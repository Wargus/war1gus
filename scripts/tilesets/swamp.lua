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
--	swamp.ccl		-	Define the orc swamp tileset.
--
--	(c) Copyright 2000-2003 by Lutz Sammer and Jimmy Salmon
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
--	$Id$

--=============================================================================
--	Define a tileset
--
--	(define-tileset ident class name image palette slots animations)
--
DefineTileset(--"tileset-swamp", "class", "swamp",
  "name", "Swamp",
  "image", "tilesets/swamp/terrain.png",
  -- Slots descriptions
  "slots",
	{
	"special", {		-- Can't be in pud
	  "top-one-tree", 91, "mid-one-tree", 92, "bot-one-tree", 93,
          "removed-tree", 96 },
	"solid", {"unused", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}}, -- fow    -- 000
	"solid", {"same", "water", {114}}, -- water                    -- 010
	"solid", {"wall", "land", "human", "wall", "unpassable",
          {16, 17, 18, 19, 20, 21, 22, 23, 24, 25,
	   26, 27, 28, 29, 30, 31}},                                       -- 020
	"solid", {"unused", {}},                                       -- 030
	"solid", {"forest", "land", "forest", "unpassable",
	  {0, 0, 0, 0, 0, 0, 0, 71, 72, 73,
	   74, 75, 76, 77, 78, 79}},                                   -- 040
	"solid", {"forest", "land", "forest", "unpassable",
	  {80, 81, 82, 83, 84, 85, 86, 87, 88,
	   89, 90, 91, 92, 93, 94, 95}},                                -- 050
	"solid", {"land",
          {96, -- chopped tree
	   97, {"land", "no-building"},
	   98, {"land", "no-building"},
	   99, {"land", "no-building"},
	   100, {"land", "no-building"},
	   101, {"land", "no-building"},
	   102, 103,
	   104, {"land", "no-building"},
	   105, {"land", "no-building"},
	   106, {"land", "no-building"},
	   107, 108,
	   109, {"land", "no-building"},
	   110, {"land", "no-building"},
	   111, {"land", "no-building"}}},                     -- 060
	"solid", {"land",
          {112, 113,
	   114, {"land", "no-building"},
	   115, {"land", "no-building"},
	   116, {"land", "no-building"},
	   117, {"land", "no-building"},
	   118, 119, 120, 121,
	   122, {"land", "no-building"},
	   123, {"land", "no-building"},
	   124, {"land", "no-building"},
	   125, 126, 127}},                                  -- 070
	"solid", {"land",
          {128, 129, 130, 131, 132, 133, 134, 135, 136, 137,
	   138, {"land", "no-building"},
	   139, {"land", "no-building"},
	   140, {"land", "no-building"},
	   141, 142, 143}},                                  -- 080
	"solid", {"land",
          {144, 145, 146, 147, 148, 149, 150, 151,
	   152, 153, 154,155, 156, 157, 158,
	   159, {"land", "no-building"}}},              -- 090
	"solid", {"land",
          {160, {"land", "no-building"},
	   161, {"land", "no-building"},
	   162, {"land", "no-building"},
	   163, {"land", "no-building"},
	   164, 165, 166, 167, 168, 169, 170, 171, 172,
	   173, {"land", "no-building"},
	   174, {"land", "no-building"},
	   175, {"land", "no-building"}}},              -- 0A0
	"solid", {"land",
          {176, {"land", "no-building"},
	   177, {"land", "no-building"},
	   178, 179, 180,
	   181, {"land", "no-building"},
	   182, {"land", "no-building"},
	   183, {"land", "no-building"},
	   184, {"land", "no-building"},
	   185, {"land", "no-building"},
	   186,
	   187, {"coast", "land", "no-building"},
	   188, {"water"},
	   189, {"coast", "land", "no-building"},
	   190, 191}},                             -- 0B0
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
	"solid", {"land",
          {256, 257, 258, 259, 260, 261, 262, 263, 264, 265,
	   266, 267, 268, 269, 270, 271}}, -- 100
	"solid", {"land",
          {272, 273, 274, 275, 276, 277, 278, 279, 280, 281,
	   282}}, -- 110
	"solid", {"land", {}}, -- 120
	"solid", {"unused", {}}, -- 130
	"solid", {"unused", {}}, -- 140
	"solid", {"unused", {}}, -- 150
	"solid", {"unused", {}}, -- 160
	"solid", {"unused", {}}, -- 170
	"solid", {"unused", {}}, -- 180
	"solid", {"unused", {}}, -- 190
	"solid", {"unused", {}}, -- 1A0
	"solid", {"unused", {}}, -- 1B0
	"solid", {"unused", {}}, -- 1C0
	"solid", {"unused", {}}, -- 1D0
	"solid", {"unused", {}}, -- 1E0
	"solid", {"unused", {}}, -- 1F0
	"solid", {"unused", {}}, -- 200
	"solid", {"unused", {}}, -- 210
	"solid", {"unused", {}}, -- 220
	"solid", {"unused", {}}, -- 230
	"solid", {"unused", {}}, -- 240
	"solid", {"unused", {}}, -- 250
	"solid", {"unused", {}}, -- 260
	"solid", {"unused", {}}, -- 270
	"solid", {"unused", {}}, -- 280
	"solid", {"unused", {}}, -- 290
	"solid", {"unused", {}}, -- 2A0
	"solid", {"unused", {}}, -- 2B0
	"solid", {"unused", {}}, -- 2C0
	"solid", {"unused", {}}, -- 2D0
	"solid", {"unused", {}}, -- 2E0
	"solid", {"unused", {}}, -- 2F0
	"solid", {"unused", {}}, -- 300
	"solid", {"unused", {}}, -- 310
	"solid", {"unused", {}}, -- 320
	"solid", {"unused", {}}, -- 330
	"solid", {"unused", {}}, -- 340
	"solid", {"unused", {}}, -- 350
	"solid", {"unused", {}}, -- 360
	"solid", {"unused", {}}, -- 370
	"solid", {"unused", {}}, -- 380
	"solid", {"unused", {}}, -- 390
	"solid", {"unused", {}}, -- 3A0
	"solid", {"unused", {}}, -- 3B0
	"solid", {"unused", {}}, -- 3C0
	"solid", {"unused", {}}, -- 3D0
	"solid", {"unused", {}}, -- 3E0
	"solid", {"unused", {}}, -- 3F0
	"solid", {"unused", {}}, -- 400
	"solid", {"unused", {}}, -- 410
	"solid", {"unused", {}}, -- 420
	"solid", {"unused", {}}, -- 430
	"solid", {"unused", {}}, -- 440
	"solid", {"unused", {}}, -- 450
	"solid", {"unused", {}}, -- 460
	"solid", {"unused", {}}, -- 470
	"solid", {"unused", {}}, -- 480
	"solid", {"unused", {}}, -- 490
	"solid", {"unused", {}}, -- 4A0
	"solid", {"unused", {}}, -- 4B0
	"solid", {"unused", {}}, -- 4C0
	"solid", {"unused", {}}, -- 4D0
	"solid", {"unused", {}}, -- 4E0
	"solid", {"unused", {}}, -- 4F0
	"solid", {"unused", {}}, -- 400
	"solid", {"unused", {}}, -- 510
	"solid", {"unused", {}}, -- 520
	"solid", {"unused", {}}, -- 530
	"solid", {"unused", {}}, -- 540
	"solid", {"unused", {}}, -- 550
	"solid", {"unused", {}}, -- 560
	"solid", {"unused", {}}, -- 570
	"solid", {"unused", {}}, -- 580
	"solid", {"unused", {}}, -- 590
	"solid", {"unused", {}}, -- 5A0
	"solid", {"unused", {}}, -- 5B0
	"solid", {"unused", {}}, -- 5C0
	"solid", {"unused", {}}, -- 5D0
	"solid", {"unused", {}}, -- 5E0
	"solid", {"unused", {}}, -- 5F0
	"solid", {"unused", {}}, -- 600
	"solid", {"unused", {}}, -- 610
	"solid", {"unused", {}}, -- 620
	"solid", {"unused", {}}, -- 630
	"solid", {"unused", {}}, -- 640
	"solid", {"unused", {}}, -- 650
	"solid", {"unused", {}}, -- 660
	"solid", {"unused", {}}, -- 670
	"solid", {"unused", {}}, -- 680
	"solid", {"unused", {}}, -- 690
	"solid", {"unused", {}}, -- 6A0
	"solid", {"unused", {}}, -- 6B0
	"solid", {"unused", {}}, -- 6C0
	"solid", {"unused", {}}, -- 6D0
	"solid", {"unused", {}}, -- 6E0
	"solid", {"unused", {}}, -- 6F0
	"mixed", { "forest", "land", "forest", "unpassable",
          { 71, 79},	-- bottom left, right		        -- 700
	  { 71, 93},	-- bottom left, bottom middle		-- 710
	  { 93, 76},	-- bottom middle, top right		-- 720
	  { 76, 80},	-- top right, centerpiece		-- 730
	  { 75, 81},	-- top middle, centerpiece2             -- 740
	  { 82, 83},	-- centerpiece3, centerpiece4		-- 750
	  { 94, 94},	-- centerpiece5, centerpiece5		-- 760
	  { 73, 77},	-- top left, centerpiece-top-open	-- 770
	  { 81, 82},	-- center-bottom, center-bottom		-- 780
	  { 72, 73},	-- left, top left			-- 790
	  { 94, 94},	-- centerpiece5, centerpiece5		-- 7A0
	  { 93, 72},	-- top right, left			-- 7B0
	  { 94, 94},	-- center-bottom, center-bottom		-- 7C0
	  { 74, 74},	-- center-top, center-top		-- 7D0
	  {},							-- 7E0
	  {}},							-- 7F0
	"mixed", { "human-wall", "dark-grass", "land", "human", "wall", "unpassable",
          {  21,   0,  23,   0,  34},						-- 800
	  {  10,   0,  22,   0,  36},						-- 810
	  {  17,   0,  29,   0,  33},						-- 820
	  {  11,   0,  40,   0,  34},						-- 830
	  {  21,  21,   0,  23,  23,   0,  34,  34},				-- 840
	  {  10,   0,  22,   0,  36},						-- 850
	  {  13,   0,  25,   0,  36},						-- 860
	  {  12,   0,  24,   0,  38},						-- 870
	  {  20,   0,  32,   0,  35},						-- 880
	  {  18,  18,   0,  30,  30,   0,  37,  37},				-- 890
	  {  19,   0,  31,   0,  37},						-- 8A0
	  {  12,   0,  24,   0,  38},						-- 8B0
	  {  15,   0,  27,   0,  33},						-- 8C0
	  {  14,   0,  26,   0,  39},						-- 8D0
	  {},									-- 8E0
	  {}},								        -- 8F0
	"mixed", { "orc-wall", "dark-grass", "land", "human", "wall", "unpassable",
          {  21,   0,  23,   0,  34},						-- 900
	  {  10,   0,  22,   0,  36},						-- 910
	  {  17,   0,  29,   0,  33},						-- 920
	  {  11,   0,  40,   0,  34},						-- 930
	  {  21,  21,   0,  23,  23,   0,  34,  34},				-- 940
	  {  10,   0,  22,   0,  36},						-- 950
	  {  13,   0,  25,   0,  36},						-- 960
	  {  12,   0,  24,   0,  38},						-- 970
	  {  20,   0,  32,   0,  35},						-- 980
	  {  18,  18,   0,  30,  30,   0,  37,  37},				-- 990
	  {  19,   0,  31,   0,  37},						-- 9A0
	  {  12,   0,  24,   0,  38},						-- 9B0
	  {  15,   0,  27,   0,  33},						-- 9C0
	  {  14,   0,  26,   0,  39},						-- 9D0
	  {},									-- 9E0
	  {}},								        -- 9F0
	}
)

BuildTilesetTables()

war1gus.tileset = "swamp"
--Load("scripts/scripts.lua")
