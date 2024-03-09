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
--      land_attack.lua - Define the land attack AI.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
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

-- defines a land attack ai. the sleep_factor is a factor to all
-- a sleep statements, to scale down difficulty
-- smaller sleep_factors mean faster AI

-- a function to just generate roads. this gives the ai player an advantage, but what the heck
function GenerateRoads(do_second, do_third)
    local first_roads = {
                            {{ 0,-1}, { 0,-2}, { 0,-3}, { 0,-4}, { 0,-5}, { 0,-6}, { 0,-7}, { 0,-8}, { 0,-9}},
                            {{-1,-1}, {-2,-1}, {-3,-1}, {-4,-1}, {-5,-1}, {-6,-1}, {-7,-1}, {-8,-1}, {-9,-1}},
                            {{ 3, 0}, { 4, 0}, { 5, 0}, { 6, 0}, { 7, 0}, { 8, 0}, { 9, 0}, {10, 0}, {11, 0}},
                            {{ 3,-1}, { 3,-2}, { 3,-3}, { 3,-4}, { 3,-5}, { 3,-6}, { 3,-7}, { 3,-8}, { 3,-9}},
                            {{ 3, 3}, { 4, 3}, { 5, 3}, { 6, 3}, { 7, 3}, { 8, 3}, { 9, 3}, {10, 3}, {11, 3}},
                            {{ 2, 3}, { 2, 4}, { 2, 5}, { 2, 6}, { 2, 7}, { 2, 8}, { 2, 9}, { 2,10}, { 2,11}},
                            {{-1, 2}, {-2, 2}, {-3, 2}, {-4, 2}, {-5, 2}, {-6, 2}, {-7, 2}, {-8, 2}, {-9, 2}},
                            {{-1, 3}, {-1, 4}, {-1, 5}, {-1, 6}, {-1, 7}, {-1, 8}, {-1, 9}, {-1,10}, {-1,11}}
                        }
    local second_roads = {
                        {{-1,-9}, {-2,-9}, {-3,-9}, {-4,-9}},
                        {{-9,-2}, {-9,-3}, {-9,-4}, {-9,-5}},
                        {{11,-1}, {11,-2}, {11,-3}, {11,-4}},
                        {{ 4,-9}, { 5,-9}, { 6,-9}, { 7,-9}},
                        {{11, 4}, {11, 5}, {11, 6}, {11, 7}},
                        {{ 2,11}, { 3,11}, { 4,11}, { 5,11}},
                        {{-9, 3}, {-9, 4}, {-9, 5}, {-9, 6}},
                        {{-2,11}, {-3,11}, {-4,11}, {-5,11}},
                        }
    local third_roads = {
                        {{-5,-9}, {-6,-9}, {-7,-9}, {-8,-9}},
                        {{-9,-6}, {-9,-7}, {-9,-7}, {-9,-9}},
                        {{11,-5}, {11,-6}, {11,-7}, {11,-8}},
                        {{ 8,-9}, { 9,-9}, {10,-9}, {11,-9}},
                        {{11, 8}, {11, 9}, {11,10}, {11,11}},
                        {{ 6,11}, { 7,11}, { 8,11}, { 9,11}},
                        {{-9, 7}, {-9, 8}, {-9, 9}, {-9,10}},
                        {{-6,11}, {-7,11}, {-8,11}, {-9,11}},
                        }
    local do_second_road = {false,false,false,false,false,false,false,false}
    local do_third_road = {false,false,false,false,false,false,false,false}
    for i,unit in ipairs(GetUnits(AiPlayer())) do
        if GetUnitVariable(unit, "Ident") == AiCityCenter() then
            local posx = GetUnitVariable(unit, "PosX")
            local posy = GetUnitVariable(unit, "PosY")
            for i,road in ipairs(first_roads) do
            do_second_road[i] = true
            for j,pos in ipairs(road) do
                local px = posx+pos[1]
                local py = posy+pos[2]
                if (px >= 0 and py >= 0 and Map.Info.MapWidth >= px and Map.Info.MapHeight >= py and
                    (not (GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "no-building") or
                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "water") or
                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "coast") or
                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "wall") or
                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "forest") or
                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "rock")))) then
                    CreateUnit("unit-road", AiPlayer(), {px,py})
                else
                    do_second_road[i] = false
                    break -- road ends here
                end
            end
        end
        if do_second then
            for i,road in ipairs(second_roads) do
                if do_second_road[i] then
                    do_third_road[i] = true
                    for j,pos in ipairs(road) do
                        local px = posx+pos[1]
                        local py = posy+pos[2]
                        if (px >= 0 and py >= 0 and Map.Info.MapWidth >= px and Map.Info.MapHeight >= py and
                            (not (GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "no-building") or
                                    GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "water") or
                                    GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "coast") or
                                    GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "wall") or
                                    GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "forest") or
                                    GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "rock")))) then
                            CreateUnit("unit-road", AiPlayer(), {px,py})
                        else
                            do_third_road[i] = false
                            break -- road ends here
                        end
                    end
                end
            end
            if do_third then
                for i,road in ipairs(third_roads) do
                    if do_third_road[i] then
                        for j,pos in ipairs(road) do
                            local px = posx+pos[1]
                            local py = posy+pos[2]
                            if (px >= 0 and py >= 0 and Map.Info.MapWidth >= px and Map.Info.MapHeight >= py and
                                (not (GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "no-building") or
                                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "water") or
                                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "coast") or
                                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "wall") or
                                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "forest") or
                                        GetTileTerrainHasFlag(posx+pos[1], posy+pos[2], "rock")))) then
                                CreateUnit("unit-road", AiPlayer(), {px,py})
                            else
                                break -- road ends here
                            end
                        end
                    end
                end
            end
        end
    end
    end
