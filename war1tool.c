//       _________ __                 __                               
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/ 
//  ______________________                           ______________________
//			  T H E   W A R   B E G I N S
//   Utility for Stratagus - A free fantasy real time strategy game engine
//
/**@name war1tool.c	-	Extract files from war archives. */
//
//	(c) Copyright 2003 by Jimmy Salmon
//
//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; version 2 dated June, 1991.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program; if not, write to the Free Software
//      Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
//      02111-1307, USA.
//
//	$Id$

//@{

/*----------------------------------------------------------------------------
--	Includes
----------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef _MSC_VER
#include <fcntl.h>
#endif
#include <ctype.h>
#include <png.h>

#include "stratagus.h"
#include "iocompat.h"
#include "myendian.h"

#if defined(_MSC_VER) || defined(__MINGW32__) || defined(USE_BEOS)
typedef unsigned long u_int32_t;
#endif

//----------------------------------------------------------------------------
//	Config
//----------------------------------------------------------------------------

/**
**	Destination directory of the graphics
*/
char* Dir;

/**
**	Path to the tileset graphics. (default=$DIR/graphics/tilesets)
*/
#define TILESET_PATH	"graphics/tilesets"

/**
**	Path to the unit graphics. (default=$DIR/graphics)
*/
#define UNIT_PATH	"graphics"

/**
**	Path the cm files. (default=$DIR)
*/
#define CM_PATH	"."

/**
**	Path the cursor files. (default=$DIR/graphic/ui/)
*/
#define CURSOR_PATH	"graphics/ui"

/**
**	Path the graphic files. (default=$DIR/graphic)
*/
#define GRAPHIC_PATH	"graphics"

/**
**	Path the sound files. (default=$DIR/sounds)
*/
#define SOUND_PATH	"sounds"

/**
**	Path the sound files. (default=$DIR/music)
*/
#define MUSIC_PATH	"music"

/**
**	Path the text files. (default=$DIR/texts)
*/
#define TEXT_PATH	"campaigns"

/**
**	Path the flc files. (default=$DIR/)
*/
#define FLC_PATH	"flc"

/**
**	How much tiles are stored in a row.
*/
#define TILE_PER_ROW	16

//----------------------------------------------------------------------------

/**
**	Conversion control sturcture.
*/
typedef struct _control_ {
    int		Type;			/// Entry type
    int		Version;		/// Only in this version
    char*	File;			/// Save file
    int		Arg1;			/// Extra argument 1
    int		Arg2;			/// Extra argument 2
    int		Arg3;			/// Extra argument 3
    int		Arg4;			/// Extra argument 4
} Control;

/**
**	Original archive buffer.
*/
unsigned char* ArchiveBuffer;

/**
**	Offsets for each entry into original archive buffer.
*/
unsigned char** ArchiveOffsets;

/**
**	Archive length
*/
int ArchiveLength;

/**
**	Possible entry types of archive file.
*/
enum _archive_type_ {
    F,			// File				(name)
    T,			// Tileset			(name,idx)
    R,			// RGB -> gimp			(name,rgb)
    U,			// Uncompressed Graphics	(name,pal,gfu)
    I,			// Image			(name,pal,img)
    W,			// Wav				(name,wav)
    X,			// Text				(name,text,ofs)
    X2,			// Text2			(name,text)
    C,			// Cursor			(name,cursor)
    FLC,		// FLC
    VOC,		// VOC
    CM,			// Cm
};

char* ArchiveDir;

