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
--	Define basic orc sounds.
--

MakeSound("orc work complete", "orc/work_complete.wav")
MakeSound("orc ready", "orc/ready.wav")
MakeSound("orc help 1", "orc/help_1.wav")
MakeSound("orc help 2", "orc/help_2.wav")
MakeSound("orc help 3", "orc/help_3.wav")
MakeSound("orc help 4", "orc/help_4.wav")
MakeSound("orc dead", "orc/dead.wav")

MakeSound("orc acknowledge",
  { "orc/acknowledgement_1.wav",
    "orc/acknowledgement_2.wav",
    "orc/acknowledgement_3.wav",
    "orc/acknowledgement_4.wav"})

MakeSound("orc annoyed",
  { "orc/annoyed_1.wav",
    "orc/annoyed_2.wav",
    "orc/annoyed_3.wav"})

MakeSound("orc-selected",
  { "orc/selected_1.wav",
    "orc/selected_2.wav",
    "orc/selected_3.wav",
    "orc/selected_4.wav",
    "orc/selected_5.wav"})

MakeSoundGroup("orc selected",
  "orc-selected", "orc annoyed")

MakeSound("capture (orc)", "mythical/misc/capture.wav")
MakeSound("rescue (orc)", "mythical/misc/rescue.wav")


------------------------------------------------------------------------------
--	Define orc attack sounds.
--

MapSound("grunt-attack", "sword attack")
MapSound("orc-catapult-attack", "catapult attack")
MapSound("raider-attack", "sword attack")
MapSound("raider1-attack", "sword attack")
MapSound("raider2-attack", "sword attack")
MapSound("spearman-attack", "arrow attack")
MapSound("necrolyte-attack", "lightning")
MapSound("warlock-attack", "lightning")


------------------------------------------------------------------------------
--	Define orc selected sounds.
--

MakeSound("orc-temple-selected", "orc/temple.wav")
MakeSound("orc-kennel-selected", "orc/kennel.wav")
MakeSound("orc-blacksmith-selected", "blacksmith")

