--[[
Los Santos Customs V1.1 
Credits - MythicalBro
/////License/////
Do not reupload/re release any part of this script without my permission
]]
local colors = {
{name = "Black", colorindex = 0},{name = "Carbon Black", colorindex = 147},
{name = "Hraphite", colorindex = 1},{name = "Anhracite Black", colorindex = 11},
{name = "Black Steel", colorindex = 2},{name = "Dark Steel", colorindex = 3},
{name = "Silver", colorindex = 4},{name = "Bluish Silver", colorindex = 5},
{name = "Rolled Steel", colorindex = 6},{name = "Shadow Silver", colorindex = 7},
{name = "Stone Silver", colorindex = 8},{name = "Midnight Silver", colorindex = 9},
{name = "Cast Iron Silver", colorindex = 10},{name = "Red", colorindex = 27},
{name = "Torino Red", colorindex = 28},{name = "Formula Red", colorindex = 29},
{name = "Lava Red", colorindex = 150},{name = "Blaze Red", colorindex = 30},
{name = "Grace Red", colorindex = 31},{name = "Garnet Red", colorindex = 32},
{name = "Sunset Red", colorindex = 33},{name = "Cabernet Red", colorindex = 34},
{name = "Wine Red", colorindex = 143},{name = "Candy Red", colorindex = 35},
{name = "Hot Pink", colorindex = 135},{name = "Pfsiter Pink", colorindex = 137},
{name = "Salmon Pink", colorindex = 136},{name = "Sunrise Orange", colorindex = 36},
{name = "Orange", colorindex = 38},{name = "Bright Orange", colorindex = 138},
{name = "Gold", colorindex = 99},{name = "Bronze", colorindex = 90},
{name = "Yellow", colorindex = 88},{name = "Race Yellow", colorindex = 89},
{name = "Dew Yellow", colorindex = 91},{name = "Dark Green", colorindex = 49},
{name = "Racing Green", colorindex = 50},{name = "Sea Green", colorindex = 51},
{name = "Olive Green", colorindex = 52},{name = "Bright Green", colorindex = 53},
{name = "Gasoline Green", colorindex = 54},{name = "Lime Green", colorindex = 92},
{name = "Midnight Blue", colorindex = 141},
{name = "Galaxy Blue", colorindex = 61},{name = "Dark Blue", colorindex = 62},
{name = "Saxon Blue", colorindex = 63},{name = "Blue", colorindex = 64},
{name = "Mariner Blue", colorindex = 65},{name = "Harbor Blue", colorindex = 66},
{name = "Diamond Blue", colorindex = 67},{name = "Surf Blue", colorindex = 68},
{name = "Nautical Blue", colorindex = 69},{name = "Racing Blue", colorindex = 73},
{name = "Ultra Blue", colorindex = 70},{name = "Light Blue", colorindex = 74},
{name = "Chocolate Brown", colorindex = 96},{name = "Bison Brown", colorindex = 101},
{name = "Creeen Brown", colorindex = 95},{name = "Feltzer Brown", colorindex = 94},
{name = "Maple Brown", colorindex = 97},{name = "Beechwood Brown", colorindex = 103},
{name = "Sienna Brown", colorindex = 104},{name = "Saddle Brown", colorindex = 98},
{name = "Moss Brown", colorindex = 100},{name = "Woodbeech Brown", colorindex = 102},
{name = "Straw Brown", colorindex = 99},{name = "Sandy Brown", colorindex = 105},
{name = "Bleached Brown", colorindex = 106},{name = "Schafter Purple", colorindex = 71},
{name = "Spinnaker Purple", colorindex = 72},{name = "Midnight Purple", colorindex = 142},
{name = "Bright Purple", colorindex = 145},{name = "Cream", colorindex = 107},
{name = "Ice White", colorindex = 111},{name = "Frost White", colorindex = 112}}
local metalcolors = {
{name = "Brushed Steel",colorindex = 117},
{name = "Brushed Black Steel",colorindex = 118},
{name = "Brushed Aluminum",colorindex = 119},
{name = "Pure Gold",colorindex = 158},
{name = "Brushed Gold",colorindex = 159}
}
local mattecolors = {
{name = "Black", colorindex = 12},
{name = "Gray", colorindex = 13},
{name = "Light Gray", colorindex = 14},
{name = "Ice White", colorindex = 131},
{name = "Blue", colorindex = 83},
{name = "Dark Blue", colorindex = 82},
{name = "Midnight Blue", colorindex = 84},
{name = "Midnight Purple", colorindex = 149},
{name = "Schafter Purple", colorindex = 148},
{name = "Red", colorindex = 39},
{name = "Dark Red", colorindex = 40},
{name = "Orange", colorindex = 41},
{name = "Yellow", colorindex = 42},
{name = "Lime Green", colorindex = 55},
{name = "Green", colorindex = 128},
{name = "Frost Green", colorindex = 151},
{name = "Foliage Green", colorindex = 155},
{name = "Olive Darb", colorindex = 152},
{name = "Dark Earth", colorindex = 153},
{name = "Desert Tan", colorindex = 154}
}



