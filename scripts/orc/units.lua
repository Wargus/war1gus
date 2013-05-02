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

-- 
-- BUILDINGS
--

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
