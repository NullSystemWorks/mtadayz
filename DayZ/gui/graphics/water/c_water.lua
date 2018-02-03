--
-- c_water.lua
--

local bEffectEnabledWater = false

addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end
	end)

function toggleWaterShader(state)
	if state then
		if not bEffectEnabledWater then
			createWaterShader()
		end
	else
		destroyWaterShader()
	end
end
	
function createWaterShader()
	if bEffectEnabledWater then return end
	-- Create shader
	myShader, tec = dxCreateShader ( ":DayZ/gui/graphics/water/water.fx" )
	if not myShader then
		outputDebugString( "Could not create shader. Please use debugscript 3" )
	else
		outputDebugString( "Using technique " .. tec )
		-- Set textures
		local textureVol = dxCreateTexture ( ":DayZ/gui/graphics/water/images/smallnoise3d.dds" );
		local textureCube = dxCreateTexture ( ":DayZ/gui/graphics/water/images/cube_env256.dds" );
		dxSetShaderValue ( myShader, "sRandomTexture", textureVol );
		dxSetShaderValue ( myShader, "sReflectionTexture", textureCube );
		-- Apply to global txd 13
		engineApplyShaderToWorldTexture ( myShader, "waterclear256" )
		-- Update water color incase it gets changed by persons unknown
		setTimer(function()			
			if myShader then
				local r,g,b,a = getWaterColor()
				dxSetShaderValue ( myShader, "sWaterColor", r/255, g/255, b/255, a/255 );
			end
		end,100,0)
	end
	bEffectEnabledWater = true
end

function destroyWaterShader()
	if myShader then
		engineRemoveShaderFromWorldTexture(myShader,"waterclear256")
		destroyElement(myShader)
		myShader = false
	end
	bEffectEnabledWater = false
end
