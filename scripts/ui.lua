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
--      ui.lua - Define the user interface
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

Preference.IconsShift = true

UI.MessageFont = Fonts["game"]
UI.MessageScrollSpeed = 5

Load("scripts/widgets.lua")

local info_panel_x = 2
local info_panel_y = 70
local info_panel_w = 64

local min_damage = Add(Div(ActiveUnitVar("PiercingDamage"),2), Add(Div(ActiveUnitVar("BasicDamage"), 2),1))
local max_damage = Add(ActiveUnitVar("PiercingDamage"), Max(ActiveUnitVar("BasicDamage"), 1))
local function ttlpercent()
   local ttlp = GetUnitVariable(-1, "TTLPercent")
   if ttlp > 0 then
      return 100 - ttlp
   else
      return ttlp
   end
end

UI.InfoPanel.X = info_panel_x
UI.InfoPanel.Y = info_panel_y

local life_bar_off_x = 36
local info_text_off_x = 1

local first_line = {info_text_off_x, 35}
local second_line = {info_text_off_x, 41}
local third_line = {(info_text_off_x * 2) + (info_panel_w / 2) + 7, 35}
local fourth_line = {(info_text_off_x * 2) + (info_panel_w / 2) + 7, 41}

local function MakeCompleteBar(condition, variable)
   return { Pos = {1, 36}, Condition = condition,
            More = {"CompleteBar", {Variable = variable, Width = 61, Height = 7, Color = "green", Border = true}}
   }
end

DefinePanelContents(
   -- Default presentation. ------------------------
   {
      Ident = "panel-general-contents",
      Pos = {info_panel_x, info_panel_y}, DefaultFont = "small",
      Contents = {
         { Pos = {life_bar_off_x, 21}, Condition = {HideAllied = false, ShowOpponent = false, HideNeutral = true},
           More = {"LifeBar", {Variable = "HitPoints", Height = 3, Width = 27, Border = false,
                               Colors = {{75, "green"}, {50, "yellow"}, {25, "orange"}, {0, "red"}}}
           }
         },
         { Pos = {life_bar_off_x, 21}, Condition = {HideAllied = true, ShowOpponent = true, HideNeutral = true},
           More = {"LifeBar", {Variable = "HitPoints", Height = 3, Width = 27, Border = 0x9b9b9b,
                               Colors = {{75, "green"}, {50, "yellow"}, {25, "orange"}, {0, "red"}}}
           }
         },
         { Pos = {info_text_off_x, 26}, More = {"Text", {Text = Line(1, UnitName("Active"), 90, "small"), Font = "game", Centered = false}} },
         -- Ressource Left
         { Pos = first_line, Condition = {ShowOpponent = false, GiveResource = "only"},
           More = {"FormattedText2", {Format = "%s: %d", Variable = "GiveResource", Component1 = "Name", Component2 = "Value"}}
         },
      }
   },
   -- Supply buildings ----------------
   {
      Ident = "panel-supply-building-contents",
      Pos = {info_panel_x, info_panel_y}, DefaultFont = "small",
      Condition = {ShowOpponent = false, HideNeutral = true, Build = "false", Supply = "only", Training = "false", UpgradeTo = "false"},
      Contents = {
         -- Food building
         { Pos = first_line, More = {"Text", {Text = function () return "Supply: " .. GetPlayerData(GetThisPlayer(), "Supply") end }} },
         { Pos = second_line, More = { "Text", {Text = function ()
                                               if GetPlayerData(GetThisPlayer(), "Demand") > GetPlayerData(GetThisPlayer(), "Supply") then
                                                  return "Demand: ~<" .. GetPlayerData(GetThisPlayer(), "Demand") .. "~>"
                                               else
                                                  return "Demand: " .. GetPlayerData(GetThisPlayer(), "Demand")
                                               end
                                 end }}
         }
      }
   },
   -- All own unit -----------------
   {
      Ident = "panel-all-unit-contents",
      Pos = {info_panel_x, info_panel_y},
      DefaultFont = "small",
      Condition = {ShowOpponent = true, HideNeutral = true, Building = "false", Build = "false"},
      Contents = {
         { Pos = first_line,
           More = {"FormattedText2", {Format = "HP:%d/%d", Variable = "HitPoints", Component1 = "Value", Component2 = "Max"}}
         },
         { Pos = second_line, Condition = {ShowOpponent = true, CanAttack = "only"},
           More = {"Text", {Text = Concat("DMG:", String(min_damage), "-", String(max_damage))}}
         },
         { Pos = third_line,
           More = {"Text", {Text = "ARM:", Variable = "Armor", Stat = true}}
         },
         { Pos = fourth_line, Condition = {ShowOpponent = true, CanAttack = "only", AttackRange = "only"},
           More = {"Text", {Text = "RNG:", Variable = "AttackRange" , Stat = true}}
         },
         -- Mana
         { Pos = {36, 10}, Condition = {HideAllied = false, ShowOpponent = true, HideNeutral = true, Mana = "only"},
           More = {"LifeBar", {Variable = "Mana", Height = 3, Width = 27, Border = false, Colors = {{0, "light-blue"}}}}
         },
         { Pos = {36, 10}, Condition = {HideAllied = true, ShowOpponent = true, HideNeutral = true, Mana = "only"},
           More = {"LifeBar", {Variable = "Mana", Height = 3, Width = 27, Border = 0x9b9b9b, Colors = {{0, "light-blue"}}}}
         },
         -- Summoned units
         { Pos = {36, 10},
           More = {"LifeBar", {
                      Variable = {
                         Max = 100,
                         Value = ttlpercent
                      },
                      Height = 3, Width = 27, Border = false,
                      Colors = {{0, "light-blue"}}}}
         },
         -- Resource Carry
         { Pos = second_line, Condition = {CarryResource = "only"},
           More = {"FormattedText2", {Format = "%s: %d", Variable = "CarryResource", Component1 = "Name", Component2 = "Value"}}
         }
      }
   },

   {
      Ident = "panel-building-unit-contents",
      Pos = {info_panel_x, info_panel_y},
      DefaultFont = "small",
      Condition = {ShowOpponent = false, HideNeutral = true},
      Contents = {
         MakeCompleteBar({Build = "only"}, "Build"),
         MakeCompleteBar({Research = "only"}, "Research"),
         MakeCompleteBar({Training = "only"}, "Training"),
         MakeCompleteBar({UpgradeTo = "only"}, "UpgradeTo")
      }
   }
)

