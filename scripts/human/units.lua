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
--      units.ccl - Define the human unit-types.
--
--      (c) Copyright 2001-2005 by Lutz Sammer and Jimmy Salmon
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
--	NOTE: Save can generate this table.
--

DefineUnitType("unit-archer", { Name = "Archer",
  Image = {"file", "human/units/archer.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-archer",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-human-catapult", { Name = "Catapult",
  Image = {"file", "human/units/catapult.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-human-catapult",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-cleric", { Name = "Cleric",
  Image = {"file", "human/units/cleric.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-cleric",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-conjurer", { Name = "Conjurer",
  Image = {"file", "human/units/conjurer.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-conjurer",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-footman", { Name = "Footman",
  Image = {"file", "human/units/footman.png", "size", {96, 96}},
  Animations = "animations-todo", Icon = "icon-footman",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )
  
  
DefineUnitType("unit-knight", { Name = "Knight",
  Image = {"file", "human/units/knight.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-knight",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-midevh", { Name = "midevh",
  Image = {"file", "human/units/midevh.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-midevh",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true} )

DefineUnitType("unit-peasant", { Name = "Peasant",
  Image = {"file", "human/units/peasant.png", "size", {64, 64}},
  Animations = "animations-todo", Icon = "icon-peasant",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 10, PiercingDamage = 2, Missile = "missile-none",
  MaxAttackRange = 3,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "attack",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  SelectableByRectangle = true,
    CanGatherResources = {
   {"file-when-loaded", "human/units/peasant_with_gold.png",
    "resource-id", "gold",
--    "harvest-from-outside",
    "resource-capacity", 100,
    "wait-at-resource", 150,
    "wait-at-depot", 150},
   {"file-when-loaded", "human/units/peasant_with_wood.png",
    "resource-id", "wood",
    "resource-capacity", 100,
    "resource-step", 2,
    "wait-at-resource", 24,
    "wait-at-depot", 150,
    "lose-resources",
    "terrain-harvester"}}} )

-- 
-- BUILDINGS
--

UnitTypeFiles["unit-human-barracks"] = {forest = "tilesets/forest/human/buildings/barracks.png",
  swamp = "tilesets/swamp/human/buildings/barracks.png"}

DefineUnitType("unit-human-barracks", { Name = "Barracks",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-human-barracks",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-human-blacksmith"] = {forest = "tilesets/forest/human/buildings/blacksmith.png",
  swamp = "tilesets/swamp/human/buildings/blacksmith.png"}

DefineUnitType("unit-human-blacksmith", { Name = "Blacksmith",
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-human-blacksmith",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-human-church"] = {forest = "tilesets/forest/human/buildings/church.png",
  swamp = "tilesets/swamp/human/buildings/church.png"}

DefineUnitType("unit-human-church", { Name = "Church",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-human-church",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

	
	
UnitTypeFiles["unit-human-farm"] = {forest = "tilesets/forest/human/buildings/farm.png",
  swamp = "tilesets/swamp/human/buildings/farm.png"}

DefineUnitType("unit-human-farm", { Name = "Farm",
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-human-farm",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-human-lumber-mill"] = {forest = "tilesets/forest/human/buildings/lumber_mill.png",
  swamp = "tilesets/swamp/human/buildings/lumber_mill.png"}

DefineUnitType("unit-human-lumber-mill", { Name = "Lumber mill",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-human-lumber-mill",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-human-stable"] = {forest = "tilesets/forest/human/buildings/stable.png",
  swamp = "tilesets/swamp/human/buildings/stable.png"}

DefineUnitType("unit-human-stable", { Name = "Stable",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-human-stable",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )
	
UnitTypeFiles["unit-stormwind-keep"] = {forest = "tilesets/forest/human/buildings/stormwind_keep.png",
  swamp = "tilesets/swamp/human/buildings/stormwind_keep.png"}

DefineUnitType("unit-stormwind-keep", { Name = "Stormwind keep",
  Image = {"size", {160, 160}},
  Animations = "animations-building", Icon = "icon-stormwind-keep",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {5, 5}, BoxSize = {159, 159},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-human-tower"] = {forest = "tilesets/forest/human/buildings/tower.png",
  swamp = "tilesets/swamp/human/buildings/tower.png"}

DefineUnitType("unit-human-tower", { Name = "Tower",
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-human-tower",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-human-town-hall"] = {forest = "tilesets/forest/human/buildings/town_hall.png",
  swamp = "tilesets/swamp/human/buildings/town_hall.png"}

DefineUnitType("unit-human-town-hall", { Name = "Town hall",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-human-town-hall",
  Costs = {"time", 100, "gold", 500, "wood", 250},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-land",
  HitPoints = 400,
  DrawLevel = 20,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 20, AnnoyComputerFactor = 45,
  Points = 100,
  Supply = 4,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
    "selected", "farm-selected",
--    "acknowledge", "farm-acknowledge",
--    "ready", "farm-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

	
--[[
UnitTypeFiles["unit-human-wall"] = {summer = "tilesets/summer/neutral/buildings/wall.png",
  winter = "tilesets/winter/neutral/buildings/wall.png",
  wasteland = "tilesets/wasteland/neutral/buildings/wall.png",
  swamp = "tilesets/summer/neutral/buildings/wall.png"}

DefineUnitType("unit-human-wall", { Name = "Wall",
  Image = {"size", {32, 32}},
  Animations = "animations-building", Icon = "icon-human-wall",
  Costs = {"time", 30, "gold", 20, "wood", 10},
  Construction = "construction-wall",
  Speed = 0,
  HitPoints = 40,
  DrawLevel = 39,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0, AnnoyComputerFactor = 45,
  Points = 1,
  Corpse = "unit-destroyed-1x1-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true, 
  Sounds = {
--    "selected", "human-wall-selected",
--    "acknowledge", "human-wall-acknowledge",
--    "ready", "human-wall-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed"} } )

--]]
