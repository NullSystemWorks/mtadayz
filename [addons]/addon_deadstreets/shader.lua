texShader = dxCreateShader ( "shader/texreplace.fx" )


shad_exp = dxCreateTexture("generic/shad_exp.png")
dxSetShaderValue(texShader,"gTexture",shad_exp)
engineApplyShaderToWorldTexture(texShader,"shad_exp")


texShader2 = dxCreateShader ( "shader/texreplace.fx" )

coronastar = dxCreateTexture("generic/coronastar.png")
dxSetShaderValue(texShader2,"gTexture",coronastar)
engineApplyShaderToWorldTexture(texShader2,"coronastar")