/**
**	What, where, how to extract.
*/
Control Todo[] = {
#define __	,0,0,0
#define _2	,0,0,

{FLC,0,"cave1.war",					   0 __},
{FLC,0,"cave2.war",					   0 __},
{FLC,0,"cave3.war",					   0 __},
{FLC,0,"hfinale.war",					   0 __},
{FLC,0,"hintro1.war",					   0 __},
{FLC,0,"hintro2.war",					   0 __},
{FLC,0,"hmap01.war",					   0 __},
{FLC,0,"hmap02.war",					   0 __},
{FLC,0,"hmap03.war",					   0 __},
{FLC,0,"hmap04.war",					   0 __},
{FLC,0,"hmap05.war",					   0 __},
{FLC,0,"hmap06.war",					   0 __},
{FLC,0,"hmap07.war",					   0 __},
{FLC,0,"hmap08.war",					   0 __},
{FLC,0,"hmap09.war",					   0 __},
{FLC,0,"hmap10.war",					   0 __},
{FLC,0,"hmap11.war",					   0 __},
{FLC,0,"hmap12.war",					   0 __},
{FLC,0,"lose1.war",					   0 __},
{FLC,0,"lose2.war",					   0 __},
{FLC,0,"ofinale.war",					   0 __},
{FLC,0,"ointro1.war",					   0 __},
{FLC,0,"ointro2.war",					   0 __},
{FLC,0,"ointro3.war",					   0 __},
{FLC,0,"omap01.war",					   0 __},
{FLC,0,"omap02.war",					   0 __},
{FLC,0,"omap03.war",					   0 __},
{FLC,0,"omap04.war",					   0 __},
{FLC,0,"omap05.war",					   0 __},
{FLC,0,"omap06.war",					   0 __},
{FLC,0,"omap07.war",					   0 __},
{FLC,0,"omap08.war",					   0 __},
{FLC,0,"omap09.war",					   0 __},
{FLC,0,"omap10.war",					   0 __},
{FLC,0,"omap11.war",					   0 __},
{FLC,0,"omap12.war",					   0 __},
{FLC,0,"title.war",					   0 __},
{FLC,0,"win1.war",					   0 __},
{FLC,0,"win2.war",					   0 __},

///////////////////////////////////////////////////////////////////////////////
//	MOST THINGS
///////////////////////////////////////////////////////////////////////////////

#ifdef USE_BEOS
{F,0,"DATA.WAR",					   0 __},
#else
{F,0,"data.war",					   0 __},
#endif

{CM,0,"puds/human 1",					 117, 63 _2},
{CM,0,"puds/human 2",					 119, 55 _2},
{CM,0,"puds/human 3",					 121, 69 _2},
{CM,0,"puds/human 4",					 123, 97 _2},
{CM,0,"puds/human 5",					 125, 57 _2},
{CM,0,"puds/human 6",					 127, 47 _2},
{CM,0,"puds/human 7",					 129, 67 _2},
{CM,0,"puds/human 8",					 131, 95 _2},
{CM,0,"puds/human 9",					 133, 71 _2},
{CM,0,"puds/human 10",					 135, 73 _2},
{CM,0,"puds/human 11",					 137, 75 _2},
{CM,0,"puds/human 12",					 139, 77 _2},
{CM,0,"puds/orc 1",					 118, 79 _2},
{CM,0,"puds/orc 2",					 120, 81 _2},
{CM,0,"puds/orc 3",					 122, 49 _2},
{CM,0,"puds/orc 4",					 124, 93 _2},
{CM,0,"puds/orc 5",					 126, 83 _2},
{CM,0,"puds/orc 6",					 128, 65 _2},
{CM,0,"puds/orc 7",					 130, 85 _2},
{CM,0,"puds/orc 8",					 132, 99 _2},
{CM,0,"puds/orc 9",					 134, 87 _2},
{CM,0,"puds/orc 10",					 136, 53 _2},
{CM,0,"puds/orc 11",					 138, 45 _2},
{CM,0,"puds/orc 12",					 140, 59 _2},

// Tilesets
{R,0,"forest/forest",					 191 __},
{T,0,"forest/terrain",					 190 __},
{R,0,"swamp/swamp",					 194 __},
{T,0,"swamp/terrain",					 193 __},
{R,0,"dungeon/dungeon",					 197 __},
{T,0,"dungeon/terrain",					 196 __},

// Some animations
{U,0,"425",						 424, 425 _2},
{U,0,"426",						 424, 426 _2},
{U,0,"427",						 424, 427 _2},
{U,0,"428",						 423, 428 _2},
{U,0,"429",						 423, 429 _2},
{U,0,"430",						 423, 430 _2},
{U,0,"431",						 423, 431 _2},
{U,0,"460",						 459, 460 _2},

// Text
{X2,0,"human/01/objectives",				 117 __},
{X2,0,"orc/01/objectives",				 118 __},
{X2,0,"human/02/objectives",				 119 __},
{X2,0,"orc/02/objectives",				 120 __},
{X2,0,"human/03/objectives",				 121 __},
{X2,0,"orc/03/objectives",				 122 __},
{X2,0,"human/04/objectives",				 123 __},
{X2,0,"orc/04/objectives",				 124 __},
{X2,0,"human/05/objectives",				 125 __},
{X2,0,"orc/05/objectives",				 126 __},
{X2,0,"human/06/objectives",				 127 __},
{X2,0,"orc/06/objectives",				 128 __},
{X2,0,"human/07/objectives",				 129 __},
{X2,0,"orc/07/objectives",				 130 __},
{X2,0,"human/08/objectives",				 131 __},
{X2,0,"orc/08/objectives",				 132 __},
{X2,0,"human/09/objectives",				 133 __},
{X2,0,"orc/09/objectives",				 134 __},
{X2,0,"human/10/objectives",				 135 __},
{X2,0,"orc/10/objectives",				 136 __},
{X2,0,"human/11/objectives",				 137 __},
{X2,0,"orc/11/objectives",				 138 __},
{X2,0,"human/12/objectives",				 139 __},
{X2,0,"orc/12/objectives",				 140 __},
{X,0,"human/01/intro",					 432 __},
{X,0,"orc/01/intro",					 433 __},
{X,0,"human/02/intro",					 434 __},
{X,0,"orc/02/intro",					 435 __},
{X,0,"human/03/intro",					 436 __},
{X,0,"orc/03/intro",					 437 __},
{X,0,"human/04/intro",					 438 __},
{X,0,"orc/04/intro",					 439 __},
{X,0,"human/05/intro",					 440 __},
{X,0,"orc/05/intro",					 441 __},
{X,0,"human/06/intro",					 442 __},
{X,0,"orc/06/intro",					 443 __},
{X,0,"human/07/intro",					 444 __},
{X,0,"orc/07/intro",					 445 __},
{X,0,"human/08/intro",					 446 __},
{X,0,"orc/08/intro",					 447 __},
{X,0,"human/09/intro",					 448 __},
{X,0,"orc/09/intro",					 449 __},
{X,0,"human/10/intro",					 450 __},
{X,0,"orc/10/intro",					 451 __},
{X,0,"human/11/intro",					 452 __},
{X,0,"orc/11/intro",					 453 __},
{X,0,"human/12/intro",					 454 __},
{X,0,"orc/12/intro",					 455 __},
{X,0,"human/ending 1",					 461 __},
{X,0,"orc/ending 1",					 462 __},
{X,0,"human/ending 2",					 463 __},
{X,0,"orc/ending 2",					 464 __},
{X,0,"credits",						 465 __},
{X,0,"victory dialog 1",				 466 __},
{X,0,"victory dialog 2",				 467 __},
{X,0,"defeat dialog 1",					 468 __},
{X,0,"defeat dialog 2",					 469 __},

// Cursors
{C,0,"cursors/arrow",					 262, 263 _2},
{C,0,"cursors/invalid command",				 262, 264 _2},
{C,0,"cursors/yellow crosshair",			 262, 265 _2},
{C,0,"cursors/red crosshair",				 262, 266 _2},
{C,0,"cursors/yellow crosshair 2",			 262, 267 _2},
{C,0,"cursors/magnifying glass",			 262, 268 _2},
{C,0,"cursors/small green crosshair",			 262, 269 _2},
{C,0,"cursors/watch",					 262, 270 _2},
{C,0,"cursors/up arrow",				 262, 271 _2},
{C,0,"cursors/upper-right arrow",			 262, 272 _2},
{C,0,"cursors/right arrow",				 262, 273 _2},
{C,0,"cursors/lower-right arrow",			 262, 274 _2},
{C,0,"cursors/down arrow",				 262, 275 _2},
{C,0,"cursors/lower-left arrow",			 262, 276 _2},
{C,0,"cursors/left arrow",				 262, 277 _2},
{C,0,"cursors/upper-left arrow",			 262, 278 _2},

// Unit graphics
{U,0,"tilesets/forest/human/units/footman",		 191, 279 _2},
{U,0,"tilesets/forest/orc/units/grunt",			 191, 280 _2},
{U,0,"tilesets/forest/human/units/peasant",		 191, 281 _2},
{U,0,"tilesets/forest/orc/units/peon",			 191, 282 _2},
{U,0,"tilesets/forest/human/units/catapult",		 191, 283 _2},
{U,0,"tilesets/forest/orc/units/catapult",		 191, 284 _2},
{U,0,"tilesets/forest/human/units/knight",		 191, 285 _2},
{U,0,"tilesets/forest/orc/units/raider",		 191, 286 _2},
{U,0,"tilesets/forest/human/units/archer",		 191, 287 _2},
{U,0,"tilesets/forest/orc/units/spearman",		 191, 288 _2},
{U,0,"tilesets/forest/human/units/conjurer",		 191, 289 _2},
{U,0,"tilesets/forest/orc/units/warlock",		 191, 290 _2},
{U,0,"tilesets/forest/human/units/cleric",		 191, 291 _2},
{U,0,"tilesets/forest/orc/units/necrolyte",		 191, 292 _2},
{U,0,"tilesets/forest/human/units/midevh",		 191, 293 _2},
{U,0,"tilesets/forest/orc/units/lothar",		 191, 294 _2},
{U,0,"tilesets/forest/units/wounded",			 191, 295 _2},
{U,0,"tilesets/forest/units/grizelda,garona",		 191, 296 _2},
{U,0,"tilesets/forest/units/ogre",			 191, 297 _2},
{U,0,"tilesets/forest/units/spider",			 191, 298 _2},
{U,0,"tilesets/forest/units/slime",			 191, 299 _2},
{U,0,"tilesets/forest/units/fire elemental",		 191, 300 _2},
{U,0,"tilesets/forest/units/scorpion",			 191, 301 _2},
{U,0,"tilesets/forest/units/brigand",			 191, 302 _2},
{U,0,"tilesets/forest/units/the dead",			 191, 303 _2},
{U,0,"tilesets/forest/units/skeleton",			 191, 304 _2},
{U,0,"tilesets/forest/units/daemon",			 191, 305 _2},
{U,0,"tilesets/forest/units/water elemental",		 191, 306 _2},
{U,0,"tilesets/forest/neutral/units/dead bodies",	 191, 326 _2},
{U,0,"tilesets/forest/human/units/peasant with wood",	 191, 327 _2},
{U,0,"tilesets/forest/orc/units/peon with wood",	 191, 328 _2},
{U,0,"tilesets/forest/human/units/peasant with gold",	 191, 329 _2},
{U,0,"tilesets/forest/orc/units/peon with gold",	 191, 330 _2},
{U,0,"tilesets/swamp/human/units/footman",		 194, 279 _2},
{U,0,"tilesets/swamp/orc/units/grunt",			 194, 280 _2},
{U,0,"tilesets/swamp/human/units/peasant",		 194, 281 _2},
{U,0,"tilesets/swamp/orc/units/peon",			 194, 282 _2},
{U,0,"tilesets/swamp/human/units/catapult",		 194, 283 _2},
{U,0,"tilesets/swamp/orc/units/catapult",		 194, 284 _2},
{U,0,"tilesets/swamp/human/units/knight",		 194, 285 _2},
{U,0,"tilesets/swamp/orc/units/raider",			 194, 286 _2},
{U,0,"tilesets/swamp/human/units/archer",		 194, 287 _2},
{U,0,"tilesets/swamp/orc/units/spearman",		 194, 288 _2},
{U,0,"tilesets/swamp/human/units/conjurer",		 194, 289 _2},
{U,0,"tilesets/swamp/orc/units/warlock",		 194, 290 _2},
{U,0,"tilesets/swamp/human/units/cleric",		 194, 291 _2},
{U,0,"tilesets/swamp/orc/units/necrolyte",		 194, 292 _2},
{U,0,"tilesets/swamp/human/units/midevh",		 194, 293 _2},
{U,0,"tilesets/swamp/orc/units/lothar",			 194, 294 _2},
{U,0,"tilesets/swamp/units/wounded",			 194, 295 _2},
{U,0,"tilesets/swamp/units/grizelda,garona",		 194, 296 _2},
{U,0,"tilesets/swamp/units/ogre",			 194, 297 _2},
{U,0,"tilesets/swamp/units/spider",			 194, 298 _2},
{U,0,"tilesets/swamp/units/slime",			 194, 299 _2},
{U,0,"tilesets/swamp/units/fire elemental",		 194, 300 _2},
{U,0,"tilesets/swamp/units/scorpion",			 194, 301 _2},
{U,0,"tilesets/swamp/units/brigand",			 194, 302 _2},
{U,0,"tilesets/swamp/units/the dead",			 194, 303 _2},
{U,0,"tilesets/swamp/units/skeleton",			 194, 304 _2},
{U,0,"tilesets/swamp/units/daemon",			 194, 305 _2},
{U,0,"tilesets/swamp/units/water elemental",		 194, 306 _2},
{U,0,"tilesets/swamp/neutral/units/dead bodies",	 194, 326 _2},
{U,0,"tilesets/swamp/human/units/peasant with wood",	 194, 327 _2},
{U,0,"tilesets/swamp/orc/units/peon with wood",		 194, 328 _2},
{U,0,"tilesets/swamp/human/units/peasant with gold",	 194, 329 _2},
{U,0,"tilesets/swamp/orc/units/peon with gold",		 194, 330 _2},
{U,0,"tilesets/dungeon/human/units/footman",		 197, 279 _2},
{U,0,"tilesets/dungeon/orc/units/grunt",		 197, 280 _2},
{U,0,"tilesets/dungeon/human/units/peasant",		 197, 281 _2},
{U,0,"tilesets/dungeon/orc/units/peon",			 197, 282 _2},
{U,0,"tilesets/dungeon/human/units/catapult",		 197, 283 _2},
{U,0,"tilesets/dungeon/orc/units/catapult",		 197, 284 _2},
{U,0,"tilesets/dungeon/human/units/knight",		 197, 285 _2},
{U,0,"tilesets/dungeon/orc/units/raider",		 197, 286 _2},
{U,0,"tilesets/dungeon/human/units/archer",		 197, 287 _2},
{U,0,"tilesets/dungeon/orc/units/spearman",		 197, 288 _2},
{U,0,"tilesets/dungeon/human/units/conjurer",		 197, 289 _2},
{U,0,"tilesets/dungeon/orc/units/warlock",		 197, 290 _2},
{U,0,"tilesets/dungeon/human/units/cleric",		 197, 291 _2},
{U,0,"tilesets/dungeon/orc/units/necrolyte",		 197, 292 _2},
{U,0,"tilesets/dungeon/human/units/midevh",		 197, 293 _2},
{U,0,"tilesets/dungeon/orc/units/lothar",		 197, 294 _2},
{U,0,"tilesets/dungeon/units/wounded",			 197, 295 _2},
{U,0,"tilesets/dungeon/units/grizelda,garona",		 197, 296 _2},
{U,0,"tilesets/dungeon/units/ogre",			 197, 297 _2},
{U,0,"tilesets/dungeon/units/spider",			 197, 298 _2},
{U,0,"tilesets/dungeon/units/slime",			 197, 299 _2},
{U,0,"tilesets/dungeon/units/fire elemental",		 197, 300 _2},
{U,0,"tilesets/dungeon/units/scorpion",			 197, 301 _2},
{U,0,"tilesets/dungeon/units/brigand",			 197, 302 _2},
{U,0,"tilesets/dungeon/units/the dead",			 197, 303 _2},
{U,0,"tilesets/dungeon/units/skeleton",			 197, 304 _2},
{U,0,"tilesets/dungeon/units/daemon",			 197, 305 _2},
{U,0,"tilesets/dungeon/units/water elemental",		 197, 306 _2},
{U,0,"tilesets/dungeon/neutral/units/dead bodies",	 197, 326 _2},
{U,0,"tilesets/dungeon/human/units/peasant with wood",	 197, 327 _2},
{U,0,"tilesets/dungeon/orc/units/peon with wood",	 197, 328 _2},
{U,0,"tilesets/dungeon/human/units/peasant with gold",	 197, 329 _2},
{U,0,"tilesets/dungeon/orc/units/peon with gold",	 197, 330 _2},

// Buildings
{U,0,"human/buildings/farm",				 191, 307 _2},
{U,0,"orc/buildings/farm",				 191, 308 _2},
{U,0,"human/buildings/barracks",			 191, 309 _2},
{U,0,"orc/buildings/barracks",				 191, 310 _2},
{U,0,"human/buildings/church",				 191, 311 _2},
{U,0,"orc/buildings/temple",				 191, 312 _2},
{U,0,"human/buildings/tower",				 191, 313 _2},
{U,0,"orc/buildings/tower",				 191, 314 _2},
{U,0,"human/buildings/town hall",			 191, 315 _2},
{U,0,"orc/buildings/town hall",				 191, 316 _2},
{U,0,"human/buildings/lumber mill",			 191, 317 _2},
{U,0,"orc/buildings/lumber mill",			 191, 318 _2},
{U,0,"human/buildings/stable",				 191, 319 _2},
{U,0,"orc/buildings/kennel",				 191, 320 _2},
{U,0,"human/buildings/blacksmith",			 191, 321 _2},
{U,0,"orc/buildings/blacksmith",			 191, 322 _2},
{U,0,"human/buildings/stormwind keep",			 191, 323 _2},
{U,0,"orc/buildings/blackrock spire",			 191, 324 _2},
{U,0,"neutral/buildings/gold mine",			 191, 325 _2},
{U,0,"human/buildings/farm construction",		 191, 331 _2},
{U,0,"orc/buildings/farm construction",			 191, 332 _2},
{U,0,"human/buildings/barracks construction",		 191, 333 _2},
{U,0,"orc/buildings/barracks construction",		 191, 334 _2},
{U,0,"human/buildings/church construction",		 191, 335 _2},
{U,0,"orc/buildings/temple construction",		 191, 336 _2},
{U,0,"human/buildings/tower construction",		 191, 337 _2},
{U,0,"orc/buildings/tower construction",		 191, 338 _2},
{U,0,"human/buildings/town hall construction",		 191, 339 _2},
{U,0,"orc/buildings/town hall construction",		 191, 340 _2},
{U,0,"human/buildings/lumber mill construction",	 191, 341 _2},
{U,0,"orc/buildings/lumber mill construction",		 191, 342 _2},
{U,0,"human/buildings/stable construction",		 191, 343 _2},
{U,0,"orc/buildings/kennel construction",		 191, 344 _2},
{U,0,"human/buildings/blacksmith construction",		 191, 345 _2},
{U,0,"orc/buildings/blacksmith construction",		 191, 346 _2},

{U,0,"missiles/fireball",				 217, 347 _2},
{U,0,"missiles/catapult projectile",			 191, 348 _2},
{U,0,"missiles/arrow",					 217, 349 _2},
{U,0,"missiles/poison cloud",				 191, 350 _2},
{U,0,"missiles/rain of fire",				 191, 351 _2},
{U,0,"missiles/flames",					 191, 352 _2},
{U,0,"missiles/larger flames",				 191, 353 _2},
{U,0,"missiles/explosion",				 191, 354 _2},
{U,0,"missiles/healing",				 217, 355 _2},
{U,0,"missiles/building collapse",			 191, 356 _2},
{U,0,"missiles/water elemental projectile",		 217, 357 _2},
{U,0,"missiles/fireball 2",				 191, 358 _2},
{U,0,"ui/orc/icon selection boxes",			 191, 359 _2},
{U,0,"ui/human/icon selection boxes",			 191, 360 _2},
{U,0,"tilesets/forest/portrait icons",			 191, 361 _2},
{U,0,"tilesets/swamp/portrait icons",			 194, 361 _2},
{U,0,"tilesets/dungeon/portrait icons",			 197, 361 _2},

// Images
{I,0,"ui/logo",						 217, 216 _2},
{I,0,"ui/human/top resource bar",			 191, 218 _2},
{I,0,"ui/orc/top resource bar",				 191, 219 _2},
{I,0,"ui/human/right panel",				 217, 220 _2},
{I,0,"ui/orc/right panel",				 217, 221 _2},
{I,0,"ui/human/bottom panel",				 217, 222 _2},
{I,0,"ui/orc/bottom panel",				 217, 223 _2},
{I,0,"ui/human/minimap",				 217, 224 _2},
{I,0,"ui/orc/minimap",					 217, 225 _2},
{I,0,"ui/human/left panel",				 217, 226 _2},
{I,0,"ui/orc/left panel",				 217, 227 _2},
{I,0,"ui/human/panel 1",				 217, 228 _2},
{I,0,"ui/orc/panel 1",					 217, 229 _2},
{I,0,"ui/human/panel 2",				 217, 233 _2},
{I,0,"ui/orc/panel 2",					 217, 234 _2},
{I,0,"ui/human/panel 3",				 217, 235 _2},
{I,0,"ui/orc/panel 3",					 217, 236 _2},
{I,0,"ui/bottom of title screen",			 260, 243 _2},
{I,0,"ui/human/left arrow",				 255, 244 _2},
{I,0,"ui/orc/left arrow",				 255, 245 _2},
{I,0,"ui/human/right arrow",				 255, 246 _2},
{I,0,"ui/orc/right arrow",				 255, 247 _2},
{I,0,"ui/box",						 255, 248 _2},
{I,0,"ui/human/save game",				 217, 249 _2},
{I,0,"ui/orc/save game",				 217, 250 _2},
{I,0,"ui/hot keys",					 255, 254 _2},
{I,0,"ui/human/ok box",					 255, 256 _2},
{I,0,"ui/orc/ok box",					 255, 257 _2},
{I,0,"ui/top of title screen",				 260, 258 _2},
{I,0,"ui/title screen",					 260, 261 _2},
{I,0,"ui/menu button 1",				 217, 362 _2},
{I,0,"ui/menu button 2",				 217, 363 _2},
{I,0,"ui/human/icon border",				 217, 364 _2},
{I,0,"ui/orc/icon border",				 217, 365 _2},
{I,0,"ui/gold icon 1",					 191, 406 _2},
{I,0,"ui/lumber icon 1",				 217, 407 _2},
{I,0,"ui/gold icon 2",					 191, 408 _2},
{I,0,"ui/lumber icon 2",				 217, 409 _2},
{I,0,"ui/percent complete",				 217, 410 _2},
{I,0,"ui/human/outcome windows",			 413, 411 _2},
{I,0,"ui/orc/outcome windows",				 414, 412 _2},
{I,0,"ui/victory scene",				 416, 415 _2},
{I,0,"ui/defeat scene",					 418, 417 _2},
{I,0,"ui/victory text",					 418, 419 _2},
{I,0,"ui/defeat text",					 418, 420 _2},
{I,0,"ui/human briefing",				 423, 421 _2},
{I,0,"ui/orc briefing",					 424, 422 _2},
{I,0,"ui/human/victory 1",				 457, 456 _2},
{I,0,"ui/orc/victory 1",				 459, 458 _2},
{I,0,"ui/human/victory 2",				 457, 470 _2},
{I,0,"ui/orc/victory 2",				 459, 471 _2},

// Sounds
{VOC,0,"misc/building",					 474	__},
{VOC,0,"misc/explosion",				 475	__},
{VOC,0,"missiles/catapult rock fired",			 476	__},
{VOC,0,"misc/tree chopping 1",				 477	__},
{VOC,0,"misc/tree chopping 2",				 478	__},
{VOC,0,"misc/tree chopping 3",				 479	__},
{VOC,0,"misc/tree chopping 4",				 480	__},
{VOC,0,"misc/building collapse 1",			 481	__},
{VOC,0,"misc/building collapse 2",			 482	__},
{VOC,0,"misc/building collapse 3",			 483	__},
{VOC,0,"ui/chime",					 484	__},
{W,0,"ui/click",					 485	__},
{VOC,0,"ui/cancel",					 486	__},
{VOC,0,"missiles/sword attack 1",			 487	__},
{VOC,0,"missiles/sword attack 2",			 488	__},
{VOC,0,"missiles/sword attack 3",			 489	__},
{VOC,0,"missiles/fist attack",				 490	__},
{VOC,0,"missiles/catapult fire explosion",		 491	__},
{VOC,0,"missiles/fireball",				 492	__},
{VOC,0,"missiles/arrow,spear",				 493	__},
{VOC,0,"missiles/arrow,spear hit",			 494	__},
{VOC,0,"human/help 1",					 495	__},
{VOC,0,"orc/help 1",					 496	__},
{W,0,"human/help 2",					 497	__},
{W,0,"orc/help 2",					 498	__},
{VOC,0,"orc/dead",					 499	__},
{VOC,0,"human/dead",					 500	__},
{VOC,0,"orc/work complete",				 501	__},
{W,0,"human/work completed",				 502	__},
{VOC,0,"orc/help 3",					 503	__},
{W,0,"orc/help 4",					 504	__},
{W,0,"human/help 3",					 505	__},
{W,0,"human/help 4",					 506	__},
{VOC,0,"orc/ready",					 507	__},
{W,0,"human/ready",					 508	__},
{VOC,0,"orc/acknowledgement 1",				 509	__},
{VOC,0,"orc/acknowledgement 2",				 510	__},
{VOC,0,"orc/acknowledgement 3",				 511	__},
{VOC,0,"orc/acknowledgement 4",				 512	__},
{W,0,"human/acknowledgement 1",				 513	__},
{W,0,"human/acknowledgement 2",				 514	__},
{VOC,0,"orc/selected 1",				 515	__},
{VOC,0,"orc/selected 2",				 516	__},
{VOC,0,"orc/selected 3",				 517	__},
{VOC,0,"orc/selected 4",				 518	__},
{VOC,0,"orc/selected 5",				 519	__},
{W,0,"human/selected 1",				 520	__},
{W,0,"human/selected 2",				 521	__},
{W,0,"human/selected 3",				 522	__},
{W,0,"human/selected 4",				 523	__},
{W,0,"human/selected 5",				 524	__},
{VOC,0,"orc/annoyed 1",					 525	__},
{VOC,0,"orc/annoyed 2",					 526	__},
{W,0,"orc/annoyed 3",					 527	__},
{W,0,"human/annoyed 1",					 528	__},
{W,0,"human/annoyed 2",					 529	__},
{W,0,"human/annoyed 3",					 530	__},
{W,0,"dead spider,scorpion",				 531	__},
{W,0,"normal spell",					 532	__},
{W,0,"misc/build road",					 533	__},
{W,0,"orc/temple",					 534	__},
{W,0,"human/church",					 535	__},
{W,0,"orc/kennel",					 536	__},
{W,0,"human/stable",					 537	__},
{W,0,"blacksmith",					 538	__},
{W,0,"misc/fire crackling",				 539	__},
{W,0,"cannon",						 540	__},
{W,0,"cannon2",						 541	__},
{W,0,"human ending",					 542	__},
{W,0,"human ending 2",					 543	__},
{W,0,"orc ending",					 544	__},
{W,0,"orc ending 2",					 545	__},
{W,0,"intro 1",						 546	__},
{W,0,"intro 2",						 547	__},
{W,0,"intro 3",						 548	__},
{W,0,"intro 4",						 549	__},
{W,0,"intro 5",						 550	__},
{W,0,"../campaigns/human/01/intro",			 551	__},
{W,0,"../campaigns/human/02/intro",			 552	__},
{W,0,"../campaigns/human/03/intro",			 553	__},
{W,0,"../campaigns/human/04/intro",			 554	__},
{W,0,"../campaigns/human/05/intro",			 555	__},
{W,0,"../campaigns/human/06/intro",			 556	__},
{W,0,"../campaigns/human/07/intro",			 557	__},
{W,0,"../campaigns/human/08/intro",			 558	__},
{W,0,"../campaigns/human/09/intro",			 559	__},
{W,0,"../campaigns/human/10/intro",			 560	__},
{W,0,"../campaigns/human/11/intro",			 561	__},
{W,0,"../campaigns/human/12/intro",			 562	__},
{W,0,"../campaigns/orc/01/intro",			 563	__},
{W,0,"../campaigns/orc/02/intro",			 564	__},
{W,0,"../campaigns/orc/03/intro",			 565	__},
{W,0,"../campaigns/orc/04/intro",			 566	__},
{W,0,"../campaigns/orc/05/intro",			 567	__},
{W,0,"../campaigns/orc/06/intro",			 568	__},
{W,0,"../campaigns/orc/07/intro",			 569	__},
{W,0,"../campaigns/orc/08/intro",			 570	__},
{W,0,"../campaigns/orc/09/intro",			 571	__},
{W,0,"../campaigns/orc/10/intro",			 572	__},
{W,0,"../campaigns/orc/11/intro",			 573	__},
{W,0,"../campaigns/orc/12/intro",			 574	__},
{W,0,"human/defeat",					 575	__},
{W,0,"orc/defeat",					 576	__},
{W,0,"orc/victory 1",					 577	__},
{W,0,"orc/victory 2",					 578	__},
{W,0,"orc/victory 3",					 579	__},
{W,0,"human/victory 1",					 580	__},
{W,0,"human/victory 2",					 581	__},
{W,0,"human/victory 3",					 582	__},

#undef __
#undef _2
};

