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
DefineTileset("name", "Swamp",
  "image", "tilesets/swamp/terrain.png",
  "size", {32 / 2, 32 / 2},
  -- Slots descriptions
  "slots",
	{ "special", {		-- Can't be in pud
    "top-one-tree", 0x5b, "mid-one-tree", 0x5c, "bot-one-tree", 0x5d,
    "removed-tree", 0x60 },
  "solid", { "unused",
    {}},								-- 000
  "solid", { "unused",
    {}},								-- 010
  "solid", { "water", "water",
    { 0xd5 }},						-- 020
  "solid", { "unused",
    {}},	-- 030
  "solid", { "light-swamp", "land",
    { 0xde }},	-- 040
  "solid", { "medium-swamp", "land",
    { 0x66, 0x78, 0x89, 0x87  }},	-- 050
  "solid", { "dark-swamp", "land",
    { 0x10a }},	-- 060
  "solid", { "forest", "land", "forest", "unpassable",
    { 0x5f }},							-- 070
  "solid", { "bridge-horizontal", "land", "no-building",
    { 0xae,0xaf,0xb0 }},						-- 080
  "solid", { "bridge-vertical", "land", "no-building",
    { 0x6e,0x73,0x7b }},					-- 090
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
  "mixed", { "water", "medium-swamp", "land", "no-building",
    { 0xf1 },							-- 100
    { 0xe0 },							-- 110
    { 0xf0, 0xfb },							-- 120
    { 0xbd },							-- 130
    { 0x106, 0x108 },							-- 140
    { 0xe2 },							-- 150
    { 0xfa },							-- 160
    { 0xc6 },							-- 170
    { 0xe2 },							-- 180
    { 0x107, 0xd3 },							-- 190
    { 0xfc },							-- 1A0
    { 0x111, 0xbc },							-- 1B0
    { 0x110 },							-- 1C0
    { 0x112 },							-- 1D0
    {},									-- 1E0
    {}},								-- 1F0
  "mixed", { "medium-swamp", "light-swamp", "land",
    { 0xdc },							-- 200
    { 0xc5 },							-- 210
    { 0xc4 },							-- 220
    { 0xeb },							-- 230
    { 0xcf },							-- 240
    { 0xd9 },							-- 250 -- what?
    { 0x6b },							-- 260
    { 0xee },							-- 270
    { 0xcc },							-- 280 -- what?
    { 0xdf },							-- 290
    { 0x70 },							-- 2A0
    { 0xdd },							-- 2B0
    { 0xc3 },							-- 2C0
    { 0xd2 },							-- 2D0
    {},									-- 2E0
    {}},								-- 2F0
  "mixed", { "medium-swamp", "dark-swamp", "land",
    { 0xf2 },							-- 300
    { 0x102 },							-- 310
    { 0xf3 },							-- 320
    { 0x113 },							-- 330
    { 0x109 },							-- 340
    { 0x10e },							-- 350
    { 0x71 },							-- 360
    { 0x114 },							-- 370
    { 0x105 },							-- 380
    { 0x10b },							-- 390
    { 0xf5 },							-- 3A0
    { 0x101 },							-- 3B0
    { 0x6c },							-- 3C0
    { 0x116 },							-- 3D0
    {},									-- 3E0
    {}},								-- 3F0
  "mixed", { "water", "bridge-horizontal", "land", "no-building",
    { 0x9f },							-- 400
    { 0xa3 },							-- 410
    { 0xa0 },							-- 420
    { 0xb5 },							-- 430
    { 0xad },	-- 440
    { 0xe5 },							-- 450
    { 0xa1 },								-- 460
    { 0xb9 },							-- 470
    { 0xe6 },							-- 480
    { 0xb1 },							-- 490
    { 0xa2 },								-- 4A0
    { 0xb8 },							-- 4B0
    { 0xb6 },								-- 4C0
    { 0xb7 },								-- 4D0
    {},									-- 4E0
    {}},								-- 4F0
  "mixed", { "water", "bridge-vertical", "land", "no-building",
    { 0x68 },							-- 500
    { 0x6a },							-- 510
    { 0x69 },							-- 520
    { 0x8a },							-- 530
    { 0x7a },							-- 540
    { 143 },							-- 550
    { 0x72 },							-- 560
    { 0x8c },							-- 570
    { 143 },							-- 580
    { 0x6f },							-- 590
    { 0x74 },							-- 5A0
    { 0x8b },							-- 5B0
    { 0x6d },							-- 5C0
    { 0x7c },							-- 5D0
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
  "mixed", { "forest", "medium-swamp", "land", "forest", "unpassable",
    { 0x50 },							-- 700
    { 0x48 },							-- 710
    { 0x5e },							-- 720
    { 0x4d },							-- 730
    { 0x4f, 0x56, 0x58 },							-- 740
    { 0x54 },							-- 750
    { 0x51 },							-- 760
    { 0x4a },							-- 770
    { 0x53 },							-- 780
    { 0x49, 0x55, 0x57 },							-- 790
    { 0x5a },							-- 7A0
    { 0x4c },							-- 7B0
    { 0x4e },							-- 7C0
    { 0x4b, 0x59 },							-- 7D0
    {},									-- 7E0
    {}},								-- 7F0
  "mixed", { "human-wall", "dark-swamp", "land", "human", "wall", "unpassable",
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
  "mixed", { "orc-wall", "dark-swamp", "land", "wall", "unpassable",
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

war1gus.tileset = "swamp"
Load("scripts/scripts.lua")

