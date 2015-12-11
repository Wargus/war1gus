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
--      Define unit-types.
--

local units = {
   {Names = {neutral = "Brigand"},
    HitPoints = 40,
    Armor = 4,
    PiercingDamage = 1,
    BasicDamage = 9},
   {Names = {neutral = "Daemon"},
    Size = {neutral = {96, 96}},
    HitPoints = 300,
    Armor = 0,
    BasicDamage = 65,
    organic = false},
   {Names = {neutral = "Fire elemental"},
    Size = {neutral = {96, 96}},
    HitPoints = 200,
    Armor = 0,
    BasicDamage = 40,
    Missile = "missile-catapult-rock",
    organic = false},
   {Names = {neutral = "Water elemental"},
    Size = {neutral = {96, 96}},
    HitPoints = 250,
    Armor = 0,
    PiercingDamage = 40,
    BasicDamage = 0,
    MaxAttackRange = 3,
    Missile = "missile-water",
    organic = false},
   {Names = {orc = "Grizelda"},
    Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
    HitPoints = 30,
    Armor = 0,
    BasicDamage = 0,
    Coward = true},
   {Names = {orc = "Garona"},
    Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
    HitPoints = 30,
    Armor = 0,
    BasicDamage = 0,
    Coward = true},
   {Names = {neutral = "Ogre"},
    HitPoints = 60,
    Armor = 3,
    PiercingDamage = 1,
    BasicDamage = 12,
    Size = {neutral = {96, 96}}},
   {Names = {neutral = "Scorpion"},
    HitPoints = 30,
    Armor = 0,
    PiercingDamage = 3,
    BasicDamage = 0,
    organic = false},
   {Names = {neutral = "Skeleton"}, -- "Dungeon Skeleton"
    HitPoints = 30,
    Armor = 2,
    PiercingDamage = 1,
    BasicDamage = 9,
    organic = false},
   {Names = {neutral = "Slime"},
    HitPoints = 150,
    Armor = 10,
    PiercingDamage = 1,
    BasicDamage = 0,
    organic = false},
   {Names = {neutral = "Spider"},
    HitPoints = 30,
    Armor = 0,
    PiercingDamage = 1,
    BasicDamage = 3,
    organic = false},
   {Names = {neutral = "The dead"}, -- "Orc conjured skeleton"
    HitPoints = 40,
    Armor = 1,
    PiercingDamage = 1,
    BasicDamage = 4,
    organic = false},
   {Names = {neutral = "Wounded"},
    HitPoints = 60,
    Corpse = nil},

   {Names = {orc = "Peon", human = "Peasant"},
    Costs = {"time", 75, "gold", 400},
    HitPoints = 40,
    CanAttack = false,
    Coward = true,
	AnnoyComputerFactor = 100,
    Armor = 0,
    RightMouseAction = "harvest",
    RepairRange = 1,
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
	AnnoyComputerFactor = 80,
    PiercingDamage = 1,
    BasicDamage = 9,
    Size = {human = {96, 96}},
    MaxAttackRange = 1},
   {Names = {orc = "Spearman", human = "Archer"},
    Costs = {"time", 70, "gold", 450, "wood", 50},
    HitPoints = 60,
    Armor = 1,
	AnnoyComputerFactor = 140,
    PiercingDamage = {orc = 5, human = 4},
    BasicDamage = 0,
    Missile = "missile-arrow",
    MaxAttackRange = {human = 5, orc = 4},
    Dependencies = {orc = {"lumber-mill"}, human = {"lumber-mill"}}},
   {Names = {orc = "Catapult", human = "Catapult"},
    Costs = {"time", 100, "gold", 900, "wood", 200},
    HitPoints = 120,
    BasicDamage = 255,
	AnnoyComputerFactor = 160,
    MaxAttackRange = 8,
    Armor = 0,
    Speed = 5,
    organic = false,
    Missile = "missile-catapult-rock",
    Dependencies = {orc = {"blacksmith", "lumber-mill"},
                    human = {"blacksmith", "lumber-mill"}}},
   {Names = {orc = "Warlock", human = "Conjurer"},
    Costs = {"time", 90, "gold", 900},
    HitPoints = 40,
    Armor = 0,
    Mana = {Enable = true},
	AnnoyComputerFactor = 200,
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
    PiercingDamage = 6,
    BasicDamage = 0,
    MaxAttackRange = {human = 3, orc = 2}},
   {Names = {orc = "Necrolyte", human = "Cleric"},
    Costs = {"time", 80, "gold", 700},
    HitPoints = 40,
    Armor = 0,
    Coward = true,
    Mana = {Enable = true},
	AnnoyComputerFactor = 180,
    CanCastSpell = {
       human = {
          "spell-healing",
          "spell-far-seeing",
          "spell-invisibility"},
       orc = {
          "spell-raise-dead",
          "spell-dark-vision",
          "spell-unholy-armor" } },
    PiercingDamage = 6,
        Missile = "missile-magic-fireball",
    BasicDamage = 0,
    MaxAttackRange = {orc = 2, human = 1}},

   {Names = {human = "Lothar"},
    Size = {human = {96, 96}},
    HitPoints = 50,
    Animations = "animations-medivh",
    Armor = 5,
    PiercingDamage = 1,
    BasicDamage = 15},

   {Names = {human = "Wounded Lothar"},
    Name = "Wounded",
    HitPoints = 60,
    Icon = "icon-wounded",
    Image = {
       "file", "neutral/units/wounded.png",
       "size", {64, 64}},
    Animations = "animations-wounded"},

   {Names = {human = "Medivh"},
    HitPoints = 110,
    Armor = 0,
    Mana = {Enable = true},
    Missile = "missile-fireball",
    PiercingDamage = 10,
    BasicDamage = 0,
    MaxAttackRange = 8,
    Mana = {Enable = true},
    CanCastSpell = {
       human = {"spell-summon-spiders",
                "spell-summon-daemon"}}}
}

-- build units from specs
for idx,unit in ipairs(units) do
   DefineUnitFromSpec(unit)
end

local knight_raider_spec = {
   Names = {orc = "Raider", human = "Knight"},
   Name = {orc = "Raider", human = "Knight"},
   Image = {orc = {"file", "orc/units/raider.png", "size", {96, 96}},
            human = {"file", "human/units/knight.png", "size", {64, 64}}},
   Costs = {"time", 80, "gold", 850},
   HitPoints = 90,
   Armor = 5,
   Speed = 13,
   AnnoyComputerFactor = 120,
   PiercingDamage = 1,
   BasicDamage = 13,
   MaxAttackRange = 1,
   Dependencies = {orc = {"blacksmith", "kennel"},
                   human = {"blacksmith", "stable"}}}
DefineUnitFromSpec(knight_raider_spec)
knight_raider_spec.Names = {orc = "Raider1", human = "Knight1"}
DefineUnitFromSpec(knight_raider_spec)
knight_raider_spec.Names = {orc = "Raider2", human = "Knight2"}
DefineUnitFromSpec(knight_raider_spec)

local dead_bodies = { Name = "Dead Body",
  Image = {"file", "neutral/units/dead_bodies.png", "size", {64, 64}},
  Animations = "animations-human-dead-body", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 30,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 1,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Vanishes = true,
  Sounds = {} }
DefineUnitType("unit-human-dead-body", dead_bodies)
dead_bodies.Animations = "animations-orc-dead-body"
DefineUnitType("unit-orc-dead-body", dead_bodies)