/**
**	File names.
*/
char* UnitNames[110];

//----------------------------------------------------------------------------
//	TOOLS
//----------------------------------------------------------------------------

/**
**	Check if path exists, if not make all directories.
*/
void CheckPath(const char* path)
{
    char* cp;
    char* s;

    if( *path && path[0]=='.' ) {	// relative don't work
	return;
    }
    cp=strdup(path);
    s=strrchr(cp,'/');
    if( s ) {
	*s='\0';			// remove file
	s=cp;
	for( ;; ) {			// make each path element
	    s=strchr(s,'/');
	    if( s ) {
		*s='\0';
	    }
#ifdef USE_WIN32
	    mkdir(cp);
#else
	    mkdir(cp,0777);
#endif
	    if( s ) {
		*s++='/';
	    } else {
		break;
	    }
	}
    }
    free(cp);
}

/**
**	Given a file name that would appear in a PC archive convert it to what
**	would appear on the Mac.
*/
void ConvertToMac(char *filename)
{
    if (!strcmp(filename, "rezdat.war")) {
	strcpy(filename, "War Resources");
	return;
    }
    if (!strcmp(filename, "strdat.war")) {
	strcpy(filename, "War Strings");
	return;
    }
    if (!strcmp(filename, "maindat.war")) {
	strcpy(filename, "War Data");
	return;
    }
    if (!strcmp(filename, "snddat.war")) {
	strcpy(filename, "War Music");
	return;
    }
    if (!strcmp(filename, "muddat.cud")) {
	strcpy(filename, "War Movies");
	return;
    }
    if (!strcmp(filename, "sfxdat.sud")) {
	strcpy(filename, "War Sounds");
	return;
    }
}

