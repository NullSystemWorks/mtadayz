//
// bloom_extract.fx
//


//---------------------------------------------------------------------
// Settings
//---------------------------------------------------------------------
float sBloomThreshold = 0.5;
texture sBaseTexture;
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
    float lumTexel = tex2D(LumSampler, PS.TexCoord).x;

    // Adjust threshold depending on scene luminance
    float BloomThreshold = sBloomThreshold + lumTexel * lumTexel;

    // Look up the original image color.
    float4 base = tex2D(BaseSampler, PS.TexCoord);

    BloomThreshold = saturate(BloomThreshold);

    // Adjust it to keep only values brighter than the specified threshold.
    return saturate((base - BloomThreshold) / (1.01 - BloomThreshold));
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
