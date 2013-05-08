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
    HitPoints = 40,
    Armor = 4,
    BasicDamage = 9},
   {Names = {neutral = "Daemon"},
    Size = {neutral = {96, 96}},
    HitPoints = 300,
    Armor = 0,
    Animations = "animations-knight",
    BasicDamage = 65},
   {Names = {neutral = "Fire elemental"},
    Size = {neutral = {96, 96}},
    Animations = "animations-todo",
    HitPoints = 200,
    Armor = 0,
    BasicDamage = 40},
   {Names = {neutral = "Water elemental"},
    Size = {neutral = {96, 96}},
    Animations = "animations-todo",
    HitPoints = 250,
    Armor = 0,
    BasicDamage = 40,
    MaxAttackRange = 3},
   {Names = {neutral = "Grizelda"},
    Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
    Animations = "animations-todo",
    HitPoints = 30,
    Armor = 0,
    BasicDamage = 0},
   {Names = {neutral = "Garona"},
    Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
    Animations = "animations-todo",
    HitPoints = 30,
    Armor = 0,
    BasicDamage = 0},
   {Names = {neutral = "Ogre"},
    Animations = "animations-knight",
    HitPoints = 60,
    Armor = 3,
    BasicDamage = 12,
    Size = {neutral = {96, 96}}},
   {Names = {neutral = "Scorpion"},
    Animations = "animations-knight",
    HitPoints = 30,
    Armor = 0,
    BasicDamage = 3},
   {Names = {neutral = "Skeleton"},
    Animations = "animations-knight",
    HitPoints = 30,
    Armor = 2,
    BasicDamage = 9},
   {Names = {neutral = "Slime"},
    Animations = "animations-todo",
    HitPoints = 150,
    Armor = 10,
    BasicDamage = 1},
   {Names = {neutral = "Spider"},
    HitPoints = 30,
    Armor = 0,
    BasicDamage = 3},
   {Names = {neutral = "The dead"},
    HitPoints = 40,
    Armor = 1,
    BasicDamage = 4,
    Animations = "animations-knight"},
   {Names = {neutral = "Wounded"},
    HitPoints = 60,
    Animations = "animations-todo"},
   {Names = {neutral = "Dead body"},
    HitPoints = 60,
    Image = {"file", "neutral/units/dead_bodies.png", "size", {64, 64}},
    Animations = "animations-todo"},

   {Names = {orc = "Peon", human = "Peasant"},
    Costs = {"time", 75, "gold", 400},
    HitPoints = 40,
    CanAttack = false,
    Coward = true,
    Armor = 0,
    RightMouseAction = "harvest",
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
    Costs = {"time", 60, "gold", 400},
    HitPoints = 60,
    Armor = 2,
    BasicDamage = 9,
    Size = {human = {96, 96}},
    MaxAttackRange = 1},
   {Names = {orc = "Spearman", human = "Archer"},
    Costs = {"time", 70, "gold", 450, "wood", 50},
    HitPoints = 60,
    Armor = 1,
    BasicDamage = 4,
    Missile = "missile-arrow",
    MaxAttackRange = 5},
   {Names = {orc = "Catapult", human = "Catapult"},
    Costs = {"time", 100, "gold", 900, "wood", 200},
    HitPoints = 120,
    BasicDamage = 255,
    MaxAttackRange = 8,
    Armor = 0,
    Speed = 5,
    Missile = "missile-catapult-rock",
    MaxAttackRange = 4},
   {Names = {orc = "Raider", human = "Knight"},
    Costs = {"time", 80, "gold", 850},
    HitPoints = 90,
    Armor = 5,
    Speed = 13,
    BasicDamage = 13,
    Size = {orc = {96, 96}},
    MaxAttackRange = 1},
   {Names = {orc = "Warlock", human = "Conjurer"},
    Costs = {"time", 90, "gold", 900},
    HitPoints = 40,
    Armor = 0,
    CanCastSpell = {
       human = {
	  "spell-summon-scorpions",
	  "spell-summon-elemental",
	  "spell-rain-of-fire"},
       orc = {
	  "spell-summon-spiders",
	  "spell-summon-daemon",
	  "spell-poison-cloud" } },
    Missile = "missile-fireball",
    BasicDamage = 6,
    MaxAttackRange = 3},
   {Names = {orc = "Necrolyte", human = "Cleric"},
    Costs = {"time", 80, "gold", 700},
    HitPoints = 40,
    Armor = 0,
    CanCastSpell = {
       human = {
	  "spell-healing",
	  "spell-far-seeing",
	  "spell-invisibility"},
       orc = {
	  "spell-raise-dead",
	  "spell-dark-vision",
	  "spell-unholy-armor" } },
    BasicDamage = 6,
    MaxAttackRange = 1},

   {Names = {orc = "Lothar"},
    Size = {orc = {96, 96}},
    HitPoints = 50,
    Armor = 5,
    BasicDamage = 15},

   {Names = {human = "Midevh"},
    HitPoints = 110,
    Armor = 0,
    Missile = "missile-fireball",
    BasicDamage = 10,
    MaxAttackRange = 5}}

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
	 MaxAttackRange = 1,
	 TileSize = {1, 1},
	 BoxSize = {31, 31},
	 SightRange = 8,
	 Speed = 9,
	 ComputerReactionRange = 6,
	 PersonReactionRange = 4,
	 Armor =  3,
	 BasicDamage = 5, PiercingDamage = 2, Missile = "missile-none",
	 Priority = 63,
	 Points = 100,
	 Demand = 1,
	 Type = "land",
	 RightMouseAction = "attack",
	 CanAttack = true, Coward = false,
	 CanTargetLand = true,
	 Sounds = {
	    "attack", unitname .. "-attack",
	    "selected", race .. " selected",
	    "acknowledge", race .. " acknowledge",
	    "ready", race .. " ready",
	    "help", race .. " help 3",
	    "dead", race .. " dead"},
	 SelectableByRectangle = true}

      for k,v in pairs(unit) do
	 if unitType[k] or k == "CanGatherResources" then
	    unitType[k] = v
	 end
      end

      if unit.CanCastSpell then
	 unitType.CanCastSpell = unit.CanCastSpell[race]
      end

      DefineUnitType("unit-" .. unitname, unitType)
   end
end
