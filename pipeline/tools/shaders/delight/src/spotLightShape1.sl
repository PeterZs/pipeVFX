light spotLightShape1(
	string shadowmapname = "";
	float shadowBlur = 0;
	float shadowSamples = 16;
	float __nonspecular = 0;
	float __nondiffuse = 0;
	string __category = "";
	float iskeylight = 0;
	string rayTraceShadowSubset = "";

	output varying float __3dfm_shadowing = 0;
	output varying color __3dfm_unshadowed_cl = 0;
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

	// Include statements
	//
	#include <spotLight.h>

	// Output variable declarations
	//

	// Compute call string for spotLightShape1
	//
	{
		prepare_maya_spotLight(
			color(1, 1, 1), // color
			1, // intensity
			0, // decayRate
			40, // coneAngle
			0, // penumbraAngle
			0, // dropoff
			0, // barnDoors
			20, // leftBarnDoor
			20, // rightBarnDoor
			20, // topBarnDoor
			20, // bottomBarnDoor
			color(0, 0, 0), // shadowColor
			1, // dmapFilterSize
			0.001000000047, // dmapBias
			0, // useRayTraceShadows
			0, // lightRadius
			1 // shadowRays
			);

		// Compute call string for spotLightShape1
		//
		end_maya_spotLight(
			color(1, 1, 1), // color
			1, // intensity
			0, // decayRate
			40, // coneAngle
			0, // penumbraAngle
			0, // dropoff
			0, // barnDoors
			20, // leftBarnDoor
			20, // rightBarnDoor
			20, // topBarnDoor
			20, // bottomBarnDoor
			color(0, 0, 0), // shadowColor
			1, // dmapFilterSize
			0.001000000047, // dmapBias
			0, // useRayTraceShadows
			0, // lightRadius
			1 // shadowRays
			);

	}

	// Assign final output variables to state variables.
	//
}
// Shader code generated by DL_translateMayaToSl.
// Total time: 0.02s.
// Time per node: 0.01s.
