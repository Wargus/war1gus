//       _________ __                 __
//      /   _____//  |_____________ _/  |______     ____  __ __  ______
//      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
//      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
//     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
//             \/                  \/          \//_____/            \/
//  ______________________                           ______________________
//                        T H E   W A R   B E G I N S
//   Utility for Stratagus - A free fantasy real time strategy game engine
//
/**@name war1tool.c - Extract files from war archives. */
//
//      (c) Copyright 2003-2004 by Jimmy Salmon
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
//      $Id$

//@{

/*----------------------------------------------------------------------------
--  Includes
----------------------------------------------------------------------------*/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#ifdef _MSC_VER
#define inline __inline
#define strdup _strdup
#define DEBUG _DEBUG
#include <direct.h>
#include <io.h>
#else
#include <unistd.h>
#endif
#include <ctype.h>
#include <png.h>
#include <zlib.h>

#include "xmi2mid.h"

#if defined(_MSC_VER) || defined(__MINGW32__) || defined(USE_BEOS)
typedef unsigned long u_int32_t;
#endif

#ifndef __GNUC__
#define __attribute__(args)  // Does nothing for non GNU CC
#endif

#ifdef WIN32
#define mkdir(x, y) _mkdir(x)
#define open(x, y, z) _open(x, y, z)
#define read(x, y, z) _read(x, y, z)
#define close(x) _close(x)
#endif

#ifndef O_BINARY
#define O_BINARY 0
#endif

// From SDL_byteorder.h
#if  defined(__i386__) || defined(__ia64__) || defined(WIN32) || \
    (defined(__alpha__) || defined(__alpha)) || \
     defined(__arm__) || \
    (defined(__mips__) && defined(__MIPSEL__)) || \
     defined(__SYMBIAN32__) || \
     defined(__x86_64__) || \
     defined(__LITTLE_ENDIAN__)
#ifdef __cplusplus
static inline void SkipLE16(unsigned char*& p) {
	p += 2;
}
static inline unsigned short FetchLE16(unsigned char*& p) {
	unsigned short s = *(unsigned short*)p;
	SkipLE16(p);
	return s;
}
static inline void SkipLE32(unsigned char*& p) {
	p += 4;
}
static inline unsigned int FetchLE32(unsigned char*& p) {
	unsigned int s = *(unsigned int*)p;
	SkipLE32(p);
	return s;
}
#else
#define SkipLE16(p) p += 2
#define FetchLE16(p) (*((unsigned short*)(p))); SkipLE16(p)
#define SkipLE32(p) p += 4
#define FetchLE32(p) (*((unsigned int*)(p))); SkipLE32(p)
#endif
#define AccessLE16(p) (*((unsigned short*)(p)))
#define AccessLE32(p) (*((unsigned int*)(p)))
#define ConvertLE16(v) (v)
#else
static inline unsigned short Swap16(unsigned short D) {
	return ((D << 8) | (D >> 8));
}
static inline unsigned int Swap32(unsigned int D) {
	return ((D << 24) | ((D << 8) & 0x00FF0000) | ((D >> 8) & 0x0000FF00) | (D >> 24));
}
#define FetchLE16(p) Swap16(*((unsigned short*)(p))); p += 2
#define FetchLE32(p) Swap32(*((unsigned int*)(p))) p += 4
#define AccessLE16(p) Swap16((*((unsigned short*)(p))))
#define AccessLE32(p) Swap32(*((unsigned int*)(p)))
#define ConvertLE16(v) Swap16(v)
#endif

#define SkipByte(p) ++p
#define FetchByte(p) (*((unsigned char*)(p))); SkipByte(p)

//----------------------------------------------------------------------------
//  Config
//----------------------------------------------------------------------------

/**
**  Destination directory of the graphics
*/
char* Dir;

/**
**  Path to the tileset graphics. (default=$DIR/graphics/tilesets)
*/
#define TILESET_PATH		"graphics/tilesets"

/**
**  Path to the unit graphics. (default=$DIR/graphics)
*/
#define UNIT_PATH		"graphics"

/**
**  Path to the cm files. (default=$DIR)
*/
#define CM_PATH		"."

/**
**  Path to the cursor files.
*/
#define CURSOR_PATH  "graphics/ui/cursors"

/**
**  Path to the graphic files.
*/
#define GRAPHIC_PATH  "graphics"

/**
**  Path to the sound files.
*/
#define SOUND_PATH  "sounds"

/**
**  Path to the sound files.
*/
#define MUSIC_PATH  "music"

/**
**  Path to the text files.
*/
#define TEXT_PATH  "campaigns"

/**
**  Path to the flc files.
*/
#define FLC_PATH  "flc"

/**
**  How much tiles are stored in a row.
*/
#define TILE_PER_ROW  16

//----------------------------------------------------------------------------

/**
**  Conversion control sturcture.
*/
typedef struct _control_ {
	int				Type;		/// Entry type
	int				Version;	/// Only in this version
	char*			        File;		/// Save file
	int				Arg1;		/// Extra argument 1
	int				Arg2;		/// Extra argument 2
	int				Arg3;		/// Extra argument 3
	int				Arg4;		/// Extra argument 4
} Control;

/**
**  Original archive buffer.
*/
unsigned char* ArchiveBuffer;

/**
**  Offsets for each entry into original archive buffer.
*/
unsigned char** ArchiveOffsets;

/**
**  Archive length
*/
int ArchiveLength;

/**
**		Possible entry types of archive file.
*/
enum _archive_type_ {
	F,						// File							(name)
	T,						// Tileset						(name,idx)
	U,						// Uncompressed Graphics		(name,pal,gfu)
	I,						// Image						(name,pal,img)
	W,						// Wav							(name,wav)
	M,						// XMI Midi Sound					(name,xmi)
	X,						// Text							(name,text,ofs)
	X2,						// Text2						(name,text)
	C,						// Cursor						(name,cursor)
	FLC,					// FLC
	VOC,					// VOC
	CM,						// Cm
};

char* ArchiveDir;

