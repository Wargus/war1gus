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
DefineVariables("Mana", {Max = 100, Value = 64, Increase = 1, Enable = false}, "Speed", "ShadowFly", {Max = 2}, "Level")

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


DefineSpell("spell-far-seeing",
	"showname", "Far Seeing",
	"manacost", 70,
	"range", "infinite",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-revealer", "time-to-live", 25},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "vision",
	"depend-upgrade", "upgrade-far-seeing"
)

DefineSpell("spell-dark-vision",
	"showname", "Dark Vision",
	"manacost", 70,
	"range", "infinite",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-revealer", "time-to-live", 25},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "vision",
	"depend-upgrade", "upgrade-dark-vision"
)

DefineSpell("spell-healing",
	"showname", "Healing",
	"manacost", 6,
	"range", 8,
	"target", "unit",
	"repeat-cast",
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
	"autocast", {"range", 6, "condition", {"alliance", "only", "HitPoints", {MaxValuePercent = 90}}}
)

DefineSpell("spell-raise-dead",
	"showname", "raise dead",
	"manacost", 25,
	"range", 5,
	"repeat-cast",
	"target", "position",
	"action", {{"summon", "unit-type", "unit-the-dead", "time-to-live", 4500, "require-corpse"},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-raise-dead"
--	"autocast", {"range", 6}
)

DefineSpell("spell-unholy-armor",
	"showname", "unholyarmor",
	"manacost", 60,
	"range", 8,
	"target", "unit",
	"action", {{"adjust-variable", {UnholyArmor = 500},
		   {"adjust-vitals", "hit-points", 20}}, -- TODO: This should be 50% of the current HP
		   {"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"organic", "only",
		"UnholyArmor", {MaxValue = 10},
		"HitPoints", {MaxValuePercent = 100}},
	"sound-when-cast", "unholy armor",
	"depend-upgrade", "upgrade-unholy-armor"
--	"autocast", {range 6 condition (Coward false alliance only)},
)

DefineSpell("spell-invisibility",
	"showname", "invisibility",
	"manacost", 60,
	"range", 8,
	"target", "unit",
	"action", {{"adjust-variable", {Invisible = 2000}},
		{"spawn-missile", "missile", "missile-normal-spell",
			"start-point", {"base", "target"}}},
	"condition", {
		"Building", "false",
		"Invisible", {MaxValue = 10}},
	"sound-when-cast", "invisibility",
	"depend-upgrade", "upgrade-invisibility"
--	"autocast", {"range", 6, "condition", {"Coward", "false"}},
)

DefineSpell("spell-summon-scorpions",
	"showname", "summon scorpions",
	"manacost", 20,
	"range", 3,
	"repeat-cast",
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-scorpion", "time-to-live", 4500},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-scorpion"
--	"autocast", {"range", 6}
)

DefineSpell("spell-summon-elemental",
	"showname", "summan elemental",
	"manacost", 60,
	"range", 3,
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-water-elemental", "time-to-live", 4500},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-water-elemental"
--	"autocast", {"range", 6}
)

DefineSpell("spell-rain-of-fire",
	"showname", "Rain of Fire",
	"manacost", 25,
	"range", 9,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-rain-of-fire",
		 "fields", 5,
		 "shards", 10,
		 "damage", 10}},
	"sound-when-cast", "blizzard",
	"depend-upgrade", "upgrade-rain-of-fire"
--	"autocast", {range 12)
)

DefineSpell("spell-summon-spiders",
	"showname", "summon spiders",
	"manacost", 20,
	"range", 3,
	"repeat-cast",
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-spider", "time-to-live", 4500},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-spider"
--	"autocast", {"range", 6}
)

DefineSpell("spell-summon-daemon",
	"showname", "summan daemon",
	"manacost", 60,
	"range", 3,
	"target", "position",
	"action", {
	   {"summon", "unit-type", "unit-daemon", "time-to-live", 4500},
	   {"spawn-missile", "missile", "missile-normal-spell", "start-point", {"base", "target"}}
		  },
	"sound-when-cast", "raise dead",
	"depend-upgrade", "upgrade-daemon"
--	"autocast", {"range", 6}
)

DefineSpell("spell-poison-cloud",
	"showname", "poison cloud",
	"manacost", 25,
	"range", 9,
	"repeat-cast",
	"target", "position",
	"action", {{"area-bombardment", "missile", "missile-poison-cloud",
		 "fields", 5,
		 "shards", 10,
		 "damage", 10,
		 --  128=4*32=4 tiles
		 "start-offset-x", -128,
		 "start-offset-y", -128}},
	"sound-when-cast", "blizzard",
	"depend-upgrade", "upgrade-poison-cloud"
--	"autocast", {range 12)
)
