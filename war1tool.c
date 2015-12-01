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

#define VERSION "2.2.7" // Version of extractor wartool
#define AUTHORS "Lutz Sammer, Nehal Mistry, Jimmy Salmon, Pali Rohar, and Tim Felgentreff."
#define COPYRIGHT "1998-2013 by The Stratagus Project"

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
#include "scale2x.h"

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
#define unlink(x) _unlink(x)
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
#define AccessByte(p) (*((unsigned char*)(p)))
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
**  Path to the video files.
*/
#define VIDEO_PATH  "videos"

#define DEFAULT_DATA_DIR "data.wc1"

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
	TU, // Tileset unit (for walls and roads)
	RP, // Tileset ruin parts (for destroyed buildings)
	I,						// Image						(name,pal,img)
	W,						// Wav							(name,wav)
	M,						// XMI Midi Sound					(name,xmi)
	X,						// Text							(name,text,ofs)
	X2,						// Text2						(name,text)
	C,						// Cursor						(name,cursor)
	FLC,					// FLC
	VOC,					// VOC
	CM,						// Cm
	CS,						// skirmish maps
};

#define NumUnitDirections 16

typedef struct _unit_directions_ {
    const char* name; // just for readability
    int directions[NumUnitDirections];
} UnitDirections;

UnitDirections TilesetUnitDirections[] = {
    {"forest-wall", {16, 11, 18, 12, 21, 21, 20, 15, 18, 10, 18, 14, 17, 13, 19, 16}},
    {"swamp-wall", {16, 11, 18, 12, 21, 21, 20, 15, 18, 10, 18, 14, 17, 13, 19, 16}},
    {"dungeon-wall", {66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66}},

    {"forest-road", {64, 59, 58, 62, 57, 61, 70, 65, 56, 60, 68, 64, 67, 63, 69, 66}},
    {"swamp-road", {65, 60, 59, 63, 58, 62, 71, 66, 57, 61, 69, 65, 68, 64, 70, 67}},
    {"dungeon-road", {81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81}}
};

#define MaxRuinDimensions 4
#define _7  ,0,0,0,0,0,0,0
#define _12  ,0,0,0,0,0,0,0,0,0,0,0,0
#define _15  ,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
typedef struct _ruin_parts_ {
	const char* name; // just for readability
	int parts[MaxRuinDimensions*MaxRuinDimensions];
} RuinParts;

RuinParts TilesetRuinParts[] = {
	{ "forest-ruins4x4",{ 41, 42, 42, 43, 44, 45, 45, 46, 44, 45, 45, 46, 47, 48, 48, 49 } },
	{ "swamp-ruins4x4",{ 42, 43, 43, 44, 45, 46, 46, 47, 45, 46, 46, 47, 48, 49, 49, 50 } },
	{ "dungeon-ruins4x4",{ 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83, 83 } },
	{ "forest-ruins3x3",{ 41, 42, 43, 44, 45, 46, 47, 48, 49 _7 } },
	{ "swamp-ruins3x3",{ 42, 43, 44, 45, 46, 47, 48, 49, 50 _7 } },
	{ "dungeon-ruins3x3",{ 83, 83, 83, 83, 83, 83, 83, 83, 83 _7 } },
	{ "forest-ruins2x2",{ 41, 43, 47, 49 _12 } },
	{ "swamp-ruins2x2",{ 42, 44, 48, 50 _12 } },
	{ "dungeon-ruins2x2",{ 83, 83, 83, 83 _12 } },
	{ "forest-ruins1x1",{ 55 _15 } },
	{ "swamp-ruins1x1",{ 54 _15 } },
	{ "dungeon-ruins1x1",{ 83 _15 } },
	{ "forest-wall-construction",{ 34 _15 } },
	{ "swamp-wall-construction",{ 34 _15 } },
	{ "dungeon-wall-construction",{ 22 _15 } }
};

char* ArchiveDir;

