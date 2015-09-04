bool isFLon = false;
float4 lightColor=float4(1,1,0.8,0.8);
#include "mta-helper.fx"

sampler Sampler0 = sampler_state
{
    Texture = (gTexture0);
};
    
float4 JaroovkaPS(float4 TexCoord : TEXCOORD0, float4 Position : POSITION, float4 Diff:COLOR0) : COLOR0
{
    float4 Tex = tex2D(Sampler0, TexCoord);
	float4 Diffuse = MTACalcGTABuildingDiffuse( Diff );
	if (isFLon==true) { return float4(Tex.rgb,1)*float4(lightColor.rgb,1); }
					else
					{return float4(Tex.rgb,1)*Diffuse;}
}

technique flash_light_jaroovka
{
    pass P0
    {
        PixelShader = compile ps_2_0 JaroovkaPS();
    }
}
