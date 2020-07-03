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
	{ "special", {		-- Can't be in pud
    "top-one-tree", 0x5a, "mid-one-tree", 0x5b, "bot-one-tree", 0x5c,
    "removed-tree", 95 },
  "solid", { "unused",
    {}},								-- 000
  "solid", { "unused",
    {}},								-- 010
  "solid", { "water", "water",
    { 164 }},						-- 020
  "solid", { "unused",
    {}},	-- 030
  "solid", { "light-grass", "land",
    { 122 }},	-- 040
  "solid", { "medium-grass", "land",
    { 119, 173, 241, 242, 246, 247, 248, 249, 250, 251 }},	-- 050
  "solid", { "dark-grass", "land",
    { 168 }},	-- 060
  "solid", { "forest", "land", "forest", "unpassable",
    { 0x5e }},							-- 070
  "solid", { "bridge-horizontal", "land", "no-building",
    { 288, 287, 286, 285, 284, 278, 277 }},						-- 080
  "solid", { "bridge-vertical", "land", "no-building",
    { 291, 300, 282, 273 }},					-- 090
  "solid", { "unused",
    {}},					-- 0A0
  "solid", { "unused",
    {}},					-- 0B0
  "solid", { "unused",
    {}},					-- 0C0
  "solid", { "unused",
    {}},								-- 0D0
  "solid", { "unused",
    {}},								-- 0E0
  "solid", { "unused",
    {}},								-- 0F0
  "mixed", { "water", "medium-grass", "land", "no-building",
    { 166 },							-- 100
    { 165 },							-- 110
    { 107 },							-- 120
    { 111 },							-- 130
    { 124 },							-- 140
    { 143 },							-- 150
    { 106 },							-- 160
    { 110 },							-- 170
    { 143 },							-- 180
    { 125 },							-- 190
    { 108 },							-- 1A0
    { 96 },							-- 1B0
    { 115 },							-- 1C0
    { 113 },							-- 1D0
    {},									-- 1E0
    {}},								-- 1F0
  "mixed", { "medium-grass", "light-grass", "land",
    { 183 },							-- 200
    { 181 },							-- 210
    { 104 },							-- 220
    { 163 },							-- 230
    { 121 },							-- 240
    { 162 },							-- 250 -- what?
    { 103 },							-- 260
    { 161 },							-- 270
    { 182 },							-- 280 -- what?
    { 123 },							-- 290
    { 105 },							-- 2A0
    { 141 },							-- 2B0
    { 140 },							-- 2C0
    { 142 },							-- 2D0
    {},									-- 2E0
    {}},								-- 2F0
  "mixed", { "medium-grass", "dark-grass", "land",
    { 136 },							-- 300
    { 134 },							-- 310
    { 156 },							-- 320
    { 99 },							-- 330
    { 167 },							-- 340
    { 98 },							-- 350
    { 155 },							-- 360
    { 97 },							-- 370
    { 135 },							-- 380
    { 169 },							-- 390
    { 157 },							-- 3A0
    { 176 },							-- 3B0
    { 175 },							-- 3C0
    { 177 },							-- 3D0
    {},									-- 3E0
    {}},								-- 3F0
  "mixed", { "water", "bridge-horizontal", "land", "no-building",
    { 256 },							-- 400
    { 261 },							-- 410
    { 258 },							-- 420
    { 293 },							-- 430
    { 276 },	-- 440
    { 275 },							-- 450
    { 257 },								-- 460
    { 298 },							-- 470
    { 280 },							-- 480
    { 279 },							-- 490
    { 260 },								-- 4A0
    { 295 },							-- 4B0
    { 294 },								-- 4C0
    { 297 },								-- 4D0
    {},									-- 4E0
    {}},								-- 4F0
  "mixed", { "water", "bridge-vertical", "land", "no-building",
    { 252 },							-- 500
    { 255 },							-- 510
    { 263 },							-- 520
    { 208 },							-- 530
    { 272 },							-- 540
    { 304 },							-- 550
    { 262 },							-- 560
    { 306 },							-- 570
    { 305 },							-- 580
    { 274 },							-- 590
    { 264 },							-- 5A0
    { 301 },							-- 5B0
    { 299 },							-- 5C0
    { 302 },							-- 5D0
    {},									-- 5E0
    {}},								-- 5F0
  "mixed", {"rocks", "light-coast", "land", "rock", "unpassable",
    --- required due to bug in the engine
    { 0 },							-- 600
    { 0 },							-- 610
    { 0 },							-- 620
    { 0 },							-- 630
    { 0 },							-- 640
    { 0 },							-- 650
    { 0 },							-- 660
    { 0 },							-- 670
    { 0 },							-- 680
    { 0 },							-- 690
    { 0 },							-- 6A0
    { 0 },							-- 6B0
    { 0 },							-- 6C0
    { 0 },							-- 6D0
    {},									-- 6E0
    {}},								-- 6F0
  "mixed", { "forest", "medium-grass", "land", "forest", "unpassable",
             -- forest starts at 0x47 and goes through to 0x5f
    { 0x4f },							-- 700
    { 0x47 },							-- 710
    { 0x5d },							-- 720
    { 0x4c },							-- 730
    { 0x4e, 0x55, 0x57 },							-- 740
    { 0x53 },							-- 750
    { 0x50 },							-- 760
    { 0x49 },							-- 770
    { 0x52 },							-- 780
    { 0x48, 0x54, 0x56 },							-- 790
    { 0x59 },							-- 7A0
    { 0x4b },							-- 7B0
    { 0x4d },							-- 7C0
    { 0x4a, 0x58 },							-- 7D0
    {},									-- 7E0
    {}},								-- 7F0
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
    {}},								-- 8F0
  "mixed", { "orc-wall", "dark-grass", "land", "wall", "unpassable",
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
    {}},								-- 9F0
  })

BuildTilesetTables()
AddColorCyclingRange(114, 118) -- water coast boundry
AddColorCyclingRange(121, 126) -- water

war1gus.tileset = "forest"
Load("scripts/scripts.lua")

