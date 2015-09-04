// shader_light.fx
// Author: Ren712/AngerMAN

//-- Declare the texture
texture sCubeTexture;

float3 rotate=(0,0,0);
float4 DistFade=(110, 80, 49, 1); // min and max distance the effect fades / all vs flashlight
float4 lightColor=float4(0,0,0,0);   // default should be float4(1,1,0.8,0.8);
float2 rc = float2(0.0008,0.0010);
float3 alterPosition=(0,0,0);
bool isLightDir = true;
float lightDirAcc = 0.3;
bool isFakeBump = false;
//-- Include some common stuff
#define GENERATE_NORMALS     
#include "mta-helper.fx"

   
   
//---------------------------------------------------------------------
//-- Sampler for the main texture (needed for pixel shaders)
//---------------------------------------------------------------------

samplerCUBE cubeSampler = sampler_state
{
    Texture = (sCubeTexture);
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    MIPMAPLODBIAS = 0.000000;
};

sampler Sampler0 = sampler_state
{
    Texture = (gTexture0);
};

//---------------------------------------------------------------------
//-- Structure of data sent to the vertex shader
//--------------------------------------------------------------------- 
 
 struct VSInput
{
    float4 Position : POSITION; 
    float3 TexCoord : TEXCOORD0;
	float4 Normal : NORMAL0;
};

//---------------------------------------------------------------------
//-- Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------

struct PSInput
{
    float4 Position : POSITION;
	float2 TexCoord : TEXCOORD0;	
    float3 SpTexCoord : TEXCOORD1;
	float DistFade : TEXCOORD2;
	float LightFade : TEXCOORD4;
	float LightDirection : TEXCOORD3; 
};

//-----------------------------------------------------------------------------
//-- VertexShader
//-----------------------------------------------------------------------------
PSInput VertexShaderSB(VSInput VS)
{
    PSInput PS = (PSInput)0;
	
	// Make sure normal is valid
    MTAFixUpNormal( VS.Normal.xyz);
	
	// The usual stuff
    PS.Position = mul(VS.Position, gWorldViewProjection);
	float4 worldPos = mul(VS.Position, gWorld); 
	
	// Let's change the coordinates (position in tha world)
	 worldPos.xyz+=alterPosition;
	 
	//calculate light vector
	float3 WorldNormal = MTACalcWorldNormal(VS.Normal.xyz);
	float3 h = (gCameraPosition - worldPos.xyz);
	PS.LightDirection = saturate(dot(WorldNormal,h));	

    // compute the eye vector 
    float4 eyeVector = worldPos - gViewInverse[3]; 

	float cosX,sinX;
	float cosY,sinY;
	float cosZ,sinZ;

	sincos(rotate.x ,sinX,cosX);
	sincos(rotate.y ,sinY,cosY);
	sincos(-rotate.z ,sinZ,cosZ);

//Euler intrinsic rotations
//http://www.vectoralgebra.info/eulermatrix.html

	float3x3 rot = float3x3(
		cosY*cosX, 					-cosY*sinX, 					sinY,
		sinZ*sinY*cosX+cosZ*sinX, 	-sinZ*sinY*sinX+cosZ*cosX, 	-sinZ*cosY,
		-cosZ*sinY*cosX+sinZ*sinX, 	cosZ*sinY*sinX+sinZ*cosX, 	cosZ*cosY
	);	

   PS.SpTexCoord.xzy = mul(rot, eyeVector);
   PS.TexCoord = VS.TexCoord;
   
   // limit the effect only to certain area
   float DistanceFromLight = MTACalcCameraDistance( gCameraPosition, worldPos);
   float DistanceFromCamera = MTACalcCameraDistance( gCameraPosition, MTACalcWorldPosition(VS.Position));
   PS.DistFade = MTAUnlerp ( DistFade[0], DistFade[1], DistanceFromCamera );
   PS.LightFade = MTAUnlerp ( DistFade[2], DistFade[3], DistanceFromLight );
   
    return PS;
}
 
//-----------------------------------------------------------------------------
//-- PixelShader
//-----------------------------------------------------------------------------
float4 PixelShaderSB(PSInput PS) : COLOR0
{
	float4 texel = tex2D(Sampler0, PS.TexCoord);
	if (isFakeBump==true) {
	texel -= tex2D(Sampler0, PS.TexCoord.xy - rc.xy)*2;
	texel += tex2D(Sampler0, PS.TexCoord.xy + rc.xy)*2;					
	texel.a*= saturate((texel.r+texel.g+texel.b)/3);
						  }
						else
						  {
						  texel.a/=2;
						  }
    float4 texLight = texCUBE(cubeSampler, PS.SpTexCoord);
	float4 outPut = ((texLight*texel.a)+(texel*texLight.a));
	if (isLightDir==true) {outPut*= saturate(pow(PS.LightDirection,lightDirAcc));}
	outPut*=lightColor;
	outPut*= saturate(PS.LightFade)*saturate(PS.DistFade);
    return outPut;
	
}


////////////////////////////////////////////////////////////
//////////////////////////////// TECHNIQUES ////////////////
////////////////////////////////////////////////////////////
technique flashLight_v01
{
    pass P0
    {
		DepthBias = -0.0003;
		AlphaRef = 1;
	    AlphaBlendEnable = TRUE;
		SrcBlend = SRCALPHA;
		DestBlend = INVSRCALPHA;
        VertexShader = compile vs_2_0 VertexShaderSB();
        PixelShader = compile ps_2_0 PixelShaderSB();
    }
}
