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
--      sound.lua - Define the used sounds.
--
--      (c) Copyright 1999-2004 by Fabrice Rossi, Lutz Sammer, and Jimmy Salmon
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

--	Uncomment this to enable threaded sound
--SoundThread()

------------------------------------------------------------------------------
--	Music part

------------------------------------------------------------------------------
--	MusicStopped is called if the current music is finished.
--
--		This is a random music player demo
--

playlist = {
  "music/default.mod"
}

function MusicStopped()
  if (table.getn(playlist) ~= 0) then
    PlayMusic(playlist[math.random(table.getn(playlist))])
  end
end

------------------------------------------------------------------------------
--	(set-cd-mode!) set how your CD is played.
--		all	plays all tracks
--		random	plays random tracks
--		defined	play according to playlist below
--		off	turns cd player off
--SetCdMode("all")
--SetCdMode("random") 
SetCdMode("defined")
--SetCdMode("off")

------------------------------------------------------------------------------
--	(define-play-sections) set the playlist for different 
--			       sections of the game
--
DefinePlaySections("type", "main-menu",
    "cd", {"order", "all", "tracks", {15}})
DefinePlaySections("race", "human", "type", "game",
    "cd", {"order", "random", "tracks", {3, 4, 5, 6}})
DefinePlaySections("race", "human", "type", "briefing",
    "cd", {"order", "all", "tracks", {7}})
DefinePlaySections("race", "human", "type", "stats-victory",
    "cd", {"order", "all", "tracks", {8}})
DefinePlaySections("race", "human", "type", "stats-defeat",
    "cd", {"order", "all", "tracks", {9}})
DefinePlaySections("race", "orc", "type", "game",
    "cd", {"order", "random", "tracks", {10, 11, 12, 13, 14}})
DefinePlaySections("race", "orc", "type", "briefing",
    "cd", {"order", "all", "tracks", {15}})
DefinePlaySections("race", "orc", "type", "stats-victory",
    "cd", {"order", "all", "tracks", {16}})
DefinePlaySections("race", "orc", "type", "stats-defeat",
    "cd", {"order", "all", "tracks", {17}})

------------------------------------------------------------------------------
--	Define simple misc sounds.
--

MakeSound("missing", "general/misc/missing.wav")

MakeSound("building construction", "misc/building.wav")

MakeSound("blacksmith", "blacksmith.wav")
MakeSound("burning", "misc/fire_crackling.wav")
MakeSound("explosion", "misc/explosion.wav")
MakeSound("building destroyed",
  { "misc/building_collapse_1.wav",
    "misc/building_collapse_2.wav",
    "misc/building_collapse_3.wav"})
MakeSound("tree chopping",
  { "misc/tree_chopping_1.wav",
    "misc/tree_chopping_2.wav",
    "misc/tree_chopping_3.wav",
    "misc/tree_chopping_4.wav"})


------------------------------------------------------------------------------
--	Define attack sounds.
--

MakeSound("catapult attack", "missiles/catapult_rock_fired.wav")
MakeSound("catapult hit", "missiles/catapult_fire_explosion.wav")
MakeSound("fireball attack", "missiles/fireball.wav")
MakeSound("arrow attack", "missiles/arrow,spear.wav")
MakeSound("arrow hit", "missiles/arrow,spear_hit.wav")
MakeSound("fist attack", "missiles/fist_attack.wav")
MakeSound("sword attack",
  { "missiles/sword_attack_1.wav",
    "missiles/sword_attack_2.wav",
    "missiles/sword_attack_3.wav"})


------------------------------------------------------------------------------
--	Define sounds used by game
--

DefineGameSounds(
  "placement-error",
    MakeSound("placement error", "general/ui/placement error.wav"),
  "placement-success",
    MakeSound("placement success", "general/ui/placement success.wav"),

  "click", MakeSound("click", "ui/click.wav"),

  "work-complete", {"human", MakeSound("human work complete", "human/work_complete.wav")},
  "work-complete", {"orc", MakeSound("orc work complete", "orc/work_complete.wav")}

--[[
  "rescue", {"human", MakeSound("human rescue", "human/misc/rescue.wav")}
  "rescue", {"orc", MakeSound("orc rescue", "orc/misc/rescue.wav")}
]]
)


------------------------------------------------------------------------------
--	Load the different races
--

Load("scripts/human/sound.lua")
Load("scripts/orc/sound.lua")

