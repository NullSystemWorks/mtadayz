//
// modulation.fx
//


//---------------------------------------------------------------------
// Settings
//---------------------------------------------------------------------
float sMultAmount = 0.5;
float sMult = 0.5;
float sAdd = 0.5;
texture sBaseTexture;

float sExtraFrom = 0.08;
float sExtraTo = 0.59;
float sExtraMult = 1;
texture sLumTexture;

//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
#include "mta-helper.fx"


//---------------------------------------------------------------------
// Sampler for the main texture
//---------------------------------------------------------------------
sampler BaseSampler = sampler_state
{
    Texture = (sBaseTexture);
};


//---------------------------------------------------------------------
// Sampler for the scene luminance texture
//---------------------------------------------------------------------
sampler LumSampler = sampler_state
{
    Texture = (sLumTexture);
};


//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
  float4 Position : POSITION0;
  float4 Diffuse : COLOR0;
  float2 TexCoord : TEXCOORD0;
};


//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{

    // Use scene luminance texture to calculate how much to multiply by
    float lumTexel = tex2D(LumSampler, PS.TexCoord).x;

    // Get scene luminance as a value from 0 to 1
    float lumNormalized = saturate( MTAUnlerp( sExtraTo, sExtraFrom, lumTexel ) );

    // Adjust multiplty depending on normalized luminance value
    float Mult = lerp( sMult, sExtraMult, lumNormalized );

    ////////////////////////////////////

    // Process original pixel
    float4 base = tex2D(BaseSampler, PS.TexCoord);

    float4 grey = float4(0.5, 0.5, 0.5, 0.5);
    float4 result = base * lerp(grey,base,sMultAmount) * Mult + sAdd;

    result.a = 1;
    return result;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique tec0
{
    pass P0
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
