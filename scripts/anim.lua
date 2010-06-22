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
--      anim.lua - The unit animation definitions.
--
--      (c) Copyright 2003-2004 by Jimmy Salmon
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
--      $Id$

--=============================================================================
--	Define animations.
--
--	(define-animations ident 'still script 'move script 'die script
--		'attack script},
--
--	A script is a list of quad numbers.
--		({Flags Pixel Sleep Frame) (#Flags Pixel Sleep Frame) ...},
--	* Format of quad numbers:
--		{Flags Pixel Sleep Frame},
--	o Flags are the sum of the following:
--		1 Restart - restart animation
--		2 Reset   - animation could here be aborted (switch to another},
--		4 Sound   - play a sound with the animation
--		8 Missile - fire a missile at this point
--	o Pixel is the number of pixels to move (if this is a moving animation},
--	o Sleep is the number of frames to wait for the next animation
--	o Frame is increment to the frame of the image
--

--------
--	Footman, Grunt
DefineAnimations("animations-footman", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 5", "move 0", "wait 5", "frame 20", "move 0", "wait 5", "frame 35", "move 0", "wait 5", "frame 50", "move 0", "wait 5",
    "frame 5", "move 0", "wait 4", "frame 5", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

  -- XXX, move, wait, frame

--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #16, P32
    { 0, 2,   2,   0}, { 0, 2,   1,  30}, { 0, 4,   2,  30}, { 0, 2,   1,  15},
    { 0, 2,   1,  15}, { 0, 4,   1,   0}, { 0, 2,   2,   0}, { 0, 2,   1,  45},
    { 0, 4,   2,  45}, { 0, 2,   1,  55}, { 0, 2,   1,  55}, { 3, 4,   1,   0}},
  "attack", {	-- #25
    { 0, 0,   5,   5}, { 0, 0,   5,  20}, { 0, 0,   5,  35}, {12, 0,   5,  50},
    { 0, 0,   4,   5}, { 3, 0,   1,   5}},
  "die", {	-- #107
    { 0, 0,   3,  10}, { 0, 0,   3,  25}, { 0, 0, 100,  40}, { 3, 0,   1,  40}})
]]

--------
--	Peasant, Peon, Peasant, Peon, Peasant, Peon, Peasant, Peon
DefineAnimations("animations-peasant", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #16, P16
    { 0, 2,   2,   0}, { 0, 2,   1,  30}, { 0, 4,   2,  30}, { 0, 2,   1,  15},
    { 0, 2,   1,  15}, { 0, 4,   1,   0}, { 0, 2,   2,   0}, { 0, 2,   1,  45},
    { 0, 4,   2,  45}, { 0, 2,   1,  55}, { 0, 2,   1,  55}, { 3, 4,   1,   0}},
  "attack", {	-- #25
    { 0, 0,   3,  50}, { 0, 0,   3,  35}, { 0, 0,   3,  60}, {12, 0,   5,   5},
    { 0, 0,   3,  20}, { 0, 0,   7,  50}, { 3, 0,   1,  50}},
  "die", {	-- #107
    { 0, 0,   3,  10}, { 0, 0,   3,  25}, { 0, 0, 100,  40}, { 3, 0,   1,  40}})
]]

--------
--	Human Catapult, Orc Catapult
DefineAnimations("animations-catapult", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 0", "wait 1", "frame 15", "move 2", "wait 2", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 5", "move 0", "wait 5", "frame 20", "move 0", "wait 5", "frame 35", "move 0", "wait 5", "frame 50", "move 0", "wait 5",
    "frame 5", "move 0", "wait 4", "frame 5", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #32, P16
    { 0, 0,   1,   0}, { 0, 2,   2,  15}, { 0, 2,   2,   0}, { 0, 2,   2,  15},
    { 0, 2,   2,   0}, { 0, 2,   2,  15}, { 0, 2,   2,   0}, { 0, 2,   2,  15},
    { 0, 2,   2,   0}, { 0, 2,   2,  15}, { 0, 2,   2,   0}, { 0, 2,   2,  15},
    { 0, 2,   2,   0}, { 0, 2,   2,  15}, { 0, 2,   2,   0}, { 0, 2,   2,  15},
    { 3, 2,   1,   0}},
  "attack", {	-- #200
    { 0, 0,  19,   0}, { 0, 0,   2,  20}, { 0, 0,   2,  30}, { 0, 0,   2,  45},
    {12, 0,   2,  40}, { 0, 0,   2,  45}, { 0, 0,  21,  40}, { 0, 0, 100,  40},
    { 0, 0,   2,  45}, { 0, 0,   2,  30}, { 0, 0,   2,  20}, { 0, 0,  43,   0},
    { 3, 0,   1,   0}})
]]

