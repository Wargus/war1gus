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
--      units.lua - Define the used unit-types.
--
--      (c) Copyright 1998-2004 by Lutz Sammer and Jimmy Salmon
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

--=============================================================================
--	Define unit-types.
--

local units = {
   {Names = {neutral = "Brigand"},
    HitPoints = 60},
   {Names = {neutral = "Daemon"},
    Size = {neutral = {96, 96}},
    HitPoints = 100},
   {Names = {neutral = "Fire elemental"},
    Size = {neutral = {96, 96}},
    HitPoints = 100},
   {Names = {neutral = "Water elemental"},
    Size = {neutral = {96, 96}},
    HitPoints = 100},
   {Names = {neutral = "Grizelda"},
    Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
    Animations = "animations-todo",
    HitPoints = 60},
   {Names = {neutral = "Garona"},
    Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
    Animations = "animations-todo",
    HitPoints = 60},
   {Names = {neutral = "Ogre"},
    Animations = "animations-knight",
    HitPoints = 100,
    Size = {neutral = {96, 96}}},
   {Names = {neutral = "Scorpion"},
    Animations = "animations-knight",
    HitPoints = 60},
   {Names = {neutral = "Skeleton"},
    Animations = "animations-knight",
    HitPoints = 60},
   {Names = {neutral = "Slime"},
    Animations = "animations-todo",
    HitPoints = 60},
   {Names = {neutral = "Spider"},
    HitPoints = 60},
   {Names = {neutral = "The dead"},
    HitPoints = 60,
    Animations = "animations-todo"},
   {Names = {neutral = "Wounded"},
    HitPoints = 60,
    Animations = "animations-todo"},
   {Names = {neutral = "Dead body"},
    HitPoints = 60,
    Image = {"file", "neutral/units/dead_bodies.png", "size", {64, 64}},
    Animations = "animations-todo"},

   {Names = {orc = "Peon", human = "Peasant"},
    Costs = {"time", 70},
    HitPoints = 60,
    CanAttack = false,
    Coward = true,
    CanGatherResources = {
       {"resource-id", "gold",
	"resource-capacity", 100,
	"wait-at-resource", 150,
	"wait-at-depot", 150},
       {"resource-id", "wood",
	"resource-capacity", 100,
	"resource-step", 2,
	"wait-at-resource", 24,
	"wait-at-depot", 150,
	"lose-resources",
	"terrain-harvester"}}},
   {Names = {orc = "Grunt", human = "Footman"},
    Costs = {"time", 70},
    HitPoints = 60,
    Size = {human = {96, 96}},
    MaxAttackRange = 1},
   {Names = {orc = "Spearman", human = "Archer"},
    Costs = {"time", 70},
    HitPoints = 60,
    Missile = "missile-arrow",
    MaxAttackRange = 3},
   {Names = {orc = "Catapult", human = "Catapult"},
    Costs = {"time", 70},
    HitPoints = 60,
    Missile = "missile-catapult-rock",
    MaxAttackRange = 4},
   {Names = {orc = "Raider", human = "Knight"},
    Costs = {"time", 70},
    HitPoints = 100,
    Size = {orc = {96, 96}},
    MaxAttackRange = 1},
   {Names = {orc = "Warlock", human = "Conjurer"},
    Costs = {"time", 70},
    HitPoints = 50,
    MaxAttackRange = 1},
   {Names = {orc = "Necrolyte", human = "Cleric"},
    Costs = {"time", 70},
    HitPoints = 50,
    MaxAttackRange = 1},

   {Names = {orc = "Lothar"},
    Size = {orc = {96, 96}},
    HitPoints = 100},

   {Names = {human = "Midevh"},
    HitPoints = 100}}

-- build units from specs
for idx,unit in ipairs(units) do
   for race,name in pairs(unit.Names) do
      local filename = string.lower(string.gsub(name, " ", "_"))
      local unitname = string.gsub(filename, "_", "-")

      local animations = ""
      if unit.Names.human then
	 animations = "animations-" .. string.lower(unit.Names.human)
      else
	 animations = "animations-" .. unitname
      end

      if unit.Names.orc and unit.Names.orc == unit.Names.human then
	 unitname = race .. "-" .. filename
      end

      local size = {64, 64}
      if unit.Size and unit.Size[race] then
	 size = unit.Size[race]
      end

      local unitType = {
	 Name = name,
	 Animations = animations,
	 Icon = "icon-" .. unitname,
	 Image = {
	    "file", race .. "/units/" .. filename .. ".png",
	    "size", size},
	 Costs = {},
	 HitPoints = unit.HitPoints,
	 DrawLevel = 60,
	 TileSize = {1, 1},
	 BoxSize = {31, 31},
	 SightRange = 5,
	 Armor =  3,
	 BasicDamage = 5, PiercingDamage = 2, Missile = "missile-none",
	 Priority = 63,
	 Points = 100,
	 Demand = 1,
	 CanAttack = true, Coward = false,
	 CanGatherResources = {},
	 SelectableByRectangle = true}

      for k,v in pairs(unit) do
	 if unitType[k] then
	    unitType[k] = v
	 end
      end
      DefineUnitType("unit-" .. unitname, unitType)
   end
end
