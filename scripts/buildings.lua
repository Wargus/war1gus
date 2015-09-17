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

local townHallBuildingRules = nil
if (preferences.AllowMultipleTownHalls) then
  townHallBuildingRules = {
          { "distance", { Distance = 3, DistanceType = ">", Type = "unit-gold-mine" } } }
else
  townHallBuildingRules = {
          { "has-unit", { Type = "unit-human-town-hall", Count = 0, CountType = "=" },
            "has-unit", { Type = "unit-orc-town-hall", Count = 0, CountType = "=" },
	    "has-unit", { Type = "unit-human-stormwind-keep", Count = 0, CountType = "=" },
	    "has-unit", { Type = "unit-orc-blackrock-spire", Count = 0, CountType = "=" },
            "distance", { Distance = 3, DistanceType = ">", Type = "unit-gold-mine" } } }
end


for i=1,4,1 do
	UnitTypeFiles["unit-destroyed-" .. i .. "x" .. i .. "-place"] = {
	  forest = "tilesets/forest/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
	  swamp = "tilesets/swamp/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
	  dungeon = "tilesets/dungeon/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png"}
	DefineUnitType("unit-destroyed-" .. i .. "x" .. i .. "-place", {
	  Name = "unit-destroyed-" .. i .. "x" .. i .. "-place",
	  Image = {"size", {i * 32, i * 32}},
	  Animations = "animations-ruins",
	  Icon = "icon-peasant",
	  Speed = 0,
	  HitPoints = 255,
	  DrawLevel = 10,
	  TileSize = {i, i}, BoxSize = {i * 32 - 1, i * 32 - 1},
	  SightRange = 0,
	  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
	  Priority = 0,
	  Type = "land",
	  Building = true,
	  VisibleUnderFog = true,
	  Corpse = "unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. (i - 1),
	  Vanishes = (i == 1),
	  Sounds = {} } )
	local j = i
	for j=i,1,-1 do
	  UnitTypeFiles["unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. j] = {
		  forest = "tilesets/forest/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
		  swamp = "tilesets/swamp/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
		  dungeon = "tilesets/dungeon/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png"}
	  DefineUnitType("unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. j, {
		  Name = "unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. j,
		  Image = {"size", {j * 32, j * 32}},
		  Animations = "animations-ruins",
		  Icon = "icon-peasant",
		  Speed = 0,
		  HitPoints = 255,
		  DrawLevel = 10,
		  TileSize = {i, i}, BoxSize = {i * 32 - 1, i * 32 - 1},
		  SightRange = 0,
		  BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
		  Priority = 0,
		  Type = "land",
		  Building = true,
		  VisibleUnderFog = true,
		  Corpse = "unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. (j - 1),
		  Vanishes = (j == 1),
		  Sounds = {} } )
	end
end

local buildings = {
   {Names = {orc = "Farm", human = "Farm"},
    Costs = {"time", 100, "gold", 500, "wood", 300},
    HitPoints = 400,
    Supply = 5,
    Size = {96, 96},
    Corpse = "unit-destroyed-2x2-place"},

   {Names = {orc = "Town hall", human = "Town hall"},
    Costs = {"time", 100, "gold", 400, "wood", 400},
    HitPoints = 2500,
    CanStore = {"wood", "gold"},
    Supply = 5,
    RepairRange = InfiniteRepairRange,
    BuildingRules = townHallBuildingRules,
        AiBuildingRules = townHallBuildingRules,
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
    Dependency = {orc = "lumber-mill", human = "lumber-mill"},
    Corpse = "unit-destroyed-2x2-place"},

   {Names = {human = "Church", orc = "Temple"},
    Costs = {"time", 200, "gold", 800, "wood", 500},
    HitPoints = 700,
    Size = {128, 128},
    Dependency = {orc = "lumber-mill", human = "lumber-mill"}},

   {Names = {orc = "Tower", human = "Tower"},
    Costs = {"time", 200, "gold", 1400, "wood", 300},
    HitPoints = 900,
    Size = {96, 96},
    Dependency = {orc = "blacksmith", human = "blacksmith"},
    Corpse = "unit-destroyed-2x2-place"},

   {Names = {human = "Stormwind keep", orc = "Blackrock spire"},
    Costs = {"time", 100, "gold", 500, "wood", 250},
    HitPoints = 5000,
    Size = {160, 160},
        CanStore = {"wood", "gold"},
    Supply = 5,
    RepairRange = 1000, -- basically infinite
    NotConstructable = true,
    Corpse = "unit-destroyed-4x4-place"}
}

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

UnitTypeFiles["unit-road"] = {
  forest = "tilesets/forest/neutral/buildings/road.png",
  swamp = "tilesets/swamp/neutral/buildings/road.png",
  dungeon = "tilesets/dungeon/neutral/buildings/road.png"
}
DefineConstruction(
   "construction-none",
   {Constructions = {{Percent = 0, File = "main", Frame = 0}}})
