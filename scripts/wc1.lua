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
--      wc1.lua - WC1 compatibility level
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

DefineRaceNames(
"race", {
    "name","human",
    "display","Human",
    "visible"
} ,
"race", {
    "name","orc",
    "display","Orc",
    "visible"
} ,
"race", {
    "name","neutral",
    "display","Neutral"
} )

-- XXX: Hack for loading savegames that are not campaigns
currentRace = "human"

-- overridden by generated wc1-config.lua
war1gus.music_extension = ".mid"

-- campaign detection
war1gus.InCampaign = false

-- unit type conversions for solo and multiplayer games
ShouldTogglePlayerRace = {}
UnitEquivalents = UnitEquivalents or { }

local dmg_formula = Add(AttackerVar("BasicDamage"),
                        Max(Sub(AttackerVar("PiercingDamage"), DefenderVar("Armor")), 0))
local dmg_with_20pc_miss = NumIf(LessThan(Rand(5), 1), 0, dmg_formula)
-- WC1 units miss around 20% of the time, except the catapult. Using this damage
-- formula isn't quite right, I found it documented somewhere, but it doesn't
-- work nicely.

-- SetDamageFormula(
--    NumIf(Equal(AttackerVar("BasicDamage"), 255), -- 255 is the catapult dmg
--          dmg_formula,
--          dmg_with_20pc_miss))

-- Convert unit type to the opposite race, if current player's race
-- does not match the predefined race
OldCreateUnit = OldCreateUnit or CreateUnit
function CreateUnit(unittype, player, pos)
    if (GameCycle ~= 0 or player == 15 or war1gus.InCampaign) then
        return OldCreateUnit(unittype, player, pos)
    end

    -- Don't add any units in 1 peasant only mode or for none-players
    if (GameSettings.NumUnits ~= -1 or Players[player].Type == PlayerNobody) then
        return
    end

    if ShouldTogglePlayerRace[player] then
        unittype = UnitEquivalents[unittype] or unittype
    end
    return OldCreateUnit(unittype, player, pos)
end

OldStartMap = OldStartMap or StartMap
function StartMap(map)
    ShouldTogglePlayerRace = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false}
    return OldStartMap(map)
end

OldSetPlayerData = OldSetPlayerData or SetPlayerData
function SetPlayerData(player, data, arg1, arg2)
  if (GameCycle ~= 0 or war1gus.InCampaign) then
    return OldSetPlayerData(player, data, arg1, arg2)
  end

  if (data == "RaceName") then
    local oldarg1 = arg1
    if (GameSettings.Presets[player].Race == 0) then
        arg1 = "human"
    elseif (GameSettings.Presets[player].Race == 1) then
        arg1 = "orc"
    end
    DebugPrint("Preset race for player " .. player .. " is " .. GameSettings.Presets[player].Race)
    DebugPrint("    oldarg1: " .. oldarg1)
    DebugPrint("    newarg1: " .. arg1)
    ShouldTogglePlayerRace[player] = (oldarg1 ~= arg1)  
    if (GetThisPlayer() == player) then
        LoadUI(arg1, Video.Width, Video.Height)
    end
  elseif (data == "Resources") then
    local res
    if (GameSettings.Resources == 0) then
      res = {gold = 2000, wood = 1500, lumber = 0}
    elseif (GameSettings.Resources == 1) then
      res = {gold = 5000, wood = 3000, lumber = 0}
    elseif (GameSettings.Resources == 2) then
      res = {gold = 10000, wood = 6000, lumber = 0}
	 elseif (GameSettings.Resources == 3) then
      res = {gold = 30000, wood = 15000, lumber = 0}
    end
    if res ~= nil then
       arg2 = res[arg1]
    end
  end
  OldSetPlayerData(player, data, arg1, arg2)

  -- If this is 1 peasant mode add the peasant now
  if (data == "RaceName") then
    if GameSettings.NumUnits ~= -1 then
      if (player ~= 15 and Players[player].Type ~= PlayerNobody) then
        local unittype = {human = "unit-peasant", orc = "unit-peon"}
        for i=1,GameSettings.NumUnits do
          OldCreateUnit(unittype[arg1], player, {Players[player].StartPos.x, Players[player].StartPos.y})
        end
      end
    end
  end
end

OldDefinePlayerTypes = OldDefinePlayerTypes or DefinePlayerTypes
function DefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
  if (war1gus.InCampaign) then
    return OldDefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
  elseif (IsNetworkGame()==true or GameSettings.GameType == -1) then
	  local p = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15}
	  local foundperson = false
	  local nump = GameSettings.Opponents
	  if (nump == 0) then nump = 15 end

	  for i=1,15 do
		if (p[i] == "person" or p[i] == "computer") then
		  if (p[i] == "person" and foundperson == false) then
			foundperson = true
		  else
			if (nump == 0) then
			  p[i] = "nobody"
			else
              if (foundperson and (not IsNetworkGame())) then
                -- in solo game, all persons save the first become computers
                p[i] = "computer"
              end
			  nump = nump - 1
			end
		  end
		end
	  end
	  OldDefinePlayerTypes(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12], p[13], p[14], p[15])
  else
	local plrsnmb = {nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil}
		for i=0,15 do
			if GameSettings.Presets[i].Type == PlayerPerson then
				plrsnmb[i+1]="person"
			elseif GameSettings.Presets[i].Type == PlayerComputer then
				plrsnmb[i+1]="computer"
			elseif GameSettings.Presets[i].Type == PlayerRescuePassive then
				plrsnmb[i+1]="rescue-passive"
			elseif GameSettings.Presets[i].Type == PlayerRescueActive then
				plrsnmb[i+1]="rescue-active"
			elseif GameSettings.Presets[i].Type == PlayerNeutral then
				plrsnmb[i+1]="nobody"
			elseif GameSettings.Presets[i].Type == -1 then
				plrsnmb[i+1]=nil
			end
		end
		return OldDefinePlayerTypes(plrsnmb[1], plrsnmb[2], plrsnmb[3], plrsnmb[4], plrsnmb[5], plrsnmb[6], plrsnmb[7], plrsnmb[8],
			plrsnmb[9], plrsnmb[10], plrsnmb[11], plrsnmb[12], plrsnmb[13], plrsnmb[14], plrsnmb[15])
	end
end
