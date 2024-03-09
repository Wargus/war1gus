--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      spells.lua - The spells.
--
--      (c) Copyright 1998-2004 by Joris Dauphin and Jimmy Salmon.
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--  
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--  
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--      $Id$

-- For documentation see stratagus/doc/ccl/ccl.html

DefineBoolFlags("isundead", "organic", "hero", "volatile")
DefineVariables("Mana", {Max = 0, Value = 64, Increase = 1, IncreaseFrequency = 2, Enable = false}, "Speed", "ShadowFly", {Max = 2}, "Level")

--  Declare some unit types used in spells. This is quite accetable, the other
--  way would be to define can-cast-spell outside unit definitions, not much of an improvement.
DefineUnitType(
   "unit-revealer", {
      Name = "Dummy unit",
      Animations = "animations-building", Icon = "icon-far-seeing",
      HitPoints = 1,
      TileSize = {1, 1}, BoxSize = {1, 1},
      SightRange = 8,
      BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
      Priority = 0,
      DecayRate = 1,
      Type = "land",
      Building = true, VisibleUnderFog = true,
      Revealer = true,
      DetectCloak = true,
      Sounds = {} })
-- These following units are redefined in units.lua
DefineUnitType("unit-the-dead", {})
DefineUnitType("unit-spider", {})
DefineUnitType("unit-scorpion", {})
DefineUnitType("unit-daemon", {})
DefineUnitType("unit-water-elemental", {})

-- And declare upgrade for dependency...
-- For human
CUpgrade:New("upgrade-far-seeing")
CUpgrade:New("upgrade-healing")
CUpgrade:New("upgrade-invisibility")
CUpgrade:New("upgrade-scorpion")
CUpgrade:New("upgrade-water-elemental")
CUpgrade:New("upgrade-rain-of-fire")
-- For orc
CUpgrade:New("upgrade-dark-vision")
CUpgrade:New("upgrade-raise-dead")
CUpgrade:New("upgrade-unholy-armor")
CUpgrade:New("upgrade-spider")
CUpgrade:New("upgrade-daemon")
CUpgrade:New("upgrade-poison-cloud")

-- functions

local function SpellUnholyArmor(spell, unit, x, y, target)
	if target ~= -1 then
		if GetUnitBoolFlag(target, "volatile") == true then
			DamageUnit(-1, target, 99999)
		else
			DamageUnit(-1, target, math.max(1, math.floor(GetUnitVariable(target, "HitPoints", "Max") / 2)))
			SetUnitVariable(target, "UnholyArmor", 600, "Max")
			SetUnitVariable(target, "UnholyArmor", 600, "Value")
			SetUnitVariable(target, "UnholyArmor", 1, "Enable")
		end
	end
	return false
end


local function SpellBlizzard(units)
	if (table.getn(units) > 1) then
		local p2 = Players[GetUnitVariable(units[1], "Player")]
		local arunits = {}
		local enemy = 2
		local costs = {}
		for i = 2,table.getn(units) do
			costs[i] = 0
			local p1 = Players[GetUnitVariable(units[i], "Player")]
			if (p1.Index == p2.Index or p1:IsAllied(p2)) then
			else
				costs[i] = costs[i] + GetUnitVariable(units[i], "Priority")
				arunits = GetUnitsAroundUnit(units[i], 5, true)
				for j = 1,table.getn(arunits) do
					if (arunits[j] ~= units[1]) then
						local p3 = Players[GetUnitVariable(arunits[j], "Player")]
						if (p3.Index == p2.Index or p3:IsAllied(p2)) then
							costs[i] = costs[i] - GetUnitVariable(arunits[j], "Priority")
						else
							costs[i] = costs[i] + GetUnitVariable(arunits[j], "Priority")
						end
					end
				end
			end
		end
		for i = 3,table.getn(costs) do
			if costs[i] > costs[enemy] then
				enemy = i
			end
		end
		if (costs[enemy] > 20) then
			local x = GetUnitVariable(units[enemy], "PosX")
			local y = GetUnitVariable(units[enemy], "PosY")
			x = x + math.floor(UnitManager:GetSlotUnit(units[enemy]).Type.TileWidth / 2)
			y = y + math.floor(UnitManager:GetSlotUnit(units[enemy]).Type.TileHeight / 2)
			return x, y
		else 
			return -1, -1
		end
	else
		return -1, -1
	end
