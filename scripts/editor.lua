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
DefineEditorUnitTypes(
  "unit-human-start-location",

  "unit-peasant",
  "unit-footman",
  "unit-archer",
  "unit-knight",
  "unit-human-catapult",
  "unit-conjurer",
  "unit-cleric",
  "unit-midevh",

  "unit-human-town-hall",
  "unit-human-farm",
  "unit-human-barracks",
  "unit-human-lumber-mill",
  "unit-human-blacksmith",
  "unit-human-stable",
  "unit-human-church",
  "unit-human-tower",

--- - - - - - - - - - - - - - - - - - -

  "unit-orc-start-location",

  "unit-peon",
  "unit-grunt",
  "unit-spearman",
  "unit-raider",
  "unit-orc-catapult",
  "unit-warlock",
  "unit-necrolyte",
  "unit-lothar",

  "unit-orc-town-hall",
  "unit-orc-farm",
  "unit-orc-barracks",
  "unit-orc-lumber-mill",
  "unit-orc-blacksmith",
  "unit-orc-kennel",
  "unit-orc-temple",
  "unit-orc-tower",

--- - - - - - - - - - - - - - - - - - -

  "unit-gold-mine",

-- Placing this unit-types on map is not (yet?) supported.
--  "unit-dead-body",
--  "unit-destroyed-1x1-place",
--  "unit-destroyed-2x2-place",
--  "unit-destroyed-3x3-place",
--  "unit-destroyed-4x4-place",
)