/**
**  What, where, how to extract.
*/
Control Todo[] = {
#define __  ,0,0,0
#define _2  ,0,0,
#if 0
{FLC,0,"cave1.war",											 0 __},
{FLC,0,"cave2.war",											 0 __},
{FLC,0,"cave3.war",											 0 __},
{FLC,0,"hfinale.war",										 0 __},
{FLC,0,"hintro1.war",										 0 __},
{FLC,0,"hintro2.war",										 0 __},
{FLC,0,"hmap01.war",										 0 __},
{FLC,0,"hmap02.war",										 0 __},
{FLC,0,"hmap03.war",										 0 __},
{FLC,0,"hmap04.war",										 0 __},
{FLC,0,"hmap05.war",										 0 __},
{FLC,0,"hmap06.war",										 0 __},
{FLC,0,"hmap07.war",										 0 __},
{FLC,0,"hmap08.war",										 0 __},
{FLC,0,"hmap09.war",										 0 __},
{FLC,0,"hmap10.war",										 0 __},
{FLC,0,"hmap11.war",										 0 __},
{FLC,0,"hmap12.war",										 0 __},
{FLC,0,"lose1.war",											 0 __},
{FLC,0,"lose2.war",											 0 __},
{FLC,0,"ofinale.war",										 0 __},
{FLC,0,"ointro1.war",										 0 __},
{FLC,0,"ointro2.war",										 0 __},
{FLC,0,"ointro3.war",										 0 __},
{FLC,0,"omap01.war",										 0 __},
{FLC,0,"omap02.war",										 0 __},
{FLC,0,"omap03.war",										 0 __},
{FLC,0,"omap04.war",										 0 __},
{FLC,0,"omap05.war",										 0 __},
{FLC,0,"omap06.war",										 0 __},
{FLC,0,"omap07.war",										 0 __},
{FLC,0,"omap08.war",										 0 __},
{FLC,0,"omap09.war",										 0 __},
{FLC,0,"omap10.war",										 0 __},
{FLC,0,"omap11.war",										 0 __},
{FLC,0,"omap12.war",										 0 __},
{FLC,0,"title.war",											 0 __},
{FLC,0,"win1.war",											 0 __},
{FLC,0,"win2.war",											 0 __},
#endif
///////////////////////////////////////////////////////////////////////////////
//  MOST THINGS
///////////////////////////////////////////////////////////////////////////////

#ifdef USE_BEOS
{F,0,"DATA.WAR",											 0 __},
#else
{F,0,"data.war",											 0 __},
#endif

// Midi music
// TODO: Use better file names
{M,0,"00",  0 __},
{M,0,"01",  1 __},
{M,0,"02",  2 __},
{M,0,"03",  3 __},
{M,0,"04",  4 __},
{M,0,"05",  5 __},
{M,0,"06",  6 __},
{M,0,"07",  7 __},
{M,0,"08",  8 __},
{M,0,"09",  9 __},
{M,0,"10", 10 __},
{M,0,"11", 11 __},
{M,0,"12", 12 __},
{M,0,"13", 13 __},
{M,0,"14", 14 __},
{M,0,"15", 15 __},
{M,0,"16", 16 __},
{M,0,"17", 17 __},
{M,0,"18", 18 __},
{M,0,"19", 19 __},
{M,0,"20", 20 __},
{M,0,"21", 21 __},
{M,0,"22", 22 __},
{M,0,"23", 23 __},
{M,0,"24", 24 __},
{M,0,"25", 25 __},
{M,0,"26", 26 __},
{M,0,"27", 27 __},
{M,0,"28", 28 __},
{M,0,"29", 29 __},
{M,0,"30", 30 __},
{M,0,"31", 31 __},
{M,0,"32", 32 __},
{M,0,"33", 33 __},
{M,0,"34", 34 __},
{M,0,"35", 35 __},
{M,0,"36", 36 __},
{M,0,"37", 37 __},
{M,0,"38", 38 __},
{M,0,"39", 39 __},
{M,0,"40", 40 __},
{M,0,"41", 41 __},
{M,0,"42", 42 __},
{M,0,"43", 43 __},
{M,0,"44", 44 __},

{CM,0,"campaigns/human/01",									 117, 63 _2},
{CM,0,"campaigns/human/02",									 119, 55 _2},
{CM,0,"campaigns/human/03",									 121, 69 _2},
{CM,0,"campaigns/human/04",									 123, 97 _2},
{CM,0,"campaigns/human/05",									 125, 57 _2},
{CM,0,"campaigns/human/06",									 127, 47 _2},
{CM,0,"campaigns/human/07",									 129, 67 _2},
{CM,0,"campaigns/human/08",									 131, 95 _2},
{CM,0,"campaigns/human/09",									 133, 71 _2},
{CM,0,"campaigns/human/10",									 135, 73 _2},
{CM,0,"campaigns/human/11",									 137, 75 _2},
{CM,0,"campaigns/human/12",									 139, 77 _2},
{CM,0,"campaigns/orc/01",									 118, 79 _2},
{CM,0,"campaigns/orc/02",									 120, 81 _2},
{CM,0,"campaigns/orc/03",									 122, 49 _2},
{CM,0,"campaigns/orc/04",									 124, 93 _2},
{CM,0,"campaigns/orc/05",									 126, 83 _2},
{CM,0,"campaigns/orc/06",									 128, 65 _2},
{CM,0,"campaigns/orc/07",									 130, 85 _2},
{CM,0,"campaigns/orc/08",									 132, 99 _2},
{CM,0,"campaigns/orc/09",									 134, 87 _2},
{CM,0,"campaigns/orc/10",									 136, 53 _2},
{CM,0,"campaigns/orc/11",									 138, 45 _2},
{CM,0,"campaigns/orc/12",									 140, 59 _2},

// Tilesets
{T,0,"forest/terrain",										 190 __},
{T,0,"swamp/terrain",										 193 __},
{T,0,"dungeon/terrain",										 196 __},

// Some animations
{U,0,"425",													 424, 425 _2},
{U,0,"426",													 424, 426 _2},
{U,0,"427",													 424, 427 _2},
{U,0,"428",													 423, 428 _2},
{U,0,"429",													 423, 429 _2},
{U,0,"430",													 423, 430 _2},
{U,0,"431",													 423, 431 _2},
{U,0,"460",													 459, 460 _2},

// Text
{X,0,"human/01_intro",										 432 __},
{X,0,"orc/01_intro",										 433 __},
{X,0,"human/02_intro",										 434 __},
{X,0,"orc/02_intro",										 435 __},
{X,0,"human/03_intro",										 436 __},
{X,0,"orc/03_intro",										 437 __},
{X,0,"human/04_intro",										 438 __},
{X,0,"orc/04_intro",										 439 __},
{X,0,"human/05_intro",										 440 __},
{X,0,"orc/05_intro",										 441 __},
{X,0,"human/06_intro",										 442 __},
{X,0,"orc/06_intro",										 443 __},
{X,0,"human/07_intro",										 444 __},
{X,0,"orc/07_intro",										 445 __},
{X,0,"human/08_intro",										 446 __},
{X,0,"orc/08_intro",										 447 __},
{X,0,"human/09_intro",										 448 __},
{X,0,"orc/09_intro",										 449 __},
{X,0,"human/10_intro",										 450 __},
{X,0,"orc/10_intro",										 451 __},
{X,0,"human/11_intro",										 452 __},
{X,0,"orc/11_intro",										 453 __},
{X,0,"human/12_intro",										 454 __},
{X,0,"orc/12_intro",										 455 __},
{X,0,"human/ending_1",										 461 __},
{X,0,"orc/ending_1",										 462 __},
{X,0,"human/ending_2",										 463 __},
{X,0,"orc/ending_2",										 464 __},
{X,0,"credits",												 465 __},
{X,0,"victory_dialog_1",									 466 __},
{X,0,"victory_dialog_2",									 467 __},
{X,0,"defeat_dialog_1",										 468 __},
{X,0,"defeat_dialog_2",										 469 __},

// Cursors
{C,0,"arrow",												 262, 263 _2},
{C,0,"invalid_command",										 262, 264 _2},
{C,0,"yellow_crosshair",									 262, 265 _2},
{C,0,"red_crosshair",										 262, 266 _2},
{C,0,"yellow_crosshair_2",									 262, 267 _2},
{C,0,"magnifying_glass",									 262, 268 _2},
{C,0,"small_green_crosshair",								 262, 269 _2},
{C,0,"watch",												 262, 270 _2},
{C,0,"up_arrow",											 262, 271 _2},
{C,0,"upper_right_arrow",									 262, 272 _2},
{C,0,"right_arrow",											 262, 273 _2},
{C,0,"lower_right_arrow",									 262, 274 _2},
{C,0,"down_arrow",											 262, 275 _2},
{C,0,"lower_left_arrow",									 262, 276 _2},
{C,0,"left_arrow",											 262, 277 _2},
{C,0,"upper_left_arrow",									 262, 278 _2},

// Unit graphics
{U,0,"human/units/footman",									 191, 279 _2},
{U,0,"orc/units/grunt",										 191, 280 _2},
{U,0,"human/units/peasant",									 191, 281 _2},
{U,0,"orc/units/peon",										 191, 282 _2},
{U,0,"human/units/catapult",								 191, 283 _2},
{U,0,"orc/units/catapult",									 191, 284 _2},
{U,0,"human/units/knight",									 191, 285 _2},
{U,0,"orc/units/raider",									 191, 286 _2},
{U,0,"human/units/archer",									 191, 287 _2},
{U,0,"orc/units/spearman",									 191, 288 _2},
{U,0,"human/units/conjurer",								 191, 289 _2},
{U,0,"orc/units/warlock",									 191, 290 _2},
{U,0,"human/units/cleric",									 191, 291 _2},
{U,0,"orc/units/necrolyte",									 191, 292 _2},
{U,0,"human/units/midevh",									 191, 293 _2},
{U,0,"orc/units/lothar",									 191, 294 _2},
{U,0,"neutral/units/wounded",								 191, 295 _2},
{U,0,"neutral/units/grizelda,garona",						 191, 296 _2},
{U,0,"neutral/units/ogre",									 191, 297 _2},
{U,0,"neutral/units/spider",								 191, 298 _2},
{U,0,"neutral/units/slime",									 191, 299 _2},
{U,0,"neutral/units/fire_elemental",						 191, 300 _2},
{U,0,"neutral/units/scorpion",								 191, 301 _2},
{U,0,"neutral/units/brigand",								 191, 302 _2},
{U,0,"neutral/units/the_dead",								 191, 303 _2},
{U,0,"neutral/units/skeleton",								 191, 304 _2},
{U,0,"neutral/units/daemon",								 191, 305 _2},
{U,0,"neutral/units/water_elemental",						 191, 306 _2},
{U,0,"neutral/units/dead_bodies",							 191, 326 _2},
{U,0,"human/units/peasant_with_wood",						 191, 327 _2},
{U,0,"orc/units/peon_with_wood",							 191, 328 _2},
{U,0,"human/units/peasant_with_gold",						 191, 329 _2},
{U,0,"orc/units/peon_with_gold",							 191, 330 _2},

// Buildings
{U,0,"tilesets/forest/human/buildings/farm",					 191, 307 _2},
{U,0,"tilesets/forest/orc/buildings/farm",						 191, 308 _2},
{U,0,"tilesets/forest/human/buildings/barracks",				 191, 309 _2},
{U,0,"tilesets/forest/orc/buildings/barracks",					 191, 310 _2},
{U,0,"tilesets/forest/human/buildings/church",					 191, 311 _2},
{U,0,"tilesets/forest/orc/buildings/temple",					 191, 312 _2},
{U,0,"tilesets/forest/human/buildings/tower",					 191, 313 _2},
{U,0,"tilesets/forest/orc/buildings/tower",						 191, 314 _2},
{U,0,"tilesets/forest/human/buildings/town_hall",				 191, 315 _2},
{U,0,"tilesets/forest/orc/buildings/town_hall",					 191, 316 _2},
{U,0,"tilesets/forest/human/buildings/lumber_mill",				 191, 317 _2},
{U,0,"tilesets/forest/orc/buildings/lumber_mill",				 191, 318 _2},
{U,0,"tilesets/forest/human/buildings/stable",					 191, 319 _2},
{U,0,"tilesets/forest/orc/buildings/kennel",					 191, 320 _2},
{U,0,"tilesets/forest/human/buildings/blacksmith",				 191, 321 _2},
{U,0,"tilesets/forest/orc/buildings/blacksmith",				 191, 322 _2},
{U,0,"tilesets/forest/human/buildings/stormwind_keep",			 191, 323 _2},
{U,0,"tilesets/forest/orc/buildings/blackrock_spire",			 191, 324 _2},
{U,0,"tilesets/forest/neutral/buildings/gold_mine",				 191, 325 _2},
{U,0,"tilesets/forest/human/buildings/farm_construction",		 191, 331 _2},
{U,0,"tilesets/forest/orc/buildings/farm_construction",			 191, 332 _2},
{U,0,"tilesets/forest/human/buildings/barracks_construction",	 191, 333 _2},
{U,0,"tilesets/forest/orc/buildings/barracks_construction",		 191, 334 _2},
{U,0,"tilesets/forest/human/buildings/church_construction",		 191, 335 _2},
{U,0,"tilesets/forest/orc/buildings/temple_construction",		 191, 336 _2},
{U,0,"tilesets/forest/human/buildings/tower_construction",		 191, 337 _2},
{U,0,"tilesets/forest/orc/buildings/tower_construction",		 191, 338 _2},
{U,0,"tilesets/forest/human/buildings/town_hall_construction",	 191, 339 _2},
{U,0,"tilesets/forest/orc/buildings/town_hall_construction",	 191, 340 _2},
{U,0,"tilesets/forest/human/buildings/lumber_mill_construction", 191, 341 _2},
{U,0,"tilesets/forest/orc/buildings/lumber_mill_construction",	 191, 342 _2},
{U,0,"tilesets/forest/human/buildings/stable_construction",		 191, 343 _2},
{U,0,"tilesets/forest/orc/buildings/kennel_construction",		 191, 344 _2},
{U,0,"tilesets/forest/human/buildings/blacksmith_construction",	 191, 345 _2},
{U,0,"tilesets/forest/orc/buildings/blacksmith_construction",	 191, 346 _2},
{U,0,"tilesets/swamp/human/buildings/farm",						 194, 307 _2},
{U,0,"tilesets/swamp/orc/buildings/farm",						 194, 308 _2},
{U,0,"tilesets/swamp/human/buildings/barracks",					 194, 309 _2},
{U,0,"tilesets/swamp/orc/buildings/barracks",					 194, 310 _2},
{U,0,"tilesets/swamp/human/buildings/church",					 194, 311 _2},
{U,0,"tilesets/swamp/orc/buildings/temple",						 194, 312 _2},
{U,0,"tilesets/swamp/human/buildings/tower",					 194, 313 _2},
{U,0,"tilesets/swamp/orc/buildings/tower",						 194, 314 _2},
{U,0,"tilesets/swamp/human/buildings/town_hall",				 194, 315 _2},
{U,0,"tilesets/swamp/orc/buildings/town_hall",					 194, 316 _2},
{U,0,"tilesets/swamp/human/buildings/lumber_mill",				 194, 317 _2},
{U,0,"tilesets/swamp/orc/buildings/lumber_mill",				 194, 318 _2},
{U,0,"tilesets/swamp/human/buildings/stable",					 194, 319 _2},
{U,0,"tilesets/swamp/orc/buildings/kennel",						 194, 320 _2},
{U,0,"tilesets/swamp/human/buildings/blacksmith",				 194, 321 _2},
{U,0,"tilesets/swamp/orc/buildings/blacksmith",					 194, 322 _2},
{U,0,"tilesets/swamp/human/buildings/stormwind_keep",			 194, 323 _2},
{U,0,"tilesets/swamp/orc/buildings/blackrock_spire",			 194, 324 _2},
{U,0,"tilesets/swamp/neutral/buildings/gold_mine",				 194, 325 _2},
{U,0,"tilesets/swamp/human/buildings/farm_construction",		 194, 331 _2},
{U,0,"tilesets/swamp/orc/buildings/farm_construction",			 194, 332 _2},
{U,0,"tilesets/swamp/human/buildings/barracks_construction",	 194, 333 _2},
{U,0,"tilesets/swamp/orc/buildings/barracks_construction",		 194, 334 _2},
{U,0,"tilesets/swamp/human/buildings/church_construction",		 194, 335 _2},
{U,0,"tilesets/swamp/orc/buildings/temple_construction",		 194, 336 _2},
{U,0,"tilesets/swamp/human/buildings/tower_construction",		 194, 337 _2},
{U,0,"tilesets/swamp/orc/buildings/tower_construction",			 194, 338 _2},
{U,0,"tilesets/swamp/human/buildings/town_hall_construction",	 194, 339 _2},
{U,0,"tilesets/swamp/orc/buildings/town_hall_construction",		 194, 340 _2},
{U,0,"tilesets/swamp/human/buildings/lumber_mill_construction",	 194, 341 _2},
{U,0,"tilesets/swamp/orc/buildings/lumber_mill_construction",	 194, 342 _2},
{U,0,"tilesets/swamp/human/buildings/stable_construction",		 194, 343 _2},
{U,0,"tilesets/swamp/orc/buildings/kennel_construction",		 194, 344 _2},
{U,0,"tilesets/swamp/human/buildings/blacksmith_construction",	 194, 345 _2},
{U,0,"tilesets/swamp/orc/buildings/blacksmith_construction",	 194, 346 _2},

// Missiles
{U,0,"missiles/fireball",									 217, 347 _2},
{U,0,"missiles/catapult_projectile",						 191, 348 _2},
{U,0,"missiles/arrow",										 217, 349 _2},
{U,0,"missiles/poison_cloud",								 191, 350 _2},
{U,0,"missiles/rain_of_fire",								 191, 351 _2},
{U,0,"missiles/small_fire",									 191, 352 _2},
{U,0,"missiles/large_fire",									 191, 353 _2},
{U,0,"missiles/explosion",									 191, 354 _2},
{U,0,"missiles/healing",									 217, 355 _2},
{U,0,"missiles/building_collapse",							 191, 356 _2},
{U,0,"missiles/water_elemental_projectile",					 217, 357 _2},
{U,0,"missiles/fireball_2",									 191, 358 _2},

// Icons
{U,0,"tilesets/forest/portrait_icons",						 191, 361 _2},
{U,0,"tilesets/swamp/portrait_icons",						 194, 361 _2},
{U,0,"tilesets/dungeon/portrait_icons",						 197, 361 _2},

// UI
{U,0,"ui/orc/icon_selection_boxes",							 191, 359 _2},
{U,0,"ui/human/icon_selection_boxes",						 191, 360 _2},
{I,0,"ui/logo",												 217, 216 _2},
{I,0,"ui/human/top_resource_bar",							 255, 218 _2},
{I,0,"ui/orc/top_resource_bar",								 191, 219 _2},
{I,0,"ui/human/right_panel",								 255, 220 _2},
{I,0,"ui/orc/right_panel",									 217, 221 _2},
{I,0,"ui/human/bottom_panel",								 255, 222 _2},
{I,0,"ui/orc/bottom_panel",									 217, 223 _2},
{I,0,"ui/human/minimap_2",									 255, 224 _2},
{I,0,"ui/orc/minimap_2",									 217, 225 _2},
{I,0,"ui/human/left_panel",									 255, 226 _2},
{I,0,"ui/orc/left_panel",									 217, 227 _2},
{I,0,"ui/human/minimap",									 255, 228 _2},
{I,0,"ui/orc/minimap",										 217, 229 _2},
{I,0,"ui/human/panel_1",									 255, 233 _2},
{I,0,"ui/orc/panel_1",										 217, 234 _2},
{I,0,"ui/human/panel_2",									 255, 235 _2},
{I,0,"ui/orc/panel_2",										 217, 236 _2},
{I,0,"ui/bottom_of_title_screen",							 260, 243 _2},
{I,0,"ui/human/left_arrow",									 255, 244 _2},
{I,0,"ui/orc/left_arrow",									 255, 245 _2},
{I,0,"ui/human/right_arrow",								 255, 246 _2},
{I,0,"ui/orc/right_arrow",									 255, 247 _2},
{I,0,"ui/box",												 255, 248 _2},
{I,0,"ui/human/save_game",									 255, 249 _2},
{I,0,"ui/orc/save_game",									 217, 250 _2},
{I,0,"ui/hot_keys",											 255, 254 _2},
{I,0,"ui/human/ok_box",										 255, 256 _2},
{I,0,"ui/orc/ok_box",										 255, 257 _2},
{I,0,"ui/top_of_title_screen",								 260, 258 _2},
{I,0,"ui/title_screen",										 260, 261 _2},
{I,0,"ui/menu_button_1",									 217, 362 _2},
{I,0,"ui/menu_button_2",									 217, 363 _2},
{I,0,"ui/human/icon_border",								 255, 364 _2},
{I,0,"ui/orc/icon_border",									 217, 365 _2},
{I,0,"ui/gold_icon_1",										 191, 406 _2},
{I,0,"ui/lumber_icon_1",									 217, 407 _2},
{I,0,"ui/gold_icon_2",										 191, 408 _2},
{I,0,"ui/lumber_icon_2",									 217, 409 _2},
{I,0,"ui/percent_complete",									 217, 410 _2},
{I,0,"ui/human/outcome_windows",							 413, 411 _2},
{I,0,"ui/orc/outcome_windows",								 414, 412 _2},
{I,0,"ui/victory_scene",									 416, 415 _2},
{I,0,"ui/defeat_scene",										 418, 417 _2},
{I,0,"ui/victory_text",										 418, 419 _2},
{I,0,"ui/defeat_text",										 418, 420 _2},
{I,0,"ui/human/briefing",									 423, 421 _2},
{I,0,"ui/orc/briefing",										 424, 422 _2},
{I,0,"ui/human/victory_1",									 457, 456 _2},
{I,0,"ui/orc/victory_1",									 459, 458 _2},
{I,0,"ui/human/victory_2",									 457, 470 _2},
{I,0,"ui/orc/victory_2",									 260, 471 _2},

// Sounds
{W,0,"logo",												 472 __},
{W,0,"intro_door",											 473 __},
{VOC,0,"misc/building",										 474 __},
{VOC,0,"misc/explosion",									 475 __},
{VOC,0,"missiles/catapult_rock_fired",						 476 __},
{VOC,0,"misc/tree_chopping_1",								 477 __},
{VOC,0,"misc/tree_chopping_2",								 478 __},
{VOC,0,"misc/tree_chopping_3",								 479 __},
{VOC,0,"misc/tree_chopping_4",								 480 __},
{VOC,0,"misc/building_collapse_1",							 481 __},
{VOC,0,"misc/building_collapse_2",							 482 __},
{VOC,0,"misc/building_collapse_3",							 483 __},
{VOC,0,"ui/chime",											 484 __},
{W,0,"ui/click",											 485 __},
{VOC,0,"ui/cancel",											 486 __},
{VOC,0,"missiles/sword_attack_1",							 487 __},
{VOC,0,"missiles/sword_attack_2",							 488 __},
{VOC,0,"missiles/sword_attack_3",							 489 __},
{VOC,0,"missiles/fist_attack",								 490 __},
{VOC,0,"missiles/catapult_fire_explosion",					 491 __},
{VOC,0,"missiles/fireball",									 492 __},
{VOC,0,"missiles/arrow,spear",								 493 __},
{VOC,0,"missiles/arrow,spear_hit",							 494 __},
{VOC,0,"orc/help_1",										 495 __},
{VOC,0,"orc/help_2",										 496 __},
{W,0,"human/help_2",										 497 __},
{W,0,"human/help_1",										 498 __},
{VOC,0,"orc/dead",											 499 __},
{VOC,0,"human/dead",										 500 __},
{VOC,0,"orc/work_complete",									 501 __},
{W,0,"human/work_complete",									 502 __},
{VOC,0,"orc/help_3",										 503 __},
{W,0,"orc/help_4",											 504 __},
{W,0,"human/help_3",										 505 __},
{W,0,"human/help_4",										 506 __},
{VOC,0,"orc/ready",											 507 __},
{W,0,"human/ready",											 508 __},
{VOC,0,"orc/acknowledgement_1",								 509 __},
{VOC,0,"orc/acknowledgement_2",								 510 __},
{VOC,0,"orc/acknowledgement_3",								 511 __},
{VOC,0,"orc/acknowledgement_4",								 512 __},
{W,0,"human/acknowledgement_1",								 513 __},
{W,0,"human/acknowledgement_2",								 514 __},
{VOC,0,"orc/selected_1",									 515 __},
{VOC,0,"orc/selected_2",									 516 __},
{VOC,0,"orc/selected_3",									 517 __},
{VOC,0,"orc/selected_4",									 518 __},
{VOC,0,"orc/selected_5",									 519 __},
{W,0,"human/selected_1",									 520 __},
{W,0,"human/selected_2",									 521 __},
{W,0,"human/selected_3",									 522 __},
{W,0,"human/selected_4",									 523 __},
{W,0,"human/selected_5",									 524 __},
{VOC,0,"orc/annoyed_1",										 525 __},
{VOC,0,"orc/annoyed_2",										 526 __},
{W,0,"orc/annoyed_3",										 527 __},
{W,0,"human/annoyed_1",										 528 __},
{W,0,"human/annoyed_2",										 529 __},
{W,0,"human/annoyed_3",										 530 __},
{W,0,"dead_spider,scorpion",								 531 __},
{W,0,"normal_spell",										 532 __},
{W,0,"misc/build_road",										 533 __},
{W,0,"orc/temple",											 534 __},
{W,0,"human/church",										 535 __},
{W,0,"orc/kennel",											 536 __},
{W,0,"human/stable",										 537 __},
{W,0,"blacksmith",											 538 __},
{W,0,"misc/fire_crackling",									 539 __},
{W,0,"cannon",												 540 __},
{W,0,"cannon2",												 541 __},
{W,0,"../campaigns/human/ending_1",							 542 __},
{W,0,"../campaigns/human/ending_2",							 543 __},
{W,0,"../campaigns/orc/ending_1",							 544 __},
{W,0,"../campaigns/orc/ending_2",							 545 __},
{W,0,"intro_1",												 546 __},
{W,0,"intro_2",												 547 __},
{W,0,"intro_3",												 548 __},
{W,0,"intro_4",												 549 __},
{W,0,"intro_5",												 550 __},
{W,0,"../campaigns/human/01_intro",							 551 __},
{W,0,"../campaigns/human/02_intro",							 552 __},
{W,0,"../campaigns/human/03_intro",							 553 __},
{W,0,"../campaigns/human/04_intro",							 554 __},
{W,0,"../campaigns/human/05_intro",							 555 __},
{W,0,"../campaigns/human/06_intro",							 556 __},
{W,0,"../campaigns/human/07_intro",							 557 __},
{W,0,"../campaigns/human/08_intro",							 558 __},
{W,0,"../campaigns/human/09_intro",							 559 __},
{W,0,"../campaigns/human/10_intro",							 560 __},
{W,0,"../campaigns/human/11_intro",							 561 __},
{W,0,"../campaigns/human/12_intro",							 562 __},
{W,0,"../campaigns/orc/01_intro",							 563 __},
{W,0,"../campaigns/orc/02_intro",							 564 __},
{W,0,"../campaigns/orc/03_intro",							 565 __},
{W,0,"../campaigns/orc/04_intro",							 566 __},
{W,0,"../campaigns/orc/05_intro",							 567 __},
{W,0,"../campaigns/orc/06_intro",							 568 __},
{W,0,"../campaigns/orc/07_intro",							 569 __},
{W,0,"../campaigns/orc/08_intro",							 570 __},
{W,0,"../campaigns/orc/09_intro",							 571 __},
{W,0,"../campaigns/orc/10_intro",							 572 __},
{W,0,"../campaigns/orc/11_intro",							 573 __},
{W,0,"../campaigns/orc/12_intro",							 574 __},
{W,0,"human/defeat",										 575 __},
{W,0,"orc/defeat",											 576 __},
{W,0,"orc/victory_1",										 577 __},
{W,0,"orc/victory_2",										 578 __},
{W,0,"orc/victory_3",										 579 __},
{W,0,"human/victory_1",										 580 __},
{W,0,"human/victory_2",										 581 __},
{W,0,"human/victory_3",										 582 __},

#undef __
#undef _2
};