DefineSprites({Name = "web", File = "contrib/graphics/missiles/missile-web.png", Offset = {0, 0}, Size = {32, 32}})

DefineDecorations({Index = "Slow", ShowOpponent = true,
  Offset = {-8, -8}, Method = {"static-sprite", {"web", 4}}
})

DefineSprites({
   Name = "sprite-invisible",
   File = "contrib/graphics/missiles/invisibility.png", Offset = {-4, -4}, Size = {25, 25}
})

DefineDecorations({
      Index = "Invisible", ShowOpponent = false,
      Offset = {0, 0},
      Method = {
         "animated-sprite", {"sprite-invisible", 14}
      }
})

DefineSprites({
   Name = "sprite-unholy",
   File = "contrib/graphics/missiles/unholy.png", Offset = {-2, -2}, Size = {20, 20}
})

DefineDecorations({
      Index = "UnholyArmor", ShowOpponent = true,
      Offset = {0, 0},
      Method = {
         "animated-sprite", {"sprite-unholy", 8}
      }
})
DefineSprites({Name = "venom", File = "contrib/graphics/ui/icon-poison.png", Offset = {0, 0}, Size = {4,6}})

DefineDecorations({
   Index = "Poison", ShowOpponent = true,
   Offset = {7, 2},
   Method = 
      {"static-sprite", {"venom", 0}}  
})

DefineSprites({Name = "woundmarker", File = "contrib/graphics/ui/icon-wound.png", Offset = {0, -7}, Size = {5, 6}})

DefineDecorations({Index = "HitPoints", HideNeutral = false, CenterX = true, ShowOpponent=true,
	OffsetPercent = {50, 100}, Method = {"sprite", {"woundmarker"}}})

DefineCursor({
      Name = "cursor-point",
      Race = "any",
      File = "ui/cursors/arrow.png",
      HotSpot = {0, 0},
      Size = {7, 11}})
DefineCursor({
      Name = "cursor-glass",
      Race = "any",
      File = "ui/cursors/magnifying_glass.png",
      HotSpot = {5, 5},
      Size = {14, 14}})
DefineCursor({
      Name = "cursor-green-hair",
      Race = "any",
      File = "ui/cursors/small_green_crosshair.png",
      HotSpot = {4, 4},
      Size = {9, 9}})
