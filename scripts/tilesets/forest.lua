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
--[[
	"special", {		-- Can't be in pud
    "top-one-tree", -1, "mid-one-tree", -1, "bot-one-tree", -1,
    "removed-tree", 95,
    "growing-tree", { -1, -1 },
    "top-one-rock", -1, "mid-one-rock", -1, "bot-one-rock", -1,
    "removed-rock", -1 },
--]]
	"solid", {"unused", {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}}, -- fow
	"solid", {"same", "water", {114}}, -- water
	"solid", {"unused", {}},
	"solid", {"unused", {}},
	"solid", {"unused", {}},
	"solid", {"same", "land", {97, 98, 99, 100, 101, 102, 103, 104, 105}}, -- grass
	"solid", {"unused", {}},
	"solid", {"same", "land", "forest", "unpassable", {85, 86, 87, 88, 89, 90, 91, 92, 93, 94}}, -- wood
	"solid", {"unused", {}},
	"solid", {"same", "land" --[[, "wall"]] , "unpassable", 
		{10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21}}, -- wall
	"solid", {"unused", {}},
	"solid", {"unused", {}},
	"solid", {"unused", {}},
	"solid", {"unused", {}},
	"solid", {"unused", {}},
	"solid", {"unused", {}},

	"solid", {"same",  "land" --[[, "wall"]] , {22, 23, 24, 24, 25, 26, 27, 28, 29, 30, 31, 32}}, -- destroyed wall
	"solid", {"same", "land", {33, 34, 35, 36, 37, 38, 39}}, -- way
	"solid", {"same", {40}}, -- destroyed wall
	"solid", {"same", {41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55}},

	"solid", {"same", "land", {56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70}}, -- road
	"solid", {"same", "forest", {71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84}},
	"solid", {"same", "forest", "land", {95}}, -- cutted wood
	"solid", {"same", "land", {96}}, -- coast

	"solid", {"same", "land", {106, 107, 108}}, -- coast
	"solid", {"same", "land", {109, 110, 111, 112}}, -- grass
	"solid", {"same", "land", {113, 115}}, -- coast

	"solid", {"same", "land", {116, 117, 118, 119, 120, 121, 122, 123}}, -- grass
	"solid", {"same", "land", {124, 125, 126, 127, 128, 129}}, -- coast
	"solid", {"same", "water", {130, 131}}, -- water
--	"solid", {"unused", {132, 133}}, 
	"solid", {"same", {134, 135, 136, 137, 138, 139, 140, 141, 142}}, -- grass
	"solid", {"same", "water", {143, 144}}, -- water
--	"solid", {"unused", {145, 146}}, 
	"solid", {"same", "land", {147, 148, 149, 150, 151, 152, 153, 154}}, -- coast
	"solid", {"same", "land", {155, 156, 157, 158, 159, 160, 161, 162, 163}}, -- grass
	"solid", {"same", "water", {164}}, -- water
	"solid", {"same", "land", {165, 166}}, -- coast
	"solid", {"same", "land", {167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177}}, -- grass
	"solid", {"same", "land", {178, 179, 180, 181, 182, 183}}, -- grass
	"solid", {"same", "land", {184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195}}, -- road
	"solid", {"same", "land", {196, 197, 198}}, -- bigway
	"solid", {"same", "land", {199, 200, 201, 202}}, -- grass
	"solid", {"same", "land", {203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217}}, -- bigway
	"solid", {"same", "land", {218}}, -- road on bigway
	"solid", {"same", "land", {219, 220, 221, 222, 223, 224}}, -- grass
	"solid", {"same", "land", {225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240}}, -- road on bigway
	"solid", {"same", "land", {241, 242}}, -- grass
	"solid", {"same", "land", {243, 244, 245}}, -- road on bigway
	"solid", {"same", "land", {246, 247, 248, 249, 250, 251}}, -- grass
	"solid", {"same", "land", {252, 253, 254, 255, 256}}, --bigway
	"solid", {"same", "land", {257, 258, 259, 260}}, --hbridge top
	"solid", {"same", "land", {261, 265, 271, 275, 280, 289, 293, 298, 303, 304, 305, 306, 308, 309, 310}}, --bigway
	"solid", {"same", "land", {262, 263, 264}}, --vbridge top
	"solid", {"same", "land", {266, 267, 268, 269, 270}}, --hbridge
	"solid", {"same", "land", {272, 273, 274}}, --vbridge
	"solid", {"same", "land", {276, 277, 278, 279}}, --hbridge
	"solid", {"same", "land", {281, 282, 283}}, --vbridge
	"solid", {"same", "land", {284, 285, 286, 287, 288}}, --hbridge
	"solid", {"same", "land", {290, 291, 292}}, --vbridge
	"solid", {"same", "land", {294, 295, 296, 297}}, --hbridge bottom
	"solid", {"same", "land", {299, 300, 301, 302}}, --vbridge bottom
	"solid", {"same", "land", {307}} --hbridge
	}
  )

--BuildTilesetTables()


war1gus.tileset = "forest"
Load("scripts/scripts.lua")