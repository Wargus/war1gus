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
              { 52 }},							-- 010
   "solid", { "unused",
              { }},	                      
   "solid", { "earth", "land",
              { 175, 106,  0, 112, 134, 135, 157, 158, 179 }},	    
   "solid", { "treasure", "land", "cost4", "unpassable", "non-mixing", -- cost4 == treasure in our case
              { 253, 90, 91 }},	    
   "solid", { "light-earth", "land",   --this is the sun on the floor, enteraing the dungeon 
              { 247 }},	             
   "solid", { "dim", "land",
              { 109,170}},							 
   "solid", { "bright", "land",
              { 172, 236, 0, 132, 133 }},
   "solid", { "brighter", "land",
              { 233, 231, 0, 155, 156 }},			   
   "solid", { "stone-floor", "land", "no-building",
              { 75, 76, 77, 300, 0, 200, 201, 202, 203, 262, 263, 286, 287, 279, 280, 281, 283}},				
   -- after 0 are decorations, pentagram 262, 263, 286, 287 is here, but its a bad filler
   "solid", { "rug", "land", "no-building",
              { 144, 0, 210 }},			    -- 0A0
   "solid", { "unused",
              {}},					        -- 0B0
   "solid", { "unused",
              {}},					        -- 0C0
   "solid", { "unused",
              {}},							-- 0D0				
   "solid", { "unused",
              {}},							-- 0E0
   "solid", { "unused",
              { }},				  			-- 0F0
			  
	--you cannot use the same tile twice
   "mixed", { "darkness", "earth", "water",
              { 95 },							-- 100 upper left dark
              { 98 },							-- 110 upper right dark
              { 54, 55 },                		-- 120 upper half dark
              { 138 },							-- 130 lower left dark
              { 159 },                   		-- 140 left half dark
					{ 204 },							-- 150 upper left, lower right dark
              { 290 },							-- 160 lower right wall
              { 181 },							-- 170 lower right dark
					{ 207 },							-- 180 upper left, lower right wall
              { 160 },							-- 190 right half dark
              { 295 },							-- 1A0 lower left wall
              { 205, 206 },						-- 1B0 upper half wall
              { 180 },							-- 1C0 upper right wall
              { 182 },							-- 1D0 upper left wall
              {},								-- 1E0
              {}},	
   "mixed", { "darkness", "stone-floor", "water",
              { 313},							-- 100 upper left dark
              { 316 },							-- 110 upper right dark
              { 242, 243 },                		-- 120 upper half dark
              { 328 },							-- 130 lower left dark
              { 321 },                    		-- 140 left half dark
					{ 327},							-- 150 upper left, lower right dark
              { 240 },							-- 160 lower right wall
              { 329 },							-- 170 lower right dark
					{ 330},							-- 180 upper left, lower right wall
              { 322 },							-- 190 right half dark
              { 245},							-- 1A0 lower left wall
              { 336 },							-- 1B0 upper half wall
              { 335 },							-- 1C0 upper right wall
              { 337 },							-- 1D0 upper left wall
              {},								-- 1E0
              {}},				  				-- 1F0
   "mixed", { "earth", "light-earth", "land",
              { 140 },							-- 200 upper left earth
              { 141 },							-- 210 upper right earth
              { 224 },							-- 220 upper half earth
              { 162 },							-- 230 lower left earth
              { 246 },							-- 240 left half earth
					{ 161 },							-- 250 upper left, lower right earth              
			  { 223 },   						-- 260 lower right light
			  { 163 },							-- 270 lower right earth
					{ 164 },							-- 280 upper left, lower right light
              { 248 },							-- 290 right half earth
              { 225 },							-- 2A0 lower left light
              { 184 },							-- 2B0 upper half light
              { 183 },							-- 2C0 upper right light
              { 186 },							-- 2D0 upper left light
              {},								-- 2E0
              {}},								-- 2F0
   "mixed", { "earth", "dim", "land",
              { 128 },							-- 200 upper left earth
              { 126 },							-- 210 upper right earth
              { 86, 127 },						-- 220 upper half earth
              { 84 },							-- 230 lower left earth
              { 108, 107},						-- 240 left half earth
					{ 305},							-- 250 upper left, lower right earth
              { 85 },   						-- 260 lower right light
              { 82 },							-- 270 lower right earth
					{ 306 },							-- 280 upper left, lower right light
              { 110, 105 },						-- 290 right half earth
              { 87 },							-- 2A0 lower left light
              { 130, 83 },						-- 2B0 upper half light
              { 129 } ,							-- 2C0 upper right light
              { 131 },							-- 2D0 upper left light
              {},								-- 2E0
              {}},								-- 2F0
   "mixed", { "earth", "bright", "land",
              { 198 },							-- 200 upper left earth
              { 196 },							-- 210 upper right earth
              { 150, 197 },						-- 220 upper half earth
              { 193 },							-- 230 lower left earth
              { 171, 176 },						-- 240 left half earth
					{ 272},							-- 250 upper left, lower right earth
              { 149 },   						-- 260 lower right light
              { 195 },							-- 270 lower right earth
					{ 273 },							-- 280 upper left, lower right light
              { 173, 174 },						-- 290 right half earth
              { 151},							-- 2A0 lower left light
              { 153, 194 },						-- 2B0 upper half light
              { 154 },							-- 2C0 upper right light
              { 152 },							-- 2D0 upper left light
              {},								-- 2E0
              {}},								-- 2F0		
   "mixed", { "bright", "brighter", "land",
              { 259 },							-- 200 upper left earth
              { 257 },							-- 210 upper right earth
              { 214, 258 },						-- 220 upper half earth
              { 254 },							-- 230 lower left earth
              { 232, 237 },						-- 240 left half earth
					{ 296},							-- 250 upper left, lower right earth
              { 213 },   						-- 260 lower right light
              { 256 },							-- 270 lower right earth
					{ 297 },							-- 280 upper left, lower right light
              { 234, 235 },						-- 290 right half earth
              { 215},							-- 2A0 lower left light
              { 217, 255 },						-- 2B0 upper half light
              { 218 },							-- 2C0 upper right light
              { 216 },							-- 2D0 upper left light
              {},								-- 2E0
              {}},								-- 2F0				  
   "mixed", { "earth", "stone-floor", "land", "no-building",
              { 125 },							-- 300
              { 123 },							-- 310
              { 124, 147 },						-- 320
              { 80 },							-- 330
              { 103,168 },						-- 340
					{ 81 },							-- 350
              { 146 },							-- 360
              { 78 },							-- 370
					{ 104 },							-- 380
              { 102, 169 },						-- 390
              { 148 },							-- 3A0
              { 79, 191 },						-- 3B0
              { 190 },							-- 3C0
              { 192 },							-- 3D0
              {  },								-- 3E0
              {  }},							-- 3F0
   "mixed", { "stone-floor", "rug", "land", "no-building",
              { 228 },							-- 400 upper left stone
              { 226 },							-- 410 upper right stone
              { 121, 249, 250 },				-- 420 upper half stone
              { 189 },							-- 430 lower left stone
              { 209, 229, 251 },	            -- 440 left half stone 
					{ 201 },							-- 450 upper left, lower right stone
              { 120 },							-- 460 lower right rug
              { 187 },							-- 470 lower right stone
					{ 202 },							-- 480 upper left, lower right stone
              { 208, 230, 252 },				-- 490 right half stone
              { 122 },							-- 4A0 lower left rug
              { 166 ,298, 299 },				-- 4B0 upper half rug
              { 165 },							-- 4C0 upper right rug
              { 167 },							-- 4D0 upper left rug
              {},								-- 4E0
              {}},								-- 4F0
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
             {},							-- 6E0
             {}},							-- 6F0
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
              {},								-- 7E0
              {}},								-- 7F0
   "mixed", { "human-wall", "dark-earth", "land", "human", "wall", "unpassable",   
   -- this 2x walls are required by engine to be. They are used in war1gus to initiate all dungeon tiles in Manual mode, so they can be used
              {  10,   11,  12,  13,  14},						-- 800
              {  15,   16,  17,  18,  19},						-- 810
              {  20,   21,  22,  23,  24},						-- 820
              {  25,   26,  27,  28,  29},						-- 830
              {  30,   31,  32,  33,  34, 35 , 36 , 37 },		-- 840
              {  38,   39,  40,  41,  42},						-- 850
              {  43,   44,  45,  47,  48},						-- 860
              {  49,   50,  51,  57,  58},						-- 870
              {  59,   60,  61,  62,  63},						-- 880
              {  64,   65,  66,  88,  89,  90 , 91 , 92 },		-- 890
              {  93,  111, 177, 178, 199},						-- 8A0
              {  211, 212, 219, 220, 221},						-- 8B0
              {  222, 238, 239, 260, 261},						-- 8C0
              {  284, 285, 288, 289, 323},						-- 8D0
              {},												-- 8E0
              {}},												-- 8F0
   "mixed", { "orc-wall", "dark-earth", "land", "wall", "unpassable",
              {  324, 325, 326, 331, 332 },						-- 900
              {  333, 334,  52,  53,  54 },						-- 910
              {  55,  56,   67,  68,  69 },						-- 920
              {  70,  71,   72,  73,  74 },						-- 930
              {  95,  96,   97,  98,  99, 100, 101, 113 },		-- 940
              {  114, 115, 116, 117, 118 },						-- 950
              {  119, 136, 137, 138, 139 },						-- 960
              {  142, 159, 160, 240, 241 },						-- 970
              {  242, 243, 244, 245, 266 },						-- 980
              {  267, 268, 269, 270, 271, 290, 291, 292 },		-- 990
              {  293, 294, 295, 301, 302 },						-- 9A0
              {  303, 304, 309, 310, 311 },						-- 9B0
              {  312, 313, 314, 315, 316 },						-- 9C0
              {  317, 318, 319, 320, 321 },						-- 9D0
              {  322, 327, 328, 329, 330, 335, 336, 337 },		-- 9E0
              {}},												-- 9F0
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
