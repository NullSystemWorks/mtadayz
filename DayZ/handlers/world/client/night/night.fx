float sRes : RES = 0;
float4 sNight : NIGHT;

#include "mta-helper.fx"

sampler Sampler0 = sampler_state
{
    Texture         = (gTexture0);
    MinFilter       = Linear;
    MagFilter       = Linear;
    MipFilter       = Linear;
};

struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord: TEXCOORD0;
};

float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    float2 uv = PS.TexCoord - fmod(PS.TexCoord, sRes);
	float4 texel = tex2D(Sampler0, uv);

	float alpha = tex2D(Sampler0, PS.TexCoord).a;

    float4 finalColor = texel * PS.Diffuse * sNight;
    finalColor.a = alpha * PS.Diffuse.a;

    return finalColor;
}

technique night
{
    pass P0
    {
        PixelShader  = compile ps_2_0 PixelShaderFunction();
    }
}

technique fallback
{
    pass P0
    {
        // Draw normally
    }
}
