shader_type spatial;
render_mode cull_front, unshaded, ambient_light_disabled;

uniform float outline_thickness_mm : hint_range(0.0, 3.0) = 1.0;
uniform vec4 outline_color : hint_color = vec4(0.0, 0.0, 0.0, 1.0);

void vertex()
{
	VERTEX = (NORMAL * outline_thickness_mm / 1000.0) + VERTEX;
}

void fragment()
{
	ALBEDO = outline_color.rgb;
}