LSC_Config = {}
LSC_Config.prices = {}

--------Prices---------
LSC_Config.prices = {

------Window tint------
	windowtint = {
		{ name = "Pure Black", tint = 1, price = 250},
		{ name = "Darksmoke", tint = 2, price = 250},
		{ name = "Lightsmoke", tint = 3, price = 250},
		{ name = "Limo", tint = 4, price = 250},
		{ name = "Green", tint = 5, price = 250},
	},

-------Respray--------
----Primary color---
	--Chrome 
	chrome = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 300
	},
	--Classic 
	classic = {
		colors = colors,
		price = 300
	},
	--Matte 
	matte = {
		colors = mattecolors,
		price = 300
	},
	--Metallic 
	metallic = {
		colors = colors,
		price = 300
	},
	--Metals 
	metal = {
		colors = metalcolors,
		price = 300
	},

----Secondary color---
	--Chrome 
	chrome2 = {
		colors = {
			{name = "Chrome", colorindex = 120}
		},
		price = 300
	},
	--Classic 
	classic2 = {
		colors = colors,
		price = 300
	},
	--Matte 
	matte2 = {
		colors = mattecolors,
		price = 300
	},
	--Metallic 
	metallic2 = {
		colors = colors,
		price = 300
	},
	--Metals 
	metal2 = {
		colors = metalcolors,
		price = 300
	},

------Neon layout------
	neonlayout = {
		{name = "Front,Back and Sides", price = 500},
	},
	--Neon color
	neoncolor = {
		{ name = "White", neon = {255,255,255}, price = 150},
		{ name = "Blue", neon = {0,0,255}, price = 150},
		{ name = "Electric Blue", neon = {0,150,255}, price = 150},
		{ name = "Mint Green", neon = {50,255,155}, price = 150},
		{ name = "Lime Green", neon = {0,255,0}, price = 150},
		{ name = "Yellow", neon = {255,255,0}, price = 150},
		{ name = "Golden Shower", neon = {204,204,0}, price = 150},
		{ name = "Orange", neon = {255,128,0}, price = 150},
		{ name = "Red", neon = {255,0,0}, price = 150},
		{ name = "Pony Pink", neon = {255,102,255}, price = 150},
		{ name = "Hot Pink",neon = {255,0,255}, price = 150},
		{ name = "Purple", neon = {153,0,153}, price = 150},
		{ name = "Brown", neon = {139,69,19}, price = 150},
	},
	
--------Plates---------
	plates = {
		{ name = "Blue on White 1", plateindex = 0, price = 50},
		{ name = "Blue On White 2", plateindex = 3, price = 50},
		{ name = "Blue On White 3", plateindex = 4, price = 50},
		{ name = "Yellow on Blue", plateindex = 2, price = 50},
		{ name = "Yellow on Black", plateindex = 1, price = 60},
	},
	
--------Wheels--------
----Wheel accessories----
	wheelaccessories = {
		{ name = "Stock Tires", price = 100},
		{ name = "Custom Tires", price = 200},
		{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 100},
		{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 100},
		{ name = "BLue Tire Smoke", smokecolor = {0,150,255}, price = 100},
		{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 100},
		{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 100},
		{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 100},
		{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 100},
		{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 100},
		{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 100},
		{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 100},
	},

----Wheel color----
	wheelcolor = {
		colors = colors,
		price = 120,
	},

