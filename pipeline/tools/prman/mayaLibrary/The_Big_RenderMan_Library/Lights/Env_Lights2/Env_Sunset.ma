//Maya ASCII 2014 scene
//Name: Env_Sunset.ma
//Last modified: Tue, Oct 08, 2013 08:56:31 AM
//Codeset: UTF-8
requires maya "2014";
requires -nodeType "RenderMan" -nodeType "RenderManEnvLightShape" -nodeType "RenderManArchive"
		 -nodeType "RenderManVolume" -nodeType "RenderManLight" -nodeType "RenderManShaderObject"
		 -nodeType "RenderManDisplacement" -nodeType "RenderManShader" -nodeType "rmanWaveletNoise3d"
		 -nodeType "RMSGPSurface" -nodeType "rmanCellNoise" -nodeType "RMSEnvLight" -nodeType "RMSCausticLight"
		 -nodeType "rmanPrimVarFloat2" -nodeType "rmanPrimVarFloat3" -nodeType "RMSGeoLightBlocker"
		 -nodeType "rmanPrimVarPoint" -nodeType "RMSLightBlocker" -nodeType "rmanOcclusion"
		 -nodeType "rmanPrimVarFloat" -nodeType "rmanSideMask" -nodeType "rmanAOV" -nodeType "RMSMatte"
		 -nodeType "rmanPrimVarVector" -nodeType "rmanImageFile" -nodeType "RMSAreaLight"
		 -nodeType "RMSAreaLightManip" -nodeType "RMSGeoAreaLight" -nodeType "RMSGeoAreaLightManip"
		 -nodeType "rmanPrimVarColor" -nodeType "RMSHair" -nodeType "rmanTexture3d" -nodeType "RMSGIPtcLight"
		 -nodeType "RMSGlass" -nodeType "rmanManifold2d" -nodeType "rmanWorleyTexture" -nodeType "rmanManifold3d"
		 -nodeType "RMSHoldOut" -nodeType "rmanPrimVarNormal" -nodeType "RMSOcean" -nodeType "RMSGILight"
		 -nodeType "RMSPointLight" -nodeType "RMSShaveHair" "RenderMan_for_Maya" "5.5b3";
requires "stereoCamera" "10.0";
requires "RenderMan_for_Maya" "5.5b2";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2014";
fileInfo "version" "2014 x64";
fileInfo "cutIdentifier" "201303010035-864206";
fileInfo "osv" "Mac OS X 10.8.4";
createNode transform -n "group14";
createNode transform -n "group4" -p "group14";
createNode transform -n "Env_Sunset" -p "group4";
	setAttr ".r" -type "double3" -90 0 0 ;
	setAttr ".s" -type "double3" -230.2299964904785 230.2299964904785 230.2299964904785 ;
createNode RMSEnvLight -n "Env_Sunset_Shape" -p "Env_Sunset";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr -k off ".v";
	setAttr ".ShadingRate" 1;
	setAttr ".exposure" 0.5;
	setAttr ".temperature" 1850;
	setAttr ".nts" -type "string" "LIGHT TEMPERATURE GUIDE\n1,700 K\t. . . . . . Match Light\n1,850 K . . . . . . Candle Light & Sunset/rise\n2,700 to 3,300 K . .Incandescent Lamp\n3,000 K . . . . . . Soft Fluorescent Lamp\n3,200 K\t. . . . . . Studio Lamp & Photoflood\n3,350 K\t. . . . . . Studio CP Light\n4,100 K\t. . . . . . Moonlight\n5,000 K\t. . . . . . Horizon Daylight\n5,000 K . . . . . . Daylight Fluorescent Lamp\n5,500–6,000 K . . . Vertical Daylight & Camera Flash\n6,200 K\t. . . . . . Xenon Short-Arc Lamp\n6,500 K\t. . . . . . Overcast Daylight\n5,500–10,500 K\t. . LCD Screen\n15,000–27,000 K\t. . Clear Blue Poleward Sky";
createNode partition -n "mtorPartition";
	addAttr -ci true -sn "rgcnx" -ln "rgcnx" -at "message";
	addAttr -ci true -sn "sd" -ln "slimData" -dt "string";
	addAttr -ci true -sn "sr" -ln "slimRIB" -dt "string";
	addAttr -ci true -sn "rd" -ln "rlfData" -dt "string";
	setAttr ".sr" -type "string" "";
createNode layeredTexture -n "sunset_procedural_env_layer";
	setAttr -s 3 ".cs";
	setAttr ".cs[0].bm" 1;
	setAttr ".cs[0].iv" yes;
	setAttr ".cs[1].bm" 1;
	setAttr ".cs[1].iv" yes;
	setAttr ".cs[2].a" 1;
	setAttr ".cs[2].bm" 0;
	setAttr ".cs[2].iv" yes;