DefineCursor({
      Name = "cursor-yellow-hair",
      Race = "any",
      File = "ui/cursors/yellow_crosshair.png",
      HotSpot = {7, 5},
      Size = {15, 11}})
DefineCursor({
      Name = "cursor-red-hair",
      Race = "any",
      File = "ui/cursors/red_crosshair.png",
      HotSpot = {7, 5},
      Size = {15, 11}})
DefineCursor({
      Name = "cursor-cross",
      Race = "any",
      File = "ui/cursors/small_green_crosshair.png",
      HotSpot = { 4,  4},
      Size = {9, 9}})
DefineCursor({
      Name = "cursor-scroll", -- Not present for wc1
      Race = "any",
      File = "ui/cursors/small_green_crosshair.png",
      HotSpot = { 4,  4},
      Size = {9, 9}})
DefineCursor({
      Name = "cursor-arrow-e",
      Race = "any",
      File = "ui/cursors/right_arrow.png",
      HotSpot = {11, 5},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-ne",
      Race = "any",
      File = "ui/cursors/upper_right_arrow.png",
      HotSpot = {10,  1},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-n",
      Race = "any",
      File = "ui/cursors/up_arrow.png",
      HotSpot = {6,  1},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-nw",
      Race = "any",
      File = "ui/cursors/upper_left_arrow.png",
      HotSpot = { 1,  1},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-w",
      Race = "any",
      File = "ui/cursors/left_arrow.png",
      HotSpot = { 2, 5},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-s",
      Race = "any",
      File = "ui/cursors/down_arrow.png",
      HotSpot = {6, 11},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-sw",
      Race = "any",
      File = "ui/cursors/lower_left_arrow.png",
      HotSpot = { 1, 9},
      Size = {16, 16}})
DefineCursor({
      Name = "cursor-arrow-se",
      Race = "any",
      File = "ui/cursors/lower_right_arrow.png",
      HotSpot = {10, 9},
      Size = {16, 16}})

local function AddFiller(file, x, y, resize_x, resize_y)
   if CanAccessFile(file) == true then
      local b = CFiller:new_local()
      b.G = CGraphic:New(file)
      b.G:Load()
      b.G:Resize(resize_x, resize_y)
      b.X = x
      b.Y = y
      UI.Fillers:push_back(b)
   end
end

function MakeButton(x, y)
   local b = CUIButton:new()
   b.X = x
   b.Y = y
   b.Style = FindButtonStyle("icon")
   return b
end

UI.NormalFontColor = "white";
UI.ReverseFontColor = "yellow";

-- gold
UI.Resources[1].G = CGraphic:New("ui/gold_icon_1.png", 13, 6)
UI.Resources[1].IconFrame = 0
UI.Resources[1].IconX = Video.Width - 137 - 9
UI.Resources[1].IconY = 1
UI.Resources[1].TextX = Video.Width - 129 - 9 - 40
UI.Resources[1].TextY = 1
UI.Resources[1].Font = Fonts["game"]

-- wood
UI.Resources[2].G = CGraphic:New("ui/lumber_icon_1.png", 9, 9)
UI.Resources[2].IconFrame = 0
UI.Resources[2].IconX = Video.Width - 33 - 13 - 13
UI.Resources[2].IconY = 0
UI.Resources[2].TextX = Video.Width - 33 - 13 - 40
UI.Resources[2].TextY = 1
UI.Resources[2].Font = Fonts["game"]

-- mana -- no good icon, but we need this for the info bar
UI.Resources[ManaResCost].G = CGraphic:New("contrib/graphics/ui/mana_icon_1.png", 9,9)
UI.Resources[ManaResCost].IconFrame = 0
UI.Resources[ManaResCost].IconX = -50
UI.Resources[ManaResCost].IconY = -50
UI.Resources[ManaResCost].TextX = UI.Resources[2].TextX
UI.Resources[ManaResCost].TextY = UI.Resources[2].TextY

UI.SingleSelectedButton = MakeButton(info_panel_x + 4, info_panel_y + 4)

UI.SelectedButtons:clear()
for i = 1,4,1 do
   local x = 4
   if i % 2 == 0 then
      x = 37
   end
   local y = 70
   if i <= 2 then
      y = y + 3
   else
      y = y + 26
   end
   UI.SelectedButtons:push_back(MakeButton(x, y))
end

UI.LifeBarColorNames:clear()
UI.LifeBarColorNames:push_back("green")
UI.LifeBarColorNames:push_back("yellow")
UI.LifeBarColorNames:push_back("orange")
UI.LifeBarColorNames:push_back("red")
UI.LifeBarYOffset = -3
UI.LifeBarBorder = false
UI.LifeBarPadding = 2