//----------------------------------------------------------------------------
//  TOOLS
//----------------------------------------------------------------------------

/**
**  Check if path exists, if not make all directories.
*/
void CheckPath(const char* path)
{
	char* cp;
	char* s;

	if (*path && path[0] == '.') {  // relative don't work
		return;
	}
	cp = strdup(path);
	s = strrchr(cp, '/');
	if (s) {
		*s = '\0';  // remove file
		s = cp;
		for (;;) {  // make each path element
			s = strchr(s, '/');
			if (s) {
				*s = '\0';
			}
			mkdir(cp, 0777);
			if (s) {
				*s++ = '/';
			} else {
				break;
			}
		}
	}
	free(cp);
}

//----------------------------------------------------------------------------
//  PNG
//----------------------------------------------------------------------------

/**
**  Resize an image
**
**  @param image  image data to be converted
**  @param ow     old image width
**  @param oh     old image height
**  @param nw     new image width
**  @param nh     new image height
*/
void ResizeImage(unsigned char** image, int ow, int oh, int nw, int nh)
{
	int i;
	int j;
	unsigned char* data;
	int x;

	if (ow == nw && nh == oh) {
		return;
	}

	data = (unsigned char*)malloc(nw * nh);
	x = 0;
	for (i = 0; i < nh; ++i) {
		for (j = 0; j < nw; ++j) {
			data[x] = ((unsigned char*)*image)[
				i * oh / nh * ow + j * ow / nw];
			++x;
		}
	}

	free(*image);
	*image = data;
}

