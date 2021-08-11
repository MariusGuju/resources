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
			{ name = "Pure Black", tint = 1, price = 0},
			{ name = "Darksmoke", tint = 2, price = 0},
			{ name = "Lightsmoke", tint = 3, price = 0},
			{ name = "Limo", tint = 4, price = 0},
			{ name = "Green", tint = 5, price = 0},
		},
	
	-------Respray--------
	----Primary color---
		--Chrome 
		chrome = {
			colors = {
				{name = "Chrome", colorindex = 0}
			},
			price = 700
		},
		--Classic 
		classic = {
			colors = colors,
			price = 200
		},
		--Matte 
		matte = {
			colors = mattecolors,
			price = 400
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
			price = 700
		},
		--Classic 
		classic2 = {
			colors = colors,
			price = 200
		},
		--Matte 
		matte2 = {
			colors = mattecolors,
			price = 400
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
			{name = "Front,Back and Sides", price = 1250},
		},
		--Neon color
		neoncolor = {
			{ name = "White", neon = {255,255,255}, price = 500},
			{ name = "Blue", neon = {0,0,255}, price = 500},
			{ name = "Electric Blue", neon = {0,150,255}, price = 500},
			{ name = "Mint Green", neon = {50,255,155}, price = 500},
			{ name = "Lime Green", neon = {0,255,0}, price = 500},
			{ name = "Yellow", neon = {255,255,0}, price = 500},
			{ name = "Golden Shower", neon = {204,204,0}, price = 500},
			{ name = "Orange", neon = {255,128,0}, price = 500},
			{ name = "Red", neon = {255,0,0}, price = 500},
			{ name = "Pony Pink", neon = {255,102,255}, price = 500},
			{ name = "Hot Pink",neon = {255,0,255}, price = 500},
			{ name = "Purple", neon = {153,0,153}, price = 500},
			{ name = "Brown", neon = {139,69,19}, price = 500},
		},
		
	--------Plates---------
		plates = {
			{ name = "Blue on White 1", plateindex = 0, price = 225},
			{ name = "Blue On White 2", plateindex = 3, price = 225},
			{ name = "Blue On White 3", plateindex = 4, price = 225},
			{ name = "Yellow on Blue", plateindex = 2, price = 225},
			{ name = "Yellow on Black", plateindex = 1, price = 225},
		},
		
	--------Wheels--------
	----Wheel accessories----
		wheelaccessories = {
			{ name = "Stock Tires", price = 10},
			{ name = "Custom Tires", price = 750},
			{ name = "White Tire Smoke",smokecolor = {254,254,254}, price = 400},
			{ name = "Black Tire Smoke", smokecolor = {1,1,1}, price = 400},
			{ name = "BLue Tire Smoke", smokecolor = {0,150,255}, price = 400},
			{ name = "Yellow Tire Smoke", smokecolor = {255,255,50}, price = 400},
			{ name = "Orange Tire Smoke", smokecolor = {255,153,51}, price = 400},
			{ name = "Red Tire Smoke", smokecolor = {255,10,10}, price = 400},
			{ name = "Green Tire Smoke", smokecolor = {10,255,10}, price = 400},
			{ name = "Purple Tire Smoke", smokecolor = {153,10,153}, price = 400},
			{ name = "Pink Tire Smoke", smokecolor = {255,102,178}, price = 400},
			{ name = "Gray Tire Smoke",smokecolor = {128,128,128}, price = 400},
		},
	
	----Wheel color----
		wheelcolor = {
			colors = colors,
			price = 500,
		},
	
	----Front wheel (Bikes)----
		frontwheel = {
			{name = "Stock", wtype = 6, mod = -1, price = 850},
			{name = "Speedway", wtype = 6, mod = 0, price = 850},
			{name = "Streetspecial", wtype = 6, mod = 1, price = 850},
			{name = "Racer", wtype = 6, mod = 2, price = 850},
			{name = "Trackstar", wtype = 6, mod = 3, price = 850},
			{name = "Overlord", wtype = 6, mod = 4, price = 850},
			{name = "Trident", wtype = 6, mod = 5, price = 850},
			{name = "Triplethreat", wtype = 6, mod = 6, price = 850},
			{name = "Stilleto", wtype = 6, mod = 7, price = 850},
			{name = "Wires", wtype = 6, mod = 8, price = 850},
			{name = "Bobber", wtype = 6, mod = 9, price = 850},
			{name = "Solidus", wtype = 6, mod = 10, price = 850},
			{name = "Iceshield", wtype = 6, mod = 11, price = 850},
			{name = "Loops", wtype = 6, mod = 12, price = 850},
		},
	
	----Back wheel (Bikes)-----
		backwheel = {
			{name = "Stock", wtype = 6, mod = -1, price = 850},
			{name = "Speedway", wtype = 6, mod = 0, price = 850},
			{name = "Streetspecial", wtype = 6, mod = 1, price = 850},
			{name = "Racer", wtype = 6, mod = 2, price = 850},
			{name = "Trackstar", wtype = 6, mod = 3, price = 850},
			{name = "Overlord", wtype = 6, mod = 4, price = 850},
			{name = "Trident", wtype = 6, mod = 5, price = 850},
			{name = "Triplethreat", wtype = 6, mod = 6, price = 850},
			{name = "Stilleto", wtype = 6, mod = 7, price = 850},
			{name = "Wires", wtype = 6, mod = 8, price = 850},
			{name = "Bobber", wtype = 6, mod = 9, price = 850},
			{name = "Solidus", wtype = 6, mod = 10, price = 850},
			{name = "Iceshield", wtype = 6, mod = 11, price = 850},
			{name = "Loops", wtype = 6, mod = 12, price = 850},
		},
	
	----Sport wheels-----
		sportwheels = {
			{name = "Stock", wtype = 0, mod = -1, price = 850},
			{name = "Inferno", wtype = 0, mod = 0, price = 850},
			{name = "Deepfive", wtype = 0, mod = 1, price = 850},
			{name = "Lozspeed", wtype = 0, mod = 2, price = 850},
			{name = "Diamondcut", wtype = 0, mod = 3, price = 850},
			{name = "Chrono", wtype = 0, mod = 4, price = 850},
			{name = "Feroccirr", wtype = 0, mod = 5, price = 850},
			{name = "Fiftynine", wtype = 0, mod = 6, price = 850},
			{name = "Mercie", wtype = 0, mod = 7, price = 850},
			{name = "Syntheticz", wtype = 0, mod = 8, price = 850},
			{name = "Organictyped", wtype = 0, mod = 9, price = 850},
			{name = "Endov1", wtype = 0, mod = 10, price = 850},
			{name = "Duper7", wtype = 0, mod = 11, price = 850},
			{name = "Uzer", wtype = 0, mod = 12, price = 850},
			{name = "Groundride", wtype = 0, mod = 13, price = 850},
			{name = "Spacer", wtype = 0, mod = 14, price = 850},
			{name = "Venum", wtype = 0, mod = 15, price = 850},
			{name = "Cosmo", wtype = 0, mod = 16, price = 850},
			{name = "Dashvip", wtype = 0, mod = 17, price = 850},
			{name = "Icekid", wtype = 0, mod = 18, price = 850},
			{name = "Ruffeld", wtype = 0, mod = 19, price = 850},
			{name = "Wangenmaster", wtype = 0, mod = 20, price = 850},
			{name = "Superfive", wtype = 0, mod = 21, price = 850},
			{name = "Endov2", wtype = 0, mod = 22, price = 850},
			{name = "Slitsix", wtype = 0, mod = 23, price = 850},
		},
	-----Suv wheels------
		suvwheels = {
			{name = "Stock", wtype = 3, mod = -1, price = 850},
			{name = "Vip", wtype = 3, mod = 0, price = 850},
			{name = "Benefactor", wtype = 3, mod = 1, price = 850},
			{name = "Cosmo", wtype = 3, mod = 2, price = 850},
			{name = "Bippu", wtype = 3, mod = 3, price = 850},
			{name = "Royalsix", wtype = 3, mod = 4, price = 850},
			{name = "Fagorme", wtype = 3, mod = 5, price = 850},
			{name = "Deluxe", wtype = 3, mod = 6, price = 850},
			{name = "Icedout", wtype = 3, mod = 7, price = 850},
			{name = "Cognscenti", wtype = 3, mod = 8, price = 850},
			{name = "Lozspeedten", wtype = 3, mod = 9, price = 850},
			{name = "Supernova", wtype = 3, mod = 10, price = 850},
			{name = "Obeyrs", wtype = 3, mod = 11, price = 850},
			{name = "Lozspeedballer", wtype = 3, mod = 12, price = 850},
			{name = "Extra vaganzo", wtype = 3, mod = 13, price = 850},
			{name = "Splitsix", wtype = 3, mod = 14, price = 850},
			{name = "Empowered", wtype = 3, mod = 15, price = 850},
			{name = "Sunrise", wtype = 3, mod = 16, price = 850},
			{name = "Dashvip", wtype = 3, mod = 17, price = 850},
			{name = "Cutter", wtype = 3, mod = 18, price = 850},
		},
	-----Offroad wheels-----
		offroadwheels = {
			{name = "Stock", wtype = 4, mod = -1, price = 850},
			{name = "Raider", wtype = 4, mod = 0, price = 850},
			{name = "Mudslinger", wtype = 4, modtype = 23, wtype = 4, mod = 1, price = 850},
			{name = "Nevis", wtype = 4, mod = 2, price = 850},
			{name = "Cairngorm", wtype = 4, mod = 3, price = 850},
			{name = "Amazon", wtype = 4, mod = 4, price = 850},
			{name = "Challenger", wtype = 4, mod = 5, price = 850},
			{name = "Dunebasher", wtype = 4, mod = 6, price = 850},
			{name = "Fivestar", wtype = 4, mod = 7, price = 850},
			{name = "Rockcrawler", wtype = 4, mod = 8, price = 850},
			{name = "Milspecsteelie", wtype = 4, mod = 9, price = 850},
		},
	-----Tuner wheels------
		tunerwheels = {
			{name = "Stock", wtype = 5, mod = -1, price = 850},
			{name = "Cosmo", wtype = 5, mod = 0, price = 850},
			{name = "Supermesh", wtype = 5, mod = 1, price = 850},
			{name = "Outsider", wtype = 5, mod = 2, price = 850},
			{name = "Rollas", wtype = 5, mod = 3, price = 850},
			{name = "Driffmeister", wtype = 5, mod = 4, price = 850},
			{name = "Slicer", wtype = 5, mod = 5, price = 850},
			{name = "Elquatro", wtype = 5, mod = 6, price = 850},
			{name = "Dubbed", wtype = 5, mod = 7, price = 850},
			{name = "Fivestar", wtype = 5, mod = 8, price = 850},
			{name = "Slideways", wtype = 5, mod = 9, price = 850},
			{name = "Apex", wtype = 5, mod = 10, price = 850},
			{name = "Stancedeg", wtype = 5, mod = 11, price = 850},
			{name = "Countersteer", wtype = 5, mod = 12, price = 850},
			{name = "Endov1", wtype = 5, mod = 13, price = 850},
			{name = "Endov2dish", wtype = 5, mod = 14, price = 850},
			{name = "Guppez", wtype = 5, mod = 15, price = 850},
			{name = "Chokadori", wtype = 5, mod = 16, price = 850},
			{name = "Chicane", wtype = 5, mod = 17, price = 850},
			{name = "Saisoku", wtype = 5, mod = 18, price = 850},
			{name = "Dishedeight", wtype = 5, mod = 19, price = 850},
			{name = "Fujiwara", wtype = 5, mod = 20, price = 850},
			{name = "Zokusha", wtype = 5, mod = 21, price = 850},
			{name = "Battlevill", wtype = 5, mod = 22, price = 850},
			{name = "Rallymaster", wtype = 5, mod = 23, price = 850},
		},
	-----Highend wheels------
		highendwheels = {
			{name = "Stock", wtype = 7, mod = -1, price = 950},
			{name = "Shadow", wtype = 7, mod = 0, price = 950},
			{name = "Hyper", wtype = 7, mod = 1, price = 950},
			{name = "Blade", wtype = 7, mod = 2, price = 950},
			{name = "Diamond", wtype = 7, mod = 3, price = 950},
			{name = "Supagee", wtype = 7, mod = 4, price = 950},
			{name = "Chromaticz", wtype = 7, mod = 5, price = 950},
			{name = "Merciechlip", wtype = 7, mod = 6, price = 950},
			{name = "Obeyrs", wtype = 7, mod = 7, price = 950},
			{name = "Gtchrome", wtype = 7, mod = 8, price = 950},
			{name = "Cheetahr", wtype = 7, mod = 9, price = 950},
			{name = "Solar", wtype = 7, mod = 10, price = 950},
			{name = "Splitten", wtype = 7, mod = 11, price = 950},
			{name = "Dashvip", wtype = 7, mod = 12, price = 950},
			{name = "Lozspeedten", wtype = 7, mod = 13, price = 950},
			{name = "Carboninferno", wtype = 7, mod = 14, price = 950},
			{name = "Carbonshadow", wtype = 7, mod = 15, price = 950},
			{name = "Carbonz", wtype = 7, mod = 16, price = 950},
			{name = "Carbonsolar", wtype = 7, mod = 17, price = 950},
			{name = "Carboncheetahr", wtype = 7, mod = 18, price = 950},
			{name = "Carbonsracer", wtype = 7, mod = 19, price = 950},
		},
	-----Lowrider wheels------
		lowriderwheels = {
			{name = "Stock", wtype = 2, mod = -1, price = 850},
			{name = "Flare", wtype = 2, mod = 0, price = 850},
			{name = "Wired", wtype = 2, mod = 1, price = 850},
			{name = "Triplegolds", wtype = 2, mod = 2, price = 850},
			{name = "Bigworm", wtype = 2, mod = 3, price = 850},
			{name = "Sevenfives", wtype = 2, mod = 4, price = 850},
			{name = "Splitsix", wtype = 2, mod = 5, price = 850},
			{name = "Freshmesh", wtype = 2, mod = 6, price = 850},
			{name = "Leadsled", wtype = 2, mod = 7, price = 850},
			{name = "Turbine", wtype = 2, mod = 8, price = 850},
			{name = "Superfin", wtype = 2, mod = 9, price = 850},
			{name = "Classicrod", wtype = 2, mod = 10, price = 850},
			{name = "Dollar", wtype = 2, mod = 11, price = 850},
			{name = "Dukes", wtype = 2, mod = 12, price = 850},
			{name = "Lowfive", wtype = 2, mod = 13, price = 850},
			{name = "Gooch", wtype = 2, mod = 14, price = 850},
		},
	-----Muscle wheels-----
		musclewheels = {
			{name = "Stock", wtype = 1, mod = -1, price = 850},
			{name = "Classicfive", wtype = 1, mod = 0, price = 850},
			{name = "Dukes", wtype = 1, mod = 1, price = 850},
			{name = "Musclefreak", wtype = 1, mod = 2, price = 850},
			{name = "Kracka", wtype = 1, mod = 3, price = 850},
			{name = "Azrea", wtype = 1, mod = 4, price = 850},
			{name = "Mecha", wtype = 1, mod = 5, price = 850},
			{name = "Blacktop", wtype = 1, mod = 6, price = 850},
			{name = "Dragspl", wtype = 1, mod = 7, price = 850},
			{name = "Revolver", wtype = 1, mod = 8, price = 850},
			{name = "Classicrod", wtype = 1, mod = 9, price = 850},
			{name = "Spooner", wtype = 1, mod = 10, price = 850},
			{name = "Fivestar", wtype = 1, mod = 11, price = 850},
			{name = "Oldschool", wtype = 1, mod = 12, price = 850},
			{name = "Eljefe", wtype = 1, mod = 13, price = 850},
			{name = "Dodman", wtype = 1, mod = 14, price = 850},
			{name = "Sixgun", wtype = 1, mod = 15, price = 850},
			{name = "Mercenary", wtype = 1, mod = 16, price = 850},
		},
		
	---------Trim color--------
		trim = {
			colors = colors,
			price = 500
		},
		
	----------Mods-----------
		mods = {
		
	----------Liveries--------
		[48] = {
			startprice = 2000,
			increaseby = 600
		},
		
	----------Windows--------
		[46] = {
			startprice = 1000,
			increaseby = 250
		},
		
	----------Tank--------
		[45] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Trim--------
		[44] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Aerials--------
		[43] = {
			startprice = 2000,
			increaseby = 625
		},
	
	----------Arch cover--------
		[42] = {
			startprice = 2000,
			increaseby = 625
		},
	
	----------Struts--------
		[41] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Air filter--------
		[40] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Engine block--------
		[39] = {
			startprice = 2000,
			increaseby = 625
		},
	
	----------Hydraulics--------
		[38] = {
			startprice = 2500,
			increaseby = 700
		},
		
	----------Trunk--------
		[37] = {
			startprice = 2000,
			increaseby = 625
		},
	
	----------Speakers--------
		[36] = {
			startprice = 2000,
			increaseby = 625
		},
	
	----------Plaques--------
		[35] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Shift leavers--------
		[34] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Steeringwheel--------
		[33] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Seats--------
		[32] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Door speaker--------
		[31] = {
			startprice = 2000,
			increaseby = 625
		},
	
	----------Dial--------
		[30] = {
			startprice = 2000,
			increaseby = 625
		},
	----------Dashboard--------
		[29] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Ornaments--------
		[28] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Trim--------
		[27] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Vanity plates--------
		[26] = {
			startprice = 2000,
			increaseby = 625
		},
		
	----------Plate holder--------
		[25] = {
			startprice = 2000,
			increaseby = 625
		},
		
	---------Headlights---------
		[22] = {
			{name = "Stock Lights", mod = 0, price = 0},
			{name = "Xenon Lights", mod = 1, price = 1250},
		},
		[21] = {
			{name = "Default", mod = -1, price = 500},
			{name = "White", mod = 0, price = 500},
			{name = "Darkblue", mod = 1, price = 500},
			{name = "Lightblue", mod = 2, price = 500},
			{name = "Turquoise", mod = 3, price = 500},
			{name = "Green", mod = 4, price = 500},
			{name = "Yellow", mod = 5, price = 500},
			{name = "Gold", mod = 6, price = 500},
			{name = "Orange", mod = 7, price = 500},
			{name = "Red", mod = 8, price = 500},
			{name = "Pink", mod = 9, price = 500},
			{name = "Violet", mod = 10, price = 500},
			{name = "Purple", mod = 11, price = 500},
			{name = "Ultraviolet", mod = 12, price = 500},
		},
		
	----------Turbo---------
		[18] = {
			{ name = "None", mod = 0, price = 0},
			{ name = "Turbo Tuning", mod = 1, price = 2500},
		},
		
	-----------Armor-------------
		[16] = {
			{name = "Armor Upgrade 20%",modtype = 16, mod = 0, price = 1500},
			{name = "Armor Upgrade 40%",modtype = 16, mod = 1, price = 3000},
			{name = "Armor Upgrade 60%",modtype = 16, mod = 2, price = 6000},
			{name = "Armor Upgrade 80%",modtype = 16, mod = 3, price = 9000},
			{name = "Armor Upgrade 100%",modtype = 16, mod = 4, price = 12000},
		},
	
	---------Suspension-----------
		[15] = {
			{name = "Lowered Suspension",mod = 0, price = 1000},
			{name = "Street Suspension",mod = 1, price = 1500},
			{name = "Sport Suspension",mod = 2, price = 2000},
			{name = "Competition Suspension",mod = 3, price = 2500},
		},
	
	-----------Horn----------
		[14] = {
			{name = "Truck Horn", mod = 0, price = 150},
			{name = "Police Horn", mod = 1, price = 150},
			{name = "Clown Horn", mod = 2, price = 150},
			{name = "Musical Horn 1", mod = 3, price = 150},
			{name = "Musical Horn 2", mod = 4, price = 150},
			{name = "Musical Horn 3", mod = 5, price = 150},
			{name = "Musical Horn 4", mod = 6, price = 150},
			{name = "Musical Horn 5", mod = 7, price = 150},
			{name = "Sadtrombone Horn", mod = 8, price = 150},
			{name = "Calssical Horn 1", mod = 9, price = 150},
			{name = "Calssical Horn 2", mod = 10, price = 150},
			{name = "Calssical Horn 3", mod = 11, price = 150},
			{name = "Calssical Horn 4", mod = 12, price = 150},
			{name = "Calssical Horn 5", mod = 13, price = 150},
			{name = "Calssical Horn 6", mod = 14, price = 150},
			{name = "Calssical Horn 7", mod = 15, price = 150},
			{name = "Scaledo Horn", mod = 16, price = 150},
			{name = "Scalere Horn", mod = 17, price = 150},
			{name = "Scalemi Horn", mod = 18, price = 150},
			{name = "Scalefa Horn", mod = 19, price = 150},
			{name = "Scalesol Horn", mod = 20, price = 150},
			{name = "Scalela Horn", mod = 21, price = 150},
			{name = "Scaleti Horn", mod = 22, price = 150},
			{name = "Scaledo Horn High", mod = 23, price = 150},
			{name = "Jazz Horn 1", mod = 25, price = 150},
			{name = "Jazz Horn 2", mod = 26, price = 150},
			{name = "Jazz Horn 3", mod = 27, price = 150},
			{name = "Jazzloop Horn", mod = 28, price = 150},
			{name = "Starspangban Horn 1", mod = 29, price = 150},
			{name = "Starspangban Horn 2", mod = 30, price = 150},
			{name = "Starspangban Horn 3", mod = 31, price = 150},
			{name = "Starspangban Horn 4", mod = 32, price = 150},
			{name = "Classicalloop Horn 1", mod = 33, price = 150},
			{name = "Classicalloop Horn 2", mod = 34, price = 150},
			{name = "Classicalloop Horn 3", mod = 35, price = 150},
		},
	
	----------Transmission---------
		[13] = {
			{name = "Street Transmission", mod = 0, price = 2500},
			{name = "Sports Transmission", mod = 1, price = 5000},
			{name = "Race Transmission", mod = 2, price = 7500},
		},
		
	-----------Brakes-------------
		[12] = {
			{name = "Street Brakes", mod = 0, price = 3500},
			{name = "Sport Brakes", mod = 1, price = 6000},
			{name = "Race Brakes", mod = 2, price = 10000},
		},
		
	------------Engine----------
		[11] = {
			{name = "EMS Upgrade, Level 2", mod = 0, price = 5000},
			{name = "EMS Upgrade, Level 3", mod = 1, price = 7500},
			{name = "EMS Upgrade, Level 4", mod = 2, price = 10000},
		},
		
	-------------Roof----------
		[10] = {
			startprice = 1000,
			increaseby = 200
		},
		
	------------Fenders---------
		[8] = {
			startprice = 1000,
			increaseby = 200
		},
		
	------------Hood----------
		[7] = {
			startprice = 1000,
			increaseby = 200
		},
		
	----------Grille----------
		[6] = {
			startprice = 1000,
			increaseby = 200
		},
		
	----------Roll cage----------
		[5] = {
			startprice = 1000,
			increaseby = 200
		},
		
	----------Exhaust----------
		[4] = {
			startprice = 1000,
			increaseby = 200
		},
		
	----------Skirts----------
		[3] = {
			startprice = 1000,
			increaseby = 200
		},
		
	-----------Rear bumpers----------
		[2] = {
			startprice = 1000,
			increaseby = 500
		},
		
	----------Front bumpers----------
		[1] = {
			startprice = 1000,
			increaseby = 500
		},
		
	----------Spoiler----------
		[0] = {
			startprice = 1000,
			increaseby = 200
		},
		}
		
	}
	
	------Model Blacklist--------
	--Does'nt allow specific vehicles to be upgraded
	LSC_Config.ModelBlacklist = {
		"police",
		"paliocv",
		"am",
		"blazerr",
		"CHARGERPF",
		"sw4samu",
		"Samu",
		"Samu2",
		"ur",
		"trash",
		"tiptruck2",
		"mule",
		"boxville2",
		"boxville4",
		"faggio2",
		"fordcargo",
		"firetruk",
		"lguard",
		"ambulance",
		"stockade",
		"sw4rota",
		"trailrota",
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
		"pbus",
		"blazerprf",
		"frontier",
		"fluence",}
	
	--Sets if garage will be locked if someone is inside it already
	LSC_Config.lock = true
	
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