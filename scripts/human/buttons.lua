--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--			  T H E   W A R   B E G I N S
--	   Stratagus - A free fantasy real time strategy game engine
--
--	buttons.ccl	-	Define the", "unit-buttons of the human race.
--
--	(c) Copyright 2001-2003 by Vladi Belperchinov-Shabanski and Lutz Sammer
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
--	$Id$

------------------------------------------------------------------------------
--	Define", "unit-button.
--
--	DefineButton( { Pos = n, Level = n 'icon ident Action = name ['value value]
--		['allowed check ['values]] Key = key, Hint = hint 'for-unit", "units)
--

-- general commands -- almost all", "units have it -------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peasant",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-peasant",
    "unit-female-hero",
    "unit-flying-angle", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-white-mage", "unit-balloon",
    "unit-gryphon-rider", "unit-mage",
    "human-group"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
  Action = "stop",
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-peasant",
    "unit-female-hero",
    "unit-flying-angle", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-white-mage", "unit-balloon",
    "unit-gryphon-rider", "unit-mage",
    "human-group"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield1"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield2"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-peasant",
    "unit-female-hero",
    "unit-flying-angle", "unit-arthor-literios", "unit-knight-rider", "unit-wise-man",
    "unit-man-of-light", "unit-white-mage", "unit-gryphon-rider", "human-group"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-sword1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-sword2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-footman", "unit-knight", "unit-archer",
    "unit-dwarves", "unit-human-catapult", "unit-arthor-literios", "unit-knight-rider",
    "unit-wise-man", "unit-man-of-light"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-archer", "unit-female-hero"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-archer", "unit-female-hero"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-archer", "unit-female-hero"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-attack-ground",
  Action = "attack-ground",
  Key = "g", Hint = "ATTACK ~!GROUND",
  ForUnit = {"unit-human-catapult", "human-group"} } )

-- paladin specific actions ---------------------------------------------------

--(if extensions
--DefineButton( { Pos = 6, Level = 0, Icon = "icon-heal
--  Action = "cast-spell", Value = "spell-area-healing
--  Allowed = "check-upgrade", AllowArg = {"upgrade-area-healing)
--  Key = "l", Hint = "AREA HEA~!LING (per 1 HP)",
--  ForUnit = {"unit-paladin", "unit-knight-rider 
--    "unit-man-of-light"} } )
--)

DefineButton( { Pos = 7, Level = 0, Icon = "icon-holy-vision",
  Action = "cast-spell", Value = "spell-holy-vision",
  Allowed = "check-upgrade", AllowArg = {"upgrade-holy-vision"},
  Key = "v", Hint = "HOLY ~!VISION",
  ForUnit = {"unit-paladin", "unit-knight-rider",
    "unit-man-of-light"} } )

DefineButton( { Pos = 8, Level = 0, Icon = "icon-heal",
  Action = "cast-spell", Value = "spell-healing",
  Allowed = "check-upgrade", AllowArg = {"upgrade-healing"},
  Key = "h", Hint = "~!HEALING (per 1 HP)",
  ForUnit = {"unit-paladin", "unit-knight-rider",
    "unit-man-of-light"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-exorcism",
  Action = "cast-spell", Value = "spell-exorcism",
  Allowed = "check-upgrade", AllowArg = {"upgrade-exorcism"},
  Key = "e", Hint = "~!EXORCISM",
  ForUnit = {"unit-paladin", "unit-knight-rider",
    "unit-man-of-light"} } )

-- mage specific actions ------------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-lightning",
  Action = "attack",
  Key = "a", Hint = "LIGHTNING ~!ATTACK",
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-fireball",
  Action = "cast-spell", Value = "spell-fireball",
  Allowed = "check-upgrade", AllowArg = {"upgrade-fireball"},
  Key = "f", Hint = "~!FIREBALL",
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-slow",
  Action = "cast-spell", Value = "spell-slow",
  Allowed = "check-upgrade", AllowArg = {"upgrade-slow"},
  Key = "o", Hint = "SL~!OW",
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-flame-shield",
  Action = "cast-spell", Value = "spell-flame-shield",
  Allowed = "check-upgrade", AllowArg = {"upgrade-flame-shield"},
  Key = "l", Hint = "F~!LAME SHIELD",
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 7, Level = 0, Icon = "icon-invisibility",
  Action = "cast-spell", Value = "spell-invisibility",
  Allowed = "check-upgrade", AllowArg = {"upgrade-invisibility"},
  Key = "i", Hint = "~!INVISIBILITY",
  ForUnit = {"unit-mage", "unit-white-mage"} } )

