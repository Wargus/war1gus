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
--      upgrade.lua - Define the dependencies and upgrades.
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

local upgrades = {
   {orc = {"axe1", {"grunt", "raider"}, "axe2"},
    human = {"sword1", {"footman", "knight"}, "sword2"},
    cost = {   120,   750,     0,     0,     0,     0,     0},
    modifier = {"PiercingDamage", 2}},
   {orc = {"axe2", {"grunt", "raider"}, "axe3"},
    human = {"sword2", {"footman", "knight"}, "sword3"},
    cost = {   120,   1500,     0,     0,     0,     0,     0},
    modifier = {"PiercingDamage", 2},
    dependency = {orc = "axe1", human = "sword1"}},

   {orc = {"spear1", {"spearman"}, "spear2"},
    human = {"arrow1", {"archer"}, "arrow2"},
    cost = {   140,   750,     0,     0,     0,     0,     0},
    modifier = {"PiercingDamage", 1}},
   {orc = {"spear2", {"spearman"}, "spear3"},
    human = {"arrow2", {"archer"}, "arrow3"},
    cost = {   140,   1500,     0,     0,     0,     0,     0},
    modifier = {"PiercingDamage", 1},
    dependency = {orc = "spear1", human = "arrow1"}},

   {orc = {"orc-shield1", {"grunt", "raider"}, "orc-shield2"},
    human = {"human-shield1", {"footman", "knight"}, "human-shield2"},
    cost = {   120,   750,     0,     0,     0,     0,     0},
    modifier = {"Armor", 2}},
   {orc = {"orc-shield2", {"grunt", "raider"}, "orc-shield3"},
    human = {"human-shield2", {"footman", "knight"}, "human-shield3"},
    cost = {   120,   1500,     0,     0,     0,     0,     0},
    modifier = {"Armor", 2},
    dependency = {orc = "orc-shield1", human = "human-shield1"}},

   {orc = {"wolves1", {"raider"}},
    human = {"horse1", {"knight"}},
    cost = {   140,   750,     0,     0,     0,     0,     0},
    modifier = {"Speed", 1}},
   {orc = {"wolves2", {"raider"}},
    human = {"horse2", {"knight"}},
    cost = {   140,   1500,     0,     0,     0,     0,     0},
    modifier = {"Speed", 1},
    dependency = {orc = "wolves1", human = "horse1"}},

   {orc = {"raise-dead", {"necrolyte"}},
    human = {"healing", {"cleric"}},
    cost = {   120,   750,     0,     0,     0,     0,     0}},

   {orc = {"dark-vision", {"necrolyte"}},
    human = {"far-seeing", {"cleric"}},
    cost = {   120,   1500,     0,     0,     0,     0,     0}},

   {orc = {"unholy-armor", {"necrolyte"}},
    human = {"invisibility", {"cleric"}},
    cost = {   120,   3000,     0,     0,     0,     0,     0}},

   {orc = {"spider", {"warlock", "medivh"}},
    human = {"scorpion", {"conjurer"}},
    cost = {   140,   750,     0,     0,     0,     0,     0}},

   {orc = {"poison-cloud", {"warlock"}},
    human = {"rain-of-fire", {"conjurer"}},
    cost = {   140,   1500,     0,     0,     0,     0,     0}},

   {orc = {"daemon", {"warlock", "medivh"}},
    human = {"water-elemental", {"conjurer"}},
    cost = {   140,   3000,     0,     0,     0,     0,     0}}
}

for idx,spec in ipairs(upgrades) do
   DefineUpgradeFromSpec(spec)
end

function DefineAllowExtraUnits()
   DefineAllow("unit-gold-mine",           "AAAAAAAAAAAAAAAA")
   DefineAllow("unit-dungeon-entrance",    "AAAAAAAAAAAAAAAA")
   DefineAllow("unit-road",                "AAAAAAAAAAAAAAAA")
   DefineAllow("unit-wall",                "AAAAAAAAAAAAAAAA")
   DefineAllow("unit-dead-body",           "AAAAAAAAAAAAAAAA")
   DefineAllow("unit-destroyed-1x1-place",	"AAAAAAAAAAAAAAAA")
   DefineAllow("unit-destroyed-2x2-place",	"AAAAAAAAAAAAAAAA")
   DefineAllow("unit-destroyed-3x3-place",	"AAAAAAAAAAAAAAAA")
   DefineAllow("unit-destroyed-4x4-place",	"AAAAAAAAAAAAAAAA")
end

DefineAllowExtraUnits()

DefineAllowOrcUnits = CreateAllowanceFunction("orc")
DefineAllowOrcUnits("AAAAAAAAAAAAAAAA")

DefineAllowHumanUnits = CreateAllowanceFunction("human")
DefineAllowHumanUnits("AAAAAAAAAAAAAAAA")

InitFuncs:add(function()
      if not war1gus.InCampaign then
         DefineAllowOrcUnits("AAAAAAAAAAAAAAAA")
         DefineAllowHumanUnits("AAAAAAAAAAAAAAAA")
         DefineAllowExtraUnits()
      end
end)
