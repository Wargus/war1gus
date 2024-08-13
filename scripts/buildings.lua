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

townHallBuildingRules = nil
if (preferences.AllowMultipleTownHalls) then
  townHallBuildingRules = {
    { "distance", { Distance = 4, DistanceType = ">", Type = "unit-gold-mine" },
      "distance", { Distance = 4, DistanceType = ">", Type = "unit-dungeon-entrance" } } }
else
  townHallBuildingRules = {
    { "has-unit", { Type = "unit-human-town-hall", Count = 0, CountType = "=" },
      "has-unit", { Type = "unit-orc-town-hall", Count = 0, CountType = "=" },
      "has-unit", { Type = "unit-human-stormwind-keep", Count = 0, CountType = "=" },
      "has-unit", { Type = "unit-orc-blackrock-spire", Count = 0, CountType = "=" },
      "distance", { Distance = 4, DistanceType = ">", Type = "unit-gold-mine" },
      "distance", { Distance = 4, DistanceType = ">", Type = "unit-dungeon-entrance" } } }
end

for i=1,4,1 do
  for j=1,i,1 do
    UnitTypeFiles["unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. j] = {
      forest = "tilesets/forest/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
      swamp = "tilesets/swamp/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
      forest_campaign = "tilesets/forest/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
      swamp_campaign = "tilesets/swamp/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
      dungeon = "tilesets/dungeon/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png",
      dungeon_campaign = "tilesets/dungeon/neutral/buildings/ruins_" .. j .. "x" .. j .. ".png"}
    DefineUnitType("unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. j, {
      Name = "unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. j,
      Image = {"size", {j * 16, j * 16}},
      Animations = "animations-ruins",
      Icon = "icon-peasant",
      Speed = 0,
      HitPoints = 255,
      DrawLevel = 10,
      TileSize = {i, i}, BoxSize = {i * 16 - 1, i * 16 - 1},
      SightRange = 0,
      Indestructible = 1,
      IsNotSelectable = true,
      NonSolid = true,
      -- as good as neutral
      ComputerReactionRange = 0,
      PersonReactionRange = 0,
      AnnoyComputerFactor = -100,
      AiAdjacentRange = 0,
      Revealer = false,
      Decoration = true,
      BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
      Priority = 0,
      Type = "land",
      Building = true,
      VisibleUnderFog = true,
      Corpse = (j ~= 1 and ("unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. (j - 1))) or nil,
      Vanishes = (j == 1),
      Sounds = {} } )
  end

  UnitTypeFiles["unit-destroyed-" .. i .. "x" .. i .. "-place"] = {
    forest = "tilesets/forest/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
    swamp = "tilesets/swamp/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
    forest_campaign = "tilesets/forest/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
    swamp_campaign = "tilesets/swamp/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
    dungeon = "tilesets/dungeon/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png",
    dungeon_campaign = "tilesets/dungeon/neutral/buildings/ruins_" .. i .. "x" .. i .. ".png"}

  DefineUnitType("unit-destroyed-" .. i .. "x" .. i .. "-place", {
    Name = "unit-destroyed-" .. i .. "x" .. i .. "-place",
    Image = {"size", {i * 16, i * 16}},
    Animations = "animations-ruins",
    Icon = "icon-peasant",
    Speed = 0,
    HitPoints = 0,
    DrawLevel = 10,
    TileSize = {i, i}, BoxSize = {i * 16 - 1, i * 16 - 1},
    SightRange = 0,
    Indestructible = 1,
    IsNotSelectable = true,
    NonSolid = true,
    -- as good as neutral
    ComputerReactionRange = 0,
    PersonReactionRange = 0,
    AnnoyComputerFactor = -100,
    AiAdjacentRange = 0,
    Revealer = false,
    Decoration = true,
    BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
    Priority = 0,
    Type = "land",
    Building = true,
    VisibleUnderFog = true,
    Corpse = (i ~= 1 and ("unit-destroyed-" .. i .. "x" .. i .. "-place-reduced-to-" .. (i - 1))) or nil,
    Vanishes = (i == 1),
    Sounds = {} } )
end

local buildings = {
   {Names = {orc = "Farm", human = "Farm"},
    Costs = {"time", 100, "gold", 500, "wood", 300},
    HitPoints = 400,
    Supply = 5,
    Size = {48, 48},
    Corpse = "unit-destroyed-2x2-place"},

   {Names = {orc = "Town hall", human = "Town hall"},
    Costs = {"time", 100, "gold", 400, "wood", 400},
    HitPoints = 2500,
    CanStore = {"wood", "gold", "lumber", "treasure"},
    Supply = 5,
    RepairRange = InfiniteRepairRange,
    BuildingRules = townHallBuildingRules,
    AiBuildingRules = townHallBuildingRules,
    Size = {64, 64}},

   {Names = {orc = "Barracks", human = "Barracks"},
    Costs = {"time", 150, "gold", 600, "wood", 500},
    HitPoints = 800,
    AnnoyComputerFactor = 50,
    Size = {64, 64}},

   {Names = {orc = "Lumber Mill", human = "Lumber Mill"},
    Costs = {"time", 150, "gold", 600, "wood", 500},
    HitPoints = 600,
    CanStore = {"wood", "lumber"},
    Size = {64, 64}},

   {Names = {orc = "Kennel", human = "Stable"},
    Costs = {"time", 150, "gold", 1000, "wood", 400},
    HitPoints = 500,
    Size = {orc = {64, 48}, human = {64, 64}},
    Dependency = {human = "lumber-mill", orc = "lumber-mill"}},

   {Names = {orc = "Blacksmith", human = "Blacksmith"},
    Costs = {"time", 150, "gold", 900, "wood", 400},
    HitPoints = 800,
    Size = {48, 48},
    Dependency = {orc = "lumber-mill", human = "lumber-mill"},
    Corpse = "unit-destroyed-2x2-place"},

   {Names = {human = "Church", orc = "Temple"},
    Costs = {"time", 200, "gold", 800, "wood", 500},
    HitPoints = 700,
    AnnoyComputerFactor = 60,
    Size = {64, 64},
    Dependency = {orc = "lumber-mill", human = "lumber-mill"}},

   {Names = {orc = "Tower", human = "Tower"},
    Costs = {"time", 200, "gold", 1400, "wood", 300},
    HitPoints = 900,
    AnnoyComputerFactor = 60,
    Size = {48, 48},
    Dependency = {orc = "blacksmith", human = "blacksmith"},
    Corpse = "unit-destroyed-2x2-place"},

   {Names = {human = "Stormwind keep", orc = "Blackrock spire"},
    Costs = {"time", 100, "gold", 500, "wood", 250},
    HitPoints = 5000,
    Size = {80, 80},
    CanStore = {"wood", "gold"},
    Supply = 5,
    RepairRange = InfiniteRepairRange,
    NotConstructable = true,
    Corpse = "unit-destroyed-4x4-place"}
}

for idx,building in ipairs(buildings) do
   DefineBuildingFromSpec(building)
end

DefineAnimations(
  "collapse",
  {Death = {"unbreakable begin", "frame 0", "wait 600", "label loop",
    "wait 100", "exact-frame 0", "goto loop", "unbreakable end", "wait 1"}})

DefineUnitType("unit-destroyed-entrance",
{
	Name = "destroyed-entrance",
	Image = {"size", {32, 48}, "file", "contrib/graphics/buildings/entrance_collapse_2x3.png"},
	Animations = "collapse",
	Icon = "icon-peasant",
	Speed = 0,
	HitPoints = 255,
	DrawLevel = 10,
	TileSize = {2, 3}, BoxSize = {34, 50},
	SightRange = 0,
	Indestructible = 1,
	IsNotSelectable = true,
	ComputerReactionRange = 0,
	PersonReactionRange = 0,
	AnnoyComputerFactor = -100,
	AiAdjacentRange = 0,
	Revealer = false,
	Decoration = true,
	BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
	Priority = 0,
	Type = "land",
	Building = true,
	VisibleUnderFog = true,
	Sounds = {}
} )

DefineUnitType(
   "unit-start-location",
   { Name = "Start Location",
     Image = {"size", {15, 11},
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
  dungeon = "contrib/graphics/buildings/dungeon_road.png",
  dungeon_campaign = "contrib/graphics/buildings/dungeon_road.png",
  forest_campaign = "tilesets/forest/neutral/buildings/road.png",
  swamp_campaign = "tilesets/swamp/neutral/buildings/road.png"
}
DefineConstruction(
   "construction-none",
   {Constructions = {{Percent = 0, File = "main", Frame = 0}}})

UnitTypeFiles["unit-gold-mine"] = {
  forest = "tilesets/forest/neutral/buildings/gold_mine.png",
  swamp = "tilesets/swamp/neutral/buildings/gold_mine.png",
  forest_campaign = "tilesets/forest/neutral/buildings/gold_mine.png",
  swamp_campaign = "tilesets/swamp/neutral/buildings/gold_mine.png",
  dungeon = "tilesets/swamp/neutral/buildings/gold_mine.png",
  dungeon_campaign = "tilesets/swamp/neutral/buildings/gold_mine.png"
}

DefineUnitType("unit-gold-mine", { Name = "Gold Mine",
  Image = {"size", {64, 64}},
  Animations = "animations-building", Icon = "icon-gold-mine",
  NeutralMinimapColor = {200, 200, 200},
  Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none",
--  Speed = 0,
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {3, 3}, BoxSize = {47, 47},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-3x3-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
  GivesResource = "gold", CanHarvest = true,
  MaxOnBoard = 5,
  Sounds = {
    "selected", "gold-mine-selected",
    "acknowledge", "gold-mine-acknowledge",
    "ready", "gold-mine-ready",
    "help", "gold-mine-help",
    "dead", "building destroyed",
--    "attack", "gold-mine-attack"
}} )

local dungeon = CIcon:New("icon-dungeon-entrance")
dungeon.G = CPlayerColorGraphic:New("contrib/graphics/ui/icon-dungeon-entrance.png", 27, 19)
dungeon.Frame = 0

DefineUnitType(
   "unit-dungeon-entrance",
   { Name = "Exit to Forest",
     Image = {"size", {32, 48},
              "file", "contrib/graphics/buildings/entrance_2x3.png"},
     Animations = "animations-building", Icon = "icon-dungeon-entrance",
     NeutralMinimapColor = {200, 200, 200},
     Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none",
--  Speed = 0,
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {2, 3}, BoxSize = {34, 50},
  SightRange = 1,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-entrance",
  ExplodeWhenKilled = "missile-explosion",
  Type = "naval",
  Building = true, VisibleUnderFog = true,
  GivesResource = "lumber", CanHarvest = true,
  MaxOnBoard = 5,
  Sounds = {
    "selected", "gold-mine-selected",
    "acknowledge", "gold-mine-acknowledge",
    "ready", "gold-mine-ready",
    "help", "gold-mine-help",
    "dead", "building destroyed",
}} )


DefineUnitType(
   "unit-road",
   { Name = "Road",
   Image = {"size", {16, 16}},
   Costs = {"time", 1, "gold", 50},
   Animations = "animations-building",
   Construction = "construction-none",
   NeutralMinimapColor = {100, 100, 100},
   OnInit = function(unit)
    SetUnitVariable(unit, "Player", 15);
  end,
  BuildingRules = {
    {"distance", {Distance = 1, DistanceType = "=", Type = "unit-road", Diagonal = false},
    "distance", {Distance = 0, DistanceType = "!=", Type = "unit-road"}},
    {"distance", {Distance = 1, DistanceType = "=", Type = "unit-human-town-hall", Owner = "self", CheckBuilder = true},
    "distance", {Distance = 0, DistanceType = "!=", Type = "unit-road"}},
    {"distance", {Distance = 1, DistanceType = "=", Type = "unit-orc-town-hall", Owner = "self", CheckBuilder = true},
    "distance", {Distance = 0, DistanceType = "!=", Type = "unit-road"}}},
    BuilderOutside = true,
    Priority = 0,
    HitPoints = 0,
    Icon = "icon-road",
    TileSize = {1, 1}, BoxSize = {16, 16},
    SightRange = 0,
    Indestructible = 1,
    DrawLevel = 0,
    Flip = false,
    NumDirections = 16,
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
  forest_campaign = "tilesets/forest/neutral/buildings/wall.png",
  swamp_campaign = "tilesets/swamp/neutral/buildings/wall.png",
  dungeon = "tilesets/dungeon/neutral/buildings/wall.png",
  dungeon_campaign = "tilesets/dungeon/neutral/buildings/wall.png"
}
local wallconstructionfiles = {
  forest = ("tilesets/forest/neutral/buildings/wall_1x1.png"),
  swamp = ("tilesets/forest/neutral/buildings/wall_1x1.png"),
  forest_campaign = ("tilesets/forest/neutral/buildings/wall_1x1.png"),
  swamp_campaign = ("tilesets/forest/neutral/buildings/wall_1x1.png"),
  dungeon = "tilesets/dungeon/neutral/buildings/wall_1x1.png",
  dungeon_campaign = "tilesets/dungeon/neutral/buildings/wall_1x1.png" }
DefineConstruction(
   "construction-wall",
   {Files = { File = wallconstructionfiles[war1gus.tileset], Size = {16, 16} },
              Constructions = {{Percent = 0, File = "construction", Frame = 0}} })
DefineUnitType(
   "unit-wall",
   { Name = "Wall",
     Image = {"size", {16, 16}},
     Costs = {"time", 100, "gold", 100, "wood", 0},
     BuildingRules = { -- all buildings except the town hall need a road
        {"distance", {Distance = 3, DistanceType = "<=", Owner = "allied"}}},
     BuilderOutside = true,
     Animations = "animations-building",
     Construction = "construction-wall",
     Priority = 0,
     HitPoints = 60,
     Flip = false,
     NumDirections = 16, 
     Icon = "icon-wall",
     TileSize = {1, 1}, BoxSize = {16, 16},
     SightRange = 0,
     DrawLevel = 40,
     IsNotSelectable = true,
     Wall = true,
     NoRandomPlacing = false,
     Type = "land", Building = true,
     VisibleUnderFog = true })
table.insert(wc1_buildings["orc"], "unit-wall")
table.insert(wc1_buildings["human"], "unit-wall")

-- dungeon decoration
DefineUnitType(
   "unit-pentagram",
   { Name = "Pentagram",
     Image = {"size", {32, 32},
              "file", "tilesets/dungeon/neutral/buildings/pentagram_2x2.png"},
     Animations = "animations-building", Icon = "icon-dungeon-entrance",
     NeutralMinimapColor = {200, 200, 200},
     Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none", 
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {34, 34},
  SightRange = 0,
  Indestructible = 1,
  IsNotSelectable = true,
  NonSolid = true,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
} )

DefineUnitType(
   "unit-north-wall",
   { Name = "Wall",
     Image = {"size", {32, 32},
              "file", "tilesets/dungeon/neutral/buildings/north-wall_2x2.png"},
     Animations = "animations-building", Icon = "icon-dungeon-entrance",
     NeutralMinimapColor = {200, 200, 200},
     Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none", 
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {34, 34},
  SightRange = 0,
  Indestructible = 1,
  IsNotSelectable = true,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
} )

DefineUnitType(
   "unit-wall-barrels",
   { Name = "Barrels",
     Image = {"size", {32, 32},
              "file", "tilesets/dungeon/neutral/buildings/north-wall-barrels_2x2.png"},
     Animations = "animations-building", Icon = "icon-dungeon-entrance",
     NeutralMinimapColor = {200, 200, 200},
     Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none", 
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {34, 34},
  SightRange = 0,
  Indestructible = 1,
  IsNotSelectable = true,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
} )

DefineUnitType(
   "unit-wall-cupboard",
   { Name = "Cupboard",
     Image = {"size", {32, 32},
              "file", "tilesets/dungeon/neutral/buildings/north-wall-cupboard_2x2.png"},
     Animations = "animations-building", Icon = "icon-dungeon-entrance",
     NeutralMinimapColor = {200, 200, 200},
     Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none", 
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {34, 34},
  SightRange = 0,
  Indestructible = 1,
  IsNotSelectable = true,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
} )

DefineUnitType(
   "unit-wall-wardrobe",
   { Name = "Wardrobe",
     Image = {"size", {32, 32},
              "file", "tilesets/dungeon/neutral/buildings/north-wall-wardrobe_2x2.png"},
     Animations = "animations-building", Icon = "icon-dungeon-entrance",
     NeutralMinimapColor = {200, 200, 200},
     Neutral = true,
  Costs = {"time", 150},
  Construction = "construction-none", 
  HitPoints = 25500,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {34, 34},
  SightRange = 0,
  Indestructible = 1,
  IsNotSelectable = true,
  Armor = 20, BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
  Priority = 0,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-explosion",
  Type = "land",
  Building = true, VisibleUnderFog = true,
} )
