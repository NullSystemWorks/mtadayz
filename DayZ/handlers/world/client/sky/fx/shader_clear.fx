//
// shader_clear.fx
//

float4x4 gWorldViewProjection : WORLDVIEWPROJECTION;

struct VSInput
{
    float4 Position : POSITION0;
    float3 TexCoord : TEXCOORD0;
    float4 Diffuse : COLOR0;
}; 

struct PSInput
{
    float4 Position : POSITION;
    float2 TexCoord : TEXCOORD0;
    float4 Diffuse : COLOR0;
};

PSInput VertexShaderSB(VSInput VS)
{
    PSInput PS = (PSInput)0;
    PS.Position = mul(VS.Position, gWorldViewProjection);
    PS.TexCoord = VS.TexCoord;
    PS.Diffuse = 0;
    return PS;
} 

technique shader_clear 
{
    pass P0 
    { 
        AlphaBlendEnable = true;
        VertexShader = compile vs_2_0 VertexShaderSB();
    }
}
technique fallback 
{
    pass P0 
    { 
    }
} 