/**
**  What, where, how to extract.
*/
Control Todo[] = {
#define __  ,0,0,0
#define _2  ,0,0,
#define _1  ,0
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

{CM,0,"campaigns/human/01", 117, 63 _2},
{CM,0,"campaigns/human/02", 119, 55 _2},
{CM,0,"campaigns/human/03", 121, 69 _2},
{CM,0,"campaigns/human/04", 123, 97 _2},
{CM,0,"campaigns/human/05", 125, 57 _2},
{CM,0,"campaigns/human/06", 127, 47 _2},
{CM,0,"campaigns/human/07", 129, 67 _2},
{CM,0,"campaigns/human/08", 131, 95 _2},
{CM,0,"campaigns/human/09", 133, 71 _2},
{CM,0,"campaigns/human/10", 135, 73 _2},
{CM,0,"campaigns/human/11", 137, 75 _2},
{CM,0,"campaigns/human/12", 139, 77 _2},
{CM,0,"campaigns/orc/01", 118, 79 _2},
{CM,0,"campaigns/orc/02", 120, 81 _2},
{CM,0,"campaigns/orc/03", 122, 49 _2},
{CM,0,"campaigns/orc/04", 124, 93 _2},
{CM,0,"campaigns/orc/05", 126, 83 _2},
{CM,0,"campaigns/orc/06", 128, 65 _2},
{CM,0,"campaigns/orc/07", 130, 85 _2},
{CM,0,"campaigns/orc/08", 132, 99 _2},
{CM,0,"campaigns/orc/09", 134, 87 _2},
{CM,0,"campaigns/orc/10", 136, 53 _2},
{CM,0,"campaigns/orc/11", 138, 45 _2},
{CM,0,"campaigns/orc/12", 140, 59 _2},

// custom maps
{CS,0,"maps/forest1", 51 __},
{CS,0,"maps/forest2", 61 __},
{CS,0,"maps/swamp1", 89 __},
{CS,0,"maps/swamp2", 91 __},
{CS,0,"maps/dungeon1", 101 __},
{CS,0,"maps/dungeon2", 103 __},
{CS,0,"maps/dungeon3", 105 __},
{CS,0,"maps/dungeon4", 107 __},
{CS,0,"maps/dungeon5", 109 __},
{CS,0,"maps/dungeon6", 111 __},
{CS,0,"maps/dungeon7", 113 __},
{CS,0,"maps/dungeon8", 115 __},

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
{X,0,"orc/01_intro",										 432 __},
{X,0,"orc/02_intro",										 433 __},
{X,0,"orc/03_intro",										 434 __},
{X,0,"orc/04_intro",										 435 __},
{X,0,"orc/05_intro",										 436 __},
{X,0,"orc/06_intro",										 437 __},
{X,0,"orc/07_intro",										 438 __},
{X,0,"orc/08_intro",										 439 __},
{X,0,"orc/09_intro",										 440 __},
{X,0,"orc/10_intro",										 441 __},
{X,0,"orc/11_intro",										 442 __},
{X,0,"orc/12_intro",										 443 __},
{X,0,"human/01_intro",										 444 __},
{X,0,"human/02_intro",										 445 __},
{X,0,"human/03_intro",										 446 __},
{X,0,"human/04_intro",										 447 __},
{X,0,"human/05_intro",										 448 __},
{X,0,"human/06_intro",										 449 __},
{X,0,"human/07_intro",										 450 __},
{X,0,"human/08_intro",										 451 __},
{X,0,"human/09_intro",										 452 __},
{X,0,"human/10_intro",										 453 __},
{X,0,"human/11_intro",										 454 __},
{X,0,"human/12_intro",										 455 __},
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
{U,0,"human/units/medivh",									 191, 293 _2},
{U,0,"human/units/lothar",									 191, 294 _2},
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
// here come buildings
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
// here come dead bodies, and workers with resources
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

{TU,0,"forest/neutral/buildings/wall",190,0 _2},
{TU,0,"swamp/neutral/buildings/wall",193,1 _2},
{TU,0,"dungeon/neutral/buildings/wall",196,2 _2},

{TU,0,"forest/neutral/buildings/road",190,3 _2},
{TU,0,"swamp/neutral/buildings/road",193,4 _2},
{TU,0,"dungeon/neutral/buildings/road",196,5 _2},

{RP,0,"forest/neutral/buildings/ruins",190,0,4 _1},
{RP,0,"swamp/neutral/buildings/ruins",193,1,4 _1},
{RP,0,"dungeon/neutral/buildings/ruins",196,2,4 _1},
{RP,0,"forest/neutral/buildings/ruins",190,3,3 _1 },
{RP,0,"swamp/neutral/buildings/ruins",193,4,3 _1 },
{RP,0,"dungeon/neutral/buildings/ruins",196,5,3 _1 },
{RP,0,"forest/neutral/buildings/ruins",190,6,2 _1 },
{RP,0,"swamp/neutral/buildings/ruins",193,7,2 _1 },
{RP,0,"dungeon/neutral/buildings/ruins",196,8,2 _1 },
{RP,0,"forest/neutral/buildings/ruins",190,9,1 _1 },
{RP,0,"swamp/neutral/buildings/ruins",193,10,1 _1 },
{RP,0,"dungeon/neutral/buildings/ruins",196,11,1 _1 },
{RP,0,"forest/neutral/buildings/wall",190,12,1 _1 },
{RP,0,"swamp/neutral/buildings/wall",193,13,1 _1 },
{RP,0,"dungeon/neutral/buildings/wall",196,14,1 _1 },

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



// This which can be allowed/disallowed in maps.
// A bitmask of 1 << these things can be found in MapFlags.
struct _allowed_features_ {
	const char* thing[2];
};
struct _allowed_features_ AllowedFeatures[] = {
	// Units. 0 - 6
	{"unit-footman", "unit-grunt"},
	{"unit-peasant", "unit-peon"},
	{"unit-human-catapult", "unit-orc-catapult"},
	{"unit-knight", "unit-raider"},
	{"unit-archer", "unit-spearman"},
	{"unit-conjurer", "unit-warlock"},
	{"unit-cleric", "unit-necrolyte"},
	// Constructing buildings. 7 - 14
	{"unit-human-farm", "unit-orc-farm"},
	{"unit-human-barracks", "unit-orc-barracks"},
	{"unit-human-church", "unit-orc-temple"},
	{"unit-human-tower", "unit-orc-tower"},
	{"unit-human-town-hall", "unit-orc-town-hall"},
	{"unit-human-lumber-mill", "unit-orc-lumber-mill"},
	{"unit-human-stable", "unit-orc-kennel"},
	{"unit-human-blacksmith", "unit-orc-blacksmith"},
	// Cleric/Necrolyte spells. 15 - 17
	{"upgrade-healing", "upgrade-raise-dead"},
	{"upgrade-holy-vision", "upgrade-dark-vision"},
	{"upgrade-invisibility", "upgrade-unholy-armor"},
	// Conjurer/Warlock spells. 18 - 20
	{"upgrade-scorpion", "upgrade-spider"},
	{"upgrade-rain-of-fire", "upgrade-poison-cloud"},
	{"upgrade-water-elemental", "upgrade-daemon"},
	// Roads and walls. 21 - 22
	{"unit-road", "unit-road"},
	{"unit-wall", "unit-wall"}
};
int MaxAllowedFeature = 22;
#define SkipFeature(f) (f >= 15 && f <= 21)
#define IsAllowedFeature(id, feature) ((id & (1 << (int)feature)) != 0)

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
	} else {
	    mkdir(cp, 0777);
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
	if (ow == nw && nh == oh) {
		return;
	}
	if (!(ow * 2 == nw && oh * 2 == nh)) {
		fprintf(stderr, "Can only scale by factors of two!");
		exit(-1);
	}
	unsigned char* data;
	data = (unsigned char*)malloc(nw * nh);

	//int i;
	//int j;
	//int x;
	//x = 0;
	//for (i = 0; i < nh; ++i) {
	//	for (j = 0; j < nw; ++j) {
	//		data[x] = ((unsigned char*)*image)[
	//			i * oh / nh * ow + j * ow / nw];
	//		++x;
	//	}
	//}
	scale2x(data, *image, ow, oh);

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
                    			bi &= 0xFFF;
					buf[bi] = j;
                    			bi++;
				} else {
					o = FetchLE16(cp);
					j = (o >> 12) + 3;
					o &= 0xFFF;
					while (j--) {
						o &= 0xFFF;
                        			bi &= 0xFFF;
                        			*dp = buf[o];
                        			dp++;
                        			buf[bi] = buf[o];
                        			bi++;
                       				 o++;
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
#if 0
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

	sprintf(pngbuf, "%s-%04d.png", FLCFile, FLCFrame++);
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

	sprintf(pngbuf, "%s-%04d.png", FLCFile, FLCFrame++);
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

	sprintf(pngbuf, "%s-%04d.png", FLCFile, FLCFrame++);
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

	sprintf(pngbuf, "%s-%04d.png", FLCFile, FLCFrame++);
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
**  Convert pngs using ffmpeg2theora.
*/
void EncodeFLC(const char* flc, int speed)
{
	int ret, i;
	char *cmd, *output, *buf;
	char pngfiles[1024];
	char cmdprefix[512];
	struct stat st;

	sprintf(cmdprefix, "ffmpeg2theora --inputfps %d --resize-method lanczos -v 10 --max_size 640 -o", speed);

	output = (char*)calloc(sizeof(char), strlen(flc) + 1);
	strcpy(output, flc);
	for (i = 0; i < (int)strlen(output); i++) {
		output[i] = tolower(output[i]);
	}
	output[strlen(output) - 3] = 'a';
	output[strlen(output) - 2] = 'v';
	output[strlen(output) - 1] = 'i';

	buf = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(VIDEO_PATH) + 1 + strlen(output) + 1);
	sprintf(buf, "%s/%s/%s", Dir, VIDEO_PATH, output);
	CheckPath(buf);	

	sprintf(pngfiles, "%s-%%04d.png", FLCFile);

	cmd = (char*)calloc(sizeof(char), strlen(cmdprefix) + 2 + strlen(pngfiles) + 3 + strlen(buf) + 2);
	sprintf(cmd, "%s \"%s\" \"%s\"", cmdprefix, buf, pngfiles);
	ret = system(cmd);

	for (i = 0; i < 1000; i++) {
		sprintf(pngfiles, "%s-%04d.png", FLCFile, i);
		if (!stat(pngfiles, &st)) {
			unlink(pngfiles);
		}
	}

	free(buf);
	free(cmd);
	free(output);

	if (ret != 0) {
		printf("Can't convert video %s to ogv format. Is ffmpeg2theora installed in PATH?\n", flc);
		fflush(stdout);
	}
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

	sprintf(FLCFile, "%s/%s/%s", Dir, VIDEO_PATH, flc);
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

	EncodeFLC(flc, speed);

	free(buf);
	free(FLCImage);
}
#else
/**
**  Convert FLC using ffmpeg. Manual conversion into PNGs (above) and
**  then into ogv should produce better results, but ffmpeg2theora
**  screws up the colors. Until then, just convert directly, and live
**  with the direct conversion bugs.
*/
void ConvertFLC(const char* file, const char* flc)
{
	int ret;
	char *cmd, *output, *outputPath;
	/* char *cmdprefix = "ffmpeg2theora --resize-method lanczos -v 10 -V 1000 --soft-target --two-pass --noaudio --max_size 640 -o"; */
	char *cmdprefix = "ffmpeg -y -i ";
	char *outputOptions = " -q:v 10 -vb 4000k -vf scale=640:-1 ";

	output = (char*)calloc(sizeof(char), strlen(flc) + 1);
	strcpy(output, flc);
	output[strlen(output) - 3] = 'o';
	output[strlen(output) - 2] = 'g';
	output[strlen(output) - 1] = 'v';

	outputPath = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(VIDEO_PATH) + 1 + strlen(output) + 1);
	sprintf(outputPath, "%s/%s/%s", Dir, VIDEO_PATH, output);
	CheckPath(outputPath);	

	cmd = (char*)calloc(sizeof(char), strlen(cmdprefix) + 2 + strlen(file) + strlen(outputOptions) + 3 + strlen(outputPath) + 2);
	sprintf(cmd, "%s \"%s\"%s\"%s\"", cmdprefix, file, outputOptions, outputPath);
	ret = system(cmd);

	free(outputPath);
	free(cmd);
	free(output);

	if (ret != 0) {
		printf("Can't convert video %s to ogv format. Is ffmpeg installed in PATH?\n", file);
		fflush(stdout);
	}
}

