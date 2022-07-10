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
wc1 = war1gus
war1gus.Name = "War1gus"
war1gus.Version = "3.2.1"
war1gus.Homepage = "https://github.com/Wargus/war1gus"
war1gus.Licence = "GPL v2"
war1gus.Copyright = "(c) 1998-2021 by The Stratagus Project"

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

OnTilesetChangeFunctions = {}
function OnTilesetChangeFunctions:add(f)
  table.insert(self, f)
end

function InitGameVariables()
  for i=1,table.getn(InitFuncs) do
    InitFuncs[i]()
  end
end

MapLoadedFuncs = {}
function MapLoadedFuncs:add(f)
   table.insert(self, f)
end

function MapLoaded()
   for i=1,#MapLoadedFuncs do
      MapLoadedFuncs[i]()
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

SetColorCycleSpeed(10)

SetSelectionStyle("rectangle")
Preference.ShowSightRange = false
Preference.ShowAttackRange = false
Preference.ShowReactionRange = false
Preference.ShowNoSelectionStats = false
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
SetRevealAttacker(true)

--  Edit this to set the type of revelation when a player lost their last main facility
--SetRevelationType("no-revelation")
--SetRevelationType("buildings-only")
SetRevelationType("all-units")

SetFogOfWarBlur(2.0, 1.5, 3) -- radiuses for simple and bilinear FOW postprocessing, number of blur iterations

-- Set opacity levels of fog for explored, "known"(when map revealed) and hidden tiles
SetFogOfWarOpacityLevels(0x7F, 0xBE, 0xFE)

-- Set opacity levels of fog for explored, "known"(when map revealed) and hidden tiles in the minimap
SetMMFogOfWarOpacityLevels(0x55, 0xAA, 0xFF) -- default values

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
SetClickMissile("missile-grey-cross")

--  Set the name of the missile to use when displaying damage
SetDamageMissile("missile-hit")

SetLeaveStops(true)

ResourcesMultiBuildersMultiplier(1)

--  Edit this to enable/disable grabbing the mouse.
SetGrabMouse(false)

--  Edit this to enable/disable mouse scrolling.
SetMouseScroll(true)
--SetMouseScroll(false)

--  Edit this to enable/disable keyboard scrolling.
SetKeyScroll(true)
--SetKeyScroll(false)

--  Set keyboard scroll speed in frames (1=each frame,2 each second,...)
SetKeyScrollSpeed(8)

--  Set mouse scroll speed in pixels per frame
--  This is when the mouse cursor hits the border.
SetMouseScrollSpeed(4)

--  While middle-mouse is pressed:
--  Pixels to move per scrolled mouse pixel, negative = reversed
SetMouseScrollSpeedDefault(1)

--  Same if Control is pressed
SetMouseScrollSpeedControl(2)

--  Change next, for the wanted double-click delay (in ms).
SetDoubleClickDelay(300)

--  Change next, for the wanted hold-click delay (in ms).
SetHoldClickDelay(1000)

--  Edit this to enable/disable the display of the command keys in buttons.
--SetShowCommandKey(true) this preferences
--SetShowCommandKey(false)

--  Choose your default fog of war state (enabled #t/disabled #f).
--    disabled is a C&C like fog of war.
SetFogOfWar(true)
-- SetFogOfWar(false)

SetTileSize(16, 16)
SetFogOfWarGraphics("tilesets/forest/fog.png")

--  Choose your default for minimap with/without terrain.
SetMinimapTerrain(true)
--SetMinimapTerrain(false)


-- Make grayscale icons for cooldown
Preference.GrayscaleIcons = true

SetFontCodePage(20127) -- 7-bit ascii only

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
   "time", _("gold"), _("wood"), _("lumber"), _("treasure"), "ore", "stone")

DefineDefaultResourceAmounts(
   _("gold"), 100000,
   _("wood"), 100,
   _("lumber"), 50000,
   _("treasure"), 5000)

DefineDefaultResourceMaxAmounts(-1, -1, -1, -1, -1, -1, -1)

