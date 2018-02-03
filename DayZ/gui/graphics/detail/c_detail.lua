--
-- c_detail.lua
--

----------------------------------------------------------------
-- enableDetail
----------------------------------------------------------------
function enableDetail()
	if bEffectEnabledDetail then return end

	-- Load textures
	detail22Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail22.png', "dxt3")
	detail58Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail58.png', "dxt3")
	detail68Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail68.png', "dxt1")
	detail63Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail63.png', "dxt3")
	dirtyTexture = dxCreateTexture(':DayZ/gui/graphics/detail/media/dirty.png', "dxt3")
	detail04Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail04.png', "dxt3")
	detail29Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail29.png', "dxt3")
	detail55Texture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail55.png', "dxt3")
	detail35TTexture = dxCreateTexture(':DayZ/gui/graphics/detail/media/detail35T.png', "dxt3")

	-- Create shaders
	brickWallShader, tec = getBrickWallShader()
	if brickWallShader then
		-- Only create the rest if the first one is OK
		grassShader = getGrassShader()
		roadShader = getRoadShader()
		road2Shader = getRoad2Shader()
		paveDirtyShader = getPaveDirtyShader()
		paveStretchShader = getPaveStretchShader()
		barkShader = getBarkShader()
		rockShader = getRockShader()
		mudShader = getMudShader()
		concreteShader = getBrickWallShader()	-- TODO make this better
		sandShader = getMudShader()				-- TODO make this better
	end

	-- Get list of all elements used
	effectPartsDetail = {
						detail22Texture, detail58Texture, detail68Texture, detail63Texture, dirtyTexture,
						detail04Texture, detail29Texture, detail55Texture, detail35TTexture,
						brickWallShader, grassShader, roadShader, road2Shader, paveDirtyShader,
						paveStretchShader, barkShader, rockShader, mudShader,
						concreteShader, sandShader
					}

	-- Check list of all elements used
	bAllValidDetail = true
	for _,part in ipairs(effectPartsDetail) do
		bAllValidDetail = part and bAllValidDetail
	end

	bEffectEnabledDetail = true

	if not bAllValidDetail then
		outputDebugString( "Detail: Could not create some things. Please use debugscript 3" )
		disableDetail()
	else
		outputDebugString( "Detail is using technique " .. tec )

		engineApplyShaderToWorldTexture ( roadShader, "*road*" )
		engineApplyShaderToWorldTexture ( roadShader, "*tar*" )
		engineApplyShaderToWorldTexture ( roadShader, "*asphalt*" )
		engineApplyShaderToWorldTexture ( roadShader, "*freeway*" )
		engineApplyShaderToWorldTexture ( concreteShader, "*wall*" )
		engineApplyShaderToWorldTexture ( concreteShader, "*floor*" )
		engineApplyShaderToWorldTexture ( concreteShader, "*bridge*" )
		engineApplyShaderToWorldTexture ( concreteShader, "*conc*" )
		engineApplyShaderToWorldTexture ( concreteShader, "*drain*" )
		engineApplyShaderToWorldTexture ( paveDirtyShader, "*walk*" )
		engineApplyShaderToWorldTexture ( paveDirtyShader, "*pave*" )
		engineApplyShaderToWorldTexture ( paveDirtyShader, "*cross*" )

		engineApplyShaderToWorldTexture ( mudShader, "*mud*" )
		engineApplyShaderToWorldTexture ( mudShader, "*dirt*" )
		engineApplyShaderToWorldTexture ( rockShader, "*rock*" )
		engineApplyShaderToWorldTexture ( rockShader, "*stone*" )
		engineApplyShaderToWorldTexture ( grassShader, "*grass*" )
		engineApplyShaderToWorldTexture ( grassShader, "desertgryard256" )	-- grass

		engineApplyShaderToWorldTexture ( sandShader, "*sand*" )
		engineApplyShaderToWorldTexture ( barkShader, "*leave*" )
		engineApplyShaderToWorldTexture ( barkShader, "*log*" )
		engineApplyShaderToWorldTexture ( barkShader, "*bark*" )

		-- Roads
		engineApplyShaderToWorldTexture ( roadShader, "*carpark*" )
		engineApplyShaderToWorldTexture ( road2Shader, "*hiway*" )
		engineApplyShaderToWorldTexture ( roadShader, "*junction*" )
		engineApplyShaderToWorldTexture ( paveStretchShader, "snpedtest*" )

		-- Pavement
		engineApplyShaderToWorldTexture ( paveStretchShader, "sidelatino*" )
		engineApplyShaderToWorldTexture ( paveStretchShader, "sjmhoodlawn41" )

		-- Remove detail from LOD models etc.
		for i,part in ipairs(effectPartsDetail) do
			if getElementType(part) == "shader" then
				engineRemoveShaderFromWorldTexture ( part, "tx*" )
				engineRemoveShaderFromWorldTexture ( part, "lod*" )
			end
		end
	end

