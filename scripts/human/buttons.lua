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
    "unit-human-catapult", "unit-peasant",
    "unit-water-elemental", "unit-scorpion",
    "unit-cleric", "unit-conjurer", "unit-medivh", "unit-lothar",
    "human-group" } } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-horse1",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = { "unit-knight1" } } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-horse2",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = { "unit-knight2" } } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
  Action = "stop",
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-footman", "unit-archer",
    "unit-knight", "unit-knight1", "unit-knight2",
    "unit-human-catapult", "unit-peasant",
    "unit-water-elemental", "unit-scorpion",
    "unit-cleric", "unit-conjurer", "unit-medivh", "unit-lothar",
    "human-group"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield1"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-footman", "unit-archer",
    "unit-knight", "unit-knight1", "unit-knight2",
    "unit-human-catapult"}} )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield3",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-shield2"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-footman", "unit-archer",
    "unit-knight", "unit-knight1", "unit-knight2",
    "unit-human-catapult"}} )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-footman", "unit-archer",
    "unit-knight", "unit-knight1", "unit-knight2",
    "unit-water-elemental", "unit-scorpion", "unit-lothar",
    "unit-human-catapult", "human-group"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-sword1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-footman", "unit-archer",
    "unit-knight", "unit-knight1", "unit-knight2",
    "unit-human-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-sword3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-sword2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-footman", "unit-archer",
    "unit-knight", "unit-knight1", "unit-knight2",
    "unit-human-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-archer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-archer"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-arrow3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-archer"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-attack-ground",
  Action = "attack-ground",
  Key = "g", Hint = "ATTACK ~!GROUND",
  ForUnit = {"unit-human-catapult", "human-group"} } )

-- cleric specific actions ---------------------------------------------------


DefineButton( { Pos = 3, Level = 0, Icon = "icon-holy-lance",
  Action = "attack",
  Key = "a", Hint = "HOLY LANCE ~!ATTACK",
  ForUnit = {"unit-cleric"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-healing",
  Action = "cast-spell", Value = "spell-healing",
  Allowed = "check-upgrade", AllowArg = {"upgrade-healing"},
  Key = "h", Hint = "~!HEALING (per 1 HP)",
  ForUnit = {"unit-cleric"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-far-seeing",
  Action = "cast-spell", Value = "spell-far-seeing",
  Allowed = "check-upgrade", AllowArg = {"upgrade-far-seeing"},
  Key = "s", Hint = "FAR ~!SEEING",
  ForUnit = {"unit-cleric"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-invisibility",
  Action = "cast-spell", Value = "spell-invisibility",
  Allowed = "check-upgrade", AllowArg = {"upgrade-invisibility"},
  Key = "i", Hint = "~!INVISIBILITY",
  ForUnit = {"unit-cleric"} } )

-- conjurer specific actions ------------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-fireball",
  Action = "attack",
  Key = "a", Hint = "FIREBALL ~!ATTACK",
  ForUnit = {"unit-conjurer"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-scorpion",
  Action = "cast-spell", Value = "spell-summon-scorpions",
  Allowed = "check-upgrade", AllowArg = {"upgrade-scorpion"},
  Key = "u", Hint = "S~!UMMON SCORPIONS",
  ForUnit = {"unit-conjurer"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-rain-of-fire",
  Action = "cast-spell", Value = "spell-rain-of-fire",
  Allowed = "check-upgrade", AllowArg = {"upgrade-rain-of-fire"},
  Key = "r", Hint = "~!RAIN OF FIRE",
  ForUnit = {"unit-conjurer"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-water-elemental",
  Action = "cast-spell", Value = "spell-summon-elemental",
  Allowed = "check-upgrade", AllowArg = {"upgrade-water-elemental"},
  Key = "e", Hint = "SUMMON E~!LEMENTAL",
  ForUnit = {"unit-conjurer"} } )

-- peasant specific actions ---------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-repair",
  Action = "repair",
  Key = "r", Hint = "~!REPAIR",
  ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-harvest",
  Action = "harvest",
  Key = "h", Hint = "~!HARVEST WOOD/MINE GOLD",
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

if (preferences.AllowMultipleTownHalls) then
  DefineButton( { Pos = 4, Level = 1, Icon = "icon-human-town-hall",
    Action = "build", Value = "unit-human-town-hall",
    Key = "t", Hint = "BUILD ~!TOWN HALL",
    ForUnit = {"unit-peasant"} } )
else
  DefineButton( { Pos = 4, Level = 1, Icon = "icon-human-town-hall",
    Action = "build", Value = "unit-human-town-hall",
    Allowed = "check-units-not", AllowArg = {"unit-human-town-hall"},
    Key = "t", Hint = "BUILD ~!TOWN HALL",
    ForUnit = {"unit-peasant"} } )
end

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
  ForUnit = {"unit-human-town-hall", "unit-human-stormwind-keep"} } )

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

DefineButton( { Pos = 4, Level = 0, Icon = "icon-knight",
  Action = "train-unit", Value = "unit-knight1",
  Key = "k", Hint = "TRAIN ~!KNIGHT",
  Allowed = "check-upgrade", AllowArg = {"upgrade-horse1"},
  ForUnit = {"unit-human-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-knight",
  Action = "train-unit", Value = "unit-knight2",
  Key = "k", Hint = "TRAIN ~!KNIGHT",
  Allowed = "check-upgrade", AllowArg = {"upgrade-horse2"},
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
  Key = "b", Hint = "~!BREED FASTER HORSES",
  ForUnit = {"unit-human-stable"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-horse2",
  Action = "research", Value = "upgrade-horse2",
  Allowed = "check-single-research",
  Key = "b", Hint = "~!BREED FASTER HORSES",
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
  Key = "f", Hint = "RESEARCH ~!FAR SEEING",
  ForUnit = {"unit-human-church"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-invisibility",
  Action = "research", Value = "upgrade-invisibility",
  Allowed = "check-single-research",
  Key = "i", Hint = "RESEARCH ~!INVISIBILITY",
  ForUnit = {"unit-human-church"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-scorpion",
  Action = "research", Value = "upgrade-scorpion",
  Allowed = "check-single-research",
  Key = "s", Hint = "RESEARCH SUMMON ~!SCORPIONS",
  ForUnit = {"unit-human-tower"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-rain-of-fire",
  Action = "research", Value = "upgrade-rain-of-fire",
  Allowed = "check-single-research",
  Key = "r", Hint = "RESEARCH ~!RAIN OF FIRE",
  ForUnit = {"unit-human-tower"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-water-elemental",
  Action = "research", Value = "upgrade-water-elemental",
  Allowed = "check-single-research",
  Key = "e", Hint = "RESEARCH SUMMON ~!ELEMENTAL",
  ForUnit = {"unit-human-tower"} } )
