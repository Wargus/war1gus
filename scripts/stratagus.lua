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
--      stratagus.lua - The craft configuration language.
--
--      (c) Copyright 1998-2003 by Lutz Sammer
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

-- For documentation see stratagus/doc/scripts/scripts.html
print("Stratagus default config file loading ...\n")

war1gus = {}
war1gus.Name = "War1gus"
war1gus.Version = "2.2.5.4"
war1gus.Homepage = "https://launchpad.net/war1gus"
war1gus.Licence = "GPL v2"
war1gus.Copyright = "Copyright (c) 1998-2010 by The Stratagus Project"

function file_exists(path, name)
   for i,f in ipairs(ListFilesInDirectory(path)) do
      if f == name then
         return true
      end
   end
   return false
end

InitFuncs = {}
function InitFuncs:add(f)
  table.insert(self, f)
end

function InitGameVariables()
  for i=1,table.getn(InitFuncs) do
    InitFuncs[i]()
  end
end

-- Config file version
--(define media-version (list 'wc1 'class 'wc1 'version '(1 18 0)))

-------------------------------------------------------------------------------
--  Config-Part
-------------------------------------------------------------------------------

--  Edit the next sections to get your look and feel.
--  Note, some of those values are overridden by user preferences,
--  see ~/.stratagus/preferences1.scripts
--  and ~/.stratagus/gamename/preferences2.scripts


--  Enter your menu music.
--SetMenuMusic("music/default.mod")


--  If color-cycle-all is off (#f) only the tileset and global palette are
--  color cycled.  Otherwise (#t) all palettes are color cycled.
--SetColorCycleAll(true) this
--SetColorCycleAll(false)

--  Set the game name. It's used so we can mantain different savegames
--  and setting. Might also be used for multiplayer.
SetGameName("wc1")
SetFullGameName(war1gus.Name)
--  set the default map file.
--SetDefaultMap("campaigns/human/01.cm")


SetSelectionStyle("rectangle")
Preference.ShowSightRange = false
Preference.ShowAttackRange = false
Preference.ShowReactionRange = false

Preference.ShowOrders = 2

-------------------------------------------------------------------------------
--  Game modification

SetMaxSelectable(4)

--  Edit this to enable/disable building capture.
--SetBuildingCapture(true)
SetBuildingCapture(false)

--  Set forest regeneration speed. (n* seconds, 0 = disabled)
--  (Auf allgemeinen Wunsch eines einzelnen Herrn :)
SetForestRegeneration(0)
--SetForestRegeneration(5)

--  Edit this to enable/disable the reveal of the attacker.
--SetRevealAttacker(true)
SetRevealAttacker(false)

-------------------------------------------------------------------------------

--  If you prefer fighters are attacking by right clicking empty space
--  uncomment this (you must comment the next).
--  FIXME: this option will be renamed
--RightButtonAttacks()

--  If you prefer fighters are moving by right clicking empty space
--  uncomment this.
--  FIXME: this option will be renamed
RightButtonMoves()

--  Set the name of the missile to use when clicking
--SetClickMissile("missile-green-cross")

--  Set the name of the missile to use when displaying damage
SetDamageMissile("missile-hit")

SetLeaveStops(true)

--  Edit this to enable/disable grabbing the mouse.
SetGrabMouse(false)

--  Edit this to enable/disable mouse scrolling.
SetMouseScroll(true)
--SetMouseScroll(false)

--  Edit this to enable/disable keyboard scrolling.
SetKeyScroll(true)
--SetKeyScroll(false)

--  Set keyboard scroll speed in frames (1=each frame,2 each second,...)
--SetKeyScrollSpeed(1)

--  Set mouse scroll speed in frames (1=each frame,2 each second,...)
--  This is when the mouse cursor hits the border.
--SetMouseScrollSpeed(1)

--  While middle-mouse is pressed:
--  Pixels to move per scrolled mouse pixel, negative = reversed
SetMouseScrollSpeedDefault(4)

--  Same if Control is pressed
SetMouseScrollSpeedControl(15)

--  Change next, for the wanted double-click delay (in ms).
SetDoubleClickDelay(300)

--  Change next, for the wanted hold-click delay (in ms).
SetHoldClickDelay(1000)

--  Edit this to enable/disable the display of the command keys in buttons.
--SetShowCommandKey(true) this preferences
--SetShowCommandKey(false)

--  Uncomment next, to reveal the complete map.
-- RevealMap()

--  Choose your default fog of war state (enabled #t/disabled #f).
--    disabled is a C&C like fog of war.
SetFogOfWar(false)
-- SetFogOfWar(false)

SetFogOfWarGraphics("tilesets/forest/fog.png")

--  Choose your default for minimap with/without terrain.
SetMinimapTerrain(true)
--SetMinimapTerrain(false)

--  Set Fog of War opacity
SetFogOfWarOpacity(128)

-------------------------------------------------------------------------------

--  Define default resources

-- FIXME: Must be removed: Use and write (define-resource)
--
--  (define-resource 'gold 'name "Gold"
--    'start-resource-default 2000
--    'start-resource-low 2000
--    'start-resource-medium 5000
--    'start-resource-high 10000
--    'income 100)
--  FIXME: Must describe how geting resources work.
--

--[[DefineDefaultResources(
  0, 2000, 1000, 1000, 1000, 1000, 1000)

DefineDefaultResourcesLow(
  0, 2000, 1000, 1000, 1000, 1000, 1000)

DefineDefaultResourcesMedium(
  0, 5000, 2000, 2000, 2000, 2000, 2000)

DefineDefaultResourcesHigh(
  0, 10000, 5000, 5000, 5000, 5000, 5000)]]

DefineDefaultIncomes(
  0, 100, 100, 100, 100, 100, 100)

DefineDefaultActions(
  "stop", "mine", "chop", "drill", "mine", "mine", "mine")

DefineDefaultResourceNames(
  "time", "gold", "wood", "oil", "ore", "stone", "coal")

DefineDefaultResourceAmounts(
  "gold", 100000,
  "oil", 50000)

DefineDefaultResourceMaxAmounts(-1, -1, -1, -1, -1, -1, -1)

-------------------------------------------------------------------------------

-- In WC1 the palette swaps were hard-coded
-- DefinePlayerColorIndex(176, 8) -- This is for orcs
-- DefinePlayerColorIndex(200, 8) -- This is for humans
-- war1tool.c force-moves all references in orc units to human color index
DefinePlayerColorIndex(200, 8) -- This really does nothing

DefinePlayerColors({
     "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
	 "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
     "orange", {{82, 34, 4}, {122, 51, 6}, {143, 60, 7}, {173, 73, 9}, {196, 82, 10}, {224, 94, 11}, {242, 102, 12}, {255, 107, 13}},
     "violet", {{81,34,92}, {93,39,105}, {109,46,122}, {122,51,138}, {138,58,156}, {158,66,178}, {183,77,207}, {213,89,240}},
     "green", {{6,82,25}, {9,117,36}, {11,143,44}, {12,163,50}, {13,181,56}, {15,199,61}, {16,219,68}, {18,240,74}},
     "black", {{0,0,0}, {12,12,11}, {25,25,22}, {39,41,35}, {51,54,45}, {64,66,56}, {76,79,67}, {91,94,80}},
     "white", {{74,75,82}, {88,89,97}, {111,113,122}, {135,136,148}, {160,162,176}, {186,188,204}, {211,213,232}, {232,235,255}},
     "yellow", {{66,66,3}, {78,79,4}, {96,97,5}, {114,115,6}, {129,130,6}, {162,163,8}, {194,196,10}, {232,235,12}},
     "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
	 "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
     "orange", {{82, 34, 4}, {122, 51, 6}, {143, 60, 7}, {173, 73, 9}, {196, 82, 10}, {224, 94, 11}, {242, 102, 12}, {255, 107, 13}},
     "violet", {{81,34,92}, {93,39,105}, {109,46,122}, {122,51,138}, {138,58,156}, {158,66,178}, {183,77,207}, {213,89,240}},
     "green", {{6,82,25}, {9,117,36}, {11,143,44}, {12,163,50}, {13,181,56}, {15,199,61}, {16,219,68}, {18,240,74}},
     "black", {{0,0,0}, {12,12,11}, {25,25,22}, {39,41,35}, {51,54,45}, {64,66,56}, {76,79,67}, {91,94,80}},
     "white", {{74,75,82}, {88,89,97}, {111,113,122}, {135,136,148}, {160,162,176}, {186,188,204}, {211,213,232}, {232,235,255}},
     "yellow", {{66,66,3}, {78,79,4}, {96,97,5}, {114,115,6}, {129,130,6}, {162,163,8}, {194,196,10}, {232,235,12}},
})
-------------------------------------------------------------------------------

SetSpeeds(1)

-------------------------------------------------------------------------------

AStar("fixed-unit-cost", 1000, "moving-unit-cost", 20, "know-unseen-terrain", "unseen-terrain-cost", 2)

-------------------------------------------------------------------------------

--  All player food unit limit
SetAllPlayersUnitLimit(200)
--  All player building limit
SetAllPlayersBuildingLimit(200)
--  All player total unit limit
SetAllPlayersTotalUnitLimit(400)

-------------------------------------------------------------------------------
--  Default triggers for single player
--    (FIXME: must be combined with game types)

function SinglePlayerTriggers()
  AddTrigger(
    function() return GetPlayerData(GetThisPlayer(), "TotalNumUnits") == 0 end,
    function() return ActionDefeat() end)

  AddTrigger(
    function() return GetNumOpponents(GetThisPlayer()) == 0 end,
    function() return ActionVictory() end)
end

-------------------------------------------------------------------------------
--  Tables-Part
-------------------------------------------------------------------------------

Load("preferences.lua")
if (wc1 ~= nil and preferences == nil and wc1.preferences ~= nil) then
  preferences = wc1.preferences
elseif (wc1 == nil or wc1.preferences == nil) then
  if wc1 == nil then wc1 = {} end
  wc1.preferences = preferences
end
if (preferences == nil) then
  preferences = {
    VideoWidth = 640,
    VideoHeight = 400,
    VideoFullScreen = false,
    PlayerName = "Player",
    FogOfWar = false,
    ShowCommandKey = true,
    GroupKeys = "0123456789`",
    GameSpeed = 30,
    EffectsEnabled = true,
    EffectsVolume = 128,
    MusicEnabled = true,
    MusicVolume = 128,
    StratagusTranslation = "",
    GameTranslation = "",
    TipNumber = 0,
    ShowTips = true,
    GrabMouse = false,
    UseOpenGL = false,
    MaxOpenGLTexture = 0,
    CampaignOrc = 1,
    CampaignHuman = 1,
    PlayIntro = true,
    MaxSelection = 4,
    TrainingQueue = false,
    AllowMultipleTownHalls = false,
    AllowTownHallUpgrade = false
  }
end
wc1.preferences = preferences
SetUseOpenGL(preferences.UseOpenGL)
SetVideoResolution(preferences.VideoWidth, preferences.VideoHeight)
SetVideoFullScreen(preferences.VideoFullScreen)
SetMaxOpenGLTexture(preferences.MaxOpenGLTexture)
SetLocalPlayerName(preferences.PlayerName)
SetFogOfWar(preferences.FogOfWar)
UI.ButtonPanel.ShowCommandKey = preferences.ShowCommandKey
SetGroupKeys(preferences.GroupKeys)
SetGameSpeed(preferences.GameSpeed)
SetEffectsEnabled(preferences.EffectsEnabled)
SetEffectsVolume(preferences.EffectsVolume)
SetMusicEnabled(preferences.MusicEnabled)
SetMusicVolume(preferences.MusicVolume)
SetTranslationsFiles(preferences.StratagusTranslation, preferences.GameTranslation)
SetGrabMouse(preferences.GrabMouse)
SetMaxSelectable(preferences.MaxSelection)
SetTrainingQueue(not not preferences.TrainingQueue)


if file_exists("videos", "INTRO.ogv") and preferences.PlayIntro then
   SetTitleScreens(
      {Image = "ui/logo.png",
       Music = "sounds/logo.wav",
       Timeout = 3},
      {Image = "videos/INTRO.ogv",
       Iterations = 1}
   )
   preferences.PlayIntro = false
else
   SetTitleScreens(
      {Image = "ui/logo.png",
       Music = "sounds/logo.wav",
       Timeout = 3}
   )
end


--- Uses Stratagus Library path!
Load("scripts/wc1.lua")

Load("scripts/helpers.lua")

Load("scripts/icons.lua")
Load("scripts/sound.lua")
Load("scripts/missiles.lua")

-- Load the animations for the units.
Load("scripts/anim.lua")
Load("scripts/spells.lua")
Load("scripts/buildings.lua")
Load("scripts/units.lua")
Load("scripts/upgrade.lua")

Load("scripts/fonts.lua")
Load("scripts/buttons.lua")
Load("scripts/ui.lua")
Load("scripts/ai.lua")
Load("scripts/cheats.lua")

print("... ready!\n")
