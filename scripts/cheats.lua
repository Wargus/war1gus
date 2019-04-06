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
   local done = false

  if (str == "corwin of amber") then
     AddMessage("Cheats enabled you wascally wabbit")
     cheatenabled = true
  elseif cheatenabled then
     done  = true
     if (str == "eye of newt") then
        DefineAllow("upgrade-spider", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-scorpion", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-poison-cloud", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-rain-of-fire", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-daemon", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-water-elemental", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-raise-dead", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-healing", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-dark-vision", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-far-seeing", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-unholy-armor", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-invisibility", "AAAAAAAAAAAAAAAA")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-spider", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-scorpion", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-poison-cloud", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-rain-of-fire", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-daemon", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-water-elemental", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-raise-dead", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-healing", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-dark-vision", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-far-seeing", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-unholy-armor", "R")
        SetPlayerData(GetThisPlayer(), "Allow", "upgrade-invisibility", "R")
        AddMessage("You shall rain fire and fury!")

     elseif (str == "ides of march") then
        wc1.preferences.CampaignHuman = 13
        wc1.preferences.CampaignOrc = 13
        StopMusic()
        StopGame(GameQuitToMenu)
        Editor.Running = EditorNotRunning

     elseif (str == "iron forge") then
        DefineAllow("upgrade-spear1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-spear2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-arrow1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-arrow2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-axe1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-axe2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-sword1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-sword2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-wolves1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-wolves2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-horse1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-horse2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-orc-shield1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-orc-shield2", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-human-shield1", "AAAAAAAAAAAAAAAA")
        DefineAllow("upgrade-human-shield2", "AAAAAAAAAAAAAAAA")
        if GetPlayerData(GetThisPlayer(), "RaceName") == "orc" then
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-spear1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-spear2", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-axe1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-axe2", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-wolves1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-wolves2", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-orc-shield1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-orc-shield2", "R")
        else
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-arrow1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-arrow2", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-sword1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-sword2", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-horse1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-horse2", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-human-shield1", "R")
           SetPlayerData(GetThisPlayer(), "Allow", "upgrade-human-shield2", "R")
        end
        AddMessage("Look at them wheels!")

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
        ActionVictory()

     elseif (str == "crushing defeat") then
        ActionDefeat()

     elseif (str == "there can be only one") then
        if (godcheat) then
           godcheat = false
           SetGodMode(false)
           AddMessage("God Mode OFF")
        else
           godcheat = true
           SetGodMode(true)
           AddMessage("God Mode ON")
        end

     elseif (str:find("^human%d+$") ~= nil) then
        print("'" .. str .. "'")
        for x in string.gmatch(str, "%d+") do
           wc1.preferences.CampaignHuman = tonumber(x)
           StopMusic()
           StopGame(GameQuitToMenu)
           Editor.Running = EditorNotRunning
        end

     elseif (str:find("^orc%d+$") ~= nil) then
        for x in string.gmatch(str, "%d+") do
           wc1.preferences.CampaignOrc = tonumber(x)
           StopMusic()
           StopGame(GameQuitToMenu)
           Editor.Running = EditorNotRunning
        end
        StopMusic()
        StopGame(GameQuitToMenu)
        Editor.Running = EditorNotRunning

     elseif (str == "action defeat") then
        ActionDefeat()
     elseif (str == "action victory") then
        ActionVictory()
     else
        done = false
     end
  end

  if done then
     return true
  elseif (string.find(str, ".lua")) then
     AddMessage("Reloading " .. str)
     Load("scripts/" .. str)
  elseif (string.find(str, "eval") == 1) then
     local code = str:gsub("^eval%s", "")
     AddMessage("Running: " .. code)
     local result = loadstring(code)
     AddMessage(" => " .. tostring(result))
  else
    return false
  end

  return true
end
