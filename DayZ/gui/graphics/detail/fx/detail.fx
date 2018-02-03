//
// Example shader - detail.fx
//


//---------------------------------------------------------------------
// Detail settings
//---------------------------------------------------------------------
texture sDetailTexture;
float sDetailScale = 8;         // Repeat interval of the texture
float sFadeStart = 10;          // Near point where distance fading will start
float sFadeEnd = 80;            // Far point where distance fading will complete (i.e. effect will not be visible past this point)
float sStrength = 0.5;          // 0 to 1 for the strength of the effect
float sAnisotropy = 0.0;        // 0 to 1 for the amount anisotropy of the effect - Higher looks better but can be slower


//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
#include "mta-helper.fx"


//---------------------------------------------------------------------
// Extra renderstates which we use
//---------------------------------------------------------------------
int gCapsMaxAnisotropy                      < string deviceCaps="MaxAnisotropy"; >; 


//---------------------------------------------------------------------
// Sampler for the main texture
//---------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture = (gTexture0);
    MipFilter = Linear;
    MaxAnisotropy = gCapsMaxAnisotropy * sAnisotropy;
    MinFilter = Anisotropic;
};

//---------------------------------------------------------------------
// Sampler for the detail texture
//---------------------------------------------------------------------
sampler SamplerDetail = sampler_state
{
    Texture = (sDetailTexture);
    MipFilter = Linear;
    MaxAnisotropy = gCapsMaxAnisotropy * sAnisotropy;
    MinFilter = Anisotropic;
};


//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VertexShaderInput
{
  float3 Position : POSITION0;
  float3 Normal : NORMAL0;
  float4 Diffuse : COLOR0;
  float2 TexCoord : TEXCOORD0;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PixelShaderInput
{
  float4 Position : POSITION0;
  float4 Diffuse : COLOR0;
  float2 TexCoord : TEXCOORD0;
  float2 DistFade : TEXCOORD1;
};


//------------------------------------------------------------------------------------------
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PixelShaderInput VertexShaderFunction(VertexShaderInput VS)
{
    // Initialize result
    PixelShaderInput PS = (PixelShaderInput)0;

    // Calculate screen pos of vertex
    PS.Position = MTACalcScreenPosition( VS.Position );

    // Pass through tex coord
    PS.TexCoord = VS.TexCoord;

    // Calculate GTA lighting for buildings
    PS.Diffuse = MTACalcGTABuildingDiffuse( VS.Diffuse );

    // Distance fade calculation
    float DistanceFromCamera = MTACalcCameraDistance( gCameraPosition, MTACalcWorldPosition( VS.Position ) );
    PS.DistFade.x = 1 - ( ( DistanceFromCamera - sFadeStart ) / ( sFadeEnd - sFadeStart ) );

    // Return result
    return PS;
}

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PixelShaderInput PS) : COLOR0
{
    // Get texture pixel
    float4 texel = tex2D(Sampler0, PS.TexCoord);

    // Get detail pixel
    float4 texelDetail1 = tex2D(SamplerDetail, PS.TexCoord * sDetailScale );
    float4 texelDetail2 = tex2D(SamplerDetail, PS.TexCoord * sDetailScale * 1.9 );
    float4 texelDetail3 = tex2D(SamplerDetail, PS.TexCoord * sDetailScale * 3.6 );
    float4 texelDetail4 = tex2D(SamplerDetail, PS.TexCoord * sDetailScale * 7.4 );

    float4 texelDetail = texelDetail1 * texelDetail2 * 2 * texelDetail3 * 2 * texelDetail4 * 2;

    // Apply diffuse lighting
    float4 Color = texel * PS.Diffuse;

    // Attenuate detail depending on pixel distance and user setting
    float detailAmount = saturate( PS.DistFade.x ) * sStrength;
    float4 texelDetailToUse = lerp ( 0.5, texelDetail, detailAmount );

    // Add detail
    float4 finalColor = Color * texelDetailToUse * 2;
    finalColor.a = Color.a;

    // Return result
    return finalColor;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------

technique detail
{
    pass P0
    {
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}

technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
