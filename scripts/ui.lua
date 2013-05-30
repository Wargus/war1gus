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

UI.MessageFont = Fonts["game"]
UI.MessageScrollSpeed = 5

Load("scripts/widgets.lua")

local info_panel_x = 0
local info_panel_y = 140
local min_damage = Div(ActiveUnitVar("PiercingDamage"), 2)
local max_damage = Add(ActiveUnitVar("PiercingDamage"), ActiveUnitVar("BasicDamage"))

DefinePanelContents(
-- Default presentation. ------------------------
  {
  Ident = "panel-general-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "game",
  Contents = {
     { Pos = {70, 36}, Condition = {ShowOpponent = false, HideNeutral = true},
       More = {"LifeBar", {Variable = "HitPoints", Height = 7, Width = 49}}
     },
     { Pos = {98, 36}, Condition = {ShowOpponent = false, HideNeutral = true},
       More = {"FormattedText2", {
		  Font = "small", Variable = "HitPoints", Format = "%d/%d",
		  Component1 = "Value", Component2 = "Max", Centered = true}}
     },
     { Pos = {105, 8}, More = {"Text", {Text = Line(1, UnitName("Active"), 90, "small"), Centered = true}} },
     { Pos = {105, 22}, More = {"Text", {Text = Line(2, UnitName("Active"), 90, "small"), Centered = true}} },
-- Ressource Left
     { Pos = {68, 86}, Condition = {ShowOpponent = false, GiveResource = "only"},
       More = {"FormattedText2", {Format = "%s Left:%d", Variable = "GiveResource",
				  Component1 = "Name", Component2 = "Value", Centered = true}}
     },
-- Construction
     { Pos = {10, 153}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
       More = {"CompleteBar", {Variable = "Build", Width = 140, Height = 18}}
     },
     { Pos = {50, 154}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
       More = {"Text", "% Complete"}},
     { Pos = {9, 78}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
       More = {"Icon", {Unit = "Worker"}}}
  } },
-- Supply Building constructed.----------------
  {
  Ident = "panel-building-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "game",
  Condition = {ShowOpponent = false, HideNeutral = true, Build = "false", Supply = "only", Training = "false", UpgradeTo = "false"},
-- FIXME more condition. not town hall.
  Contents = {
-- Food building
	{ Pos = {16, 51}, More = {"Text", "Usage"} },
	{ Pos = {38, 66}, More = {"Text", {Text = "Supply : ", Variable = "Supply", Component = "Max"}} },
	{ Pos = {31, 82}, More = { "Text", {Text = Concat("Demand : ",
									If(GreaterThan(ActiveUnitVar("Demand", "Max"), ActiveUnitVar("Supply", "Max")),
										InverseVideo(String(ActiveUnitVar("Demand", "Max"))),
										String(ActiveUnitVar("Demand", "Max")) ))}}
    }

  } },
-- All own unit -----------------
  {
  Ident = "panel-all-unit-contents",
  Pos = {info_panel_x, info_panel_y},
  DefaultFont = "game",
  Condition = {ShowOpponent = false, HideNeutral = true, Build = "false"},
  Contents = {
     { Pos = {33, 82}, Condition = {AttackRange = "only"},
       More = {"Text", {Text = "Range: ", Variable = "AttackRange" , Stat = true}}
     },
-- Research
     { Pos = {10, 153}, Condition = {Research = "only"},
       More = {"CompleteBar", {Variable = "Research", Width = 140, Height = 18}}
     },
     { Pos = {16, 86}, Condition = {Research = "only"}, More = {"Text", "Researching:"}},
     { Pos = {50, 154}, Condition = {Research = "only"}, More = {"Text", "% Complete"}},
-- Training
     { Pos = {10, 153}, Condition = {Training = "only"},
       More = {"CompleteBar", {Variable = "Training", Width = 140, Height = 18}}
     },
     { Pos = {50, 154}, Condition = {Training = "only"}, More = {"Text", "% Complete"}},
-- Upgrading To
     { Pos = {10, 153}, Condition = {UpgradeTo = "only"},
       More = {"CompleteBar", {Variable = "UpgradeTo", Width = 140, Height = 18}}
     },
     { Pos = {16,  86}, More = {"Text", "Upgrading:"}, Condition = {UpgradeTo = "only"} },
     { Pos = {50, 154}, More = {"Text", "% Complete"}, Condition = {UpgradeTo = "only"} },
-- Mana
     { Pos = {70, 45}, Condition = {Mana = "only"},
       More = {"CompleteBar", {Variable = "Mana", Height = 7, Width = 49, Border = true}}
     },
     { Pos = {98, 45},
       Condition = {Mana = "only"},
       More = {"FormattedText2", {
		  Font = "small", Variable = "Mana", Format = "%d/%d",
		  Component1 = "Value", Component2 = "Max", Centered = true}} },
-- Resource Carry
     { Pos = {61, 149}, Condition = {CarryResource = "only"},
       More = {"FormattedText2", {Format = "Carry: %d %s", Variable = "CarryResource",
				  Component1 = "Value", Component2 = "Name"}}
     }
  } },
-- Attack Unit -----------------------------
  {
  Ident = "panel-attack-unit-contents",
  Pos = {info_panel_x, info_panel_y},
  DefaultFont = "game",
  Condition = {ShowOpponent = true, HideNeutral = true, Building = "false", Build = "false"},
  Contents = {
-- Unit caracteristics
     { Pos = {22, 52}, Condition = {Armor = "only"},
       More = {"Text", {
		  Text = "Armor: ", Variable = "Armor", Stat = true}}
     },
     { Pos = {25, 67},
       More = {"Text", {
		  Text = Concat("Damage: ",
				String(min_damage), "-", String(max_damage))
		       }
       }
     }}
  })

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

