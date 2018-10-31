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

local info_panel_x = 4
local info_panel_y = 140
local info_panel_w = 128

local min_damage = Div(ActiveUnitVar("PiercingDamage"), 2)
local max_damage = Add(ActiveUnitVar("PiercingDamage"), ActiveUnitVar("BasicDamage"))

UI.InfoPanel.X = info_panel_x
UI.InfoPanel.Y = info_panel_y

local life_bar_off_x = 71
local info_text_off_x = 6

local first_line = {info_text_off_x, 72}
local second_line = {info_text_off_x, 82}
local third_line = {(info_text_off_x * 2) + (info_panel_w / 2) + 2, 72}
local fourth_line = {(info_text_off_x * 2) + (info_panel_w / 2) + 2, 82}

local function MakeCompleteBar(condition, variable)
   return { Pos = {2, 72}, Condition = condition,
            More = {"CompleteBar", {Variable = variable, Width = 124, Height = 14, Color = "green", Border = true}}
   }
end

DefinePanelContents(
   -- Default presentation. ------------------------
   {
      Ident = "panel-general-contents",
      Pos = {info_panel_x, info_panel_y}, DefaultFont = "small",
      Contents = {
         { Pos = {life_bar_off_x, 41}, Condition = {ShowOpponent = true, HideNeutral = false},
           More = {"LifeBar", {Variable = "HitPoints", Height = 6, Width = 54, Border = false,
                               Colors = {{75, "green"}, {50, "yellow"}, {25, "orange"}, {0, "red"}}}
           }
         },
         { Pos = {info_text_off_x, 52}, More = {"Text", {Text = UnitName("Active"), Font = "game", Centered = false}} },
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
      Condition = {ShowOpponent = false, HideNeutral = true, Building = "false", Build = "false"},
      Contents = {
         { Pos = first_line,
           More = {"FormattedText2", {Format = "HP:%d/%d", Variable = "HitPoints", Component1 = "Value", Component2 = "Max"}}
         },
         { Pos = second_line, Condition = {CanAttack = "only"},
           More = {"Text", {Text = Concat("DMG:", String(min_damage), "-", String(max_damage))}}
         },
         { Pos = third_line,
           More = {"Text", {Text = "ARM:", Variable = "Armor", Stat = true}}
         },
         { Pos = fourth_line, Condition = {CanAttack = "only", AttackRange = "only"},
           More = {"Text", {Text = "RNG:", Variable = "AttackRange" , Stat = true}}
         },
         -- Mana
         { Pos = {71, 19}, Condition = {Mana = "only"},
           More = {"LifeBar", {Variable = "Mana", Height = 6, Width = 54, Border = false, Colors = {{0, "light-blue"}}}}
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

DefineCursor({
      Name = "cursor-point",
      Race = "any",
      File = "ui/cursors/arrow.png",
      HotSpot = {0, 0},
      Size = {14, 22}})
DefineCursor({
      Name = "cursor-glass",
      Race = "any",
      File = "ui/cursors/magnifying_glass.png",
      HotSpot = {11, 11},
      Size = {28, 28}})
DefineCursor({
      Name = "cursor-green-hair",
      Race = "any",
      File = "ui/cursors/small_green_crosshair.png",
      HotSpot = {8, 8},
      Size = {18, 18}})
DefineCursor({
      Name = "cursor-yellow-hair",
      Race = "any",
      File = "ui/cursors/yellow_crosshair.png",
      HotSpot = {14, 10},
      Size = {30, 22}})
DefineCursor({
      Name = "cursor-red-hair",
      Race = "any",
      File = "ui/cursors/red_crosshair.png",
      HotSpot = {14, 10},
      Size = {30, 22}})
DefineCursor({
      Name = "cursor-cross",
      Race = "any",
      File = "ui/cursors/small_green_crosshair.png",
      HotSpot = { 8,  8},
      Size = {18, 18}})
DefineCursor({
      Name = "cursor-scroll", -- Not present for wc1
      Race = "any",
      File = "ui/cursors/small_green_crosshair.png",
      HotSpot = { 8,  8},
      Size = {18, 18}})
DefineCursor({
      Name = "cursor-arrow-e",
      Race = "any",
      File = "ui/cursors/right_arrow.png",
      HotSpot = {23, 10},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-ne",
      Race = "any",
      File = "ui/cursors/upper_right_arrow.png",
      HotSpot = {21,  2},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-n",
      Race = "any",
      File = "ui/cursors/up_arrow.png",
      HotSpot = {12,  2},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-nw",
      Race = "any",
      File = "ui/cursors/upper_left_arrow.png",
      HotSpot = { 2,  2},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-w",
      Race = "any",
      File = "ui/cursors/left_arrow.png",
      HotSpot = { 4, 10},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-s",
      Race = "any",
      File = "ui/cursors/down_arrow.png",
      HotSpot = {12, 23},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-sw",
      Race = "any",
      File = "ui/cursors/lower_left_arrow.png",
      HotSpot = { 2, 19},
      Size = {32, 32}})
DefineCursor({
      Name = "cursor-arrow-se",
      Race = "any",
      File = "ui/cursors/lower_right_arrow.png",
      HotSpot = {21, 19},
      Size = {32, 32}})

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

local function MakeButton(x, y)
   local b = CUIButton:new()
   b.X = x
   b.Y = y
   b.Style = FindButtonStyle("icon")
   return b
end

UI.NormalFontColor = "white";
UI.ReverseFontColor = "yellow";

-- gold
UI.Resources[1].G = CGraphic:New("ui/gold_icon_1.png", 26, 12)
UI.Resources[1].IconFrame = 0
UI.Resources[1].IconX = Video.Width - 66 - 26
UI.Resources[1].IconY = 1
UI.Resources[1].TextX = Video.Width - 66 - 26 - 80
UI.Resources[1].TextY = 1
UI.Resources[1].Font = Fonts["game"]

-- wood
UI.Resources[2].G = CGraphic:New("ui/lumber_icon_1.png", 18, 18)
UI.Resources[2].IconFrame = 0
UI.Resources[2].IconX = Video.Width - 274 - 18
UI.Resources[2].IconY = 0
UI.Resources[2].TextX = Video.Width - 258 - 18 - 80
UI.Resources[2].TextY = 1
UI.Resources[2].Font = Fonts["game"]

-- mana -- no good icon, but we need this for the info bar
UI.Resources[ManaResCost].G = CGraphic:New("missiles/healing.png", 32, 32)
UI.Resources[ManaResCost].IconFrame = 0
UI.Resources[ManaResCost].IconX = -100
UI.Resources[ManaResCost].IconY = -100
UI.Resources[ManaResCost].TextX = UI.Resources[2].TextX
UI.Resources[ManaResCost].TextY = UI.Resources[2].TextY

UI.SingleSelectedButton = MakeButton(info_panel_x + 8, info_panel_y + 9)

UI.SelectedButtons:clear()
for i = 1,4,1 do
   local x = 9
   if i % 2 == 0 then
      x = 75
   end
   local y = 140
   if i <= 2 then
      y = y + 6
   else
      y = y + 52
   end
   UI.SelectedButtons:push_back(MakeButton(x, y))
end

UI.LifeBarColorNames:clear()
UI.LifeBarColorNames:push_back("green")
UI.LifeBarColorNames:push_back("yellow")
UI.LifeBarColorNames:push_back("orange")
UI.LifeBarColorNames:push_back("red")
UI.LifeBarYOffset = -4
UI.LifeBarBorder = false

UI.MaxSelectedFont = Fonts["game"]
UI.MaxSelectedTextX = info_panel_x + 10
UI.MaxSelectedTextY = info_panel_y + 10

--

local button_panel_off_x_1 = 9
local button_panel_off_x_2 = 75
local button_panel_off_y_1 = 240 + 47 * 0
local button_panel_off_y_2 = 240 + 47 * 1
local button_panel_off_y_3 = 240 + 47 * 2
local button_panel_off_y_4 = 240 + 47 * 3

local function MakeBuildingButton(index)
   return MakeButton(button_panel_off_x_1 + (index * 10), button_panel_off_y_4)
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
   local x = 9
   if (i + 1) % 2 == 0 then
      x = 75
   end
   local y = 240 + (47 * math.floor(i / 2))
   UI.ButtonPanel.Buttons:push_back(MakeButton(x, y))
end

UI.ButtonPanel.X = 0
UI.ButtonPanel.Y = 300
UI.ButtonPanel.AutoCastBorderColorRGB = CColor(0, 0, 252)

UI.MapArea.X = 144
UI.MapArea.Y = 16
UI.MapArea.EndX = Video.Width - 16 - 1
UI.MapArea.EndY = Video.Height - 16 - 1

UI.Minimap.X = 6
UI.Minimap.Y = 12
UI.Minimap.W = 128
UI.Minimap.H = 128

UI.StatusLine.TextX = 2 + 176
UI.StatusLine.TextY = Video.Height + 2 - 16
UI.StatusLine.Width = Video.Width - 16 - 2 - 176
UI.StatusLine.Font = Fonts["game"]

UI.MenuButton.X = 6
UI.MenuButton.Y = Video.Height - 24
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

UI.NetworkMenuButton.X = 6
UI.NetworkMenuButton.Y = 2
UI.NetworkMenuButton.Text = "Menu"
UI.NetworkMenuButton.Style = FindButtonStyle("network")
UI.NetworkMenuButton:SetCallback(function() RunGameMenu() end)

UI.NetworkDiplomacyButton.X = 90
UI.NetworkDiplomacyButton.Y = 2
UI.NetworkDiplomacyButton.Text = "Diplomacy"
UI.NetworkDiplomacyButton.Style = FindButtonStyle("network")
UI.NetworkDiplomacyButton:SetCallback(function() RunDiplomacyMenu() end)

function LoadUI(race, screen_width, screen_height)
   UI.Fillers:clear()
   AddFiller("ui/" .. race .. "/minimap.png", 0, 0, 144, 144)
   AddFiller("ui/" .. race .. "/left_panel.png", 0, 144, 144, Video.Height - (400 - 256))
   AddFiller("ui/" .. race .. "/top_resource_bar.png", 144, 0, Video.Width - (640 - 480), 24)
   AddFiller("ui/" .. race .. "/right_panel.png", Video.Width - 16, 0, 16, Video.Height)
   AddFiller("ui/" .. race .. "/bottom_panel.png", 144, Video.Height - 24, Video.Width - (640 - 480), 24)

   UI.InfoPanel.G = CGraphic:New("ui/" .. race .. "/icon_selection_boxes.png", 132, 92)
   
   Preference.IconFrameG = CGraphic:New("ui/" .. race .. "/icon_border.png", 62, 48)
   Preference.PressedIconFrameG = CGraphic:New("ui/" .. race .. "/icon_border.png", 62, 48)

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
   if (wc1.preferences.UseOpenGL == false) then
      return b + g*0x100 + r*0x10000 + a*0x1000000
   else
      return r + g*0x100 + b*0x10000 + a*0x1000000
   end
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
            { 	Margin = {1, 1}, HighlightColor = "red",
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
                More = {"Text", {Text = _("~<CTRL~>-click on button enables/disables auto-repair of damaged buildings."), MaxWidth = Video.Width / 5, Font = PopupFont}}
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
                More = {"Text", {Text = _("~<SHIFT~>-click could be used to make a building queue."), MaxWidth = Video.Width / 5, Font = PopupFont}}
            },
            -- Auto-cast hint
            { 	Margin = {1, 1}, Condition = {ButtonAction = "cast-spell"},
                More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
            },
            { 	Condition = {ButtonAction = "cast-spell"}, Margin = {1, 1}, TextColor = "yellow", HighlightColor = "cyan",
                More = {"Text", {Text = _("~<CTRL~>-click on button enables/disables auto-cast ability."), MaxWidth = Video.Width / 5, Font = PopupFont}}
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
