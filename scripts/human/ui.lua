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

function HumanScreen(screen_width, screen_height)
  info_panel_x = 0
  info_panel_y = 160

  DefineUI("human", screen_width, screen_height,
    "normal-font-color", "white",
    "reverse-font-color", "yellow",

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

    "info-panel", {
--[[
      "panel", {
        "file", "ui/human/infopanel.png",
        "pos", { info_panel_x, info_panel_y},
        "size", {176, 176}
      },
]]
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

    "button-panel", {
--[[
      "panel", {
        "file", "ui/human/" ..
          screen_width .. "x" .. screen_height ..
          "/buttonpanel.png",
        "pos", {0, 336}},
]]
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
        Caption = "Menu (~<F10~>)",
        Style = "main"},
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
      "panel3", "ui/human/panel_3.png",
      "panel4", "ui/human/panel_4.png",
      "panel5", "ui/human/panel_5.png"},

    "victory-background", "ui/human/victory.png",
    "defeat-background", "ui/human/defeat.png")
end

HumanScreen(640, 480)
HumanScreen(800, 600)
HumanScreen(1024, 768)
HumanScreen(1280, 960)
HumanScreen(1600, 1200)
