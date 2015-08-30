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
--      campaign.lua - Define the campaign attack AI.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
--      (c) Copyright 2012-2015 by Tim Felgentreff
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

function CreateAiCampaign(level)
   -- smaller sleep_factors mean faster AI, so we get scaling in the last lvls, even though actions are the same
   local sleep_factor = 13 - level

   local PureAiSleep = AiSleep
   local AiSleep = function(cycles)
      return PureAiSleep(cycles * sleep_factor)
   end

   -- This simulates a timeout around WaitForce. If, for some reason,
   -- we cannot build within 240 rounds (~4 min), we just attack,
   -- anyway
   local waitForceRounds = 0
   local PureAiWaitForce = AiWaitForce
   local AiWaitForce = function(num)
      if (not AiCheckForce(num)) and waitForceRounds < 240 then
   	 -- redo this step
   	 local loopidx = stratagus.gameData.AIState.loop_index[1 + AiPlayer()]
   	 local idx = stratagus.gameData.AIState.index[1 + AiPlayer()]
   	 if loopidx > 1 then
   	     stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = loopidx - 1
   	 else
   	    stratagus.gameData.AIState.index[1 + AiPlayer()] = idx - 1
   	 end

   	 waitForceRounds = waitForceRounds + 1
   	 return AiSleep(AiGetSleepCycles() * 2)
      else
   	 waitForceRounds = 0
   	 return false
      end
   end

   local campaign_funcs10 = {
	  function() return AiResearch(AiSummonerSpell3()) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 5}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiCityCenter()) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 5}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiSet(AiWorker(), 25) end,

	  function() print("Looping at lvl 10!") return false end,
	  function() return AiForce(0, {AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1, AiMage(), 3, AiSummoner(), 3}) end,
	  function() return AiForce(1, {AiShooter(), 4, AiCavalry(), 4, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 2}) end,
	  function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
	  function() return AiAttackWithForce(1) end,
	  function() return AiSleep(500) end,	

      -- Everything researched...
      function()
	    stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = stratagus.gameData.AIState.loop_index[1 + AiPlayer()] - 8
	  end
   }

   local campaign_funcs9 = {
      function() return AiResearch(AiSummonerSpell2()) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 3, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiResearch(AiSummonerSpell3()) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,
      function() return AiSleep(500) end,

	  function() print("Looping at lvl 9!") return false end,
	  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 2}) end,
	  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
	  function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
	  function() return AiAttackWithForce(1) end,
	  function() return AiSleep(500) end,

	  function()
		if level > 9 then
		  return AiLoop(campaign_funcs10, stratagus.gameData.AIState.loop_index)
		else
		  stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = stratagus.gameData.AIState.loop_index[1 + AiPlayer()] - 8
		end
      end
	}

   local campaign_funcs7 = {
      function() return AiSleep(500) end,
      function() return AiNeed(AiMageTower()) end,
      function() return AiResearch(AiSummonerSpell1()) end,

	  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 3, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

	  function() print("Looping at lvl 7!") return false end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 3, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,
      function() return AiSleep(500) end,

	  function()
		if level > 7 then
		  return AiLoop(campaign_funcs9, stratagus.gameData.AIState.loop_index)
		else
		  stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = stratagus.gameData.AIState.loop_index[1 + AiPlayer()] - 8
		end
      end
   }

   local campaign_funcs6 = {
	  function() return AiResearch(AiUpgradeWeapon2()) end,
      function() return AiResearch(AiUpgradeArmor2()) end,
      function() return AiSleep(500) end,
      function() return AiSet(AiWorker(), 15) end,
      function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCatapult(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiSleep(500) end,
      function() return AiAttackWithForce(0) end,
	  function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiCityCenter()) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1}) end,
      function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,
      
      function() return AiSleep(500) end,
      function() return AiNeed(AiBarracks()) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 6, AiCatapult(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1}) end,
      function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiTemple()) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 4, AiMage(), 1, AiCatapult(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiMage(), 1, AiCatapult(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

	  function() print("Looping at lvl 6!") return false end,
	  function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 4, AiMage(), 1, AiCatapult(), 1}) end,
	  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiMage(), 1, AiCatapult(), 1}) end,
	  function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
	  function() return AiAttackWithForce(1) end,
	  function() return AiSleep(500) end,	

	  function()
		if level > 6 then
		  return AiLoop(campaign_funcs7, stratagus.gameData.AIState.loop_index)
		else
		  stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = stratagus.gameData.AIState.loop_index[1 + AiPlayer()] - 8
		end
      end
    }

    local campaign_funcs5 = {
      function() return AiResearch(AiUpgradeMissile2()) end,
	  function() return AiSet(AiWorker(), 9) end,
      function() return AiSleep(500) end,
	  function() return AiNeed(AiBlacksmith()) end,
      function() return AiResearch(AiUpgradeWeapon1()) end,
      function() return AiResearch(AiUpgradeArmor1()) end,
	  function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 2, AiShooter(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiSleep(500) end,
	  function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiBarracks()) end,
      function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2, AiCavalry(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCavalry(), 2}) end,
      function() return AiWaitForce(1) end,
      function() return AiSleep(600) end,
	  function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

	  function() print("looping at lvl 5 !") return false end,
	  function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2, AiCavalry(), 2}) end,
	  function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCavalry(), 2}) end,
	  function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
	  function() return AiAttackWithForce(1) end,
	  function() return AiSleep(500) end,

	  function()
	    if level > 5 then
		  return AiLoop(campaign_funcs6, stratagus.gameData.AIState.loop_index)
		else
		  stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = stratagus.gameData.AIState.loop_index[1 + AiPlayer()] - 8
		end
      end
    }

    local campaign_funcs3 = {
      function() AiDebug(false) return false end,
      function() return AiSleep(AiGetSleepCycles()) end,
      function() return AiNeed(AiCityCenter()) end,
      function() return AiSet(AiWorker(), 1) end,
      function() return AiWait(AiCityCenter()) end,
      function() return AiWait(AiWorker()) end, -- start hangs if nothing available

      function() return AiSet(AiWorker(), 4) end,
      function() return AiNeed(AiLumberMill()) end,
      function() return AiNeed(AiBarracks()) end,
      function() return AiForce(0, {AiSoldier(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 1}) end,
      function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,
      function() return AiSleep(1) end,      

	  function() return AiSleep(500) end,
	  function() return AiResearch(AiUpgradeMissile1()) end,
	  function() return AiNeed(AiTemple()) end,
      function() return AiResearch(AiMageSpell2()) end,

	  function() print("looping at lvl 3 !") return false end,
	  function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 1, AiMage(), 1}) end,
	  function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiMage(), 1}) end,
	  function() return AiWaitForce(1) end,
	  function() return AiAttackWithForce(0) end,
	  function() return AiAttackWithForce(1) end,
	  function() return AiSleep(500) end,

	  function()
	    if level > 3 then
		  return AiLoop(campaign_funcs5, stratagus.gameData.AIState.loop_index)
		else
		  stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = stratagus.gameData.AIState.loop_index[1 + AiPlayer()] - 8
        end
      end
    }

    local AiCampaignAttack = function()
      return AiLoop(campaign_funcs3, stratagus.gameData.AIState.index)
    end

    return AiCampaignAttack
