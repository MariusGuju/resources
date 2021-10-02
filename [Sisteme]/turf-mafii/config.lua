config = {

	-- Blip/Color Reference: --
	-- https://docs.fivem.net/docs/game-references/blips/ --
	
	-- Config Info: --
	-- "coords" = Contains the x, y, z, coordinates of the zone. --
		-- "x" = The "X" coordinate of the zone. --
		-- "y" = The "Y" coordinate of the zone. --
		-- "z" = The "Z" coordinate of the zone. --
	-- "zone" = Contains the radius and color of the zone. --
		-- "radius" = The radius of the zone. (Default = 300.0) --
		-- "color" = The color of the zone. (Same color id's as blips.) --
	-- "blip" = Contains the id, color, and text of the blip. --
		-- "draw" = If this is "true" it will show a blip in the center of the zone. --
		-- "id" = The id of the blip. --
		-- "color" = The color of the blip. --
		-- "text" = The text of the blip. --
	
	zones = {
		{
			coords = {x = 96.39868927002, y = -1933.2166748047, z = 20.803726196289},
			zone = {radius = 100.0, color = 69}, 
			blip = {draw = false, id = 0, color = 0, text = ""}
		},
		{
			coords = {x = -1011.7712402344, y = -982.37561035156, z = 2.1503098011017}, --1011.7712402344,-982.37561035156,2.1503098011017
			zone = {radius = 100.0, color = 4}, 
			blip = {draw = false, id = 0, color = 0, text = ""}
		}
	}
}