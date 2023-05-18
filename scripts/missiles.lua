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
  { File = "missiles/arrow.png", Size = {32, 32}, Frames = 5, NumDirections = 9,
  DrawLevel = 50, ImpactSound = "bow hit",
  Class = "missile-class-point-to-point", Sleep = 1, Speed = 16, Range = 0 } )

DefineMissileType("missile-catapult-rock",
  { File = "missiles/catapult_projectile.png", Size = {32, 32}, Frames = 15, NumDirections = 9,
  ImpactSound = "explosion",
  DrawLevel = 200, Class = "missile-class-parabolic", Sleep = 1, Speed = 3, Range = 2,
  ImpactMissile = "missile-explosion", SplashFactor = 4 } )

DefineMissileType("missile-small-fire",
  { File = "missiles/small_fire.png", Size = {16, 32}, Frames = 4, NumDirections = 1,
  DrawLevel = 245, Class = "missile-class-fire", Sleep = 8, Speed = 16, Range = 1 } )

DefineMissileType("missile-big-fire",
  { File = "missiles/large_fire.png", Size = {16, 32}, Frames = 4, NumDirections = 1,
  DrawLevel = 245, Class = "missile-class-fire", Sleep = 8, Speed = 16, Range = 1 } )

DefineMissileType("missile-explosion",
  { File = "missiles/explosion.png", Size = {48, 48}, Frames = 6, NumDirections = 1,
  DrawLevel = 200, Class = "missile-class-stay", Sleep = 6, Speed = 16, Range = 1 } )

DefineMissileType("missile-normal-spell",
  { File = "missiles/healing.png", Size = {16, 16}, Frames = 6, NumDirections = 1,
    DrawLevel = 200, Class = "missile-class-stay", Sleep = 5, Speed = 0, Range = 1 } )

DefineMissileType("missile-magic-fireball",
  { File = "missiles/fireball.png", Size = {32, 32}, Frames = 25, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 3, Range = 0 } )

DefineMissileType("missile-fireball",
  { File = "missiles/fireball_2.png", Size = {32, 32}, Frames = 10, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "bow hit",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 3, Range = 0 } )

DefineMissileType("missile-water",
  { File = "missiles/water_elemental_projectile.png", Size = {32, 32}, Frames = 10, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 3, Range = 0 } )

DefineMissileType("missile-rain-of-fire",
  { File = "missiles/rain_of_fire.png", Size = {16, 16}, Frames = 7, NumDirections = 1,
  Class = "missile-class-point-to-point-with-hit", Sleep = 4, Speed = 8, Range = 1,
  DrawLevel = 100 } )

DefineMissileType("missile-poison-cloud",
  { File = "missiles/poison_cloud.png", Size = {64, 64}, Frames = 4, NumDirections = 1,
  Class = "missile-class-point-to-point-with-hit", Sleep = 8, Speed = 8, Range = 1,
  DrawLevel = 100 } )

DefineMissileType("missile-none",
  { Size = {16, 16}, DrawLevel = 50,
  Class = "missile-class-none", Sleep = 1, Speed = 16, Range = 1 } )

DefineMissileType("missile-hit",
  { Size = {7, 7}, DrawLevel = 150,
  Class = "missile-class-hit", Sleep = 1, Speed = 1, Range = 16 } )

DefineMissileType("missile-building-collapse",
  { File = "missiles/building_collapse.png", Size = {48, 64}, Frames = 17, NumDirections = 1,
  DrawLevel = 50, Class = "missile-class-stay", Sleep = 2, Speed = 1, Range = 1 } )

DefineBurningBuilding(
  {"percent", 0, "missile", "missile-big-fire"},
  {"percent", 50, "missile", "missile-small-fire"},
  {"percent", 75 } -- no missile
)

DefineMissileType("missile-grey-cross",
  { File = "contrib/graphics/missiles/grey_cross.png", Size = {18, 18}, Frames = 6, NumDirections = 1,
  DrawLevel = 150, Class = "missile-class-cycle-once", Sleep = 2, Speed = 111, Range = 1 } )

DefineMissileType("missile-web",
  { File = "contrib/graphics/missiles/missile-web.png", Size = {32, 32}, Frames = 5, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 2, Range = 0 } )

	DefineMissileType("missile-shadow",
  { File = "contrib/graphics/missiles/shadow_spear.png", Size = {32, 32}, Frames = 5, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 2, Range = 0 } )

	DefineMissileType("missile-iceshard",
  { File = "contrib/graphics/missiles/ice-shard.png", Size = {32, 32}, Frames = 5, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "fireball attack",
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 2, Range = 0 } )

DefineMissileType("missile-hail",
  { File = "contrib/graphics/missiles/hail.png", Size = {32, 32}, Frames = 4, NumDirections = 1,
  DrawLevel = 200, Class = "missile-class-flame-shield", Sleep = 6, Speed = 14, Range = 1 } )

DefineMissileType("missile-unholy",
  { File = "contrib/graphics/missiles/unholy.png", Size = {20, 20}, Frames = 4, NumDirections = 1,
  DrawLevel = 250, Class = "missile-class-clip-to-target", Sleep = 7, Speed = 11, Range = 1, NumBounces = 35} )

DefineMissileType("missile-invisibility",
  { File = "contrib/graphics/missiles/invisibility.png", Size = {25, 25}, Frames = 4, NumDirections = 1,
  DrawLevel = 250, Class = "missile-class-clip-to-target", Sleep = 13, Speed = 11, Range = 1, NumBounces = 38} )

DefineMissileType("missile-bleeding",
  { File = "contrib/graphics/missiles/bleeding.png", Size = {20, 20}, Frames = 6, NumDirections = 1,
  DrawLevel = 150, Class = "missile-class-stay", Sleep = 4, Speed = 111, Range = 1 } )

DefineMissileType("missile-blood-pool",
  { File = "contrib/graphics/missiles/blood-pool.png", Size = {10, 10}, Frames = 6, NumDirections = 1,
  DrawLevel = 10, Class = "missile-class-stay", Sleep =  425, Speed = 111, Range = 1 } )
  
DefineMissileType("missile-blood-in-impact",
  { File = "contrib/graphics/missiles/blood-in-impact.png", Size = {10, 10}, Frames = 6, NumDirections = 1,
  DrawLevel = 150, Class = "missile-class-stay", Sleep = 3, Speed = 111, Range = 1 } )  
  
DefineMissileType("missile-blood-footprint",
  { File = "contrib/graphics/missiles/blood-footprint.png", Size = {10, 10}, Frames = 6, NumDirections = 1,
  DrawLevel = 10, Class = "missile-class-stay", Sleep =  55, Speed = 111, Range = 1 } )

DefineMissileType("missile-bleeding-walk",
  { File = "contrib/graphics/missiles/bleeding-walk.png", Size = {20, 20}, Frames = 10, NumDirections = 1,
  DrawLevel = 150, Class = "missile-class-stay", Sleep = 4, Speed = 111, Range = 1 } )