----Front wheel (Bikes)----
	frontwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 120},
		{name = "Speedway", wtype = 6, mod = 0, price = 180},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 180},
		{name = "Racer", wtype = 6, mod = 2, price = 180},
		{name = "Trackstar", wtype = 6, mod = 3, price = 180},
		{name = "Overlord", wtype = 6, mod = 4, price = 180},
		{name = "Trident", wtype = 6, mod = 5, price = 180},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 180},
		{name = "Stilleto", wtype = 6, mod = 7, price = 180},
		{name = "Wires", wtype = 6, mod = 8, price = 180},
		{name = "Bobber", wtype = 6, mod = 9, price = 180},
		{name = "Solidus", wtype = 6, mod = 10, price = 180},
		{name = "Iceshield", wtype = 6, mod = 11, price = 180},
		{name = "Loops", wtype = 6, mod = 12, price = 180},
	},

----Back wheel (Bikes)-----
	backwheel = {
		{name = "Stock", wtype = 6, mod = -1, price = 130},
		{name = "Speedway", wtype = 6, mod = 0, price = 200},
		{name = "Streetspecial", wtype = 6, mod = 1, price = 200},
		{name = "Racer", wtype = 6, mod = 2, price = 200},
		{name = "Trackstar", wtype = 6, mod = 3, price = 200},
		{name = "Overlord", wtype = 6, mod = 4, price = 200},
		{name = "Trident", wtype = 6, mod = 5, price = 200},
		{name = "Triplethreat", wtype = 6, mod = 6, price = 200},
		{name = "Stilleto", wtype = 6, mod = 7, price = 200},
		{name = "Wires", wtype = 6, mod = 8, price = 200},
		{name = "Bobber", wtype = 6, mod = 9, price = 200},
		{name = "Solidus", wtype = 6, mod = 10, price = 200},
		{name = "Iceshield", wtype = 6, mod = 11, price = 200},
		{name = "Loops", wtype = 6, mod = 12, price = 200},
	},

----Sport wheels-----
	sportwheels = {
		{name = "Stock", wtype = 0, mod = -1, price = 130},
		{name = "Inferno", wtype = 0, mod = 0, price = 200},
		{name = "Deepfive", wtype = 0, mod = 1, price = 200},
		{name = "Lozspeed", wtype = 0, mod = 2, price = 200},
		{name = "Diamondcut", wtype = 0, mod = 3, price = 200},
		{name = "Chrono", wtype = 0, mod = 4, price = 200},
		{name = "Feroccirr", wtype = 0, mod = 5, price = 200},
		{name = "Fiftynine", wtype = 0, mod = 6, price = 200},
		{name = "Mercie", wtype = 0, mod = 7, price = 200},
		{name = "Syntheticz", wtype = 0, mod = 8, price = 200},
		{name = "Organictyped", wtype = 0, mod = 9, price = 200},
		{name = "Endov1", wtype = 0, mod = 10, price = 200},
		{name = "Duper7", wtype = 0, mod = 11, price = 200},
		{name = "Uzer", wtype = 0, mod = 12, price = 200},
		{name = "Groundride", wtype = 0, mod = 13, price = 200},
		{name = "Spacer", wtype = 0, mod = 14, price = 200},
		{name = "Venum", wtype = 0, mod = 15, price = 200},
		{name = "Cosmo", wtype = 0, mod = 16, price = 200},
		{name = "Dashvip", wtype = 0, mod = 17, price = 200},
		{name = "Icekid", wtype = 0, mod = 18, price = 200},
		{name = "Ruffeld", wtype = 0, mod = 19, price = 200},
		{name = "Wangenmaster", wtype = 0, mod = 20, price = 200},
		{name = "Superfive", wtype = 0, mod = 21, price = 200},
		{name = "Endov2", wtype = 0, mod = 22, price = 200},
		{name = "Slitsix", wtype = 0, mod = 23, price = 200},
	},
