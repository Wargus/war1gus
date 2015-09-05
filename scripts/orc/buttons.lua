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
--	buttons.ccl	-	Define the", "unit-buttons of the orc race.
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

DefineButton( { Pos = 1, Level = 0, Icon = "icon-move-peon",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = {"unit-grunt", "unit-raider", "unit-spearman",
    "unit-orc-catapult", "unit-peon",
    "unit-daemon", "unit-spider",
    "unit-necrolyte", "unit-warlock", "unit-garona", "unit-griselda",
    "orc-group" } } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-wolves1",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = {"unit-raider1"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-wolves2",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  ForUnit = {"unit-raider2"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield1",
  Action = "stop",
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-grunt", "unit-spearman",
    "unit-raider", "unit-raider1", "unit-raider2",
    "unit-orc-catapult", "unit-peon",
    "unit-daemon", "unit-spider",
    "unit-necrolyte", "unit-warlock", "unit-garona", "unit-griselda",
    "orc-group"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-shield1"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-grunt", "unit-spearman",
    "unit-raider", "unit-raider1", "unit-raider2",
    "unit-orc-catapult"}} )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield3",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-shield2"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-grunt", "unit-spearman",
    "unit-raider", "unit-raider1", "unit-raider2",
    "unit-orc-catapult"}} )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-axe1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-grunt", "unit-spearman",
    "unit-raider", "unit-raider1", "unit-raider2",
    "unit-daemon", "unit-spider",
    "unit-orc-catapult", "orc-group"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-axe2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-axe1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-grunt", "unit-spearman",
    "unit-raider", "unit-raider1", "unit-raider2",
    "unit-orc-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-axe3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-axe2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-grunt", "unit-spearman",
    "unit-raider", "unit-raider1", "unit-raider2",
    "unit-orc-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-spear1",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-spearman"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-spear2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-spear1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-spearman"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-spear3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-spear2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-spearman"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-orc-attack-ground",
  Action = "attack-ground",
  Key = "g", Hint = "ATTACK ~!GROUND",
  ForUnit = {"unit-orc-catapult", "orc-group"} } )

-- necrolyte specific actions ---------------------------------------------------


