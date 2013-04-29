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
--      upgrade.lua - Define the orcish dependencies and upgrades.
--
--      (c) Copyright 2001-2004 by Lutz Sammer and Jimmy Salmon
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

--	NOTE: Save can generate this table.

upgrades = {
  {"upgrade-axe1", "icon-axe2",
    {   200,   750,     0,     0,     0,     0,     0}},
  {"upgrade-axe2", "icon-axe3",
    {   250,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-spear1", "icon-spear2",
    {   200,   750,     0,     0,     0,     0,     0}},
  {"upgrade-spear2", "icon-spear3",
    {   250,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-wolves1", "icon-wolves1",
    {   200,   750,     0,     0,     0,     0,     0}},
  {"upgrade-wolves2", "icon-wolves2",
    {   250,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-orc-shield1", "icon-orc-shield2",
    {   200,   750,     0,     0,     0,     0,     0}},
  {"upgrade-orc-shield2", "icon-orc-shield3",
    {   250,  1500,     0,     0,     0,     0,     0}},

  {"upgrade-raise-dead", "icon-raise-dead",
    {   200,   750,     0,     0,     0,     0,     0}},
  {"upgrade-dark-vision", "icon-dark-vision",
    {   150,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-unholy-armor", "icon-unholy-armor",
    {   200,  3000,     0,     0,     0,     0,     0}},

  {"upgrade-spider", "icon-spider",
    {   200,   750,     0,     0,     0,     0,     0}},
  {"upgrade-poison-cloud", "icon-poison-cloud",
    {   150,  1500,     0,     0,     0,     0,     0}},
  {"upgrade-daemon", "icon-daemon",
    {   200,  3000,     0,     0,     0,     0,     0}},
}

for i = 1,table.getn(upgrades) do
  u = CUpgrade:New(upgrades[i][1])
  u.Icon = Icons[upgrades[i][2]]
  for j = 1,table.getn(upgrades[i][3]) do
    u.Costs[j - 1] = upgrades[i][3][j]
  end
end

--	NOTE: Save can generate this table.

DefineModifier("upgrade-axe1",
  {"PiercingDamage", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-raider"})
DefineModifier("upgrade-axe2",
  {"PiercingDamage", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-raider"})

DefineModifier("upgrade-spear1",
  {"PiercingDamage", 1},
  {"apply-to", "unit-spearman"})
DefineModifier("upgrade-spear2",
  {"PiercingDamage", 1},
  {"apply-to", "unit-spearman"})

DefineModifier("upgrade-wolves1",
--  {"Speed", 1},
  {"apply-to", "unit-raider"})
DefineModifier("upgrade-wolves2",
--  {"Speed", 1},
  {"apply-to", "unit-raider"})

DefineModifier("upgrade-orc-shield1",
  {"Armor", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-raider"})
DefineModifier("upgrade-orc-shield2",
  {"Armor", 2},
  {"apply-to", "unit-grunt"}, {"apply-to", "unit-raider"})

DefineModifier("upgrade-raise-dead",
  {"apply-to", "unit-necrolyte"})
DefineModifier("upgrade-dark-vision",
  {"apply-to", "unit-necrolyte"})
DefineModifier("upgrade-unholy-armor",
  {"apply-to", "unit-necrolyte"})

DefineModifier("upgrade-spider",
  {"apply-to", "unit-warlock"})
DefineModifier("upgrade-poison-cloud",
  {"apply-to", "unit-warlock"})
DefineModifier("upgrade-daemon",
  {"apply-to", "unit-warlock"})

--	NOTE: Save can generate this table.

DefineAllow("unit-grunt",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-peon",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-catapult",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-raider",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-spearman",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-necrolyte",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-warlock",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-farm",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-barracks",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-temple",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-kennel",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-town-hall",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-lumber-mill",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-tower",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-blacksmith",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-start-location",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-orc-wall",			"AAAAAAAAAAAAAAAA")

--- upgrades

DefineAllow("upgrade-axe1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-axe2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-spear1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-spear2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-wolves1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-wolves2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-shield1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-orc-shield2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-raise-dead",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-dark-vision",		"RRRRRRRRRRRRRRRR")
DefineAllow("upgrade-unholy-armor",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-spider",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-poison-cloud",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-daemon",		"AAAAAAAAAAAAAAAA")

--	NOTE: Save can generate this table.

--- orc land forces
DefineDependency("unit-spearman",
  {"unit-orc-lumber-mill"})
DefineDependency("unit-orc-catapult",
  {"unit-orc-blacksmith", "unit-orc-lumber-mill"})
DefineDependency("unit-raider",
  {"unit-orc-kennel", "unit-orc-blacksmith"})

--- orc buildings
DefineDependency("unit-orc-blacksmith",
  {"unit-orc-lumber-mill"})
DefineDependency("unit-orc-kennel",
  {"unit-orc-lumber-mill"})
DefineDependency("unit-orc-temple",
  {"unit-orc-lumber-mill"})
DefineDependency("unit-orc-tower",
  {"unit-orc-blacksmith"})

--- orc upgrades/research
DefineDependency("upgrade-axe2",
  {"upgrade-axe1"})
DefineDependency("upgrade-spear2",
  {"upgrade-spear1"})
DefineDependency("upgrade-wolves2",
  {"upgrade-wolves1"})
DefineDependency("upgrade-orc-shield2",
  {"upgrade-orc-shield1"})
