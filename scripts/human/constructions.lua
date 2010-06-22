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
--      constructions.lua - Define the human constructions.
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

--=============================================================================
--	Define a construction.
--
--	(define-construction ident 'files '(tileset-name filename ..)
--	    'size '(x y))

DefineConstruction("construction-human-barracks", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/barracks_construction.png",
    Size = {128, 128}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/barracks_construction.png",
--    Size = {128, 128}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-blacksmith", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/blacksmith_construction.png",
    Size = {96, 96}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/blacksmith_construction.png",
--    Size = {96, 96}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-church", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/church_construction.png",
    Size = {128, 128}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/church_construction.png",
--    Size = {128, 128}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-farm", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/farm_construction.png",
    Size = {96, 96}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/farm_construction.png",
--    Size = {96, 96}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-lumber-mill", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/lumber_mill_construction.png",
    Size = {128, 128}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/lumber_mill_construction.png",
--    Size = {128, 128}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-stable", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/stable_construction.png",
    Size = {128, 128}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/stable_construction.png",
--    Size = {128, 128}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-tower", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/tower_construction.png",
    Size = {96, 96}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/tower_construction.png",
--    Size = {96, 96}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

DefineConstruction("construction-human-town-hall", {
  Files = {
--   {Tileset = "forest",
    File = "tilesets/forest/human/buildings/town_hall_construction.png",
    Size = {128, 128}},
--   {Tileset = "swamp",
--    File = "tilesets/swamp/human/buildings/town_hall_construction.png",
--    Size = {128, 128}}},
  Constructions = {
   {Percent = 0,
    File = "construction",
    Frame = 0},
   {Percent = 33,
    File = "construction",
    Frame = 1},
   {Percent = 67,
    File = "construction",
    Frame = 2}}
})

