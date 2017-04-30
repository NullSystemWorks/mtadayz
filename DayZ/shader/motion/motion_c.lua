local w, h = guiGetScreenSize( );
local x1, y1, z1 = getCameraMatrix()
local sx1, sy1 = getScreenFromWorldPosition(x1, y1, z1)
local enable = false;

addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource() ),
	function( )
		--bindKey( "u", "up", enableBlackWhite );
	end
)

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end

function renderEffect()	
	local x2, y2, z2 = getCameraMatrix()
	
	local d = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2);
	
	sx2, sy2 = w/2, h/2
	
	local dx = x1 - x2
	local dy = y1 - y2
	local dz = z1 - z2
	
	dxSetShaderValue( screenShader, "BlurAmount", d*multiplier );
	dxSetShaderValue( screenShader, "Angle", findRotation(dx, dx, dx, dz)) -- Fail code, but gives a nice effect
	
	dxSetRenderTarget();
	dxUpdateScreenSource( screenSrc );
	dxDrawImage( 0, 0, w, h, screenShader );
	
	x1, y1, z1 =  getCameraMatrix()
end
--[[
function enableBlackWhite( )
--outputChatBox("Motion Blur Disabled")
		if isElement(screenShader) then
			destroyElement( screenShader );
			destroyElement( screenSrc );
			screenShader, screenSrc = nil, nil;
			removeEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
			multiplier = 0
		end		
	--enable = not enable;
	if getElementData(getLocalPlayer(),"blood") < 3000 then
		--outputChatBox("Motion Blur Enabled")
		screenShader = dxCreateShader( "shader/motion/motion.fx" );
		screenSrc = dxCreateScreenSource( w, h );
		if screenShader and screenSrc then
			dxSetShaderValue( screenShader, "ScreenTexture", screenSrc );
			multiplier = 0.001
			isHandled = true
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end
	elseif getElementData(getLocalPlayer(),"blood") < 5000 then
		--outputChatBox("Motion Blur Enabled")
		screenShader = dxCreateShader( "shader/motion/motion.fx" );
		screenSrc = dxCreateScreenSource( w, h );
		if screenShader and screenSrc then
			dxSetShaderValue( screenShader, "ScreenTexture", screenSrc );
			multiplier = 0.0004
			isHandled = true
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end	
	elseif getElementData(getLocalPlayer(),"blood") < 8000 then
		--outputChatBox("Motion Blur Enabled")
		screenShader = dxCreateShader( "shader/motion/motion.fx" );
		screenSrc = dxCreateScreenSource( w, h );
		if screenShader and screenSrc then
			dxSetShaderValue( screenShader, "ScreenTexture", screenSrc );
			multiplier = 0.0001
			isHandled = true
			addEventHandler( "onClientHUDRender", getRootElement( ), renderEffect );
		end		
	else
			isHandled = false
	end
end
setTimer(enableBlackWhite,3000,0)
]]