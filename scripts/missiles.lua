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
--      missiles.lua - Define the used missiles.
--
--      (c) Copyright 1998-2004 by Lutz Sammer, Fabrice Rossi,
--                                 Jimmy Salmon and Crestez Leonard
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

DefineMissileType("missile-arrow",
  { File = "missiles/arrow.png", Size = {64, 64}, Frames = 5, NumDirections = 5,
  DrawLevel = 50, ImpactSound = "bow hit",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 32, Range = 0 } )

DefineMissileType("missile-catapult-rock",
  { File = "missiles/catapult_projectile.png", Size = {64, 64}, Frames = 15, NumDirections = 9,
  ImpactSound = "explosion",
  DrawLevel = 50, Class = "missile-class-parabolic", Sleep = 1, Speed = 3, Range = 2,
  ImpactMissile = "missile-explosion", SplashFactor = 4 } )

DefineMissileType("missile-small-fire",
  { File = "missiles/small_fire.png", Size = {32, 64}, Frames = 4, NumDirections = 1,
  DrawLevel = 245, Class = "missile-class-fire", Sleep = 8, Speed = 16, Range = 1 } )

DefineMissileType("missile-big-fire",
  { File = "missiles/large_fire.png", Size = {32, 64}, Frames = 4, NumDirections = 1,
  DrawLevel = 245, Class = "missile-class-fire", Sleep = 8, Speed = 16, Range = 1 } )

DefineMissileType("missile-explosion",
  { File = "missiles/explosion.png", Size = {96, 96}, Frames = 6, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-normal-spell",
  { File = "missiles/healing.png", Size = {32, 32}, Frames = 6, NumDirections = 1,
    DrawLevel = 50, Class = "missile-class-stay", Sleep = 5, Speed = 0, Range = 1 } )

DefineMissileType("missile-magic-fireball",
  { File = "missiles/fireball.png", Size = {64, 64}, Frames = 5, NumDirections = 5,
    DrawLevel = 200, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 8, Range = 0 } )

DefineMissileType("missile-fireball",
  { File = "missiles/fireball_2.png", Size = {64, 64}, Frames = 2, NumDirections = 5,
    DrawLevel = 50, ImpactSound = "bow hit",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 8, Range = 0 } )

DefineMissileType("missile-water",
  { File = "missiles/water_elemental_projectile.png", Size = {64, 64}, Frames = 2, NumDirections = 5,
    DrawLevel = 50, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 8, Range = 0 } )

DefineMissileType("missile-rain-of-fire",
  { File = "missiles/rain_of_fire.png", Size = {32, 32}, Frames = 7, NumDirections = 1,
  Class = "missile-class-point-to-point-with-hit", Sleep = 2, Speed = 8, Range = 1,
  DrawLevel = 100 } )

DefineMissileType("missile-poison-cloud",
  { File = "missiles/poison_cloud.png", Size = {128, 128}, Frames = 4, NumDirections = 1,
  Class = "missile-class-point-to-point-with-hit", Sleep = 2, Speed = 8, Range = 1,
  DrawLevel = 100 } )

DefineMissileType("missile-none",
  { Size = {32, 32}, DrawLevel = 50,
  Class = "missile-class-none", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-hit",
  { Size = {15, 15}, DrawLevel = 150,
  Class = "missile-class-hit", Sleep = 1, Speed = 1, Range = 16 } )

DefineMissileType("missile-building-collapse",
  { File = "missiles/building_collapse.png", Size = {96, 128}, Frames = 17, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 2, Speed = 1, Range = 1 } )

DefineBurningBuilding(
  {"percent", 0, "missile", "missile-big-fire"},
  {"percent", 50, "missile", "missile-small-fire"},
  {"percent", 75 } -- no missile
)