end

Ai02 = function()
    return AiLoop({
		function()
			AiForce(0, {AiSoldier(), 1})
			if not AiCheckForce(0) then AiForce(0, {AiShooter(), 1}) end
			return AiSleep(9000)
		end,
		function() return AiAttackWithForce(0) end,
      
		function()
			AiForce(0, {AiShooter(), 1})
			if not AiCheckForce(0) then AiForce(0, {AiSoldier(), 1}) end
			return AiSleep(9000)
		end,
		function() return AiAttackWithForce(0) end,
      
		function()
			stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = 0
			return false
		end
	}, stratagus.gameData.AIState.loop_index)
end

DefineAi("camp01", "*", "camp01", AiPassive)
DefineAi("camp02", "*", "camp02", Ai02)
DefineAi("camp03", "*", "camp03", CreateAiCampaign(3))
DefineAi("camp04", "*", "camp04", AiPassive)
DefineAi("camp05", "*", "camp05", CreateAiCampaign(5))
DefineAi("camp06", "*", "camp06", CreateAiCampaign(6))
DefineAi("camp07", "*", "camp07", CreateAiCampaign(7))
DefineAi("camp08", "*", "camp08", AiPassive)
DefineAi("camp09", "*", "camp09", CreateAiCampaign(9))
DefineAi("camp10", "*", "camp10", CreateAiCampaign(10))
DefineAi("camp11", "*", "camp11", CreateAiCampaign(11))
DefineAi("camp12", "*", "camp12", CreateAiCampaign(12))
