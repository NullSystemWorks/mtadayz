--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script inventory.lua				*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

inventoryItems = {
["Weapons"] = {
["Primary Weapon"] = {
{"M4",10, 'm4a1.png', 128, 64,"Assault Rifle", "Ammunition: 5.56x45mm Cartridge \nNoise: High (60)\nDamage: 3300"},
{"CZ 550",10, 'sniper.png', 256,82,"Sniper", "Ammunition: 9.3x62mm Cartridge \nNoise: High (60)\nDamage: 7733"},
{"Winchester 1866",10, 'winchester.png', 256, 143 ,"Shotgun", "Ammunition: 1866 Slug \nNoise: Moderate (40)\nDamage: 8910"},
{"SPAZ-12 Combat Shotgun",10, 'm1014.png', 256, 128 ,"Shotgun", "Ammunition: 12 Gauge Pellet \nNoise: High (60)\nDamage: 3000"},
{"Sawn-Off Shotgun",10, 'sawn.png', 256, 128,"Shotgun", "Ammunition: 2Rnd. Slug \nNoise: High (60)\nDamage: 6500"},
{"AK-47",10, 'akm.png', 256, 128 ,"Assault Rifle", "Ammunition: 5.45x39mm Cartridge \nNoise: High (60)\nDamage: 2722"},
{"Lee Enfield",10, 'lee.png', 256, 128,"Repeating Rifle", "Ammunition: .303 British Cartridge \nNoise: Moderate (40)\nDamage: 6722"},
{"Sporter 22",10,'lee.png',256,128,"Repeating Rifle","Ammunition: .303 British Cartridge \nNoise: Moderate (40)\nDamage: 6722"},
{"Mosin 9130",10,'lee.png',256,128,"Repeating Rifle","Ammunition: .303 British Cartridge \nNoise: Moderate (40)\nDamage: 6722"},
{"Crossbow",10,'crossbow.png',128,128,"Crossbow","Ammunition: Bolt \nNoise: None (0)\nDamage: 5333"},
{"SKS",10,'lee.png',256,128,"Repeating Rifle","Ammunition: .303 British Cartridge \nNoise: High (60)\nDamage: 4000"},
{"Blaze 95 Double Rifle",10,'m1014.png',256,128,"Shotgun","Ammunition: 2Rnd. Slug \nNoise: High (60)\nDamage: 4500"},
{"Remington 870",10,'m1014.png',256,128,"Shotgun","Ammunition: 12 Gauge Pellet \nNoise: High (60)\nDamage: 4500"},
{"FN FAL",10,'akm.png',256,128,"Assault Rifle","Ammunition: 5.45x39mm Cartridge \nNoise: High (60)\nDamage: 2800"},
{"G36C",10,'akm.png',256,128,"Assault Rifle","Ammunition: 5.45x39mm Cartridge \nNoise: High (60)\nDamage: 3300"},
{"Sa58V CCO",10,'akm.png',256,128,"Assault Rifle","Ammunition: 5.45x39mm Cartridge \nNoise: High (60)\nDamage: 4100"},
{"SVD Dragunov",10,'sniper.png',256,82,"Sniper","Ammunition: 9.3x62mm Cartridge \nNoise: High (60)\nDamage: 8000"},
{"DMR",10,'sniper.png',256,82,"Sniper","Ammunition: 9.3x62mm Cartridge \nNoise: High (60)\nDamage: 8200"},
},

["Secondary Weapon"] = {
{"M1911",5, 'colt.png', 256, 256,"Handgun", "Ammunition: .45 ACP Cartridge \nNoise: Low (20)\nDamage: 889"},
{"M9 SD",5, 'm9.png', 256, 256,"Handgun", "Ammunition: 9x19mm SD Cartridge \nNoise: None (0)\nDamage: 889"},
{"PDW",5, 'pdw.png', 256, 256,"Sub-Machine Gun", "Ammunition: 9x19mm Cartridge \nNoise: Moderate (40)\nDamage: 889"},
{"G17",5,'colt.png',256,256,"Handgun","You shouldn't have this."},
{"MP5A5",5, 'mp5.png', 256, 128,"Sub-Machine Gun", "Ammunition: 9x18mm Cartridge \nNoise: High (60)\nDamage: 889"},
{"Desert Eagle",5, 'revolver.png',256,256,"Handgun","Ammunition: .45 ACP Cartridge \nNoise: High (60)\nDamage: 4500"},
{"Bizon PP-19",5,'mp5.png',256,128,"Sub-Machine Gun","Ammunition: 9x18mm Cartridge \nNoise: High (60)\nDamage: 889"},
{"Revolver",5,'revolver.png',256,256,"Handgun","Ammunition: .45 ACP Cartridge \nNoise: High (60)\nDamage: 4500"},
{"Hunting Knife",5, 'knife.png',128,128,"Melee", "Ammunition: None\n Noise: None (0)\nDamage: 1500"},
{"Hatchet",5, 'hatchet.png',128,128,"Melee", "Ammunition: None\n Noise: None (0)\nDamage: 2000"},
{"Baseball Bat",5, 'bat.png', 256,128,"Melee", "Ammunition: None\n Noise: None (0)\nDamage: 1199"},
{"Shovel",5, 'shovel.png', 256, 154,"Melee", "Ammunition: None\n Noise: None (0)\nDamage: 1203"},
{"Golf Club",5, 'golf.png', 256, 192,"Melee", "Ammunition: None\n Noise: None (0)\nDamage: 953"},
{"Machete",5,'bat.png',128,64,"Melee","<DEV WEAPON>\nDamage: 12500"},
{"Crowbar",5,'bat.png',128,64,"Melee","You shouldn't have this."},
},

["Specially Weapon"] = {
{"Parachute",1, 'parachute.png', 128,128,"Item", "Equip to use.\n'Time to fly!'"},
{"Tear Gas",1, 'gas.png', 128, 128,"Item", "You shouldn't have this."},
{"Grenade",5, 'grenade.png', 128, 128,"Item", "'Noise: High(60)\nDamage: 17998\n'Fucking brutal.'"},
{"Binoculars",1, 'binocular.png', 128, 128,"Item", "Click item to equip.\n'I can see my house from here!'"}
},

},
["Ammo"] = {
{".45 ACP Cartridge",0.085, 'mag.png',256,256,"Ammunition", "For:\nM1911\nDesert Eagle\nRevolver"},
{"9x19mm SD Cartridge",0.085, 'mag.png',256,256,"Ammunition", "For:\nM9 SD"},
{"9x19mm Cartridge",0.025, 'mag.png',256,256,"Ammunition", "For:\nPDW"},
{"9x18mm Cartridge",0.025, 'mag.png',256,256,"Ammunition", "For:\nMP5A5\nBizon PP-19"},
{"5.45x39mm Cartridge",0.035, 'mag.png',256,256,"Ammunition", "For:\nAK-47\nG36C\nFN FAL"},
{"5.56x45mm Cartridge",0.035, 'mag.png',256,256,"Ammunition", "For:\nM4"},
{"1866 Slug",0.067, 'mag.png',256,256,"Ammunition", "For:\nWinchester 1866"},
{"2Rnd. Slug",0.067, 'mag.png',256,256,"Ammunition", "For:\nSawn-Off Shotgun\nBlaze 95 Double Rifle"},
{"12 Gauge Pellet",0.067, 'mag.png',256,256,"Ammunition", "For:\nSPAZ-12 C. Shotgun\nRemington 870"},
{"9.3x62mm Cartridge",0.1, 'mag.png',256,256,"Ammunition", "For:\nCZ 550\nDMR\nSVD Dragunov"},
{".303 British Cartridge",0.1, 'mag.png',256,256,"Ammunition", "For:\nLee Enfield\nSporter 22\nMosin 9130\nSKS"},
{"Bolt",0.1,'mag.png',256,256,"Ammunition","For:\nCrossbow"},
},

["Food"] = {
{"Water Bottle",1, 'bottle.png', 128, 128,"Drink", "Restores: Thirst\nAmount: 100(Thirst)"},
{"Pasta Can",1,'can.png',256,256,"Food", "Restores: Hunger, Blood\nAmount: 100(Hunger), 200(Blood)"},
{"Beans Can",1,'can.png',256,256,"Food", "Restores: Hunger, Blood\nAmount: 100(Hunger), 200(Blood)"},
{"Burger",1,'burger.png',256,256,"Food", "Restores: Hunger, Blood\nAmount: 100(Hunger), 300(Blood)"},
{"Pizza",1, 'pizza.png', 256, 256,"Food", "Restores: Hunger, Blood\nAmount: 100(Hunger), 300(Blood)"},
{"Soda Bottle",1,'pepsi.png', 256, 256,"Drink", "Restores: Thirst\nAmount: 100(Thirst)"},
{"Milk",1,'milk.png', 256, 256,"Drink", "Restores: Thirst\nAmount: 100(Thirst)"},
{"Cooked Meat",1, 'meat.png',256,256,"Food", "Restores: Hunger, Blood\nAmount: 100(Hunger), 800(Blood)"},
},

["Items"] = {
{"Wood Pile",2, 'wood.png',128,128,"Item", "Use in combination with 'Box of Matches'\ntocreate a fire.\nCan cook Raw Meat."},
{"Bandage",1, 'bandage.png', 128, 128, "Item", "Use when bleeding.","Bandage yourself"},
{"Roadflare",1, 'flashlight.png', 128, 128, "Item", "Use to illuminate dark places\nor for a distraction.","Place"},
{"Empty Gas Canister",2, 'kan.png', 128, 128,"Item", "Can be refilled at local\npatrol station."},
{"Full Gas Canister",2, 'kan.png', 128, 128,"Item", "Filled with gas."},
{"Medic Kit",2, 'chest.png', 128, 128, "Item", "Use when low on blood.","Use"},
{"Heat Pack",1, 'heater.png', 128, 128, "Item", "Use when low on temperature.","Use"},
{"Painkiller",1, 'tablet.png', 256, 256, "Item", "Use when feeling pain.","Use"},
{"Morphine",1, 'morphine.png',128,128,"Item", "Use when suffering from\nbroken bones.","Use"},
{"Blood Bag",1, 'blood.png', 128, 85, "Item", "Use on other players to full restore\ntheir blood.","Use"},
{"Wire Fence", 1, 'wirefence.png', 128, 128, "Item", "Use to protect narrow places.","Build a wire fence"}, 
{"Raw Meat", 1, 'flesh.png', 128, 128,"Item", "Use on fireplaces to produce\nRaw Meat."}, 
{"Tire", 2, 'wheel.png', 128, 128,"Item", "Can be used to repair a car."}, 
{"Engine", 5, 'engine.png', 128,128,"Item", "Can be used to repair a car.",}, 
{"Tank Parts", 3, 'engine_part.png', 128,128,"Item", "Can be used to reduce\nfuel consumption."},
{"Tent", 3, 'tent.png', 256, 256, "Item", "Use to create your own\npersonal place to store\nitems in.","Pitch a tent"}, 
{"Camouflage Clothing",1,'clothes.png',128,128,"Item","Use to 'adorn' yourself\nwith new clothes.","Put clothes on"},
{"Civilian Clothing",1,'clothes.png',128,128,"Item","Use to 'adorn' yourself\nwith new clothes.","Put clothes on"},
{"Survivor Clothing",1,'clothes.png',128,128,"Item","Use to 'adorn' yourself\nwith new clothes.","Put clothes on"},
{"Ghillie Suit",1,'clothes.png',128,128,"Item","Use to 'adorn' yourself\nwith new clothes.\nSPECIAL:\nWill become invisible when\nstanding still.","Put clothes on"},
{"Empty Water Bottle", 1, 'gas.png', 128, 128,"Item", "Use in a body of water\n to refill.", "Fill bottle up"}, 
{"Empty Soda Cans", 1,'cola.png', 256, 256,"Item", "Useless garbage."}, 
{"Scruffy Burgers", 1,'burger.png',256,256,"Item", "Useless garbage."}, 
{"Assault Pack (ACU)",1,'coyote.png',170,170,"Item", "Gives you an additional\n18 slots."},
{"Alice Pack",1,'coyote.png',170,170,"Item", "Gives you an additional\n25 slots."},
{"Czech Backpack",1,'coyote.png',170,170,"Item", "Gives you an additional\n46 slots."},
{"Coyote Backpack",1,'coyote.png',170,170,"Item", "Gives you an additional\n64 slots."},
{"Ghillie Backpack",1,'coyote.png',170,170,"Item", "Gives you an additional\n45 slots."},
{"OS Backpack",1,'coyote.png',170,170,"Item", "Gives you an additional\n100 slots."},


-- [[ BLUEPRINTS ]] --
-- [ PRIMARY WEAPONS ] --
{"M4 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"CZ 550 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Winchester '66 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"SPAZ-12 C. Shtgn. Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Sawn-Off Shtgn. Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"AK-47 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Lee Enfield Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Sporter 22 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Mosin 9130 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Crossbow Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"SKS Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Blaze 95 D. R. Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Remington 870 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"FN FAL Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"G36C Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Sa58V CCO Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"SVD Dragunov Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"DMR Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},

-- [ SECONDARY WEAPONS ] --
{"M1911 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"M9 SD Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"PDW Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"G17 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"MP5A5 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Bizon PP-19 Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Revolver Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Desert Eagle Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Hunting Knife Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Hatchet Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Baseball Bat Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Shovel Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Golf Club Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Machete Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Crowbar Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},

-- [ SPECIAL WEAPONS ] --
{"Parachute Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Tear Gas Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Grenade Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Binoculars Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},

-- [ AMMO BLUEPRINTS ] --
{".45 ACP Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components,\n one is able to rebuild the item shown on this blueprint.","Craft"},
{"9x19mm SD Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"9x19mm Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"9x18mm Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"5.45x39mm Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"5.56x45mm Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"1866 Slug Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"2Rnd. Slug Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"12 Gauge Pellet Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"9.3x62mm Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{".303 British Cartridge Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Bolt Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},

-- [ ITEMS BLUEPRINTS ] --
{"Medic Kit Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Wire Fence Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Tent Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Camouflage Clthng. Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Survivor Clthng. Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Civilian Clthng. Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Ghillie Suit Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Roadflare Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},

-- [ TOOLBELT BLUEPRINTS ] --
{"Toolbox Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Radio Device Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Infrared Goggles Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},
{"Night Vision Goggles Blueprint",1,'clothes.png',128,128,"Blueprint","Given the right tools and components, one is able to\n rebuild the item shown on this blueprint.","Craft"},


-- [ BLUEPRINT PARTS ] --
{"Gun Barrel",1,'clothes.png',128,128,"Used in:","All Primary Weapons Blueprints"},
{"Short Gun Barrel",1,'clothes.png',128,128,"Used in:","All Secondary Gun Weapons Blueprints"},
{"Gun Stock",1,'clothes.png',128,128,"Used in:","All Weapons Blueprints"},
{"Thread",1,'clothes.png',128,128,"Used in:","Survivor Clothing Blueprint\nCivilian Clothing Blueprint\nCamouflage Clothing Blueprint\nGhillie Suit Blueprint"},
{"Cloth",1,'clothes.png',128,128,"Component","Can be used to craft various clothings."},
{"Gun Powder",1,'clothes.png',128,128,"Component","Universal component used for ammunition."},
{"Mechanical Supplies",1,'clothes.png',128,128,"Component","Universal component used for electronics."},
{"Cables",1,'clothes.png',128,128,"Component","Universal component used for electronics."},
{"Nails",1,'clothes.png',128,128,"Component","Universal component used in various blueprints."},
{"Sheet",1,'clothes.png',128,128,"Component","A sheet. What else did you expect?"},
{"Barbed Wire",1,'clothes.png',128,128,"Component","Used for tactical consumables like the Wire Fence."},
{"Duct Tape",1,'clothes.png',128,128,"Component","Universal component used for electronics."},
{"Glue",1,'clothes.png',128,128,"Component","Universal component used for electronics."},
{"Drugs",1,'clothes.png',128,128,"Component","Can be used for medical consumables."},
{"Bandaid",1,'clothes.png',128,128,"Component","Can be used for medical consumables."},
{"Vitamins",1,'clothes.png',128,128,"Component","Can be used for medical consumables."},
{"Tissue",1,'clothes.png',128,128,"Component","Can be used for medical consumables."},
{"Small Box",1,'clothes.png',128,128,"Component","A small box."},
{"String",1,'clothes.png',128,128,"Component","A rather long string."},
{"Needle",1,'clothes.png',128,128,"Component","A sharp instrument for sowing."},
{"Microchips",1,'clothes.png',128,128,"Component","Can be used for electric consumables."},
{"Optics",1,'clothes.png',128,128,"Component","Can be used for items like the binoculars."},
{"Sharp Metal",1,'clothes.png',128,128,"Component","TO DO"},
{"Handle",1,'clothes.png',128,128,"Component","TO DO"},
{"Wooden Stick",1,'clothes.png',128,128,"Component","TO DO"},
{"Hand Saw",1,'clothes.png',128,128,"Component","TO DO"},
{"Metal Plate",1,'clothes.png',128,128,"Component","TO DO"},
{"Metallic Stick",1,'clothes.png',128,128,"Component","TO DO"},
{"Small Casing",1,'clothes.png',128,128,"Component","TO DO"},
},

["Toolbelt"] = {
{"Night Vision Goggles", 1,'night.png',128,128,"Item", "Press 'N' to activate."}, 
{"Infrared Goggles", 1,'ir.png',128,128,"Item", "Press 'I' to activate."}, 
{"Map", 1,'map.png',256,256,"Item", "Press 'F11' to activate."}, 
{"Box of Matches", 1, 'matches.png',100,100,"Item", "Use in combination with 'Wood Pile'\nto create a fire.", "Make a Fire"}, 
{"Watch", 1,'watch.png',256,256,"Item", "Passive item, will be\nactivated when picking up."}, 
{"GPS", 1,'gps.png',128,128,"Item", "Passive item, will be\nactivated when picking up."}, 
{"Toolbox", 1,'tool.png',128,128,"Item", "Used to repair cars\n of all kinds."}, 
{"Radio Device", 1,'radio.png',128,128,"Item", "Press 'Z' to activate."},
{"Compass",1,'gps.png',128,128,"Item","Passive item, will be\nactivated when picking up."},
},

}




------------------------------------------------------------------------------
--INVENTORY
local headline = {}
local gridlistItems = {}
local buttonItems = {}

function hideInventoryManual()
	closeInventory()
end
addEvent("hideInventoryManual", true)
addEventHandler("hideInventoryManual", getLocalPlayer(), hideInventoryManual)

function refreshInventoryManual()
	placeItemsInInventory()
end
addEvent("refreshInventoryManual", true)
addEventHandler("refreshInventoryManual", getLocalPlayer(), refreshInventoryManual)

function refreshLootManual(loot)
	refreshLoot(loot)
end
addEvent("refreshLootManual", true)
addEventHandler("refreshLootManual", getLocalPlayer(), refreshLootManual)

function getPlayerMaxAviableSlots()
	return getElementData(getLocalPlayer(), "MAX_Slots")
end

function getLootMaxAviableSlots(loot)
	if isElement ( loot ) then
		return getElementData(loot, "MAX_Slots")
	else
		return 0
	end
end

function getPlayerCurrentSlots()
local current_SLOTS = 0
	for id,item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
		if getElementData(getLocalPlayer(), item[1]) and getElementData(getLocalPlayer(), item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(getLocalPlayer(), item[1])
		end
	end
	for id,item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
		if getElementData(getLocalPlayer(), item[1]) and getElementData(getLocalPlayer(), item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(getLocalPlayer(), item[1])
		end
	end
	for id,item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
		if getElementData(getLocalPlayer(), item[1]) and getElementData(getLocalPlayer(), item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(getLocalPlayer(), item[1])
		end
	end
	for id,item in ipairs(inventoryItems["Ammo"]) do
		if getElementData(getLocalPlayer(), item[1]) and getElementData(getLocalPlayer(), item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(getLocalPlayer(), item[1])
		end
	end
	for id,item in ipairs(inventoryItems["Food"]) do
		if getElementData(getLocalPlayer(), item[1]) and getElementData(getLocalPlayer(), item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(getLocalPlayer(), item[1])
		end
	end
	for id,item in ipairs(inventoryItems["Items"]) do
		if getElementData(getLocalPlayer(), item[1]) and getElementData(getLocalPlayer(), item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(getLocalPlayer(), item[1])
		end
	end
return math.floor(current_SLOTS)
end

function getLootCurrentSlots(loot)
	if isElement ( loot ) then
	  local current_SLOTS = 0
	  for id,item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(inventoryItems["Ammo"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(inventoryItems["Food"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(inventoryItems["Items"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  return math.floor(current_SLOTS)
	else
		return false
	end
end

function getItemSlots(itema)
local current_SLOTS = 0
	for id,item in ipairs(inventoryItems["Weapons"]["Primary Weapon"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(inventoryItems["Weapons"]["Secondary Weapon"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(inventoryItems["Weapons"]["Specially Weapon"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(inventoryItems["Ammo"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(inventoryItems["Food"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(inventoryItems["Items"]) do
		if itema == item[1] then
			return item[2]
		end
	end
return false
end

function isToolbeltItem(itema)
local current_SLOTS = 0
	for id,item in ipairs(inventoryItems["Toolbelt"]) do
		if itema == item[1] then
			return true
		end
	end
return false
end
vehicleAddonsInfo = {
-- {Model ID, Tires, Engine, Tank Parts}
{422,4,1,1},
{470,4,1,1},
{468,2,1,1},
{433,6,1,1},
{437,6,1,1},
{509,0,0,0},
{487,0,1,1},
{497,0,1,1},
{453,0,1,1},
{483,4,1,1},
{508,4,1,1},
}

function getVehicleAddonInfos (id)
	for i,veh in ipairs(vehicleAddonsInfo) do
		if veh[1] == id then
			return veh[2],veh[3], veh[4]
		end
	end
end

--OTHER ITEM STUFF
vehicleFuelTable = {
-- {Model ID, Max Fuel}
{422,80},
{470,100},
{468,30},
{433,140},
{437,140},
{509,0},
{487,60},
{497,60},
{453,60},
{483,140},
{508,140},
}

function getVehicleMaxFuel(loot)
	local modelID = getElementModel(getElementData(loot,"parent"))
	for i,vehicle in ipairs(vehicleFuelTable) do
		if modelID == vehicle[1] then
			 return vehicle[2]
		end
	end
	return false
end

function moveItemOutOfInventory(itemName)
if playerMovedInInventory then startRollMessage2("Inventory", "Abusing explots will result in a ban!", 255, 22, 0) return true end
	if getElementData(getLocalPlayer(), itemName) and getElementData(getLocalPlayer(), itemName) >= 1 then
		if isPlayerInLoot() then
			local isVehicle = getElementData(isPlayerInLoot(), "vehicle")
			local isTent = getElementData(isPlayerInLoot(), "tent")
			if isVehicle and not isTent then
				local veh = getElementData(isPlayerInLoot(), "parent")
				local tires,engine,parts = getVehicleAddonInfos(getElementModel(veh))
				if itemName == "Tire" then itemName = "Tire" end
				if itemName == "Engine" then itemName = "Engine" end
				if itemName == "Tank Parts" then itemName = "Parts" end
				if not getElementData(isPlayerInLoot(), itemName.."_inVehicle") then setElementData(isPlayerInLoot(), itemName .. "_inVehicle", 0) end
				if (itemName == "Tire" and tires > 0 and getElementData ( isPlayerInLoot(), "Tire_inVehicle") < tires) or ( itemName == "Engine" and engine > 0 and getElementData ( isPlayerInLoot(), "Engine_inVehicle") < engine) or ( itemName == "Parts" and parts > 0 and getElementData ( isPlayerInLoot(), "Parts_inVehicle") < parts) then
					triggerEvent("onPlayerMoveItemOutOFInventory", getLocalPlayer(), itemName.."_inVehicle", isPlayerInLoot())
				else
					triggerEvent("onPlayerMoveItemOutOFInventory", getLocalPlayer(), itemName, isPlayerInLoot())
				end
				playerMovedInInventory = true
				setTimer(function()
					playerMovedInInventory = false
				end, 700, 1)
			elseif isToolbeltItem(itemName) or getLootCurrentSlots(getElementData(getLocalPlayer(), "currentCol")) + getItemSlots(itemName) <= getLootMaxAviableSlots(isPlayerInLoot()) then
				triggerEvent("onPlayerMoveItemOutOFInventory", getLocalPlayer(), itemName, isPlayerInLoot())
				playerMovedInInventory = true
				setTimer(function()
					playerMovedInInventory = false
				end, 700, 1)
			else
				startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
				return true
			end
			local col = getElementData(getLocalPlayer(), "currentCol")
			setTimer(placeItemsInInventory, 200, 2)
		else
			triggerEvent("onPlayerMoveItemOutOFInventory", getLocalPlayer(), itemName, false)
			setTimer(placeItemsInInventory, 200, 2)
		end
	end
end

function onPlayerMoveItemOutOFInventory (itemName,loot)
local itemPlus = 1
if itemName == ".45 ACP Cartridge" then
	itemPlus = 7
elseif itemName == "9x19mm SD Cartridge" then
	itemPlus = 15
elseif itemName == "9x19mm Cartridge" then
	itemPlus = 30
elseif itemName == "9x18mm Cartridge" then
	itemPlus = 20
elseif itemName == "5.45x39mm Cartridge" then
	itemPlus = 30
elseif itemName == "5.56x45mm Cartridge" then
	itemPlus = 20
elseif itemName == "1866 Slug" then
	itemPlus = 7
elseif itemName == "2Rnd. Slug" then
	itemPlus = 2
elseif itemName == "12 Gauge Pellet" then
	itemPlus = 7
elseif itemName == "9.3x62mm Cartridge" then
	itemPlus = 5
elseif itemName == ".303 British Cartridge" then
	itemPlus = 10
elseif itemName == "M136 Rocket" then
	itemPlus = 0
elseif itemName == "Bolt" then
	itemPlus = 7
elseif itemName == "M4" or itemName == "Mosin 9130" or itemName == "Sporter 22" or itemName == "SKS" or itemName == "Blaze 95 Double Rifle" or itemName == "DMR" or itemName == "SVD Dragunov" or itemName == "Crossbow" or itemName == "Bizon PP-19" or itemName == "FN FAL" or itemName == "G36C" or itemName == "Sa58V CCO" or itemName == "AK-47" or itemName == "CZ 550" or itemName == "Winchester 1866" or itemName == "SPAZ-12 Combat Shotgun" or itemName == "Sawn-Off Shotgun" or itemName == "Heat-Seeking RPG" or itemName == "M136 Rocket Launcher" or itemName == "Lee Enfield" then
	triggerServerEvent("removeBackWeaponOnDrop",getLocalPlayer())
end
if loot then
		if not getElementData(loot, "itemloot") and getElementType(getElementData(loot, "parent")) == "vehicle" and itemName == "Full Gas Canister" then
			if getElementData(loot, "fuel") + 20 < getVehicleMaxFuel(loot) then
				addingfuel = 20
			elseif getVehicleMaxFuel(loot) + 15 < getElementData(loot, "fuel") + 20 then
				triggerEvent("displayClientInfo", getLocalPlayer(), "Vehicle", "The tank is full!", 255, 22, 0)
				return true
			else
				addingfuel = getVehicleMaxFuel(loot) - getElementData(loot, "fuel")
			end
			setElementData(loot, "fuel", getElementData(loot, "fuel") + addingfuel)
			setElementData(getLocalPlayer(), itemName, getElementData(getLocalPlayer(), itemName) - itemPlus)
			setElementData(getLocalPlayer(), "Empty Gas Canister", (getElementData(getLocalPlayer(), "Empty Gas Canister") or 0) + itemPlus)
			triggerEvent("displayClientInfo", getLocalPlayer(), "Vehicle", "Filled gas into vehicle!", 22, 255, 0)
			return true
		end
		itemName2 = itemName
		if itemName == "Tire_inVehicle" then itemName2 = "Tire" end
		if itemName == "Engine_inVehicle" then itemName2 = "Engine" end
		if itemName == "Parts_inVehicle" then itemName2 = "Tank Parts" end
		if not getElementData(loot, itemName) then
			setElementData(loot, itemName, 1)
		else
			setElementData(loot, itemName, getElementData(loot, itemName)+1)
		end
		local players = getElementsWithinColShape(loot, "player")
		if #players > 1 then
			triggerServerEvent("onPlayerChangeLoot", getRootElement(), loot)
		end
		if not getElementData(loot, "itemloot") and getElementType(getElementData(loot, "parent")) == "vehicle" then
			setElementData(getLocalPlayer(), itemName2, getElementData(getLocalPlayer(), itemName2) - itemPlus)
			triggerServerEvent("refreshItemLoot", getRootElement(), loot, getElementData(loot, "parent"))
			return true
		end
		if itemName == "Tire_inVehicle" then itemName = "Tire" end
		if itemName == "Engine_inVehicle" then itemName = "Engine" end
		if itemName == "Parts_inVehicle" then itemName = "Tank Parts" end
		setElementData(getLocalPlayer(), itemName, getElementData(getLocalPlayer(), itemName) - itemPlus)
		if loot and getElementData(loot, "itemloot") then
			triggerServerEvent("refreshItemLoot", getRootElement(), loot, getElementData(loot, "parent"))
		end
	else
		if itemName == "Tire_inVehicle" then itemName = "Tire" end
		if itemName == "Engine_inVehicle" then itemName = "Engine" end
		if itemName == "Parts_inVehicle" then itemName = "Tank Parts" end
		setElementData(getLocalPlayer(), itemName, getElementData(getLocalPlayer(), itemName) - itemPlus)
		triggerServerEvent("playerDropAItem", getLocalPlayer(), itemName)
	end
end
addEvent("onPlayerMoveItemOutOFInventory", true)
addEventHandler("onPlayerMoveItemOutOFInventory", getRootElement(), onPlayerMoveItemOutOFInventory)


function onPlayerMoveItemInInventory()
	local itemName = guiGridListGetItemText(gridlistItems.loot, guiGridListGetSelectedItem(gridlistItems.loot), 1)
	if isPlayerInLoot() then
		if getElementData(isPlayerInLoot(), itemName) and getElementData(isPlayerInLoot(), itemName) >= 1 then
			if not isToolbeltItem(itemName) then
				if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then
					if not playerMovedInInventory then
						triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
						playerMovedInInventory = true
						setTimer(function()
							playerMovedInInventory = false
						end, 700, 1)
					else
						startRollMessage2("Inventory", "Abusing exploits will result in a ban!", 255, 22, 0)
						return true
					end
				else
					startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
					return true
				end
			else
				playerMovedInInventory = true
				 setTimer(function()
					 playerMovedInInventory = false
				end, 700, 1)
				triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
			end
		end
	end
	if isPlayerInLoot() then
		local gearName = guiGetText(headline.loot)
		local col = getElementData(getLocalPlayer(), "currentCol")
		setTimer(refreshInventory, 200, 2)
		setTimer(refreshLoot, 200, 2, col, gearName)
	end
end

function refreshLoot()
	return true
end


function onPlayerMoveItemInInventory (itemName,loot)
local itemPlus = 1
if itemName == ".45 ACP Cartridge" then
	itemPlus = 7
elseif itemName == "9x19mm SD Cartridge" then
	itemPlus = 15
elseif itemName == "9x19mm Cartridge" then
	itemPlus = 30
elseif itemName == "9x18mm Cartridge" then
	itemPlus = 20
elseif itemName == "5.45x39mm Cartridge" then
	itemPlus = 30
elseif itemName == "5.56x45mm Cartridge" then
	itemPlus = 20
elseif itemName == "1866 Slug" then
	itemPlus = 7
elseif itemName == "2Rnd. Slug" then
	itemPlus = 2
elseif itemName == "12 Gauge Pellet" then
	itemPlus = 7
elseif itemName == "9.3x62mm Cartridge" then
	itemPlus = 5
elseif itemName == ".303 British Cartridge" then
	itemPlus = 10
elseif itemName == "M136 Rocket" then
	itemPlus = 0
elseif itemName == "Bolt" then
	itemPlus = 7
elseif itemName == "Assault Pack (ACU)" then
	if getElementData(localPlayer,"MAX_Slots") == 18 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 18 then
		if getElementData(loot,itemName) ~= "Assault Pack (ACU)" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",18)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Alice Pack" then
	if getElementData(localPlayer,"MAX_Slots") == 25 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 25 then
		if getElementData(loot,itemName) ~= "Alice Pack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",25)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Czech Backpack" then
	if getElementData(localPlayer,"MAX_Slots") == 36 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 36 then
		if getElementData(loot,itemName) ~= "Assault Pack (ACU)" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",36)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0	
elseif itemName == "Coyote Backpack" then
	if getElementData(localPlayer,"MAX_Slots") == 64 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 64 then
		if getElementData(loot,itemName) ~= "Coyote Backpack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",64)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Ghillie Backpack" then
	if getElementData(localPlayer,"MAX_Slots") == 45 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 45 then
		if itemName ~= "Ghillie Backpack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",45)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0	
elseif itemName == "OS Backpack" then
	if getElementData(localPlayer,"MAX_Slots") == 100 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 100 then
		if getElementData(loot,itemName) ~= "OS Backpack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName,getElementData(loot,itemName)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",100)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
end
if not getElementData(getLocalPlayer(), itemName) then
	setElementData(getLocalPlayer(), itemName, itemPlus)
else
	setElementData(getLocalPlayer(), itemName, getElementData(localPlayer, itemName )+itemPlus)
end
if itemPlus == 0 then
	setElementData(loot, itemName, getElementData(loot, itemName) - 0)
else
	setElementData(loot, itemName, getElementData(loot, itemName) - 1)
end
local players = getElementsWithinColShape(loot, "player")
if #players > 1 then
	triggerServerEvent("onPlayerChangeLoot", getRootElement(), loot)
end
if getElementData(loot, "itemloot") then
	triggerServerEvent("refreshItemLoot", getRootElement(), loot, getElementData(loot, "parent"))
end
end
addEvent("onPlayerMoveItemInInventory", true)
addEventHandler("onPlayerMoveItemInInventory", getRootElement(), onPlayerMoveItemInInventory)

function onClientOpenInventoryStopMenu()
  triggerEvent("disableMenu", getLocalPlayer())
end

function isPlayerInLoot()
	if getElementData(getLocalPlayer(), "loot") then
		return getElementData(getLocalPlayer(), "currentCol")
	end
	return false
end


function getInventoryInfosForRightClickMenu(itemName)
	for i,itemInfo in ipairs(inventoryItems["Food"]) do
		if itemName == itemInfo[1] then
			if itemInfo[1] == "Water Bottle" or itemInfo[1] == "Milk" or itemInfo[1] == "Soda Bottle" then
				info = "Drink"
			else
				info = "Eat"
			end
			return itemName, info 
		end
	end
	for i,itemInfo in ipairs(inventoryItems["Items"]) do
		if itemName == itemInfo[1] then
			if #itemInfo >= 8 then
				return itemName, itemInfo[8]
			end
			break
		end
	end
	for i,itemInfo in ipairs(inventoryItems["Toolbelt"]) do
		if itemName == itemInfo[1] then
			if #itemInfo >= 8 then
				return itemName, itemInfo[8]
			end
			break
		end
	end
	return itemName, false
end

local playerFire = {}
local fireCounter = 0
function playerUseItem(itemName,itemInfo)
	if itemInfo == "Drink" then
		triggerServerEvent("onPlayerRequestChangingStats",getLocalPlayer(),itemName,itemInfo,"thirst")
	elseif itemInfo == "Eat" then
		triggerServerEvent("onPlayerRequestChangingStats",getLocalPlayer(),itemName,itemInfo,"food")	
	elseif itemInfo == "Put clothes on" then
		triggerServerEvent("onPlayerChangeSkin",getLocalPlayer(),itemName)
	elseif itemName == "Empty Water Bottle" then
		triggerServerEvent("onPlayerRefillWaterBottle",getLocalPlayer(),itemName)		
	elseif itemName == "Tent" then
		triggerServerEvent("onPlayerPitchATent",getLocalPlayer(),itemName)
	elseif itemInfo == "Build a wire fence"	then
		triggerServerEvent("onPlayerBuildAWireFence",getLocalPlayer(),itemName)
	elseif itemName == "Roadflare" then
		triggerServerEvent("onPlayerPlaceRoadflare",getLocalPlayer(),itemName)	
	elseif itemInfo == "Make a Fire" then
		if getElementData (getLocalPlayer(),"Wood Pile") > 0 then
			triggerServerEvent("onPlayerMakeAFire", getLocalPlayer(), itemName)
		else
			triggerEvent("displayClientInfo", getLocalPlayer(), "Matches", "You need a Wood Pile!", 22, 255, 0)
		end	
	elseif itemInfo == "Use" then
		triggerServerEvent("onPlayerUseMedicObject",getLocalPlayer(),itemName)
    elseif itemInfo == "Heat" then
        triggerServerEvent("onPlayerUseMedicObject",getLocalPlayer(),itemName)
    elseif itemInfo == "Painkiller" then
        triggerServerEvent("onPlayerUseMedicObject",getLocalPlayer(),itemName)
    elseif itemInfo == "Morphine" then
        triggerServerEvent("onPlayerUseMedicObject",getLocalPlayer(),itemName)
    elseif itemName == "Bandage" then
        triggerServerEvent("onPlayerUseMedicObject",getLocalPlayer(),itemName)  
    elseif itemInfo == "Use Googles" then
        triggerServerEvent("onPlayerChangeView",getLocalPlayer(),itemName)  
    elseif itemInfo == "Equip Primary Weapon" then
        triggerServerEvent("onPlayerRearmWeapon",getLocalPlayer(),itemName,1)
    elseif itemInfo == "Equip Secondary Weapon" then
        triggerServerEvent("onPlayerRearmWeapon",getLocalPlayer(),itemName,2)
    elseif itemInfo == "Equip Special Weapon" then
        triggerServerEvent("onPlayerRearmWeapon",getLocalPlayer(),itemName,3)
	elseif itemInfo == "Craft" then
		setElementData(localPlayer,"selectedBlueprint",itemName)
		checkComponents()
	end
end

weaponAmmoTable = {

[".45 ACP Cartridge"] = {
{"M1911",22},
{"Desert Eagle",24},
{"Revolver",24},
},

["9x19mm SD Cartridge"] = {
{"M9 SD",23},
},

["9x19mm Cartridge"] = {
{"PDW",28},
},

["9x18mm Cartridge"] = {
{"MP5A5",29},
{"Bizon PP-19",29},
},

["5.45x39mm Cartridge"] = {
{"AK-47",30},
{"FN FAL",30},
{"G36C",30},
{"Sa58V CCO",30},
},

["5.56x45mm Cartridge"] = {
{"M4",31},
},

["1866 Slug"] = {
{"Winchester 1866",25},
},

["2Rnd. Slug"] = {
{"Sawn-Off Shotgun",26},
{"Blaze 95 Double Rifle",25},
},

["12 Gauge Pellet"] = {
{"SPAZ-12 Combat Shotgun",27},
{"Remington 870",27},
},

["9.3x62mm Cartridge"] = {
{"CZ 550",34},
{"DMR",34},
{"SVD Dragunov",34},
},

[".303 British Cartridge"] = {
{"Lee Enfield",33},
{"Sporter 22",33},
{"Mosin 9130",33},
{"SKS",33},
},

["M136 Rocket"] = {
{"Heat-Seeking RPG",36},
{"M136 Rocket Launcher",35},
},

["Bolt"] = {
{"Crossbow",25},
},

["others"] = {
{"Parachute",46},
{"Satchel",39},
{"Tear Gas",17},
{"Grenade",16},
{"Hunting Knife",4},
{"Hatchet",8},
{"Binoculars",43},
{"Baseball Bat",5},
{"Shovel",6},
{"Golf Club",2},
{"Machete",8},
{"Crowbar",2},
},
}

function getWeaponAmmoTypeName (weaponName)
    for i,weaponData in ipairs(weaponAmmoTable["others"]) do
        if weaponName == weaponData[1] then
            return weaponData[1],weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".45 ACP Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm SD Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm SD Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.56x45mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
        if weaponName == weaponData[1] then
            return "1866 Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge Pellet"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge Pellet",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
        if weaponName == weaponData[1] then
            return "2Rnd. Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9.3x62mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9.3x62mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
        if weaponName == weaponData[1] then
            return "M136 Rocket",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponName == weaponData[1] then
			return "Bolt",weaponData[2]
		end
	end
end

function getWeaponAmmoType2 (weaponName)
	for i,weaponData in ipairs(weaponAmmoTable["others"]) do
		if weaponName == weaponData[2] then
			return weaponData[1],weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable[".45 ACP Cartridge"]) do
        if weaponName == weaponData[2] then
            return ".45 ACP Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm SD Cartridge"]) do
        if weaponName == weaponData[2] then
            return "9x19mm SD Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponName == weaponData[2] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponName == weaponData[2] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponName == weaponData[2] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponName == weaponData[2] then
            return "5.56x45mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
        if weaponName == weaponData[2] then
            return "1866 Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge Pellet"]) do
        if weaponName == weaponData[2] then
            return "12 Gauge Pellet",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
        if weaponName == weaponData[2] then
            return "2Rnd. Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9.3x62mm Cartridge"]) do
        if weaponName == weaponData[2] then
            return "9.3x62mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponName == weaponData[2] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
        if weaponName == weaponData[2] then
            return "M136 Rocket",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponName == weaponData[2] then
			return "Bolt",weaponData[2]
		end
	end
end

function weaponSwitch (weapon)
	if source == getLocalPlayer() then
		local ammoName,_ = getWeaponAmmoType2 (weapon)
		if getElementData(getLocalPlayer(),"Bolt") > 0 then
			if getElementData(getLocalPlayer(),"currentweapon_1") == "Crossbow" then
				setElementData(getLocalPlayer(),"Bolt",getElementData(getLocalPlayer(),"Bolt")-1)
			else return
			end
		end
		if getElementData(getLocalPlayer(),ammoName) > 0 then
			setElementData(getLocalPlayer(),ammoName,getElementData(getLocalPlayer(),ammoName)-1)
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), weaponSwitch )

--[[
function weaponDegrade(weapon)
local getCurrentMainWeapon = getElementData(localPlayer,"currentweapon_1")
local getCurrentSecondaryWeapon = getElementData(localPlayer,"currentweapon_2")

	if source == localPlayer then
		return
	end
end
]]

setRadioChannel(0)

function makeRadioStayOff()
	setRadioChannel(0)
	cancelEvent()
end
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)



-- [[ BLUEPRINTS CODE ]] --
--[[

Stuff to do:

- Player must not move while crafting, or else crafting will cancel (Animation?)
- Are the requirements too high/too low? Needs extensive testing!
- More Blueprint Parts

]]


craftingTable = {

-- {string Blueprint Name, string Blueprint Result, int Result Number, string Part1, string Part2, string Part3, int Part1Required, int Part2Required, int Part3Required, int CraftingTime},
--[[ 
Note that for CraftingTime, the progress bar is increased by +1 every milliseconds at which CraftingTime has been specified 
(if it's set to 1000, the progress bar will be increased by 1 every second, if it's set to 60000, every 60 seconds) 
]]
--  [[ PRIMARY WEAPONS ]] --
{"M4 Blueprint","M4",1,"Gun Barrel","Gun Stock","Nails",1,1,2,500},
{"CZ 550 Blueprint","CZ 550",1,"Gun Barrel","Gun Stock","Optics",1,1,1,10000},
{"Winchester '66 Blueprint","Winchester 1866",1,"Gun Barrel","Gun Stock","Duct Tape",2,1,4,3000},
{"SPAZ-12 C. Shtgn. Blueprint","SPAZ-12 Combat Shotgun",1,"Gun Barrel","Gun Stock","Duct Tape",2,1,4,3000},
{"Sawn-Off Shtgn. Blueprint","Sawn-Off Shotgun",1,"Gun Barrel","Gun Stock","Duct Tape",2,2,2,3000},
{"AK-47 Blueprint","AK-47",1,"Gun Barrel","Gun Stock","Nails",1,1,2,5000},
{"Lee Enfield Blueprint","Lee Enfield",1,"Gun Barrel","Gun Stock","Duct Tape",1,1,2,7000},
{"Sporter 22 Blueprint","Sporter 22",1,"Gun Barrel","Gun Stock","Duct Tape",1,1,2,7000},
{"Mosin 9130 Blueprint","Mosin 9130",1,"Gun Barrel","Gun Stock","Duct Tape",1,1,2,7000},
{"Crossbow Blueprint","Crossbow",1,"String","Handle","Wooden Stick",2,1,2,10000},
{"SKS Blueprint","SKS",1,"Gun Barrel","Gun Stock","Duct Tape",1,1,2,7000},
{"Blaze 95 D. R. Blueprint","Blaze 95 Double Rifle",1,"Gun Barrel","Gun Stock","Duct Tape",2,1,4,3000},
{"Remington 870 Blueprint","Remington 870",1,"Gun Barrel","Gun Stock","Duct Tape",2,1,4,3000},
{"FN FAL Blueprint","FN FAL",1,"Gun Barrel","Gun Stock","Nails",1,1,2,5000},
{"G36C Blueprint","G36C",1,"Gun Barrel","Gun Stock","Nails",1,1,2,5000},
{"Sa58V CCO Blueprint","Sa58V CCO",1,"Gun Barrel","Gun Stock","Nails",1,1,2,5000},
{"SVD Dragunov Blueprint","SVD Dragunov",1,"Gun Barrel","Gun Stock","Optics",1,1,1,10000},
{"DMR Blueprint","DMR",1,"Gun Barrel","Gun Stock","Optics",1,1,1,10000},

-- [[ SECONDARY WEAPONS ]] --
{"M1911 Blueprint","M1911",1,"Short Gun Barrel","Gun Stock","Nails",1,1,2,700},
{"M9 SD Blueprint","M9 SD",1,"Short Gun Barrel","Gun Stock","Metallic Stick",1,1,1,900},
{"PDW Blueprint","PDW",1,"Short Gun Barrel","Gun Stock","Nails",1,1,2,700},
{"G17 Blueprint","G17",1,"Short Gun Barrel","Gun Stock","Glue",1,1,2,700},
{"MP5A5 Blueprint","MP5A5",1,"Short Gun Barrel","Gun Stock","Duct Tape",1,1,2,1200},
{"Bizon PP-19 Blueprint","Bizon PP-19",1,"Short Gun Barrel","Gun Stock","Duct Tape",1,1,2,1200},
{"Revolver Blueprint","Revolver",1,"Short Gun Barrel","Gun Stock","Nails",1,1,3,900},
{"Desert Eagle Blueprint","Desert Eagle",1,"Short Gun Barrel","Gun Stock","Nails",1,1,3,900},
{"Hunting Knife Blueprint","Hunting Knife",1,"Handle","Sharp Metal","Glue",1,1,1,200},
{"Hatchet Blueprint","Hatchet",1,"Handle","Metal Plate","Barbed Wire",1,1,1,3000},
{"Baseball Bat Blueprint","Baseball Bat",1,"Wooden Stick","Nails","Glue",1,1,1,200},
{"Shovel Blueprint","Shovel",1,"Wooden Stick","Metal Plate","Nails",1,1,2,700},
{"Golf Club Blueprint","Golf Club",1,"Metallic Stick","Metal Plate","Barbed Wire",1,1,1,700},
{"Machete Blueprint","Machete",1,"Handle","Sharp Metal","Glue",1,2,2,3000},
{"Crowbar Blueprint","Crowbar",1,"Metallic Stick","Hand Saw","Duct Tape",1,1,1,1200},

-- [[ SPECIAL WEAPONS ]] --
{"Parachute Blueprint","Parachute",1,"String","Cloth","Sheet",4,2,2,2000},
{"Tear Gas Blueprint","Tear Gas",1,"Glue","Small Casing","String",2,1,1,2000},
{"Grenade Blueprint","Grenade",1,"Small Casing","Gun Powder","Cables",1,4,1,2000},
{"Binoculars Blueprint","Binoculars",1,"Optics","Small Box","Glue",2,1,1,2000},

-- [[ AMMO ]] --
{".45 ACP Cartridge Blueprint",".45 ACP Cartridge",1,"Small Casing","Gun Powder","Glue",1,1,1,500},
{"9x19mm SD Cartridge Blueprint","9x19mm SD Cartridge",1,"Small Casing","Gun Powder","Glue",1,1,1,500},
{"9x19mm Cartridge Blueprint","9x19mm Cartridge",1,"Small Casing","Gun Powder","Glue",1,1,1,500},
{"9x18mm Cartridge Blueprint","9x18mm Cartridge",1,"GSmall Casing","Gun Powder","Glue",1,1,1,500},
{"5.45x39mm Cartridge Blueprint","5.45x39mm Cartridge",1,"Small Casing","Gun Powder","Glue",1,3,1,500},
{"5.56x45mm Cartridge Blueprint","5.56x45mm Cartridge",1,"Small Casing","Gun Powder","Glue",1,3,1,500},
{"1866 Slug Blueprint","1866 Slug",1,"Small Casing","Gun Powder","Glue",1,2,1,500},
{"2Rnd. Slug Blueprint","2Rnd. Slug",1,"Small Casing","Gun Powder","Glue",1,2,1,500},
{"12 Gauge Pellet Blueprint","12 Gauge Pellet",1,"Small Casing","Gun Powder","Glue",1,2,1,500},
{"9.3x62mm Cartridge Blueprint","9.3x62mm Cartridge",1,"Small Casing","Gun Powder","Glue",1,4,1,500},
{".303 British Cartridge Blueprint",".303 British Cartridge",1,"Small Casing","Gun Powder","Glue",1,2,1,500},
{"Bolt Blueprint","Bolt",1,"Wooden Stick","Sharp Metal","Hand Saw",2,1,1,500},

-- [[ ITEMS ]] --
{"Medic Kit Blueprint","Medic Kit",1,"Drugs","Vitamins","Bandaid",2,2,1,3400},
{"Wire Fence Blueprint","Wire Fence",1,"Barbed Wire","Wooden Stick","Duct Tape",1,2,1,3400},
{"Tent Blueprint","Tent",1,"String","Sheet","Wooden Stick",1,2,1,3400},
{"Camouflage Clthng. Blueprint","Camouflage Clothing",1,"Thread","Cloth","Needle",3,1,1,8400},
{"Survivor Clthng. Blueprint","Survivor Clothing",1,"Thread","Cloth","Needle",3,1,1,8400},
{"Civilian Clthng. Blueprint","Civilian Clothing",1,"Thread","Cloth","Needle",3,1,1,8400},
{"Ghillie Suit Blueprint","Ghillie Suit",1,"Thread","Cloth","Needle",3,3,2,16800},
{"Roadflare Blueprint","Roadflare",1,"Small Box","Gun Powder","Tissue",1,1,1,1200},

--[[ TOOLBELT ]] --
{"Toolbox Blueprint","Toolbox",1,"Mechanical Supplies","Small Box","Hand Saw",1,1,1,600},
{"Radio Device Blueprint","Radio Device",1,"Microchips","Small Box","Mechanical Supplies",2,1,1,600},
{"Infrared Goggles Blueprint","Infrared Goggles",1,"Optics","Microchips","Glue",2,4,1,2000},
{"Night Vision Goggles Blueprint","Night Vision Goggles",1,"Optics","Microchips","Glue",2,4,1,2000},

}

-- [[ We initialize the crafting process ]] --
selectedBlueprint = ""		-- The blueprint that will be used (equals data[1])
craftedItem = ""			-- The end result of the crafting process (equals data[2])
craftedAmount = 0			-- The amount of craftedItem (equals data[3])
craftingTime = 0			-- How long will the item take to craft? (equals data[10])
ComponentA = ""				-- Component A (equals data[4])
ComponentB = ""				-- Component B (equals data[5])
ComponentC = ""				-- Component C (equals data[6])
ComponentA_Amount = ""		-- Amount for A (equals data[7])
ComponentB_Amount = ""		-- Amount for B (equals data[8])
ComponentC_Amount = ""		-- Amount for C (equals data[9])
crafted = false				-- Has the item been crafted?
isCrafting = false			-- Is the player crafting already?


-- [[ Using the assigned variables, we now craft the item ]] --
function craftItem()
	if getElementData(localPlayer,ComponentA) >= ComponentA_Amount then
		if getElementData(localPlayer,ComponentB) >= ComponentB_Amount then
			if getElementData(localPlayer,ComponentC) >= ComponentC_Amount then
				if not isCrafting then
					triggerEvent("onStartCraftingTimer",localPlayer)
					if crafted then
						startRollMessage2("Crafting","Item has been crafted!",0,255,0)
						setElementData(localPlayer,craftedItem,getElementData(localPlayer,craftedItem)+craftedAmount)
						setElementData(localPlayer,selectedBlueprint,getElementData(localPlayer,selectedBlueprint)-1)
						setElementData(localPlayer,ComponentA,getElementData(localPlayer,ComponentA)-ComponentA_Amount)
						setElementData(localPlayer,ComponentB,getElementData(localPlayer,ComponentB)-ComponentB_Amount)
						setElementData(localPlayer,ComponentC,getElementData(localPlayer,ComponentC)-ComponentC_Amount)
						craftingTime = 0
						crafted = false
						destroyElement(craftingBar)
						killTimer(craftingTimer)
						isCrafting = false
					else
						startRollMessage2("Crafting","Item is being crafted...",0,0,255)
					end
				else
					startRollMessage2("Crafting","You are crafting already!",255,0,0)
				end
			else
				startRollMessage2("Crafting","Not enough components! ("..ComponentC..")",255,0,0)
				return
			end
		else
			startRollMessage2("Crafting","Not enough components! ("..ComponentB..")",255,0,0)
			return
		end
	else
		startRollMessage2("Crafting","Not enough components! ("..ComponentA..")",255,0,0)
		return
	end
end
addEvent("onPlayerStartCrafting",true)
addEventHandler("onPlayerStartCrafting",root,craftItem)

-- [[ First we check if the player has all components, and if he has, assign the respective item ]] --
function checkComponents()
local getSelectedBlueprint = getElementData(localPlayer,"selectedBlueprint")
	for i,data in ipairs(craftingTable) do
		if getSelectedBlueprint == data[1] then
			selectedBlueprint = data[1]
			craftedItem = data[2]
			craftedAmount = data[3]
			ComponentA = data[4]
			ComponentB = data[5]
			ComponentC = data[6]
			ComponentA_Amount = data[7]
			ComponentB_Amount = data[8]
			ComponentC_Amount = data[9]
			craftingTime = data[10]
			triggerEvent("onPlayerStartCrafting",localPlayer)
			break
		end
	end
end

-- [[ Creates a progress bar for crafting ]] --
function onStartCraftingTimer()
	if isElement(craftingBar) then
		return
	else
		craftingBar = guiCreateProgressBar(0.35,0.9,0.3,0.05,true)
		guiProgressBarSetProgress(craftingBar,0)
		craftingTimer = setTimer(increaseTimer,craftingTime,0)
		craftingsound = playSound("sounds/crafting.mp3",false)
		isCrafting = true
		
	end
end
addEvent("onStartCraftingTimer",true)
addEventHandler("onStartCraftingTimer",localPlayer,onStartCraftingTimer)

-- [[ Increasing the progress bar status until it's 100 ]] --
function increaseTimer()
	if guiProgressBarGetProgress(craftingBar) >= 100 then
		if getPlayerCurrentSlots() --[[+ getItemSlots(itemName) ]] >= getPlayerMaxAviableSlots() then
			setTimer(startRollMessage2("Crafting","Inventory is full!",255,0,0),100,1)
			crafted = false
			destroyElement(craftingBar)
			destroyElement(secondsleftlabel)
			killTimer(craftingTimer)
			return
		else
			crafted = true
			isCrafting = false
			craftItem()
			return
		end
	else
		guiProgressBarSetProgress(craftingBar,guiProgressBarGetProgress(craftingBar)+1)
	end
end