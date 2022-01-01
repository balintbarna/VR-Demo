// Based on Cel shader v2.0 by David Lipps aka DaveTheDev @ EXPWorlds

shader_type spatial;
//render_mode unshaded;
//render_mode ambient_light_disabled;

uniform bool use_shade = true;
uniform bool use_specular = true;
uniform bool use_rim = true;
uniform bool use_light = true;
uniform bool use_shadow = true;

uniform vec4 albedo_color : hint_color = vec4(1.0);
uniform vec4 specular_tint : hint_color = vec4(0.75);
uniform vec4 rim_tint : hint_color = vec4(0.75);

uniform float shaded_energy : hint_range(0.0, 1.0) = 0.2;
uniform float shade_threshold : hint_range(-1.0, 1.0, 0.001) = 0.0;
uniform float shade_softness : hint_range(0.0, 1.0, 0.001) = 0.01;

uniform float specular_glossiness : hint_range(1.0, 100.0, 0.1) = 15.0;
uniform float specular_threshold : hint_range(0.01, 1.0, 0.001) = 0.5;
uniform float specular_softness : hint_range(0.0, 1.0, 0.001) = 0.1;

uniform float rim_threshold : hint_range(0.00, 1.0, 0.001) = 0.25;
uniform float rim_softness : hint_range(0.0, 1.0, 0.001) = 0.05;
uniform float rim_spread : hint_range(0.0, 1.0, 0.001) = 0.5;

uniform float shadow_threshold : hint_range(0.00, 1.0, 0.001) = 0.7;
uniform float shadow_softness : hint_range(0.0, 1.0, 0.001) = 0.1;

uniform float light_contribution : hint_range(0.0, 1.0) = 1.0;

uniform sampler2D albedo_texture: hint_albedo;

void fragment()
{
	vec4 albedo = texture(albedo_texture, UV) * albedo_color;
	ALBEDO = albedo.rgb;
//	ALPHA = albedo.a;
}

float get_shade_lit_ratio(float light_facing_ratio, inout float lit_amount, float attenuation)
{
	// calculate lack_of_light ratio based on how much the surface faces the light
	lit_amount = smoothstep(shade_threshold - shade_softness, shade_threshold + shade_softness, light_facing_ratio); // fx ratio in [-0.01;0.01]->[0;1] 
	if (use_shadow)
	{
		// decrease litness based on engine calculated light attenuation
		lit_amount *= smoothstep(shadow_threshold - shadow_softness, shadow_threshold + shadow_softness, attenuation); // [0;1]
	}
	return mix(shaded_energy, 1.0, lit_amount); // interpolate
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
	float light_facing_ratio = dot(NORMAL, LIGHT); // angle -> [-1;1]
	float lit_amount = step(shade_threshold, light_facing_ratio); // [-1;1] -> 0 or 1
	DIFFUSE_LIGHT = ALBEDO;
	
	if (use_shade)
	{
		DIFFUSE_LIGHT *= get_shade_lit_ratio(light_facing_ratio, lit_amount, ATTENUATION.r); // *[0;1]
	}
	
	if (use_specular)
	{
		vec4 s = specular(VIEW, LIGHT, NORMAL, lit_amount);
		DIFFUSE_LIGHT += s.rgb;
//		ALPHA += s.a;
	}
	
	if (use_rim)
	{
		vec4 r = rim(VIEW, NORMAL, light_facing_ratio, lit_amount);
		DIFFUSE_LIGHT += r.rgb;
//		ALPHA += r.a;
	}
	
	if (use_light)
	{
		DIFFUSE_LIGHT *= 1.0 - light_contribution + light_contribution*LIGHT_COLOR;
	}
}