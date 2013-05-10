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
--      (c) Copyright 2003-2010 by Jimmy Salmon
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

-- TODO remove this once replaced by correct animation
DefineAnimations("animations-todo", {
Still = {"frame 0", "wait 4"},
Move = {"frame 0", "move 32", "wait 4"},
Attack = {"frame 0", "attack", "wait 4"},
Death = {"frame 0", "wait 4"}
})

local function DefaultStillAnimation()
	return {"frame 0", "wait 4"}
end

local function BuildMoveAnimation(frames)
	local tilesizeinpixel = 32
	local halfIndex;
	if (#frames % 2 == 0) then
		halfIndex = (#frames) / 2
	else
		halfIndex = (#frames + 1) / 2
	end
	local res = {"unbreakable begin"}
	while (tilesizeinpixel > 4) do
		for i = 1, halfIndex do
			res[1 + #res] = "frame " .. frames[i]
			res[1 + #res] = "move 4"
			res[1 + #res] = "wait 2"
			tilesizeinpixel = tilesizeinpixel - 4;
		end
		for i = 1, halfIndex - 1  do
			res[1 + #res] = "frame " .. frames[halfIndex - i]
			res[1 + #res] = "move 4"
			res[1 + #res] = "wait 2"
			tilesizeinpixel = tilesizeinpixel - 4;
		end
		res[1 + #res] = "frame 0"
		res[1 + #res] = "move 4"
		res[1 + #res] = "wait 2"
		tilesizeinpixel = tilesizeinpixel - 4;
		
		for i = 1, halfIndex do
			res[1 + #res] = "frame " .. frames[1 + #frames - i]
			res[1 + #res] = "move 4"
			res[1 + #res] = "wait 2"
			tilesizeinpixel = tilesizeinpixel - 4;
		end
		for i = (2 + #frames - halfIndex), #frames do
			res[1 + #res] = "frame " .. frames[i]
			res[1 + #res] = "move 4"
			res[1 + #res] = "wait 2"
			tilesizeinpixel = tilesizeinpixel - 4;
		end
		res[1 + #res] = "frame 0"
		res[1 + #res] = "move 4"
		res[1 + #res] = "wait 2"
		tilesizeinpixel = tilesizeinpixel - 4;
	end	
	res[1 + #res] = "unbreakable end"
	res[1 + #res] = "frame 0"
	res[1 + #res] = "wait 1"	

	if (tilesizeinpixel ~= 0) then
		error("Problem in move animation")
	end
	return res
end

local function BuildAttackAnimation(frames)
	-- Attack / Harvest with some modification
	local halfIndex;
	if (#frames % 2 == 0) then
		halfIndex = (#frames ) / 2
	else
		halfIndex = (#frames + 1) / 2
	end
	local res = {"unbreakable begin"}
	for i = 1, #frames do
		res[1 + #res] = "frame " .. frames[i]
		if (i == halfIndex) then
			res[1 + #res] = "attack"
			-- Add sound here
		end
		res[1 + #res] = "wait 5"
	end
	res[1 + #res] = "unbreakable end"
	res[1 + #res] = "frame 0"
	res[1 + #res] = "wait 1"
	return res
end

local function BuildAttackHarvest(frames)
	-- Attack / Harvest with some modification
	local res = {"unbreakable begin"}
	for i = 1, #frames do
		res[1 + #res] = "frame " .. frames[i]
		if (i == (1 + #frames) / 2) then
			-- Add sound here
		end
		res[1 + #res] = "wait 5"
	end
	res[1 + #res] = "unbreakable end"
	res[1 + #res] = "frame 0"
	res[1 + #res] = "wait 1"
	return res
end

local function BuildDeathAnimation(frames)
	local res = {"unbreakable begin"}
	for i = 1, #frames do
		res[1 + #res] = "frame " .. frames[i]
		res[1 + #res] = "wait 3"
	end
	res[#res] = "wait 101" -- overwrite last value
	res[1 + #res] = "unbreakable end"
	res[1 + #res] = "wait 1"
	return res
end


local function GetFrameNumbers(nbdir, initCounter)
	initCounter[1] = initCounter[1] - 1
	local total = initCounter[1] + initCounter[2] + initCounter[3];
	local counter = {initCounter[1] + 1, initCounter[2], initCounter[3]}
	local itype = 1; -- 1:move, 2:attack, 3:death
	local res = {{}, {}, {}}

	local function nextType(itype, counter)
		itype = itype + 1
		if (itype == 4) then
			itype = 1;
		end
		if (counter[itype] > 0) then
			return itype;
		end
		return nextType(itype, counter)
	end

	for i = 1, total do
		counter[itype] = counter[itype] - 1
		itype = nextType(itype, counter)

		res[itype][1 + initCounter[itype] - counter[itype]] = i * nbdir;
	end
	return res;
end

local function BuildAnimations(frames)
	return {
		Still = DefaultStillAnimation(),
		Move = BuildMoveAnimation(frames[1]),
		Attack = BuildAttackAnimation(frames[2]),
		Death = BuildDeathAnimation(frames[3])
	}
end

--
--
--

local frameNumbers_5_5_5_5 = GetFrameNumbers(5, {5, 5, 5})
local frameNumbers_5_5_5_4 = GetFrameNumbers(5, {5, 5, 4})
local frameNumbers_5_5_5_3 = GetFrameNumbers(5, {5, 5, 3})
local frameNumbers_5_5_4_5 = GetFrameNumbers(5, {5, 4, 5})
local frameNumbers_5_5_4_4 = GetFrameNumbers(5, {5, 4, 4})
local frameNumbers_5_5_4_3 = GetFrameNumbers(5, {5, 4, 3})
local frameNumbers_5_5_3_2 = GetFrameNumbers(5, {5, 3, 2})
local frameNumbers_5_5_2_3 = GetFrameNumbers(5, {5, 2, 3})
local frameNumbers_5_2_5_3 = GetFrameNumbers(5, {2, 5, 3})


local animation_5move_5att_3death = BuildAnimations(frameNumbers_5_5_5_3)

--	brigand
DefineAnimations("animations-brigand", BuildAnimations(frameNumbers_5_5_3_2))
DefineAnimations("animations-spider", BuildAnimations(frameNumbers_5_5_4_5))


-- Footman, Grunt
DefineAnimations("animations-footman", animation_5move_5att_3death)

-- Peasant, Peon, Peasant, Peon, Peasant, Peon, Peasant, Peon
DefineAnimations("animations-peasant", {
  Still = DefaultStillAnimation(),
  Move = BuildMoveAnimation(frameNumbers_5_5_5_3[1]),
  Attack = BuildAttackAnimation(frameNumbers_5_5_5_3[2]),
  Harvest_wood = BuildAttackHarvest(frameNumbers_5_5_5_3[2]),
  Death = BuildDeathAnimation(frameNumbers_5_5_5_3[3])
})

--	Human Catapult, Orc Catapult
DefineAnimations("animations-catapult", BuildAnimations(frameNumbers_5_2_5_3))

--	Knight, Raider
DefineAnimations("animations-knight", BuildAnimations(frameNumbers_5_5_5_5))

--	Archer, Spearman
DefineAnimations("animations-archer", BuildAnimations(frameNumbers_5_5_2_3))

--	Cleric
DefineAnimations("animations-cleric", BuildAnimations(frameNumbers_5_5_4_3))

--	Necrolyte
DefineAnimations("animations-necrolyte", BuildAnimations(frameNumbers_5_5_5_4))

--	Conjurer, Warlock
DefineAnimations("animations-conjurer", BuildAnimations(frameNumbers_5_5_4_4))

-- Medivh, Lothar
DefineAnimations("animations-medivh", animation_5move_5att_3death)

--	Human Farm, Orc Farm, Human Barracks, Orc Barracks,
--	Human Church, Orc Temple, Human Stable, Orc Kennel,
--	Human Town Hall, Orc Town Hall, Elven Lumber Mill, Troll Lumber Mill,
--	Human Tower, Orc Tower, Human Blacksmith, Orc Blacksmith,
--	Gold Mine, Human Start Location, Orc Start Location,
--	Human Wall, Orc Wall
DefineAnimations("animations-building", {
  Still = {"frame 0", "wait 5"},
  Death = {"unbreakable begin",
	"frame 10", "wait 3",
	"frame 25", "wait 3",
	"frame 40", "wait 100",
	"frame 40", "wait 1",
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
  Death = {"unbreakable begin",
	   "frame 0", "wait 300",
	   "frame 10", "wait 300",
	   "frame 15", "wait 300",
	   "frame 20", "wait 300",
	   "unbreakable end",
	   "wait 1"},
})


DefineAnimations("animations-wounded", {
  Still = {"frame 0", "wait 5"},
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
	"frame 0", "wait 4",
	"frame 0", "wait 1",
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
