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

local info_panel_x = 0
local info_panel_y = 140
local min_damage = Div(ActiveUnitVar("PiercingDamage"), 2)
local max_damage = Add(ActiveUnitVar("PiercingDamage"), ActiveUnitVar("BasicDamage"))

UI.InfoPanel.X = info_panel_x
UI.InfoPanel.Y = info_panel_y

DefinePanelContents(
-- Default presentation. ------------------------
  {
  Ident = "panel-general-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "small",
  Contents = {
     { Pos = {70, 36}, Condition = {ShowOpponent = true, HideNeutral = false},
       More = {"LifeBar", {Variable = "HitPoints", Height = 7, Width = 55, Border = false,
                           Colors = {{75, "green"}, {50, "yellow"}, {25, "orange"}, {0, "red"}}}
       }
     },
     { Pos = {98, 36}, Condition = {ShowOpponent = false, HideNeutral = true},
       More = {"FormattedText2", {
		  Font = "small", Variable = "HitPoints", Format = "%d/%d",
		  Component1 = "Value", Component2 = "Max", Centered = true}}
     },
     { Pos = {105, 8}, More = {"Text", {Text = Line(1, UnitName("Active"), 90, "small"), Font = "small", Centered = true}} },
     { Pos = {105, 22}, More = {"Text", {Text = Line(2, UnitName("Active"), 90, "small"), Font = "small", Centered = true}} },
-- Ressource Left
     { Pos = {10, 86}, Condition = {ShowOpponent = false, GiveResource = "only"},
       More = {"FormattedText", {Format = "%s Left", Variable = "GiveResource",
				  Component = "Name"}}
     },
     { Pos = {10, 100}, Condition = {ShowOpponent = false, GiveResource = "only"},
       More = {"FormattedText", {Format = "%d", Variable = "GiveResource",
				  Component = "Value"}}
     },
-- Construction
     { Pos = {70, 22}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
       More = {"CompleteBar", {Variable = "Build", Width = 55, Height = 10, Color = "green"}}
     },
     { Pos = {98, 23}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
       More = {"Text", {Text = "% Complete", Font = "small", Centered = true}}},
     { Pos = {9, 78}, Condition = {ShowOpponent = false, HideNeutral = true, Build = "only"},
       More = {"Icon", {Unit = "Worker"}}}
  } },
-- Supply Building constructed.----------------
  {
  Ident = "panel-building-contents",
  Pos = {info_panel_x, info_panel_y}, DefaultFont = "small",
  Condition = {ShowOpponent = false, HideNeutral = true, Build = "false", Supply = "only", Training = "false", UpgradeTo = "false"},
-- FIXME more condition. not town hall.
  Contents = {
-- Food building
	{ Pos = {9, 66}, More = {"Text", {Text = function () return "Supply: " .. GetPlayerData(GetThisPlayer(), "Supply") end }} },
	{ Pos = {9, 82}, More = { "Text", {Text = function ()
                                                  if GetPlayerData(GetThisPlayer(), "Demand") > GetPlayerData(GetThisPlayer(), "Supply") then
                                                    return "Demand: ~<" .. GetPlayerData(GetThisPlayer(), "Demand") .. "~>"
                                                  else
                                                    return "Demand: " .. GetPlayerData(GetThisPlayer(), "Demand")
                                                  end
                                                end }}
    }

  } },
-- All own unit -----------------
  {
  Ident = "panel-all-unit-contents",
  Pos = {info_panel_x, info_panel_y},
  DefaultFont = "small",
  Condition = {ShowOpponent = false, HideNeutral = true, Build = "false"},
  Contents = {
     { Pos = {9, 82}, Condition = {AttackRange = "only"},
       More = {"Text", {Text = "Range: ", Variable = "AttackRange" , Stat = true}}
     },
-- Research
     { Pos = {70, 22}, Condition = {Research = "only"},
       More = {"CompleteBar", {Variable = "Research", Width = 55, Height = 10, Color = "green"}}
     },
     { Pos = {9, 50}, Condition = {Research = "only"}, More = {"Text", "Researching"}},
     { Pos = {98, 23}, Condition = {Research = "only"},
       More = {"Text", {Text = "% Complete", Font = "small", Centered = true}}},
-- Training
     { Pos = {70, 22}, Condition = {Training = "only"},
       More = {"CompleteBar", {Variable = "Training", Width = 55, Height = 10, Color = "green"}}},
     { Pos = {98, 23}, Condition = {Training = "only"},
       More = {"Text", {Text = "% Complete", Font = "small", Centered = true}}},
     { Pos = {9, 50}, Condition = {Training = "only"},
       More = {"Text", {Text = "Training", Font = "small", Centered = false}}},
-- Upgrading To
     { Pos = {70, 22}, Condition = {UpgradeTo = "only"},
       More = {"CompleteBar", {Variable = "UpgradeTo", Width = 55, Height = 10, Color = "green"}}
     },
     { Pos = {9,  50}, More = {"Text", "Upgrading"}, Condition = {UpgradeTo = "only"} },
     { Pos = {98, 23}, Condition = {UpgradeTo = "only"},
       More = {"Text", {Text = "% Complete", Font = "small", Centered = true}}},
-- Mana
     { Pos = {70, 21}, Condition = {Mana = "only"},
       More = {"CompleteBar", {Variable = "Mana", Height = 8, Width = 52, Border = true, Color = "light-blue"}}
     },
     { Pos = {97, 23},
       Condition = {Mana = "only"},
       More = {"FormattedText2", {
		  Font = "small", Variable = "Mana", Format = "%d/%d",
		  Component1 = "Value", Component2 = "Max", Centered = true}} },
-- Resource Carry
     { Pos = {9, 52}, Condition = {CarryResource = "only"},
       More = {"FormattedText2", {Format = "%s: %d", Variable = "CarryResource",
				  Component1 = "Name", Component2 = "Value"}}
     }
  } },
-- Attack Unit -----------------------------
  {
  Ident = "panel-attack-unit-contents",
  Pos = {info_panel_x, info_panel_y},
  DefaultFont = "small",
  Condition = {ShowOpponent = true, HideNeutral = true, Building = "false", Build = "false"},
  Contents = {
-- Unit caracteristics
     { Pos = {9, 52}, Condition = {Armor = "only"},
       More = {"Text", {
		  Text = "Armor: ", Variable = "Armor", Stat = true}}
     },
     { Pos = {9, 67},
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

b = CUIButton:new()
b.X = 9
b.Y = 140 + 6
b.Style = FindButtonStyle("icon")
UI.SingleSelectedButton = b

UI.SelectedButtons:clear()

AddSelectedButton(9, 140 + 6)
AddSelectedButton(75, 140 + 6)
AddSelectedButton(9, 140 + 52)
AddSelectedButton(75, 140 + 52)

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

b = CUIButton:new()
b.X = 9
b.Y = 200
b.Style = FindButtonStyle("icon")
UI.SingleTrainingButton = b

UI.TrainingButtons:clear()

AddTrainingButton(9, 200)
AddTrainingButton(19, 200)
AddTrainingButton(29, 200)
AddTrainingButton(39, 200)
AddTrainingButton(49, 200)
AddTrainingButton(59, 200)

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
AddTransportingButton(75, 387)
AddTransportingButton(9, 434)
AddTransportingButton(75, 434)

--

UI.CompletedBarColorRGB = CColor(48, 100, 4)
UI.CompletedBarShadow = true

UI.ButtonPanel.Buttons:clear()

AddButtonPanelButton(9, 240 + 47 * 0)
AddButtonPanelButton(75, 240 + 47 * 0)
AddButtonPanelButton(9, 240 + 47 * 1)
AddButtonPanelButton(75, 240 + 47 * 1)
AddButtonPanelButton(9, 240 + 47 * 2)
AddButtonPanelButton(75, 240 + 47 * 2)

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
