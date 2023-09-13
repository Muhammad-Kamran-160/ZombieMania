--[[
    XP Utils
    Author: Kamran / portodemesso
--]]

local function getRomanNumeral(index)
	local numerals = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"}
	return numerals[index]
end

local function getTitle(index)
	local titles = {
		"Novice", "Apprentice", "Adept", "Specialist", "Expert", "Knight", "Holy Knight", "Captain",
		"Commander", "General", "Warlord", "Hero", "Lord", "King", "Sovereign", "Overlord", "Emperor", "Supreme", "Legend", "Mythic", "Immortal", "Ascendant",
		"Divine", "Super Divine", "Demigod", "Super Demigod", "God", "Super God",  "Celestial", "Super Celestial",  "Galactic",
		"Super Galactic", "Universal", "Super Universal", "Multiversal", "Super Multiversal", "Eternal", "Super Eternal", "Timeless", "Super Timeless",
		"Infinite", "Super Infinite", "Absolute", "Super Absolute", "The Alpha", "The Super Alpha", "The Ultimate Alpha",
		"The Omega", "The Super Omega", "The Ultimate Omega", "Ultra Zombie Assassin"
	}
	return titles[index]
end

--Main
return function (level)
	local title = ""
	local color = Color3.new(1, 1, 1) -- Default color is white
	local tier = 0

	if level > 0 then
		local titleIndex = math.floor(level/30) + 1
		if titleIndex > 51 then
			titleIndex = 51
		end
		
		local numeralIndex = math.floor(((level) % 30) / 5) + 1
		if numeralIndex == 7 then
			numeralIndex = 1
		end
		
		local romanNumeral = getRomanNumeral(numeralIndex)

		if titleIndex >= 51 then
			local specialIndex = math.floor(level/1500)
			if specialIndex > 10 then
				specialIndex = 10
			end
			romanNumeral = getRomanNumeral(specialIndex)
			title = getTitle(titleIndex).." "..romanNumeral
		else
			title = getTitle(titleIndex).." "..romanNumeral
		end

		-- Set the color based on the tier
		if titleIndex >= 1 and titleIndex <= 5 then
			color = Color3.new(1, 1, 1) -- White
			tier = 1
		elseif titleIndex >= 6 and titleIndex <= 12 then
			color = Color3.new(1, 0.5, 0) -- Orange
			tier = 2
		elseif titleIndex >= 13 and titleIndex <= 17 then
			color = Color3.new(0, 1, 0) -- Green
			tier = 3
		elseif titleIndex >= 18 and titleIndex <= 22 then
			color = Color3.new(0, 0, 1) -- Blue
			tier = 4
		elseif titleIndex >= 23 and titleIndex <= 28 then
			color = Color3.new(0.5, 0, 0.5) -- Purple
			tier = 5
		elseif titleIndex >= 29 and titleIndex <= 36 then
			color = Color3.new(0.4, 0.2, 0) -- Brown
			tier = 6
		elseif titleIndex >= 37 and titleIndex <= 44 then
			color = Color3.new(1, 0, 0) -- Red
			tier = 7
		elseif titleIndex >= 45 and titleIndex <= 50 then
			color = Color3.new(0, 0, 0) -- Black
			tier = 8
		elseif titleIndex >= 51 then
			color = Color3.new(1, 0.84, 0) -- Gold
			tier = 9
		end
	end

	return title, color, tier
end
