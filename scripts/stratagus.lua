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

--  Enter your default title screen.

SetTitleScreens(
  {Image = "ui/logo.png",
   Music = "sounds/logo.wav",
   Timeout = 3},
  {Image = "videos/hintro1.avi",
   Music = "sounds/intro_1.wav",
   Iterations = 1},
  {Image = "videos/hintro2.avi",
   Music = "sounds/intro_2.wav",
   Iterations = 10},
  {Image = "videos/ointro1.avi",
   Music = "sounds/intro_3.wav",
   Iterations = 1},
  {Image = "videos/ointro2.avi",
   Iterations = 10},
  {Image = "videos/ointro3.avi",
   Music = "sounds/intro_door.wav",
   Iterations = 1},
  {Image = "videos/cave1.avi",
   Music = "sounds/intro_4.wav",
   Iterations = 1},
  {Image = "videos/cave2.avi",
   Iterations = 3},
  {Image = "videos/cave3.avi",
   Music = "sounds/intro_5.wav",
   Iterations = 1},
  {Image = "videos/title.avi",
   Iterations = 1}
)


--  Enter your menu music.
--SetMenuMusic("music/default.mod")
SetTitleScreens(
   {Music = "music/default.mod"}
)

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


SetSelectionStyle("corners")
Preference.ShowSightRange = false
Preference.ShowAttackRange = false
Preference.ShowReactionRange = false

Preference.ShowOrders = 2

--  Enable/disable the short display of the orders after command.
--  FIXME: planned
--(set-order-feedback! #t)
--(set-order-feedback! #f)

--              file              hotx hoty width height
--ManaSprite("ui/mana.png", -7, -7, 7, 7)
--DefineSprites({Name = "sprite-mana", File = "ui/mana2.png", Offset = {0, -1}, Size = {31, 4}})
--HealthSprite("ui/health.png", 1, -7, 7, 7)
--DefineSprites({Name = "sprite-health", File = "ui/health.png", Offset = {0, -4}, Size = {31, 4}})

--ShowHealthBar()
--ShowHealthVertical()
--ShowHealthHorizontal()
--DefineDecorations({Index = "HitPoints", HideNeutral = true, CenterX = true, OffsetPercent = {50, 100}, Method = {"sprite", {"sprite-health"}}})

--ShowManaBar()
--ShowManaVertical()
--ShowManaHorizontal()
--DefineDecorations({Index = "HitPoints", HideNeutral = true, CenterX = true, OffsetPercent = {50, 100}, Method = {"sprite", {"sprite-mana"}}})

--ShowNoFull() this
--ShowFull()


--  Uncomment next, to show energy bars and dots only for selected units
--(show-energy-selected-only)

--  Uncomment next, to show bars and dots always on top.
--  FIXME: planned feature
--DecorationOnTop() this

--  Define shadow-sprite.
--
--  (shadow-sprite file hotx hoty width height)
--
--ShadowSprite("missiles/unit_shadow.png", 3, 42, 32, 32)
--DefineSprites({Name = "sprite-spell", File = "ui/bloodlust,haste,slow,invisible,shield.png", Offset = {1, 1}, Size = {16, 16}})

--  Uncomment next, to enable fancy building (random mirroring buildings)
--SetFancyBuildings(true) this
--SetFancyBuildings(false)

--  Edit this to enable/disable show tips at the start of a level
--SetShowTips(true) this

-------------------------------------------------------------------------------
--  Game modification

--  Edit this to enable/disable extended features.
--    Currently enables some additional buttons.
extensions = true
--extensions = false

--  Edit this to enable/disable the training queues.
SetTrainingQueue(true)
--SetTrainingQueue(false)

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

--  Edit this to enable/disable grabbing the mouse.
SetGrabMouse(false)

--  Edit this to enable/disable stopping scrolling on mouse leave.
SetLeaveStops(true)

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
RevealMap()

--  Choose your default fog of war state (enabled #t/disabled #f).
--    disabled is a C&C like fog of war.
SetFogOfWar(false)
--SetFogOfWar(false)

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

-------------------------------------------------------------------------------

DefinePlayerColorIndex(208, 4)

DefinePlayerColors({
  "red", {{164, 0, 0}, {124, 0, 0}, {92, 4, 0}, {68, 4, 0}},
  "blue", {{12, 72, 204}, {4, 40, 160}, {0, 20, 116}, {0, 4, 76}},
  "green", {{44, 180, 148}, {20, 132, 92}, {4, 84, 44}, {0, 40, 12}},
  "violet", {{152, 72, 176}, {116, 44, 132}, {80, 24, 88}, {44, 8, 44}},
  "orange", {{248, 140, 20}, {200, 96, 16}, {152, 60, 16}, {108, 32, 12}},
  "black", {{40, 40, 60}, {28, 28, 44}, {20, 20, 32}, {12, 12, 20}},
  "white", {{224, 224, 224}, {152, 152, 180}, {84, 84, 128}, {36, 40, 76}},
  "yellow", {{252, 252, 72}, {228, 204, 40}, {204, 160, 16}, {180, 116, 0}},
  "red", {{164, 0, 0}, {124, 0, 0}, {92, 4, 0}, {68, 4, 0}},
  "blue", {{12, 72, 204}, {4, 40, 160}, {0, 20, 116}, {0, 4, 76}},
  "green", {{44, 180, 148}, {20, 132, 92}, {4, 84, 44}, {0, 40, 12}},
  "violet", {{152, 72, 176}, {116, 44, 132}, {80, 24, 88}, {44, 8, 44}},
  "orange", {{248, 140, 20}, {200, 96, 16}, {152, 60, 16}, {108, 32, 12}},
  "black", {{40, 40, 60}, {28, 28, 44}, {20, 20, 32}, {12, 12, 20}},
  "white", {{224, 224, 224}, {152, 152, 180}, {84, 84, 128}, {36, 40, 76}},
  "yellow", {{252, 252, 72}, {228, 204, 40}, {204, 160, 16}, {180, 116, 0}},
})
-------------------------------------------------------------------------------

SetSpeeds(1)

-------------------------------------------------------------------------------

AStar("fixed-unit-cost", 1000, "moving-unit-cost", 20, "know-unseen-terrain", "unseen-terrain-cost", 2)

-------------------------------------------------------------------------------

--  Maximum number of selectable units
SetMaxSelectable(4)

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

if (preferences == nil) then
  preferences = {
    VideoWidth = 640,
    VideoHeight = 400,
    VideoFullScreen = false,
    PlayerName = "Player",
    FogOfWar = true,
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
    CampaignOrcX = 1,
    CampaignHumanX = 1,
  }
end

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

--- Uses Stratagus Library path!
Load("scripts/wc1.lua")

--Load("scripts/tilesets.lua")
Load("scripts/icons.lua")
--Load("scripts/sound.lua")
Load("scripts/missiles.lua")
Load("scripts/constructions.lua")
--Load("scripts/spells.lua")
Load("scripts/units.lua")
--Load("scripts/upgrade.lua")
Load("scripts/fonts.lua")
Load("scripts/buttons.lua")
Load("scripts/ui.lua")
Load("scripts/ai.lua")
--Load("scripts/campaigns.lua")
--Load("scripts/tips.lua")
--Load("scripts/ranks.lua")
--Load("scripts/menus.lua")
--Load("scripts/cheats.lua")

print("... ready!\n")
