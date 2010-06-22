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
--      wc1.lua - WC1 compatibility level
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

DefineRaceNames(
  "race", {
    "name", "human",
    "display", "Human",
    "visible"},
  "race", {
    "name", "orc",
    "display", "Orc",
    "visible"},
  "race", {
    "name", "neutral",
    "display", "Neutral"})

--DefineTilesetWcNames(
--  "tileset-forest", "tileset-swamp", "tileset-dungeon")

--[[DefineConstructionWcNames(
  "construction-none",
  "construction-wall",
  "construction-human-barracks", "construction-human-blacksmith",
  "construction-human-church", "construction-human-farm",
  "construction-human-lumber-mill", "construction-human-stable",
  "construction-human-tower", "construction-human-town-hall"
)

DefineUnitTypeWcNames(
  "unit-footman", "unit-grunt",
  "unit-peasant", "unit-peon",
  "unit-human-catapult", "unit-orc-catapult",
  "unit-knight", "unit-raider",
  "unit-archer", "unit-spearman",
  "unit-conjurer", "unit-warlock",
  "unit-cleric", "unit-necrolyte",
  "unit-midevh", "unit-lothar",
  "unit-garona", "unit-grizelda",
  "unit-water-elemental", "unit-daemon",
  "unit-scorpion", "unit-spider",
  "unit-human-farm", "unit-orc-farm",
  "unit-human-barracks", "unit-orc-barracks",
  "unit-human-church", "unit-orc-temple",
  "unit-human-tower", "unit-orc-tower",
  "unit-human-town-hall", "unit-orc-town-hall",
  "unit-human-lumber-mill", "unit-orc-lumber-mill",
  "unit-human-stable", "unit-orc-kennel",
  "unit-human-blacksmith", "unit-orc-blacksmith",
  "unit-stormwind-keep", "unit-blackrock-spire",
  "unit-peasant-with-wood", "unit-peon-with-wood",
  "unit-peasant-with-gold", "unit-peon-with-gold",
  "unit-ogre",
  "unit-slime",
  "unit-fire-elemental",
  "unit-brigand",
  "unit-skeleton",
  "unit-the-dead",
  "unit-wounded",
  "unit-dead-body",
  "unit-wall",
  "unit-destroyed-1x1-place", "unit-destroyed-2x2-place",
  "unit-destroyed-3x3-place", "unit-destroyed-4x4-place",
--56
  "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman", "unit-footman", "unit-footman",
  "unit-footman", "unit-footman",
--92
  "unit-gold-mine",
  "unit-footman",
--94
  "unit-human-start-location", "unit-orc-start-location"
)

DefineMissileTypeWcNames(
  "missile-lightning",
  "missile-fireball", "missile-blizzard",
  "missile-heal-effect",
  "missile-catapult-projectile",
  "missile-arrow",
  "missile-small-fire", "missile-big-fire",
  "missile-normal-spell", "missile-explosion",
  "missile-daemon-fire",
  "missile-green-cross", "missile-none", "missile-blizzard-hit"
)

DefineIconWcNames(
  "icon-footman", "icon-grunt",
  "icon-conjurer", "icon-warlock",
  "icon-peasant", "icon-peon",
  "icon-human-catapult", "icon-orc-catapult",
  "icon-knight", "icon-raider",
  "icon-archer", "icon-spearman",
  "icon-cleric", "icon-necrolyte",
  "icon-human-farm", "icon-orc-farm",
  "icon-human-barracks", "icon-orc-barracks",
  "icon-human-tower", "icon-orc-tower",
  "icon-human-town-hall", "icon-orc-town-hall",
  "icon-human-lumber-mill", "icon-orc-lumber-mill",
  "icon-human-stable", "icon-orc-kennel",
  "icon-human-blacksmith", "icon-orc-blacksmith",
  "icon-human-church", "icon-orc-temple",
  "icon-gold-mine",
  "icon-stormwind-keep", "icon-blackrock-spire",
  "icon-move-peasant", "icon-move-peon",
  "icon-repair",
  "icon-harvest",
  "icon-build-basic",
  "icon-build-advanced",
  "icon-return-goods",
  "icon-cancel",
  "icon-wall",
  "icon-road",
  "icon-ogre",
  "icon-spider",
  "icon-slime",
  "icon-fire-elemental",
  "icon-scorpion",
  "icon-the-dead",
  "icon-skeleton",
  "icon-daemon",
  "icon-water-elemental",
  "icon-lothar", "icon-midevh",
  "icon-garona", "icon-grizelda",
  "icon-wounded",
  "icon-brigand",
  "icon-holy-lance",
  "icon-elemental-blast",
  "icon-shadow-spear",
  "icon-fireball",
  "icon-sword1", "icon-sword2", "icon-sword3",
  "icon-axe1", "icon-axe2", "icon-axe3",
  "icon-wolves1", "icon-wolves2",
  "icon-arrow1", "icon-arrow2", "icon-arrow3",
  "icon-spear1", "icon-spear2", "icon-spear3",
  "icon-horse1", "icon-horse2",
  "icon-human-shield1", "icon-human-shield2", "icon-human-shield3",
  "icon-orc-shield1", "icon-orc-shield2", "icon-orc-shield3",
  "icon-healing",
  "icon-far-seeing",
  "icon-invisibility",
  "icon-rain-of-fire",
  "icon-raise-dead",
  "icon-dark-vision",
  "icon-unholy-armor",
  "icon-poison-cloud",
  "icon-human-patrol-land", "icon-orc-patrol-land",
  "icon-human-stand-ground", "icon-orc-stand-ground",
  "icon-human-attack-ground", "icon-orc-attack-ground"
)

DefineUpgradeWcNames(
  "upgrade-sword1", "upgrade-sword2",
  "upgrade-axe1", "upgrade-axe2",
  "upgrade-arrow1", "upgrade-arrow2",
  "upgrade-spear1", "upgrade-spear2",
  "upgrade-horse1", "upgrade-horse2",
  "upgrade-wolves1", "upgrade-wolves2",
  "upgrade-human-shield1", "upgrade-human-shield2",
  "upgrade-orc-shield1", "upgrade-orc-shield2",
  "upgrade-healing", "upgrade-far-seeing", "upgrade-invisibility",
  "upgrade-raise-dead", "upgrade-dark-vision", "upgrade-unholy-armor",
  "upgrade-scorpion", "upgrade-rain-of-fire", "upgrade-water-elemental",
  "upgrade-spider", "upgrade-poison-cloud", "upgrade-daemon"
)

DefineAiWcNames(
  "land-attack", "passive", "orc-03", "hum-04", "orc-04", "hum-05", "orc-05",
  "hum-06", "orc-06", "hum-07", "orc-07", "hum-08", "orc-08", "hum-09", "orc-09",
  "hum-10", "orc-10", "hum-11", "orc-11", "hum-12", "orc-12", "hum-13", "orc-13",
  "hum-14-orange", "orc-14-blue", "sea-attack", "air-attack", "hum-14-red",
  "hum-14-white", "hum-14-black", "orc-14-green", "orc-14-white", "orc-exp-04",
  "orc-exp-05", "orc-exp-07a", "orc-exp-09", "orc-exp-10", "orc-exp-12", "orc-exp-06a",
  "orc-exp-06b", "orc-exp-11a", "orc-exp-11b", "hum-exp-02a-red", "hum-exp-02b-black",
  "hum-exp-02c-yellow", "hum-exp-03a-orange", "hum-exp-03b-red", "hum-exp-03c-violet",
  "hum-exp-04a-black", "hum-exp-04b-red", "hum-exp-04c-white", "hum-exp-05a-green",
  "hum-exp-05b-orange", "hum-exp-05c-violet", "hum-exp-05d-yellow", "hum-exp-06a-green",
  "hum-exp-06b-black", "hum-exp-06c-orange", "hum-exp-06d-red", "hum-exp-08a-white",
  "hum-exp-08b-yellow", "hum-exp-08c-violet", "hum-exp-09a-black", "hum-exp-09b-red",
  "hum-exp-09c-green", "hum-exp-09d-white", "hum-exp-10a-violet", "hum-exp-10b-green",
  "hum-exp-10c-black", "hum-exp-11a", "hum-exp-11b", "hum-exp-12a", "orc-exp-05b",
  "hum-exp-07a", "hum-exp-07b", "hum-exp-07c", "orc-exp-12a", "orc-exp-12b", "orc-exp-12c",
  "orc-exp-12d", "orc-exp-02", "orc-exp-07b", "orc-exp-03",
-- Some additionals scripts
  "gruntrush", "goldfever",
  "fca-01", "fca-02", "fca-03", "fca-04", "fca-05", "fca-06", "fca-07", "fca-08", "fca-09",
  "fca-10", "fca-11", "fca-12", "fca-13", "fca-14", "fca-15", "fca-16", "fca-17", "fca-18",
  "fcm-01", "fcm-02", "fcm-03", "fcm-04", "fcm-05", "fcm-06", "fcm-07", "fcm-08", "fcm-09",
  "fcm-10", "fcm-11", "fcm-12", "fcm-13", "fcm-14", "fcm-15", "fcm-16", "fcm-17", "fcm-18")
]]
