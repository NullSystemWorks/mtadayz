--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script inventory.lua				*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

inventoryItems = {
["Weapons"] = {
["Primary Weapon"] = {
{"M4",10, 'm4.png', 256, 128,"Assault Rifle", "Ammunition: 5.56x45mm Cartridge"},
{"CZ 550",10, 'cz550.png', 256,128,"Sniper", "Ammunition: 9.3x62mm Cartridge"},
{"Winchester 1866",10, 'winchester.png', 256, 128 ,"Shotgun", "Ammunition: 1866 Slug"},
{"SPAZ-12 Combat Shotgun",10, 'spaz.png', 256, 128 ,"Shotgun", "Ammunition: 12 Gauge Pellet"},
{"Sawn-Off Shotgun",10, 'sawn.png', 256, 128,"Shotgun", "Ammunition: 2Rnd. Slug"},
{"AK-47",10, 'ak47.png', 256, 128 ,"Assault Rifle", "Ammunition: 5.45x39mm Cartridge"},
{"Lee Enfield",10, 'enfield.png', 256, 128,"Repeating Rifle", "Ammunition: .303 British Cartridge"},
{"Sporter 22",10,'enfield.png',256,128,"Repeating Rifle","Ammunition: .303 British Cartridge"},
{"Mosin 9130",10,'enfield.png',256,128,"Repeating Rifle","Ammunition: .303 British Cartridge"},
{"Crossbow",10,'crossbow.png',128,128,"Crossbow","Ammunition: Bolt"},
{"SKS",10,'enfield.png',256,128,"Repeating Rifle","Ammunition: .303 British Cartridge"},
{"Blaze 95 Double Rifle",10,'spaz.png',256,128,"Shotgun","Ammunition: 2Rnd. Slug"},
{"Remington 870",10,'remington.png',256,128,"Shotgun","Ammunition: 12 Gauge Pellet"},
{"FN FAL",10,'fnfal.png',256,128,"Assault Rifle","Ammunition: 5.45x39mm Cartridge"},
{"G36C",10,'g36c.png',256,128,"Assault Rifle","Ammunition: 5.45x39mm Cartridge"},
{"Sa58V CCO",10,'sa58v.png',256,128,"Assault Rifle","Ammunition: 5.45x39mm Cartridge"},
{"SVD Dragunov",10,'svd.png',256,128,"Sniper","Ammunition: 9.3x62mm Cartridge"},
{"DMR",10,'dmr.png',256,128,"Sniper","Ammunition: 9.3x62mm Cartridge"},
},

["Secondary Weapon"] = {
{"M1911",5, 'm1911.png', 128, 128,"Handgun", "Ammunition: .45 ACP Cartridge"},
{"M9 SD",5, 'm9sd.png', 128, 128,"Handgun", "Ammunition: 9x19mm SD Cartridge"},
{"PDW",5, 'pdw.png', 128, 128,"Sub-Machine Gun", "Ammunition: 9x19mm Cartridge"},
{"G17",5,'g17.png',128,128,"Handgun","You shouldn't have this."},
{"MP5A5",5, 'mp5a5.png', 128, 128,"Sub-Machine Gun", "Ammunition: 9x18mm Cartridge"},
{"Desert Eagle",5, 'revolver.png',128,128,"Handgun","Ammunition: .45 ACP Cartridge"},
{"Bizon PP-19",5,'bizon.png',128,128,"Sub-Machine Gun","Ammunition: 9x18mm Cartridge"},
{"Revolver",5,'revolver.png',128,128,"Handgun","Ammunition: .45 ACP Cartridge"},
{"Hunting Knife",5, 'knife.png',128,128,"Melee", "Ammunition: None"},
{"Hatchet",5, 'hatchet.png',128,128,"Melee", "Ammunition: None"},
{"Baseball Bat",5, 'bat.png', 128,128,"Melee", "Ammunition: None"},
{"Shovel",5, 'shovel.png', 128, 128,"Melee", "Ammunition: None"},
{"Golf Club",5, 'golf.png', 128, 128,"Melee", "Ammunition: None"},
{"Machete",5, 'machete.png',128,128,"Melee","<DEV WEAPON>\nDamage: 12500"},
{"Crowbar",5, 'crowbar.png',128,128,"Melee","Ammunition: None"},
},

["Specially Weapon"] = {
{"Parachute",1, 'parachute.png', 128,128,"Item", "Equip to use."},
{"Tear Gas",1, 'gas.png', 128, 128,"Item", "You shouldn't have this."},
{"Grenade",5, 'grenade.png', 128, 128,"Item", "Extremely deadly and extremely noisy."},
{"Binoculars",1, 'binoculars.png', 128, 128,"Item", "Click item to equip."}
},

},
["Ammo"] = {
{".45 ACP Cartridge",0.085, '45acp.png',128,128,"Ammunition", "For:\nM1911\nDesert Eagle\nRevolver"},
{"9x19mm SD Cartridge",0.085, '9x19sd.png',128,128,"Ammunition", "For:\nM9 SD"},
{"9x19mm Cartridge",0.025, '9x19.png',128,128,"Ammunition", "For:\nPDW"},
{"9x18mm Cartridge",0.025, '9x18.png',128,128,"Ammunition", "For:\nMP5A5\nBizon PP-19"},
{"5.45x39mm Cartridge",0.035, 'ak.png',128,128,"Ammunition", "For:\nAK-47\nG36C\nFN FAL"},
{"5.56x45mm Cartridge",0.035, 'm4.png',128,128,"Ammunition", "For:\nM4"},
{"1866 Slug",0.067, 'shotgun.png',128,128,"Ammunition", "For:\nWinchester 1866"},
{"2Rnd. Slug",0.067, 'shotgun.png',128,128,"Ammunition", "For:\nSawn-Off Shotgun\nBlaze 95 Double Rifle"},
{"12 Gauge Pellet",0.067, 'shotgun.png',128,128,"Ammunition", "For:\nSPAZ-12 C. Shotgun\nRemington 870"},
{"9.3x62mm Cartridge",0.1, 'sniper.png',128,128,"Ammunition", "For:\nCZ 550\nDMR\nSVD Dragunov"},
{".303 British Cartridge",0.1, 'british.png',128,128,"Ammunition", "For:\nLee Enfield\nSporter 22\nMosin 9130\nSKS"},
{"Bolt",0.1,'arrow.png',128,128,"Ammunition","For:\nCrossbow"},
},

["Food"] = {
{"Baked Beans",1,'bakedbeans.png',128,128,"Food", "Canned Baked Beans used for sustainment.\nLasts well over five years if stored \ncorrectly."},
{"Pasta",1,'pasta.png',128,128,"Food", "Canned Pasta used for sustainment.\nLasts well over five years if stored \ncorrectly."},
{"Sardines",1,'sardines.png',128,128,"Food", "Canned Sardines used for sustainment.\nLasts well over five years if stored \ncorrectly."},
{"Frank & Beans",1,'frankbeans.png',128,128,"Food","Canned Frank & Beans used for sustainment.\nLasts well over five years if stored \ncorrectly."},
{"Can (Corn)",1,'corn.png',128,128,"Food", "A clean, unopened tin can of corn."},
{"Can (Peas)",1,'peas.png',128,128,"Food", "A clean, unopened tin can of peas."},
{"Can (Pork)",1,'pork.png',128,128,"Food", "A clean, unopened tin can of pork."},
{"Can (Stew)",1,'stew.png',128,128,"Food", "A clean, unopened tin can of beef stew."},
{"Can (Ravioli)",1,'ravioli.png',128,128,"Food", "A clean, unopened tin can of ravioli."},
{"Can (Fruit)",1,'fruit.png',128,128,"Food", "A clean, unopened tin can of mixed fruits."},
{"Can (Chowder)",1,'chowder.png',128,128,"Food", "A clean, unopened tin can of clam chowder."},
{"MRE",1,'mre.png', 128, 128,"Food", "Meal Ready-to-Eat."},
{"Pistachios",1,'pistachios.png', 128, 128,"Food", "A pack of pistachios, roasted and salted."},
{"Trail Mix",1,'trailmix.png', 128, 128,"Food", "Contains twelve different fruits and nuts."},
{"Cooked Meat",1, 'cookedmeat.png',128,128,"Food", "Meat that has been cooked over a fire."},
{"Water Bottle",1, 'bottle.png', 128, 128,"Drink", "A bottle of water that has been\nfiltered and can be consumed."},
{"Soda Can (Pepsi)",1,'pepsi.png', 128, 128,"Drink", "An aluminium can containing a tasty\ncarbonated beverage full of sugar,\nartificial flavors, and preservatives."},
{"Soda Can (Cola)",1,'cola.png', 128, 128,"Drink", "An aluminium can containing a tasty\ncarbonated beverage full of sugar,\nartificial flavors, and preservatives."},
{"Soda Can (Mountain Dew)",1,'dew.png', 128, 128,"Drink", "An aluminium can containing a tasty\ncarbonated beverage full of sugar,\nartificial flavors, and preservatives."},
{"Can (Milk)",1,'milkcan.png',128,128,"Drink", "An aluminium can containing a tasty\ncarbonated beverage full of sugar,\nartificial flavors, and preservatives."},
},

["Items"] = {
{"Wood Pile",2, 'wood.png',128,128,"Item", "A small pile of freshly chopped\nwood that can be used for making\na fireplace and various other things."},
{"Bandage",1, 'bandage.png', 128, 128, "Item", "Joint Services standard first aid dressing.\nUsed to stop bleeding of wounds.","Bandage yourself"},
{"Road Flare",1, 'roadflare.png', 128, 128, "Item", "Hand operated flare commonly found\n in roadside emergency kits. Will burn\n for approximately five minutes.","Place"},
{"Empty Gas Canister",3, 'canister.png', 128, 128,"Item", "20L Jerry Can that can be used for\nrefuelling vehicles and powering generators.\nIt's empty."},
{"Full Gas Canister",3, 'canister.png', 128, 128,"Item", "20L Jerry Can that can be used for\nrefuelling vehicles and powering generators."},
{"Medic Kit",2, 'chest.png', 128, 128, "Item", "<You shouldn't have this.>","Use"},
{"Heat Pack",1, 'heatpack.png', 128, 128, "Item", "A heating pad that heats when you\nstart the crystallisation process.\nUsed to provide quick warmth to your body.","Use"},
{"Painkiller",1, 'painkillers.png', 128, 128, "Item", "A moderate painkiller suitable\nfor regular use of relief of pain\nand inflammation caused by moderate \nwounds.","Use"},
{"Morphine",1, 'morphine.png',128,128,"Item", "Used for intramuscular injection to manage\nsevere pain such as those from fractures.","Use"},
{"Blood Bag",1, 'bloodbag.png', 128, 85, "Item", "Bag of blood used for administering\na blood transfusion.","Use"},
{"Wire Fence", 1, 'wirefence.png', 128, 128, "Item", "Razor wire in large coils which\ncan be expanded like a concertina with\nsteel pickets to form military wire obstacles.","Build a wire fence"}, 
{"Raw Meat", 1, 'rawmeat.png', 128, 128,"Item", "Raw meat gutted from an animal."}, 
{"Tire", 2, 'wheel.png', 128, 128,"Item", "An old car wheel that could be\nused to repair a vehicle with a broken one."}, 
{"Engine", 5, 'engine.png', 128,128,"Item", "Engine components with oil and lubricant.\nEverything you would need to repair an engine.",}, 
{"Tank Parts", 3, 'engine_part.png', 128,128,"Item", "An old fuel tank that could be used\nto repair a vehicle with a broken one."},
{"Tent", 3, 'tent.png', 128, 128, "Item", "A camping tent that can be pitched,\nallowing you extended storage\nsafe from others.","Pitch a tent"}, 
{"Camouflage Clothing",1,'clothes.png',128,128,"Item","A mixture of camouflage trousers\n with a brown t-shirt and no hat.\nCan be unpacked and worn.","Put clothes on"},
{"Civilian Clothing",1,'clothes.png',128,128,"Item","A normal mixture of civilian clothing\n with a light-weight vest and hat.\nCan be unpacked and worn.","Put clothes on"},
{"Survivor Clothing",1,'clothes.png',128,128,"Item","Use to 'adorn' yourself\nwith new clothes.","Put clothes on"},
{"Ghillie Suit",1,'clothes.png',128,128,"Item","A type of camouflage clothing\ndesigned to resemble heavy foliage.\nCan be unpacked and worn.","Put clothes on"},
{"Empty Water Bottle", 1, 'emptybottle.png', 128, 128,"Item", "A bottle of water that has been\nfiltered and can be consumed.\nIt's empty, though.", "Fill bottle up"}, 
{"Empty Soda Can", 1,'emptysoda.png', 128, 128,"Item", "A aluminium can that once contained\na tasty carbonated beverage,\nand now contains nothing."}, 
{"Assault Pack (ACU)",1,'acu.png',170,170,"Item", "Gives you +12 slots."},
{"Czech Vest Pouch",1,'czechpouch.png',170,170,"Item", "Gives you +13 slots."},
{"ALICE Pack",1,'alice.png',170,170,"Item", "Gives you +16 slots."},
{"Survival ACU",1,'survival.png',170,170,"Item", "Gives you +17 slots."},
{"British Assault Pack",1,'britishpack.png',170,170,"Item", "Gives you +18 slots."},
{"Backpack (Coyote)",1,'coyote.png',170,170,"Item", "Gives +24 slots."},
{"Czech Backpack",1,'czech.png',170,170,"Item", "Gives +30 slots."},

-- [[ BLUEPRINTS ]] --
-- [ PRIMARY WEAPONS ] --
{"M4 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"CZ 550 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nOptics(x1)","Craft"},
{"Winchester '66 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x2)\nGun Stock(x1)\nDuct Tape(x4)","Craft"},
{"SPAZ-12 C. Shtgn. Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x2)\nGun Stock(x1)\nDuct Tape(x4)","Craft"},
{"Sawn-Off Shtgn. Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x2)\nGun Stock(x2)\nDuct Tape(x2)","Craft"},
{"AK-47 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"Lee Enfield Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nDuct Tape(x2)","Craft"},
{"Sporter 22 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nDuct Tape(x2)","Craft"},
{"Mosin 9130 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nDuct Tape(x2)","Craft"},
{"Crossbow Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x2)\nHandle(x1)\nWooden Stick(x2)","Craft"},
{"SKS Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nDuct Tape(x2)","Craft"},
{"Blaze 95 D. R. Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x2)\nGun Stock(x1)\nDuct Tape(x4)","Craft"},
{"Remington 870 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x2)\nGun Stock(x1)\nDuct Tape(x4)","Craft"},
{"FN FAL Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"G36C Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"Sa58V CCO Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"SVD Dragunov Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nOptics(x1)","Craft"},
{"DMR Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGun Barrel(x1)\nGun Stock(x1)\nOptics(x1)","Craft"},

-- [ SECONDARY WEAPONS ] --
{"M1911 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"M9 SD Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\Metallic Stick(x1)","Craft"},
{"PDW Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nNails(x2)","Craft"},
{"G17 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nGlue(x2)","Craft"},
{"MP5A5 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nDuct Tape(x2)","Craft"},
{"Bizon PP-19 Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nDuct Tape(x2)","Craft"},
{"Revolver Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nNails(x3)","Craft"},
{"Desert Eagle Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nShort Gun Barrel(x1)\nGun Stock(x1)\nNails(x3)","Craft"},
{"Hunting Knife Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nHandle(x1)\nSharp Metal(x1)\nGlue(x1)","Craft"},
{"Hatchet Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nHandle(x1)\nMetal Plate(x1)\nBarbed Wire(x1)","Craft"},
{"Baseball Bat Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:Wooden Stick\n(x1)\nNails(x1)\nGlue(x1)","Craft"},
{"Shovel Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nWooden Stick(x1)\nMetal Plate(x1)\nNails(x1)","Craft"},
{"Golf Club Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nMetallic Stick(x1)\nMetal Plate(x1)\nBarbed Wire(x1)","Craft"},
{"Machete Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nHandle(x1)\nSharp Metal(x2)\nGlue(x2)","Craft"},
{"Crowbar Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nMetallic Stick(x1)\nHand Saw(x1)\nDuct Tape(x1)","Craft"},

-- [ SPECIAL WEAPONS ] --
{"Parachute Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nString(x4)\nCloth(x2)\nSheet(x2)","Craft"},
{"Tear Gas Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nGlue(x2)\nSmall Casing(x1)\nString(x1)","Craft"},
{"Grenade Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x4)\nCables(x1)","Craft"},
{"Binoculars Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nOptics(x2)\nSmall Box(x1)\nGlue(x1)","Craft"},

-- [ AMMO BLUEPRINTS ] --
{".45 ACP Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"9x19mm SD Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"9x19mm Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"9x18mm Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"5.45x39mm Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"5.56x45mm Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"1866 Slug Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"2Rnd. Slug Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"12 Gauge Pellet Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"9.3x62mm Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{".303 British Cartridge Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Casing(x1)\nGun Powder(x2)\nGlue(x1)","Craft"},
{"Bolt Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nWooden Stick(x2)\nSharp Metal(x2)\nHand Saw(x1)","Craft"},

-- [ ITEMS BLUEPRINTS ] --
{"Medic Kit Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nDrugs(x2)\nVitamins(x2)\nBandaid(x1)","Craft"},
{"Wire Fence Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nBarbed Wire(x1)\nWooden Stick(x2)\nDuct Tape(x1)","Craft"},
{"Tent Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nString(x1)\nSheet(x2)\nWooden Stick(x1)","Craft"},
{"Camouflage Clthng. Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nThread(x3)\nCloth(x1)\nNeedle(x1)","Craft"},
{"Survivor Clthng. Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nThread(x3)\nCloth(x1)\nNeedle(x1)","Craft"},
{"Civilian Clthng. Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nThread(x3)\nCloth(x1)\nNeedle(x1)","Craft"},
{"Ghillie Suit Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nThread(x3)\nCloth(x3)\nNeedle(x2)","Craft"},
{"Road Flare Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nSmall Box(x1)\nGun Powder(x1)\nTissue(x1)","Craft"},

-- [ TOOLBELT BLUEPRINTS ] --
{"Toolbox Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nMechanical Supplies(x1)\nSmall Box(x1)\nHand Saw(x1)","Craft"},
{"Radio Device Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nMicrochips(x2)\nSmall Box(x1)\nMechanical Supplies(x1)","Craft"},
{"IR Goggles Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nOptics(x3)\nMicrochips(x4)\nGlue(x1)","Craft"},
{"NV Goggles Blueprint",1,'blueprint.png',128,128,"Blueprint","Components:\nOptics(x3)\nMicrochips(x4)\nGlue(x1)","Craft"},


-- [ BLUEPRINT PARTS ] --
{"Gun Barrel",1,'parts.png',128,128,"Used in:","Universal component for primary weapons."},
{"Short Gun Barrel",1,'parts.png',128,128,"Used in:","Universal component for secondary weapons."},
{"Gun Stock",1,'parts.png',128,128,"Used in:","Universal component for all guns."},
{"Thread",1,'parts.png',128,128,"Used in:","A thread. What did you expect?"},
{"Cloth",1,'parts.png',128,128,"Component","Can be used to craft various clothings."},
{"Gun Powder",1,'parts.png',128,128,"Component","Universal component for ammunition."},
{"Mechanical Supplies",1,'parts.png',128,128,"Component","Universal component for electronics."},
{"Cables",1,'parts.png',128,128,"Component","Universal component for electronics."},
{"Nails",1,'parts.png',128,128,"Component","Universal component used in various blueprints."},
{"Sheet",1,'parts.png',128,128,"Component","A sheet. What else did you expect?"},
{"Barbed Wire",1,'parts.png',128,128,"Component","Used for tactical consumables like the Wire Fence."},
{"Duct Tape",1,'parts.png',128,128,"Component","Universal component used for electronics."},
{"Glue",1,'parts.png',128,128,"Component","Universal component used for electronics."},
{"Drugs",1,'parts.png',128,128,"Component","Can be used for medical consumables."},
{"Bandaid",1,'parts.png',128,128,"Component","Can be used for medical consumables."},
{"Vitamins",1,'parts.png',128,128,"Component","Can be used for medical consumables."},
{"Tissue",1,'parts.png',128,128,"Component","Can be used for medical consumables."},
{"Small Box",1,'parts.png',128,128,"Component","A small box."},
{"String",1,'parts.png',128,128,"Component","A rather long string."},
{"Needle",1,'parts.png',128,128,"Component","A sharp instrument for sowing."},
{"Microchips",1,'parts.png',128,128,"Component","Can be used for electric consumables."},
{"Optics",1,'parts.png',128,128,"Component","Can be used for items like the binoculars."},
{"Sharp Metal",1,'parts.png',128,128,"Component","Piece of sharp metal.\nNot sharp enough to see usage\nas a weapon, though."},
{"Handle",1,'parts.png',128,128,"Component","A fine piece of handle."},
{"Wooden Stick",1,'parts.png',128,128,"Component","Some random stick found somewhere."},
{"Hand Saw",1,'parts.png',128,128,"Component","Commonly used on building lots."},
{"Metal Plate",1,'parts.png',128,128,"Component","A rather heavy metal plate."},
{"Metallic Stick",1,'parts.png',128,128,"Component","A metallic stick. Too short\nto be used as a weapon."},
{"Small Casing",1,'parts.png',128,128,"Component","A small casing to store things."},
},

["Toolbelt"] = {
{"NV Goggles", 1,'nvgoggles.png',128,128,"Item", "Press 'N' to activate."}, 
{"IR Goggles", 1,'nvgoggles.png',128,128,"Item", "Press 'I' to activate."}, 
{"Map", 1,'map.png',128,128,"Item", "Press 'F11' to activate."}, 
{"Box of Matches", 1, 'matchbox.png',100,100,"Item", "Use in combination with 'Wood Pile'\nto create a fire.", "Make a Fire"}, 
{"Watch", 1,'watch.png',128,128,"Item", "Passive item, will be\nactivated when picking up."}, 
{"GPS", 1,'gps.png',128,128,"Item", "Passive item, will be\nactivated when picking up."}, 
{"Toolbox", 1,'toolbox.png',128,128,"Item", "Used to repair cars\nof all kinds."}, 
{"Radio Device", 1,'radio.png',128,128,"Item", "Press 'Z' to activate."},
{"Compass",1,'compass.png',128,128,"Item","Passive item, will be\nactivated when picking up."},
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
	if getElementData(localPlayer,"MAX_Slots") == 12 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 12 then
		if getElementData(loot,itemName) ~= "Assault Pack (ACU)" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",12)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Czech Vest Pouch" then
	if getElementData(localPlayer,"MAX_Slots") == 13 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 13 then
		if getElementData(loot,itemName) ~= "Czech Vest Pouch" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",13)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "ALICE Pack" then
	if getElementData(localPlayer,"MAX_Slots") == 16 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 16 then
		if getElementData(loot,itemName) ~= "ALICE Pack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",16)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0	
elseif itemName == "Survival ACU" then
	if getElementData(localPlayer,"MAX_Slots") == 17 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 17 then
		if getElementData(loot,itemName) ~= "Survival ACU" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",17)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "British Assault Pack" then
	if getElementData(localPlayer,"MAX_Slots") == 18 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 18 then
		if itemName ~= "British Assault Pack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName2,getElementData(loot,itemName2)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",18)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0	
elseif itemName == "Backpack (Coyote)" then
	if getElementData(localPlayer,"MAX_Slots") == 24 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 24 then
		if getElementData(loot,itemName) ~= "Backpack (Coyote)" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName,getElementData(loot,itemName)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",24)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Czech Backpack" then
	if getElementData(localPlayer,"MAX_Slots") == 30 then
		setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)+1)
	end
	if getElementData(getLocalPlayer(),"MAX_Slots") > 30 then
		if getElementData(loot,itemName) ~= "Czech Backpack" then
			itemName2 = itemName
			setElementData(localPlayer,itemName2,getElementData(localPlayer,itemName2)+1)
			setElementData(loot,itemName,getElementData(loot,itemName)-1)
			return
		end
	end
	setElementData(getLocalPlayer(),"MAX_Slots",30)
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
			if itemInfo[1] == "Water Bottle" or itemInfo[1] == "Soda Can (Pepsi)" or itemInfo[1] == "Soda Can (Cola)" or itemInfo[1] == "Soda Can (Mountain Dew)" or itemInfo[1] == "Can (Milk)" then
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
	elseif itemName == "Road Flare" then
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
{"G17",22},
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
{"Road Flare Blueprint","Road Flare",1,"Small Box","Gun Powder","Tissue",1,1,1,1200},

--[[ TOOLBELT ]] --
{"Toolbox Blueprint","Toolbox",1,"Mechanical Supplies","Small Box","Hand Saw",1,1,1,600},
{"Radio Device Blueprint","Radio Device",1,"Microchips","Small Box","Mechanical Supplies",2,1,1,600},
{"IR Goggles Blueprint","IR Goggles",1,"Optics","Microchips","Glue",2,4,1,2000},
{"NV Goggles Blueprint","NV Goggles",1,"Optics","Microchips","Glue",2,4,1,2000},

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