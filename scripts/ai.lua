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
--      ai.lua - Define the AI.
--
--      (c) Copyright 2000-2013 by Lutz Sammer, Jimmy Salmon, and Joris Dauphin
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


--(define (ai:sleep) () #t)

race1 = "human"
race2 = "orc"

DefineAiHelper(
   {"unit-equiv", "unit-knight", "unit-knight1", "unit-knight2"}
)
DefineAiHelper(
   {"unit-equiv", "unit-raider", "unit-raider1", "unit-raider2"}
)
DefineAiHelper(
   {"unit-equiv", "unit-human-town-hall", "unit-human-stormwind-keep"}
)
DefineAiHelper(
   {"unit-equiv", "unit-orc-town-hall", "unit-orc-blackrock-spire"}
)

--
--  City-center of the current race.
--
function AiCityCenter()
   if (AiGetRace() == race1) then
      return "unit-human-town-hall"
   else
      return "unit-orc-town-hall"
   end
end

--
--  Worker of the current race.
--
function AiWorker()
   if (AiGetRace() == race1) then
      return "unit-peasant"
   else
      return "unit-peon"
   end
end

--
--  Lumber mill of the current race.
--
function AiLumberMill()
   if (AiGetRace() == race1) then
      return "unit-human-lumber-mill"
   else
      return "unit-orc-lumber-mill"
   end
end

--
--  Blacksmith of the current race.
--
function AiBlacksmith()
   if (AiGetRace() == race1) then
      return "unit-human-blacksmith"
   else
      return "unit-orc-blacksmith"
   end
end

--
--  Upgrade armor 1 of the current race.
--
function AiUpgradeArmor1()
   if (AiGetRace() == race1) then
      return "upgrade-human-shield1"
   else
      return "upgrade-orc-shield1"
   end
end

--
--  Upgrade armor 2 of the current race.
--
function AiUpgradeArmor2()
   if (AiGetRace() == race1) then
      return "upgrade-human-shield2"
   else
      return "upgrade-orc-shield2"
   end
end

--
--  Upgrade weapon 1 of the current race.
--
function AiUpgradeWeapon1()
   if (AiGetRace() == race1) then
      return "upgrade-sword1"
   else
      return "upgrade-axe1"
   end
end

--
--  Upgrade weapon 2 of the current race.
--
function AiUpgradeWeapon2()
   if (AiGetRace() == race1) then
      return "upgrade-sword2"
   else
      return "upgrade-axe2"
   end
end

--
--  Upgrade missile 1 of the current race.
--
function AiUpgradeMissile1()
   if (AiGetRace() == race1) then
      return "upgrade-arrow1"
   else
      return "upgrade-spear1"
   end
end

--
--  Upgrade missile 2 of the current race.
--
function AiUpgradeMissile2()
   if (AiGetRace() == race1) then
      return "upgrade-arrow2"
   else
      return "upgrade-spear2"
   end
end

--
--  Stables of the current race.
--
function AiStables()
   if (AiGetRace() == race1) then
      return "unit-human-stable"
   else
      return "unit-orc-kennel"
   end
end

--
--  Temple of the current race.
--
function AiTemple()
   if (AiGetRace() == race1) then
      return "unit-human-church"
   else
      return "unit-orc-temple"
   end
end

--
--  Mage tower of the current race.
--
function AiMageTower()
   if (AiGetRace() == race1) then
      return "unit-human-tower"
   else
      return "unit-orc-tower"
   end
end

--
--  Barracks of the current race.
--
function AiBarracks()
   if (AiGetRace() == race1) then
      return "unit-human-barracks"
   else
      return "unit-orc-barracks"
   end
end

--
--  Soldier of the current race.
--
function AiSoldier()
   if (AiGetRace() == race1) then
      return "unit-footman"
   else
      return "unit-grunt"
   end
end

--
--  Shooter of the current race.
--
function AiShooter()
   if (AiGetRace() == race1) then
      return "unit-archer"
   else
      return "unit-spearman"
   end
end

--
--  Cavalry of the current race.
--
function AiCavalry()
   if (AiGetRace() == race1) then
      return "unit-knight"
   else
      return "unit-raider"
   end
end

--
-- Supporting mage
--
function AiMage()
   if (AiGetRace() == race1) then
      return "unit-cleric"
   else
      return "unit-necrolyte"
   end
end

--
--  Summoner of the current race.
--
function AiSummoner()
   if (AiGetRace() == race1) then
      return "unit-conjurer"
   else
      return "unit-warlock"
   end
end

--
--  Catapult of the current race.
--
function AiCatapult()
   if (AiGetRace() == race1) then
      return "unit-human-catapult"
   else
      return "unit-orc-catapult"
   end
end

--
--  1st spell of the cavalry mages of the current race.
--
function AiMageSpell1()
   if (AiGetRace() == race1) then
      return "upgrade-far-seeing"
   else
      return "upgrade-dark-vision"
   end
end

--
--  2nd spell of the cavalry mages of the current race.
--
function AiMageSpell2()
   if (AiGetRace() == race1) then
      return "upgrade-healing"
   else
      return "upgrade-raise-dead"
   end
end

--
--  3rd spell of the cavalry mages of the current race.
--
function AiMageSpell3()
   if (AiGetRace() == race1) then
      return "upgrade-invisibility"
   else
      return "upgrade-unholy-armor"
   end
end

--
--  1st spell of the summoners of the current race.
--
function AiSummonerSpell1()
   if (AiGetRace() == race1) then
      return "upgrade-scorpion"
   else
      return "upgrade-spider"
   end
end

--
--  2nd spell of the summoners of the current race.
--
function AiSummonerSpell2()
   if (AiGetRace() == race1) then
      return "upgrade-rain-of-fire"
   else
      return "upgrade-poison-cloud"
   end
end

--
--  3th spell of the mages of the current race.
--
function AiSummonerSpell3()
   if (AiGetRace() == race1) then
      return "upgrade-water-elemental"
   else
      return "upgrade-daemon"
   end
end

--
--  Some functions used by Ai
--

-- Create some counters used by ai
local function CreateAiGameData()
   if stratagus == nil then
      stratagus = {}
   end
   if stratagus.gameData == nil then
      stratagus.gameData = {}
   end
   if stratagus.gameData.AIState == nil then
      stratagus.gameData.AIState = {}
      stratagus.gameData.AIState.index = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
      stratagus.gameData.AIState.loop_index = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
   end
end

local function CleanAiGameData()
   if stratagus ~= nil and stratagus.gameData ~= nil then
      stratagus.gameData.AIState = nil
   end
end

function ReInitAiGameData()
   CleanAiGameData()
   CreateAiGameData()
end

function DebugMessage(message)
   message = "Game cycle(" .. GameCycle .. "):".. message
   --	AddMessage(message)
   DebugPrint(message .. "\n")
end

function AiLoop(loop_funcs, indexes)
   local playerIndex = AiPlayer() + 1

   while (true) do
      local func = loop_funcs[indexes[playerIndex]]
      local ret = false
      if (func == nil) then
         AddMessage("BUG: Please file a bug 'AI loop broken' with the level and this number: " .. indexes[playerIndex])
         indexes[playerIndex] = 0
      else
         ret = func()
      end
      if (ret) then break end
      indexes[playerIndex] = indexes[playerIndex] + 1
   end
   return true
end

--
--  Load the actual individual scripts.
--
ReInitAiGameData()
Load("scripts/ai/passive.lua")
Load("scripts/ai/land_attack.lua")
Load("scripts/ai/campaign.lua")