UI.MaxSelectedFont = Fonts["game"]
UI.MaxSelectedTextX = info_panel_x + 5
UI.MaxSelectedTextY = info_panel_y + 5

--

local button_panel_off_x_1 = 4
local button_panel_off_x_2 = 37
local button_panel_off_y_1 = 120 + 23 * 0
local button_panel_off_y_2 = 120 + 23 * 1
local button_panel_off_y_3 = 120 + 23 * 2
local button_panel_off_y_4 = 120 + 23 * 3

local function MakeBuildingButton(index)
   return MakeButton(button_panel_off_x_1 + (index * 5), button_panel_off_y_4)
end

UI.SingleTrainingButton = MakeBuildingButton(0)
UI.TrainingButtons:clear()
for i=0,5,1 do
   UI.TrainingButtons:push_back(MakeBuildingButton(i))
end

UI.UpgradingButton = MakeBuildingButton(0)
UI.ResearchingButton = MakeBuildingButton(0)

--

UI.CompletedBarColorRGB = CColor(48, 100, 4)
UI.CompletedBarShadow = true

UI.ButtonPanel.Buttons:clear()
for i = 0,5,1 do
   local x = 4
   if (i + 1) % 2 == 0 then
      x = 37
   end
   local y = 120 + (23 * math.floor(i / 2))
   UI.ButtonPanel.Buttons:push_back(MakeButton(x, y))
end

UI.ButtonPanel.X = 0
UI.ButtonPanel.Y = 150
UI.ButtonPanel.AutoCastBorderColorRGB = CColor(0, 0, 252)

UI.MapArea.X = 72
UI.MapArea.Y = 8
UI.MapArea.EndX = Video.Width - 8 - 1
UI.MapArea.EndY = Video.Height - 8 - 1

UI.Minimap.X = 3
UI.Minimap.Y = 6
UI.Minimap.W = 64
UI.Minimap.H = 64

UI.StatusLine.TextX = 1 + 88
UI.StatusLine.TextY = Video.Height + 1 - 8
UI.StatusLine.Width = Video.Width - 8 - 1 - 88
UI.StatusLine.Font = Fonts["game"]

UI.MenuButton.X = 3
UI.MenuButton.Y = Video.Height - math.floor(16 * (Video.Height - UI.Minimap.H) / (240 - UI.Minimap.H))
UI.MenuButton.Text = "            "
UI.MenuButton.Style = FindButtonStyle("main")
UI.MenuButton:SetCallback(
   function()
      if (Editor.Running == EditorNotRunning) then
	 RunGameMenu()
      else
	 RunInEditorMenu()
      end
end)


UI.NetworkMenuButton.X = 3
UI.NetworkMenuButton.Y = 1
UI.NetworkMenuButton.Text = "Menu"
UI.NetworkMenuButton.Style = FindButtonStyle("network")
UI.NetworkMenuButton:SetCallback(function() RunGameMenu() end)

UI.NetworkDiplomacyButton.X = 45
UI.NetworkDiplomacyButton.Y = 1
UI.NetworkDiplomacyButton.Text = "Diplomacy"
UI.NetworkDiplomacyButton.Style = FindButtonStyle("network")
UI.NetworkDiplomacyButton:SetCallback(function() RunDiplomacyMenu() end)

UI.EditorSettingsAreaTopLeft.x = UI.InfoPanel.X
UI.EditorSettingsAreaTopLeft.y = UI.InfoPanel.Y
UI.EditorSettingsAreaBottomRight.x = UI.MapArea.X
UI.EditorSettingsAreaBottomRight.y = UI.ButtonPanel.Y

UI.EditorButtonAreaTopLeft.x = UI.ButtonPanel.X
UI.EditorButtonAreaTopLeft.y = UI.ButtonPanel.Y
UI.EditorButtonAreaBottomRight.x = UI.MapArea.X
UI.EditorButtonAreaBottomRight.y = UI.MenuButton.Y

