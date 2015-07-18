texture BlackWhiteTexture;	

sampler screenSampler = sampler_state
{
	Texture = <BlackWhiteTexture>;
};

float4 main(float2 uv : TEXCOORD0) : COLOR0 
{ 
    float4 Color; 
    Color = tex2D( screenSampler , uv); 
	Color.rgb = (Color.r+Color.g+Color.b)/3.0f; 
    return Color; 
};

technique BlackWhite
{
	pass P1
	{
		PixelShader = compile ps_2_0 main();
	}
}