createNode ramp -n "__ramp_ground1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".in" 4;
	setAttr -s 5 ".cel";
	setAttr ".cel[1].ep" 0.5;
	setAttr ".cel[1].ec" -type "float3" 0.60799998 0.20282878 0.131328 ;
	setAttr ".cel[2].ep" 0.97000002861022949;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[3].ep" 0.2199999988079071;
	setAttr ".cel[3].ec" -type "float3" 0.082642861 0.043579768 0.0093995575 ;
	setAttr ".cel[4].ep" 0;
	setAttr ".cel[4].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[5].ep" 0.48500001430511475;
	setAttr ".cel[5].ec" -type "float3" 0.25619897 0.10606546 0.029205767 ;
	setAttr ".n" 0.05714285746216774;
	setAttr ".nf" 0.0099999997764825821;
	setAttr ".nts" -type "string" "Ramp controls color of ground";
createNode place2dTexture -n "__place2dTexture4";
createNode ramp -n "__ramp3";
	setAttr ".in" 2;
	setAttr -s 2 ".cel";
	setAttr ".cel[1].ep" 0.5;
	setAttr ".cel[1].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[2].ep" 0.48500001430511475;
	setAttr ".cel[2].ec" -type "float3" 1 1 1 ;
	setAttr ".nf" 1;
createNode place2dTexture -n "__place2dTexture5";
createNode ramp -n "__ramp_sky";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".t" 4;
	setAttr ".in" 3;
	setAttr -s 5 ".cel";
	setAttr ".cel[0].ep" 0.28499999642372131;
	setAttr ".cel[0].ec" -type "float3" 0.745 0.23393001 0.23393001 ;
	setAttr ".cel[1].ep" 0.02500000037252903;
	setAttr ".cel[1].ec" -type "float3" 8 8 8 ;
	setAttr ".cel[3].ep" 0.090000003576278687;
	setAttr ".cel[3].ec" -type "float3" 1.9 1.6195283 0.91009992 ;
	setAttr ".cel[4].ep" 0.77999997138977051;
	setAttr ".cel[4].ec" -type "float3" 0.172975 0.18827876 0.27500001 ;
	setAttr ".cel[5].ep" 0.029999999329447746;
	setAttr ".cel[5].ec" -type "float3" 2.508018 2.394974 2.1090381 ;
	setAttr ".n" 0.019999999552965164;
	setAttr ".nf" 0.05000000074505806;
	setAttr ".nts" -type "string" "ramp for the control of the sky\n";
createNode place2dTexture -n "__place2dTexture6";
	setAttr ".of" -type "float2" 0 -0.001 ;
createNode ramp -n "_ramp_clouds";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".in" 4;
	setAttr -s 3 ".cel";
	setAttr ".cel[1].ep" 0;
	setAttr ".cel[1].ec" -type "float3" 1 1 1 ;
	setAttr ".cel[2].ep" 0.98500001430511475;
	setAttr ".cel[2].ec" -type "float3" 0 0 0 ;
	setAttr ".cel[3].ep" 0.63499999046325684;
	setAttr ".nts" -type "string" "Clouds are created with a blend using this alpha";
createNode place2dTexture -n "__place2dTexture7";
createNode remapValue -n "_remapValue1";
	setAttr -s 2 ".vl[0:1]"  0 0 1 1 0.5 1;
	setAttr -s 2 ".cl";
	setAttr ".cl[0].cli" 1;
	setAttr ".cl[1].clp" 1;
	setAttr ".cl[1].clc" -type "float3" 1 1 1 ;
	setAttr ".cl[1].cli" 1;
createNode fractal -n "_fractal1";
	addAttr -ci true -sn "nts" -ln "notes" -dt "string";
	setAttr ".ra" 0.56862747669219971;
	setAttr ".th" 0.29411765933036804;
	setAttr ".fr" 3.2058823108673096;
	setAttr ".nts" -type "string" "Cloud pattern";
createNode place2dTexture -n "_place2dTexture7";
	setAttr ".mu" yes;
	setAttr ".mv" yes;
	setAttr ".re" -type "float2" 1 3 ;
createNode ramp -n "_ramp_sky_color2";
	setAttr -s 5 ".cel";
	setAttr ".cel[0].ep" 0.50499999523162842;
	setAttr ".cel[0].ec" -type "float3" 0.5950408 0.082108796 0.082108796 ;
	setAttr ".cel[1].ep" 0.58499997854232788;
	setAttr ".cel[2].ep" 0;
	setAttr ".cel[2].ec" -type "float3" 0.33780703 0.33780703 0.52700001 ;
	setAttr ".cel[3].ep" 0.68500000238418579;
	setAttr ".cel[3].ec" -type "float3" 0.65701503 0.62777197 0.43645301 ;
	setAttr ".cel[4].ep" 1;
	setAttr ".cel[4].ec" -type "float3" 0.45434299 0.44366699 0.49394301 ;
