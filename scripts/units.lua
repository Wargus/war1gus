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

-- Load the animations for the units.
Load("scripts/anim.lua")

--=============================================================================
--	Define unit-types.
--

DefineUnitType("unit-gold-mine", { Name = "Gold Mine",
  Files = {"tileset-forest", "tilesets/forest/neutral/buildings/gold_mine.png",
    "tileset-swamp", "tilesets/swamp/neutral/buildings/gold_mine.png"},
  Size = {128, 128},
  Animations = "animations-building", Icon = "icon-gold-mine",
  NeutralMinimapColor = {255, 255, 0},
  Costs = {"time", 150},
  Construction = "construction-land",
  Speed = 0,
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = {"unit-destroyed-3x3-place", 0},
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
    "attack", "gold-mine-attack"} } )

DefineUnitType("unit-dead-body", { Name = "Dead Body",
  Files = {"tileset-forest", "neutral/units/dead_bodies.png"},
  Size = {64, 64},
  Animations = "animations-dead-body", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 30,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 1,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-destroyed-1x1-place", { Name = "Destroyed 1x1 Place",
  Files = {"tileset-forest", "neutral/small_destroyed_site.png"},
  Size = {32, 32},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 2,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-destroyed-2x2-place", { Name = "Destroyed 2x2 Place",
  Files = {"tileset-forest", "neutral/destroyed_site.png"},
  Size = {64, 64},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-destroyed-3x3-place", { Name = "Destroyed 3x3 Place",
  Files = {"tileset-forest", "neutral/destroyed_site.png"},
  Size = {64, 64},
--  Size = {96, 96},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {3, 3}, BoxSize = {95, 95},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-destroyed-4x4-place", { Name = "Destroyed 4x4 Place",
  Files = {"tileset-forest", "neutral/destroyed_site.png"},
  Size = {64, 64},
--  Size = {128, 128},
  Animations = "animations-destroyed-place", Icon = "icon-peasant",
  Speed = 0,
  HitPoints = 255,
  DrawLevel = 10,
  TileSize = {4, 4}, BoxSize = {127, 127},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Vanishes = true,
  Sounds = {} } )

DefineUnitType("unit-revealer", { Name = "Dummy unit",
  Size = {0, 0},
  Animations = "animations-building", Icon = "icon-holy-vision",
  Speed = 0,
  HitPoints = 1,
  TileSize = {1, 1}, BoxSize = {1, 1},
  SightRange = 12,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  DecayRate = 1,
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Revealer = true,
  DetectCloak = true,
  Sounds = {} } )

DefineUnitType("unit-critter", { Name = "Critter",
  Files = {"tileset-forest", "tilesets/critter.png"},
  Size = {32, 32},
  Animations = "animations-critter", Icon = "icon-critter",
  NeutralMinimapColor = {192, 192, 192},
  Speed = 3,
  HitPoints = 5,
  DrawLevel = 35,
  TileSize = {1, 1}, BoxSize = {31, 31},
  SightRange = 2, ComputerReactionRange = 20, PersonReactionRange = 10,
  BasicDamage = 80, PiercingDamage = 0, Missile = "missile-critter-explosion",
  MaxAttackRange = 1,
  Priority = 37,
  Points = 1,
  Demand = 1,
  Type = "land",
  RightMouseAction = "move",
  CanTargetLand = true,
  LandUnit = true,
  RandomMovementProbability = 100,
  ClicksToExplode = 10,
  organic = true,
  Sounds = {
    "selected", "critter-selected",
    "acknowledge", "critter-acknowledge",
    "ready", "critter-ready",
    "help", "critter-help",
    "dead", "critter-dead",
    "attack", "critter-attack"} } )

DefineUnitType("unit-circle-of-power", { Name = "Circle of Power",
  Files = {"tileset-forest", "tilesets/circle_of_power.png"},
  Size = {64, 64},
  Animations = "animations-building", Icon = "icon-circle-of-power",
  NeutralMinimapColor = {128, 128, 0},
  Speed = 0,
  HitPoints = 0,
  DrawLevel = 5,
  TileSize = {2, 2}, BoxSize = {63, 63},
  SightRange = 0,
  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = {"unit-destroyed-2x2-place", 0},
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
  Sounds = {
    "selected", "circle-of-power-selected",
    "acknowledge", "circle-of-power-acknowledge",
    "ready", "circle-of-power-ready",
    "help", "basic human voices help 2",
    "dead", "building destroyed",
    "attack", "circle-of-power-attack"} } )


-- Load the different races
Load("scripts/human/units.lua")
Load("scripts/orc/units.lua")

