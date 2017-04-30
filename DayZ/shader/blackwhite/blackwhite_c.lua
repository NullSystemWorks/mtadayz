local w, h = guiGetScreenSize( );
isEnablededededed = false

function renderEffect2( )
	dxSetRenderTarget( );
	dxUpdateScreenSource( screenSrc2 );
	dxDrawImage( 0, 0, w, h, screenShader2 );
end

function enableBlackWhite(enable)
	if enable then
		if isEnablededededed then return end
		screenShader2 = dxCreateShader( "shader/blackwhite/blackwhite.fx" );
		screenSrc2 = dxCreateScreenSource( w, h );
		if screenShader and screenSrc2 then
			dxSetShaderValue( screenShader2, "BlackWhiteTexture", screenSrc2 );
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect2 );
		end
		isEnablededededed = true
	else
		if screenShader2 and screenSrc2 then
			destroyElement( screenShader2 );
			destroyElement( screenSrc2 );
			screenShader2, screenSrc2 = nil, nil;
			removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect2 );
			isEnablededededed = false
		end
	end
end

function enableBlackWhite2( )
	if getElementData(getLocalPlayer(),"blood") < 2000 then
		enableBlackWhite(true)
	else
		enableBlackWhite(false)
	end
end
--setTimer(enableBlackWhite2,1000,0)