createNode place2dTexture -n "_place2dTexture22";
createNode ramp -n "_ramp_cloud_lighting";
	setAttr ".t" 1;
	setAttr ".in" 5;
	setAttr -s 5 ".cel";
	setAttr ".cel[1].ep" 0.5;
	setAttr ".cel[1].ec" -type "float3" 0.58677042 0.10562295 0.10562295 ;
	setAttr ".cel[2].ep" 0.69499999284744263;
	setAttr ".cel[2].ec" -type "float3" 0.86000001 0.74110502 0.38442004 ;
	setAttr ".cel[3].ep" 0.99500000476837158;
	setAttr ".cel[3].ec" -type "float3" 0.85000002 0.81082916 0.51425004 ;
	setAttr ".cel[4].ep" 0;
	setAttr ".cel[4].ec" -type "float3" 0.84828299 0.80505699 0.50719899 ;
	setAttr ".cel[5].ep" 0.25499999523162842;
	setAttr ".cel[5].ec" -type "float3" 0.86000001 0.74110502 0.38442004 ;
	setAttr ".n" 0.066666670143604279;
	setAttr ".nf" 0.26666668057441711;
createNode place2dTexture -n "_place2dTexture8";
select -ne :time1;
	setAttr ".o" 1;
	setAttr ".unw" 1;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultShaderList1;
	setAttr -s 2 ".s";
select -ne :defaultTextureList1;
	setAttr -s 30 ".tx";
select -ne :lightList1;
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderUtilityList1;
	setAttr -s 27 ".u";
select -ne :defaultRenderingList1;
select -ne :renderGlobalsList1;
select -ne :defaultRenderGlobals;
	setAttr ".ren" -type "string" "renderMan";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :defaultLightSet;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 18 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surfaces" "Particles" "Fluids" "Image Planes" "UI:" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 18 0 1 1 1 1 1
		 1 0 0 0 0 0 0 0 0 0 0 0 ;
select -ne :defaultHardwareRenderGlobals;
	setAttr ".fn" -type "string" "im";
	setAttr ".res" -type "string" "ntsc_4d 646 485 1.333";
connectAttr "sunset_procedural_env_layer.oc" "Env_Sunset_Shape.lightcolor";
connectAttr ":defaultRenderGlobals.msg" "mtorPartition.rgcnx";
connectAttr "__ramp_ground1.oc" "sunset_procedural_env_layer.cs[0].c";
connectAttr "__ramp3.oa" "sunset_procedural_env_layer.cs[0].a";
connectAttr "__ramp_sky.oc" "sunset_procedural_env_layer.cs[1].c";
connectAttr "_ramp_clouds.oa" "sunset_procedural_env_layer.cs[1].a";
connectAttr "_ramp_sky_color2.oc" "sunset_procedural_env_layer.cs[2].c";
connectAttr "__place2dTexture4.o" "__ramp_ground1.uv";
connectAttr "__place2dTexture4.ofs" "__ramp_ground1.fs";
connectAttr "__place2dTexture5.o" "__ramp3.uv";
connectAttr "__place2dTexture5.ofs" "__ramp3.fs";
connectAttr "__place2dTexture6.o" "__ramp_sky.uv";
connectAttr "__place2dTexture6.ofs" "__ramp_sky.fs";
connectAttr "__place2dTexture7.o" "_ramp_clouds.uv";
connectAttr "__place2dTexture7.ofs" "_ramp_clouds.fs";
connectAttr "_remapValue1.oc" "_ramp_clouds.cel[3].ec";
connectAttr "_fractal1.oa" "_remapValue1.i";
connectAttr "_place2dTexture7.o" "_fractal1.uv";
connectAttr "_place2dTexture7.ofs" "_fractal1.fs";
connectAttr "_place2dTexture22.o" "_ramp_sky_color2.uv";
connectAttr "_place2dTexture22.ofs" "_ramp_sky_color2.fs";
connectAttr "_ramp_cloud_lighting.oc" "_ramp_sky_color2.cel[1].ec";
connectAttr "_place2dTexture8.o" "_ramp_cloud_lighting.uv";
connectAttr "_place2dTexture8.ofs" "_ramp_cloud_lighting.fs";
connectAttr "sunset_procedural_env_layer.msg" ":defaultTextureList1.tx" -na;
connectAttr "__ramp_ground1.msg" ":defaultTextureList1.tx" -na;
connectAttr "__ramp3.msg" ":defaultTextureList1.tx" -na;
connectAttr "__ramp_sky.msg" ":defaultTextureList1.tx" -na;
connectAttr "_ramp_clouds.msg" ":defaultTextureList1.tx" -na;
connectAttr "_ramp_sky_color2.msg" ":defaultTextureList1.tx" -na;
connectAttr "_fractal1.msg" ":defaultTextureList1.tx" -na;
connectAttr "_ramp_cloud_lighting.msg" ":defaultTextureList1.tx" -na;
connectAttr "Env_Sunset_Shape.ltd" ":lightList1.l" -na;
connectAttr "__place2dTexture4.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "__place2dTexture5.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "__place2dTexture6.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "__place2dTexture7.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "_place2dTexture22.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "_remapValue1.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "_place2dTexture7.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "_place2dTexture8.msg" ":defaultRenderUtilityList1.u" -na;
connectAttr "Env_Sunset.iog" ":defaultLightSet.dsm" -na;
// End of Env_Sunset.ma