end
--

DefineSpell("spell-far-seeing",
	"showname", "Far Seeing",
	"manacost", 35,
	"range", "infinite",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-revealer", "time-to-live", 1000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "vision",
	"depend-upgrade", "upgrade-far-seeing"
)

DefineSpell("spell-dark-vision",
	"showname", "Dark Vision",
	"manacost", 35,
	"range", "infinite",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-revealer", "time-to-live", 1000},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "vision",
	"depend-upgrade", "upgrade-dark-vision"
)

DefineSpell("spell-healing",
	"showname", "Healing",
	"manacost", 2,
	"range", 8,
	"target", "unit",
	"repeat-cast",
        "cooldown", 120,
	"action", {{"adjust-vitals", "hit-points", 1},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"organic", "only",
		"Building", "false",
		"HitPoints", {MaxValuePercent = 100}
	},
	"sound-when-cast", "healing",
	"depend-upgrade", "upgrade-healing",
	"autocast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}},
	"ai-cast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}}
)

DefineSpell("spell-raise-dead",
	"showname", "raise dead",
	"manacost", 25,
	"range", 5,
	"repeat-cast",
	"target", "position",
        "cooldown", 120,
	"action", {
           {"summon", "unit-type", "unit-the-dead", "time-to-live", 4500, "require-corpse"},
	   {"adjust-variable", {Mana = {Max = 1, Value = 0}}},
           {"spawn-missile", "missile", "missile-normal-spell",
            "start-point", {"base", "target"}}
        },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-raise-dead",
	"autocast", {"range", 6, "corpse", "only", "priority", {"Distance", false}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 6, "corpse", "only", "priority", {"Distance", false}, "position-autocast", SpellBlizzard}
)

DefineSpell("spell-unholy-armor",
	"showname", "unholyarmor",
	"manacost", 55,
	"range", 8,
	"target", "unit",
	"action", {{"lua-callback", SpellUnholyArmor},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
           "organic", "only",
           "UnholyArmor", {MaxValue = 10},
           "HitPoints", {MinValuePercent = 51}
        },
	"sound-when-cast", "unholy armor",
	"depend-upgrade", "upgrade-unholy-armor",
	"autocast", {"attacker", "only", "range", 9, "priority", {"Points", true}, "condition", {"Coward", "false", "alliance", "only"}},
	"ai-cast", {"attacker", "only", "range", 9, "priority", {"Points", true}, "condition", {"Coward", "false", "alliance", "only"}}

)