-----Suv wheels------
	suvwheels = {
		{name = "Stock", wtype = 3, mod = -1, price = 130},
		{name = "Vip", wtype = 3, mod = 0, price = 200},
		{name = "Benefactor", wtype = 3, mod = 1, price = 200},
		{name = "Cosmo", wtype = 3, mod = 2, price = 200},
		{name = "Bippu", wtype = 3, mod = 3, price = 200},
		{name = "Royalsix", wtype = 3, mod = 4, price = 200},
		{name = "Fagorme", wtype = 3, mod = 5, price = 200},
		{name = "Deluxe", wtype = 3, mod = 6, price = 200},
		{name = "Icedout", wtype = 3, mod = 7, price = 200},
		{name = "Cognscenti", wtype = 3, mod = 8, price = 200},
		{name = "Lozspeedten", wtype = 3, mod = 9, price = 200},
		{name = "Supernova", wtype = 3, mod = 10, price = 200},
		{name = "Obeyrs", wtype = 3, mod = 11, price = 200},
		{name = "Lozspeedballer", wtype = 3, mod = 12, price = 200},
		{name = "Extra vaganzo", wtype = 3, mod = 13, price = 200},
		{name = "Splitsix", wtype = 3, mod = 14, price = 200},
		{name = "Empowered", wtype = 3, mod = 15, price = 200},
		{name = "Sunrise", wtype = 3, mod = 16, price = 200},
		{name = "Dashvip", wtype = 3, mod = 17, price = 200},
		{name = "Cutter", wtype = 3, mod = 18, price = 200},
	},
-----Offroad wheels-----
	offroadwheels = {
		{name = "Stock", wtype = 4, mod = -1, price = 120},
		{name = "Raider", wtype = 4, mod = 0, price = 200},
		{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 200},
		{name = "Nevis", wtype = 4, mod = 2, price = 200},
		{name = "Cairngorm", wtype = 4, mod = 3, price = 200},
		{name = "Amazon", wtype = 4, mod = 4, price = 200},
		{name = "Challenger", wtype = 4, mod = 5, price = 200},
		{name = "Dunebasher", wtype = 4, mod = 6, price = 200},
		{name = "Fivestar", wtype = 4, mod = 7, price = 200},
		{name = "Rockcrawler", wtype = 4, mod = 8, price = 200},
		{name = "Milspecsteelie", wtype = 4, mod = 9, price = 200},
	},
-----Tuner wheels------
	tunerwheels = {
		{name = "Stock", wtype = 5, mod = -1, price = 120},
		{name = "Cosmo", wtype = 5, mod = 0, price = 200},
		{name = "Supermesh", wtype = 5, mod = 1, price = 200},
		{name = "Outsider", wtype = 5, mod = 2, price = 200},
		{name = "Rollas", wtype = 5, mod = 3, price = 200},
		{name = "Driffmeister", wtype = 5, mod = 4, price = 200},
		{name = "Slicer", wtype = 5, mod = 5, price = 200},
		{name = "Elquatro", wtype = 5, mod = 6, price = 200},
		{name = "Dubbed", wtype = 5, mod = 7, price = 200},
		{name = "Fivestar", wtype = 5, mod = 8, price = 200},
		{name = "Slideways", wtype = 5, mod = 9, price = 200},
		{name = "Apex", wtype = 5, mod = 10, price = 200},
		{name = "Stancedeg", wtype = 5, mod = 11, price = 200},
		{name = "Countersteer", wtype = 5, mod = 12, price = 200},
		{name = "Endov1", wtype = 5, mod = 13, price = 200},
		{name = "Endov2dish", wtype = 5, mod = 14, price = 200},
		{name = "Guppez", wtype = 5, mod = 15, price = 200},
		{name = "Chokadori", wtype = 5, mod = 16, price = 200},
		{name = "Chicane", wtype = 5, mod = 17, price = 200},
		{name = "Saisoku", wtype = 5, mod = 18, price = 200},
		{name = "Dishedeight", wtype = 5, mod = 19, price = 200},
		{name = "Fujiwara", wtype = 5, mod = 20, price = 200},
		{name = "Zokusha", wtype = 5, mod = 21, price = 200},
		{name = "Battlevill", wtype = 5, mod = 22, price = 200},
		{name = "Rallymaster", wtype = 5, mod = 23, price = 200},
	},