/**
**  Save a png file.
**
**  @param name   File name
**  @param image  Graphic data
**  @param w      Graphic width
**  @param h      Graphic height
**  @param pal    Palette
**  @param transparent  Image uses transparency
*/
int SavePNG(const char* name, unsigned char* image, int w, int h,
	unsigned char* pal, int transparent)
{
	FILE* fp;
	png_structp png_ptr;
	png_infop info_ptr;
	unsigned char** lines;
	int i;
	const int bit_depth = 8;
	const int interlace_type = 0;
	const int num_palette = 256;

	if (!(fp = fopen(name, "wb"))) {
		fprintf(stderr,"%s:", name);
		perror("Can't open file");
		return 1;
	}

	png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
	if (!png_ptr) {
		fclose(fp);
		return 1;
	}
	info_ptr = png_create_info_struct(png_ptr);
	if (!info_ptr) {
		png_destroy_write_struct(&png_ptr, NULL);
		fclose(fp);
		return 1;
	}

	if (setjmp(png_jmpbuf(png_ptr))) {
		// FIXME: must free buffers!!
		png_destroy_write_struct(&png_ptr, &info_ptr);
		fclose(fp);
		return 1;
	}
	png_init_io(png_ptr, fp);

	// zlib parameters
	png_set_compression_level(png_ptr, Z_BEST_COMPRESSION);

	// prepare the file information
#if PNG_LIBPNG_VER >= 10504
	png_set_IHDR(png_ptr, info_ptr, w, h, bit_depth, PNG_COLOR_TYPE_PALETTE, interlace_type,
				PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_DEFAULT);
	png_set_PLTE(png_ptr, info_ptr, (png_colorp)pal, num_palette);
#else
	info_ptr->width = w;
	info_ptr->height = h;
	info_ptr->bit_depth = bit_depth;
	info_ptr->color_type = PNG_COLOR_TYPE_PALETTE;
	info_ptr->interlace_type = interlace_type;
	info_ptr->valid |= PNG_INFO_PLTE;
	info_ptr->palette = (png_colorp)pal;
	info_ptr->num_palette = num_palette;
#endif

	if (transparent != -1) {
		unsigned char* p;
		unsigned char* end;
		png_byte trans[256];

		p = image;
		end = image + (w * h);
		while (p < end) {
			if (!*p) {
				*p = 0xFF;
			}
			++p;
		}

		memset(trans, 0xFF, sizeof(trans));
		trans[255] = 0x0;
		png_set_tRNS(png_ptr, info_ptr, trans, 256, 0);
	}

	// write the file header information
	png_write_info(png_ptr, info_ptr);

	// set transformation

	// prepare image
	lines = (unsigned char**)malloc(h * sizeof(*lines));
	if (!lines) {
		png_destroy_write_struct(&png_ptr, &info_ptr);
		fclose(fp);
		return 1;
	}

	for (i = 0; i < h; ++i) {
		lines[i] = image + i * w;
	}

	png_write_image(png_ptr, lines);
	png_write_end(png_ptr, info_ptr);

	png_destroy_write_struct(&png_ptr, &info_ptr);
	fclose(fp);

	free(lines);

	return 0;
}

//----------------------------------------------------------------------------
//  Archive
//----------------------------------------------------------------------------

/**
**  Open the archive file.
**
**  @param file  Archive file name
**  @param type  Archive type requested
*/
int OpenArchive(const char* file, int type)
{
	int f;
	struct stat stat_buf;
	unsigned char* buf;
	unsigned char* cp;
	unsigned char** op;
	int entries;
	int i;

	//
	//  Open the archive file
	//
	f = open(file, O_RDONLY | O_BINARY, 0);

	if (f == -1) {
		printf("Can't open %s\n", file);
		exit(-1);
	}
	if (fstat(f, &stat_buf)) {
		printf("Can't fstat %s\n", file);
		exit(-1);
	}

	//
	//  Read in the archive
	//
	buf = malloc(stat_buf.st_size);
	if (!buf) {
		printf("Can't malloc %ld\n", (long)stat_buf.st_size);
		exit(-1);
	}
	if (read(f, buf, stat_buf. st_size) != stat_buf.st_size) {
		printf("Can't read %ld\n", (long)stat_buf.st_size);
		exit(-1);
	}
	close(f);

	cp = buf;
	i = FetchLE32(cp);
	if (i != 0x19 && i != 0x18) {
		printf("Wrong magic %08x, expected %08x or %08x\n",
			i, 0x00000019, 0x00000018);
		exit(-1);
	}
	entries = FetchLE16(cp);
	i = FetchLE16(cp);
	if (i != type) {
		printf("Wrong type %08x, expected %08x\n", i, type);
		exit(-1);
	}

	//
	//  Read offsets.
	//
	op = malloc((entries + 1) * sizeof(unsigned char**));
	if (!op) {
		printf("Can't malloc %d entries\n", entries);
		exit(-1);
	}
	for (i = 0; i < entries; ++i) {
		op[i] = buf + FetchLE32(cp);
	}
	op[i] = buf + stat_buf.st_size;

	ArchiveOffsets = op;
	ArchiveBuffer = buf;
	ArchiveLength = stat_buf.st_size;

	return 0;
}

/**
**  Extract/uncompress entry.
**
**  @param cp    Pointer to compressed entry
**  @param lenp  Return pointer of length of the entry
**
**  @return      Pointer to uncompressed entry
*/
unsigned char* ExtractEntry(unsigned char* cp, int* lenp)
{
	unsigned char* dp;
	unsigned char* dest;
	int uncompressed_length;
	int flags;

	uncompressed_length = FetchLE32(cp);
	flags = uncompressed_length >> 24;
	uncompressed_length &= 0x00FFFFFF;

	if (uncompressed_length + (cp - ArchiveBuffer) > ArchiveLength) {
		printf("Entry goes past end of file\n");
		return NULL;
	}

	dp = dest = malloc(uncompressed_length);
	if (!dest) {
		printf("Can't malloc %d\n", uncompressed_length);
		exit(-1);
	}

	if (flags == 0x20) {
		unsigned char buf[4096];
		unsigned char* ep;
		int bi;

		bi = 0;
		memset(buf, 0, sizeof(buf));
		ep = dp + uncompressed_length;

		// FIXME: If the decompression is too slow, optimise this loop :->
		while (dp < ep) {
			int i;
			int bflags;

			bflags = FetchByte(cp);
			for (i = 0; i < 8; ++i) {
				int j;
				int o;

				if (bflags & 1) {
					j = FetchByte(cp);
					*dp++ = j;
					buf[bi++ & 0xFFF] = j;
				} else {
					o = FetchLE16(cp);
					j = (o >> 12) + 3;
					o &= 0xFFF;
					while (j--) {
						buf[bi++ & 0xFFF] = *dp++ = buf[o++ & 0xFFF];
						if (dp == ep) {
							break;
						}
					}
				}
				if (dp == ep) {
					break;
				}
				bflags >>= 1;
			}
		}
		//if (dp!=ep ) printf("%p,%p %d\n",dp,ep,dp-dest);
	} else if (flags == 0x00) {
		memcpy(dest, cp, uncompressed_length);
	} else {
		printf("Unknown flags %x\n", flags);
		free(dest);
		return NULL;
	}

	if (lenp) {						// return resulting length
		*lenp = uncompressed_length;
	}

	return dest;
}

