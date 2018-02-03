//
// Example shader - brightPass.fx
//
// Cut off pixels below threshold
//

//---------------------------------------------------------------------
// brightPass settings
//---------------------------------------------------------------------
texture sTex0 : TEX0;
float sCutoff : CUTOFF = 0.2;         // 0 - 1
float sPower : POWER  = 1;            // 1 - 5


//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
#include "mta-helper.fx"


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
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float3 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
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
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;

    // Calculate screen pos of vertex
    PS.Position = MTACalcScreenPosition ( VS.Position );

    // Pass through color and tex coord
    PS.Diffuse = VS.Diffuse;
    PS.TexCoord = VS.TexCoord;

    return PS;
}


//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float4 Color = 0;

	float4 texel = tex2D(Sampler0, PS.TexCoord);

    float lum = (texel.r + texel.g + texel.b)/3;

    float adj = saturate( lum - sCutoff );

    adj = adj / (1.01 - sCutoff);
    
    texel = texel * adj;
    texel = pow(texel, sPower);

    Color = texel;

	Color.a = 1;
	return Color;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique brightpass
{
    pass P0
    {
        VertexShader = compile vs_2_0 VertexShaderFunction();
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
