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
--      icons.lua - Define the icons.
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

icons = {
  {"icon-footman", 0},
  {"icon-grunt", 1},
  {"icon-conjurer", 2},
  {"icon-warlock", 3},
  {"icon-peasant", 4},
  {"icon-peon", 5},
  {"icon-human-catapult", 6},
  {"icon-orc-catapult", 7},
  {"icon-knight", 8},
  {"icon-raider", 9},
  {"icon-archer", 10},
  {"icon-spearman", 11},
  {"icon-cleric", 12},
  {"icon-necrolyte", 13},
  {"icon-human-farm", 14},
  {"icon-orc-farm", 15},
  {"icon-human-barracks", 16},
  {"icon-orc-barracks", 17},
  {"icon-human-tower", 18},
  {"icon-orc-tower", 19},
  {"icon-human-town-hall", 20},
  {"icon-orc-town-hall", 21},
  {"icon-human-lumber-mill", 22},
  {"icon-orc-lumber-mill", 23},
  {"icon-human-stable", 24},
  {"icon-orc-kennel", 25},
  {"icon-human-blacksmith", 26},
  {"icon-orc-blacksmith", 27},
  {"icon-human-church", 28},
  {"icon-orc-temple", 29},
  {"icon-gold-mine", 30},
  {"icon-stormwind-keep", 31},
  {"icon-blackrock-spire", 32},
  {"icon-move-peasant", 33},
  {"icon-move-peon", 34},
  {"icon-repair", 35},
  {"icon-harvest", 36},
  {"icon-build-basic", 37},
  {"icon-build-advanced", 38},
  {"icon-return-goods", 39},
  {"icon-cancel", 40},
  {"icon-wall", 41},
  {"icon-road", 42},

  {"icon-ogre", 44},
  {"icon-spider", 45},
  {"icon-slime", 46},
  {"icon-fire-elemental", 47},
  {"icon-scorpion", 48},
  {"icon-the-dead", 49},
  {"icon-skeleton", 50},
  {"icon-daemon", 51},
  {"icon-water-elemental", 52},
  {"icon-lothar", 53},
  {"icon-midevh", 54},
  {"icon-garona", 55},
  {"icon-grizelda", 56},
  {"icon-wounded", 57},
  {"icon-brigand", 58},
  {"icon-holy-lance", 59},
  {"icon-elemental-blast", 60},
  {"icon-shadow-spear", 61},
  {"icon-fireball", 62},
  {"icon-sword1", 63},
  {"icon-sword2", 64},
  {"icon-sword3", 65},
  {"icon-axe1", 66},
  {"icon-axe2", 67},
  {"icon-axe3", 68},
  {"icon-wolves1", 69},
  {"icon-wolves2", 70},
  {"icon-arrow1", 71},
  {"icon-arrow2", 72},
  {"icon-arrow3", 73},
  {"icon-spear1", 74},
  {"icon-spear2", 75},
  {"icon-spear3", 76},
  {"icon-horse1", 77},
  {"icon-horse2", 78},
  {"icon-human-shield1", 79},
  {"icon-human-shield2", 80},
  {"icon-human-shield3", 81},
  {"icon-orc-shield1", 82},
  {"icon-orc-shield2", 83},
  {"icon-orc-shield3", 84},
  {"icon-healing", 85},
  {"icon-far-seeing", 86},
  {"icon-invisibility", 87},
  {"icon-rain-of-fire", 88},
  {"icon-raise-dead", 89},
  {"icon-dark-vision", 90},
  {"icon-unholy-armor", 91},
  {"icon-poison-cloud", 92},

  {"icon-human-patrol-land", 40},
  {"icon-orc-patrol-land", 40},
  {"icon-human-stand-ground", 40},
  {"icon-orc-stand-ground", 40},
  {"icon-human-attack-ground", 40},
  {"icon-orc-attack-ground", 40},
}

for i = 1,table.getn(icons) do
  DefineIcon({
    Name = icons[i][1],
    Tileset = "tileset-summer",
    Size = {54, 38},
    File = "tilesets/summer/portrait_icons.png",
    Index = icons[i][2],})

  DefineIcon({
    Name = icons[i][1],
    Tileset = "tileset-swamp",
    Size = {54, 38},
    File = "tilesets/swamp/portrait_icons.png",
    Index = icons[i][2],})

  DefineIcon({
    Name = icons[i][1],
    Tileset = "tileset-dungeon",
    Size = {54, 38},
    File = "tilesets/dungeon/portrait_icons.png",
    Index = icons[i][2],})
end