-----Highend wheels------
	highendwheels = {
		{name = "Stock", wtype = 7, mod = -1, price = 120},
		{name = "Shadow", wtype = 7, mod = 0, price = 200},
		{name = "Hyper", wtype = 7, mod = 1, price = 200},
		{name = "Blade", wtype = 7, mod = 2, price = 200},
		{name = "Diamond", wtype = 7, mod = 3, price = 200},
		{name = "Supagee", wtype = 7, mod = 4, price = 200},
		{name = "Chromaticz", wtype = 7, mod = 5, price = 200},
		{name = "Merciechlip", wtype = 7, mod = 6, price = 200},
		{name = "Obeyrs", wtype = 7, mod = 7, price = 200},
		{name = "Gtchrome", wtype = 7, mod = 8, price = 200},
		{name = "Cheetahr", wtype = 7, mod = 9, price = 200},
		{name = "Solar", wtype = 7, mod = 10, price = 200},
		{name = "Splitten", wtype = 7, mod = 11, price = 200},
		{name = "Dashvip", wtype = 7, mod = 12, price = 200},
		{name = "Lozspeedten", wtype = 7, mod = 13, price = 200},
		{name = "Carboninferno", wtype = 7, mod = 14, price = 200},
		{name = "Carbonshadow", wtype = 7, mod = 15, price = 200},
		{name = "Carbonz", wtype = 7, mod = 16, price = 200},
		{name = "Carbonsolar", wtype = 7, mod = 17, price = 200},
		{name = "Carboncheetahr", wtype = 7, mod = 18, price = 200},
		{name = "Carbonsracer", wtype = 7, mod = 19, price = 200},
	},
-----Lowrider wheels------
	lowriderwheels = {
		{name = "Stock", wtype = 2, mod = -1, price = 120},
		{name = "Flare", wtype = 2, mod = 0, price = 200},
		{name = "Wired", wtype = 2, mod = 1, price = 200},
		{name = "Triplegolds", wtype = 2, mod = 2, price = 200},
		{name = "Bigworm", wtype = 2, mod = 3, price = 200},
		{name = "Sevenfives", wtype = 2, mod = 4, price = 200},
		{name = "Splitsix", wtype = 2, mod = 5, price = 200},
		{name = "Freshmesh", wtype = 2, mod = 6, price = 200},
		{name = "Leadsled", wtype = 2, mod = 7, price = 200},
		{name = "Turbine", wtype = 2, mod = 8, price = 200},
		{name = "Superfin", wtype = 2, mod = 9, price = 200},
		{name = "Classicrod", wtype = 2, mod = 10, price = 200},
		{name = "Dollar", wtype = 2, mod = 11, price = 200},
		{name = "Dukes", wtype = 2, mod = 12, price = 200},
		{name = "Lowfive", wtype = 2, mod = 13, price = 200},
		{name = "Gooch", wtype = 2, mod = 14, price = 200},
	},
-----Muscle wheels-----
	musclewheels = {
		{name = "Stock", wtype = 1, mod = -1, price = 120},
		{name = "Classicfive", wtype = 1, mod = 0, price = 200},
		{name = "Dukes", wtype = 1, mod = 1, price = 200},
		{name = "Musclefreak", wtype = 1, mod = 2, price = 200},
		{name = "Kracka", wtype = 1, mod = 3, price = 200},
		{name = "Azrea", wtype = 1, mod = 4, price = 200},
		{name = "Mecha", wtype = 1, mod = 5, price = 200},
		{name = "Blacktop", wtype = 1, mod = 6, price = 200},
		{name = "Dragspl", wtype = 1, mod = 7, price = 200},
		{name = "Revolver", wtype = 1, mod = 8, price = 200},
		{name = "Classicrod", wtype = 1, mod = 9, price = 200},
		{name = "Spooner", wtype = 1, mod = 10, price = 200},
		{name = "Fivestar", wtype = 1, mod = 11, price = 200},
		{name = "Oldschool", wtype = 1, mod = 12, price = 200},
		{name = "Eljefe", wtype = 1, mod = 13, price = 200},
		{name = "Dodman", wtype = 1, mod = 14, price = 200},
		{name = "Sixgun", wtype = 1, mod = 15, price = 200},
		{name = "Mercenary", wtype = 1, mod = 16, price = 200},
	},
	
---------Trim color--------
	trim = {
		colors = colors,
		price = 120
	},
	