/**
**  Close the archive file.
*/
int CloseArchive(void)
{
	free(ArchiveBuffer);
	free(ArchiveOffsets);
	ArchiveBuffer = 0;
	ArchiveOffsets = 0;

	return 0;
}

//----------------------------------------------------------------------------
//  FLC
//----------------------------------------------------------------------------

char FLCFile[1024];
unsigned char FLCPalette[256 * 3];
int FLCWidth;
int FLCHeight;
unsigned char* FLCImage;
unsigned char* FLCImage2;
int FLCFrame;

/**
**  Convert FLC COLOR256
*/
void ConvertFLC_COLOR256(unsigned char* buf)
{
	int packets;
	unsigned char* p;
	int skip;
	int color_count;
	int index;

	index = 0;
	p = buf;

	packets = FetchLE16(p);
	for (; packets; --packets) {
		skip = FetchByte(p);
		index += skip;
		color_count = FetchByte(p);
		if (color_count == 0) {
			color_count = 256;
		}
		for (; color_count; --color_count) {
			FLCPalette[index * 3 + 0] = FetchByte(p);
			FLCPalette[index * 3 + 1] = FetchByte(p);
			FLCPalette[index * 3 + 2] = FetchByte(p);
			++index;
		}
	}
}

/**
**  Convert FLC SS2
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

	p = buf;
	lines = FetchLE16(p);
	skiplines = 0;

	for (; lines; --lines) {
		i = FLCImage + FLCWidth * skiplines;
		w = FetchLE16(p);
		if ((w & 0xC000) == 0) {
			packets = w;
			for (; packets; --packets) {
				skip = FetchByte(p);
				i += skip;
				type = FetchByte(p);
				if (type > 0) {
					for (; type; --type) {
						*(unsigned short*)i = FetchLE16(p);
						i += 2;
					}
				} else if (type < 0) {
					packet = FetchLE16(p);
					for (; type; ++type) {
						*(unsigned short*)i = packet;
						i += 2;
					}
				}
			}
		} else if ((w & 0xC000) == 0x8000) {
			// Not used, ignore
			printf("SS2 low order byte stored in last byte of line\n");
			++lines;
		} else if ((w & 0xC000) == 0xC000) {
			skip = -(short)w;
			skiplines += skip - 1; // -1 because of ++skiplines below
			++lines;
		} else {
			printf("SS2 error\n");
			return;
		}
		++skiplines;
	}

	sprintf(pngbuf, "%s-%02d.png", FLCFile, FLCFrame++);
	memcpy(FLCImage2, FLCImage, FLCWidth * FLCHeight);
	ResizeImage(&FLCImage2, FLCWidth, FLCHeight, 2 * FLCWidth, 2 * FLCHeight);
	SavePNG(pngbuf, FLCImage2, 2 * FLCWidth, 2 * FLCHeight, FLCPalette, -1);
}

/**
**  Convert FLC LC
*/
void ConvertFLC_LC(unsigned char* buf)
{
	unsigned char* p;
	int lines;
	int packets;
	unsigned char* i;
	int skip;
	char type;
	unsigned char packet;
	int skiplines;
	char pngbuf[1024];

	p = buf;
	skiplines = FetchLE16(p);
	lines = FetchLE16(p);

	for (; lines; --lines) {
		packets = FetchByte(p);
		i = FLCImage + FLCWidth * skiplines;
		for (; packets; --packets) {
			skip = FetchByte(p);
			i += skip;
			type = FetchByte(p);
			if (type > 0) {
				for (; type; --type) {
					*i++ = FetchByte(p);
				}
			} else if (type < 0) {
				packet = FetchByte(p);
				for (; type; ++type) {
					*i++ = packet;
				}
			}
		}
		++skiplines;
	}

	sprintf(pngbuf, "%s-%02d.png", FLCFile, FLCFrame++);
	memcpy(FLCImage2, FLCImage, FLCWidth * FLCHeight);
	ResizeImage(&FLCImage2, FLCWidth, FLCHeight, 2 * FLCWidth, 2 * FLCHeight);
	SavePNG(pngbuf, FLCImage2, 2 * FLCWidth, 2 * FLCHeight, FLCPalette, -1);
}

/**
**  Convert FLC BRUN
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

	p = buf;
	i = FLCImage;

	for (h = FLCHeight; h; --h) {
		++p; // ignore first byte
		for (w = FLCWidth; w;) {
			type = FetchByte(p);

			if (type < 0) {
				for (; type; ++type) {
					*i++ = FetchByte(p);
					--w;
				}
			} else {
				pixel = FetchByte(p);
				for (; type; --type) {
					*i++ = pixel;
					--w;
				}
			}
		}
	}

	sprintf(pngbuf, "%s-%02d.png", FLCFile, FLCFrame++);
	memcpy(FLCImage2, FLCImage, FLCWidth * FLCHeight);
	ResizeImage(&FLCImage2, FLCWidth, FLCHeight, 2 * FLCWidth, 2 * FLCHeight);
	SavePNG(pngbuf, FLCImage2, 2 * FLCWidth, 2 * FLCHeight, FLCPalette, -1);
}

/**
**  Convert FLC COPY
*/
void ConvertFLC_COPY(unsigned char* buf)
{
	unsigned char* p;
	unsigned char* i;
	int h;
	int w;
	char pngbuf[1024];

	p = buf;
	i = FLCImage;

	for (h = FLCHeight; h; --h) {
		for (w = FLCWidth; w; --w) {
			*i++ = FetchByte(p);
		}
	}

	sprintf(pngbuf, "%s-%02d.png", FLCFile, FLCFrame++);
	memcpy(FLCImage2, FLCImage, FLCWidth * FLCHeight);
	ResizeImage(&FLCImage2, FLCWidth, FLCHeight, 2 * FLCWidth, 2 * FLCHeight);
	SavePNG(pngbuf, FLCImage2, 2 * FLCWidth, 2 * FLCHeight, FLCPalette, -1);
}