//----------------------------------------------------------------------------
//	PNG
//----------------------------------------------------------------------------

/**
**	Save a png file.
**
**	@param name	File name
**	@param image	Graphic data
**	@param w	Graphic width
**	@param h	Graphic height
**	@param pal	Palette
*/
int SavePNG(const char* name,unsigned char* image,int w,int h
	,unsigned char* pal)
{
    FILE* fp;
    png_structp png_ptr;
    png_infop info_ptr;
    unsigned char** lines;
    int i;

    if( !(fp=fopen(name,"wb")) ) {
	fprintf(stderr,"%s:",name);
	perror("Can't open file");
	return 1;
    }

    png_ptr=png_create_write_struct(PNG_LIBPNG_VER_STRING,NULL,NULL,NULL);
    if( !png_ptr ) {
	fclose(fp);
	return 1;
    }
    info_ptr=png_create_info_struct(png_ptr);
    if( !info_ptr ) {
	png_destroy_write_struct(&png_ptr,NULL);
	fclose(fp);
	return 1;
    }

    if( setjmp(png_ptr->jmpbuf) ) {
	// FIXME: must free buffers!!
	png_destroy_write_struct(&png_ptr,&info_ptr);
	fclose(fp);
	return 1;
    }
    png_init_io(png_ptr,fp);

    // zlib parameters
    png_set_compression_level(png_ptr,Z_BEST_COMPRESSION);

    //	prepare the file information

    info_ptr->width=w;
    info_ptr->height=h;
    info_ptr->bit_depth=8;
    info_ptr->color_type=PNG_COLOR_TYPE_PALETTE;
    info_ptr->interlace_type=0;
    info_ptr->valid|=PNG_INFO_PLTE;
    info_ptr->palette=(void*)pal;
    info_ptr->num_palette=256;

    png_write_info(png_ptr,info_ptr);	// write the file header information

    //	set transformation

    //	prepare image

    lines=malloc(h*sizeof(*lines));
    if( !lines ) {
	png_destroy_write_struct(&png_ptr,&info_ptr);
	fclose(fp);
	return 1;
    }

    for( i=0; i<h; ++i ) {
	lines[i]=image+i*w;
    }

    png_write_image(png_ptr,lines);
    png_write_end(png_ptr,info_ptr);

    png_destroy_write_struct(&png_ptr,&info_ptr);
    fclose(fp);

    free(lines);

    return 0;
}

//----------------------------------------------------------------------------
//	Archive
//----------------------------------------------------------------------------

/**
**	Open the archive file.
**
**	@param file	Archive file name
**	@param type	Archive type requested
*/
int OpenArchive(const char* file,int type)
{
    int f;
    struct stat stat_buf;
    unsigned char* buf;
    unsigned char* cp;
    unsigned char** op;
    int entries;
    int i;

    //
    //	Open the archive file
    //
    f=open(file,O_RDONLY|O_BINARY,0);
    if( f==-1 ) {
	printf("Can't open %s\n",file);
	exit(-1);
    }
    if( fstat(f,&stat_buf) ) {
	printf("Can't fstat %s\n",file);
	exit(-1);
    }
    DebugLevel3("Filesize %ld %ldk\n"
	_C_ (long)stat_buf.st_size _C_ stat_buf.st_size/1024);

    //
    //	Read in the archive
    //
    buf=malloc(stat_buf.st_size);
    if( !buf ) {
	printf("Can't malloc %ld\n",(long)stat_buf.st_size);
	exit(-1);
    }
    if( read(f,buf,stat_buf.st_size)!=stat_buf.st_size ) {
	printf("Can't read %ld\n",(long)stat_buf.st_size);
	exit(-1);
    }
    close(f);

    cp=buf;
    i=FetchLE32(cp);
    DebugLevel2("Magic\t%08X\t" _C_ i);
    if( i!=0x19 && i!=0x18 ) {
	printf("Wrong magic %08x, expected %08x or %08x\n",i,0x00000019,0x00000018);
	exit(-1);
    }
    entries=FetchLE16(cp);
    DebugLevel3("Entries\t%5d\t" _C_ entries);
    i=FetchLE16(cp);
    DebugLevel3("ID\t%d\n" _C_ i);
    if( i!=type ) {
	printf("Wrong type %08x, expected %08x\n",i,type);
	exit(-1);
    }

    //
    //	Read offsets.
    //
    op=malloc((entries+1)*sizeof(unsigned char**));
    if( !op ) {
	printf("Can't malloc %d entries\n",entries);
	exit(-1);
    }
    for( i=0; i<entries; ++i ) {
	op[i]=buf+FetchLE32(cp);
	DebugLevel3("Offset\t%d\n" _C_ op[i]);
    }
    op[i]=buf+stat_buf.st_size;

    ArchiveOffsets=op;
    ArchiveBuffer=buf;
    ArchiveLength=stat_buf.st_size;

    return 0;
}

/**
**	Extract/uncompress entry.
**
**	@param cp	Pointer to compressed entry
**	@param lenp	Return pointer of length of the entry
**
**	@return		Pointer to uncompressed entry
*/
unsigned char* ExtractEntry(unsigned char* cp,int* lenp)
{
    unsigned char* dp;
    unsigned char* dest;
    int uncompressed_length;
    int flags;

    uncompressed_length=FetchLE32(cp);
    flags=uncompressed_length>>24;
    uncompressed_length&=0x00FFFFFF;
    DebugLevel3("Entry length %8d flags %02x\t" _C_ uncompressed_length _C_ flags);

    if( uncompressed_length+(cp-ArchiveBuffer)>=ArchiveLength ) {
	printf("Entry goes past end of file\n");
	return NULL;
    }

    dp=dest=malloc(uncompressed_length);
    if( !dest ) {
	printf("Can't malloc %d\n",uncompressed_length);
	exit(-1);
    }

    if( flags==0x20 ) {
	unsigned char buf[4096];
	unsigned char* ep;
	int bi;

	DebugLevel3("Compressed entry\n");

	bi=0;
	memset(buf,0,sizeof(buf));
	ep=dp+uncompressed_length;

	// FIXME: If the decompression is too slow, optimise this loop :->
	while( dp<ep ) {
	    int i;
	    int bflags;

	    bflags=FetchByte(cp);
	    DebugLevel3("Ctrl %02x " _C_ bflags);
	    for( i=0; i<8; ++i ) {
		int j;
		int o;

		if( bflags&1 ) {
		    j=FetchByte(cp);
		    *dp++=j;
		    buf[bi++&0xFFF]=j;
		    DebugLevel3("=%02x" _C_ j);
		} else {
		    o=FetchLE16(cp);
		    DebugLevel3("*%d,%d" _C_ o>>12 _C_ o&0xFFF);
		    j=(o>>12)+3;
		    o&=0xFFF;
		    while( j-- ) {
			buf[bi++&0xFFF]=*dp++=buf[o++&0xFFF];
			if( dp==ep ) {
			    break;
			}
		    }
		}
		if( dp==ep ) {
		    break;
		}
		bflags>>=1;
	    }
	    DebugLevel3("\n");
	}
	//if( dp!=ep ) printf("%p,%p %d\n",dp,ep,dp-dest);
    } else if( flags==0x00 ) {
	DebugLevel3("Uncompressed entry\n");
	memcpy(dest,cp,uncompressed_length);
    } else {
	printf("Unknown flags %x\n",flags);
	free(dest);
	return NULL;
    }

    if( lenp ) {			// return resulting length
	*lenp=uncompressed_length;
    }

    return dest;
}