DefineButton( { Pos = 9, Level = 0, Icon = "icon-blizzard",
  Action = "cast-spell", Value = "spell-blizzard",
  Allowed = "check-upgrade", AllowArg = {"upgrade-blizzard"},
  Key = "b", Hint = "~!BLIZZARD",
  ForUnit = {"unit-mage", "unit-white-mage"} } )

-- peasant specific actions ---------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-repair",
  Action = "repair",
  Key = "r", Hint = "~!REPAIR",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-harvest",
  Action = "harvest",
  Key = "h", Hint = "~!HARVEST LUMBER/MINE GOLD",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-return-goods",
  Action = "return-goods",
  Key = "t", Hint = "RETURN GOODS TO ~!TOWN HALL",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-build-basic",
  Action = "button", Value = 1,
  Key = "b", Hint = "BUILD ~!BASIC STRUCTURE",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-build-advanced",
  Action = "button", Value = 2,
  Allowed = "check-units-or", AllowArg = {"unit-human-lumber-mill"},
  Key = "a", Hint = "BUILD ~!ADVANCED STRUCTURE",
  ForUnit = {"unit-peasant"} } )

-- simple buildings human -----------------------------------------------------

DefineButton( { Pos = 1, Level = 1, Icon = "icon-human-farm",
  Action = "build", Value = "unit-human-farm",
  Key = "f", Hint = "BUILD ~!FARM",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 2, Level = 1, Icon = "icon-human-lumber-mill",
  Action = "build", Value = "unit-human-lumber-mill",
  Key = "l", Hint = "BUILD ~!LUMBER MILL",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 3, Level = 1, Icon = "icon-human-barracks",
  Action = "build", Value = "unit-human-barracks",
  Key = "b", Hint = "BUILD ~!BARRACKS",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 6, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> - CANCEL",
  ForUnit = {"unit-peasant"} } )

-- human advanced buildings ---------------------------------------------------

DefineButton( { Pos = 1, Level = 2, Icon = "icon-human-blacksmith",
  Action = "build", Value = "unit-human-blacksmith",
  Key = "b", Hint = "BUILD ~!BLACKSMITH",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 2, Level = 2, Icon = "icon-human-church",
  Action = "build", Value = "unit-human-church",
  Key = "u", Hint = "BUILD CH~!URCH",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 3, Level = 2, Icon = "icon-human-stable",
  Action = "build", Value = "unit-human-stable",
  Key = "s", Hint = "BUILD ~!STABLE",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 4, Level = 2, Icon = "icon-human-tower",
  Action = "build", Value = "unit-human-tower",
  Key = "t", Hint = "BUILD ~!TOWER",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 6, Level = 2, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> - CANCEL",
  ForUnit = {"unit-peasant"} } )

-- town hall commands ---------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-peasant",
  Action = "train-unit", Value = "unit-peasant",
  Allowed = "check-no-research",
  Key = "p", Hint = "TRAIN ~!PEASANT",
  ForUnit = {"unit-human-town-hall"} } )

--[[
DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-road",
  Action = "build", Value = "unit-human-road",
  Key = "r", Hint = "BUILD ~!ROAD",
  ForUnit = {"unit-human-town-hall"} } )
]]

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-wall",
  Action = "build", Value = "unit-human-wall",
  Key = "w", Hint = "BUILD ~!WALL",
  ForUnit = {"unit-human-town-hall"} } )


