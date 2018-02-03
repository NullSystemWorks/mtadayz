//
// Example shader - blurH.fx
//
// Horizontal blur
//

//---------------------------------------------------------------------
// blurH settings
//---------------------------------------------------------------------
float sBloom : BLOOM = 1;
texture sTex0 : TEX0;
float2 sTex0Size : TEX0SIZE;


//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
#include "mta-helper.fx"


//-----------------------------------------------------------------------------
// Static data
//-----------------------------------------------------------------------------
static const float Kernel[13] = {-6, -5,     -4,     -3,     -2,     -1,     0,      1,      2,      3,      4,      5,      6};
static const float Weights[13] = {      0.002216,       0.008764,       0.026995,       0.064759,       0.120985,       0.176033,       0.199471,       0.176033,       0.120985,       0.064759,       0.026995,       0.008764,       0.002216};


//---------------------------------------------------------------------
// Sampler for the main texture
//---------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture         = (sTex0);
    MinFilter       = Linear;
    MagFilter       = Linear;
    MipFilter       = Linear;
};


//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord: TEXCOORD0;
};


//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 Color = 0;

    float2 coord;
    coord.y = PS.TexCoord.y;

    for(int i = 0; i < 13; ++i)
    {
        coord.x = PS.TexCoord.x + Kernel[i]/sTex0Size.x;
        Color += tex2D(Sampler0, coord.xy) * Weights[i] * sBloom;
    }

    Color = Color * PS.Diffuse;
    Color.a = 1;
    return Color;  
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique blurh
{
    pass P0
    {
        PixelShader  = compile ps_2_0 PixelShaderFunction();
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