/**
**  Convert FLC PSTAMP
*/
void ConvertFLC_PSTAMP(unsigned char* buf)
{
	//
	//  Read header
	//
	unsigned char *p, *image, *i;
	int height, width, pstamp_type;
	
	p = buf;
	height = FetchLE16(p);
	width = FetchLE16(p);
	SkipLE16(p);
	
	image = (unsigned char*)malloc(height * width);
	if (!image) {
		printf("Can't allocate image\n");
		exit(-1);
	}
	memset(image, 255, height * width);
	i = image;

	//
	//  PSTAMP header
	//
	SkipLE32(p);
	pstamp_type = FetchLE16(p);

	switch (pstamp_type) {
		case 15:
		{
			int h, w;
			for (h = height; h; --h) {
				++p; // ignore first byte
				for (w = width; w;) {
					char type = FetchByte(p);

					if (type < 0) {
						for (; type; ++type) {
							*i++ = FetchByte(p);
							--w;
						}
					} else {
						unsigned char pixel = FetchByte(p);
						for (; type; --type) {
							*i++ = pixel;
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
**  Convert FLC Frame Chunk
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
	//  Read header
	//
	p = buf;
	frame_size = FetchLE32(p);
	frame_type = FetchLE16(p);
	if (frame_type != 0xF1FA) {
		printf("Wrong magic: %04x != %04x\n", frame_type, 0xF1FA);
		return 0;
	}
	frame_chunks = FetchLE16(p);
	p += 8; // reserved

	//
	//  Read chunks
	//
	for (; frame_chunks; --frame_chunks) {
		data_size = FetchLE32(p);
		data_type = FetchLE16(p);
		switch (data_type) {
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
		p += data_size - 6;
	}

	return frame_size;
}

/**
**  Convert FLC
*/
void ConvertFLC(const char* file, const char* flc)
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
	FILE* fd;
	char txtbuf[1024];
	int speed;

	f = open(file, O_RDONLY | O_BINARY, 0);
	if (f == -1) {
		printf("Can't open %s\n", file);
		return;
	}
	if (fstat(f, &stat_buf)) {
		printf("Can't fstat %s\n", file);
		exit(-1);
	}

	//
	//  Read in the archive
	//
	buf = malloc(stat_buf.st_size);
	if (!buf) {
		printf("Can't malloc %ld\n", (long)stat_buf.st_size);
		exit(-1);
	}
	if (read(f, buf, stat_buf.st_size) != stat_buf.st_size) {
		printf("Can't read %ld\n", (long)stat_buf.st_size);
		exit(-1);
	}
	close(f);

	sprintf(FLCFile, "%s/%s/%s", Dir, FLC_PATH, flc);
	p = (unsigned char*)strrchr(FLCFile, '.');
	if (p) {
		*p = '\0';
	}
	CheckPath(FLCFile);
	FLCFrame = 0;

	//
	//  Read header
	//
	p = buf;
	i = FetchLE32(p);
	if (i != stat_buf.st_size) {
		printf("FLC file size incorrect: %d != %ld\n", i, (long)stat_buf.st_size);
		free(buf);
		return;
	}
	i = FetchLE16(p);
	if (i != 0xAF12) {
		printf("Wrong FLC magic: %04x != %04x\n", i, 0xAF12);
		free(buf);
		return;
	}
	frames = FetchLE16(p);
	FLCWidth = FetchLE16(p);
	FLCHeight = FetchLE16(p);
	i = FetchLE16(p); // depth always 8
	i = FetchLE16(p); // flags, unused
	speed = FetchLE32(p);
	i = FetchLE16(p); // reserved
	i = FetchLE32(p); // created
	i = FetchLE32(p); // creator
	i = FetchLE32(p); // updated
	i = FetchLE32(p); // updater
	i = FetchLE16(p); // aspectx
	i = FetchLE16(p); // aspecty
	p += 38;		// reserved
	oframe1 = FetchLE32(p);
	oframe2 = FetchLE32(p);
	p += 40;		// reserved

	FLCImage = malloc(FLCWidth * FLCHeight);
	FLCImage2 = malloc(2 * FLCWidth * 2 * FLCHeight);
	if (!FLCImage || !FLCImage2) {
		printf("Can't allocate image\n");
		exit(-1);
	}

	offset = oframe1;
	for (; frames; --frames) {
		offset += ConvertFLCFrameChunk(buf + offset);
	}

	//
	//  Save FLC info
	//
	sprintf(txtbuf, "%s.txt", FLCFile);
	fd = fopen(txtbuf, "wb");
	if (!fd) {
		printf("Can't open file: %s", txtbuf);
		free(buf);
		free(FLCImage);
		return;
	}
	fprintf(fd, "width: %d\n", FLCWidth);
	fprintf(fd, "height: %d\n", FLCHeight);
	fprintf(fd, "speed: %d\n", speed);
	fclose(fd);

	free(buf);
	free(FLCImage);
}

//----------------------------------------------------------------------------
//  Palette
//----------------------------------------------------------------------------

/**
**  Convert palette.
**
**  @param pal  Pointer to palette
**
**  @return     Pointer to palette
*/
unsigned char* ConvertPalette(unsigned char* pal)
{
	int i;

	for (i = 0; i < 768; ++i) {  // PNG needs 0-256
		pal[i] <<= 2;
	}

	return pal;
}

//----------------------------------------------------------------------------
//  Tileset
//----------------------------------------------------------------------------

/**
**  Decode a minitile into the image.
*/
void DecodeMiniTile(unsigned char* image, int ix, int iy, int iadd,
	unsigned char* mini,int index, int flipx, int flipy)
{
	static const int flip[] = {
		7, 6, 5, 4, 3, 2, 1, 0, 8
	};
	int x;
	int y;

	for (y = 0; y < 8; ++y) {
		for (x = 0; x < 8; ++x) {
			image[(y + iy * 8) * iadd + ix * 8 + x] = mini[index +
				(flipy ? flip[y] : y) * 8 + (flipx ? flip[x] : x)];
		}
	}
}

/**
**  Convert a tileset to my format.
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

	pale = index + 1;
	palp = ExtractEntry(ArchiveOffsets[pale], &len);
	if (!palp) {
		return 0;
	}
	if (len < 768) {
		palp = realloc(palp, 768);
		memset(palp + len, 0, 768 - len);
	}
	if (pale == 191 || pale == 194 || pale == 197) {
		unsigned char* gpalp;
		int i;
		gpalp = ExtractEntry(ArchiveOffsets[217], NULL);
		for (i = 0; i < 128; ++i) {
			if (palp[i * 3 + 0] == 63 && palp[i * 3 + 1] == 0 &&
					palp[i * 3 + 2] == 63) {
				palp[i * 3 + 0] = gpalp[i * 3 + 0];
				palp[i * 3 + 1] = gpalp[i * 3 + 1];
				palp[i * 3 + 2] = gpalp[i * 3 + 2];
			}
		}
		for (i = 128; i < 256; ++i) {
			if (!(gpalp[i * 3 + 0] == 63 && gpalp[i * 3 + 1] == 0 &&
					gpalp[i * 3 + 2] == 63)) {
				palp[i * 3 + 0] = gpalp[i * 3 + 0];
				palp[i * 3 + 1] = gpalp[i * 3 + 1];
				palp[i * 3 + 2] = gpalp[i * 3 + 2];
			}
		}
		free(gpalp);
	}
	mini = ExtractEntry(ArchiveOffsets[index], NULL);
	if (!mini) {
		free(palp);
		return 0;
	}
	mega = ExtractEntry(ArchiveOffsets[index - 1], &msize);
	if (!mega) {
		free(palp);
		free(mini);
		return 0;
	}
	numtiles = msize / 8;

	width = TILE_PER_ROW * 16;
	height = ((numtiles + TILE_PER_ROW - 1) / TILE_PER_ROW) * 16;
	image = malloc(height * width);
	memset(image, 0, height * width);

	for (i = 0; i < numtiles; ++i) {
		mp = (const unsigned short*)(mega + i * 8);
		for (y = 0; y < 2; ++y) {
			for (x = 0; x < 2; ++x) {
				offset = ConvertLE16(mp[x + y * 2]);
				DecodeMiniTile(image,
					x + ((i % TILE_PER_ROW) * 2), y + (i / TILE_PER_ROW) * 2,
					width, mini, (offset & 0xFFFC) << 1, offset & 2, offset & 1);
			}
		}
	}

	ConvertPalette(palp);

	sprintf(buf, "%s/%s/%s.png", Dir, TILESET_PATH, file);
	CheckPath(buf);
	ResizeImage(&image, width, height, 2 * width, 2 * height);
	SavePNG(buf, image, 2 * width, 2 * height, palp, 0);

	for (y = 0; y < 32; ++y) {
		for (x = 10 * 32; x < 16 * 32; ++x) {
			image[y * 16 * 32 + x] = 0;
		}
	}
	sprintf(buf, "%s/%s/%s", Dir, TILESET_PATH, file);
	*(strrchr(buf, '/') + 1) = '\0';
	strcat(buf, "fog.png");
	CheckPath(buf);
	SavePNG(buf, image, 16 * 32, 32, palp, 0);

	free(palp);
	free(mini);
	free(mega);

	return 0;
}

//----------------------------------------------------------------------------
//  Graphics
//----------------------------------------------------------------------------

/**
**  Decode a entry(frame) into image.
*/
void DecodeGfuEntry(int index, unsigned char* start,
	unsigned char* image, int iadd)
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

	bp = start + index * 8;
	xoff = FetchByte(bp);
	yoff = FetchByte(bp);
	width = FetchByte(bp);
	height = FetchByte(bp);
	offset = FetchLE32(bp);
	if (offset < 0) {  // High bit of width
		offset &= 0x7FFFFFFF;
		width += 256;
	}

	sp = start + offset - 4;
	dp = image + xoff + yoff * iadd;
	for (i = 0; i < height; ++i) {
		memcpy(dp, sp, width);
		dp += iadd;
		sp += width;
	}
}
/**
**  Convert graphics into image.
*/
unsigned char* ConvertGraphic(unsigned char* bp,int *wp,int *hp,
	unsigned char* bp2)
{
	int i;
	int count;
	int length;
	int max_width;
	int max_height;
	unsigned char* image;
	int IPR;

	if (bp2) {  // Init pointer to 2nd animation
		count = FetchLE16(bp2);
		max_width = FetchByte(bp2);
		max_height = FetchByte(bp2);
	}
	count = FetchLE16(bp);
	max_width = FetchByte(bp);
	max_height = FetchByte(bp);


	if (count % 5 == 0) {
		IPR = 5;
		length = ((count + IPR - 1) / IPR) * IPR;
	} else {
		IPR = 1;
		length = count;
	}

	image = malloc(max_width * max_height * length);

	//  Image:  0, 1, 2, 3, 4,
	//          5, 6, 7, 8, 9, ...
	if (!image) {
		printf("Can't allocate image\n");
		exit(-1);
	}
	// Set all to transparent.
	memset(image, 0, max_width * max_height * length);

	for (i = 0; i < count; ++i) {
		DecodeGfuEntry(i, bp,
			image + max_width * (i % IPR) + max_height * max_width * IPR * (i / IPR),
			max_width * IPR);
	}

	*wp = max_width * IPR;
	*hp = max_height * (length / IPR);

	return image;
}

/**
**  Convert a uncompressed graphic to my format.
*/
int ConvertGfu(char* file, int pale, int gfue)
{
	unsigned char* palp;
	unsigned char* gfup;
	unsigned char* image;
	int w;
	int h;
	char buf[1024];
	int len;

	palp = ExtractEntry(ArchiveOffsets[pale], &len);
	if (!palp) {
		return 0;
	}
	if (len < 768) {
		palp = realloc(palp, 768);
		memset(palp + len, 0, 768 - len);
	}
	if (pale == 191 || pale == 194 || pale == 197) {
		unsigned char* gpalp;
		int i;

		gpalp = ExtractEntry(ArchiveOffsets[217], NULL);
		for (i = 0; i < 128; ++i) {
			if (palp[i * 3 + 0] == 63 && palp[i * 3 + 1] == 0 &&
					palp[i * 3 + 2] == 63) {
				palp[i * 3 + 0] = gpalp[i * 3 + 0];
				palp[i * 3 + 1] = gpalp[i * 3 + 1];
				palp[i * 3 + 2] = gpalp[i * 3 + 2];
			}
		}
		for (i = 128; i < 256; ++i) {
			if (!(gpalp[i * 3 + 0] == 63 && gpalp[i * 3 + 1] == 0 &&
					gpalp[i * 3 + 2] == 63)) {
				palp[i * 3 + 0] = gpalp[i * 3 + 0];
				palp[i * 3 + 1] = gpalp[i * 3 + 1];
				palp[i * 3 + 2] = gpalp[i * 3 + 2];
			}
		}
		free(gpalp);
	}

	gfup = ExtractEntry(ArchiveOffsets[gfue], NULL);
	if (!gfup) {
		free(palp);
		return 0;
	}

	image = ConvertGraphic(gfup, &w, &h, NULL);

	free(gfup);
	ConvertPalette(palp);

	sprintf(buf, "%s/%s/%s.png", Dir, UNIT_PATH, file);
	CheckPath(buf);
	ResizeImage(&image, w, h, 2 * w, 2 * h);
	SavePNG(buf, image, 2 * w, 2 * h, palp, 0);

	free(image);
	free(palp);

	return 0;
}

//----------------------------------------------------------------------------
//  Image
//----------------------------------------------------------------------------

/**
**  Convert image into image.
*/
unsigned char* ConvertImg(unsigned char* bp, int *wp, int *hp)
{
	int width;
	int height;
	unsigned char* image;
	int i;

	width = FetchLE16(bp);
	height = FetchLE16(bp);

	image = malloc(width * height);
	if (!image) {
		printf("Can't allocate image\n");
		exit(-1);
	}
	memcpy(image, bp, width * height);

	for (i = 0; i < width * height; ++i) {
		if (image[i] == 96) {
			image[i] = 255;
		}
	}

	*wp = width;
	*hp = height;

	return image;
}

/**
**  Convert an image to my format.
*/
int ConvertImage(char* file, int pale, int imge)
{
	unsigned char* palp;
	unsigned char* imgp;
	unsigned char* image;
	int w;
	int h;
	char buf[1024];
	int len;

	palp = ExtractEntry(ArchiveOffsets[pale], &len);
	if (!palp) {
		return 0;
	}
	if (len < 768) {
		palp = realloc(palp, 768);
		memset(palp + len, 0, 768 - len);
	}
	if (pale == 191 || pale == 194 || pale == 197) {
		unsigned char* gpalp;
		int i;
		gpalp = ExtractEntry(ArchiveOffsets[217], NULL);
		for (i = 0; i < 128; ++i) {
			if (palp[i * 3 + 0] == 63 && palp[i * 3 + 1] == 0 &&
					palp[i * 3 + 2] == 63) {
				palp[i * 3 + 0] = gpalp[i * 3 + 0];
				palp[i * 3 + 1] = gpalp[i * 3 + 1];
				palp[i * 3 + 2] = gpalp[i * 3 + 2];
			}
		}
		for (i = 128; i < 256; ++i) {
			if (!(gpalp[i * 3 + 0] == 63 && gpalp[i * 3 + 1] == 0 &&
					gpalp[i * 3 + 2] == 63)) {
				palp[i * 3 + 0] = gpalp[i * 3 + 0];
				palp[i * 3 + 1] = gpalp[i * 3 + 1];
				palp[i * 3 + 2] = gpalp[i * 3 + 2];
			}
		}
		free(gpalp);
	}

	imgp = ExtractEntry(ArchiveOffsets[imge], NULL);
	if (!imgp) {
		free(palp);
		return 0;
	}

	image = ConvertImg(imgp, &w, &h);

	free(imgp);
	ConvertPalette(palp);

	sprintf(buf, "%s/%s/%s.png", Dir, GRAPHIC_PATH, file);
	CheckPath(buf);

	ResizeImage(&image, w, h, 2 * w, 2 * h);
	SavePNG(buf, image, 2 * w, 2 * h, palp, -1);

	free(image);
	free(palp);

	return 0;
}

//----------------------------------------------------------------------------
//		Cursor
//----------------------------------------------------------------------------

/**
**  Convert a cursor to my format.
*/
int ConvertCursor(char* file, int pale, int cure)
{
	unsigned char* palp;
	unsigned char* curp;
	unsigned char* p;
	unsigned char* image;
	int hotx;
	int hoty;
	int w;
	int h;
	char buf[1024];

	palp = ExtractEntry(ArchiveOffsets[pale], NULL);
	if (!palp) {
		return 0;
	}
	p = curp = ExtractEntry(ArchiveOffsets[cure], NULL);
	if (!curp) {
		if (pale != 27 && cure != 314) {
			free(palp);
		}
		return 0;
	}

	hotx = FetchLE16(p);
	hoty = FetchLE16(p);
	w = FetchLE16(p);
	h = FetchLE16(p);
	image = malloc(w * h);
	memcpy(image, p, w * h);

	ConvertPalette(palp);

	sprintf(buf, "%s/%s/%s.png", Dir, CURSOR_PATH, file);
	CheckPath(buf);
	ResizeImage(&image, w, h, 2 * w, 2 * h);
	SavePNG(buf, image, 2 * w, 2 * h, palp, 0);

	free(curp);
	free(image);
	if (pale != 27 && cure != 314) {
		free(palp);
	}

	return 0;
}

//----------------------------------------------------------------------------
//  Wav
//----------------------------------------------------------------------------

/**
**  Convert wav to my format.
*/
int ConvertWav(char* file, int wave)
{
	unsigned char* wavp;
	char buf[1024];
	gzFile gf;
	int l;

	wavp = ExtractEntry(ArchiveOffsets[wave], &l);
	if (!wavp) {
		return 0;
	}

	if (strncmp((char*)wavp, "RIFF", 4)) {
		printf("Not a wav file: %s\n", file);
		free(wavp);
		return 0;
	}

	sprintf(buf, "%s/%s/%s.wav.gz", Dir, SOUND_PATH, file);
	CheckPath(buf);
	gf = gzopen(buf, "wb9");
	if (!gf) {
		perror("");
		printf("Can't open %s\n", buf);
		exit(-1);
	}
	if (l != gzwrite(gf, wavp, l)) {
		printf("Can't write %d bytes\n", l);
	}

	free(wavp);

	gzclose(gf);
	return 0;
}

//----------------------------------------------------------------------------
//  XMI Midi
//----------------------------------------------------------------------------

/**
**  Convert XMI Midi sound to Midi
*/

int ConvertXmi(char* file, int xmi)
{
        unsigned char* xmip;
        size_t xmil;
        unsigned char* midp;
        size_t midl;
		char buf[1024];
        gzFile gf;

        xmip = ExtractEntry(ArchiveOffsets[xmi], (int*)&xmil);
        midp = TranscodeXmiToMid(xmip, xmil, &midl);

        free(xmip);

        sprintf(buf, "%s/%s/%s.mid.gz", Dir, MUSIC_PATH, file);
        CheckPath(buf);
        gf = gzopen(buf, "wb9");
        if (!gf) {
                perror("");
                printf("Can't open %s\n", buf);
                exit(-1);
        }
        if (midl != (size_t)gzwrite(gf, midp, midl)) {
                printf("Can't write %d bytes\n", (int)midl);
        }

        free(midp);

        gzclose(gf);
        return 0;
}

/**
**  Convert voc to my format.
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
	int w, wavlen, i, s;

	vocp = ExtractEntry(ArchiveOffsets[voce], &l);
	if (!vocp) {
		return 0;
	}

	p = vocp;
	if (memcmp(vocp, "Creative Voice File", 19)) {
		printf("Not a voc file: %s\n", file);
		free(vocp);
		return 0;
	}
	p += 19;
	++p; // 0x1A
	offset = FetchLE16(p);
	i = FetchLE16(p); // Version
	i = FetchLE16(p); // 1's comp of version

	wavp = NULL;
	wavlen = 0;
	w = 0;

	while (1) {
		type = FetchByte(p);
		if (type == 0) {
			break;
		}
		a = FetchByte(p);
		b = FetchByte(p);
		c = FetchByte(p);
		size = (c << 16) | (b << 8) | a;
		switch (type) {
			case 1:
				sample_rate = FetchByte(p);
				compression_type = FetchByte(p);
				wavlen += size - 2;
				wavp = realloc(wavp, wavlen);
				for (i = size - 2; i; --i) {
					wavp[w++] = FetchByte(p);
				}
				break;
			default:
				printf("Unsupported voc type: %d\n", type);
				break;
		}
	}

	sprintf(buf, "%s/%s/%s.wav.gz", Dir, SOUND_PATH, file);
	CheckPath(buf);
	gf = gzopen(buf, "wb9");
	if (!gf) {
		perror("");
		printf("Can't open %s\n", buf);
		exit(-1);
	}
	gzprintf(gf, "RIFF");
	i = wavlen + 36;
	gzwrite(gf, &i, 4);
	gzprintf(gf, "WAVE");
	gzprintf(gf, "fmt ");
	i = 16;
	gzwrite(gf, &i, 4);
	s = 1;
	gzwrite(gf, &s, 2); // format
	gzwrite(gf, &s, 2); // channels
	i = 11025;
	gzwrite(gf, &i, 4); // samples per sec
	gzwrite(gf, &i, 4); // avg bytes per sec
	s = 1;
	gzwrite(gf, &s, 2); // block alignment
	s = 8;
	gzwrite(gf, &s, 2); // sample size
	gzprintf(gf, "data");
	i = wavlen;
	gzwrite(gf, &i, 4);
	gzwrite(gf, wavp, wavlen);

	free(vocp);

	gzclose(gf);
	return 0;
}

//----------------------------------------------------------------------------
//  Text
//----------------------------------------------------------------------------

/**
**  Convert text to my format.
*/
int ConvertText(char* file, int txte, int ofs)
{
	unsigned char* txtp;
	char buf[1024];
	gzFile gf;
	int l;

	txtp = ExtractEntry(ArchiveOffsets[txte], &l);
	if (!txtp) {
		return 0;
	}
	sprintf(buf, "%s/%s/%s.txt.gz", Dir, TEXT_PATH, file);
	CheckPath(buf);
	gf = gzopen(buf, "wb9");
	if (!gf) {
		perror("");
		printf("Can't open %s\n", buf);
		exit(-1);
	}
	if (l - ofs - 1 != gzwrite(gf, txtp + ofs, l - ofs - 1)) {
		printf("Can't write %d bytes\n", l - ofs - 1);
	}

	free(txtp);

	gzclose(gf);
	return 0;
}

/**
**  Save the players
**
**  @param f      File handle
**  @param mtxme  Entry number of map.
*/
static void SmsSaveObjectives(gzFile sms, FILE* sms_c2, unsigned char* txtp, const char* lvlpath, char* race)
{
	int offset;
	unsigned int i;
	char objectives[1024];

	offset = ConvertLE16(*(unsigned short*)(txtp + 0x94));
	if (!offset) {
		return;
	}

	
	fprintf(sms_c2, "title = \"%s\"\n", lvlpath);
	fprintf(sms_c2, "objectives = {\"");
	strcpy(objectives, (const char*)(txtp + offset));
	for (i = 0; i < strlen(objectives); i++) {
		if (objectives[i] == '\n' || objectives[i] == '\r') {
			objectives[i] = ' ';
		}
	}
	fprintf(sms_c2, objectives);
	fprintf(sms_c2, "\"}\n");

	gzprintf(sms, "-- Stratagus Map - Single player campaign\n\n");

	gzprintf(sms, "Load(\"%s_c2.sms\")\n\n", lvlpath);
	gzprintf(sms, "Briefing(\n");
        gzprintf(sms, "  title,\n");
        gzprintf(sms, "  objectives,\n");
        gzprintf(sms, "  \"../graphics/ui/%s/briefing.png\",\n", race);
	gzprintf(sms, "  \"%s_intro.txt\",\n", lvlpath);
	gzprintf(sms, "  {\"%s_intro.wav\"}\n", lvlpath);
	gzprintf(sms, ")\n\n");

	// TODO: Use actual triggers
	gzprintf(sms, "Triggers = [[\n");
	gzprintf(sms, "AddTrigger(\n");
	gzprintf(sms, "  function() return GetNumOpponents(GetThisPlayer()) == 0 end,\n");
	gzprintf(sms, "  function() return ActionVictory() end)\n");
	gzprintf(sms, "AddTrigger(\n");
	gzprintf(sms, "  function() return GetPlayerData(GetThisPlayer(), \"TotalNumUnits\") == 0 end,\n");
	gzprintf(sms, "  function() return ActionDefeat() end)\n");
	gzprintf(sms, "]]\n\n");
	gzprintf(sms, "assert(loadstring(Triggers))()\n\n");

	// TODO: Restrict units
}

/**
**  Save the players
**
**  @param f      File handle
**  @param mtxme  Entry number of map.
*/
static void SmsSavePlayers(char* race, gzFile sms, gzFile smp)
{
	int i;
	
	for (i = 0; i < 16; ++i) {
		gzprintf(sms, "SetStartView(%d, 0, 0)\n", i);
		gzprintf(sms, "SetPlayerData(%d, \"Resources\", \"gold\", 1000)\n", i);
		gzprintf(sms, "SetPlayerData(%d, \"Resources\", \"wood\", 1000)\n", i);
		if (i == 0) {
			gzprintf(sms, "SetPlayerData(%d, \"RaceName\", \"%s\")\n", i, race);
		} else if (i == 15) {
			gzprintf(sms, "SetPlayerData(%d, \"RaceName\", \"neutral\")\n", i);
		} else {
			if (strcmp(race, "orc")) {
				gzprintf(sms, "SetPlayerData(%d, \"RaceName\", \"human\")\n", i);
			} else {
				gzprintf(sms, "SetPlayerData(%d, \"RaceName\", \"orc\")\n", i);
			}
		}
		gzprintf(sms, "SetAiType(%d, \"wc1-passive\")\n", i);
	}
	gzprintf(smp, "-- Stratagus Map Presentation\n");
	gzprintf(smp, "-- Generated from war1tool\n\n");

	gzprintf(smp, "DefinePlayerTypes(\"person\", \"computer\", ");
	for (i = 2; i < 15; ++i) {
		gzprintf(smp, "\"nobody\", ");
	}
	gzprintf(smp, "\"neutral\")\n");
}

/**
**  Save the map
**
**  @param f      File handle
**  @param mtxme  Entry number of map.
*/
static void SmsSaveMap(gzFile sms, gzFile smp, int mtxme, const char* lvlpath)
{
	unsigned char* mtxm;
	unsigned char* p;
	unsigned short s;
	int i;
	int j;

	mtxm = ExtractEntry(ArchiveOffsets[mtxme], NULL);
	if (!mtxm) {
		return;
	}

	p = mtxm;

	gzprintf(smp, "PresentMap(\"(unnamed)\", 16, 64, 64, 1)\n");
	// TODO: this next line causes loading of the maps to fail. investigate.
	// gzprintf(smp, "DefineMapSetup(\"%s_c.sms\")\n", lvlpath);

	gzprintf(sms, "LoadTileModels(\"scripts/tilesets/forest.lua\")\n\n");

	// TODO: Save actual map layout
	for (i = 0; i < 64; ++i) {
		gzprintf(sms, "  -- %d\n",i);
		for (j = 0; j < 64; ++j) {
			s = FetchLE16(p);
			gzprintf(sms, "SetTile(%d, %d, %d, 0)\n", s, j, i);
		}
	}
	gzprintf(sms, "\n");

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
**  Save the units to cm.
**
**  @param f  File handle
*/
static void SmsSaveUnits(gzFile f, unsigned char* txtp)
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
	int startx;
	int starty;
	int endx;
	int endy;

	gzprintf(f, "if (MapUnitsInit ~= nil) then MapUnitsInit() end\n");

	p = txtp;
	while (p[0] != 0xFF || p[1] != 0xFF || p[2] != 0xFF || p[3] != 0xFF) {
		++p;
	}
	p += 4;
	while (p[0] != 0xFF || p[1] != 0xFF || p[2] != 0xFF || p[3] != 0xFF) {
		++p;
	}
	p += 4;
	x = FetchLE16(p);
	p = txtp + x;

	numunits = 0;
	p2 = p;
	while (p2[0] != 0xFF || p2[1] != 0xFF) {
		SkipByte(p2);
		SkipByte(p2);
		type = FetchByte(p2);
		SkipByte(p2);
		if (type == 0x32) {
			// gold mine
			SkipByte(p2);
			SkipByte(p2);
		}
		++numunits;
	}

	/* gzprintf(f, "SlotUsage(0, \"-\", %d)\n", numunits - 1); */

	i = 0;
	while (p[0] != 0xFF || p[1] != 0xFF) {
		x = FetchByte(p);
		x /= 2;
		y = FetchByte(p);
		y /= 2;
		type = FetchByte(p);
		player = FetchByte(p);
		if (player == 4) {
			player = 15;
		}
		if (type == 0x32) {
			// gold mine
			value = FetchByte(p);
			value = FetchByte(p);
			value *= 250;
		} else {
			value = 0;
		}

		gzprintf(f, "unit = CreateUnit(\"%s\", %d, {%d, %d})\n", UnitTypes[type], player, x, y);
		if (value) {
			gzprintf(f, "SetResourcesHeld(unit, %d)\n", value);
		}
		++i;
	}

	p += 2;
	while (p[0] != 0xFF || p[1] != 0xFF) {
		startx = FetchByte(p);
		startx /= 2;
		starty = FetchByte(p);
		starty /= 2;
		endx = FetchByte(p);
		endx /= 2;
		endy = FetchByte(p);
		endy /= 2;
		type = FetchByte(p);
		/* gzprintf(f, "-- Roads (%d):", type); */
		for (x = startx; x <= endx; ++x) {
			for (y = starty; y <= endy; ++y) {
				/* gzprintf(f, " {%d, %d}", x, y); */
			}
		}
		/* gzprintf(f, "\n"); */
	}
}

/**
**  Convert a map to Stratagus map format.
*/
int ConvertMap(const char* file, int txte, int mtxme)
{
	unsigned char* txtp;
	unsigned char buf[1024];
	char* race;
	gzFile smp, sms;
	FILE *sms_c, *sms_c2;

	txtp = ExtractEntry(ArchiveOffsets[txte], NULL);
	if (!txtp) {
		return 0;
	}
	sprintf((char*)buf, "%s/%s/%s.smp.gz", Dir, CM_PATH, file);
	CheckPath((char*)buf);
	smp = gzopen((char*)buf, "wb9");
	sprintf((char*)buf, "%s/%s/%s.sms.gz", Dir, CM_PATH, file);
	sms = gzopen((char*)buf, "wb9");
	if (!smp || !sms) {
		perror("");
		fprintf(stderr, "Can't open map file for %s/%s/%s\n",
			Dir, CM_PATH, file);
		exit(-1);
	}

	sprintf((char*)buf, "%s/%s/%s_c.sms", Dir, CM_PATH, file);
	sms_c = fopen((char*)buf, "wb");
	sprintf((char*)buf, "%s/%s/%s_c2.sms", Dir, CM_PATH, file);
	sms_c2 = fopen((char*)buf, "wb");
	if (!sms_c || !sms_c2) {
		perror("");
		fprintf(stderr, "Can't open campaign file for %s/%s/%s\n",
			Dir, CM_PATH, file);
		exit(-1);
	}

	// Get the race
	race = (char*)calloc(sizeof(char), 1024);
	strcpy(race, file);
	assert(strlen(race) > 3 && race[strlen(race) - 3] == '/');
	race[strlen(race) - 3] = '\0';
	while (strstr(race, "/")) {
		race++;
	}

	SmsSaveObjectives(sms, sms_c2, txtp, file, race);
	SmsSavePlayers(race, sms, smp);
	SmsSaveMap(sms, smp, mtxme, file);
	SmsSaveUnits(sms, txtp);

	fprintf(sms_c, "Load(\"%s.sms\")", file);
	fclose(sms_c);
	fclose(sms_c2);

	free(txtp);
	gzclose(sms);
	gzclose(smp);
	return 0;
}

//----------------------------------------------------------------------------
//  Main loop
//----------------------------------------------------------------------------

/**
**  Display the usage.
*/
void Usage(const char* name)
{
	printf("war1tool for Stratagus (c) 2003-2004 by the Stratagus Project\n\
Usage: %s archive-directory [destination-directory]\n\
archive-directory\tDirectory which includes the archives maindat.war...\n\
destination-directory\tDirectory where the extracted files are placed.\n"
	,name);
}

/**
**  Main
*/
#undef main
int main(int argc, char** argv)
{
	unsigned u;
	char buf[1024];
	int a;
	int upper;
	struct stat st;

	a = 1;
	upper = 0;
	while (argc >= 2) {
		if (!strcmp(argv[a], "-h")) {
			Usage(argv[0]);
			++a;
			--argc;
			exit(0);
		}
		break;
	}

	if (argc != 2 && argc != 3) {
		Usage(argv[0]);
		exit(-1);
	}

	ArchiveDir = argv[a];
	if (argc == 3) {
		Dir = argv[a + 1];
	} else {
		Dir = "data";
	}

#ifdef DEBUG
	printf("Extract from \"%s\" to \"%s\"\n", ArchiveDir, Dir);
#endif

	sprintf(buf, "%s/data.war", ArchiveDir);
	if (stat(buf, &st)) {
		sprintf(buf, "%s/DATA.WAR", ArchiveDir);
		upper = 1;
	}

	for (u = 0; u < sizeof(Todo) / sizeof(*Todo); ++u) {
		// Should only be on the expansion cd
#ifdef DEBUG
		printf("%s:\n", Todo[u].File);
#endif
		switch (Todo[u].Type) {
			case F:
				if (upper) {
					int i = 0;
					char filename[1024];
					strcpy(filename, Todo[u].File);
					Todo[u].File = filename ;
					while (Todo[u].File[i]) {
						Todo[u].File[i] = toupper(Todo[u].File[i]);
						++i;
					}
				}

				sprintf(buf, "%s/%s", ArchiveDir, Todo[u].File);
#ifdef DEBUG
				printf("Archive \"%s\"\n", buf);
#endif
				if (ArchiveBuffer) {
					CloseArchive();
				}
				OpenArchive(buf, Todo[u].Arg1);
				break;
			case FLC:
				if (upper) {
					int i = 0;
					char filename[1024];
					strcpy(filename, Todo[u].File);
					Todo[u].File = filename;
					while (Todo[u].File[i]) {
						Todo[u].File[i] = toupper(Todo[u].File[i]);
						++i;
					}
				}
				sprintf(buf, "%s/%s", ArchiveDir, Todo[u].File);
				ConvertFLC(buf, Todo[u].File);
				break;
			case T:
				ConvertTileset(Todo[u].File, Todo[u].Arg1);
				break;
			case U:
				ConvertGfu(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
				break;
			case I:
				ConvertImage(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
				break;
			case C:
				ConvertCursor(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
				break;
			case W:
				ConvertWav(Todo[u].File, Todo[u].Arg1);
				break;
			case M:
				ConvertXmi(Todo[u].File, Todo[u].Arg1);
				break;
			case VOC:
				ConvertVoc(Todo[u].File, Todo[u].Arg1);
				break;
			case X:
				ConvertText(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
				break;
			case CM:
				ConvertMap(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
				break;
			default:
				break;
		}
	}

	return 0;
}

//@}
