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
--      units.ccl - Define the orc unit-types.
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

DefineUnitType("unit-orc-catapult", { Name = "Catapult",
  Image = {"file", "orc/units/catapult.png", "size", {64, 64}},
  Animations = "animations-catapult", Icon = "icon-orc-catapult",
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

DefineUnitType("unit-grunt", { Name = "Grunt",
  Image = {"file", "orc/units/grunt.png", "size", {64, 64}},
  Animations = "animations-footman", Icon = "icon-grunt",
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

DefineUnitType("unit-lothar", { Name = "Lothar",
  Image = {"file", "orc/units/lothar.png", "size", {96, 96}},
  Animations = "animations-midevh", Icon = "icon-lothar",
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

DefineUnitType("unit-necrolyte", { Name = "Necrolyte",
  Image = {"file", "orc/units/necrolyte.png", "size", {64, 64}},
  Animations = "animations-necrolyte", Icon = "icon-necrolyte",
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

DefineUnitType("unit-peon", { Name = "Peon",
  Image = {"file", "orc/units/peon.png", "size", {64, 64}},
  Animations = "animations-peasant", Icon = "icon-peon",
  Costs = {"time", 70},
  NeutralMinimapColor = {192, 0, 0},
  HitPoints = 60,
  DrawLevel = 60,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 5, ComputerReactionRange = 7, PersonReactionRange = 5,
  Armor = 3, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  MaxAttackRange = 0,
  Priority = 63,
  Points = 100,
  Demand = 1,
  RightMouseAction = "harvest",
  CanAttack = false,
  Coward = true,
  SelectableByRectangle = true,
    CanGatherResources = {
   {"file-when-loaded", "orc/units/peon_with_gold.png",
    "resource-id", "gold",
--    "harvest-from-outside",
    "resource-capacity", 100,
    "wait-at-resource", 150,
    "wait-at-depot", 150},
   {"file-when-loaded", "orc/units/peon_with_wood.png",
    "resource-id", "wood",
    "resource-capacity", 100,
    "resource-step", 2,
    "wait-at-resource", 24,
    "wait-at-depot", 150,
    "lose-resources",
    "terrain-harvester"}}} )

DefineUnitType("unit-raider", { Name = "Raider",
  Image = {"file", "orc/units/raider.png", "size", {96, 96}},
  Animations = "animations-knight", Icon = "icon-raider",
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

DefineUnitType("unit-spearman", { Name = "Spearman",
  Image = {"file", "orc/units/spearman.png", "size", {64, 64}},
  Animations = "animations-archer", Icon = "icon-spearman",
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

DefineUnitType("unit-warlock", { Name = "Warlock",
  Image = {"file", "orc/units/warlock.png", "size", {64, 64}},
  Animations = "animations-footman", Icon = "icon-warlock",
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
-- 
-- BUILDINGS
--

UnitTypeFiles["unit-orc-barracks"] = {forest = "tilesets/forest/orc/buildings/barracks.png",
  swamp = "tilesets/swamp/orc/buildings/barracks.png"}

DefineUnitType("unit-orc-barracks", { Name = "Barracks",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-orc-barracks",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-blackrock-spire"] = {forest = "tilesets/forest/orc/buildings/blackrock_spire.png",
  swamp = "tilesets/swamp/orc/buildings/blackrock_spire.png"}

DefineUnitType("unit-blackrock-spire", { Name = "Blackrock-spire",
  Image = {"size", {160, 160}},
  Animations = "animations-building", Icon = "icon-blackrock-spire",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-orc-blacksmith"] = {forest = "tilesets/forest/orc/buildings/blacksmith.png",
  swamp = "tilesets/swamp/orc/buildings/blacksmith.png"}

DefineUnitType("unit-orc-blacksmith", { Name = "Blacksmith",
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-orc-blacksmith",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-orc-farm"] = {forest = "tilesets/forest/orc/buildings/farm.png",
  swamp = "tilesets/swamp/orc/buildings/farm.png"}

DefineUnitType("unit-orc-farm", { Name = "Farm",
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-orc-farm",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-orc-kennel"] = {forest = "tilesets/forest/orc/buildings/kennel.png",
  swamp = "tilesets/swamp/orc/buildings/kennel.png"}

DefineUnitType("unit-orc-kennel", { Name = "Kennel",
  Image = {"size", {128, 96}},
  Animations = "animations-building", Icon = "icon-orc-kennel",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-orc-lumber-mill"] = {forest = "tilesets/forest/orc/buildings/lumber_mill.png",
  swamp = "tilesets/swamp/orc/buildings/lumber_mill.png"}

DefineUnitType("unit-orc-lumber-mill", { Name = "Lumber mill",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-orc-lumber-mill",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-orc-temple"] = {forest = "tilesets/forest/orc/buildings/temple.png",
  swamp = "tilesets/swamp/orc/buildings/temple.png"}

DefineUnitType("unit-orc-temple", { Name = "Temple",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-orc-temple",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )


UnitTypeFiles["unit-orc-tower"] = {forest = "tilesets/forest/orc/buildings/tower.png",
  swamp = "tilesets/swamp/orc/buildings/tower.png"}

DefineUnitType("unit-orc-tower", { Name = "Tower",
  Image = {"size", {96, 96}},
  Animations = "animations-building", Icon = "icon-orc-tower",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

UnitTypeFiles["unit-orc-town-hall"] = {forest = "tilesets/forest/orc/buildings/town_hall.png",
  swamp = "tilesets/swamp/orc/buildings/town_hall.png"}

DefineUnitType("unit-orc-town-hall", { Name = "Town hall",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-orc-town-hall",
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
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

--]]	
--[[
UnitTypeFiles["unit-orc-wall"] = {summer = "tilesets/summer/neutral/buildings/wall.png",
  winter = "tilesets/winter/neutral/buildings/wall.png",
  wasteland = "tilesets/wasteland/neutral/buildings/wall.png",
  swamp = "tilesets/summer/neutral/buildings/wall.png"}

DefineUnitType("unit-orc-wall", { Name = "Wall",
  Image = {"size", {32, 32}},
  Animations = "animations-building", Icon = "icon-orc-wall",
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
--    "selected", "orc-wall-selected",
--    "acknowledge", "orc-wall-acknowledge",
--    "ready", "orc-wall-ready",
    "help", "basic orc voices help 2",
    "dead", "building destroyed"} } )

--]]