DefineButton( { Pos = 3, Level = 0, Icon = "icon-shadow-spear",
  Action = "attack",
  Key = "a", Hint = "SHADOW SPEAR ~!ATTACK",
  ForUnit = {"unit-necrolyte"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-raise-dead",
  Action = "cast-spell", Value = "spell-raise-dead",
  Allowed = "check-upgrade", AllowArg = {"upgrade-raise-dead"},
  Key = "r", Hint = "~!RAISE-DEAD",
  ForUnit = {"unit-necrolyte"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-dark-vision",
  Action = "cast-spell", Value = "spell-dark-vision",
  Allowed = "check-upgrade", AllowArg = {"upgrade-dark-vision"},
  Key = "v", Hint = "DARK ~!VISION",
  ForUnit = {"unit-necrolyte"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-unholy-armor",
  Action = "cast-spell", Value = "spell-unholy-armor",
  Allowed = "check-upgrade", AllowArg = {"upgrade-unholy-armor"},
  Key = "u", Hint = "~!UNHOLY-ARMOR",
  ForUnit = {"unit-necrolyte"} } )

-- warlock specific actions ------------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-fireball",
  Action = "attack",
  Key = "a", Hint = "FIREBALL ~!ATTACK",
  ForUnit = {"unit-warlock"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-spider",
  Action = "cast-spell", Value = "spell-summon-spiders",
  Allowed = "check-upgrade", AllowArg = {"upgrade-spider"},
  Key = "u", Hint = "S~!UMMON SPIDERS",
  ForUnit = {"unit-warlock"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-poison-cloud",
  Action = "cast-spell", Value = "spell-poison-cloud",
  Allowed = "check-upgrade", AllowArg = {"upgrade-poison-cloud"},
  Key = "p", Hint = "~!POISON CLOUD",
  ForUnit = {"unit-warlock"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-daemon",
  Action = "cast-spell", Value = "spell-summon-daemon",
  Allowed = "check-upgrade", AllowArg = {"upgrade-daemon"},
  Key = "d", Hint = "SUMMON D~!AEMON",
  ForUnit = {"unit-warlock"} } )

-- peon specific actions ---------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-repair",
  Action = "repair",
  Key = "r", Hint = "~!REPAIR",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-harvest",
  Action = "harvest",
  Key = "h", Hint = "~!HARVEST LUMBER/MINE GOLD",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-return-goods",
  Action = "return-goods",
  Key = "t", Hint = "RETURN GOODS TO ~!TOWN HALL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-build-basic",
  Action = "button", Value = 1,
  Key = "b", Hint = "BUILD ~!BASIC STRUCTURE",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 6, Level = 0, Icon = "icon-build-advanced",
  Action = "button", Value = 2,
  Allowed = "check-units-or", AllowArg = {"unit-orc-lumber-mill"},
  Key = "a", Hint = "BUILD ~!ADVANCED STRUCTURE",
  ForUnit = {"unit-peon"} } )

-- simple buildings -----------------------------------------------------

DefineButton( { Pos = 1, Level = 1, Icon = "icon-orc-farm",
  Action = "build", Value = "unit-orc-farm",
  Key = "f", Hint = "BUILD ~!FARM",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 1, Icon = "icon-orc-lumber-mill",
  Action = "build", Value = "unit-orc-lumber-mill",
  Key = "l", Hint = "BUILD ~!LUMBER MILL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 3, Level = 1, Icon = "icon-orc-barracks",
  Action = "build", Value = "unit-orc-barracks",
  Key = "b", Hint = "BUILD ~!BARRACKS",
  ForUnit = {"unit-peon"} } )

Load("preferences.lua")
if (preferences.AllowMultipleTownHalls) then
  DefineButton( { Pos = 4, Level = 1, Icon = "icon-orc-town-hall",
    Action = "build", Value = "unit-orc-town-hall",
    Key = "t", Hint = "BUILD ~!TOWN HALL",
    ForUnit = {"unit-peon"} } )
else
  DefineButton( { Pos = 4, Level = 1, Icon = "icon-orc-town-hall",
    Action = "build", Value = "unit-orc-town-hall",
    Allowed = "check-units-not", AllowArg = {"unit-orc-town-hall"},
    Key = "t", Hint = "BUILD ~!TOWN HALL",
    ForUnit = {"unit-peon"} } )
end

DefineButton( { Pos = 6, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> - CANCEL",
  ForUnit = {"unit-peon"} } )

-- advanced buildings ---------------------------------------------------

DefineButton( { Pos = 1, Level = 2, Icon = "icon-orc-blacksmith",
  Action = "build", Value = "unit-orc-blacksmith",
  Key = "b", Hint = "BUILD ~!BLACKSMITH",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 2, Level = 2, Icon = "icon-orc-temple",
  Action = "build", Value = "unit-orc-temple",
  Key = "u", Hint = "BUILD CH~!URCH",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 3, Level = 2, Icon = "icon-orc-kennel",
  Action = "build", Value = "unit-orc-kennel",
  Key = "s", Hint = "BUILD ~!KENNEL",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 4, Level = 2, Icon = "icon-orc-tower",
  Action = "build", Value = "unit-orc-tower",
  Key = "t", Hint = "BUILD ~!TOWER",
  ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 6, Level = 2, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "\27", Hint = "~<ESC~> - CANCEL",
  ForUnit = {"unit-peon"} } )

-- town hall commands ---------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-peon",
  Action = "train-unit", Value = "unit-peon",
  Allowed = "check-no-research",
  Key = "p", Hint = "TRAIN ~!PEON",
  ForUnit = {"unit-orc-town-hall", "unit-orc-blackrock-spire"} } )

