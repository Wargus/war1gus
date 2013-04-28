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
--      ui.ccl - Define the human user interface
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

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--	* Race human.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function AddFiller(file, x, y)
        if CanAccessFile(file) == true then
                b = CFiller:new_local()
                b.G = CGraphic:New(file)
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



function HumanScreen(screen_width, screen_height)
  info_panel_x = 0
  info_panel_y = 160

--  DefineUI("human", screen_width, screen_height,
  UI.NormalFontColor = "white";
  UI.ReverseFontColor = "yellow";
--    "normal-font-color", "white",
--    "reverse-font-color", "yellow",

  UI.Fillers:clear()
  AddFiller("ui/human/minimap.png", 0, 0)
  AddFiller("ui/human/left_panel.png", 0, 144)
  AddFiller("ui/human/top_resource_bar.png", 144, 0)
  AddFiller("ui/human/right_panel.png", 624, 0)
  AddFiller("ui/human/bottom_panel.png", 144, 376)
--[[
    "filler", {
      File = "ui/human/minimap.png",
      Pos = {0, 0}},
    "filler", {
      File = "ui/human/left_panel.png",
      Pos = {0, 144}},
    "filler", {
      File = "ui/human/top_resource_bar.png",
      Pos = {144, 0}},
    "filler", {
      File = "ui/human/right_panel.png",
      Pos = {624, 0}},
    "filler", {
      File = "ui/human/bottom_panel.png",
      Pos = {144, 376}},
]]

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

--[[
-- oil
UI.Resources[3].G = CGraphic:New("ui/gold,wood,oil,mana.png", 14, 14)
UI.Resources[3].IconFrame = 2
UI.Resources[3].IconX = 176 + 150
UI.Resources[3].IconY = 0
UI.Resources[3].TextX = 176 + 150 + 18
UI.Resources[3].TextY = 1

-- food
UI.Resources[FoodCost].G = CGraphic:New("ui/food.png", 14, 14)
UI.Resources[FoodCost].IconFrame = 0
UI.Resources[FoodCost].IconX = Video.Width - 16 - 138
UI.Resources[FoodCost].IconY = 0
UI.Resources[FoodCost].TextX = Video.Width - 16 - 138 + 18
UI.Resources[FoodCost].TextY = 1

-- score
UI.Resources[ScoreCost].G = CGraphic:New("ui/score.png", 14, 14)
UI.Resources[ScoreCost].IconFrame = 0
UI.Resources[ScoreCost].IconX = Video.Width - 16 - 68
UI.Resources[ScoreCost].IconY = 0
UI.Resources[ScoreCost].TextX = Video.Width - 16 - 68 + 18
UI.Resources[ScoreCost].TextY = 1
--]]
--[[
    "resources", {
      "gold", { File = "ui/gold,wood,oil,mana.png", Frame = 0,
        Pos = { 176 + 0, 0}, Size = {14, 14}, TextPos = { 176 + 0 + 18, 1}},
      "wood", { File = "ui/gold,wood,oil,mana.png", Frame = 1,
        Pos = { 176 + 75, 0}, Size = {14, 14}, TextPos = { 176 + 75 + 18, 1}},
      "oil", { File = "ui/gold,wood,oil,mana.png", Frame = 2,
        Pos = { 176 + 150, 0}, Size = {14, 14}, TextPos = { 176 + 150 + 18, 1}},
      "food", { File = "ui/food.png", Frame = 0,
        Pos = { screen_width - 16 - 138, 0}, Size = {14, 14}, TextPos = { (screen_width - 16 - 138) + 18, 1}},
      "score", { File = "ui/score.png", Frame = 0,
        Pos = { screen_width - 16 - 68, 0}, Size = {14, 14}, TextPos = { (screen_width - 16 - 68) + 18, 1}}},
]]

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
b.X = 110
b.Y = 160 + 11 + 70
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
b.X = 110
b.Y = 160 + 11 + 70
b.Style = FindButtonStyle("icon")
UI.UpgradingButton = b

--

b = CUIButton:new()
b.X = 110
b.Y = 160 + 11 + 70
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

--    "info-panel", {
--[[
      "panel", {
        "file", "ui/human/infopanel.png",
        "pos", { info_panel_x, info_panel_y},
        "size", {176, 176}
      },
]]

--[[
      "selected", {
        "single", {
          "icon", {
            "pos", {  6, 166}, "style", "icon"}},
        "multiple", {
          "icons", {
            { "pos", {  6, 166}, "style", "icon"},
            { "pos", { 62, 166}, "style", "icon"},
            { "pos", {118, 166}, "style", "icon"},
            { "pos", {  6, 220}, "style", "icon"},
            { "pos", { 62, 220}, "style", "icon"},
            { "pos", {118, 220}, "style", "icon"},
            { "pos", {  6, 274}, "style", "icon"},
            { "pos", { 62, 274}, "style", "icon"},
            { "pos", {118, 274}, "style", "icon"}},
          "max-text", {
            "font", "game",
            "pos", { info_panel_x + 10, info_panel_y + 10}}}
      },
      "training", {
        "single", {
          "text", {
            "text", "Training:",
            "font", "game",
            "pos", { info_panel_x + 37, info_panel_y + 8 + 78}},
          "icon", {
            "pos", { info_panel_x + 107, info_panel_y + 8 + 70},
            "style", "icon"}},
        "multiple", {
          "icons", {
            { "pos", {  6, 216}, "style", "icon"},
            { "pos", { 62, 216}, "style", "icon"},
            { "pos", {118, 216}, "style", "icon"},
            { "pos", {  6, 263}, "style", "icon"},
            { "pos", { 62, 263}, "style", "icon"},
            { "pos", {118, 263}, "style", "icon"}}}
      },
      "upgrading", {
        "text", {
          "text", "Upgrading:",
          "font", "game",
          "pos", { info_panel_x + 29, info_panel_y + 8 + 78}},
        "icon", {
          "pos", { info_panel_x + 107, info_panel_y + 8 + 70},
          "style", "icon"},
      },
      "researching", {
        "text", {
          "text", "Researching:",
          "font", "game",
          "pos", { info_panel_x + 16, info_panel_y + 8 + 78}},
        "icon", {
          "pos", { info_panel_x + 107, info_panel_y + 8 + 70},
          "style", "icon"}
      },
      "transporting", {
        "icons", {
          { "pos", {  6, 220}, "style", "icon"},
          { "pos", { 62, 220}, "style", "icon"},
          { "pos", {118, 220}, "style", "icon"},
          { "pos", {  6, 274}, "style", "icon"},
          { "pos", { 62, 274}, "style", "icon"},
          { "pos", {118, 274}, "style", "icon"}}
      },
      "completed-bar", {
        "color", {48, 100, 4},
        "pos", { 12, 313},
        "size", {152, 14},
        "text", {
          "text", "% Complete",
          "font", "game",
          "pos", { 50, 313}}
      }
    },
]]
--    "button-panel", {
--[[
      "panel", {
        "file", "ui/human/" ..
          screen_width .. "x" .. screen_height ..
          "/buttonpanel.png",
        "pos", {0, 336}},
]]
--[[
      "icons", {
        {"pos", {  8, 236}, "style", "icon"},
        {"pos", { 76, 236}, "style", "icon"},
        {"pos", {  8, 282}, "style", "icon"},
        {"pos", { 76, 282}, "style", "icon"},
        {"pos", {  8, 328}, "style", "icon"},
        {"pos", { 76, 328}, "style", "icon"}},
      "auto-cast-border-color", {0, 0, 252},
    },

    "map-area", {
      Pos = {144, 24},
      Size = {480, 352}},

    "menu-panel", {
      "menu-button", {
        Pos = {6, 376},
        Style = "menu"},
      "network-menu-button", {
        Pos = {6, 376},
        Caption = "Menu",
        Style = "network"},
      "network-diplomacy-button", {
        Pos = {168, 376},
        Caption = "Diplomacy",
        Style = "network"},
    },

    "minimap", {
      Pos = {6, 12},
      Size = {128, 128}},

    "status-line", {
      TextPos = {148, 385},
      Font = "game",
      Width = 480},

    "cursors", {
      Point = "cursor-point",
      Glass = "cursor-glass",
      Cross = "cursor-cross",
      Yellow = "cursor-yellow-hair",
      Green = "cursor-green-hair",
      Red = "cursor-red-hair",
      Scroll = "cursor-scroll",
      ArrowE = "cursor-arrow-e",
      ArrowNE = "cursor-arrow-ne",
      ArrowN = "cursor-arrow-n",
      ArrowNW = "cursor-arrow-nw",
      ArrowW = "cursor-arrow-w",
      ArrowSW = "cursor-arrow-sw",
      ArrowS = "cursor-arrow-s",
      ArrowSE = "cursor-arrow-se"},

    "menu-panels", {
      "panel1", "ui/human/panel_1.png",
      "panel2", "ui/human/panel_2.png",
      "panel3", "ui/human/panel_2.png",
      "panel4", "ui/human/panel_2.png",
      "panel5", "ui/human/panel_2.png"},
]]

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

--    "victory-background", "ui/human/victory.png",
--    "defeat-background", "ui/human/defeat.png")
end

HumanScreen(640, 480)
HumanScreen(800, 600)
HumanScreen(1024, 768)
HumanScreen(1280, 960)
HumanScreen(1600, 1200)
