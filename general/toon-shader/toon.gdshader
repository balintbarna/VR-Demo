// Based on Cel shader v2.0 by David Lipps aka DaveTheDev @ EXPWorlds

shader_type spatial;
//render_mode unshaded;
//render_mode ambient_light_disabled;

uniform bool shaded = true;
uniform bool shadows = true;
uniform bool lighting_color = true;
uniform bool specular_reflection = true;
uniform bool rim_light = true;

uniform vec4 albedo_color : hint_color = vec4(1.0);
uniform vec4 specular_tint : hint_color = vec4(0.75);
uniform vec4 rim_tint : hint_color = vec4(0.75);

const float shade_threshold = 0.0;
uniform float shade_softness : hint_range(0.0, 1.0, 0.001) = 0.01;

const float shadow_threshold = 0.3;
uniform float shadow_softness : hint_range(0.0, 1.0, 0.001) = 0.1;
uniform float shadowed_energy : hint_range(0.0, 1.0) = 0.0;

uniform float specular_glossiness : hint_range(1.0, 100.0, 0.1) = 15.0;
uniform float specular_threshold : hint_range(0.01, 1.0, 0.001) = 0.5;
uniform float specular_softness : hint_range(0.0, 1.0, 0.001) = 0.1;

uniform float rim_threshold : hint_range(0.00, 1.0, 0.001) = 0.25;
uniform float rim_softness : hint_range(0.0, 1.0, 0.001) = 0.05;
uniform float rim_spread : hint_range(0.0, 1.0, 0.001) = 0.5;

uniform float light_contribution : hint_range(0.0, 1.0) = 1.0;

uniform sampler2D albedo_texture: hint_albedo;

void fragment()
{
	vec4 albedo = texture(albedo_texture, UV) * albedo_color;
	ALBEDO = albedo.rgb;
	//ALPHA = albedo.a;
}

float lit_shadow(float attenuation)
{
	// decrease litness based on engine calculated light attenuation and shadow cast
	return smoothstep(shadow_threshold - shadow_softness, shadow_threshold + shadow_softness, attenuation); // [0;1]
}

vec3 coloration(vec3 lighting)
{
	lighting /= abs(max(max(lighting.r, lighting.g), lighting.b));
	return mix(vec3(1.0), lighting, light_contribution);
}

vec4 specular(vec3 view, vec3 light, vec3 normal, float lit_amount)
{
	// compare the summed direction of view and light to the surface normal
	vec3 light_and_view_direction = normalize(view + light);
	// the ratio the centredness of the light's reflection
	float light_reflection_centredness = dot(normal, light_and_view_direction); // [0;1]
	
	float specular_value = pow(light_reflection_centredness * lit_amount, specular_glossiness * specular_glossiness); // [0;1]
	specular_value = smoothstep(specular_threshold - specular_softness, specular_threshold + specular_softness, specular_value); // if value within treshold ->[0;1]
	return specular_tint * specular_value;
}

vec4 rim(vec3 view, vec3 normal, float light_facing_ratio, float lit_amount)
{
	float inverted_camera_facing_ratio = 1.0 - dot(view, normal); // rim should be visible on sides (not towrads view) [0;1]
	float inverted_rim_threshold = 1.0 - rim_threshold;
	float inverted_rim_spread = 1.0 - rim_spread;
	
	float rim_value = inverted_camera_facing_ratio * pow(light_facing_ratio, inverted_rim_spread); // has to be light facing
	rim_value = smoothstep(inverted_rim_threshold - rim_softness, inverted_rim_threshold + rim_softness, rim_value);
	return rim_tint * rim_value * lit_amount; // only well lit parts
}

void light()
{
	DIFFUSE_LIGHT = ALBEDO;
	DIFFUSE_LIGHT *= step(0.001, ATTENUATION); // necessary with many lights in the scene because they add up wierdly
	if (shaded)
	{
		float light_facing_ratio = dot(NORMAL, LIGHT); // angle -> [-1;1]
		vec3 lighting = LIGHT_COLOR * max(ATTENUATION, 0.0); // HDR, real lighting
		// calculate lack_of_light ratio based on how much the surface faces the light
		float toon_lit_amount = smoothstep(shade_threshold - shade_softness, shade_threshold + shade_softness, light_facing_ratio); // fx ratio in [-0.01;0.01]->[0;1]
		if (shadows)
		{
			toon_lit_amount *= lit_shadow(length(lighting)); // *[0;1]
		}
		DIFFUSE_LIGHT *= mix(shadowed_energy, 1.0, toon_lit_amount); // interpolate
		if (lighting_color)
		{
			DIFFUSE_LIGHT *= coloration(LIGHT_COLOR);
		}
		if (specular_reflection)
		{
			vec4 s = specular(VIEW, LIGHT, NORMAL, toon_lit_amount);
			SPECULAR_LIGHT += s.rgb;
			//ALPHA += s.a;
		}
		if (rim_light)
		{
			vec4 r = rim(VIEW, NORMAL, light_facing_ratio, toon_lit_amount);
			DIFFUSE_LIGHT += r.rgb;
			//ALPHA += r.a;
		}
	}
}