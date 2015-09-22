local blockedTasks = 
{
	"TASK_SIMPLE_IN_AIR", -- We're falling or in a jump.
	"TASK_SIMPLE_JUMP", -- We're beginning a jump
	"TASK_SIMPLE_LAND", -- We're landing from a jump
	"TASK_SIMPLE_GO_TO_POINT", -- In MTA, this is the player probably walking to a car to enter it
	"TASK_SIMPLE_NAMED_ANIM", -- We're performing a setPedAnimation
	"TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE", -- Opening a car door
	"TASK_SIMPLE_CAR_GET_IN", -- Entering a car
	"TASK_SIMPLE_CLIMB", -- We're climbing or holding on to something
	"TASK_SIMPLE_SWIM",
	"TASK_SIMPLE_HIT_HEAD", -- When we try to jump but something hits us on the head
	"TASK_SIMPLE_FALL", -- We fell
	"TASK_SIMPLE_GET_UP" -- We're getting up from a fall
}

local function reloadWeapon()
	-- Usually, getting the simplest task is enough to suffice
	local task = getPedSimplestTask (localPlayer) 

	-- Iterate through our list of blocked tasks
	for idx, badTask in ipairs(blockedTasks) do
		-- If the player is performing any unwanted tasks, do not fire an event to reload
		if (task == badTask) then
			return
		end
	end
	


	triggerServerEvent("relWep", resourceRoot)

	local playerWeapon = getPedWeapon(localPlayer)
	local x,y,z = getElementPosition(localPlayer)
	local sound = playSound3D(":DayZ/sounds/weapons/reload/"..playerWeapon..".wav",x,y,z)
	setSoundMaxDistance(sound,5)
	setSoundVolume(sound,0.5)
end

-- The jump task is not instantly detectable and bindKey works quicker than getControlState
-- If you try to reload and jump at the same time, you will be able to instant reload.
-- We work around this by adding an unnoticable delay to foil this exploit.
addCommandHandler("Reload weapon", function()
	setTimer(function()
		if getPedControlState(localPlayer, "aim_weapon") then return end
		local playerWeapon = getPedWeapon(localPlayer)
		if playerWeapon == 22 and getElementData(localPlayer,"currentweapon_2") == "Flashlight" or playerWeapon == 33 or playerWeapon == 34 then
			return 
		end
		if getPedTotalAmmo (localPlayer) - getPedAmmoInClip (localPlayer) <= 0 then
			triggerEvent("onRollMessageStart", localPlayer, "No ammo left to reload!", 255, 0, 0)
			return
		end
		if 	getPedAmmoInClip (localPlayer) == getWeaponProperty(getPedWeapon( localPlayer ), "pro", "maximum_clip_ammo")or
			getPedAmmoInClip (localPlayer) == getWeaponProperty(getPedWeapon( localPlayer ), "std", "maximum_clip_ammo")or
			getPedAmmoInClip (localPlayer) == getWeaponProperty(getPedWeapon( localPlayer ), "poor", "maximum_clip_ammo")then
			return
		end
		reloadWeapon()
	end, 50, 1)
end)
bindKey("r", "down", "Reload weapon")
