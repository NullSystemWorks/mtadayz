//
// shader_dynamicSky2top.fx
// Author: Ren712/AngerMAN
//

//---------------------------------------------------------------------
//-- Settings
//---------------------------------------------------------------------

float gDayTime = 0;
float mMoonLightInt = 1;
bool gIsInWater = false;
float3 gScale = float3(1, 1, 1);
float gRescale = 1;
float2x3 gSunColor = {0,0,0,0,0,0};
float3 gRotate = float3(0,0,0);
float3 mRotate = float3(0,0,0);
float gCloudSpeed = 0.0;
float2 gStratosFade = float2(14000, 10000);
float gAlphaMult = 1;
float gBottCloudSpread = 500;
bool gHorizonBlending = true;

texture sCubeTex;
texture sMoon;

//---------------------------------------------------------------------
//-- Include some common things
//---------------------------------------------------------------------
float4x4 gWorld : WORLD;
float4x4 gView : VIEW;
float4x4 gProjection : PROJECTION;
float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;
float3 gCameraPosition : CAMERAPOSITION;
float3 gCameraDirection : CAMERADIRECTION;
matrix gProjectionMainScene : PROJECTION_MAIN_SCENE;
int gFogEnable < string renderState="FOGENABLE"; >;
float4 gFogColor < string renderState="FOGCOLOR"; >;
float gFogStart < string renderState="FOGSTART"; >;
float gTime : TIME;

//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------
samplerCUBE envMap = sampler_state
{
    Texture = (sCubeTex);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    MIPMAPLODBIAS = 0.000000;
};

sampler moonMap = sampler_state
{
    Texture = (sMoon);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU =  Clamp;
    AddressV =  Clamp;
    AddressW =  Clamp;
    BorderColor = float4(0,0,0,0);
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
 struct VSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION; 
    float3 TexCoord1 : TEXCOORD1;
    float3 TexCoord2 : TEXCOORD2;
    float3 TexCoord3 : TEXCOORD3;
    float3 NightFade : TEXCOORD4;
    float3 LimitDot : TEXCOORD5;
    float4 WorldPos : TEXCOORD6;
    float3 PositionVS : TEXCOORD7;
};

//-----------------------------------------------------------------------------
//-- eulerRotate
//-----------------------------------------------------------------------------
float3x3 eulerRotate(float3 Rotate)
{
    float cosX,sinX;
    float cosY,sinY;
    float cosZ,sinZ;
	
    sincos(Rotate.x ,sinX,cosX);
    sincos(-Rotate.y ,sinY,cosY);
    sincos(Rotate.z ,sinZ,cosZ);

    return float3x3(
		cosY * cosZ + sinX * sinY * sinZ, -cosX * sinZ,  sinX * cosY * sinZ - sinY * cosZ,
		cosY * sinZ - sinX * sinY * cosZ,  cosX * cosZ, -sinY * sinZ - sinX * cosY * cosZ,
		cosX * sinY,                       sinX,         cosX * cosY
	);
}

//------------------------------------------------------------------------------------------
// MTAUnlerp
//------------------------------------------------------------------------------------------
float MTAUnlerp( float from, float to, float pos )
{
    if ( from == to )
        return 1.0;
    else
        return ( pos - from ) / ( to - from );
}

//-----------------------------------------------------------------------------
//-- VertexShader
//-----------------------------------------------------------------------------
PSInput VertexShaderSB(VSInput VS)
{
    PSInput PS = (PSInput)0;	
    PS.PositionVS = VS.Position.xyz;
    float farClip = gProjectionMainScene[3][2] / (1 - gProjectionMainScene[2][2]);
    if ((gFogEnable) && (gIsInWater)) farClip = min(gFogStart, farClip);
    VS.Position.xyz *= gScale * max(230, farClip) * 0.31 * gRescale;
    float4x4 sWorld = gWorld; sWorld[3].xyz = float3(0,0,0);
    float4 mulWorld = mul(VS.Position, sWorld);
    float4x4 sView = gView; sView[3].xyz = float3(0,0,0);
    float4 mulView = mul( mulWorld, sView);
    PS.Position = mul(mulView, gProjection);
    PS.TexCoord1 = normalize(mul(eulerRotate(gRotate), VS.Position.xyz));
    PS.TexCoord2 = normalize(mul(eulerRotate(mRotate), VS.Position.xyz)) * 5;
    PS.WorldPos = mul(VS.Position, sWorld);
    float3 eyeVector = normalize(PS.WorldPos.xyz - 0); 	 
    PS.TexCoord3 = mul(eulerRotate(gRotate), eyeVector.xyz);
    PS.NightFade.x = saturate(MTAUnlerp(gStratosFade[0], gStratosFade[1], gCameraPosition.z));
    PS.NightFade.y = saturate(dot( float3(0,0,-1), PS.TexCoord2));
    PS.NightFade.z = saturate(MTAUnlerp(farClip + abs(gBottCloudSpread) + 300, farClip + 300, gCameraPosition.z));

    float fadeDot = dot(float3(0,0,1), PS.PositionVS.xyz);	
    if (gHorizonBlending) PS.LimitDot.x = saturate(pow(max(0.0001, fadeDot), 0.4) * 1.0 );
        else PS.LimitDot.x = 1.0;
    float topDot = dot(float3(0,0,1), PS.PositionVS.xyz);	
    PS.LimitDot.y = 1 - saturate(pow(max(0.0001, topDot), 6.4) * 0.001);
    PS.LimitDot.z = dot(float3(0,0,-1), normalize(PS.TexCoord2));	
    return PS;
}