/**
** Mux intro music and video using ffmpeg. TODO: find a way to do this inline
*/
void MuxIntroVideos(void) {
	char* videos[] = {"HINTRO1.ogv", "HINTRO2.ogv",
			  "OINTRO1.ogv", "OINTRO2.ogv", "OINTRO3.ogv",
			  "CAVE1.ogv", "CAVE2.ogv", "CAVE3.ogv",
			  "TITLE.ogv"};
	char* audios[] = {"intro_1.wav", "intro_2.wav",
			  "intro_3.wav", "intro_door.wav",
			  "intro_4.wav",
			  "intro_5.wav"};

	int repeats[] = {1, 11,
			 1, 17, 1,
			 1, 2, 1,
			 1};

	int i, j, ret;
	size_t readM;
	gzFile wavGz;
	FILE *wavFile;
	char *cmd, *outputVideo, *outputAudio, *inputAudio, *inputWavGz, *outputIntro, *buf;
	unsigned char *wavBuffer;
	char *cmdprefix = "ffmpeg -y -f concat -i ";
	char *cmdsuffixVideo = " -c copy ";
	char *cmdsuffixAudio = " -acodec libvorbis";
	char *encoderIntroOpts = " -shortest -c copy ";
	FILE* mylist;
	char listfile[2048] = { '\0' };
	sprintf(listfile, "%s/%s/mylist.txt", Dir, VIDEO_PATH);

	// VIDEO
	mylist = fopen(listfile, "w");
	for (i = 0; i < 9; i++) {
		for (j = 0; j < repeats[i]; j++) {
			fprintf(mylist, "file '%s'\n", videos[i]);
		}
	}
	outputVideo = (char*)calloc(sizeof(char), 1 + strlen(Dir) + 1 + strlen(VIDEO_PATH) + 1 + strlen("INTRO.ogg") + 2);
	sprintf(outputVideo, "\"%s/%s/INTRO.ogg\"", Dir, VIDEO_PATH);
	cmd = (char*)calloc(sizeof(char), strlen(cmdprefix) + strlen(listfile) + strlen(cmdsuffixVideo) + strlen(outputVideo));
	sprintf(cmd, "%s %s %s %s", cmdprefix, listfile, cmdsuffixVideo, outputVideo);
	fclose(mylist);
	printf("%s\n\n", cmd);
	fflush(stdout);
	ret = system(cmd);
	if (ret != 0) {
		printf("Can't concat intro videos. Is ffmpeg installed in PATH?\n");
		fflush(stdout);
		exit(-1);
	}
	free(cmd);
	unlink(listfile);

	// AUDIO
	sprintf(listfile, "%s/%s/mylist.txt", Dir, SOUND_PATH);
	mylist = fopen(listfile, "w");
	for (i = 0; i < 6; i++) {
		inputWavGz = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(SOUND_PATH) + 1 + strlen(audios[i]) + 4);
	 	sprintf(inputWavGz, "%s/%s/%s.gz", Dir, SOUND_PATH, audios[i]);
	 	wavGz = gzopen(inputWavGz, "rb");
	 	if (!wavGz) {
	 		printf("Can't open %s for muxing\n", inputWavGz);
	 		fflush(stdout);
	 		free(inputWavGz);
	 		continue;
	 	}
	 
	 	inputAudio = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(SOUND_PATH) + 1 + strlen(audios[i]) + 4);
	 	sprintf(inputAudio, "%s/%s/%s", Dir, SOUND_PATH, audios[i]);
		wavFile = fopen(inputAudio, "wb");
	 	if (!wavGz) {
	 		printf("Can't open %s for muxing\n", inputAudio);
	 		fflush(stdout);
	 		free(inputWavGz);
	 		gzclose(wavGz);
	 		free(inputAudio);
	 		continue;
	 	}
	 
	 	wavBuffer = (unsigned char*)calloc(sizeof(char), 1024 * 128);
	 	while((readM = gzread(wavGz, wavBuffer, 1024 * 128 * sizeof(char))) > 0) {
			printf("writing %d to %s from %s\n", readM, inputAudio, inputWavGz);
	 		fwrite(wavBuffer, sizeof(char), readM,  wavFile);
			fflush(wavFile);
	 	}
	 	free(wavBuffer);
	 	unlink(inputWavGz);
	 	free(inputWavGz);
	 	gzclose(wavGz);
	 	fclose(wavFile);

		fprintf(mylist, "file '%s'\n", audios[i]);
		free(inputAudio);
	}
	outputAudio = (char*)calloc(sizeof(char), 1 + strlen(Dir) + 1 + strlen(SOUND_PATH) + 1 + strlen("INTRO.ogg") + 2);
	sprintf(outputAudio, "\"%s/%s/INTRO.ogg\"", Dir, SOUND_PATH);
	cmd = (char*)calloc(sizeof(char), strlen(cmdprefix) + strlen(listfile) + strlen(cmdsuffixAudio) + strlen(outputAudio));
	sprintf(cmd, "%s %s %s %s", cmdprefix, listfile, cmdsuffixAudio, outputAudio);
	fclose(mylist);
	printf("%s\n\n", cmd);
	fflush(stdout);
	ret = system(cmd);
	if (ret != 0) {
		printf("Can't concat intro videos. Is ffmpeg installed in PATH?\n");
		fflush(stdout);
		exit(-1);
	}
	free(cmd);
	unlink(listfile);

	// Mux
	cmdprefix = "ffmpeg -y ";
	outputIntro = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(VIDEO_PATH) + 1 + strlen("INTRO.ogv") + 2);
	sprintf(outputIntro, "\"%s/%s/INTRO.ogv\"", Dir, VIDEO_PATH);
	cmd = (char*)calloc(sizeof(char), strlen(cmdprefix) + 1 +
 			    strlen("-i") + 1 + strlen(outputVideo) + 1 +
			    strlen("-i") + 1 + strlen(outputAudio) + 1 +
			    1 + strlen(encoderIntroOpts) + 1 +
			    1 + strlen(outputIntro) + 2);
	sprintf(cmd, "%s -i %s -i %s %s %s", cmdprefix, outputVideo, outputAudio, encoderIntroOpts, outputIntro);
	printf("%s\n", cmd);
 	ret = system(cmd);
 	if (ret != 0) {
		printf("Can't mux intro video and audio. Is ffmpeg installed in PATH?\n");
		fflush(stdout);
	}
	free(outputIntro);
	free(cmd);
	
	// remove unneeded files
	for (i = 0; i < 9; i++) {
		buf = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(VIDEO_PATH) + 1 + strlen(videos[i]) + 1);
		sprintf(buf, "%s/%s/%s", Dir, VIDEO_PATH, videos[i]);
		unlink(buf);
		free(buf);
	}
	for (i = 0; i < 6; i++) {
		buf = (char*)calloc(sizeof(char), strlen(Dir) + 1 + strlen(SOUND_PATH) + 1 + strlen(audios[i]) + 1);
		sprintf(buf, "%s/%s/%s", Dir, SOUND_PATH, audios[i]);
		unlink(buf);
		free(buf);
	}

	// remove quotes, then unlink
	outputAudio[strlen(outputAudio) - 1] = '\0';
	outputVideo[strlen(outputVideo) - 1] = '\0';
	unlink(outputAudio + 1);
	unlink(outputVideo + 1);
	free(outputAudio);
	free(outputVideo);
}
#endif

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