DefineUnitType(
   "unit-road",
   { Name = "Road",
     Image = {"size", {32, 32}},
     Costs = {"time", 1, "gold", 50},
     Animations = "animations-building",
     Construction = "construction-none",
	 NeutralMinimapColor = {100, 100, 100},
	 OnInit = function(unit)
	   SetUnitVariable(unit, "Player", 15);
	 end,
     BuildingRules = {
	{"distance", {Distance = 1, DistanceType = "=", Type = "unit-road", Diagonal = true}},
        {"distance", {Distance = 1, DistanceType = "=", Type = "unit-human-town-hall", Owner = "self", CheckBuilder = true}},
        {"distance", {Distance = 1, DistanceType = "=", Type = "unit-orc-town-hall", Owner = "self", CheckBuilder = true}}},
     AiBuildingRules = {-- these are silly, but what can you do
	-- the first road is next to a town hall
	{"has-unit", { Type = "unit-road", Count = 0, CountType = "=", Owner = "any" },
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-human-town-hall", Owner = "self", CheckBuilder = true}},
	{"has-unit", { Type = "unit-road", Count = 0, CountType = "=", Owner = "any" },
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-orc-town-hall", Owner = "self", CheckBuilder = true}},
	
	-- the first four roads should be at the town hall and have some space between them
	{"has-unit", { Type = "unit-road", Count = 6, CountType = "<", Owner = "any" },
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-human-town-hall", Owner = "self", CheckBuilder = true},
	 "distance", {Distance = 2, DistanceType = ">", Type = "unit-road", Owner = "self"} },
	{"has-unit", { Type = "unit-road", Count = 6, CountType = "<", Owner = "any" },
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-orc-town-hall", Owner = "self", CheckBuilder = true},
	 "distance", {Distance = 2, DistanceType = ">", Type = "unit-road", Owner = "self"} },

	-- the next 12 roads should lead away from the town hall
	{"has-unit", { Type = "unit-road", Count = 6, CountType = ">=", Owner = "any" },
	 "has-unit", { Type = "unit-road", Count = 16, CountType = "<", Owner = "any" },
	 "surrounded-by", { Type = "unit-road", Owner = "self", Count = 1, CountType = "<=", Distance = 1, DistanceType = "=" },
	 "distance", {Distance = 2, DistanceType = ">=", Type = "unit-human-town-hall", Owner = "self", CheckBuilder = true},
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-road", Owner = "self", Diagonal = false} },
	{"has-unit", { Type = "unit-road", Count = 6, CountType = ">=", Owner = "any" },
	 "has-unit", { Type = "unit-road", Count = 16, CountType = "<", Owner = "any" },
	 "surrounded-by", { Type = "unit-road", Count = 1, CountType = "<=", Distance = 1, DistanceType = "=" },
	 "distance", {Distance = 2, DistanceType = ">=", Type = "unit-orc-town-hall", Owner = "self", CheckBuilder = true},
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-road", Owner = "self", Diagonal = false} },

	-- when building next to a road later, do not build next to the town hall
	{"has-unit", { Type = "unit-road", Count = 16, CountType = ">=", Owner = "any" },
	 "surrounded-by", { Type = "unit-road", Count = 3, CountType = "<=", Distance = 1, DistanceType = "=" },
	 "surrounded-by", { Type = "unit-road", Count = 4, CountType = "<=", Distance = 2, DistanceType = "=" },
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-road", Owner = "self"} },
	{"has-unit", { Type = "unit-road", Count = 16, CountType = ">=", Owner = "any" },
	 "surrounded-by", { Type = "unit-road", Count = 3, CountType = "<=", Distance = 1, DistanceType = "=" },
	 "surrounded-by", { Type = "unit-road", Count = 4, CountType = "<=", Distance = 2, DistanceType = "=" },
	 "distance", {Distance = 1, DistanceType = "=", Type = "unit-road", Owner = "self"} }
     },
     BuilderOutside = true,
     Priority = 0,
     HitPoints = 1,
     Icon = "icon-road",
     TileSize = {1, 1}, BoxSize = {32, 32},
     SightRange = 0,
     Indestructible = 1,
     DrawLevel = 0,
     IsNotSelectable = true,
     NonSolid = true,
     Wall = true,
     NoRandomPlacing = false,
	 -- as good as neutral
	 ComputerReactionRange = 0,
	 PersonReactionRange = 0,
	 AnnoyComputerFactor = -100,
	 AiAdjacentRange = 0,
	 Revealer = false,
	 Decoration = true,
	 -- 
     Type = "land", Building = true,
     VisibleUnderFog = true })

UnitTypeFiles["unit-wall"] = {
  forest = "tilesets/forest/neutral/buildings/wall.png",
  swamp = "tilesets/swamp/neutral/buildings/wall.png",
  dungeon = "tilesets/dungeon/neutral/buildings/wall.png"
}
local wallconstructionfiles = {
	 forest = ("tilesets/forest/neutral/buildings/wall_1x1.png"),
	 swamp = ("tilesets/forest/neutral/buildings/wall_1x1.png") }
DefineConstruction(
   "construction-wall",
   {Files = { File = wallconstructionfiles[war1gus.tileset], Size = {32, 32} },
              Constructions = {{Percent = 0, File = "construction", Frame = 0}} })
DefineUnitType(
   "unit-wall",
   { Name = "Wall",
     Image = {"size", {32, 32}},
     Costs = {"time", 100, "gold", 100, "wood", 0},
     BuildingRules = { -- all buildings except the town hall need a road
        {"distance", {Distance = 3, DistanceType = "<=", Owner = "allied"}}},
     BuilderOutside = true,
     Animations = "animations-building",
     Construction = "construction-wall",
     Priority = 0,
     HitPoints = 60,
     Icon = "icon-wall",
     TileSize = {1, 1}, BoxSize = {32, 32},
     SightRange = 0,
     DrawLevel = 40,
     IsNotSelectable = true,
     Wall = true,
     NoRandomPlacing = false,
     Type = "land", Building = true,
     VisibleUnderFog = true })
table.insert(wc1_buildings["orc"], "unit-wall")
table.insert(wc1_buildings["human"], "unit-wall")
