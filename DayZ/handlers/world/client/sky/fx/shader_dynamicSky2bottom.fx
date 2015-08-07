//
// shader_dynamicSky2bottom.fx
// Author: Ren712/AngerMAN
//

//---------------------------------------------------------------------
//-- Settings
//---------------------------------------------------------------------

float gDayTime = 0;
bool gIsInWater = false;
float3 gScale = float3(1, 1, 1);
float gRescale = 1;
float gCloudSpeed = 0.0;
float2 gStratosFade = float2(14000, 10000);
float gAlphaMult = 1;
float gBottCloudSpread = 500;
bool gHorizonBlending = true;
texture sClouds;

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

sampler cloudMap = sampler_state
{
    Texture = (sClouds);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Wrap;
    AddressV = Wrap;
    AddressW = Wrap;
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
    float3 TexCoord0 : TEXCOORD0;
    float2 NightFade : TEXCOORD1;
    float3 PositionVS : TEXCOORD2;
    float2 LimitDot : TEXCOORD3;
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
    float2 move = float2(gCameraPosition.x * 0.00001, gCameraPosition.z * 0.0005);
    PS.TexCoord0 = VS.TexCoord - float3(move.x, move.y, 0); 
    PS.NightFade.x = saturate(MTAUnlerp(gStratosFade[1], gStratosFade[1] - 2000, gCameraPosition.z));
    if (gHorizonBlending) PS.NightFade.y = saturate(MTAUnlerp(farClip + abs(gBottCloudSpread) + 500, farClip + 500, gCameraPosition.z));
        else PS.NightFade.y = 0.5 * PS.NightFade.y;
    float fadeDot = dot(float3(0,0,-1), PS.PositionVS.xyz);	
    if (gHorizonBlending) PS.LimitDot.x = saturate(pow(max(0.0001, fadeDot), 0.4) * 1.0 );
        else PS.LimitDot.x = 1.0;
    float botDot = dot(float3(0,0,-1), PS.PositionVS.xyz);	
    PS.LimitDot.y = 1 - saturate(pow(max(0.0001, botDot), 6.4) * 0.001);
    return PS;
}

//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderClouds(PSInput PS) : COLOR0
{
    PS.TexCoord0.x += fmod(( gCloudSpeed * gTime)/8 ,1 );
    float4 clouds = tex2D(cloudMap, PS.TexCoord0.xy * 2.0 );

    float4 outPut = clouds;
    outPut.rgb *= saturate(0.5 + pow(gDayTime, 1.2));
    outPut.rgb *= saturate(0.5 + gFogColor.rgb/2);
    outPut.a *= 1.5;
    outPut.a = saturate(outPut.a);
    outPut *= PS.LimitDot.y; 
	
    float fadeDot = pow(PS.LimitDot.x,1.05);

    fadeDot = lerp(1, fadeDot, PS.NightFade.y);
	
    outPut.a *= gAlphaMult;
    outPut *= fadeDot;
    outPut.a *= fadeDot * saturate(1 - pow(PS.NightFade.y,4));
    outPut = saturate(outPut);	
    return saturate(outPut * pow(PS.NightFade.x,5));
}

//-----------------------------------------------------------------------------
//-- Techniques
//-----------------------------------------------------------------------------
technique DynamicSky2bottom
{
	
    pass P0
    {
        SrcBlend = SrcAlpha;
        DestBlend = InvSrcAlpha;
        AlphaRef = 1;
        FogEnable = false;
        AlphaBlendEnable = true;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderClouds();
    }	
}

