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
--      editor.lua - Editor configuration and functions.
--
--      (c) Copyright 2002-2004 by Lutz Sammer and Jimmy Salmon
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


--	Set which icons to display
SetEditorSelectIcon("icon-human-patrol-land")
SetEditorUnitsIcon("icon-footman")

--
--	editor-unit-types a sorted list of unit-types for the editor.
--	FIXME: this is only a temporary hack, for better sorted units.
--
local editor_types = {
--  "unit-human-start-location",

  "unit-peasant",
  "unit-footman",
  "unit-archer",

  "unit-knight",
  "unit-human-catapult",
  "unit-conjurer",
  "unit-cleric",
  "unit-medivh",
  "unit-lothar",

  "unit-human-town-hall",
  "unit-human-farm",
  "unit-human-barracks",
  "unit-human-lumber-mill",
  "unit-human-blacksmith",
  "unit-human-stable",
  "unit-human-church",
  "unit-human-tower",
  "unit-human-stormwind-keep",

--- - - - - - - - - - - - - - - - - - -

--  "unit-orc-start-location",

  "unit-peon",

  "unit-grunt",
  "unit-spearman",
  "unit-raider",
  "unit-orc-catapult",
  "unit-warlock",
  "unit-necrolyte",
  "unit-grizelda",
  "unit-garona",

  "unit-orc-town-hall",
  "unit-orc-farm",
  "unit-orc-barracks",
  "unit-orc-lumber-mill",
  "unit-orc-blacksmith",
  "unit-orc-kennel",
  "unit-orc-temple",
  "unit-orc-tower",
  "unit-orc-blackrock-spire",

--- - - - - - - - - - - - - - - - - - -

  "unit-road",
  "unit-wall",
  "unit-gold-mine",
  "unit-dungeon-entrance",
  "unit-brigand",
  "unit-daemon",
  "unit-fire-elemental",
  "unit-ogre",
  "unit-scorpion",
  "unit-skeleton",
  "unit-slime",
  "unit-spider",
  "unit-the-dead",
  "unit-water-elemental",
  "unit-wounded",

-- Placing this unit-types on map is not (yet?) supported.
--  "unit-dead-body",

}

Editor.UnitTypes:clear()
for key,value in ipairs(editor_types) do
  Editor.UnitTypes:push_back(value)
end

local keystrokes = {
  {"Ctrl-f", "toggle full screen"},
  {"Ctrl-m", "cycle mirror editing"},
  {"Ctrl-x", "exit"},
  {"Ctrl-q", "quit to previous menu"},
  {"Ctrl-z", "undo"},
  {"Ctrl-y", "redo"},
  {"backspace/delete", "remove unit under cursor"},
  {"0", "assign unit under cursor to last player (neutral)"},
  {"1-9", "assign unit under cursor to player 1 - 9"},
  {"F5", "Map properties"},
  {"F6", "Player properties"},
  {"F11", "Save map"},
  {"F12", "Load map"},
  {"Right mouse click", "Deselect current tile/unit. In selection mode, edit unit under cursor"}
}

function RunEditorHelpMenu()
  local menu = WarGameMenu(panel(1), 176, 176)

  local c = Container()
  c:setOpaque(false)

  for i=1,table.getn(keystrokes) do
    local l = Label(keystrokes[i][1])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 0, 10 * (i - 1))
    local l = Label(keystrokes[i][2])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 40, 10 * (i - 1))
  end

  local s = ScrollArea()
  c:setSize(160 - s:getScrollbarWidth(), 10 * table.getn(keystrokes))
  s:setBaseColor(dark)
  s:setBackgroundColor(dark)
  s:setForegroundColor(clear)
  s:setSize(160, 108)
  s:setContent(c)
  menu:add(s, 8, 30)

  menu:addLabel("Keystroke Help Menu", 88, 5)
  menu:addFullButton("Previous (~<Esc~>)", "escape",
    (88) - (63), 176 - 20, function() menu:stop() end)

  menu:run(false)
end
