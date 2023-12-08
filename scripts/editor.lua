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
SetEditorRandomizeProperties({
  BaseTile = 80, -- grass
  RandomTiles = {
	{32, 1, 40}, -- water
	{64, 4, 15}, -- light grass
	{112, 20, 7}, -- forest	
	{96, 12, 2}, -- dark grass
  },
  RandomUnits = {
    {"unit-gold-mine", 1, 20000, 64}
  }
})

--
--	editor-unit-types a sorted list of unit-types for the editor.
--	FIXME: this is only a temporary hack, for better sorted units.
--
local editor_types = {
--  "unit-human-start-location",

  "unit-peasant",
  "",
  "unit-footman",
  "unit-archer",
  "unit-human-catapult",
  "unit-knight",
  "unit-cleric",
  "unit-conjurer",
  "", "", 
  "unit-human-farm",
  "unit-human-lumber-mill",
  "unit-human-barracks",
  "unit-human-town-hall",
  "unit-human-guard-tower",
  "", 
  "unit-human-blacksmith", 
  "unit-human-church",
  "unit-human-stable",
  "unit-human-tower",
  "", "", 
  "unit-medivh",
  "unit-lothar",
  "unit-human-stormwind-keep",
  "", 
--- - - - - - - - - - - - - - - - - - -
 
--  "unit-orc-start-location",

  "unit-peon",
  "",
  "unit-grunt",
  "unit-spearman",
  "unit-orc-catapult",
  "unit-raider",
  "unit-necrolyte",
  "unit-warlock",
  "", "", 
  "unit-orc-farm",
  "unit-orc-lumber-mill",
  "unit-orc-barracks",
  "unit-orc-town-hall",
  "unit-orc-watch-tower",
  "", 
  "unit-orc-blacksmith",
  "unit-orc-temple",
  "unit-orc-kennel",
  "unit-orc-tower",
  "",  "", 
  "unit-grizelda",
  "unit-garona",
  "unit-orc-blackrock-spire",
  "", 

--- - - - - - - - - - - - - - - - - - -

  "unit-road",
  "unit-wall",

  "", "",

  "unit-gold-mine",
  "unit-dungeon-entrance",
  
  "", "",
  "unit-scorpion",
  "unit-spider",  
  "unit-water-elemental",
  "unit-daemon",
  "unit-skeleton",
  "unit-the-dead",

  "unit-brigand",
  "unit-ogre",
  "unit-slime",
  "unit-fire-elemental",
  "unit-wounded",

  "", "","",
  "unit-slime-pond",
  "unit-magma-rift",
  "unit-windmill",
  "unit-ruin",
  "", "",
--  "unit-pentagram",
--  "unit-north-wall",
--  "unit-wall-wardrobe",
--  "unit-wall-cupboard",
--  "unit-wall-barrels",

-- Placing this unit-types on map is not (yet?) supported.
--  "unit-dead-body",

}

Editor.UnitTypes:clear()
for key,value in ipairs(editor_types) do
  Editor.UnitTypes:push_back(value)
end

local keystrokes = {
  {"Ctrl-R", "randomize map"},  
  {"Ctrl-T", "cycle active tool"},
  {"Ctrl-F", "toggle full screen"},
  {"Ctrl-M", "cycle mirror editing"},
  {"Ctrl-C", "exit"},
  {"Ctrl-Q", "quit to menu"},
  {"Ctrl-Z", "undo"},
  {"Ctrl-Y", "redo"},
  {"backspace", "remove unit under cursor"},
  {"0", "unit under cursor to last player (neutral)"},
  {"1-9", "unit under cursor to player 1-9"},
  {"F5", "Map properties"},
  {"F6", "Player properties"},
  {"F11", "Save map"},
  {"F12", "Load map"},
  {"Rightclick", "Tile mode: Deselect current tile"},
  {"Rightclick", "Unit mode: Deselect current unit"},
  {"Rightclick", "Select mode: Edit unit under cursor"},
  {"Alt+click", "Tile mode when no tile is selected: Modify tile under cursor"}
}

function RunEditorHelpMenu()
  local menu = WarGameMenu(panel(1), 176, 176)

  local c = Container()
  c:setOpaque(false)

  local xWidth = 0

  for i=1,table.getn(keystrokes) do
    local l = Label(keystrokes[i][1])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 0, 10 * (i - 1))
    local l = Label(keystrokes[i][2])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 60, 10 * (i - 1))
    xWidth = math.max(l:getWidth(), xWidth)
  end

  local s = ScrollArea()
  c:setSize(xWidth * 2, 10 * table.getn(keystrokes))
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