----------Mods-----------
	mods = {
	
----------Liveries--------
	[48] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Windows--------
	[46] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Tank--------
	[45] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Trim--------
	[44] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Aerials--------
	[43] = {
		startprice = 500,
		increaseby = 800
	},

----------Arch cover--------
	[42] = {
		startprice = 500,
		increaseby = 800
	},

----------Struts--------
	[41] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Air filter--------
	[40] = {
		startprice = 1000,
		increaseby = 1250
	},
	
----------Engine block--------
	[39] = {
		startprice = 500,
		increaseby = 800
	},

----------Hydraulics--------
	[38] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Trunk--------
	[37] = {
		startprice = 500,
		increaseby = 800
	},

----------Speakers--------
	[36] = {
		startprice = 500,
		increaseby = 800
	},

----------Plaques--------
	[35] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Shift leavers--------
	[34] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Steeringwheel--------
	[33] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Seats--------
	[32] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Door speaker--------
	[31] = {
		startprice = 500,
		increaseby = 800
	},

----------Dial--------
	[30] = {
		startprice = 500,
		increaseby = 800
	},
----------Dashboard--------
	[29] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Ornaments--------
	[28] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Trim--------
	[27] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Vanity plates--------
	[26] = {
		startprice = 500,
		increaseby = 800
	},
	
----------Plate holder--------
	[25] = {
		startprice = 500,
		increaseby = 800
	},
	
---------Headlights---------
	[22] = {
		{name = "Stock Lights", mod = 0, price = 0},
		{name = "Xenon Lights", mod = 1, price = 150},
	},
	
----------Turbo---------
	[18] = {
		{ name = "None", mod = 0, price = 0},
		{ name = "Turbo Tuning", mod = 1, price = 1000},
	},
	
-----------Armor-------------
	[16] = {
		{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price = 200},
		{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price = 500},
		{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price = 900},
		{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price = 1350},
		{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 2000},
	},

---------Suspension-----------
	[15] = {
		{name = "Lowered Suspension",mod = 0, price = 100},
		{name = "Street Suspension",mod = 1, price = 350},
		{name = "Sport Suspension",mod = 2, price = 550},
		{name = "Competition Suspension",mod = 3, price = 750},
	},

-----------Horn----------
	[14] = {
		{name = "Truck Horn", mod = 0, price = 100},
		{name = "Police Horn", mod = 1, price = 100},
		{name = "Clown Horn", mod = 2, price = 100},
		{name = "Musical Horn 1", mod = 3, price = 250},
		{name = "Musical Horn 2", mod = 4, price = 250},
		{name = "Musical Horn 3", mod = 5, price = 250},
		{name = "Musical Horn 4", mod = 6, price = 250},
		{name = "Musical Horn 5", mod = 7, price = 250},
		{name = "Sadtrombone Horn", mod = 8, price = 250},
		{name = "Calssical Horn 1", mod = 9, price = 250},
		{name = "Calssical Horn 2", mod = 10, price = 250},
		{name = "Calssical Horn 3", mod = 11, price = 250},
		{name = "Calssical Horn 4", mod = 12, price = 250},
		{name = "Calssical Horn 5", mod = 13, price = 250},
		{name = "Calssical Horn 6", mod = 14, price = 250},
		{name = "Calssical Horn 7", mod = 15, price = 250},
		{name = "Scaledo Horn", mod = 16, price = 250},
		{name = "Scalere Horn", mod = 17, price = 250},
		{name = "Scalemi Horn", mod = 18, price = 250},
		{name = "Scalefa Horn", mod = 19, price = 250},
		{name = "Scalesol Horn", mod = 20, price = 250},
		{name = "Scalela Horn", mod = 21, price = 250},
		{name = "Scaleti Horn", mod = 22, price = 250},
		{name = "Scaledo Horn High", mod = 23, price = 250},
		{name = "Jazz Horn 1", mod = 25, price = 250},
		{name = "Jazz Horn 2", mod = 26, price = 250},
		{name = "Jazz Horn 3", mod = 27, price = 250},
		{name = "Jazzloop Horn", mod = 28, price = 250},
		{name = "Starspangban Horn 1", mod = 29, price = 250},
		{name = "Starspangban Horn 2", mod = 30, price = 250},
		{name = "Starspangban Horn 3", mod = 31, price = 250},
		{name = "Starspangban Horn 4", mod = 32, price = 250},
		{name = "Classicalloop Horn 1", mod = 33, price = 250},
		{name = "Classicalloop Horn 2", mod = 34, price = 250},
		{name = "Classicalloop Horn 3", mod = 35, price = 250},
	},

----------Transmission---------
	[13] = {
		{name = "Street Transmission", mod = 0, price = 500},
		{name = "Sports Transmission", mod = 1, price = 750},
		{name = "Race Transmission", mod = 2, price = 950},
	},
	
-----------Brakes-------------
	[12] = {
		{name = "Street Brakes", mod = 0, price = 400},
		{name = "Sport Brakes", mod = 1, price = 600},
		{name = "Race Brakes", mod = 2, price = 900},
	},
	
------------Engine----------
	[11] = {
		{name = "EMS Upgrade, Level 2", mod = 0, price = 1000},
		{name = "EMS Upgrade, Level 3", mod = 1, price = 1500},
		{name = "EMS Upgrade, Level 4", mod = 2, price = 2200},
	},
	
-------------Roof----------
	[10] = {
		startprice = 150,
		increaseby = 100
	},
	
------------Fenders---------
	[8] = {
		startprice = 150,
		increaseby = 100
	},
	
------------Hood----------
	[7] = {
		startprice = 150,
		increaseby = 100
	},
	
----------Grille----------
	[6] = {
		startprice = 150,
		increaseby = 100
	},
	
----------Roll cage----------
	[5] = {
		startprice = 150,
		increaseby = 100
	},
	
----------Exhaust----------
	[4] = {
		startprice = 150,
		increaseby = 100
	},
	
----------Skirts----------
	[3] = {
		startprice = 150,
		increaseby = 100
	},
	
-----------Rear bumpers----------
	[2] = {
		startprice = 150,
		increaseby = 100
	},
	
----------Front bumpers----------
	[1] = {
		startprice = 300,
		increaseby = 200
	},
	
----------Spoiler----------
	[0] = {
		startprice = 300,
		increaseby = 200
	},
	}
	
}

