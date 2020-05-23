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
  "size", {16, 16},
  -- Slots descriptions
  "slots",
	{
	"solid", {"land", -- "wall"
          {0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
	   0, 0, 0, 13, 0, 15}},   -- 000
	"solid", {"land", -- "wall"
          {0, 17, 0, 19, 0, 0, 0, 23, 0, 25,
	   0, 27, 0, 29, 30, 31}}, -- water                    -- 010
	"solid", {"land",
          {32, 33, 34, 35, 36, 37, 38, 39, 0, 0,
	   42, 0, 0, 45, 46, 47, {"rock", "unpassable", "opaque"}}},                                       -- 020
	"solid", {"land",
          {48, 49,
	   50, {"rock", "unpassable", "opaque"},
	   51, {"rock", "unpassable", "opaque"},
	   52, {"rock", "unpassable", "opaque"},
	   53, {"rock", "unpassable", "opaque"},
	   54, {"rock", "unpassable", "opaque"},
	   55, {"rock", "unpassable", "opaque"},
	   56, {"rock", "unpassable", "opaque"},
	   57, 58, 59, 60, 61, 62, 63}},                                       -- 030
	"solid", {"land",
	  {64, {"rock", "unpassable", "opaque"},
	   65, {"rock", "unpassable", "opaque"},
	   66, {"rock", "unpassable", "opaque"},
	   67, {"rock", "unpassable", "opaque"},
	   68, {"rock", "unpassable", "opaque"},
	   69, {"land"},
	   70, {"rock", "unpassable"},
	   71, {"rock", "unpassable"},
	   72, {"rock", "unpassable", "opaque"},
	   73, {"unpassable", "opaque"},
	   74, {"unpassable", "opaque"},
	   75, {"land"},
	   76, {"land"},
	   77, {"land"},
	   78, {"land"},
	   79, {"land"}}},                                   -- 040
	"solid", {"land",
	  {80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
	   90, {"rock", "unpassable"},
	   91, {"rock", "unpassable"},
	   92, {"rock", "unpassable"},
	   93, {"rock", "unpassable"},
	   94, {"rock", "unpassable", "opaque"},
	   95, {"rock", "unpassable"}}},                                -- 050
	"solid", {"land",
	 {96, 97,
	  98, {"rock", "unpassable"},
	  99, {"rock", "unpassable", "opaque"},
	  100, {"unpassable"},
	  101, {"unpassable"},
	  102, 103, 104, 105, 106, 107, 108, 109, 110,
	  111, {"rock", "unpassable", "opaque"}}},                     -- 060
	"solid", {"land",
          {112,
	   113, {"rock", "unpassable", "opaque"},
	   114, 115,
	   116, {"rock", "unpassable", "opaque"},
	   117, 118,
	   119, {"rock", "unpassable"},
	   120, 121, 122, 123, 124, 125, 126, 127}},                                  -- 070
	"solid", {"land",
          {128, 129, 130, 131, 132, 133, 134, 135,
	   136, {"rock", "unpassable", "opaque"},
	   137, {"rock", "unpassable", "opaque"},
	   138, {"rock", "unpassable", "opaque"},
	   139, 140, 141, 142, 143}},                                  -- 080
	"solid", {"land",
          {0, -- remapped default door, for destructions
           145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, {"rock", "unpassable", "opaque"}}},                             -- 090
	"solid", {"land",
          {0, -- remapped default door, for destructions
	   161, 162, 163, 164, 165, 166,
	   167, 168, 169, 170, 171, 172, 173, 174, 175}},              -- 0A0
	"solid", {"land",
          {176,
	   177, {"rock", "unpassable"},
	   178, {"rock", "unpassable"},
	   179,
	   180, {"rock", "unpassable", "opaque"},
	   181, {"rock", "unpassable", "opaque"},
	   182, {"rock", "unpassable", "opaque"},
	   183, 184, 185, 186, 187, 188, 189, 190, 191}},                             -- 0B0
	"solid", {"land",
          {192, 193, 194, 195, 196, 197, 198,
	   199, {"rock", "unpassable"},
	   200, 201, 201, 203,
	   204, {"rock", "unpassable", "opaque"},
	   205, {"rock", "unpassable", "opaque"},
	   206, {"rock", "unpassable", "opaque"},
	   207, {"rock", "unpassable", "opaque"}}},                             -- 0C0
	"solid", {"land",
		  {208, 209, 210,
	   211, {"rock", "unpassable"},
	   212, {"rock", "unpassable"},
	   213, 214, 215, 216, 217, 218,
	   219, {"rock", "unpassable", "opaque"},
	   220, {"rock", "unpassable", "opaque"},
	   221, {"rock", "unpassable", "opaque"},
	   222, {"rock", "unpassable", "opaque"},
	   223}},                                                    -- 0D0
	"solid", {"land",
          {224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237,
	   238, {"rock", "unpassable"},
	   239, {"rock", "unpassable"}}},                             -- 0E0
	"solid", {"land",
		  {240, {"rock", "unpassable", "opaque"},
	   241, {"rock", "unpassable", "opaque"},
	   242, {"rock", "unpassable", "opaque"},
	   243, {"rock", "unpassable", "opaque"},
	   244, {"rock", "unpassable", "opaque"},
	   245, {"rock", "unpassable", "opaque"},
	   246, 247, 248, 249, 250, 251, 252, 253, 254, 255,}},                             -- 0F0
	"solid", {"land",  -- bridge
	  {256, 257, 258, 259,
	   260, {"rock", "unpassable", "opaque"},
	   261, {"rock", "unpassable", "opaque"},
	   262, 263,
	   264, {"rock", "unpassable"},
	   265, {"rock", "unpassable"},
	   266, {"rock", "unpassable", "opaque"},
	   267, {"rock", "unpassable"},
	   268, {"unpassable"},
	   269, {"unpassable"},
	   270, {"rock", "unpassable"},
	   271, {"rock", "unpassable", "opaque"}}},                             -- 100
	"solid", {"land",   -- bridge
	  {272, 273,
	   274, {"rock", "unpassable"},
	   275, {"rock", "unpassable"},
	   276, {"rock", "unpassable"},
	   277, {"rock", "unpassable"},
	   278, {"rock", "unpassable"},
	   279, 280, 281,
	   282, {"rock", "unpassable"},
	   283,
	   284, {"rock", "unpassable"},
	   285, {"rock", "unpassable"},
	   286, 287}},                             -- 110
	"solid", {"land" ,  -- bridge
	  {288, {"rock", "unpassable"},
	   289, {"rock", "unpassable"},
	   290, {"rock", "unpassable", "opaque"},
	   291, {"rock", "unpassable"},
	   292, 293,
	   294, {"rock", "unpassable"},
	   295, {"rock", "unpassable", "opaque"},
	   296, 297, 298, 299, 300,
	   301, {"rock", "unpassable", "opaque"},
	   302, 303}},                             -- 120
	"solid", {"land",
	  {304, {"rock", "unpassable", "opaque"},
	   305, 306, 307, 308,
	   309, {"rock", "unpassable"},
	   310, 311,
	   312, {"rock", "unpassable"},
	   313, {"rock", "unpassable"},
	   314, 315,
	   316, {"rock", "unpassable"},
	   317, {"rock", "unpassable", "opaque"},
	   318, 319}},                        -- 130,
	"solid", {"land",  -- bridge
	  {320, {"rock", "unpassable", "opaque"},
	   321, {"rock", "unpassable", "opaque"},
	   322, {"rock", "unpassable", "opaque"},
	   323, {"rock", "unpassable", "opaque"},
	   324, {"rock", "unpassable", "opaque"},
	   325, {"rock", "unpassable", "opaque"},
	   326, {"rock", "unpassable", "opaque"},
	   327, {"rock", "unpassable", "opaque"},
	   328, {"rock", "unpassable", "opaque"},
	   329, {"rock", "unpassable", "opaque"},
	   330, {"rock", "unpassable", "opaque"},
	   331, {"rock", "unpassable", "opaque"},
	   332, {"land"},
	   333, {"land"},
	   334, {"rock", "unpassable", "opaque"},
	   335, {"rock", "unpassable", "opaque"}}},                        -- 140,
	"solid", {"rock", "unpassable", "opaque",  -- bridge
	  {336, 337}},                        -- 150,
    "solid", {"unused", {}},                                  -- 160
    "solid", {"unused", {}}, -- 170
    "solid", {"remapped-land", {144,
                                160, {"rock", "unpassable", "opaque"}}}, -- 180
    "solid", {"unused", {}}, -- 190
    "solid", {"unused", {}}, -- 1A0
    "solid", {"unused", {}}, -- 1B0
    "solid", {"unused", {}}, -- 1C0
    "solid", {"unused", {}}, -- 1D0
    "solid", {"unused", {}}, -- 1E0
    "solid", {"unused", {}}, -- 1F0
    "mixed", {"unused", "unused", {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, -- 200
    "mixed", {"unused", "unused", {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, -- 300
    "mixed", {"unused", "unused", {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, -- 400
    "mixed", {"unused", "unused", {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, -- 500
    "mixed", {"unused", "unused", {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, -- 600
    "mixed", {"unused", "unused", {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}}, -- 700
    "mixed", { "human-wall", "dark-grass", "land", "human", "wall", "unpassable", "opaque",
    {0x0b,   0,  0x15,   0,  0x1f},						-- 800
    {0x0c,   0,  0x16,   0,  0x20},						-- 810
    {   0,   0,     0,   0,     0},						-- 820
    {0x0a,   0,  0x14,   0,  0x1e},						-- 830
    {   0,   0,     0,   0,     0},     				-- 840
    {   0,   0,     0,   0,     0},						-- 850
    {   0,   0,     0,   0,     0},						-- 860
    {0x0e,   0,  0x18,   0,  0x22},						-- 870
    {   0,   0,     0,   0,     0},						-- 880
    {   0,   0,     0,   0,     0},		        		-- 890
    {   0,   0,     0,   0,     0},						-- 8A0
    {   0,   0,     0,   0,     0},						-- 8B0
    {},						-- 8C0
    {},						-- 8D0
    {},									-- 8E0
    {}},								-- 8F0
    "mixed", { "orc-wall", "dark-grass", "land", "wall", "unpassable", "opaque",
    {0x28,   0,  0x29,   0,  0x2a},						-- 900
    {0x10,   0,  0x1a,   0,  0x24},						-- 910
    {   0,   0,     0,   0,     0},						-- 920
    {0x2b,   0,  0x2c,   0,  0x2d},						-- 930
    {   0,   0,     0,   0,     0},     				-- 940
    {   0,   0,     0,   0,     0},						-- 950
    {   0,   0,     0,   0,     0},						-- 960
    {0x12,   0,  0x1c,   0,  0x26},						-- 970
    {   0,   0,     0,   0,     0},						-- 980
    {   0,   0,     0,   0,     0},		        		-- 990
    {   0,   0,     0,   0,     0},						-- 9A0
    {   0,   0,     0,   0,     0},						-- 9B0
    {},						-- 9C0
    {}}						-- 9D0
	}
  )

BuildTilesetTables() -- needs proper wall definitions
war1gus.tileset = "dungeon_campaign"
Load("scripts/scripts.lua")

local wallTileMapping = {}
wallTileMapping[0x0b] = 0x800
wallTileMapping[0x15] = 0x802
wallTileMapping[0x0c] = 0x810
wallTileMapping[0x16] = 0x812
wallTileMapping[0x0a] = 0x830
wallTileMapping[0x14] = 0x832
wallTileMapping[0x0e] = 0x870
wallTileMapping[0x18] = 0x872
wallTileMapping[0x28] = 0x900
wallTileMapping[0x29] = 0x902
wallTileMapping[0x10] = 0x910
wallTileMapping[0x1a] = 0x912
wallTileMapping[0x2b] = 0x930
wallTileMapping[0x2c] = 0x932
wallTileMapping[0x12] = 0x970
wallTileMapping[0x1c] = 0x972
-- hardcoded default walls for human and orc
-- remap those tiles to something else, their
-- indices must have placeholders
wallTileMapping[0x90] = 0x180
wallTileMapping[0xa0] = 0x181

-- Transformation function to translate tile indices for doors into wall indices
OldSetTile = SetTile
function SetTile(oldidx, x, y, oldvalue)
    local idx = wallTileMapping[oldidx] or oldidx
    local value = oldvalue
    if (idx ~= oldidx) then
      value = 35 -- doors are lighter than walls
    end
    if (x == 63 and y == 63) then
      -- campaign maps are always 64x64, reset the old SetTile function
      SetTile = OldSetTile
    end
    return OldSetTile(idx, x, y, 100)
end
