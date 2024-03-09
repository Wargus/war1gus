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
--      scripts.lua - The craft configuration language.
--
--      (c) Copyright 2005 by Jimmy Salmon
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

for i=1,table.getn(OnTilesetChangeFunctions) do
    OnTilesetChangeFunctions[i]()
end

-- Hardcoded unit-types, moved from Stratagus to games
if war1gus.tileset == "dungeon_campaign" then
    UnitTypeHumanWall = UnitTypeByIdent("unit-wall");
    UnitTypeOrcWall = UnitTypeByIdent("unit-wall");
end

if war1gus.tileset == "dungeon" or war1gus.tileset == "dungeon_campaign" then
    GameSettings.Inside = true
else
    GameSettings.Inside = false
end

LoadUI(GetPlayerData(GetThisPlayer(), "RaceName"), Video.Width, Video.Height)

StopMusic()
MusicStopped()
