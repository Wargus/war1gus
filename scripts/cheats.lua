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
--      wc2.lua - WC2 compatibility level
--
--      (c) Copyright 2001-2004 by Lutz Sammer and Jimmy Salmon
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

speedcheat = false
godcheat = false
cheatenabled = false

function HandleCheats(str)
  local resources = { "gold", "wood" }

  if (str == "corwin of amber") then
	AddMessage("Cheats enabled you wascally wabbit")
	cheatenabled = true

  elseif (str == "eye of newt") then
    -- FIXME: no function yet
    AddMessage("All wizard spells cheat ... not working yet")

  elseif (str == "ides of march") then
    -- FIXME: no function yet
    AddMessage("Final campaign sequence cheat ... not working yet")

  elseif (str == "iron forge") then
    -- FIXME: no function yet
    AddMessage("Upgraded technology cheat ... not working yet")

  elseif (str == "pot of gold") then
    SetPlayerData(GetThisPlayer(), "Resources", "gold",
      GetPlayerData(GetThisPlayer(), "Resources", "gold") + 10000)
    SetPlayerData(GetThisPlayer(), "Resources", "wood",
      GetPlayerData(GetThisPlayer(), "Resources", "wood") + 5000)
    AddMessage("!!! :)")

  elseif (str == "sally shears") then
    RevealMap()

  elseif (str == "hurry up guys") then
    if (speedcheat) then
      speedcheat = false
      for idx,res in ipairs(resources) do
	 SetSpeedResourcesHarvest(GetThisPlayer(), res, 1)
	 SetSpeedResourcesReturn(GetThisPlayer(), res, 1)
      end
      SetSpeedBuild(GetThisPlayer(), 1)
      SetSpeedTrain(GetThisPlayer(), 1)
      SetSpeedUpgrade(GetThisPlayer(), 1)
      SetSpeedResearch(GetThisPlayer(), 1)
      AddMessage("NO RUSH!")
    else
      speedcheat = true
      for idx,res in ipairs(resources) do
	 SetSpeedResourcesHarvest(GetThisPlayer(), res, 10)
	 SetSpeedResourcesReturn(GetThisPlayer(), res, 10)
      end
      SetSpeedBuild(GetThisPlayer(), 10)
      SetSpeedTrain(GetThisPlayer(), 10)
      SetSpeedUpgrade(GetThisPlayer(), 10)
      SetSpeedResearch(GetThisPlayer(), 10)
      AddMessage("HURRY!")
    end

  elseif (str == "yours truly") then
    if (cheatenabled) then ActionVictory() end

  elseif (str == "crushing defeat") then
    if (cheatenabled) then ActionDefeat() end

  elseif (str == "there can be only one") then
    if (cheatenabled) then
      if (godcheat) then
        godcheat = false
        SetGodMode(false)
        AddMessage("God Mode OFF")
      else
        godcheat = true
        SetGodMode(true)
        AddMessage("God Mode ON")
      end
	end

  elseif (str:gsub("^human%d$", "") == "") then
     AddMessage("Skip to human lvl" .. str:gsub("human", "") .. ". Not implemented yet")

  elseif (str:gsub("^orc%d$", "") == "") then
     AddMessage("Skip to orc lvl" .. str:gsub("orc", "") .. ". Not implemented yet")

  elseif (str == "action defeat") then
    ActionDefeat()
  elseif (str == "action victory") then
    ActionVictory()

  else
    return false
  end
  return true
end