/**
**  Convert one ore more tileset mini image to a separate unit png
*/
int ConvertTilesetUnit(char* file, int index, int directions_idx)
{
	unsigned char* palp;
	unsigned char* mini;
	unsigned char* mega;
	unsigned char* image;
	const unsigned short* mp;
	int msize;
	int height;
	int width;
	int x, y, direction;
	int offset;
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

	width = 16 * NumUnitDirections;
	height = 16;
	image = malloc(height * width);
	memset(image, 0, height * width);

	for (direction = 0; direction < NumUnitDirections; direction++) {
		mp = (const unsigned short*)(mega + TilesetUnitDirections[directions_idx].directions[direction] * 8);
		for (y = 0; y < 2; ++y) {
			for (x = 0; x < 2; ++x) {
				offset = ConvertLE16(mp[x + y * 2]);
				DecodeMiniTile(image,
					       direction * 2 + x, y,
					       width, mini,
					       (offset & 0xFFFC) << 1,
					       offset & 2, offset & 1);
			}
		}
	}

	ConvertPalette(palp);

	sprintf(buf, "%s/%s/%s.png", Dir, TILESET_PATH, file);
	CheckPath(buf);
	ResizeImage(&image, width, height, 2 * width, 2 * height);
	SavePNG(buf, image, 2 * width, 2 * height, palp, 0);

	free(palp);
	free(mini);
	free(mega);

	return 0;
}