/**
**	Close the archive file.
*/
int CloseArchive(void)
{
    free(ArchiveBuffer);
    free(ArchiveOffsets);
    ArchiveBuffer=0;
    ArchiveOffsets=0;

    return 0;
}

//----------------------------------------------------------------------------
//	FLC
//----------------------------------------------------------------------------

char FLCFile[1024];
unsigned char FLCPalette[256*3];
int FLCWidth;
int FLCHeight;
unsigned char* FLCImage;
int FLCFrame;

/**
**	Convert FLC COLOR256
*/
void ConvertFLC_COLOR256(unsigned char* buf)
{
    int packets;
    unsigned char* p;
    int skip;
    int color_count;
    int index;

    index=0;
    p=buf;

    packets=FetchLE16(p);
    for( ; packets; --packets ) {
	skip=FetchByte(p);
	index+=skip;
	color_count=FetchByte(p);
	if( color_count==0 ) {
	    color_count=256;
	}
	for( ; color_count; --color_count ) {
	    FLCPalette[index*3+0]=FetchByte(p);
	    FLCPalette[index*3+1]=FetchByte(p);
	    FLCPalette[index*3+2]=FetchByte(p);
	    ++index;
	}
    }
}

/**
**	Convert FLC SS2
*/
void ConvertFLC_SS2(unsigned char* buf)
{
    unsigned char* p;
    int lines;
    int packets;
    int w;
    unsigned char* i;
    int skip;
    char type;
    int packet;
    int skiplines;
    char pngbuf[1024];

    p=buf;
    lines=FetchLE16(p);
    skiplines=0;

    for( ; lines; --lines) {
	i=FLCImage+FLCWidth*skiplines;
	w=FetchLE16(p);
	if( (w&0xC0) == 0 ) {
	    packets=w;
	    for( ; packets; --packets ) {
		skip=FetchByte(p);
		i+=skip;
		type=FetchByte(p);
		if( type>0 ) {
		    for( ; type; --type ) {
			*(unsigned short*)i=FetchLE16(p);
			i+=2;
		    }
		} else {
		    packet=FetchLE16(p);
		    for( ; type; ++type ) {
			*(unsigned short*)i=packet;
			i+=2;
		    }
		}
	    }
	} else if( (w&0xC000) == 0x8000 ) {
	    printf("SS2 low order byte stored in last byte of line\n");
	} else if( (w&0xC000) == 0xC000 ) {
	    skip=-(short)w;
	    skiplines+=skip-1; // -1 because of ++skiplines below
	} else {
	    printf("SS2 error\n");
	    return;
	}
	++skiplines;
    }

    sprintf(pngbuf,"%s-%02d.png",FLCFile,FLCFrame++);
    SavePNG(pngbuf,FLCImage,FLCWidth,FLCHeight,FLCPalette);
}

/**
**	Convert FLC LC
*/
void ConvertFLC_LC(unsigned char* buf)
{
    unsigned char* p;
    int lines;
    int packets;
    unsigned char x;
    unsigned char* i;
    int skip;
    char type;
    unsigned char packet;
    int skiplines;
    char pngbuf[1024];

    p=buf;
    skiplines=FetchLE16(p);
    lines=FetchLE16(p);

    for( ; lines; --lines) {
	x=FetchByte(p);
	packets=FetchByte(p);
	i=FLCImage+FLCWidth*skiplines+x;
	for( ; packets; --packets ) {
	    skip=FetchByte(p);
	    i+=skip;
	    type=FetchByte(p);
	    if( type>0 ) {
		for( ; type; --type ) {
		    *i++=FetchByte(p);
		}
	    } else {
		packet=FetchByte(p);
		for( ; type; ++type ) {
		    *i++=packet;
		}
	    }
	}
	++skiplines;
    }

    sprintf(pngbuf,"%s-%02d.png",FLCFile,FLCFrame++);
    SavePNG(pngbuf,FLCImage,FLCWidth,FLCHeight,FLCPalette);
}

/**
**	Convert FLC BRUN
*/
void ConvertFLC_BRUN(unsigned char* buf)
{
    unsigned char* p;
    unsigned char* i;
    char type;
    unsigned char pixel;
    int h;
    int w;
    char pngbuf[1024];

    p=buf;
    i=FLCImage;

    for( h=FLCHeight; h; --h ) {
	++p; // ignore first byte
	for( w=FLCWidth; w; ) {
	    type=FetchByte(p);

	    if( type<0 ) {
		for( ; type; ++type ) {
		    *i++=FetchByte(p);
		    --w;
		}
	    } else {
		pixel=FetchByte(p);
		for( ; type; --type ) {
		    *i++=pixel;
		    --w;
		}
	    }
	}
    }

    sprintf(pngbuf,"%s-%02d.png",FLCFile,FLCFrame++);
    SavePNG(pngbuf,FLCImage,FLCWidth,FLCHeight,FLCPalette);
}

/**
**	Convert FLC COPY
*/
void ConvertFLC_COPY(unsigned char* buf)
{
    unsigned char* p;
    unsigned char* i;
    int h;
    int w;
    char pngbuf[1024];

    p=buf;
    i=FLCImage;

    for( h=FLCHeight; h; --h ) {
	for( w=FLCWidth; w; --w ) {
	    *i++=FetchByte(p);
	}
    }

    sprintf(pngbuf,"%s-%02d.png",FLCFile,FLCFrame++);
    SavePNG(pngbuf,FLCImage,FLCWidth,FLCHeight,FLCPalette);
}

/**
**	Convert FLC PSTAMP
*/
void ConvertFLC_PSTAMP(unsigned char* buf)
{
    unsigned char* p;
    int height;
    int width;
    int xlate;
    int pstamp_size;
    int pstamp_type;
    int h;
    int w;
    unsigned char* image;
    unsigned char* i;

    //
    //	Read header
    //
    p=buf;
    height=FetchLE16(p);
    width=FetchLE16(p);
    xlate=FetchLE16(p);

    image=malloc(height*width);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    memset(image,255,height*width);
    i=image;

    //
    //	PSTAMP header
    //
    pstamp_size=FetchLE32(p);
    pstamp_type=FetchLE16(p);

    switch( pstamp_type ) {
	case 15:
	{
	    char type;
	    unsigned char pixel;

	    for( h=height; h; --h ) {
		++p; // ignore first byte
		for( w=width; w; ) {
		    type=FetchByte(p);

		    if( type<0 ) {
			for( ; type; ++type ) {
			    *i++=FetchByte(p);
			    --w;
			}
		    } else {
			pixel=FetchByte(p);
			for( ; type; --type ) {
			    *i++=pixel;
			    --w;
			}
		    }
		}
	    }

	    break;
	}
	default:
	    printf("Unsupported pstamp_type: %d\n", pstamp_type);
	    break;
    }

    // Image unused, do nothing

    free(image);
}

/**
**	Convert FLC Frame Chunk
*/
int ConvertFLCFrameChunk(unsigned char* buf)
{
    unsigned char* p;
    int frame_size;
    int frame_type;
    int frame_chunks;
    int data_size;
    int data_type;

    //
    //	Read header
    //
    p=buf;
    frame_size=FetchLE32(p);
    frame_type=FetchLE16(p);
    if( frame_type!=0xF1FA ) {
	printf("Wrong magic: %04x != %04x\n",frame_type,0xF1FA);
	return 0;
    }
    frame_chunks=FetchLE16(p);
    p+=8; // reserved

    //
    //	Read chunks
    //
    for( ; frame_chunks; --frame_chunks ) {
	data_size=FetchLE32(p);
	data_type=FetchLE16(p);
	switch( data_type ) {
	    case 4:
		ConvertFLC_COLOR256(p);
		break;
	    case 7:
		ConvertFLC_SS2(p);
		break;
	    case 12:
		ConvertFLC_LC(p);
		break;
	    case 15:
		ConvertFLC_BRUN(p);
		break;
	    case 16:
		ConvertFLC_COPY(p);
		break;
	    case 18:
		ConvertFLC_PSTAMP(p);
		break;
	    default:
		printf("Unknown data_type = %d\n",data_type);
		break;
	}
	p+=data_size-6;
    }

    return frame_size;
}

/**
**	Convert FLC
*/
void ConvertFLC(const char* file,const char* flc)
{
    int f;
    struct stat stat_buf;
    unsigned char* buf;
    unsigned char* p;
    int i;
    int frames;
    int oframe1;
    int oframe2;
    int offset;
    FILE *fd;
    char txtbuf[1024];
    int speed;

    f=open(file,O_RDONLY|O_BINARY,0);
    if( f==-1 ) {
	printf("Can't open %s\n",file);
	return;
    }
    if( fstat(f,&stat_buf) ) {
	printf("Can't fstat %s\n",file);
	exit(-1);
    }
    DebugLevel3("Filesize %ld %ldk\n"
	_C_ (long)stat_buf.st_size _C_ stat_buf.st_size/1024);

    //
    //	Read in the archive
    //
    buf=malloc(stat_buf.st_size);
    if( !buf ) {
	printf("Can't malloc %ld\n",(long)stat_buf.st_size);
	exit(-1);
    }
    if( read(f,buf,stat_buf.st_size)!=stat_buf.st_size ) {
	printf("Can't read %ld\n",(long)stat_buf.st_size);
	exit(-1);
    }
    close(f);

    sprintf(FLCFile,"%s/%s/%s",Dir,FLC_PATH,flc);
    p=strrchr(FLCFile,'.');
    if( p ) {
	*p='\0';
    }
    CheckPath(FLCFile);
    FLCFrame=0;

    //
    //	Read header
    //
    p=buf;
    i=FetchLE32(p);
    if( i!=stat_buf.st_size ) {
	printf("FLC file size incorrect: %d != %ld\n",i,(long)stat_buf.st_size);
	free(buf);
	return;
    }
    i=FetchLE16(p);
    if( i!=0xAF12 ) {
	printf("Wrong FLC magic: %04x != %04x\n",i,0xAF12);
	free(buf);
	return;
    }
    frames=FetchLE16(p);
    FLCWidth=FetchLE16(p);
    FLCHeight=FetchLE16(p);
    i=FetchLE16(p); // depth always 8
    i=FetchLE16(p); // flags, unused
    speed=FetchLE32(p);
    i=FetchLE16(p); // reserved
    i=FetchLE32(p); // created
    i=FetchLE32(p); // creator
    i=FetchLE32(p); // updated
    i=FetchLE32(p); // updater
    i=FetchLE16(p); // aspectx
    i=FetchLE16(p); // aspecty
    p+=38;        // reserved
    oframe1=FetchLE32(p);
    oframe2=FetchLE32(p);
    p+=40;        // reserved

    FLCImage=malloc(FLCWidth*FLCHeight);
    if( !FLCImage ) {
	printf("Can't allocate image\n");
	exit(-1);
    }

    offset=oframe1;
    for( ; frames; --frames) {
	offset+=ConvertFLCFrameChunk(buf+offset);
    }

    //
    //	Save FLC info
    //
    sprintf(txtbuf,"%s.txt",FLCFile);
    fd=fopen(txtbuf,"wb");
    if( !fd ) {
	printf("Can't open file: %s", txtbuf);
	free(buf);
	free(FLCImage);
	return;
    }
    fprintf(fd,"width: %d\n",FLCWidth);
    fprintf(fd,"height: %d\n",FLCHeight);
    fprintf(fd,"speed: %d\n",speed);
    fclose(fd);

    free(buf);
    free(FLCImage);
}