function LoadUI(race, screen_width, screen_height)
   currentRace = race
   Load("scripts/widgets.lua")
   UI.Fillers:clear()
   AddFiller("ui/" .. race .. "/minimap.png", 0, 0, 72, 72)
   AddFiller("ui/" .. race .. "/left_panel.png", 0, 72, 72, Video.Height - (200 - 128))
   AddFiller("contrib/graphics/ui/" .. race .. "/top_resource_bar.png", 72, 0, Video.Width - (320 - 240), 12)
   AddFiller("ui/" .. race .. "/right_panel.png", Video.Width - 8, 0, 8, Video.Height)
   AddFiller("ui/" .. race .. "/bottom_panel.png", 72, Video.Height - 12, Video.Width - (320 - 240), 12)

   UI.InfoPanel.G = CGraphic:New("ui/" .. race .. "/icon_selection_boxes.png", 66, 46)
   
   Preference.IconFrameG = CGraphic:New("ui/" .. race .. "/icon_border.png", 31, 24)
   Preference.PressedIconFrameG = CGraphic:New("ui/" .. race .. "/icon_border.png", 31, 24)

   local ui = {
      "info-panel", {
         "panels", {"panel-general-contents", "panel-attack-unit-contents",
                    "panel-all-unit-contents", "panel-building-contents"},
         "completed-bar", {
            "color", {48, 100, 4}
                          }
                    }
   }
end

-- Popups
PopupFont = nil
PopupFont = "small"
local GetRGBA = function(r, g, b, a)
   return b + g*0x100 + r*0x10000 + a*0x1000000
end
local PopupBackgroundColor = GetRGBA(0,32,96, 208)
local PopupBorderColor = GetRGBA(192,192,255, 160)

if (wc1.preferences.ShowButtonPopups) then
   local OldDefineButton = DefineButton
   DefineButton = function(spec)
      if spec.Popup == nil then
         spec.Popup = "popup"
      end
      return OldDefineButton(spec)
   end
   DefinePopup({
         Ident = "popup",
         BackgroundColor = PopupBackgroundColor,
         BorderColor = PopupBorderColor,
         Contents = {
            { 	Margin = {1, 1}, HighlightColor = "yellow",
                More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
            },
            -- Move  hint
            { 	Margin = {1, 1}, Condition = {ButtonAction = "move"},
                More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
            },
            { 	Condition = {ButtonAction = "move"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
                More = {"Text", {Text = _("~<ALT~>-click to defend unit."), MaxWidth = Video.Width / 5, Font = PopupFont}}
            },
            { 	Condition = {ButtonAction = "move"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
                More = {"Text", {Text = _("~<SHIFT~>-click to make waypoints."), MaxWidth = Video.Width / 5, Font = PopupFont}}
            },
            -- Repair hint
            { 	Margin = {1, 1}, Condition = {ButtonAction = "repair"},
                More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
            },
            { 	Condition = {ButtonAction = "repair"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
                More = {"Text", {Text = _("~<CTRL~>-click to toggle auto-repair of damaged buildings."), MaxWidth = Video.Width / 5, Font = PopupFont}}
            },
            -- buildings, units, upgrades
            { 	Condition = {ButtonAction = "build"},
                More = {"Costs"}, HighlightColor = "red",
            },
            { 	Condition = {ButtonAction = "train-unit"},
                More = {"Costs"}, HighlightColor = "red",
            },
            { 	Condition = {ButtonAction = "research"},
                More = {"Costs"}, HighlightColor = "red",
            },
            { 	Condition = {ButtonAction = "upgrade-to"},
                More = {"Costs"}, HighlightColor = "red",
            },
            { 	Condition = {ButtonAction = "cast-spell"},
                More = {"Costs"}, HighlightColor = "red",
            },
            -- Multi-build hint
            { 	Margin = {1, 1}, Condition = {ButtonAction = "build"},
                More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
            },
            { 	Condition = {ButtonAction = "build"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
                More = {"Text", {Text = _("~<SHIFT~>-click to create a building queue."), MaxWidth = Video.Width / 5, Font = PopupFont}}
            },
            -- Auto-cast hint
            { 	Margin = {1, 1}, Condition = {ButtonAction = "cast-spell"},
                More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
            },
            { 	Condition = {ButtonAction = "cast-spell"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
                More = {"Text", {Text = _("~<CTRL~>-click to toggle auto-cast ability."), MaxWidth = Video.Width / 5, Font = PopupFont}}
            },
            -- Description
            { 	Margin = {1, 1}, Condition = {HasDescription = true},
                More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
            },
            { 	Condition = {HasDescription = true}, Margin = {1, 1}, HighlightColor = "red",
                More = {"ButtonInfo", {InfoType = "Description", MaxWidth = Video.Width / 5, Font = PopupFont}}
            },

         }
   })
end