end


----------------------------------------------------------------
-- disableDetail
----------------------------------------------------------------
function disableDetail()
	if not bEffectEnabledDetail then return end

	-- Destroy all parts
	for _,part in ipairs(effectPartsDetail) do
		if part then
			destroyElement( part )
		end
	end
	effectPartsDetail = {}
	bAllValidDetail = false

	-- Flag effect as stopped
	bEffectEnabledDetail = false
end


----------------------------------------------------------------
-- All the shaders
----------------------------------------------------------------
function getBrickWallShader()
	return getMakeShader( getBrickWallSettings () )
end

function getGrassShader()
	return getMakeShader( getGrassSettings () )
end

function getRoadShader()
	return getMakeShader( getRoadSettings () )
end

function getRoad2Shader()
	return getMakeShader( getRoad2Settings () )
end

function getPaveDirtyShader()
	return getMakeShader( getPaveDirtySettings () )
end

function getPaveStretchShader()
	return getMakeShader( getPaveStretchSettings () )
end

function getBarkShader()
	return getMakeShader( getBarkSettings () )
end

function getRockShader()
	return getMakeShader( getRockSettings () )
end

function getMudShader()
	return getMakeShader( getMudSettings () )
end

function getMakeShader(vDetail)
	--  Create shader with a draw range of 100 units
	local shader,tec = dxCreateShader ( ":DayZ/gui/graphics/detail/fx/detail.fx", 1, 100 )
	if shader then
		dxSetShaderValue( shader, "sDetailTexture", vDetail.texture );
		dxSetShaderValue( shader, "sDetailScale", vDetail.detailScale )
		dxSetShaderValue( shader, "sFadeStart", vDetail.sFadeStart )
		dxSetShaderValue( shader, "sFadeEnd", vDetail.sFadeEnd )
		dxSetShaderValue( shader, "sStrength", vDetail.sStrength )
		dxSetShaderValue( shader, "sAnisotropy", vDetail.sAnisotropy )
	end
	return shader,tec
end


-- brick wall type thing
---------------------------------
function getBrickWallSettings ()
	local vDetail = {}
	vDetail.texture=detail22Texture
	vDetail.detailScale=3
	vDetail.sFadeStart=60
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.6
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- grass
---------------------------------
function getGrassSettings ()
	local vDetail = {}
	vDetail.texture=detail58Texture
	vDetail.detailScale=2
	vDetail.sFadeStart=60
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.6
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- road
---------------------------------
function getRoadSettings ()
	local vDetail = {}
	vDetail.texture=detail68Texture
	vDetail.detailScale=1
	vDetail.sFadeStart=60
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.6
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- road2
---------------------------------
function getRoad2Settings ()
	local vDetail = {}
	vDetail.texture=detail63Texture
	vDetail.detailScale=1
	vDetail.sFadeStart=90
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.7
	vDetail.sAnisotropy=0.9
	return vDetail
end
---------------------------------

-- dirty pave
---------------------------------
function getPaveDirtySettings ()
	local vDetail = {}
	vDetail.texture=dirtyTexture
	vDetail.detailScale=1
	vDetail.sFadeStart=60
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.4
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- stretch pave 
---------------------------------
function getPaveStretchSettings ()
	local vDetail = {}
	vDetail.texture=detail04Texture
	vDetail.detailScale=1
	vDetail.sFadeStart=80
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.3
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- tree bark
---------------------------------
function getBarkSettings ()
	local vDetail = {}
	vDetail.texture=detail29Texture
	vDetail.detailScale=1
	vDetail.sFadeStart=80
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.6
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- rock
---------------------------------
function getRockSettings ()
	local vDetail = {}
	vDetail.texture=detail55Texture
	vDetail.detailScale=1
	vDetail.sFadeStart=80
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.5
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------

-- mud
---------------------------------
function getMudSettings ()
	local vDetail = {}
	vDetail.texture=detail35TTexture
	vDetail.detailScale=2
	vDetail.sFadeStart=80
	vDetail.sFadeEnd=100
	vDetail.sStrength=0.6
	vDetail.sAnisotropy=1
	return vDetail
end
---------------------------------