//----------------------------------------------------------------------------
//	Palette
//----------------------------------------------------------------------------

/**
**	Convert palette.
**
**	@param pal	Pointer to palette
**
**	@return		Pointer to palette
*/
unsigned char* ConvertPalette(unsigned char* pal)
{
    int i;

    for( i=0; i<768; ++i ) {		// PNG needs 0-256
	pal[i]<<=2;
    }

    return pal;
}

/**
**	Convert rgb to my format.
*/
int ConvertRgb(char* file,int rgbe)
{
    unsigned char* rgbp;
    char buf[1024];
    FILE* f;
    int i;
    size_t l;

    rgbp=ExtractEntry(ArchiveOffsets[rgbe],&l);
    if( l<768 ) {
	rgbp=realloc(rgbp,768);
	memset(rgbp+l,0,768-l);
	l=768;
    }
    ConvertPalette(rgbp);

    //
    //	Generate RGB File.
    //
    sprintf(buf,"%s/%s/%s.rgb",Dir,TILESET_PATH,file);
    CheckPath(buf);
    f=fopen(buf,"wb");
    if( !f ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=fwrite(rgbp,1,l,f) ) {
	printf("Can't write %d bytes\n",l);
    }

    fclose(f);

    //
    //	Generate GIMP palette
    //
    sprintf(buf,"%s/%s/%s.gimp",Dir,TILESET_PATH,file);
    CheckPath(buf);
    f=fopen(buf,"wb");
    if( !f ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    fprintf(f,"GIMP Palette\n# Stratagus %c%s -- GIMP Palette file\n"
	    ,toupper(*file),file+1);

    for( i=0; i<256; ++i ) {
	// FIXME: insert nice names!
	fprintf(f,"%d %d %d\t#%d\n"
		,rgbp[i*3],rgbp[i*3+1],rgbp[i*3+2],i);
    }

    free(rgbp);

    return 0;
}

//----------------------------------------------------------------------------
//	Tileset
//----------------------------------------------------------------------------

/**
**	Decode a minitile into the image.
*/
void DecodeMiniTile(unsigned char* image,int ix,int iy,int iadd
	,unsigned char* mini,int index,int flipx,int flipy)
{
    int x;
    int y;

    DebugLevel3Fn("index %d\n" _C_ index);
    for( y=0; y<8; ++y ) {
	for( x=0; x<8; ++x ) {
	    image[(y+iy*8)*iadd+ix*8+x]=mini[index+
		(flipy ? (8-y) : y)*8+(flipx ? (8-x) : x)];
	}
    }
}

/**
**	Convert a tileset to my format.
*/
int ConvertTileset(char* file,int index)
{
    unsigned char* palp;
    unsigned char* mini;
    unsigned char* mega;
    unsigned char* image;
    const unsigned short* mp;
    int msize;
    int height;
    int width;
    int i;
    int x;
    int y;
    int offset;
    int numtiles;
    int len;
    char buf[1024];
    int pale;

    pale=index+1;
    palp=ExtractEntry(ArchiveOffsets[pale],&len);
    if( !palp ) {
	return 0;
    }
    if( len<768 ) {
	palp=realloc(palp,768);
	memset(palp+len,0,768-len);
    }
    if( pale==191 || pale==194 || pale==197 ) {
	unsigned char* gpalp;
	int i;
	gpalp=ExtractEntry(ArchiveOffsets[217],NULL);
	for( i=0; i<128; ++i ) {
	    if( palp[i*3+0]==63 && palp[i*3+1]==0 && palp[i*3+2]==63 ) {
		palp[i*3+0]=gpalp[i*3+0];
		palp[i*3+1]=gpalp[i*3+1];
		palp[i*3+2]=gpalp[i*3+2];
	    }
	}
	for( i=128; i<256; ++i ) {
	    if( !(gpalp[i*3+0]==63 && gpalp[i*3+1]==0 && gpalp[i*3+2]==63) ) {
		palp[i*3+0]=gpalp[i*3+0];
		palp[i*3+1]=gpalp[i*3+1];
		palp[i*3+2]=gpalp[i*3+2];
	    }
	}
	free(gpalp);
    }
    mini=ExtractEntry(ArchiveOffsets[index],NULL);
    if( !mini ) {
	free(palp);
	return 0;
    }
    mega=ExtractEntry(ArchiveOffsets[index-1],&msize);
    if( !mega ) {
	free(palp);
	free(mini);
	return 0;
    }
    numtiles=msize/8;

    width=TILE_PER_ROW*16;
    height=((numtiles+TILE_PER_ROW-1)/TILE_PER_ROW)*16;
    image=malloc(height*width);
    memset(image,0,height*width);

    for( i=0; i<numtiles; ++i ) {
	mp=(const unsigned short*)(mega+i*8);
	for( y=0; y<2; ++y ) {
	    for( x=0; x<2; ++x ) {
		offset=ConvertLE16(mp[x+y*2]);
		DecodeMiniTile(image
		    ,x+((i%TILE_PER_ROW)*2),y+(i/TILE_PER_ROW)*2,width
		    ,mini,(offset&0xFFFC)<<1,offset&2,offset&1);
	    }
	}
    }

    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,TILESET_PATH,file);
    CheckPath(buf);
    SavePNG(buf,image,width,height,palp);

    free(palp);
    free(mini);
    free(mega);

    return 0;
}

//----------------------------------------------------------------------------
//	Graphics
//----------------------------------------------------------------------------

/**
**	Decode a entry(frame) into image.
*/
void DecodeGfuEntry(int index,unsigned char* start
	,unsigned char* image,int iadd)
{
    unsigned char* bp;
    unsigned char* sp;
    unsigned char* dp;
    int i;
    int xoff;
    int yoff;
    int width;
    int height;
    int offset;

    bp=start+index*8;
    xoff=FetchByte(bp);
    yoff=FetchByte(bp);
    width=FetchByte(bp);
    height=FetchByte(bp);
    offset=FetchLE32(bp);
    if( offset<0 ) {			// High bit of width
	offset&=0x7FFFFFFF;
	width+=256;
    }

    DebugLevel3("%2d: +x %2d +y %2d width %2d height %2d offset %d\n"
	_C_ index _C_ xoff _C_ yoff _C_ width _C_ height _C_ offset);

    sp=start+offset-4;
    dp=image+xoff+yoff*iadd;
    for( i=0; i<height; ++i ) {
	memcpy(dp,sp,width);
	dp+=iadd;
	sp+=width;
    }
}
/**
**	Convert graphics into image.
*/
unsigned char* ConvertGraphic(unsigned char* bp,int *wp,int *hp
	,unsigned char* bp2,int start2)
{
    int i;
    int count;
    int length;
    int max_width;
    int max_height;
    unsigned char* image;
    int IPR;

    if (bp2) {	// Init pointer to 2nd animation
	count=FetchLE16(bp2);
	max_width=FetchByte(bp2);
	max_height=FetchByte(bp2);
    }
    count=FetchLE16(bp);
    max_width=FetchByte(bp);
    max_height=FetchByte(bp);


    DebugLevel3("Entries %2d Max width %3d height %3d, " _C_ count
	    _C_ max_width _C_ max_height);

    if( count%5==0 ) {
	IPR=5;
	length=((count+IPR-1)/IPR)*IPR;
    } else {
	IPR=1;
	length=count;
    }

    image=malloc(max_width*max_height*length);

    //	Image:	0, 1, 2, 3, 4,
    //		5, 6, 7, 8, 9, ...
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    // Set all to transparent.
    memset(image,255,max_width*max_height*length);

    for( i=0; i<count; ++i ) {
	DecodeGfuEntry(i,bp
	    ,image+max_width*(i%IPR)+max_height*max_width*IPR*(i/IPR)
	    ,max_width*IPR);
    }

    *wp=max_width*IPR;
    *hp=max_height*(length/IPR);

    return image;
}

/**
**	Convert a uncompressed graphic to my format.
*/
int ConvertGfu(char* file,int pale,int gfue)
{
    unsigned char* palp;
    unsigned char* gfup;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];
    int len;

    palp=ExtractEntry(ArchiveOffsets[pale],&len);
    if( !palp ) {
	return 0;
    }
    if( len<768 ) {
	palp=realloc(palp,768);
	memset(palp+len,0,768-len);
    }
    if( pale==191 || pale==194 || pale==197 ) {
	unsigned char* gpalp;
	int i;
	gpalp=ExtractEntry(ArchiveOffsets[217],NULL);
	for( i=0; i<128; ++i ) {
	    if( palp[i*3+0]==63 && palp[i*3+1]==0 && palp[i*3+2]==63 ) {
		palp[i*3+0]=gpalp[i*3+0];
		palp[i*3+1]=gpalp[i*3+1];
		palp[i*3+2]=gpalp[i*3+2];
	    }
	}
	for( i=128; i<256; ++i ) {
	    if( !(gpalp[i*3+0]==63 && gpalp[i*3+1]==0 && gpalp[i*3+2]==63) ) {
		palp[i*3+0]=gpalp[i*3+0];
		palp[i*3+1]=gpalp[i*3+1];
		palp[i*3+2]=gpalp[i*3+2];
	    }
	}
	free(gpalp);
    }

    gfup=ExtractEntry(ArchiveOffsets[gfue],NULL);
    if( !gfup ) {
	free(palp);
	return 0;
    }

    image=ConvertGraphic(gfup,&w,&h,NULL,0);

    free(gfup);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,UNIT_PATH,file);
    CheckPath(buf);
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Image
//----------------------------------------------------------------------------