function AddFiller(file, x, y, resize_x, resize_y)
        if CanAccessFile(file) == true then
                b = CFiller:new_local()
                b.G = CGraphic:New(file)
                b.G:Load()
                b.G:Resize(resize_x, resize_y)
                b.X = x
                b.Y = y
                UI.Fillers:push_back(b)
        end    
end

function AddSelectedButton(x, y)
        b = CUIButton:new_local()
        b.X = x
        b.Y = y
        b.Style = FindButtonStyle("icon")
        UI.SelectedButtons:push_back(b)
end

function AddTrainingButton(x, y)
        b = CUIButton:new_local()
        b.X = x
        b.Y = y
        b.Style = FindButtonStyle("icon")
        UI.TrainingButtons:push_back(b)
end

function AddTransportingButton(x, y)
        b = CUIButton:new_local()
        b.X = x
        b.Y = y
        b.Style = FindButtonStyle("icon")
        UI.TransportingButtons:push_back(b)
end

function AddButtonPanelButton(x, y)
        b = CUIButton:new_local()
        b.X = x
        b.Y = y
        b.Style = FindButtonStyle("icon")
        UI.ButtonPanel.Buttons:push_back(b)
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
UI.Resources[2].IconFrame = 1
UI.Resources[2].IconX = Video.Width - 258 - 18
UI.Resources[2].IconY = 0
UI.Resources[2].TextX = Video.Width - 258 - 18 - 80
UI.Resources[2].TextY = 1
UI.Resources[2].Font = Fonts["game"]

b = CUIButton:new()
b.X = 9
b.Y = 140 + 6
b.Style = FindButtonStyle("icon")
UI.SingleSelectedButton = b

UI.SelectedButtons:clear()

AddSelectedButton(9, 140 + 6)
AddSelectedButton(70, 140 + 6)
AddSelectedButton(9, 140 + 52)
AddSelectedButton(70, 140 + 52)

UI.MaxSelectedFont = Fonts["game"]
UI.MaxSelectedTextX = info_panel_x + 10
UI.MaxSelectedTextY = info_panel_y + 10

--

b = CUIButton:new()
b.X = 6
b.Y = 200
b.Style = FindButtonStyle("icon")
UI.SingleTrainingButton = b

UI.TrainingButtons:clear()

AddTrainingButton(6, 200)
AddTrainingButton(62, 200)
AddTrainingButton(6, 200 + 47)
AddTrainingButton(62, 200 + 47)
AddTrainingButton(6, 200 + 47 * 2)
AddTrainingButton(62, 200 + 47 * 2)

--

b = CUIButton:new()
b.X = 6
b.Y = 200
b.Style = FindButtonStyle("icon")
UI.UpgradingButton = b

--

b = CUIButton:new()
b.X = 6
b.Y = 200
b.Style = FindButtonStyle("icon")
UI.ResearchingButton = b

--

UI.TransportingButtons:clear()

AddTransportingButton(9, 387)
AddTransportingButton(70, 387)
AddTransportingButton(9, 434)
AddTransportingButton(70, 434)

--

UI.CompletedBarColorRGB = CColor(48, 100, 4)
UI.CompletedBarShadow = true

UI.ButtonPanel.Buttons:clear()

AddButtonPanelButton(9, 240 + 47 * 0)
AddButtonPanelButton(70, 240 + 47 * 0)
AddButtonPanelButton(9, 240 + 47 * 1)
AddButtonPanelButton(70, 240 + 47 * 1)
AddButtonPanelButton(9, 240 + 47 * 2)
AddButtonPanelButton(70, 240 + 47 * 2)

UI.ButtonPanel.X = 0
UI.ButtonPanel.Y = 200
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
