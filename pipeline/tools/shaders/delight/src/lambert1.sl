surface lambert1(
	uniform float shaderid = 0;
#ifdef USE_AOV_aov_ambient
	output varying color aov_ambient = 0;
#endif
#ifdef USE_AOV_aov_diffuse
	output varying color aov_diffuse = 0;
#endif
#ifdef USE_AOV_aov_refraction
	output varying color aov_refraction = 0;
#endif
#ifdef USE_AOV_aov_reflection
	output varying color aov_reflection = 0;
#endif
#ifdef USE_AOV_aov_rt_reflection
	output varying color aov_rt_reflection = 0;
#endif
#ifdef USE_AOV_aov_rt_reflection_alpha
	output varying float aov_rt_reflection_alpha = 0;
#endif
#ifdef USE_AOV_aov_env_reflection
	output varying color aov_env_reflection = 0;
#endif
#ifdef USE_AOV_aov_shadow
	output varying float aov_shadow = 0;
#endif
#ifdef USE_AOV_aov_incandescence
	output varying color aov_incandescence = 0;
#endif
#ifdef USE_AOV_aov_translucence
	output varying color aov_translucence = 0;
#endif
#ifdef USE_AOV_aov_ambient_no_shadow
	output varying color aov_ambient_no_shadow = 0;
#endif
#ifdef USE_AOV_aov_diffuse_no_shadow
	output varying color aov_diffuse_no_shadow = 0;
#endif
#ifdef USE_AOV_aov_diffuse_intensity
	output varying color aov_diffuse_intensity = 0;
#endif
#ifdef USE_AOV_aov_diffuse_intensity_no_shadow
	output varying color aov_diffuse_intensity_no_shadow = 0;
#endif
#ifdef USE_AOV_aov_key_lights_diffuse_intensity
 output varying color aov_key_lights_diffuse_intensity = 0;
#endif
#ifdef USE_AOV_aov_key_lights_diffuse_intensity_no_shadow
	output varying color aov_key_lights_diffuse_intensity_no_shadow = 0;
#endif
#ifdef USE_AOV_aov_luminance_depth
	output varying color aov_luminance_depth = 0;
#endif
#ifdef USE_AOV_aov_color_no_shadow
	output varying color aov_color_no_shadow = 0;
#endif
#ifdef USE_AOV_aov_surface_color
	output varying color aov_surface_color = 0;
#endif
#ifdef USE_AOV_aov_camera_space_normal
	output varying normal aov_camera_space_normal = 0;
#endif
#ifdef USE_AOV_aov_facing_ratio
	output varying float aov_facing_ratio = 0;
#endif
#ifdef USE_AOV_aov_occlusion
	output varying color aov_occlusion = 0;
#endif
#ifdef USE_AOV_aov_env_diffuse
	output varying color aov_env_diffuse = 0;
#endif
#ifdef USE_AOV_aov_indirect
	output varying color aov_indirect = 0;
#endif
#ifdef USE_AOV_aov_gi
	output varying color aov_gi = 0;
#endif
)
{
	// Common variables declarations
	//
	float ss = s;
	float tt = 1 - t;

	// Dummy variable declarations
	//
	float floatDummy = 0.0;
	float float2Dummy[2] = {0.0, 0.0};
	color colorDummy = color(0,0,0);
	matrix matrixDummy = 1;
	normal normalDummy = normal(0,0,0);
	point pointDummy = point(0,0,0);
	vector vectorDummy = vector(0,0,0);
	string stringDummy;

	// Variable to keep track of transparency for AOVs if multiple shaders are used
	color __transparency = 1;

	// Get current ray type.
	//
	uniform string __raytype = "";
	if(rayinfo( "type", __raytype ) == 0)
	{
		__raytype = "";
	}

	uniform float __shadowmaprendering = 0;
	if(attribute("user:ShadowMapRendering", __shadowmaprendering) == 0)
	{
		__shadowmaprendering = 0;
	}

	uniform float __is_shadow_ray = (__raytype == "transmission" || __shadowmaprendering == 1) ? 1:0;

	uniform float __is_bakepass = 0;
	if(option("user:maya_bakepass", __is_bakepass) == 0)
	{
		__is_bakepass = 0;
	}

	uniform float __is_irradiance_ray =
		(__raytype == "diffuse" || __is_bakepass != 0) ? 1:0;

	// Get object attributes related to ray-tracing.
	//
	uniform float __reflects = (__is_shadow_ray==0 && __is_irradiance_ray==0) ? 1:0;
	uniform float __refracts = (__is_shadow_ray!=0 || __is_irradiance_ray==0) ? 1:0;

	// Include statements
	//
	#include <lambert.h>

	// Output variable declarations
	//
	color lambert1_outColor_local = color(0,0,0);
	color lambert1_outTransparency_local = color(0,0,0);

	// Compute call string for lambert1
	//
	maya_lambert(
		color(0, 0, 0), // ambientColor
		color(0.5, 0.5, 0.5), // color
		0.8000000119, // diffuse
		color(0, 0, 0), // incandescence
		2, // matteOpacityMode
		1, // matteOpacity
		0, // refractions
		1, // refractiveIndex
		6, // refractionLimit
		0, // lightAbsorbance
		0.5, // shadowAttenuation
		N, // normalCamera
		color(0, 0, 0), // transparency
		0, // translucence
		0.5, // translucenceDepth
		0.5, // translucenceFocus
		lambert1_outColor_local,
		lambert1_outTransparency_local
		);

	// Assign final output variables to state variables.
	//
	Oi = Os * (1.0 - lambert1_outTransparency_local);
	Ci = lambert1_outColor_local * Os;

	illuminance( "bakelight", P, "send:light:do_bake", 1 )
	{
	}
}
// Shader code generated by DL_translateMayaToSl.
// Total time: 0.02s.
// Time per node: 0.02s.