/**
**	Convert image into image.
*/
unsigned char* ConvertImg(unsigned char* bp,int *wp,int *hp)
{
    int width;
    int height;
    unsigned char* image;
    int i;

    width=FetchLE16(bp);
    height=FetchLE16(bp);

    DebugLevel3("Image: width %3d height %3d\n" _C_ width _C_ height);

    image=malloc(width*height);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    memcpy(image,bp,width*height);

    for( i=0; i<width*height; ++i ) {
	if( image[i]==96 ) {
	    image[i]=255;
	}
    }

    *wp=width;
    *hp=height;

    return image;
}

/**
**	Resize an image
**
**	@param image	image data to be converted
**	@param ow	old image width
**	@param oh	old image height
**	@param nw	new image width
**	@param nh	new image height
*/
void ResizeImage(unsigned char** image,int ow,int oh,int nw,int nh)
{
    int i;
    int j;
    unsigned char *data;
    int x;

    if( ow==nw && nh==oh ) {
	return;
    }

    data = (unsigned char*)malloc(nw*nh);
    x=0;
    for( i=0; i<nh; ++i ) {
	for( j=0; j<nw; ++j ) {
	    data[x] = ((unsigned char*)*image)[
		(i*oh+nh/2)/nh*ow + (j*ow+nw/2)/nw];
	    ++x;
	}
    }

    free(*image);
    *image=data;
}

/**
**	Convert an image to my format.
*/
int ConvertImage(char* file,int pale,int imge, int nw, int nh)
{
    unsigned char* palp;
    unsigned char* imgp;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];
    int len;

    palp=ExtractEntry(ArchiveOffsets[pale],&len);
    if( !palp ) {
	return 0;
    }
    if( len<768 ) {
	palp=realloc(palp,768);
	memset(palp+len,0,768-len);
    }
    if( pale==191 || pale==194 || pale==197 ) {
	unsigned char* gpalp;
	int i;
	gpalp=ExtractEntry(ArchiveOffsets[217],NULL);
	for( i=0; i<128; ++i ) {
	    if( palp[i*3+0]==63 && palp[i*3+1]==0 && palp[i*3+2]==63 ) {
		palp[i*3+0]=gpalp[i*3+0];
		palp[i*3+1]=gpalp[i*3+1];
		palp[i*3+2]=gpalp[i*3+2];
	    }
	}
	for( i=128; i<256; ++i ) {
	    if( !(gpalp[i*3+0]==63 && gpalp[i*3+1]==0 && gpalp[i*3+2]==63) ) {
		palp[i*3+0]=gpalp[i*3+0];
		palp[i*3+1]=gpalp[i*3+1];
		palp[i*3+2]=gpalp[i*3+2];
	    }
	}
	free(gpalp);
    }

    imgp=ExtractEntry(ArchiveOffsets[imge],NULL);
    if( !imgp ) {
	free(palp);
	return 0;
    }

    image=ConvertImg(imgp,&w,&h);

    free(imgp);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,GRAPHIC_PATH,file);
    CheckPath(buf);

    // Only resize if parameters 3 and 4 are non-zero
    if (nw && nh) {
	ResizeImage(&image,w,h,nw,nh);
	w=nw; h=nh;
    }
    SavePNG(buf,image,w,h,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Cursor
//----------------------------------------------------------------------------

/**
**	Convert cursor into image.
*/
unsigned char* ConvertCur(unsigned char* bp,int *wp,int *hp)
{
    int i;
    int hotx;
    int hoty;
    int width;
    int height;
    unsigned char* image;

    hotx=FetchLE16(bp);
    hoty=FetchLE16(bp);
    width=FetchLE16(bp);
    height=FetchLE16(bp);

    DebugLevel3("Cursor: hotx %d hoty %d width %d height %d\n"
	    _C_ hotx _C_ hoty _C_ width _C_ height);

    image=malloc(width*height);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    for( i=0; i<width*height; ++i ) {
	image[i]=bp[i] ? bp[i] : 255;
    }

    *wp=width;
    *hp=height;

    return image;
}

/**
**	Convert a cursor to my format.
*/
int ConvertCursor(char* file,int pale,int cure)
{
    unsigned char* palp;
    unsigned char* curp;
    unsigned char* image;
    int w;
    int h;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    if( !palp ) {
	return 0;
    }
    curp=ExtractEntry(ArchiveOffsets[cure],NULL);
    if( !curp ) {
	if( pale!=27 && cure!=314 ) {
	    free(palp);
	}
	return 0;
    }

    image=ConvertCur(curp,&w,&h);

    free(curp);
    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,CURSOR_PATH,file);
    CheckPath(buf);
    SavePNG(buf,image,w,h,palp);

    free(image);
    if( pale!=27 && cure!=314 ) {
	free(palp);
    }

    return 0;
}

//----------------------------------------------------------------------------
//	Wav
//----------------------------------------------------------------------------

/**
**	Convert wav to my format.
*/
int ConvertWav(char* file,int wave)
{
    unsigned char* wavp;
    char buf[1024];
    gzFile gf;
    int l;

    wavp=ExtractEntry(ArchiveOffsets[wave],&l);
    if( !wavp ) {
	return 0;
    }

    if( strncmp(wavp,"RIFF",4) ) {
	printf("Not a wav file: %s\n", file);
	free(wavp);
	return 0;
    }

    sprintf(buf,"%s/%s/%s.wav.gz",Dir,SOUND_PATH,file);
    CheckPath(buf);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=gzwrite(gf,wavp,l) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(wavp);

    gzclose(gf);
    return 0;
}

/**
**	Convert voc to my format.
*/
int ConvertVoc(char* file,int voce)
{
    unsigned char* vocp;
    char buf[1024];
    gzFile gf;
    int l;
    unsigned char* p;
    unsigned char type;
    int offset;
    int size;
    int sample_rate;
    int compression_type;
    unsigned char a,b,c;
    unsigned char* wavp;
    int w;
    int wavlen;
    int i;
    short s;

    vocp=ExtractEntry(ArchiveOffsets[voce],&l);
    if( !vocp ) {
	return 0;
    }

    p=vocp;
    if( memcmp(vocp,"Creative Voice File",19) ) {
	printf("Not a voc file: %s\n",file);
	free(vocp);
	return 0;
    }
    p+=19;
    ++p; // 0x1A
    offset=FetchLE16(p);
    i=FetchLE16(p); // Version
    i=FetchLE16(p); // 1's comp of version

    wavp=NULL;
    wavlen=0;
    w=0;

    while( 1 ) {
	type=FetchByte(p);
	if( type==0 ) {
	    break;
	}
	a=FetchByte(p);
	b=FetchByte(p);
	c=FetchByte(p);
	size=(c<<16)|(b<<8)|a;
	switch( type ) {
	    case 1:
		sample_rate=FetchByte(p);
		compression_type=FetchByte(p);
		wavlen+=size-2;
		wavp=realloc(wavp,wavlen);
		for( i=size-2; i; --i ) {
		    wavp[w++]=FetchByte(p);
		}
		break;
	    default:
		printf("Unsupported voc type: %d\n", type);
		break;
	}
    }

    sprintf(buf,"%s/%s/%s.wav.gz",Dir,SOUND_PATH,file);
    CheckPath(buf);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    gzprintf(gf,"RIFF");
    i=wavlen+36;
    gzwrite(gf,&i,4);
    gzprintf(gf,"WAVE");
    gzprintf(gf,"fmt ");
    i=16;
    gzwrite(gf,&i,4);
    s=1;
    gzwrite(gf,&s,2); // format
    gzwrite(gf,&s,2); // channels
    i=11025;
    gzwrite(gf,&i,4); // samples per sec
    gzwrite(gf,&i,4); // avg bytes per sec
    s=1;
    gzwrite(gf,&s,2); // block alignment
    s=8;
    gzwrite(gf,&s,2); // sample size
    gzprintf(gf,"data");
    i=wavlen;
    gzwrite(gf,&i,4);
    gzwrite(gf,wavp,wavlen);

    free(vocp);

    gzclose(gf);
    return 0;
}

//----------------------------------------------------------------------------
//	Video
//----------------------------------------------------------------------------

/**
**	Convert pud to my format.
*/
int ConvertVideo(char* file,int video)
{
    unsigned char* vidp;
    char buf[1024];
    FILE* gf;
    size_t l;

    vidp=ExtractEntry(ArchiveOffsets[video],&l);
    if( !vidp ) {
	return 0;
    }

    sprintf(buf,"%s/%s.smk",Dir,file);
    CheckPath(buf);
    gf=fopen(buf,"wb");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l!=fwrite(vidp,1,l,gf) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(vidp);

    fclose(gf);
    return 0;
}

//----------------------------------------------------------------------------
//	Text
//----------------------------------------------------------------------------

/**
**	Convert text to my format.
*/
int ConvertText(char* file,int txte,int ofs)
{
    unsigned char* txtp;
    char buf[1024];
    gzFile gf;
    int l;

    txtp=ExtractEntry(ArchiveOffsets[txte],&l);
    if( !txtp ) {
	return 0;
    }
    sprintf(buf,"%s/%s/%s.txt.gz",Dir,TEXT_PATH,file);
    CheckPath(buf);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    if( l-ofs!=gzwrite(gf,txtp+ofs,l-ofs) ) {
	printf("Can't write %d bytes\n",l);
    }

    free(txtp);

    gzclose(gf);
    return 0;
}

/**
**	Convert text to my format.
*/
int ConvertText2(char* file,int txte)
{
    unsigned char* txtp;
    char buf[1024];
    gzFile gf;
    int l;
    unsigned char* t;
    unsigned char* p;

    txtp=ExtractEntry(ArchiveOffsets[txte],&l);
    if( !txtp ) {
	return 0;
    }

    sprintf(buf,"%s/%s/%s.txt.gz",Dir,TEXT_PATH,file);
    CheckPath(buf);
    gf=gzopen(buf,"wb9");
    if( !gf ) {
	perror("");
	printf("Can't open %s\n",buf);
	exit(-1);
    }
    t=p=txtp+ConvertLE16(*(unsigned short*)(txtp+0x94));
    while( *p ) {
	++p;
    }
    gzwrite(gf,t,p-t+1);

    free(txtp);

    gzclose(gf);
    return 0;
}

/**
**	Parse string.
*/
char* ParseString(char* input)
{
    static char buf[1024];
    char* dp;
    char* sp;
    char* tp;
    int i;
    int f;

    for( sp=input,dp=buf; *sp; ) {
	if( *sp=='%' ) {
	    f=0;
	    if( *++sp=='-' ) {
		f=1;
		++sp;
	    }
	    i=strtol(sp,&sp,0);
	    tp=UnitNames[i];
	    if( f ) {
		tp=strchr(tp,' ')+1;
	    }
	    while( *tp ) {	// make them readabler
		if( *tp=='-' ) {
		    *dp++='_';
		    tp++;
		} else {
		    *dp++=tolower(*tp++);
		}
	    }
	    continue;
	}
	*dp++=*sp++;
    }
    *dp='\0';

    return buf;
}