------Model Blacklist--------
--Does'nt allow specific vehicles to be upgraded
LSC_Config.ModelBlacklist = {
	"police",
	"police2",
	"police3",
	"paliocv",
	"am",
	"blazerr",
	"fbi2",
	"sheriff2",
	"sheriff",
	"CHARGERPF",
	"sw4samu",
	"Samu",
	"Samu2",
	"policeb",
	"ur",
	"trash",
	"tiptruck2",
	"mule",
	"boxville2",
	"boxville4",
	--"flatbed",
	"faggio2",
	"fordcargo",
	"firetruk",
	"lguard",
	"ambulance",
	"stockade",
	"sw4rota",
	"trailrota",
	"hwaycar5",
	"riot",
	"tigerrocam",
	"rocammoto",
	"trailft",
	"blazerft",
	"ft",
	"globocar",
	"palio",
	"spin",
	"space",
	"s10",
	"policerenault",
	"police4",
	"pbus",
	"blazerprf",
	"frontier",
	"fluence",
	"sheriff",}

--Sets if garage will be locked if someone is inside it already
LSC_Config.lock = false

--Enable/disable old entering way
LSC_Config.oldenter = true

--Menu settings
LSC_Config.menu = {

-------Controls--------
	controls = {
		menu_up = 27,
		menu_down = 173,
		menu_left = 174,
		menu_right = 175,
		menu_select = 201,
		menu_back = 177
	},

-------Menu position-----
	--Possible positions:
	--Left
	--Right
	--Custom position, example: position = {x = 0.2, y = 0.2}
	position = "left",

-------Menu theme--------
	--Possible themes: light, darkred, bluish, greenish
	--Custom example:
	--[[theme = {
		text_color = { r = 255,g = 255, b = 255, a = 255},
		bg_color = { r = 0,g = 0, b = 0, a = 155},
		--Colors when button is selected
		stext_color = { r = 0,g = 0, b = 0, a = 255},
		sbg_color = { r = 255,g = 255, b = 0, a = 200},
	},]]
	theme = "light",
	
--------Max buttons------
	--Default: 10
	maxbuttons = 10,

-------Size---------
	--[[
	Default:
	width = 0.24
	height = 0.36
	]]
	width = 0.24,
	height = 0.36

}
