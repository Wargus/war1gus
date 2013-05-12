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
--      sounds.lua - Define the used sounds.
--
--      (c) Copyright 2004 by Jimmy Salmon
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

------------------------------------------------------------------------------
--	Define basic human sounds.
--

MakeSound("human work complete", "human/work_completed.wav")
MakeSound("human ready", "human/ready.wav")
MakeSound("human help 1", "human/help_1.wav")
MakeSound("human help 2", "human/help_2.wav")
MakeSound("human help 3", "human/help_3.wav")
MakeSound("human help 4", "human/help_4.wav")
MakeSound("human dead", "human/dead.wav")

MakeSound("human acknowledge",
  { "human/acknowledgement_1.wav",
    "human/acknowledgement_2.wav"})

MakeSound("human annoyed",
  { "human/annoyed_1.wav",
    "human/annoyed_2.wav",
    "human/annoyed_3.wav"})

MakeSound("human-selected",
  { "human/selected_1.wav",
    "human/selected_2.wav",
    "human/selected_3.wav",
    "human/selected_4.wav",
    "human/selected_5.wav"})

MakeSoundGroup("human selected",
  "human-selected", "human annoyed")


------------------------------------------------------------------------------
--	Define human selected sounds.
--

MakeSound("human-church-selected", "human/church.wav")
MakeSound("human-stable-selected", "human/stable.wav")
MakeSound("human-blacksmith-selected", "blacksmith.wav")