end

function CreateAiLandAttack(sleep_factor, max_force)
   local end_loop_funcs = {
      function() print("Looping !") return false end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 4, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 4}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 4, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 2}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,
      function() return AiSleep(500) end,
      function() 
	 stratagus.gameData.AIState.loop_index[1 + AiPlayer()] = 0
	 return false
      end,
   }

   local land_funcs = {
      function() AiDebug(false) return false end,
      function() return AiSleep(AiGetSleepCycles()) end,
      function() return AiNeed(AiCityCenter()) end,
      function() return AiSet(AiWorker(), 1) end,
      function() return AiWait(AiCityCenter()) end,
      function() return AiWait(AiWorker()) end, -- start hangs if nothing available

      function () return GenerateRoads(true, false) end,

      function() return AiSet(AiWorker(), 4) end,
	  function() return AiWait(AiWorker()) end,

      function() return AiNeed(AiBarracks()) end,
	  function() return AiNeed(AiLumberMill()) end,
	  function() return AiWait(AiBarracks()) end,
      function() return AiForce(0, {AiSoldier(), 2}) end,
      --function() return AiForce(1, {AiSoldier(), 1}) end,
      --function() return AiWaitForce(1) end,
      --function() return AiAttackWithForce(1) end,
      function() return AiSleep(1) end,      

      function () return GenerateRoads(true, false) end,

      function() return AiSet(AiWorker(), 9) end,
      function() return AiSleep(500) end,
      function() return AiNeed(AiBlacksmith()) end,
	  function() return AiWait(AiWorker()) end,
	  function() return AiWait(AiLumberMill()) end, 
      function() return AiNeed(AiTower()) end,
      function() return AiForce(0, {AiSoldier(), 2, AiShooter(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 2, AiShooter(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
	  function() return AiNeed(AiTower()) end,
      function() return AiSleep(500) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

	  function() return AiWait(AiBlacksmith()) end,
      function() return AiResearch(AiUpgradeWeapon1()) end,
      function() return AiResearch(AiUpgradeArmor1()) end,
      function() return AiResearch(AiUpgradeMissile1()) end,
      --function() return AiResearch(AiUpgradeWeapon2()) end,
      --function() return AiResearch(AiUpgradeArmor2()) end,
      --function() return AiResearch(AiUpgradeMissile2()) end,
      function() return AiNeed(AiBarracks()) end,
	  function() return AiWait(AiBarracks()) end,

      function () return GenerateRoads(true, true) end,

      function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiSleep(600) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiSet(AiWorker(), 15) end,
      function() return AiForce(0, {AiSoldier(), 3, AiShooter(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCatapult(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiSleep(500) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

      function() return AiSleep(500) end,

      function() return AiForce(1, {AiSoldier(), 3, AiShooter(), 1, AiCatapult(), 1}) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiStables()) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,
      
      function() return AiSleep(500) end,
      function() return AiNeed(AiBarracks()) end,
      function() return AiSet(AiWorker(), 19) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiTemple()) end,
      function() return AiResearch(AiMageSpell2()) end,
      function() return AiResearch(AiMageSpell3()) end,

      function () return GenerateRoads(true, true) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiMage(), 1, AiCatapult(), 1}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiMage(), 1, AiCatapult(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

      function() return AiSleep(500) end,
      function() return AiNeed(AiMageTower()) end,
      function() return AiResearch(AiSummonerSpell1()) end,
      function() return AiResearch(AiSummonerSpell3()) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 3, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiResearch(AiSummonerSpell2()) end,

      function () return GenerateRoads(true, true) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

      function() return AiSleep(500) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 2}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,

      function () return GenerateRoads(true, true) end,

      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 5}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

      function() return AiSleep(500) end,
      function() return AiForce(0, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 3, AiCatapult(), 1, AiMage(), 2, AiSummoner(), 5}) end,
      function() return AiForce(1, {AiSoldier(), 1, AiShooter(), 2, AiCavalry(), 2, AiCatapult(), 1, AiMage(), 1, AiSummoner(), 1}) end,
      function() return AiWaitForce(0) end,
      function() return AiWaitForce(1) end,
      function() return AiAttackWithForce(0) end,
      function() return AiAttackWithForce(1) end,

      function () return GenerateRoads(true, true) end,

      function() return AiSleep(500) end,
      function() return AiSet(AiWorker(), 25) end,

      -- Everything researched...
      function()
	 return AiLoop(end_loop_funcs, stratagus.gameData.AIState.loop_index)
      end
   }

   local AiLandAttack = function()
      return AiLoop(land_funcs, stratagus.gameData.AIState.index)
   end

   return AiLandAttack
end

-- global default land attack
AiLandAttack = CreateAiLandAttack(1)
DefineAi("wc1-land-attack", "*", "wc1-land-attack", AiLandAttack)
DefineAi("ai-land-attack", "*", "ai-land-attack", AiLandAttack)