/**
**	Save the players
**
**	@param f	File handle
**	@param mtxme	Entry number of map.
*/
local void CmSavePlayers(gzFile f)
{
    int i;

    for( i=0; i<16; ++i ) {
	gzprintf(f,"(player %d\n",i);
	gzprintf(f,"  'name \"Player %d\"\n",i);
	if( i==0 ) {
	    gzprintf(f,"  'type 'person 'race \"human\" 'ai 0\n");
	    gzprintf(f,"  'team 2 'enemy \"_X______________\" 'allied \"_______________\" 'shared-vision \"________________\"\n");
	} else if( i==1 ) {
	    gzprintf(f,"  'type 'computer 'race \"orc\" 'ai 0\n");
	    gzprintf(f,"  'team 2 'enemy \"X_______________\" 'allied \"_______________\" 'shared-vision \"________________\"\n");
	} else if( i==15 ) {
	    gzprintf(f,"  'type 'neutral 'race \"neutral\" 'ai 0\n");
	    gzprintf(f,"  'team 2 'enemy \"________________\" 'allied \"_______________\" 'shared-vision \"________________\"\n");
	} else {
	    gzprintf(f,"  'type 'nobody 'race \"human\" 'ai 0\n");
	    gzprintf(f,"  'team 2 'enemy \"________________\" 'allied \"_______________\" 'shared-vision \"________________\"\n");
	}
	gzprintf(f,"  'start '(0 0)\n");
	gzprintf(f,"  'resources '(time 0 gold 1000 wood 1000 oil 0 ore 0 stone 0 coal 0)\n");
	gzprintf(f,"  'incomes '(time 0 gold 100 wood 100 oil 0 ore 0 stone 0 coal 0)\n");
	if( i!=1 ) {
	    gzprintf(f,"  'ai-disabled\n");
	} else {
	    gzprintf(f,"  'ai-enabled\n");
	}
	gzprintf(f,")\n");
    }
    gzprintf(f,"(set-this-player! 0)\n");
}

/**
**	Save the map
**
**	@param f	File handle
**	@param mtxme	Entry number of map.
*/
local void CmSaveMap(gzFile f,int mtxme)
{
    unsigned char* mtxm;
    unsigned char* p;
    unsigned short s;
    int i;
    int j;

    mtxm=ExtractEntry(ArchiveOffsets[mtxme],NULL);
    if( !mtxm ) {
	return;
    }

    p=mtxm;

    gzprintf(f,"(stratagus-map\n");
    gzprintf(f,"  'the-map '(\n");
    gzprintf(f,"  terrain (tileset-forest \"forest\")\n");
    gzprintf(f,"  size (64 64)\n");
    gzprintf(f,"  map-fields (\n");

    for( i=0; i<64; ++i ) {
	gzprintf(f,"  ; %d\n",i);
	for( j=0; j<64; ++j ) {
	    if( !(j&1) ) {
		gzprintf(f,"  ");
	    } else {
		gzprintf(f,"\t");
	    }
	    s=FetchLE16(p);
	    gzprintf(f,"(%d land)",s);
	    if( j&1 ) {
		gzprintf(f,"\n");
	    }
	}
    }

    gzprintf(f,")))\n");

    free(mtxm);
}

char *UnitTypes[] = {
    // 0
    "unit-footman", "unit-grunt",
    "unit-peasant", "unit-peon",
    "unit-human-catapult", "unit-orc-catapult",
    "unit-knight", "unit-raider",
    "unit-archer", "unit-spearman",
    // 10
    "unit-conjurer", "unit-warlock",
    "unit-cleric", "unit-necrolyte",
    "unit-midevh", "unit-lothar",
    "unit-garona", "unit-grizelda",
    "unit-water-elemental", "unit-daemon",
    // 20
    "unit-scorpion", "unit-spider",
    "unit-22", "unit-23",
    "unit-24", "unit-25",
    "unit-26", "unit-27",
    "unit-28", "unit-29",
    // 30
    "unit-30", "unit-31",
    "unit-human-farm", "unit-orc-farm",
    "unit-human-barracks", "unit-orc-barracks",
    "unit-human-church", "unit-orc-temple",
    "unit-human-tower", "unit-orc-tower",
    // 40
    "unit-human-town-hall", "unit-orc-town-hall",
    "unit-elven-lumber-mill", "unit-troll-lumber-mill",
    "unit-human-stable", "unit-orc-kennel",
    "unit-human-blacksmith", "unit-orc-blacksmith",
    "unit-stormwind-keep", "unit-blackrock-spire",
    // 50
    "unit-gold-mine", "unit-51",
    "unit-peasant-with-wood", "unit-peon-with-wood",
    "unit-peasant-with-gold", "unit-peon-with-gold",
};

/**
**	Save the units to cm.
**
**	@param f	File handle
*/
local void CmSaveUnits(gzFile f,unsigned char* txtp)
{
    unsigned char* p;
    unsigned char* p2;
    int x;
    int y;
    int type;
    int player;
    int value;
    int i;
    int numunits;

    p=txtp;
    while( p[0]!=0xFF || p[1]!=0xFF || p[2]!=0xFF || p[3]!=0xFF ) {
	++p;
    }
    p+=4;
    while( p[0]!=0xFF || p[1]!=0xFF || p[2]!=0xFF || p[3]!=0xFF ) {
	++p;
    }
    p+=4;
    x=FetchLE16(p);
    p=txtp+x;

    numunits=0;
    p2=p;
    while( p2[0]!=0xFF || p2[1]!=0xFF ) {
	x=FetchByte(p2)/2;
	y=FetchByte(p2)/2;
	type=FetchByte(p2);
	player=FetchByte(p2);
	if( type==0x32 ) {
	    // gold mine
	    value=FetchByte(p2);
	    value=FetchByte(p2)*250;
	}
	++numunits;
    }

    gzprintf(f,"(slot-usage '(0 - %d))\n",numunits-1);

    i=0;
    while( p[0]!=0xFF || p[1]!=0xFF ) {
	x=FetchByte(p)/2;
	y=FetchByte(p)/2;
	type=FetchByte(p);
	player=FetchByte(p);
	if( player==4 ) {
	    player=15;
	}
	if( type==0x32 ) {
	    // gold mine
	    value=FetchByte(p);
	    value=FetchByte(p)*250;
	} else {
	    value=0;
	}

	gzprintf(f,"(unit %d 'type '%s 'player %d\n",i,UnitTypes[type],player);
	gzprintf(f,"  'tile '(%d %d)\n",x,y);
	if( value ) {
	    gzprintf(f,"  'value %d\n",value);
	}
	gzprintf(f,")\n");
	++i;
    }
}

/**
**	Convert a map to cm.
*/
int ConvertCm(const char* file,int txte,int mtxme)
{
    unsigned char* txtp;
    unsigned char buf[1024];
    gzFile f;

    txtp=ExtractEntry(ArchiveOffsets[txte],NULL);
    if( !txtp ) {
	return 0;
    }
    sprintf(buf,"%s/%s/%s.cm.gz",Dir,CM_PATH,file);
    CheckPath(buf);
    f=gzopen(buf,"wb9");
    if( !f ) {
	perror("");
	fprintf(stderr,"Can't open %s\n",buf);
	exit(-1);
    }

    CmSavePlayers(f);
    CmSaveMap(f,mtxme);
    CmSaveUnits(f,txtp);

    free(txtp);
    gzclose(f);
    return 0;
}

//----------------------------------------------------------------------------
//	Main loop
//----------------------------------------------------------------------------

/**
**	Display the usage.
*/
void Usage(const char* name)
{
    printf("war1tool for Stratagus V" VERSION ", (c) 1999-2003 by the Stratagus Project\n\
Usage: %s archive-directory [destination-directory]\n\
archive-directory\tDirectory which includes the archives maindat.war...\n\
destination-directory\tDirectory where the extracted files are placed.\n"
    ,name);
}

/**
**	Main
*/
#undef main
int main(int argc,char** argv)
{
    unsigned u;
    char buf[1024];
    int a;

    a=1;
    while( argc>=2 ) {
	if( !strcmp(argv[a],"-h") ) {
	    Usage(argv[0]);
	    ++a;
	    --argc;
	    exit(0);
	}
	break;
    }

    if( argc!=2 && argc!=3 ) {
	Usage(argv[0]);
	exit(-1);
    }

    ArchiveDir=argv[a];
    if( argc==3 ) {
	Dir=argv[a+1];
    } else {
	Dir="data";
    }

    DebugLevel2("Extract from \"%s\" to \"%s\"\n" _C_ ArchiveDir _C_ Dir);
    for( u=0; u<sizeof(Todo)/sizeof(*Todo); ++u ) {
	// Should only be on the expansion cd
	DebugLevel2("%s:\n" _C_ ParseString(Todo[u].File));
	switch( Todo[u].Type ) {
	    case F:
		sprintf(buf,"%s/%s",ArchiveDir,Todo[u].File);
		DebugLevel2("Archive \"%s\"\n" _C_ buf);
		if( ArchiveBuffer ) {
		    CloseArchive();
		}
		OpenArchive(buf,Todo[u].Arg1);
		break;
	    case FLC:
		sprintf(buf,"%s/%s",ArchiveDir,Todo[u].File);
		ConvertFLC(buf,Todo[u].File);
		break;
	    case R:
		ConvertRgb(Todo[u].File,Todo[u].Arg1);
		break;
	    case T:
		ConvertTileset(Todo[u].File,Todo[u].Arg1);
		break;
	    case U:
		ConvertGfu(Todo[u].File,Todo[u].Arg1,Todo[u].Arg2);
		break;
	    case I:
		ConvertImage(Todo[u].File,Todo[u].Arg1,Todo[u].Arg2,
		    Todo[u].Arg3,Todo[u].Arg4);
		break;
	    case C:
		ConvertCursor(Todo[u].File,Todo[u].Arg1,Todo[u].Arg2);
		break;
	    case W:
		ConvertWav(Todo[u].File,Todo[u].Arg1);
		break;
	    case VOC:
		ConvertVoc(Todo[u].File,Todo[u].Arg1);
		break;
	    case X:
		ConvertText(Todo[u].File,Todo[u].Arg1,Todo[u].Arg2);
		break;
	    case X2:
		ConvertText2(Todo[u].File,Todo[u].Arg1);
		break;
	    case CM:
		ConvertCm(Todo[u].File,Todo[u].Arg1,Todo[u].Arg2);
		break;
	    default:
		break;
	}
    }

    return 0;
}

//@}
