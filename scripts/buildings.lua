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
--      constructions.lua - Define the constructions.
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

UnitTypeFiles = {}

if (war1gus.tileset == nil) then
  war1gus.tileset = "forest"
end

local buildings = {
   {Names = {orc = "Farm", human = "Farm"},
    Costs = {"time", 100, "gold", 500, "wood", 300},
    HitPoints = 400,
    Supply = 5,
    Size = {96, 96}},

   {Names = {orc = "Town hall", human = "Town hall"},
    Costs = {"time", 100, "gold", 400, "wood", 400},
    HitPoints = 2500,
    CanStore = {"wood", "gold"},
    Supply = 5,
    Size = {128, 128}},

   {Names = {orc = "Barracks", human = "Barracks"},
    Costs = {"time", 150, "gold", 600, "wood", 500},
    HitPoints = 800,
    Size = {128, 128}},

   {Names = {orc = "Lumber mill", human = "Lumber mill"},
    Costs = {"time", 150, "gold", 600, "wood", 500},
    HitPoints = 600,
    CanStore = {"wood"},
    Size = {128, 128}},

   {Names = {orc = "Kennel"},
    Costs = {"time", 150, "gold", 1000, "wood", 400},
    HitPoints = 500,
    Size = {128, 96},
    Dependency = {orc = "lumber-mill"}},

   {Names = {human = "Stable"},
    Costs = {"time", 150, "gold", 1000, "wood", 400},
    HitPoints = 500,
    Size = {128, 128},
    Dependency = {human = "lumber-mill"}},

   {Names = {orc = "Blacksmith", human = "Blacksmith"},
    Costs = {"time", 150, "gold", 900, "wood", 400},
    HitPoints = 800,
    Size = {96, 96},
    Dependency = {orc = "lumber-mill", human = "lumber-mill"}},

   {Names = {human = "Church", orc = "Temple"},
    Costs = {"time", 200, "gold", 800, "wood", 500},
    HitPoints = 700,
    Size = {128, 128},
    Dependency = {orc = "lumber-mill", human = "lumber-mill"}},

   {Names = {orc = "Tower", human = "Tower"},
    Costs = {"time", 200, "gold", 1400, "wood", 300},
    HitPoints = 900,
    Size = {96, 96},
    Dependency = {orc = "blacksmith", human = "blacksmith"}},

   {Names = {human = "Stormwind keep", orc = "Blackrock spire"},
    Costs = {"time", 100, "gold", 500, "wood", 250},
    HitPoints = 5000,
    Size = {160, 160},
    NotConstructable = true,
    Corpse = "unit-destroyed-3x3-place"}}

for idx,building in ipairs(buildings) do
   DefineBuildingFromSpec(building)
end

UnitTypeFiles["unit-gold-mine"] = {
  forest = "tilesets/forest/neutral/buildings/gold_mine.png",
  swamp = "tilesets/swamp/neutral/buildings/gold_mine.png"
}

DefineUnitType("unit-gold-mine", { Name = "Gold Mine",
  Image = {"size", {128, 128}},
  Animations = "animations-building", Icon = "icon-gold-mine",
  NeutralMinimapColor = {200, 200, 200},
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

DefineUnitType(
   "unit-start-location",
   { Name = "Start Location",
     Image = {"size", {30, 22},
	      "file", "graphics/ui/cursors/yellow_crosshair.png"},
     Animations = "animations-building",
     Priority = 0,
     HitPoints = 1,
     Icon = "icon-cancel",
     TileSize = {1, 1}, BoxSize = {1, 1},
     SightRange = 1,
     Indestructible = 1,
     DrawLevel = 0,
     IsNotSelectable = true,
     NonSolid = true,
     Type = "land", Building = true,
     VisibleUnderFog = true })
