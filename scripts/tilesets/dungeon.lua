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
DefineTileset("name", "dungeon",
  "image", "tilesets/dungeon/terrain.png",
  "size", {32, 32},
  -- Slots descriptions
  "slots",
	{ "special", {		-- Can't be in pud
    "top-one-tree", 0x5d, "mid-one-tree", 0x5a, "bot-one-tree", 0x5a,
    "removed-tree", 0x22 },
  "solid", { "unused",
    {}},								-- 000
  "solid", { "unused",
    {}},								-- 010
  "solid", { "darkness", "water",
    { 0x34 }},						-- 020
  "solid", { "unused",
    {}},	-- 030
  "solid", { "medium-earth", "land",
    { 0xac, 0x85 }},	-- 040
  "solid", { "dark-earth", "land",
    { 0xaf, 0x70, 0xb3, 0x86, 0x87, 0x9d }},	-- 050
  "solid", { "light-earth", "land",
    { 0xe9, 0x9b }},	-- 060
  "solid", { "forest", "land", "forest", "unpassable",
    { 0x5c }},							-- 070
  "solid", { "rug", "land",
    { 0x90 }},						-- 080
  "solid", { "stone-floor", "land", "no-building",
    { 0x4b }},					-- 090
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
  "mixed", { "darkness", "dark-earth", "land", "unpassable", "no-building",
    { 0x60 },							-- 100
    { 0x61 },							-- 110
    { 0x45 },							-- 120
    { 0x8a },							-- 130
    { 0x88, 0x9f },							-- 140
    { 0 },							-- 150
    { 0x44 },							-- 160
    { 0xb5 },							-- 170
    { 1 },							-- 180
    { 0x89, 0xa0 },							-- 190
    { 0x38 },							-- 1A0
    { 0xcd, 0xce },							-- 1B0
    { 0xb4 },							-- 1C0
    { 0xb6 },							-- 1D0
    {},									-- 1E0
    {}},								-- 1F0
  "mixed", { "dark-earth", "medium-earth", "land",
    { 0xc6 },							-- 200
    { 0xc4 },							-- 210
    { 0xc5 },							-- 220
    { 0x9a },							-- 230
    { 0xb0 },							-- 240
    { 2 },							-- 250 -- what?
    { 0x95 },							-- 260
    { 0xc3 },							-- 270
    { 3 },							-- 280 -- what?
    { 0xa3 },							-- 290
    { 0x97 },							-- 2A0
    { 0xc2 },							-- 2B0
    { 0x99 },							-- 2C0
    { 0xad },							-- 2D0
    {},									-- 2E0
    {}},								-- 2F0
  "mixed", { "medium-earth", "light-earth", "land",
    { 0xd5 },							-- 300
    { 0xd7 },							-- 310
    { 0xd6 },							-- 320
    { 0xfe },							-- 330
    { 0xed },							-- 340
    { 4 },							-- 350
    { 0x84 },							-- 360
    { 0xd9 },							-- 370
    { 5 },							-- 380
    { 0xda },							-- 390
    { 0x101 },							-- 3A0
    { 0xeb },							-- 3B0
    { 0x9c },							-- 3C0
    { 0x100 },							-- 3D0
    {},									-- 3E0
    {}},								-- 3F0
  "mixed", { "dark-earth", "stone-floor", "land", "no-building",
    { 0x7d },							-- 400
    { 0x7b },							-- 410
    { 0x7c },							-- 420
    { 0x50 },							-- 430
    { 0x66 },	-- 440
    { 0x51 },							-- 450
    { 0x92 },								-- 460
    { 0x4e },							-- 470
    { 0x9e },							-- 480
    { 0x67 },							-- 490
    { 0x95 },								-- 4A0
    { 0x94 },							-- 4B0
    { 0x4f },								-- 4C0
    { 0xc0 },								-- 4D0
    {},									-- 4E0
    {}},								-- 4F0
  "mixed", { "rug", "stone-floor", "land", "no-building",
    { 0xa7 },							-- 500
    { 0xa5 },							-- 510
    { 0xa6 },							-- 520
    { 0x7a },							-- 530
    { 0xd0 },							-- 540
    { 0xd2 },							-- 550
    { 0xbb },							-- 560
    { 0x78 },							-- 570
    { 0xfa },							-- 580
    { 0xd1 },							-- 590
    { 0xfd },							-- 5A0
    { 0x79 },							-- 5B0
    { 0xe2 },							-- 5C0
    { 0xe4 },							-- 5D0
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
  "mixed", { "forest", "stone-floor", "land", "forest", "unpassable",
    { 0xd3 },							-- 700
    { 0xee },							-- 710
    { 0xef },							-- 720
    { 0xd4 },							-- 730
    { 0x112 },							-- 740
    { 0x113 },							-- 750
    { 0x114 },							-- 760
    { 0x115 },							-- 770
    { 0x116 },							-- 780
    { 0x120 },							-- 790
    { 0x11c },							-- 7A0
    { 0x11d },							-- 7B0
    { 0xb2 },							-- 7C0
    { 0x121 },							-- 7D0
    {},									-- 7E0
    {}},								-- 7F0
  "mixed", { "human-wall", "dark-grass", "land", "human", "wall", "unpassable",
    {  21,   0,  23,   0,  0},						-- 800
	  {  10,   0,  22,   0,  36},						-- 810
	  {  17,   0,  29,   0,  33},						-- 820
	  {  11,   0,  40,   0,  0},						-- 830
	  {  21,  21,   0,  23,  23,   0,  0,  0},				-- 840
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
    {  21,   0,  23,   0,  0},						-- 900
	  {  10,   0,  22,   0,  36},						-- 910
	  {  17,   0,  29,   0,  33},						-- 920
	  {  11,   0,  40,   0,  0},						-- 930
	  {  21,  21,   0,  23,  23,   0,  0,  0},				-- 940
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

war1gus.tileset = "dungeon"
Load("scripts/scripts.lua")
