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
--      widgets.lua - Define the widgets
--
--      (c) Copyright 2004 by Jimmy Salmon
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


DefineButtonStyle("menu", {
  Size = {65, 12},
  Font = "game",
  Default = { File = "ui/menu_button_1.png"},
  Clicked = { File = "ui/menu_button_2.png"},
})


DefineButtonStyle("main", {
  Size = {128, math.floor(16 * (Video.Height - UI.Minimap.H) / (240 - UI.Minimap.H))},
  Font = "game",
  TextNormalColor = "yellow",
  TextReverseColor = "white",
  TextAlign = "Center",
  TextPos = {32, 2},
  Hover = { TextNormalColor = "white" },
  Clicked = {
    TextNormalColor = "white",
    TextPos = {33, 3},
  },
})

DefineButtonStyle("network", {
  Size = {40, 10},
  Font = "game",
  TextNormalColor = "yellow",
  TextReverseColor = "white",
  TextAlign = "Center",
  TextPos = {20, 2},
  Hover = { TextNormalColor = "white" },
  Clicked = {
    TextNormalColor = "white",
    TextPos = {21, 3},
  },
})

DefineButtonStyle("gm-half", {
  Size = {53, 14},
  Font = "large",
  TextNormalColor = "yellow",
  TextReverseColor = "white",
  TextAlign = "Center",
  TextPos = {26, 3},
  Default = { File = "ui/buttons_1.png", Size = {150, 72}, Frame = 10},
  Hover = { TextNormalColor = "white" },
  Clicked = {
    TextNormalColor = "white",
    TextPos = {27, 4},
  },
})

DefineButtonStyle("gm-full", {
  Size = {112, 14},
  Font = "large",
  TextNormalColor = "yellow",
  TextReverseColor = "white",
  TextAlign = "Center",
  TextPos = {56, 3},
  Default = { File = "ui/buttons_1.png", Size = {150, 72}, Frame = 16},
  Hover = { TextNormalColor = "white" },
  Clicked = {
    TextNormalColor = "white",
    TextPos = {57, 4},
  },
})

DefineButtonStyle("folder", {
  Size = {19, 11},
  Font = "large",
  TextNormalColor = "yellow",
  TextReverseColor = "white",
  TextAlign = "Left",
  TextPos = {22, 3},
  Hover = { TextNormalColor = "white" },
  Clicked = {
    TextNormalColor = "white",
  },
})

DefineButtonStyle("icon", {
  Size = {27, 19},
  Font = "game",
  TextNormalColor = "yellow",
  TextReverseColor = "white",
  TextAlign = "Right",
  TextPos = {27, 13},
  Default = {
    Border = {
      Color = {0, 0, 0}, Size = 1,
    },
  },
  Hover = {
    TextNormalColor = "white",
    Border = {
      SolidColor = {128, 128, 128}, Size = 1,
    },
  },
  Clicked = {
    TextNormalColor = "white",
    Border = {
      SolidColor = {128, 128, 128}, Size = 1,
    },
  },
})