--------
--	Knight
DefineAnimations("animations-knight", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #12, P16
    { 0, 6,   2,   0}, { 0, 6,   2,  15}, { 0, 4,   2,  30}, { 0, 6,   2,  45},
    { 0, 6,   2,  60}, { 0, 2,   1,   0}, { 3, 2,   1,   0}},
  "attack", {	-- #25
    { 0, 0,   3,   5}, { 0, 0,   3,  20}, { 0, 0,   3,  35}, {12, 0,   5,  50},
    { 0, 0,  10,  65}, { 3, 0,   1,   0}},
  "die", {	-- #507
    { 0, 0,   3,  10}, { 0, 0,   3,  25}, { 0, 0, 100,  40}, { 0, 0, 200,  55},
    { 0, 0, 200,  70}, { 3, 0,   1,  70}})
]]

--------
--	Archer, Spearman
DefineAnimations("animations-archer", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #16, P16
    { 0, 2,   1,   0}, { 0, 2,   1,  15}, { 0, 2,   1,  15}, { 0, 2,   1,  30},
    { 0, 2,   1,  30}, { 0, 2,   1,  15}, { 0, 2,   2,  15}, { 0, 2,   1,   0},
    { 0, 2,   1,   0}, { 0, 2,   1,  45}, { 0, 2,   1,  40}, { 0, 2,   1,  40},
    { 0, 2,   1,  45}, { 0, 4,   1,  45}, { 3, 2,   1,   0}},
  "attack", {	-- #65
    { 0, 0,  10,   0}, {12, 0,  10,  20}, { 0, 0,  44,   0}, { 3, 0,   1,   0}},
  "die", {	-- #107
    { 0, 0,   3,  10}, { 0, 0,   3,  25}, { 0, 0, 100,  35}, { 3, 0,   1,  35}})
]]

--------
--	Cleric
DefineAnimations("animations-cleric", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #12, P16
    { 0, 4,   1,   0}, { 0, 2,   1,   5}, { 0, 4,   2,   5}, { 0, 4,   1,  10},
    { 0, 2,   1,  10}, { 0, 4,   1,  15}, { 0, 4,   2,  15}, { 0, 2,   1,  20},
    { 0, 4,   1,  20}, { 3, 2,   1,   0}},
  "attack", {	-- #25
    { 0, 0,   3,  25}, { 0, 0,   3,  30}, { 0, 0,   3,  35}, {12, 0,   5,  40},
    { 0, 0,  10,   0}, { 3, 0,   1,   0}},
  "die", {	-- #507
    { 0, 0,   3,  45}, { 0, 0,   3,  50}, { 0, 0, 100,  55}, { 0, 0, 200,  60},
    { 0, 0, 200,  65}, { 3, 0,   1,  65}})
]]

--------
--	Necrolyte
DefineAnimations("animations-necrolyte", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #12, P16
    { 0, 4,   1,   0}, { 0, 2,   1,   5}, { 0, 4,   2,   5}, { 0, 4,   1,  10},
    { 0, 2,   1,  10}, { 0, 4,   1,  15}, { 0, 4,   2,  15}, { 0, 2,   1,  20},
    { 0, 4,   1,  20}, { 3, 2,   1,   0}},
  "attack", {	-- #25
    { 0, 0,   3,  25}, { 0, 0,   3,  30}, { 0, 0,   3,  35}, {12, 0,   5,  40},
    { 0, 0,  10,   0}, { 3, 0,   1,   0}},
  "die", {	-- #507
    { 0, 0,   3,  45}, { 0, 0,   3,  50}, { 0, 0, 100,  55}, { 0, 0, 200,  60},
    { 0, 0, 200,  65}, { 3, 0,   1,  65}})
]]

--------
--	Conjurer, Warlock
DefineAnimations("animations-conjurer", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #18, P16
    { 0, 2,   2,   0}, { 0, 2,   1,  30}, { 0, 4,   2,  30}, { 0, 2,   1,  15},
    { 0, 2,   1,  15}, { 0, 4,   1,   0}, { 0, 2,   2,   0}, { 0, 2,   1,  45},
    { 0, 4,   2,  45}, { 0, 2,   1,  60}, { 0, 2,   1,  60}, { 3, 4,   1,   0}},
  "attack", {	-- #40
    { 0, 0,   5,   5}, { 0, 0,   5,  20}, {12, 0,   7,  35}, { 0, 0,   5,  50},
    { 0, 0,  17,   5}, { 3, 0,   1,   5}},
  "die", {	-- #307
    { 0, 0,   3,  10}, { 0, 0,   3,  25}, { 0, 0, 100,  40}, { 0, 0, 200,  55},
    { 3, 0,   1,  55}})
]]

