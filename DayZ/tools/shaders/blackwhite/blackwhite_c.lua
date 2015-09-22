local w, h = guiGetScreenSize( )
isEnabled = false

function renderEffect( )
	dxSetRenderTarget( )
	dxUpdateScreenSource( screenSrc2 )
	dxDrawImage( 0, 0, w, h, screenShader2 )
end

function enableBlackWhite(enable)
	if enable then
		if isEnabled then return end
		screenShader2 = dxCreateShader( "tools/shaders/blackwhite/blackwhite.fx" )
		screenSrc2 = dxCreateScreenSource( w, h )
		if screenShader2 and screenSrc2 then
			dxSetShaderValue( screenShader2, "BlackWhiteTexture", screenSrc2 )
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect )
		end
		isEnabled = true
	else
		if screenShader2 and screenSrc2 then
			destroyElement( screenShader2 )
			destroyElement( screenSrc2 )
			screenShader2, screenSrc2 = nil, nil
			removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect)
			isEnabled = false
		end
	end
end