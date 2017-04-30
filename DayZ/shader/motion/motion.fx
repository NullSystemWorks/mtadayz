texture ScreenTexture;	

float Angle = 0;  // Defines the blurring direction
float BlurAmount = 0.001;  // Defines the blurring magnitude

sampler ImageSampler = sampler_state
{
	Texture = <ScreenTexture>;
};


float4 main( float2 uv : TEXCOORD) : COLOR
{
	float4 output = 0;  // Defines the output color of a pixel
	float2 offset;  // Defines the blurring direction as a direction vector
	int count = 24;  // Defines the number of blurring iterations

	//First compute a direction vector which defines the direction of blurring. 
	//	This is done using the sincos instruction and the Angle input parameter, 
	//	and the result is stored in the offset variable. This vector is of unit 
	//	length. Multiply this unit vector by BlurAmount to adjust its length to 
	//	reflect the blurring magnitude.
	sincos(Angle, offset.y, offset.x);
	offset *= BlurAmount;

	// To generate the blurred image, we 
	//	generate multiple copies of the input image, shifted 
	//	according to the blurring direction vector, and then sum 
	//	them all up to get the final image.
	for(int i=0; i<count; i++)
		 {
			  output += tex2D(ImageSampler, uv - offset * i);
		 }
	output /= count; // Normalize the color

	return output;
};

technique MotionBlur
{
	pass P1
	{
		PixelShader = compile ps_2_0 main();
	}
}