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
			coords = {x = -185.08790588379, y = -1300.9184570312, z = 31.296089172363},
			zone = {radius = 140.0, color = 61}, 
			blip = {draw = false, id = 0, color = 0, text = ""}
		}
	}
}