-- training commands ---------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-grunt",
  Action = "train-unit", Value = "unit-grunt",
  Key = "f", Hint = "TRAIN ~!GRUNT",
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-spearman",
  Action = "train-unit", Value = "unit-spearman",
  Key = "a", Hint = "TRAIN ~!SPEARMAN",
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-catapult",
  Action = "train-unit", Value = "unit-orc-catapult",
  Key = "b", Hint = "BUILD ~!CATAPULT",
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-raider",
  Action = "train-unit", Value = "unit-raider",
  Key = "k", Hint = "TRAIN ~!RAIDER",
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-raider",
  Action = "train-unit", Value = "unit-raider1",
  Key = "k", Hint = "TRAIN ~!RAIDER",
  Allowed = "check-upgrade", AllowArg = {"upgrade-wolves1"},
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-raider",
  Action = "train-unit", Value = "unit-raider2",
  Key = "k", Hint = "TRAIN ~!RAIDER",
  Allowed = "check-upgrade", AllowArg = {"upgrade-wolves2"},
  ForUnit = {"unit-orc-barracks"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-warlock",
  Action = "train-unit", Value = "unit-warlock",
  Key = "t", Hint = "TRAIN ~!WARLOCK",
  ForUnit = {"unit-orc-tower"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-necrolyte",
  Action = "train-unit", Value = "unit-necrolyte",
  Key = "c", Hint = "TRAIN ~!NECROLYTE",
  ForUnit = {"unit-orc-temple"} } )

-- upgrades -------------------------------------------------------------------

DefineButton( { Pos = 1, Level = 0, Icon = "icon-axe2",
  Action = "research", Value = "upgrade-axe1",
  Allowed = "check-single-research",
  Key = "a", Hint = "UPGRADE ~!AXE STRENGTH",
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-axe3",
  Action = "research", Value = "upgrade-axe2",
  Allowed = "check-single-research",
  Key = "a", Hint = "UPGRADE ~!AXE STRENGTH",
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield2",
  Action = "research", Value = "upgrade-orc-shield1",
  Allowed = "check-single-research",
  Key = "s", Hint = "UPGRADE ~!SHIELD STRENGTH",
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield3",
  Action = "research", Value = "upgrade-orc-shield2",
  Allowed = "check-single-research",
  Key = "s", Hint = "UPGRADE ~!SHIELD STRENGTH",
  ForUnit = {"unit-orc-blacksmith"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-spear2",
  Action = "research", Value = "upgrade-spear1",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!UPGRADE SPEAR STRENGTH",
  ForUnit = {"unit-orc-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-spear3",
  Action = "research", Value = "upgrade-spear2",
  Allowed = "check-single-research",
  Key = "u", Hint = "~!UPGRADE SPEAR STRENGTH",
  ForUnit = {"unit-orc-lumber-mill"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-wolves1",
  Action = "research", Value = "upgrade-wolves1",
  Allowed = "check-single-research",
  Key = "b", Hint = "~!BREED FASTER WOLVES",
  ForUnit = {"unit-orc-kennel"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-wolves2",
  Action = "research", Value = "upgrade-wolves2",
  Allowed = "check-single-research",
  Key = "b", Hint = "~!BREED FASTER WOLVES",
  ForUnit = {"unit-orc-kennel"} } )

-- spells -------------------------------------------------------------------

DefineButton( { Pos = 2, Level = 0, Icon = "icon-raise-dead",
  Action = "research", Value = "upgrade-raise-dead",
  Allowed = "check-single-research",
  Key = "d", Hint = "RESEARCH RAISE ~!DEAD",
  ForUnit = {"unit-orc-temple"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-dark-vision",
  Action = "research", Value = "upgrade-dark-vision",
  Allowed = "check-single-research",
  Key = "v", Hint = "RESEARCH DARK ~!VISION",
  ForUnit = {"unit-orc-temple"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-unholy-armor",
  Action = "research", Value = "upgrade-unholy-armor",
  Allowed = "check-single-research",
  Key = "a", Hint = "RESEARCH UNHOLY ~!ARMOR",
  ForUnit = {"unit-orc-temple"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-spider",
  Action = "research", Value = "upgrade-spider",
  Allowed = "check-single-research",
  Key = "s", Hint = "RESEARCH SUMMON ~!SPIDERS",
  ForUnit = {"unit-orc-tower"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-poison-cloud",
  Action = "research", Value = "upgrade-poison-cloud",
  Allowed = "check-single-research",
  Key = "p", Hint = "RESEARCH ~!POISON CLOUD",
  ForUnit = {"unit-orc-tower"} } )

DefineButton( { Pos = 4, Level = 0, Icon = "icon-daemon",
  Action = "research", Value = "upgrade-daemon",
  Allowed = "check-single-research",
  Key = "d", Hint = "RESEARCH SUMMON ~!DAEMON",
  ForUnit = {"unit-orc-tower"} } )