-------------------------------------------------------------------------------

SetSpeeds(1)

-------------------------------------------------------------------------------

AStar("fixed-unit-cost", 1000, "moving-unit-cost", 20, "know-unseen-terrain", "unseen-terrain-cost", 2)

-------------------------------------------------------------------------------

--  All player food unit limit
SetAllPlayersUnitLimit(400)
--  All player building limit
SetAllPlayersBuildingLimit(400)
--  All player total unit limit
SetAllPlayersTotalUnitLimit(1000)

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
if wc1 == nil then wc1 = {} end
preferences = wc1.preferences
if (preferences == nil) then
  preferences = {}
end
local DefaultPreference = function(name, value)
    if preferences[name] == nil then
        preferences[name] = value
    end
end
DefaultPreference("VideoWidth", 480)
DefaultPreference("VideoHeight", 300)
DefaultPreference("VideoShader", "none")
DefaultPreference("VideoFullScreen", true)
DefaultPreference("PlayerName", "Player")
DefaultPreference("FogOfWar", true)
DefaultPreference("ShowCommandKey", true)
DefaultPreference("GroupKeys", "0123456789`")
DefaultPreference("GameSpeed", 75)
DefaultPreference("EffectsEnabled", true)
DefaultPreference("EffectsVolume", 128)
DefaultPreference("MusicEnabled", true)
DefaultPreference("MusicVolume", 128)
DefaultPreference("StratagusTranslation", "")
DefaultPreference("GameTranslation", "")
DefaultPreference("TipNumber", 0)
DefaultPreference("ShowTips", true)
DefaultPreference("GrabMouse", false)
DefaultPreference("CampaignOrc", 1)
DefaultPreference("CampaignHuman", 1)
DefaultPreference("PlayIntro", true)
DefaultPreference("MaxSelection", 50)
DefaultPreference("TrainingQueue", true)
DefaultPreference("AllowMultipleTownHalls", true)
DefaultPreference("AllowTownHallUpgrade", false)
DefaultPreference("MultiColoredCampaigns", true)
DefaultPreference("ShowButtonPopups", true)
DefaultPreference("ShowDamage", true)
DefaultPreference("ShowOrders", false)
DefaultPreference("OnlineServer", "network.stratagus.de")
DefaultPreference("OnlinePort", 6112)
DefaultPreference("SimplifiedAutoTargeting", true)
DefaultPreference("FogOfWarType", "fast")      -- "enhanced", "tiled" or "fast". Tiled and fast types of FOW don't work with shadow casting FOV.
DefaultPreference("FogOfWarBilinear", false)       -- Enable/Disable bilinear filtration for fog of war
DefaultPreference("DungeonSightBlocking", true)    -- Enable/Disable sight blocking in the dungeons
DefaultPreference("FieldOfViewType", "simple-radial")    -- default field of view type (possibe values: "simple-radial" and "shadow-casting" )
DefaultPreference("RebalancedStats", true)
DefaultPreference("OriginalPixelRatio", true)

wc1.preferences = preferences

function StoreSharedSettingsInBits(settings)
   settings:SetUserGameSetting(0, preferences.AllowMultipleTownHalls)
   settings:SetUserGameSetting(1, preferences.AllowTownHallUpgrade)
   settings:SetUserGameSetting(2, preferences.DungeonSightBlocking)
   settings:SetUserGameSetting(3, preferences.TrainingQueue)
   settings:SetUserGameSetting(4, preferences.RebalancedStats)
end

