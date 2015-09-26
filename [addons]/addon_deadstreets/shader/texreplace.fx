// Variable to fetch the texture from the script
texture gTexture;

// My nice technique. Requires absolutely no tools, worries nor skills
technique TexReplace
{
	pass P0
	{
		// Set the texture
		Texture[0] = gTexture;

		
		// LET THE MAGIC DO ITS MAGIC!
	}
}