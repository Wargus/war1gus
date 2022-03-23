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
DefineAnimations(
   "animations-todo", 
   {Still = {"frame 0", "wait 4"},
    Move = {"frame 0", "move 16", "wait 4"},
    Attack = {"frame 0", "attack", "wait 4"},
    Death = {"frame 0", "wait 4"}}
)

local function DefaultStillAnimation()
   return {
      "frame 0", "wait 30",
      "if-var b.organic != 1 no_blood",
      "if-var v.HitPoints.Percent > 50 no_blood",
      "if-var v.HitPoints.Percent > 25 less_blood",
	  
         "random-goto 25 no_blood",
         "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-pool 0 0 0 0 setdirection 0",
		 "goto no_blood",
		 
      "label less_blood",
         "random-goto 75 no_blood",
         "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
      
	  "label no_blood"
   }
end

local function BuildMoveAnimation(frames)
   local maxspeed = 10
   local halfIndex
   
   if (#frames % 2 == 0) then
      halfIndex = (#frames) / 2
   else
      halfIndex = (#frames + 1) / 2
   end
   local res = {
	  "if-var b.organic != 1 no_blood",
      "if-var v.HitPoints.Percent > 50 no_blood",
      "if-var v.HitPoints.Percent > 25 less_blood",
	  
         "random-goto 25 no_blood",
         "spawn-missile missile-bleeding-walk 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
		 "goto no_blood",
		 
      "label less_blood",
         "random-goto 75 no_blood",
         "spawn-missile missile-bleeding-walk 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
      
	  "label no_blood",
      "unbreakable begin"
   }

   for unitspeed=0,maxspeed do
      local op
      if unitspeed == maxspeed then
         op = ">="
      else
         op = "=="
      end
      res[1 + #res] = "if-var v.Speed.Value " .. op .. " " .. unitspeed .. " speed_" .. unitspeed
   end

   for unitspeed=0,maxspeed do
      local waittime
      local waittime_fraction
      local tilesizeinpixel = 16
      local fractional_counter = 0
      waittime, waittime_fraction = math.modf(1 + ((maxspeed - unitspeed) / 2))

      res[1 + #res] = "label speed_" .. unitspeed
      while (tilesizeinpixel > 2) do
         for i = 1, halfIndex do
            res[1 + #res] = "frame " .. frames[i]
            res[1 + #res] = "move 2"
            res[1 + #res] = "wait " .. waittime
            fractional_counter = fractional_counter + waittime_fraction
            if fractional_counter > 1 then
               fractional_counter = fractional_counter - 1
               res[1 + #res] = "wait 1"
            end
            tilesizeinpixel = tilesizeinpixel - 2;
         end
         for i = 1, halfIndex - 1  do
            res[1 + #res] = "frame " .. frames[halfIndex - i]
            res[1 + #res] = "move 2"
            res[1 + #res] = "wait " .. waittime
            fractional_counter = fractional_counter + waittime_fraction
            if fractional_counter > 1 then
               fractional_counter = fractional_counter - 1
               res[1 + #res] = "wait 1"
            end
            tilesizeinpixel = tilesizeinpixel - 2;
         end
         res[1 + #res] = "frame 0"
         res[1 + #res] = "move 2"
         res[1 + #res] = "wait " .. waittime
         fractional_counter = fractional_counter + waittime_fraction
         if fractional_counter > 1 then
            fractional_counter = fractional_counter - 1
            res[1 + #res] = "wait 1"
         end
         tilesizeinpixel = tilesizeinpixel - 2;
   
         for i = 1, halfIndex do
            res[1 + #res] = "frame " .. frames[1 + #frames - i]
            res[1 + #res] = "move 2"
            res[1 + #res] = "wait " .. waittime
            fractional_counter = fractional_counter + waittime_fraction
            if fractional_counter > 1 then
               fractional_counter = fractional_counter - 1
               res[1 + #res] = "wait 1"
            end
            tilesizeinpixel = tilesizeinpixel - 2;
         end
         for i = (2 + #frames - halfIndex), #frames do
            res[1 + #res] = "frame " .. frames[i]
            res[1 + #res] = "move 2"
            res[1 + #res] = "wait " .. waittime
            fractional_counter = fractional_counter + waittime_fraction
            if fractional_counter > 1 then
               fractional_counter = fractional_counter - 1
               res[1 + #res] = "wait 1"
            end
            tilesizeinpixel = tilesizeinpixel - 2;
         end
         res[1 + #res] = "frame 0"
         res[1 + #res] = "move 2"
         res[1 + #res] = "wait " .. waittime
         fractional_counter = fractional_counter + waittime_fraction
         if fractional_counter > 1 then
            fractional_counter = fractional_counter - 1
            res[1 + #res] = "wait 1"
         end
         tilesizeinpixel = tilesizeinpixel - 2;
      end
      res[1 + #res] = "goto end"
   
      if (tilesizeinpixel ~= 0) then
         error("Problem in move animation with #" .. #frames .. " frames")
      end
   end

   res[1 + #res] = "label end"
   res[1 + #res] = "unbreakable end"
   res[1 + #res] = "frame 0"
   res[1 + #res] = "wait 1"

   return res
end

local function BuildAttackAnimation(frames, waittime, coolofftime, sound)
   -- Attack / Harvest with some modification
   local halfIndex;
   if (#frames % 2 == 0) then
      halfIndex = (#frames ) / 2
   else
      halfIndex = (#frames + 1) / 2
   end
   local res = {   
   	  "if-var b.organic != 1 no_blood",
      "if-var v.HitPoints.Percent > 50 no_blood",
      "if-var v.HitPoints.Percent > 25 less_blood",
	  
         "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
		 "goto no_blood",
		 
      "label less_blood",
         "random-goto 50 no_blood",
         "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
      
	  "label no_blood",
      "unbreakable begin"}
   for i = 1, #frames do
      res[1 + #res] = "frame " .. frames[i]
      if (i == halfIndex) then
	 res[1 + #res] = "attack"
	 res[1 + #res] = "sound " .. sound
      end
      res[1 + #res] = "wait " .. waittime
   end
   -- make sure we don't attack faster just because we have fewer frames
   res[1 + #res] = "wait " .. (5 - #frames) * waittime
   res[1 + #res] = "frame 0"
   res[1 + #res] = "wait " .. coolofftime
   res[1 + #res] = "unbreakable end"
   res[1 + #res] = "frame 0"
   res[1 + #res] = "wait 1"
   return res
end

local function BuildAttackHarvest(frames, waittime, sound)
   -- Attack / Harvest with some modification
   local res = {
      "if-var b.organic != 1 no_blood",
      "if-var v.HitPoints.Percent > 50 no_blood",
      "if-var v.HitPoints.Percent > 25 less_blood",
	  
         "random-goto 50 no_blood",
         "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
	"goto no_blood",
		 
      "label less_blood",
         "random-goto 75 no_blood",
         "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-footprint 0 0 0 0 setdirection 0",
      
	  "label no_blood",
          "unbreakable begin",
	  "sound tree chopping", "wait 5"}
   for i = 1, #frames do
      res[1 + #res] = "frame " .. frames[i]
      if (i == (1 + #frames) / 2) then
	 res[1 + #res] = "sound " .. sound
      end
      res[1 + #res] = "wait " .. waittime
   end
   res[1 + #res] = "unbreakable end"
   res[1 + #res] = "frame 5"
   res[1 + #res] = "wait 1"
   return res
end

local function BuildDeathAnimation(frames)
      local res = {
   "if-var b.organic != 1 no_blood", 
		 "spawn-missile missile-bleeding 0 0 0 0 setdirection 0",
         "spawn-missile missile-blood-pool 0 0 0 0 setdirection 0",
      "label no_blood",
      "unbreakable begin" }
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

local function BuildAnimations(frames, ...)
   options = select(1, ...) or {}
   attackspeed = options.attackspeed or 7
   coolofftime = options.coolofftime or 20
   attacksound = options.attacksound or "sword attack"
   local returnvalue = {
      Still = options.Still or DefaultStillAnimation(),
      Move = options.Move or BuildMoveAnimation(frames[1]),
      Attack = options.Attack or BuildAttackAnimation(frames[2], attackspeed, coolofftime, attacksound),
      Death = options.Death or BuildDeathAnimation(frames[3]),
      Harvest_wood = options.Harvest_wood,
      Harvest_treasure = options.Harvest_wood,
   }
   if options.RepairAsAttack then
     returnvalue.Repair = returnvalue.Attack
   end
   return returnvalue
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
local frameNumbers_5_3_5_3 = GetFrameNumbers(5, {3, 5, 3})
local frameNumbers_5_2_5_3 = GetFrameNumbers(5, {2, 5, 3})
local frameNumbers_5_4_3_3 = GetFrameNumbers(5, {4, 3, 3})


DefineAnimations("animations-brigand", BuildAnimations(frameNumbers_5_5_3_2))

DefineAnimations("animations-spider",
		 BuildAnimations(frameNumbers_5_5_4_5,
				 {attacksound = "fist attack"}))

DefineAnimations("animations-water-elemental",
		 BuildAnimations(frameNumbers_5_3_5_3,
				 {attacksound = "fireball attack",
				  coolofftime = 70,
				  Still = {
				      "frame 1", "wait 8",
					  "frame 5", "wait 8",
					  "frame 15", "wait 8",
					  "frame 30", "wait 8"}}))

DefineAnimations("animations-fire-elemental",
		 BuildAnimations(GetFrameNumbers(5, {5, 5, 0}),
				 {attacksound = "fireball attack",
				  coolofftime = 60,
				  Still = {
					  "frame 5", "wait 8",
					  "frame 15", "wait 8",
					  "frame 25", "wait 8",
					  "frame 35", "wait 8",
					  "frame 50", "wait 1"}}))

DefineAnimations(
   "animations-slime",
   BuildAnimations(
      frameNumbers_5_5_5_3,
      {Still = {
	  "frame 0", "wait 8",
	  "frame 65", "wait 8",
	  "frame 70", "wait 8",
	  "frame 75", "wait 8",
	  "frame 80", "wait 8",
	  "frame 85", "wait 8",
	  "frame 90", "wait 1",
      },
      attacksound = "fist attack",
      attackspeed = 15,
	   coolofftime = 5})
)

local grizelda_garona_anim = {
   Still = DefaultStillAnimation(),
   Move = BuildMoveAnimation({10, 20, 30, 35}),
   Death = BuildDeathAnimation({5, 15, 25})
}
DefineAnimations("animations-grizelda", grizelda_garona_anim)
DefineAnimations("animations-garona", grizelda_garona_anim)

DefineAnimations("animations-footman", BuildAnimations(frameNumbers_5_5_5_3))
DefineAnimations("animations-grunt", BuildAnimations(frameNumbers_5_5_5_3))

local worker_anim = BuildAnimations(
   frameNumbers_5_5_4_3,
   {attacksound = "tree chopping",
    Harvest_wood = BuildAttackHarvest(frameNumbers_5_5_4_3[2], 5, "tree chopping"),
    RepairAsAttack = true}
)
DefineAnimations("animations-peasant", worker_anim)
DefineAnimations("animations-peon", worker_anim)

local catapult_anim = BuildAnimations(
   frameNumbers_5_2_5_3,
   { attackspeed = 25,
     coolofftime = 49,
     attacksound = "catapult attack" }
)
DefineAnimations("animations-human-catapult", catapult_anim)
DefineAnimations("animations-orc-catapult", catapult_anim)

local anim_rider = BuildAnimations(frameNumbers_5_5_5_5, {})
DefineAnimations("animations-knight", anim_rider)
DefineAnimations("animations-raider", anim_rider)

DefineAnimations("animations-daemon", BuildAnimations(frameNumbers_5_5_5_5, {coolofftime = 50}))
DefineAnimations("animations-ogre",
		 BuildAnimations(frameNumbers_5_5_5_5,
				 {attackspeed = 10,
				 coolofftime = 50,
				 attacksound = "fist attack"}))
DefineAnimations("animations-skeleton", BuildAnimations(frameNumbers_5_5_5_5))
DefineAnimations("animations-scorpion",
		 BuildAnimations(frameNumbers_5_5_5_5,
				 {attacksound = "fist attack"}))
DefineAnimations("animations-the-dead", BuildAnimations(frameNumbers_5_5_5_5))

DefineAnimations("animations-archer",
		 BuildAnimations(frameNumbers_5_5_2_3,
				 {attackspeed = 13,
				  attacksound = "arrow attack"}))
DefineAnimations("animations-spearman",
		 BuildAnimations(frameNumbers_5_5_2_3,
				 {attackspeed = 11,
				  attacksound = "arrow attack"}))

DefineAnimations("animations-cleric",
		 BuildAnimations(frameNumbers_5_5_4_3,
				 {attacksound = "fireball attack"}))

DefineAnimations("animations-necrolyte",
		 BuildAnimations(frameNumbers_5_5_5_4,
				 {attacksound = "fireball attack"}))

DefineAnimations("animations-conjurer",
		 BuildAnimations(frameNumbers_5_5_4_4,
				 {attacksound = "fireball attack",
				  SpellCast = {
				  "frame 5", "wait 8",
				  "frame 20", "wait 8",
				  "frame 35", "wait 8",
				  "frame 50", "wait 8"
				  }}))
DefineAnimations("animations-warlock",
		 BuildAnimations(frameNumbers_5_5_5_3,
				 {attacksound = "fireball attack",
				  SpellCast = {
				  "frame 5", "wait 8",
				  "frame 20", "wait 8",
				  "frame 35", "wait 8",
				  "frame 50", "wait 8",
				  "frame 60", "wait 8"
				  }}))

DefineAnimations("animations-medivh",
		 BuildAnimations(frameNumbers_5_5_5_3,
				 {attacksound = "lightning"}))
DefineAnimations("animations-lothar", BuildAnimations(frameNumbers_5_5_5_3))

DefineAnimations(
   "animations-building",
   {Still = {"frame 0", "wait 5"},
    Death = {"frame 0", "wait 1"}})

DefineAnimations(
   "animations-ruins",
   {Death = {"unbreakable begin", "frame 0", "wait 600", "unbreakable end", "wait 1"}})

DefineAnimations(
   "animations-orc-dead-body",
   {Death = {"unbreakable begin",
	     "frame 5", "wait 300",
	     "frame 10", "wait 300",
	     "frame 15", "wait 300",
	     "frame 20", "wait 300",
	     "unbreakable end",
	     "wait 1"}})

DefineAnimations(
   "animations-human-dead-body",
   {Death = {"unbreakable begin",
	     "frame 0", "wait 300",
	     "frame 10", "wait 300",
	     "frame 15", "wait 300",
	     "frame 20", "wait 300",
	     "unbreakable end",
	     "wait 1"}})

DefineAnimations("animations-wounded", {Still = {"frame 0", "wait 5"}})

DefineAnimations(
   "animations-destroyed-place",
   {Still = {"frame 0", "wait 4",
	     "frame 0", "wait 1"}})
