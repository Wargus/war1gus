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
--      upgrade.ccl - Define the human dependencies and upgrades.
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

DefineUpgrade("upgrade-sword1", "icon", "icon-sword2",
  "costs", {   200,   750,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-sword2", "icon", "icon-sword3",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-arrow1", "icon", "icon-arrow2",
  "costs", {   200,   750,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-arrow2", "icon", "icon-arrow3",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-horse1", "icon", "icon-horse1",
  "costs", {   200,   750,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-horse2", "icon", "icon-horse2",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-human-shield1", "icon", "icon-human-shield2",
  "costs", {   200,   750,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-human-shield2", "icon", "icon-human-shield3",
  "costs", {   250,  1500,     0,     0,     0,     0,     0})

DefineUpgrade("upgrade-healing", "icon", "icon-healing",
  "costs", {     0,   750,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-far-seeing", "icon", "icon-far-seeing",
  "costs", {     0,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-invisibility", "icon", "icon-invisibility",
  "costs", {     0,  3000,     0,     0,     0,     0,     0})

DefineUpgrade("upgrade-scorpion", "icon", "icon-scorpion",
  "costs", {   100,   750,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-rain-of-fire", "icon", "icon-rain-of-fire",
  "costs", {     0,  1500,     0,     0,     0,     0,     0})
DefineUpgrade("upgrade-water-elemental", "icon", "icon-water-elemental",
  "costs", {   200,  3000,     0,     0,     0,     0,     0})

--	NOTE: Save can generate this table.

DefineModifier("upgrade-sword1",
  {"piercing-damage", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"})
DefineModifier("upgrade-sword2",
  {"piercing-damage", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"})

DefineModifier("upgrade-arrow1",
  {"piercing-damage", 1},
  {"apply-to", "unit-archer"})
DefineModifier("upgrade-arrow2",
  {"piercing-damage", 1},
  {"apply-to", "unit-archer"})

DefineModifier("upgrade-horse1",
  {"speed", 1},
  {"apply-to", "unit-knight"})
DefineModifier("upgrade-horse2",
  {"speed", 1},
  {"apply-to", "unit-knight"})

DefineModifier("upgrade-human-shield1",
  {"armor", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"})
DefineModifier("upgrade-human-shield2",
  {"armor", 2},
  {"apply-to", "unit-footman"}, {"apply-to", "unit-knight"})

DefineModifier("upgrade-healing",
  {"apply-to", "unit-cleric"})
DefineModifier("upgrade-far-seeing",
  {"apply-to", "unit-cleric"})
DefineModifier("upgrade-invisibility",
  {"apply-to", "unit-cleric"})

DefineModifier("upgrade-scorpion",
  {"apply-to", "unit-conjurer"})
DefineModifier("upgrade-rain-of-fire",
  {"apply-to", "unit-conjurer"})
DefineModifier("upgrade-water-elemental",
  {"apply-to", "unit-conjurer"})

--	NOTE: Save can generate this table.

--- units

DefineAllow("unit-footman",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-peasant",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-catapult",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-knight",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-archer",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-cleric",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-conjurer",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-farm",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-barracks",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-church",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-stable",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-town-hall",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-lumber-mill",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-tower",			"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-blacksmith",		"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-start-location",	"AAAAAAAAAAAAAAAA")
DefineAllow("unit-human-wall",			"AAAAAAAAAAAAAAAA")

--- upgrades

DefineAllow("upgrade-sword1",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-sword2",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-arrow1",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-arrow2",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-horse1",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-horse2",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-shield1",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-human-shield2",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-healing",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-far-seeing",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-invisibility",		"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-scorpion",	"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-rain-of-fire",			"AAAAAAAAAAAAAAAA")
DefineAllow("upgrade-water-elemental",		"RRRRRRRRRRRRRRRR")

--	NOTE: Save can generate this table.

--- human land forces
DefineDependency("unit-archer",
  {"unit-human-lumber-mill"})
DefineDependency("unit-human-catapult",
  {"unit-human-blacksmith", "unit-human-lumber-mill"})
DefineDependency("unit-knight",
  {"unit-human-stable", "unit-human-blacksmith"})

--- human buildings
DefineDependency("unit-human-blacksmith",
  {"unit-human-lumber-mill"})
DefineDependency("unit-human-stable",
  {"unit-human-lumber-mill"})
DefineDependency("unit-human-church",
  {"unit-human-lumber-mill"})
DefineDependency("unit-human-tower",
  {"unit-human-blacksmith"})

--- human upgrades/research
DefineDependency("upgrade-sword2",
  {"upgrade-sword1"})
DefineDependency("upgrade-arrow2",
  {"upgrade-arrow1"})
DefineDependency("upgrade-horse2",
  {"upgrade-horse1"})
DefineDependency("upgrade-human-shield2",
  {"upgrade-human-shield1"})