-- training commands ---------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-footman",
  Action = "train-unit", Value = "unit-footman",
  Key = "f", Hint = "TRAIN ~!FOOTMAN",
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-archer",
  Action = "train-unit", Value = "unit-archer",
  Key = "a", Hint = "TRAIN ~!ARCHER",
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-catapult",
  Action = "train-unit", Value = "unit-human-catapult",
  Key = "b", Hint = "BUILD ~!CATAPULT",
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-knight",
  Action = "train-unit", Value = "unit-knight",
  Key = "k", Hint = "TRAIN ~!KNIGHT",
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-conjurer",
  Action = "train-unit", Value = "unit-conjurer",
  Key = "t", Hint = "TRAIN ~!CONJURER",
  ForUnit = {"unit-human-tower"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-cleric",
  Action = "train-unit", Value = "unit-cleric",
  Key = "c", Hint = "TRAIN ~!CLERIC",
  ForUnit = {"unit-human-church"} } )

-- upgrades -------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-sword2",
  Action = "research", Value = "upgrade-sword1",
  Allowed = "check-single-research",
  Key = "w", Hint = "UPGRADE S~!WORD STRENGTH",
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-sword3",
  Action = "research", Value = "upgrade-sword2",
  Allowed = "check-single-research",
  Key = "w", Hint = "UPGRADE S~!WORD STRENGTH",
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
  Action = "research", Value = "upgrade-human-shield1",
  Allowed = "check-single-research",
  Key = "h", Hint = "UPGRADE S~!HIELD STRENGTH",
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
  Action = "research", Value = "upgrade-human-shield2",
  Allowed = "check-single-research",
  Key = "h", Hint = "UPGRADE S~!HIELD STRENGTH",
  ForUnit = {"unit-human-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow2",
  Action = "research", Value = "upgrade-arrow1",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!UPGRADE ARROW STRENGTH",
  ForUnit = {"unit-human-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow3",
  Action = "research", Value = "upgrade-arrow2",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!UPGRADE ARROW STRENGTH",
  ForUnit = {"unit-human-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-horse1",
  Action = "research", Value = "upgrade-horse1",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!BREED FASTER HORSES",
  ForUnit = {"unit-human-stable"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-horse2",
  Action = "research", Value = "upgrade-horse2",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!BREED FASTER HORSES",
  ForUnit = {"unit-human-stable"} } )

-- spells -------------------------------------------------------------------

DefineButton( { Pos = 2, Level = 0, Icon = "icon-healing",
  Action = "research", Value = "upgrade-healing",
  Allowed = "check-single-research",
  Key = "h", Hint = "RESEARCH ~!HEALING",
  ForUnit = {"unit-human-church"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-far-seeing",
  Action = "research", Value = "upgrade-far-seeing",
  Allowed = "check-single-research",
  Key = "e", Hint = "RESEARCH ~!FAR SEEING",
  ForUnit = {"unit-human-church"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-invisibility",
  Action = "research", Value = "upgrade-invisibility",
  Allowed = "check-single-research",
  Key = "o", Hint = "RESEARCH ~!INVISIBILITY",
  ForUnit = {"unit-human-church"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-scorpion",
  Action = "research", Value = "upgrade-scorpion",
  Allowed = "check-single-research",
  Key = "b", Hint = "RESEARCH ~!MINOR SUMMONING",
  ForUnit = {"unit-human-tower"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-rain-of-fire",
  Action = "research", Value = "upgrade-rain-of-fire",
  Allowed = "check-single-research",
  Key = "b", Hint = "RESEARCH ~!RAIN OF FIRE",
  ForUnit = {"unit-human-tower"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-water-elemental",
  Action = "research", Value = "upgrade-water-elemental",
  Allowed = "check-single-research",
  Key = "b", Hint = "RESEARCH ~!MAJOR SUMMONING",
  ForUnit = {"unit-human-tower"} } )