--------
--	Midevh
DefineAnimations("animations-midevh", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}},
  "move", {	-- #12, P16
    { 0, 4,   1,   0}, { 0, 2,   1,   5}, { 0, 4,   2,   5}, { 0, 4,   1,  10},
    { 0, 2,   1,  10}, { 0, 4,   1,  15}, { 0, 4,   2,  15}, { 0, 2,   1,  20},
    { 0, 4,   1,  20}, { 3, 2,   1,   0}},
  "attack", {	-- #25
    { 0, 0,   3,  25}, { 0, 0,   3,  30}, { 0, 0,   3,  35}, {12, 0,   5,  40},
    { 0, 0,  10,   0}, { 3, 0,   1,   0}},
  "die", {	-- #507
    { 0, 0,   3,  45}, { 0, 0,   3,  50}, { 0, 0, 100,  55}, { 0, 0, 200,  60},
    { 0, 0, 200,  65}, { 3, 0,   1,  65}})
]]

--------
--	Human Farm, Orc Farm, Human Barracks, Orc Barracks,
--	Human Church, Orc Temple, Human Stable, Orc Kennel,
--	Human Town Hall, Orc Town Hall, Elven Lumber Mill, Troll Lumber Mill,
--	Human Tower, Orc Tower, Human Blacksmith, Orc Blacksmith,
--	Gold Mine, Human Start Location, Orc Start Location,
--	Human Wall, Orc Wall
DefineAnimations("animations-building", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "still", {	-- #5
    { 0, 0,   4,   0}, { 3, 0,   1,   0}})
]]

--------
--	Dead Body
DefineAnimations("animations-dead-body", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "die", {	-- #201
    --	Corpse:		Orcish
    { 0, 0, 200,   5}, {16, 0, 200,  10}, { 0, 0, 200,  15}, { 0, 0, 200,  20},
    { 0, 0,   1,  20}, { 3, 0,   1,  20},
    --	Corpse:		Human
    { 0, 0, 200,   0}, {16, 0, 200,  10}, { 0, 0, 200,  15}, { 0, 0, 200,  20},
    { 0, 0,   1,  20}, { 3, 0,   1,  20}})
]]

--------
--	Destroyed 1x1, Place, Destroyed 2x2, Place,
--	Destroyed 3x3, Place, Destroyed 4x4, Place
DefineAnimations("animations-destroyed-place", {
  Still = {
    "frame 0", "wait 4", "frame 0", "wait 1",
  },
  Move = {"unbreakable begin",
    "frame 0", "move 2", "wait 2", "frame 30", "move 2", "wait 1", "frame 30", "move 4", "wait 2", "frame 15", "move 2", "wait 1",
    "frame 15", "move 2", "wait 1", "frame 0", "move 4", "wait 1", "frame 0", "move 2", "wait 2", "frame 45", "move 2", "wait 1",
    "frame 45", "move 4", "wait 2", "frame 55", "move 2", "wait 1", "frame 55", "move 2", "wait 1", "frame 0", "move 4", "wait 1",
    "unbreakable end", "wait 1",
  },
  Attack = {"unbreakable begin",
    "frame 50", "move 0", "wait 3", "frame 35", "move 0", "wait 3", "frame 60", "move 0", "wait 3", "frame 5", "move 0", "wait 5",
    "frame 20", "move 0", "wait 3", "frame 50", "move 0", "wait 7", "frame 50", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
  Death = {"unbreakable begin",
    "frame 10", "move 0", "wait 3", "frame 25", "move 0", "wait 3", "frame 40", "move 0", "wait 100", "frame 40", "move 0", "wait 1",
    "unbreakable end", "wait 1",
  },
})

--!!!TODO!!!
--[[
  "die", {	-- #401
    --	Destroyed land site
    { 0, 0, 200,   0}, {16, 0, 200,   1}, { 3, 0,   1,   1},
    --	Destroyed water site
    { 0, 0, 200,   2}, {16, 0, 200,   3}, { 3, 0,   1,   3}})
]]