function RestoreSharedSettingsFromBits(settings, errorCb)
   if settings:GetUserGameSetting(0) then
      if not preferences.AllowMultipleTownHalls then
         preferences.AllowMultipleTownHalls = true
         Load("scripts/buttons.lua")
         Load("scripts/buildings.lua")
         if preferences.RebalancedStats then
            Load("scripts/balancing.lua")
         end
      end
   else
      if preferences.AllowMultipleTownHalls then
         preferences.AllowMultipleTownHalls = false
         Load("scripts/buttons.lua")
         Load("scripts/buildings.lua")
         if preferences.RebalancedStats then
            Load("scripts/balancing.lua")
         end
      end
   end
   preferences.AllowTownHallUpgrade = settings:GetUserGameSetting(1)
   preferences.DungeonSightBlocking = settings:GetUserGameSetting(2)
   preferences.TrainingQueue = settings:GetUserGameSetting(3)
   if settings:GetUserGameSetting(4) then
      if not preferences.RebalancedStats then
         Load("scripts/balancing.lua")
         preferences.RebalancedStats = true
      end
   else
      if preferences.RebalancedStats then
         if errorCb then
            errorCb("Rebalanced stats must be disabled manually and the game restartet to continue")
         end
      end
   end
end

MapLoadedFuncs:add(function()
   RestoreSharedSettingsFromBits(GameSettings, function(s)
      print("ERROR RESTORING GAME SETTINGS! " .. s)
   end)
end)

InitFuncs:add(function()
   StoreSharedSettingsInBits(GameSettings)
end)

SetVideoResolution(preferences.VideoWidth, preferences.VideoHeight)
local pixelScale = 1.0
if preferences.OriginalPixelRatio then
   pixelScale = 1.2
end
if preferences.VideoWidth < 640 then
   SetWindowSize(preferences.VideoWidth * 2, preferences.VideoHeight * 2 * pixelScale)
end
-- WC1 uses non-square pixels: graphics are 320x200, but rendered 320x240
SetVerticalPixelSize(pixelScale)

SetVideoFullScreen(preferences.VideoFullScreen)
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
Preference.SF2Soundfont = "music/TimGM6mb.sf2"
Preference.PauseOnLeave = false
if preferences.ShowDamage == true then
   SetDamageMissile("missile-hit")
else
   SetDamageMissile(nil)
end
if preferences.ShowOrders == true then
   Preference.ShowOrders = 1
else
   Preference.ShowOrders = 0
end
Preference.SimplifiedAutoTargeting = preferences.SimplifiedAutoTargeting
SetFieldOfViewType(preferences.FieldOfViewType)
SetFogOfWarType(preferences.FogOfWarType)
SetFogOfWarBilinear(preferences.FogOfWarBilinear)
Preference.HardwareCursor = preferences.HardwareCursor or false

if preferences.PlayIntro == true then
   if file_exists("videos", "hintro.ogv") and file_exists("videos", "ointro.ogv") and file_exists("videos", "cave.ogv") and file_exists("videos", "title.ogv") then
      SetTitleScreens(
         {Image = "ui/logo.png",
          Music = "sounds/logo.wav",
          Timeout = 3},
         {Image = "videos/hintro.ogv",
          Iterations = 1},
         {Image = "videos/ointro.ogv",
          Iterations = 1},
         {Image = "videos/cave.ogv",
          Iterations = 1},
         {Image = "videos/title.ogv",
          Iterations = 1}
      )
   elseif file_exists("videos", "intro.ogv") then
      SetTitleScreens(
         {Image = "ui/logo.png",
          Music = "sounds/logo.wav",
          Timeout = 3},
         {Image = "videos/intro.ogv",
          Iterations = 1}
      )
   else
      SetTitleScreens(
         {Image = "ui/logo.png",
          Music = "sounds/logo.wav",
          Timeout = 3}
      )
   end
else
   SetTitleScreens(
	  {Image = "ui/logo.png",
	   Music = "sounds/logo.wav",
	   Timeout = 3}
   )
end

--- Uses Stratagus Library path!
Load("scripts/wc1.lua")
Load("scripts/wc1-config.lua")
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
Load("scripts/ui.lua")
Load("scripts/buttons.lua")
Load("scripts/ai.lua")
Load("scripts/cheats.lua")
Load("scripts/colors.lua")
Load("scripts/commands.lua")

if preferences.RebalancedStats then
   Load("scripts/balancing.lua")
end

print("... ready!\n")
