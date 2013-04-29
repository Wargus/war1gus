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
--      forest.ccl - Define the orc swamp tileset.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
--
--      This program is free software-- you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation-- either version 2 of the License, or
--      (at your option) any later version.
--  
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY-- without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--  
--      You should have received a copy of the GNU General Public License
--      along with this program-- if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--      $Id$

--=============================================================================
--  Define a tileset
--

--  DefineTileset(ident class name image palette slots animations)
--
DefineTileset("name", "Forest",
  "image", "tilesets/forest/terrain.png",
  "size", {32, 32},
  -- Slots descriptions
  "slots",
	{
	"special", {		-- Can't be in pud
          "removed-tree", 95 },
	"solid", {"unused", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}}, -- fow    -- 000
	"solid", {"same", "water", {114}}, -- water                    -- 010
	"solid", {"unused", {}},                                       -- 020
	"solid", {"unused", {}},                                       -- 030
	"solid", {"forest", "land", "forest", "unpassable",
	  {0, 0, 0, 0, 0, 0, 0, 71, 72, 73,
	   74, 75, 76, 77, 78, 79}},                                   -- 040
	"solid", {"forest", "land", "forest", "unpassable",
	  {80, 81, 82, 83, 84, 85, 86, 87, 88,
	   89, 90, 91, 92, 93, 94, 0}},                                -- 050
	"solid", {"land",
          {96, 97, 98, 99, 100, 101, 102, 103, 104, 105,
	   106, 107, 108, 109, 110, 111}},                             -- 060
	"solid", {"land",
          {112, 113, 114, 115, 116, 117, 118, 119, 120, 121,
	   122, 123, 124, 125, 126, 127}},                             -- 070
	"solid", {"land",
          {128, 129, 130, 131, 132, 133, 134, 135, 136, 137,
	   138, 139, 140, 141, 142, 143}},                             -- 080
	"solid", {"land",
          {144, 145, 146, 147, 148, 149, 150, 151, 152, 153,
	   154, 155, 156, 157, 158, 159}},                             -- 080
	"solid", {"land",
          {160, 161, 162, 163, 164, 165, 166, 167, 168, 169,
	   170, 171, 172, 173, 174, 175}},                             -- 0A0
	"solid", {"land",
          {176, 177, 178, 179, 180, 181, 182, 183, 184, 185,
	   186, 187, 188, 189, 190, 191}},                             -- 0B0
	"solid", {"land",
          {192, 193, 194, 195, 196, 197, 198, 199, 200, 201,
	   201, 203, 204, 205, 206, 207}},                             -- 0C0
	"solid", {"land",
          {208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 
	   218, 219, 220, 221, 222, 223}},                             -- 0D0
	"solid", {"land",
          {224, 225, 226, 227, 228, 229, 230, 231, 232, 233,
	   234, 235, 236, 237, 238, 239}},                             -- 0E0
	"solid", {"land",
          {240, 241, 242, 243, 244, 245, 246, 247, 248, 249,
	   250, 251, 252, 253, 254, 255}},                             -- 0F0
	"solid", {"land",  -- bridge
	  {256, 257, 258, 259, 260, 261, 262, 263, 264, 265,
	   266, 267, 268, 269, 270, 271}},                             -- 100
	"solid", {"land",   -- bridge
	  {272, 273, 274, 275, 276, 277, 278, 279, 280, 281,
	   282, 283, 284, 285, 286, 287}},                             -- 110
	"solid", {"land" ,  -- bridge
	  {288, 289, 290, 291, 292, 293, 294, 295, 296, 297,
	   298, 299, 300, 301, 302, 303}},                             -- 120
	"solid", {"land" ,  -- bridge
	  {304, 305, 306, 307, 308, 309, 310}},                        -- 130
	}
  )

--BuildTilesetTables()


war1gus.tileset = "forest"
Load("scripts/scripts.lua")
