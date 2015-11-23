--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--			  T H E   W A R   B E G I N S
--	   Stratagus - A free fantasy real time strategy game engine
--
--	summer.ccl		-	Define the summer tileset.
--
--	(c) Copyright 2000-2003 by Lutz Sammer and Jimmy Salmon
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
--	$Id$

--=============================================================================
--	Define a tileset
--
--	(define-tileset ident class name image palette slots animations)
--
DefineTileset("name", "dungeon_campaign",
  "image", "tilesets/dungeon/terrain.png",
  "size", {32, 32},
  -- Slots descriptions
  "slots",
	{
	"solid", {"land", -- "wall"
          {0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
	   10, 11, 12, 13, 14, 15}},   -- 000
	"solid", {"land", -- "wall"
          {16, 17, 18, 19, 20, 31, 22, 23, 24, 25,
	   26, 27, 28, 29, 30, 31}}, -- water                    -- 010
	"solid", {"land",
          {32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
	   42, 43, 44, 45, 46, 47, {"rock", "unpassable"}}},                                       -- 020
	"solid", {"land",
          {48, 49,
	   50, {"rock", "unpassable"},
	   51, {"rock", "unpassable"},
	   52, {"rock", "unpassable"},
	   53, {"rock", "unpassable"}, 
	   54, {"rock", "unpassable"}, 
	   55, {"rock", "unpassable"}, 
	   56, {"rock", "unpassable"}, 
	   57, 58, 59, 60, 61, 62, 63}},                                       -- 030
	"solid", {"rock", "unpassable",
	  {64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
	   75, {"land"},
	   76, {"land"},
	   77, {"land"},
	   78, {"land"},
	   79, {"land"}}},                                   -- 040
	"solid", {"land",
	  {80, 81, 82, 83, 84, 85, 86, 87,
	   88, {"rock", "unpassable"},
	   89, {"rock", "unpassable"},
	   90, {"rock", "unpassable"},
	   91, {"rock", "unpassable"},
	   92, {"rock", "unpassable"},
	   93, {"rock", "unpassable"},
	   94, {"rock", "unpassable"},
	   95, {"rock", "unpassable"}}},                                -- 050
	"solid", {"land",
	 {96, {"rock", "unpassable"},
	  97, {"rock", "unpassable"},
	  98, {"rock", "unpassable"},
	  99, {"rock", "unpassable"},
	  100, {"rock", "unpassable"},
	  101, {"rock", "unpassable"},
	  102, 103, 104, 105, 106, 107, 108, 109, 110,
	  111, {"rock", "unpassable"}}},                     -- 060
	"solid", {"land",
          {112,
	   113, {"rock", "unpassable"},
	   114, {"rock", "unpassable"},
	   115,
	   116, {"rock", "unpassable"},
	   117, {"rock", "unpassable"},
	   118, 119,
	   120, {"rock", "unpassable"},
	   121, 122, 123, 124, 125, 126, 127}},                                  -- 070
	"solid", {"land",
          {128, 129, 130, 131, 132, 133, 134, 135,
	   136, {"rock", "unpassable"},
	   137, {"rock", "unpassable"},
	   138, {"rock", "unpassable"},
	   139, 140, 141, 142, 143}},                                  -- 080
	"solid", {"land",
          {144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158,
	   159, {"rock", "unpassable"}}},                             -- 090
	"solid", {"land",
          {160, {"rock", "unpassable"},
	   161, 162, 163, 164, 165, 166, 
	   167, 168, 169, 170, 171, 172, 173, 174, 175}},              -- 0A0
	"solid", {"land",
          {176,
	   177, {"rock", "unpassable"},
	   178, {"rock", "unpassable"},
	   179,
	   180, {"rock", "unpassable"},
	   181, {"rock", "unpassable"},
	   182, {"rock", "unpassable"},
	   183, 184, 185, 186, 187, 188, 189, 190, 191}},                             -- 0B0
	"solid", {"land",
          {192, 193, 194, 195, 196, 197, 198,
	   199, {"rock", "unpassable"},
	   200, 201, 201, 203,
	   204, {"rock", "unpassable"},
	   205, {"rock", "unpassable"},
	   206, {"rock", "unpassable"},
	   207, {"rock", "unpassable"}}},                             -- 0C0
	"solid", {"land",
          {208, 209, 210, 211, 212, 213, 214, 215, 216,
	   217, {"rock", "unpassable"},
	   218, 219, 220, 221,
	   222, {"rock", "unpassable"},
	   223, {"rock", "unpassable"}}},                             -- 0D0
	"solid", {"land",
          {224, 225, 226,
	   227, {"rock", "unpassable"},
	   228, {"rock", "unpassable"},
	   229, 230, 231, 232, 233, 234,
	   235, {"rock", "unpassable"},
	   236, {"rock", "unpassable"},
	   237, {"rock", "unpassable"},
	   238, {"rock", "unpassable"},
	   239}},                             -- 0E0
	"solid", {"land",
          {240, 241, 242, 243, 244, 245, 246, 247, 248, 249,
	   250, 251, 252, 253,
	   254, {"rock", "unpassable"},
	   255, {"rock", "unpassable"}}},                             -- 0F0
	"solid", {"land",  -- bridge
	  {256, {"rock", "unpassable"},
	   257, {"rock", "unpassable"},
	   258, {"rock", "unpassable"},
	   259, {"rock", "unpassable"},
	   260, {"rock", "unpassable"},
	   261, {"rock", "unpassable"},
	   262, 263, 264, 265, 266, 267, 268, 269, 270, 271}},                             -- 100
	"solid", {"land",   -- bridge
	  {272, 273, 274, 275,
	   276, {"rock", "unpassable"},
	   277, {"rock", "unpassable"},
	   278, 279,
	   280, {"rock", "unpassable"},
	   281, {"rock", "unpassable"},
	   282, {"rock", "unpassable"},
	   283, {"rock", "unpassable"},
	   284, {"rock", "unpassable"},
	   285, {"rock", "unpassable"},
	   286, {"rock", "unpassable"},
	   287, {"rock", "unpassable"}}},                             -- 110
	"solid", {"land" ,  -- bridge
	  {288, 289,
	   290, {"land", "unpassable"},
	   291, {"land", "unpassable"},
	   292, {"land", "unpassable"},
	   293, {"land", "unpassable"},
	   294, {"land", "unpassable"},
	   295, 296, 297,
	   298, {"land", "unpassable"},
	   299,
	   300, {"rock", "unpassable"},
	   301, {"rock", "unpassable"},
	   302, 303}},                             -- 120
	"solid", {"rock", "unpassable",
	  {304, 305, 306, 307, 308, 309, 310, 311,
	   312, {"land"},
	   313, {"land"},
	   314, {"land"},
	   315, {"land"},
	   316, {"land"},
	   317, 318, 319}},                        -- 130,
	"solid", {"rock", "unpassable",  -- bridge
	  {320,
	   321, {"land"},
	   322, {"land"},
	   323, {"land"},
	   324, {"land"}, 
	   325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335}},                        -- 140,
	"solid", {"rock", "unpassable",  -- bridge
	  {336, 337}},                        -- 150,
	}
  )

-- BuildTilesetTables() -- needs proper wall definitions
war1gus.tileset = "dungeon_campaign"
Load("scripts/scripts.lua")