/**
**  Convert one ore more tileset mini image to a separate unit png
*/
int ConvertRuin(char* file, int index, int partsidx, int dimensions)
{
	unsigned char* palp;
	unsigned char* mini;
	unsigned char* mega;
	unsigned char* image;
	const unsigned short* mp;
	int msize;
	int height;
	int width;
	int x, y, part;
	int offset;
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

	width = 16 * dimensions;
	height = 16 * dimensions;
	image = malloc(height * width);
	memset(image, 0, height * width);
	for (part = 0; part < dimensions*dimensions; part++) {
		mp = (const unsigned short*)(mega + TilesetRuinParts[partsidx].parts[part] * 8);
		for (y = 0; y < 2; ++y) {
			for (x = 0; x < 2; ++x) {
				offset = ConvertLE16(mp[x + y * 2]);
				DecodeMiniTile(image, (part % dimensions) * 2 + x, y + (part / dimensions) * 2, width, mini, (offset & 0xFFFC) << 1, 0, 0);
			}
		}
	}
	ConvertPalette(palp);
	sprintf(buf, "%s/%s/%s_%dx%d.png", Dir, TILESET_PATH, file, dimensions, dimensions);
	CheckPath(buf);
	ResizeImage(&image, width, height, 2 * width, 2 * height);
	SavePNG(buf, image, 2 * width, 2 * height, palp, 0);

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

	// force orc palette override. Forces Orc red to Human blue,
	// and then we can use that palette for changing the faction color
	if (strstr(file, "orc/") != NULL) {
		unsigned char* p = image;
		unsigned char* end = image + (2 * w * 2 * h);
		while (p < end) {
			if (*p >= 176 && *p <= 183) {
				*p = *p + 24;
			}
			++p;
		}
	}

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

	// force orc palette override for menu button on left panel.
	// switches the ugly pink (idx 215) to a dark blue (idx 154)
	if (strstr(file, "ui/orc/left_panel") != NULL) {
		unsigned char* p = image;
		unsigned char* end = image + (w * h);
		while (p < end) {
			if (*p == 215) {
				*p = 154;
			}
			++p;
		}
	}

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

	SkipLE16(p); // hoty
	SkipLE16(p); // hotx
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

void ConvertXmi(char* file, int xmi, short midiToOgg)
{
	unsigned char* xmip;
	unsigned char* midp;
	unsigned char* oggp;
	char buf[1024];
	char* cmd;
	gzFile gf;
	FILE* f;
	size_t xmil;
	size_t midl;
	size_t oggl;
	int ret;

	xmip = ExtractEntry(ArchiveOffsets[xmi], (int*)&xmil);
	midp = TranscodeXmiToMid(xmip, xmil, &midl);

	free(xmip);

	sprintf(buf, "%s/%s/%s.mid", Dir, MUSIC_PATH, file);
	CheckPath(buf);
	f = fopen(buf, "wb");
	if (!f) {
		perror("");
		printf("Can't open %s\n", buf);
		exit(-1);
	}
	if (midl != (size_t)fwrite(midp, 1, midl, f)) {
		printf("Can't write %d bytes\n", (int)midl);
		fflush(stdout);
	}
	free(midp);
	fclose(f);
	if (!midiToOgg) return;
	cmd = (char*)calloc(strlen("timidity -Ow \"") + strlen(buf) + strlen("\" -o \"") + strlen(buf) + strlen("\"") + 1, 1);
	if (!cmd) {
		fprintf(stderr, "Memory error\n");
		exit(-1);
	}

	sprintf(cmd, "timidity -Ow \"%s/%s/%s.mid\" -o \"%s/%s/%s.wav\"", Dir, MUSIC_PATH, file, Dir, MUSIC_PATH, file);

	ret = system(cmd);

	free(cmd);
	remove(buf);

	if (ret != 0) {
		printf("Can't convert midi sound %s to wav format. Is timidity installed in PATH?\n", file);
		fflush(stdout);
		return;
	}

	sprintf(buf, "%s/%s/%s.wav", Dir, MUSIC_PATH, file);
	CheckPath(buf);

	cmd = (char*)calloc(strlen("ffmpeg2theora --optimize \"") + strlen(buf) + strlen("\" -o \"") + strlen(buf) + strlen("\"") + 1, 1);
	if (!cmd) {
		fprintf(stderr, "Memory error\n");
		exit(-1);
	}

	sprintf(cmd, "ffmpeg2theora --optimize \"%s/%s/%s.wav\" -o \"%s/%s/%s.ogg\"", Dir, MUSIC_PATH, file, Dir, MUSIC_PATH, file);

	ret = system(cmd);

	free(cmd);
	remove(buf);

	if (ret != 0) {
		printf("Can't convert wav sound %s to ogv format. Is ffmpeg2theora installed in PATH?\n", file);
		fflush(stdout);
		return;
	}

	sprintf(buf, "%s/%s/%s.ogg", Dir, MUSIC_PATH, file);
	CheckPath(buf);
	f = fopen(buf, "rb");
	if (!f) {
		perror("");
		printf("Can't open %s\n", buf);
		exit(-1);
	}

	fseek(f, 0, SEEK_END);
	oggl = ftell(f);
	rewind(f);

	oggp = (unsigned char*)malloc(oggl);
	if (!oggp) {
		fprintf(stderr, "Memory error\n");
		exit(-1);
	}

	if (oggl != (size_t)fread(oggp, 1, oggl, f)) {
		printf("Can't read %d bytes\n", (int)oggl);
		fflush(stdout);
	}

	fclose(f);
	remove(buf);

	sprintf(buf, "%s/%s/%s.ogg.gz", Dir, MUSIC_PATH, file);
	CheckPath(buf);
	gf = gzopen(buf, "wb9");
	if (!gf) {
		perror("");
		printf("Can't open %s\n", buf);
		exit(-1);
	}

	if (oggl != (size_t)gzwrite(gf, oggp, oggl)) {
		printf("Can't write %d bytes\n", (int)oggl);
		fflush(stdout);
	}

	gzclose(gf);
	free(oggp);

	return;
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
	int size;
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
	SkipLE16(p);
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
				SkipByte(p);
				SkipByte(p);
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
static void SmsSaveObjectives(FILE* sms_c2, unsigned char* txtp)
{
	int offset;
	unsigned int i;
	char objectives[1024];

	offset = ConvertLE16(*(unsigned short*)(txtp + 0x94));
	if (!offset) {
		return;
	}

	fprintf(sms_c2, "objectives = {\"");
	strcpy(objectives, (const char*)(txtp + offset));
	for (i = 0; i < strlen(objectives); i++) {
		if (objectives[i] == '\n' || objectives[i] == '\r') {
			objectives[i] = ' ';
		}
	}
	fprintf(sms_c2, "%s", objectives);
	fprintf(sms_c2, "\"}\n");
}

static void SmsSaveResources(FILE* sms_c2, unsigned char* txtp)
{

	// 0x005C - 0x0069: 5xDWord: Lumber for each player.
	// 0x0070 - 0x0083: 5xDWord: Gold for each player. 
	fprintf(sms_c2, "\n-- Resources\n");
	for (int p = 0; p < 5; p++) {
		fprintf(sms_c2, "SetPlayerData(%d, \"Resources\", \"wood\", %d)\n", p, AccessLE32(txtp + 0x5c + (4 * p)));
		fprintf(sms_c2, "SetPlayerData(%d, \"Resources\", \"gold\", %d)\n", p, AccessLE32(txtp + 0x70 + (4 * p)));
	}
	fprintf(sms_c2, "\n");
}

static void SmsSaveAllowed(FILE* sms_c2, unsigned char* txtp)
{
	int allowid = AccessLE32(txtp);

	fprintf(sms_c2, "\n-- Allowed units\n"\
					"DefineAllowHumanUnits(\"FFFFFFFFFFFFFFFF\")\n"\
					"DefineAllowOrcUnits(\"FFFFFFFFFFFFFFFF\")\n");	
	fprintf(sms_c2, "\n-- Allowed upgraded units. These are just enabled if the corresponding update is researched, anyway\n"\
					"DefineAllow(\"unit-knight1\", \"AAAAAAAAAAAAAAAA\")\n"\
					"DefineAllow(\"unit-knight2\", \"AAAAAAAAAAAAAAAA\")\n"\
					"DefineAllow(\"unit-raider1\", \"AAAAAAAAAAAAAAAA\")\n"\
					"DefineAllow(\"unit-raider2\", \"AAAAAAAAAAAAAAAA\")\n");
	for (int race = 0; race < 2; race++) {
		for (int f = 0; f <= MaxAllowedFeature; f++) {
			if (IsAllowedFeature(allowid, f) && !SkipFeature(f)) {
				fprintf(sms_c2, "DefineAllow(\"%s\", \"AAAAAAAAAAAAAAAA\")\n", AllowedFeatures[f].thing[race]);
			}
		}
	}
	fprintf(sms_c2, "\n");
}

static void SmsSaveUpgrades(FILE* sms_c2, unsigned char* txtp)
{
	int allowid = AccessLE32(txtp);
	char *allowed1, *allowed2;
	allowed1 = (char*)calloc(sizeof(char), 17);
	allowed2 = (char*)calloc(sizeof(char), 17);
	short offset;
	fprintf(sms_c2, "\n-- Researched upgrades and spells\n");
	// 0x0004 - 0x0008: 5xByte: Upgrade: Ranged Weapons, arrows / spears.
	// 0x0009 - 0x000D: 5xByte: Upgrade: Melee Weapons, swords / axes.
	// 0x000E - 0x0012: 5xByte: Upgrade: Rider speed, horses / wolves.
	// 0x0013 - 0x0017: 5xByte: Spell: summon scorpions / summon spiders.
	// 0x0018 - 0x001C: 5xByte: Spell: rain of fire / cloud of poison.
	// 0x001D - 0x0021: 5xByte: Spell: summon water elemental / summon daemon.
	// 0x0022 - 0x0026: 5xByte: Spell: healing / raise dead.
	// 0x0027 - 0x002B: 5xByte: Spell: far seeing / dark vision.
	// 0x002C - 0x0030: 5xByte: Spell: invisibility / unholy armor.
	// 0x0031 - 0x0035: 5xByte: Upgrade: Shields.
	assert(AccessLE32(txtp + 0x36) == 0xFFFFFFFF);
	const char* upgradeNames[20] = {
		"upgrade-spear", "upgrade-arrow",
		"upgrade-axe", "upgrade-sword",
		"upgrade-wolves", "upgrade-horse",
		"upgrade-spider", "upgrade-scorpion",
		"upgrade-poison-cloud", "upgrade-rain-of-fire",
		"upgrade-daemon", "upgrade-water-elemental",
		"upgrade-raise-dead", "upgrade-healing",
		"upgrade-dark-vision", "upgrade-far-seeing",
		"upgrade-unholy-armor", "upgrade-invisibility",
		"upgrade-orc-shield", "upgrade-human-shield"
	};
	// basic upgrades
	for (int upgrade = 0x4; upgrade <= 0x12; upgrade += 5) {
		memset(allowed1, 'A', 16);
		memset(allowed2, 'A', 16);
		for (int player = 0; player < 5; player++) {
			offset = AccessByte(txtp + player + upgrade);
			allowed1[player == 4 ? 15 : player] = offset >= 1 ? 'R' : 'A';
			allowed2[player == 4 ? 15 : player] = offset >= 2 ? 'R' : 'A';
		}
		for (int race = 0; race < 2; race++) {	
			fprintf(sms_c2, "DefineAllow(\"%s1\", \"%s\")\n", upgradeNames[((upgrade - 0x4) / 5) * 2 + race], allowed1);
			fprintf(sms_c2, "DefineAllow(\"%s2\", \"%s\")\n", upgradeNames[((upgrade - 0x4) / 5) * 2 + race], allowed2);
		}
	}
	// shields
	for (int race = 0; race < 2; race++) {
		int upgrade = 0x31;
		memset(allowed1, 'A', 16);
		memset(allowed2, 'A', 16);
		for (int player = 0; player < 5; player++) {
			offset = AccessByte(txtp + player + upgrade);
			allowed1[player == 4 ? 15 : player] = offset >= 1 ? 'R' : 'A';
			allowed2[player == 4 ? 15 : player] = offset >= 2 ? 'R' : 'A';
		}
		fprintf(sms_c2, "DefineAllow(\"%s1\", \"%s\")\n", upgradeNames[((upgrade - 0x4) / 5) * 2 + race], allowed1);
		fprintf(sms_c2, "DefineAllow(\"%s2\", \"%s\")\n", upgradeNames[((upgrade - 0x4) / 5) * 2 + race], allowed2);
	}
	// spells
	for (int upgrade = 0x13; upgrade <= 0x30; upgrade += 5) {
		char* allowed = allowed1;
		// spells may not be allowed. offset of spells in allowed features is 15
		// usefully, they are not in the same order in the allowid as they
		// are in the list of researched stuff
		int offsetInAllowedFeatures = (((upgrade - 0x13) / 5) + 3) % 6 + 15;
		if (!(IsAllowedFeature(allowid, offsetInAllowedFeatures)) && allowid != 0) {
			memset(allowed, 'F', 16);
		} else {
			memset(allowed, 'A', 16);
			for (int player = 0; player < 5; player++) {
				offset = AccessByte(txtp + player + upgrade);
				allowed[player == 4 ? 15 : player] = offset >= 1 ? 'R' : 'A';
			}
		}
		for (int race = 0; race < 2; race++) {
			fprintf(sms_c2, "DefineAllow(\"%s\", \"%s\")\n", upgradeNames[((upgrade - 0x4) / 5) * 2 + race], allowed);
		}
	}
	fprintf(sms_c2, "\n");
}

static void SmsSetCurrentRace(FILE* sms_c2, char* race, int state)
{
	fprintf(sms_c2, "currentRace = \"%s\" -- Fix for restoring the correct race on load\n", race);
	fprintf(sms_c2, "currentState = %d -- Fix for restoring the correct campaign pos on load\n", state);
}

/**
**  Save the players
**
**  @param f      File handle
**  @param mtxme  Entry number of map.
*/
static void SmsSavePlayers(char* race, char* mapnum, gzFile sms, gzFile smp)
{
	int i;
	const char* computerrace = strcmp(race, "orc") ? "orc" : "human";
	
	gzprintf(smp, "-- Stratagus Map Presentation\n");
	gzprintf(smp, "-- Generated from war1tool\n\n");

	gzprintf(smp, "DefinePlayerTypes(\"person\", ");
	gzprintf(sms, "Player(0,\n\
             \"type\", \"person\",\n\
             \"race\", \"%s\",\n\
             \"color\", { 224, 224, 224 })\n", race);
	for (i = 1; i < 4; ++i) {
		gzprintf(smp, "\"computer\", ");
		gzprintf(sms,
			"Player(%d,\n\
            \"type\",\"computer\",\n\
            \"race\", \"%s\",\n\
            \"ai-name\", \"camp%s\",\n\
            \"color\", { 255, 0, 0 },\n\
            \"resources\", {\"gold\", 2000, \"wood\", 2000})\n", i, computerrace, mapnum);
	}
	gzprintf(smp, "\"neutral\", ");
	gzprintf(sms, "Player(4,\n\
             \"type\", \"rescue-passive\",\n\
             \"race\", \"neutral\",\n\
             \"ai-name\", \"rescue-passive\",\n\
             \"color\", { 200, 200, 200 },\n\
             \"allied\", \"+\")\n");
	for (i = 5; i < 14; ++i) {
		gzprintf(smp, "\"nobody\", ");
		gzprintf(sms, "Player(%d, \"type\",\"nobody\")\n", i);
	}
	gzprintf(smp, "\"neutral\")\n");
	gzprintf(sms, "Player(15,\n\
             \"race\", \"neutral\",\n\
             \"color\", { 100, 100, 100 })\n");
}

/**
**  Save the map
// Info taken from Alpha.WC1
// -- Here is a long and incomplete description of the data --
// FIXME: The map information chunk is not completely decoded. This is from
// my observations and war1gus code. There are offsets in the file, probably
// a lot of the mistery data is pointed to by those offsets.
// Offset ranges are inclusive (0x0000 - 0x0003 means 4 bytes).
// An intereseting observation is that WC1 has 5 players (4 + neutral).
//
// 0x0000 - 0x0003: DWord: Allowed units/upgrades, see AllowId
//
//     Here we have some per-player data, upgrades and spells (spells are
//     actually upgrades too, so...
//     The data is 5 bytes per player (but player 5 is neutral).
//     Upgrade values are from 0 to 2, spells are 0 and 1
//     Orc and Human spells/upgrades overlap, so the first upgrade
//     is either arrows or spears, etc.
//
// 0x0004 - 0x0008: 5xByte: Upgrade: Ranged Weapons, arrows / spears.
// 0x0009 - 0x000D: 5xByte: Upgrade: Melee Weapons, swords / axes.
// 0x000E - 0x0012: 5xByte: Upgrade: Rider speed, horses / wolves.
// 0x0013 - 0x0017: 5xByte: Spell: summon scorpions / summon spiders.
// 0x0018 - 0x001C: 5xByte: Spell: rain of fire / cloud of poison.
// 0x001D - 0x0021: 5xByte: Spell: summon water elemental / summon daemon.
// 0x0022 - 0x0026: 5xByte: Spell: healing / raise dead.
// 0x0027 - 0x002B: 5xByte: Spell: far seeing / dark vision.
// 0x002C - 0x0030: 5xByte: Spell: invisibility / unholy armor.
// 0x0031 - 0x0035: 5xByte: Upgrade: Shields.
//
// 0x0036 - 0x0039: 0xFFFFFFFF: This is a constant marker.
//
// 0x005C - 0x0069: 5xDWord: Lumber for each player.
// 0x0070 - 0x0083: 5xDWord: Gold for each player.
//
// 0x0088 - 0x008C: 5xByte: Mistery data, per player. human/orc/neutral? human/ai/neutral?
//
// 0x0094 - 0x0095: Word: Offset to a null-terminated string with a short briefing.
//
//     Here are some chunk numbers, please see Terrain Data.
//     Chunk number seem to be off (+2). Probably array base trouble.
// 0x00D0 - 0x00D1: Word: Chunk number with terrain tile data.
// 0x00D2 - 0x00D3: Word: Chunk number with terrain flags information.
// 0x00D4 - 0x00D6: Word: Chunk number of tileset palette.
// 0x00D6 - 0x00D7: Word: Chunk number of tileset info.
// 0x00D8 - 0x00D9: Word: Chunk number of tileset image data.
//
//     This header stuff continues until another FF FF FF FF, but it's
//     not predictable where. After that you see another int16 offset, into unit data.
//
//
// * Unit Data:
// Unit data consist of multiple records like this:
// byte X: X position on the map.
// byte Y: Y position on the map.
// byte Type: Type of the unit.
// byte player: Player that owns the unit (0 - 4). Gold mines have 4, neutral.
//
// If Type is 0x32 then there are also some values for gold. There are two bytes.
// The first seems to be constant 0xFE, the second is aprox gold value/250. I'm
// not sure how to read gold the right way. The current way sort of works, but it
// has small differences.
//
// Unit data is finished by a "fake" unit with x = y = 0xFF. This is obviousely out
// of the map.
//
// Then we have roads, as 5 bytes: x1, y1, x2, y2, type
// This means a road from x1 x1 to x2 y2. They do cross. Type seems to be the race.
// This is also ended by x1 = FF x2 = FF
//
// After that we have walls, written exactly the same way as roads.
//
//
// * Terrain Data
//
// Decoding the terrain chunk is easy, it's just a 64*64 array of Int16
// that reference tiles in the Tileset array.
//
// There's also a second terrain chunk, with flags.
// It's also a 64 * 64 array of Int16. It's not completely decoded,
// but the here are some flags:
//
// 0x0000: Normal ground
// 0x000C: Door(dungeon only)
// 0x0020: Dungeon entrance? no idea.
// 0x0040: Forest
// 0x0080: Water
// 0x0010: Bridge
//
// I use the above for map passability information.
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
	gzprintf(smp, "DefineMapSetup(\"%s_c.sms\")\n", lvlpath);

	// Warcraft I maps are always 64x64
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
	"unit-medivh", "unit-lothar",
	"unit-wounded", "unit-grizelda",
	"unit-garona", "unit-ogre",
	// 20
	"unit-20", "unit-spider",
	"unit-slime", "unit-fire-elemental",
	"unit-scorpion", "unit-brigand",
	"unit-26", "unit-skeleton",
	"unit-daemon", "unit-29",
	// 30
	"unit-30", "unit-31",
	"unit-human-farm", "unit-orc-farm",
	"unit-human-barracks", "unit-orc-barracks",
	"unit-human-church", "unit-orc-temple",
	"unit-human-tower", "unit-orc-tower",
	// 40
	"unit-human-town-hall", "unit-orc-town-hall",
	"unit-human-lumber-mill", "unit-orc-lumber-mill",
	"unit-human-stable", "unit-orc-kennel",
	"unit-human-blacksmith", "unit-orc-blacksmith",
	"unit-human-stormwind-keep", "unit-orc-blackrock-spire",
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

	// Units, placed by calling PlaceUnits at the very end
	gzprintf(f, "local PlaceUnits = function()\n");
	i = 0;
	while (p[0] != 0xFF || p[1] != 0xFF) {
		x = FetchByte(p);
		x /= 2;
		y = FetchByte(p);
		y /= 2;
		type = FetchByte(p);
		player = FetchByte(p);
		if (type == 0x32) {
			// gold mine
		        value = FetchLE16(p);
		} else {
			value = 0;
		}

		if (!strcmp("unit-gold-mine", UnitTypes[type])) {
			player = 15;
		}
		gzprintf(f, "  unit = CreateUnit(\"%s\", %d, {%d, %d})\n", UnitTypes[type], player, x, y);
		if (value) {
			gzprintf(f, "  SetResourcesHeld(unit, %d)\n", value);
		}
		++i;
	}
	gzprintf(f, "end\n");

	gzprintf(f, "CreateRoads({\n");
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
		for (x = startx; x <= endx; ++x) {
			for (y = starty; y <= endy; ++y) {
			        gzprintf(f, "{player = %d, x = %d, y = %d},\n", type, x, y);
			}
		}
	}
	gzprintf(f, "})\n");

	gzprintf(f, "CreateWalls({\n");
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
		for (x = startx; x <= endx; ++x) {
			for (y = starty; y <= endy; ++y) {
			        gzprintf(f, "{player = %d, x = %d, y = %d},\n", type, x, y);
			}
		}
	}
	gzprintf(f, "})\n");

	// Must place units after roads. Units can be placed on top of
	// roads, but not the other way around
	gzprintf(f, "PlaceUnits()\n");
}

/**
**  Convert a map to Stratagus map format.
*/
void ConvertSkirmishMap(const char* file, int mtxme)
{
    gzFile smp, sms;
    unsigned char buf[1024];
    unsigned char *mtxm, *p;
    unsigned short s;
    int i, j;
    unsigned char* tileset;
    unsigned char* extraPlayers;
    int numPlayers;

    if (strstr(file, "forest")) {
		tileset = "forest_campaign";
    } else if (strstr(file, "swamp")) {
        tileset = "swamp_campaign";
    } else {
		tileset = "dungeon_campaign";
    }
    
    for (numPlayers = 2; numPlayers <= 4; numPlayers++) {
	if (numPlayers == 2) {
	    extraPlayers = "";
	} else if (numPlayers == 3) {
	    extraPlayers = ",\"computer\"";
	} else {
	    extraPlayers = ",\"computer\",\"computer\"";
	}

	sprintf((char*)buf, "%s/%s/%s_%d_players.smp.gz", Dir, CM_PATH, file, numPlayers);
	CheckPath((char*)buf);
	smp = gzopen((char*)buf, "wb9");
	sprintf((char*)buf, "%s/%s/%s_%d_players.sms.gz", Dir, CM_PATH, file, numPlayers);
	CheckPath((char*)buf);
	sms = gzopen((char*)buf, "wb9");

	mtxm = ExtractEntry(ArchiveOffsets[mtxme], NULL);
	if (!mtxm) {
	    return;
	}
	p = mtxm;

	
	
	gzprintf(smp,
		 "-- Stratagus Map Presentation\n"\
		 "-- File generated automatically from pudconvert.\n"\
		 "DefinePlayerTypes(\"person\",\"computer\"%s)\n"\
		 "PresentMap(\"(unnamed)\", %d, 64, 64, 1)\n", extraPlayers, numPlayers);
	gzprintf(sms,
		 "LoadTileModels(\"scripts/tilesets/%s.lua\")\n"\
		 "SetStartView(0, 16, 16)\n"\
		 "SetPlayerData(0, \"Resources\", \"gold\", 10000)\n"\
		 "SetPlayerData(0, \"Resources\", \"wood\", 3000)\n"\
		 "SetPlayerData(0, \"RaceName\", \"human\")\n"\
		 "SetStartView(1, 48, 48)\n"\
		 "SetPlayerData(1, \"Resources\", \"gold\", 10000)\n"\
		 "SetPlayerData(1, \"Resources\", \"wood\", 3000)\n"\
		 "SetPlayerData(1, \"RaceName\", \"orc\")\n"\
		 "SetPlayerData(15, \"RaceName\", \"neutral\")\n\n", tileset);
	if (numPlayers > 2) {
	    gzprintf(sms,
		     "SetStartView(2, 16, 48)\n"\
		     "SetPlayerData(2, \"Resources\", \"gold\", 10000)\n"\
		     "SetPlayerData(2, \"Resources\", \"wood\", 3000)\n"\
		     "SetPlayerData(2, \"RaceName\", \"human\")\n");
	}
	if (numPlayers > 3) {
	    gzprintf(sms,
		     "SetStartView(3, 48, 16)\n"\
		     "SetPlayerData(3, \"Resources\", \"gold\", 10000)\n"\
		     "SetPlayerData(3, \"Resources\", \"wood\", 3000)\n"\
		     "SetPlayerData(3, \"RaceName\", \"orc\")\n");
	}
	for (i = 0; i < 64; ++i) {
	    gzprintf(sms, "  -- %d\n",i);
	    for (j = 0; j < 64; ++j) {
		s = FetchLE16(p);
		gzprintf(sms, "SetTile(%d, %d, %d, 0)\n", s, j, i);
	    }
	}

	gzprintf(sms,
		 "\n\nif (MapUnitsInit ~= nil) then MapUnitsInit() end\n"\
		 "unit = CreateUnit(\"unit-gold-mine\", 15, {16, 16})\n"\
		 "SetResourcesHeld(unit, 45000)\n"\
		 "unit = CreateUnit(\"unit-gold-mine\", 15, {16, 48})\n"\
		 "SetResourcesHeld(unit, 45000)\n"\
		 "unit = CreateUnit(\"unit-gold-mine\", 15, {48, 16})\n"\
		 "SetResourcesHeld(unit, 45000)\n"\
		 "unit = CreateUnit(\"unit-gold-mine\", 15, {48, 48})\n"\
		 "SetResourcesHeld(unit, 45000)\n"\
		 "unit = CreateUnit(\"unit-peasant\", 0, {16, 16})\n"\
		 "unit = CreateUnit(\"unit-peon\", 1, {48, 48})\n");
	if (numPlayers > 2) {
	    gzprintf(sms, "unit = CreateUnit(\"unit-peasant\", 1, {16, 48})\n");
	}
	if (numPlayers > 3) {
	    gzprintf(sms, "unit = CreateUnit(\"unit-peon\", 1, {48, 16})\n");
	}
	gzprintf(smp, "\n");
	gzclose(sms);
	gzclose(smp);
    }
    free(mtxm);
}


/**
**  Convert a map to Stratagus map format.
*/
int ConvertMap(const char* file, int txte, int mtxme)
{
	unsigned char* txtp;
	unsigned char buf[1024];
	char *race, *racemem;
	char mapnum[3] = {'\0'};
	gzFile smp, sms;
	FILE* sms_c2;

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

	sprintf((char*)buf, "%s/%s/%s_c2.sms", Dir, CM_PATH, file);
	sms_c2 = fopen((char*)buf, "wb");
	if (!sms_c2) {
		perror("");
		fprintf(stderr, "Can't open campaign file for %s/%s/%s\n",
			Dir, CM_PATH, file);
		exit(-1);
	}

	// XXX: Get the race
	race = racemem = (char*)calloc(sizeof(char), 1024);
	strcpy(race, file);
	assert(strlen(race) > 3 && race[strlen(race) - 3] == '/');
	race[strlen(race) - 3] = '\0';
	while (strstr(race, "/")) {
		race++;
	}

	// XXX: Get the map number
	mapnum[0] = file[strlen(file) - 2];
	mapnum[1] = file[strlen(file) - 1];

	SmsSaveObjectives(sms_c2, txtp);
	SmsSaveAllowed(sms_c2, txtp);
	SmsSaveUpgrades(sms_c2, txtp);
	SmsSaveResources(sms_c2, txtp);
	SmsSetCurrentRace(sms_c2, race, atoi(mapnum));
	SmsSavePlayers(race, mapnum, sms, smp);
	SmsSaveMap(sms, smp, mtxme, file);
	SmsSaveUnits(sms, txtp);

	fclose(sms_c2);

	free(txtp);
	free(racemem);
	gzclose(sms);
	gzclose(smp);
	return 0;
}

void CopyDirectories(char** directories) {
	int i, ret;
	char* dir;
	char cmd[2048];
	
	CheckPath(Dir);

	for (i = 0; (dir = directories[i]); i++) {
#if defined(_MSC_VER) || defined(WIN32)
		sprintf(cmd, "robocopy \"%s\" \"%s\\%s\" /MIR", dir, Dir, dir);
#else
		sprintf(cmd, "cp -Ru \"%s\" \"%s/\"", dir, Dir);
#endif
		ret = system(cmd);
		if (ret != 0) {
			fprintf(stderr, "Problem copying %s to %s\n", dir, Dir);
			fflush(stdout);
		}
	}
}

void CreateConfig(char* outputdir, int video, int miditoogg) {
	CheckPath(Dir);
	char cfile[2048];
	FILE *config;
	sprintf(cfile, "%s/%s", outputdir, "scripts/wc1-config.lua");
	config = fopen(cfile, "w");
	fprintf(config, "war1gus.music_extension = \"%s\"\n", miditoogg ? ".ogg" : ".midi");
	fclose(config);
}

//----------------------------------------------------------------------------
//  Main loop
//----------------------------------------------------------------------------

/**
**  Display the usage.
*/
void Usage(const char* name)
{
	printf("wartool V%s for Stratagus, (c) %s.\n\
\tWritten by %s\n\
\thttps://launchpad.net/war1gus\n\n\
Usage: %s [-m] [-v] [-V] [-h] archive-directory [destination-directory]\n\
\t-m\tExtract and convert midi sound files (may take some time)\n\
\t-v\tExtract and convert videos\n\
\t-V\tShow version\n\
\t-h\tShow usage (this text)\n\
archive-directory\tDirectory which includes the archives (data.war...)\n\
destination-directory\tDirectory where the extracted files are placed (default: %s).\n"
	       ,VERSION, COPYRIGHT, AUTHORS, name,
	       DEFAULT_DATA_DIR);
}

/**
**  Main
*/
#undef main
int main(int argc, char** argv)
{
	unsigned u;
	char buf[2048];
	char* archive_dir;
	int a;
	int upper;
	struct stat st;
	int midi, video;
	char* dirs[4] = {0x0};
	video = midi = 0;

	a = 1;
	upper = 0;
	while (argc >= 2) {
		if (!strcmp(argv[a], "-h")) {
			Usage(argv[0]);
			++a;
			--argc;
			exit(0);
		}
		if (!strcmp(argv[a], "-m")) {
			midi = 1;
			++a;
			--argc;
			continue;
		}
		if (!strcmp(argv[a], "-v")) {
			video = 1;
			++a;
			--argc;
			continue;
		}
		if (!strcmp(argv[a], "-V")) {
			printf(VERSION "\n");
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
	archive_dir = (char*)calloc(sizeof(char), strlen(ArchiveDir) + strlen("fdata") + 1);
	if (!archive_dir) {
		fprintf(stderr, "Memory Error!\n");
		exit(1);
	}
	if (argc == 3) {
		Dir = argv[a + 1];
	} else {
		Dir = DEFAULT_DATA_DIR;
	}

	sprintf(buf, "%s/data.war", ArchiveDir);
	if (stat(buf, &st)) {
		sprintf(buf, "%s/DATA.WAR", ArchiveDir);
		upper = 1;
	}
	if (stat(buf, &st)) {
		sprintf(buf, "%s/fdata/data.war", ArchiveDir);
		upper = 0;
	}
	if (stat(buf, &st)) {
		sprintf(buf, "%s/FDATA/DATA.WAR", ArchiveDir);
		upper = 1;
	}
	if (stat(buf, &st)) {
		sprintf(buf, "%s/DATA/DATA.WAR", ArchiveDir);
		upper = 1;
	}
	if (stat(buf, &st)) {
		sprintf(buf, "%s/data/data.war", ArchiveDir);
		upper = 0;
	}
	if (stat(buf, &st)) {
		fprintf(stderr, "error: %s/data.war does not exist\n", ArchiveDir);
		fprintf(stderr, "error: %s/fdata/data.war does not exist\n", ArchiveDir);
		fprintf(stderr, "error: %s/data/data.war does not exist\n", ArchiveDir);
		fprintf(stderr, "error: %s/DATA.WAR does not exist\n", ArchiveDir);
		fprintf(stderr, "error: %s/FDATA/DATA.WAR does not exist\n", ArchiveDir);
		fprintf(stderr, "error: %s/DATA/DATA.WAR does not exist\n", ArchiveDir);
		fflush(stderr);
		exit(1);
	}
	buf[strlen(buf) - strlen("data.war")] = '\0';
	sprintf(archive_dir, "%s", buf);
	ArchiveDir = archive_dir;

	printf("Extract from \"%s\" to \"%s\"\n", ArchiveDir, Dir);
	printf("Please be patient, the data may take a couple of minutes to extract...\n");
	fflush(stdout);

	dirs[0] = "scripts";
	dirs[1] = "contrib";
	dirs[2] = "campaigns";
	CopyDirectories(dirs);
	
	CreateConfig(Dir, video, midi);

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
				if (video) {
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
				}
				break;
			case T:
				ConvertTileset(Todo[u].File, Todo[u].Arg1);
				break;
			case TU:
				ConvertTilesetUnit(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2);
				break;
			case RP:
				ConvertRuin(Todo[u].File, Todo[u].Arg1, Todo[u].Arg2, Todo[u].Arg3);
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
				if (midi) {
					ConvertXmi(Todo[u].File, Todo[u].Arg1, 1);
				} else {
					ConvertXmi(Todo[u].File, Todo[u].Arg1, 0);
				}
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
			case CS:
				ConvertSkirmishMap(Todo[u].File, Todo[u].Arg1);
				break;
			default:
				break;
		}
	}

	if (video) {
	    // TODO: embed this somewhere nicer
	    MuxIntroVideos();
	}

	printf("War1gus data setup is now complete\n");
	printf("Note: you do not need to run this again\n");
	fflush(stdout);

	return 0;
}

//@}
