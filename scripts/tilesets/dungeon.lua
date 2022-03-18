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
local slots = {
   "special", {		-- Can't be in pud
      "top-one-tree", 253, "mid-one-tree", 253, "bot-one-tree", 253,
      "removed-tree", 300 },
   "solid", { "unused",
              {}},								-- 000
   "solid", { "darkness", "water",
              { 245 }},							-- 010
   "solid", { "unused",
              { }},						      -- 020
   "solid", { "unused",
              { }},	                     -- 030
   "solid", { "earth", "land",
              { 172, 173, 174, 175, 0, 112, 132, 135 }},	   -- 040
   "solid", { "treasure", "land", "cost4", "unpassable", "non-mixing", -- cost4 == treasure in our case
              { 253, 90, 91 }},	   -- 050
   "solid", { "light-earth", "land",
              { 247 }},	            -- 060
   "solid", { "unused",
              { }},							-- 070
   "solid", { "unused",
              { }},						   -- 080
   "solid", { "stone-floor", "land", "no-building",
              { 75, 76, 77 }},				-- 090
   "solid", { "rug", "land", "no-building",
              { 144, 0, 210 }},					      -- 0A0
   "solid", { "unused",
              {}},					         -- 0B0
   "solid", { "unused",
              {}},					         -- 0C0
   "solid", { "unused",
              {}},								-- 0D0
   "solid", { "unused",
              {}},								-- 0E0
   "solid", { "unused",
              {}},								-- 0F0
   "mixed", { "darkness", "earth", "water",
              { 95 },							-- 100 upper left dark
              { 98 },							-- 110 upper right dark
              { 54, 55 },                 -- 120 upper half dark
              { 138 },							-- 130 lower left dark
              { 159 },                    -- 140 left half dark
              { 270 },							-- 150 upper left, lower right dark
              { 290 },							-- 160 lower right wall
              { 181 },							-- 170 lower right dark
              { 267 },							-- 180 upper left, lower right wall
              { 160 },							-- 190 right half dark
              { 295 },							-- 1A0 lower left wall
              { 205, 206 },					-- 1B0 upper half wall
              { 180 },							-- 1C0 upper right wall
              { 182 },							-- 1D0 upper left wall
              {},									-- 1E0
              {}},								-- 1F0
   "mixed", { "earth", "light-earth", "land",
              { 140 },						-- 200 upper left earth
              { 141 },						-- 210 upper right earth
              { 224 },					-- 220 upper half earth
              { 162 },							-- 230 lower left earth
              { 246 },							-- 240 left half earth
              { 133 },							-- 250 upper left, lower right earth
              { 223 },   						-- 260 lower right light
              { 163 },							-- 270 lower right earth
              { 134 },							-- 280 upper left, lower right light
              { 248 },							-- 290 right half earth
              { 225 },							-- 2A0 lower left light
              { 184 },							-- 2B0 upper half light
              { 183 },							-- 2C0 upper right light
              { 185 },							-- 2D0 upper left light
              {},									-- 2E0
              {}},								-- 2F0
   "mixed", { "earth", "stone-floor", "land", "no-building",
              { 125 },							-- 300
              { 123 },							-- 310
              { 124 },							-- 320
              { 80 },							-- 330
              { 103 },							-- 340
              { 157 },							-- 350
              { 146 },							-- 360
              { 78 },							-- 370
              { 158 },							-- 380
              { 102 },							-- 390
              { 148 },							-- 3A0
              { 79 },							-- 3B0
              { 81 },							-- 3C0
              { 192 },							-- 3D0
              {  },									-- 3E0
              {  }},								-- 3F0
   "mixed", { "stone-floor", "rug", "land", "no-building",
              { 228 },							-- 400 upper left stone
              { 226 },							-- 410 upper right stone
              { 250 },							-- 420 upper half stone
              { 189 },							-- 430 lower left stone
              { 229 },	                  -- 440 left half stone 
              { 201 },							-- 450 upper left, lower right stone
              { 120 },							-- 460 lower right rug
              { 187 },							-- 470 lower right stone
              { 202 },							-- 480 upper left, lower right stone
              { 230 },							-- 490 right half stone
              { 122 },							-- 4A0 lower left rug
              { 299 },							-- 4B0 upper half rug
              { 165 },							-- 4C0 upper right rug
              { 167 },							-- 4D0 upper left rug
              {},								-- 4E0
              {}},							-- 4F0
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
   "mixed", { "stone-floor", "treasure", "land", "non-mixing",
              { 300 },							-- 700 upper left stone
              { 300 },							-- 710 upper right stone
              { 300 },							-- 720 upper half stone
              { 300 },							-- 730 lower left stone
              { 300 }, 							-- 740 left half stone 
              { 300 },							-- 750 upper left, lower right stone
              { 300 },							-- 760 lower right treasure
              { 300 },							-- 770 lower right stone
              { 300 },							-- 780 upper left, lower right stone
              { 300 },							-- 790 right half stone
              { 300 },							-- 7A0 lower left treasure
              { 300 },							-- 7B0 upper half treasure
              { 300 },							-- 7C0 upper right treasure
              { 300 },							-- 7D0 upper left treasure
              {},									-- 7E0
              {}},								-- 7F0
   "mixed", { "human-wall", "dark-earth", "land", "human", "wall", "unpassable",
              {  26,   0,  23,   0,  0},						-- 800
              {  10,   0,  22,   0,  36},						-- 810
              {  17,   0,  29,   0,  36},						-- 820
              {  11,   0,  40,   0,  0},						-- 830
              {  26,  26,   0,  23,  23,   0,  0,  0},				-- 840
              {  10,   0,  22,   0,  36},						-- 850
              {  13,   0,  25,   0,  36},						-- 860
              {  12,   0,  24,   0,  38},						-- 870
              {  29,   0,  36,   0,  36},						-- 880
              {  18,  18,   0,  30,  30,   0,  37,  37},				-- 890
              {  19,   0,  31,   0,  37},						-- 8A0
              {  12,   0,  24,   0,  38},						-- 8B0
              {  15,   0,  27,   0,  36},						-- 8C0
              {  14,   0,  26,   0,  39},						-- 8D0
              {},									-- 8E0
              {}},								-- 8F0
   "mixed", { "orc-wall", "dark-earth", "land", "wall", "unpassable",
              {  26,   0,  23,   0,  0},						-- 900
              {  10,   0,  22,   0,  36},						-- 910
              {  17,   0,  29,   0,  36},						-- 920
              {  11,   0,  40,   0,  0},						-- 930
              {  26,  26,   0,  23,  23,   0,  0,  0},				-- 940
              {  10,   0,  22,   0,  36},						-- 950
              {  13,   0,  25,   0,  36},						-- 960
              {  12,   0,  24,   0,  38},						-- 970
              {  29,   0,  36,   0,  36},						-- 980
              {  18,  18,   0,  30,  30,   0,  37,  37},				-- 990
              {  19,   0,  31,   0,  37},						-- 9A0
              {  12,   0,  24,   0,  38},						-- 9B0
              {  15,   0,  27,   0,  36},						-- 9C0
              {  14,   0,  26,   0,  39},						-- 9D0
              {},									-- 9E0
              {}},								-- 9F0
}

-- dungeons are really special and pretty much everything is just decoration

DefineTileset("name", "dungeon",
  "image", "tilesets/dungeon/terrain.png",
  "size", {16, 16},
  -- Slots descriptions
  "slots", slots)

BuildTilesetTables()

war1gus.tileset = "dungeon"
SetFogOfWarGraphics("tilesets/dungeon/fog.png")
Load("scripts/scripts.lua")