//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderStratos(PSInput PS) : COLOR0
{
    float3 TexCoord2 = normalize(PS.TexCoord2);	

    TexCoord2 = PS.TexCoord2 + float3(0.5,0.25,0);	
    float4 moon = tex2D(moonMap, TexCoord2.xyz);
    float moonAp = moon.a;
    moon.a = pow(moon.a, 2);
    moon *= saturate(1 - PS.NightFade.x);
    moon *= PS.NightFade.y;
    moon.rgb *= 0.9;
    moon.a *= max(saturate(1 - pow(gDayTime, 35)),saturate(1 - PS.NightFade.x)) * 0.9;
    
    float fadeDot = PS.LimitDot.x;
	
    float4 nightSky = float4(0,0,0,0);
    if ((1 - PS.NightFade.x)>0) 
    {
        nightSky = texCUBE(envMap, PS.TexCoord3.xzy);
        nightSky.rgb = lerp(nightSky.rgb, 0, moonAp);
        nightSky.rgb = 0.9 * nightSky.rgb;
        nightSky = saturate( nightSky );
        nightSky.rgba *= saturate(1 - PS.NightFade.x);
    }
    moon.a *= max(saturate(1 - PS.NightFade.x), lerp(moon.a/20, 1, saturate(1 - pow(gDayTime, 35))));
    nightSky.rgb = lerp(nightSky.rgb, moon.rgb, moon.a);
    nightSky.a *= pow(fadeDot, 1.05);
    nightSky.a *= gAlphaMult;
    return nightSky;
}

float4 PixelShaderDots(PSInput PS) : COLOR0
{
    float4 nightSky = texCUBE(envMap, PS.TexCoord3.xzy);
    nightSky.rgb = 0.9 * nightSky.rgb * PS.NightFade.x;
    nightSky = saturate( nightSky );
	
    float3 TexCoord2 = normalize(PS.TexCoord2);
    float MoonDot = PS.LimitDot.z;
    float MoonCombine = saturate(0.2 * MoonDot);	

    TexCoord2 = PS.TexCoord2 + float3(0.5,0.25,0);	
    float4 moon = tex2D(moonMap, TexCoord2.xyz);
    nightSky.rgb *= saturate(1 - moon.a) * PS.NightFade.x;
    moon.a = pow(moon.a, 2);
    float moonAp = saturate((moon.r + moon.g + moon.b)/3) * moon.a;
    moon *= PS.NightFade.y;
    moon.a *= max(saturate(1 - pow(gDayTime, 35)),saturate(1 - PS.NightFade.x)) * 0.9;
    moon.rgba *= 0.9;	
    moon.rgb = saturate(moon.rgb + MoonCombine);
    moon.rgb += MoonDot * 0.1 * PS.NightFade.x;
    moon = saturate(moon);
    moon.a *= max(saturate(1 - PS.NightFade.x), lerp(moon.a/20, 1, saturate(1 - pow(gDayTime, 35))));
    nightSky.rgb = lerp(nightSky.rgb, moon.rgb, moonAp);
	
    float3 TexCoord1 = normalize(PS.TexCoord1);
    float SunDot = dot(float3(0,0,-1), TexCoord1);	
    float SunLight = pow(max(0.0001, SunDot), 60);
    float SunAura = pow(max(0.0001, SunDot), 100);
    float3 sunCombine = saturate(0.7 * SunLight * gSunColor[0] + 0.4 * SunAura * gSunColor[1]);

    nightSky.rgb = saturate(nightSky.rgb);
	
    float3 allCombine = lerp(sunCombine,nightSky.rgb,1 - pow(gDayTime,1.2));
    float4 outPut = float4(allCombine, 1);
    outPut = saturate(outPut);
	
    float fadeDot = PS.LimitDot.x;
    fadeDot = pow(fadeDot, 1.05);
    outPut.a *= fadeDot;
    outPut.a *= gAlphaMult;
    return outPut;
}

//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------
technique DynamicSky2stratos
{
    pass P0
    {
        SrcBlend = SrcAlpha;
        DestBlend = InvSrcAlpha; 
        AlphaRef = 1;
        AlphaBlendEnable = true;
        FogEnable = false;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderStratos();
    }
    pass P1
    {
        SrcBlend = SrcAlpha; 
        DestBlend = One;
        AlphaRef = 1;
        AlphaBlendEnable = true;
        FogEnable = false;
        DepthBias = -0.000005;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderDots();
    }
}