DefineSpell("spell-invisibility",
	"showname", "invisibility",
	"manacost", 40,
	"range", 8,
	"target", "unit",
	"action", {{"adjust-variable", {Invisible = 2000}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Invisible", {MaxValue = 10}},
	"sound-when-cast", "invisibility",
	"depend-upgrade", "upgrade-invisibility",
	"autocast", {"range", 6, "condition", {"AirUnit", "only", "alliance", "only"}},
	"ai-cast", {"range", 6, "combat", "false", "condition", {"LandUnit", "false", "alliance", "only"}}
)

DefineSpell("spell-summon-elemental",
	"showname", "summan elemental",
	"manacost", 60,
	"range", 2,
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-water-elemental", "time-to-live", 4500},
	   {"adjust-variable", {Mana = {Max = 1, Value = 0}}},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-water-elemental",
	"autocast", {"range", 5, "combat", "only", "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 4, "combat", "only", "position-autocast", SpellBlizzard}
)

DefineSpell("spell-summon-daemon",
	"showname", "summan daemon",
	"manacost", 60,
	"range", 2,
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-daemon", "time-to-live", 4500},
	   {"adjust-variable", {Mana = {Max = 1, Value = 0}}},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-daemon",
	"autocast", {"range", 5, "combat", "only", "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 4, "combat", "only", "position-autocast", SpellBlizzard}
)

DefineSpell("spell-summon-scorpions",
	"showname", "summon scorpions",
	"manacost", 30,
	"range", 3,
	"repeat-cast",
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-scorpion", "time-to-live", 4500},
	   {"adjust-variable", {Mana = {Max = 1, Value = 0}}},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-scorpion",
	"autocast", {"range", 6, "combat", "only", "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 4, "combat", "only", "position-autocast", SpellBlizzard}
)

DefineSpell("spell-summon-spiders",
	"showname", "summon spiders",
	"manacost", 30,
	"range", 3,
	"repeat-cast",
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-spider", "time-to-live", 4500},
	   {"adjust-variable", {Mana = {Max = 1, Value = 0}}},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-spider",
	"autocast", {"range", 6, "combat", "only", "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 4, "combat", "only", "position-autocast", SpellBlizzard}
)

DefineSpell("spell-poison-cloud",
	"showname", "poison cloud",
	"manacost", 7,
	"range", 9,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-poison-cloud",
		 "fields", 13,
		 "shards", 2,
		 "damage", 6}},
	"sound-when-cast", "blizzard",
	"depend-upgrade", "upgrade-poison-cloud",
    "autocast", {"range", 9, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 9, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard}
)

DefineSpell("spell-rain-of-fire",
	"showname", "Rain of Fire",
	"manacost", 20,
	"range", 9,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-rain-of-fire",
		 "fields", 8,
		 "shards", 5,
		 "damage", 13,
		 --  128=4*32=4 tiles
		 "start-offset-x", 0,
		 "start-offset-y", -32}},
	"sound-when-cast", "blizzard",
	"autocast", {"range", 9, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard},
	"ai-cast", {"range", 9, "priority", {"Priority", true}, "condition", {"opponent", "only"}, "position-autocast", SpellBlizzard}
)

DefineSpell("spell-slow",
	"showname", _("Slow"),
	"manacost", 0,
	"range", 5,
	"target", "unit",
	 "cooldown", 1000,
	"action", {{"adjust-variable", {Slow = 500, Haste = 0}},
		{"spawn-missile", "missile", "missile-web",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Slow", {ExactValue = 0}},
	"sound-when-cast", "raise dead", 
	"autocast", {"range", 10, "condition", {"Coward", "false", "opponent", "only"}},
	"ai-cast", {"range", 10, "combat", "only", "condition", {"Coward", "false", "opponent", "only"}}
)

DefineSpell("spell-poison",
	"showname", _("poison"),
	"manacost", 0,
	"range", 1,
	"target", "unit",
	 "cooldown", 1000,
	"action", {{"adjust-variable", {Poison = 500}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Slow", {ExactValue = 0}},
	"sound-when-cast", "raise dead", 
	"autocast", {"range", 10, "condition", {"Coward", "false", "opponent", "only"}},
	"ai-cast", {"range", 10, "combat", "only", "condition", {"Coward", "false", "opponent", "only"}}
)

DefineSpell("spell-freeze",
	"showname", _("Slow"),
	"manacost", 35,
	"range", 5,
	"target", "unit",
	 "cooldown", 150,
	"action", {{"adjust-variable", {Slow = 800, Haste = 0}},
		{"spawn-missile", "missile", "missile-iceshard",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Slow", {ExactValue = 0}},
	"sound-when-cast", "raise dead", 
	"autocast", {"range", 10, "condition", {"Coward", "false", "opponent", "only"}},
	"ai-cast", {"range", 10, "combat", "only", "condition", {"Coward", "false", "opponent", "only"}}
)

DefineSpell("spell-hail",
	"showname", _("flame shield"),
	"manacost", 30,
	"range", 6,
	"target", "unit",
	"action", {
		{"spawn-missile", "missile", "missile-hail", "ttl", 600, "damage", 2},
		{"spawn-missile", "missile", "missile-hail", "ttl", 607, "damage", 0},
		{"spawn-missile", "missile", "missile-hail", "ttl", 614, "damage", 0},
		{"spawn-missile", "missile", "missile-hail", "ttl", 621, "damage", 0},
		{"spawn-missile", "missile", "missile-hail", "ttl", 628, "damage", 0}
	},
	-- I think it's better if we can cast it multiple times and the effects stack.
	-- Can be casted, and is effective on both allies and enemies
	"condition", {"Building", "false", "AirUnit", "false"},
	"sound-when-cast", "raise dead", 
	--"depend-upgrade", "upgrade-flame-shield",
	"autocast", {"range", 6, "attacker", "only", "condition", {"Coward", "false"}}
)
