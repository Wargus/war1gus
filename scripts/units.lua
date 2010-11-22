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

UnitTypeFiles = {}

-- Load the animations for the units.
Load("scripts/anim.lua")

--=============================================================================
--	Define unit-types.
--

UnitTypeFiles["unit-gold-mine"] = {
  forest = "tilesets/forest/neutral/buildings/gold_mine.png",
  swamp = "tilesets/swamp/neutral/buildings/gold_mine.png"
}

DefineUnitType("unit-gold-mine", { Name = "Gold Mine",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-gold-mine",
  NeutralMinimapColor = {255, 255, 0},
  Costs = {"time", 150},
  Construction = "construction-none",
--  Speed = 0,
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-3x3-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
  GivesResource = "gold", CanHarvest = true,
  Sounds = {
    "selected", "gold-mine-selected",
    "acknowledge", "gold-mine-acknowledge",
    "ready", "gold-mine-ready",
    "help", "gold-mine-help",
    "dead", "building destroyed",
--    "attack", "gold-mine-attack"
}} )

DefineUnitType("unit-brigand", { Name = "Brigand",
  Image = {"file", "neutral/units/brigand.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-brigand",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-daemon", { Name = "Daemon",
  Image = {"file", "neutral/units/daemon.png", "size", {96, 96}},
  Animations = "animations-todo", Icon = "icon-daemon",
  Costs = {"time", 70, "gold", 500, "oil", 50},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
--  Type = "fly", ShadowFly = {Value = 1, Enable = true},
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  AirUnit = true,
--  DetectCloak = true,
--  Organic = true,
  SelectableByRectangle = true,
  Sounds = {
    "selected", "daemon-selected",
--    "acknowledge", "daemon-acknowledge",
--    "ready", "daemon-ready",
    "help", "basic orc voices help 1",
    "dead", "basic orc voices dead"} } )

DefineUnitType("unit-fire-elemental", { Name = "Fire elemental",
  Image = {"file", "neutral/units/fire_elemental.png", "size", {96, 96}},
  Animations = "animations-todo", Icon = "icon-fire-elemental",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-grizelda", { Name = "Grizelda",
  Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-grizelda",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-garona", { Name = "Garona",
  Image = {"file", "neutral/units/grizelda,garona.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-garona",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-ogre", { Name = "Ogre",
  Image = {"file", "neutral/units/ogre.png", "size", {96, 96}},
  Animations = "animations-todo", Icon = "icon-ogre",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-scorpion", { Name = "Scorpion",
  Image = {"file", "neutral/units/scorpion.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-scorpion",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-skeleton", { Name = "Skeleton",
  Image = {"file", "neutral/units/skeleton.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-skeleton",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-slime", { Name = "Slime",
  Image = {"file", "neutral/units/slime.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-slime",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-spider", { Name = "Spider",
  Image = {"file", "neutral/units/spider.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-spider",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )
  
DefineUnitType("unit-the-dead", { Name = "The dead",
  Image = {"file", "neutral/units/the_dead.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-the-dead",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-water-elemental", { Name = "Water elemental",
  Image = {"file", "neutral/units/water_elemental.png", "size", {96, 96}},
  Animations = "animations-todo", Icon = "icon-water-elemental",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-wounded", { Name = "Wounded",
  Image = {"file", "neutral/units/wounded.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-wounded",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-dead-body", { Name = "Dead body",
  Image = {"file", "neutral/units/dead_bodies.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-wounded",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-daemon-fire",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

-- Load the different races
Load("scripts/human/units.lua")
Load("scripts/orc/units.lua")
