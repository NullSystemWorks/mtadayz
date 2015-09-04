bool isFRon = false;
float4 lightColor=float4(1,1,0.8,1);

float4 LightRaysPS(float4 TexCoord : TEXCOORD0, float4 Position : POSITION) : COLOR0
{
	float4 outPut=0;
	if (isFRon==true) { outPut=lightColor;
	  outPut.a=saturate((1-TexCoord.y)*0.13)*lightColor;}
    return outPut;
}

technique flash_light_rays
{
    pass P0
    {
		AlphaRef = 1;
	    AlphaBlendEnable = TRUE;
        PixelShader = compile ps_2_0 LightRaysPS();
    }
}
