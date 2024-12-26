shader_type spatial;
render_mode unshaded;
render_mode depth_test_disabled;


uniform sampler2D texture_albedo;

void vertex() {
	VERTEX.y -= cos(VERTEX.x*0.5);
}

void fragment() {
	
	vec4 albedo = texture(texture_albedo, UV);
	ALBEDO = albedo.rgb;
	ALPHA = albedo.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
