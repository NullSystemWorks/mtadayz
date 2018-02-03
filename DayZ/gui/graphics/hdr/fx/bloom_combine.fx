//
// bloom_combine.fx
//


//---------------------------------------------------------------------
// Settings
//---------------------------------------------------------------------
float sBloomIntensity = 0.5;
float sBloomSaturation = 0.5;
float sBaseIntensity = 0.5;
float sBaseSaturation = 0.5;
texture sBaseTexture;
texture sBloomTexture;

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
// Sampler for the other texture
//---------------------------------------------------------------------
sampler BloomSampler = sampler_state
{
    Texture = (sBloomTexture);
};


//---------------------------------------------------------------------
// Helper for modifying the saturation of a color.
//---------------------------------------------------------------------
float4 AdjustSaturation(float4 color, float saturation)
{
    // The constants 0.3, 0.59, and 0.11 are chosen because the
    // human eye is more sensitive to green light, and less to blue.
    float grey = dot(color, float3(0.3, 0.59, 0.11));

    return lerp(grey, color, saturation);
}


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
    // Look up the bloom and original base image colors.
    float4 bloom = tex2D(BloomSampler, PS.TexCoord);
    float4 base = tex2D(BaseSampler, PS.TexCoord);
    
    // Adjust color saturation and intensity.
    bloom = AdjustSaturation(bloom, sBloomSaturation) * sBloomIntensity;
    base = AdjustSaturation(base, sBaseSaturation) * sBaseIntensity;
    
    // Darken down the base image in areas where there is a lot of bloom,
    // to prevent things looking excessively burned-out.
    base *= (1 - saturate(bloom));
    
    // Combine the two images.
    return base + bloom;
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
