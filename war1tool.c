//   ___________		     _________		      _____  __
//   \_	  _____/______   ____   ____ \_   ___ \____________ _/ ____\/  |_
//    |    __) \_  __ \_/ __ \_/ __ \/    \  \/\_  __ \__  \\   __\\   __|
//    |     \   |  | \/\  ___/\  ___/\     \____|  | \// __ \|  |   |  |
//    \___  /   |__|    \___  >\___  >\______  /|__|  (____  /__|   |__|
//	  \/		    \/	   \/	     \/		   \/
//  ______________________                           ______________________
//			  T H E   W A R   B E G I N S
//   Utility for FreeCraft - A free fantasy real time strategy game engine
//
/**@name war1tool.c	-	Extract files from war archives. */
//
//	(c) Copyright 2003 by Jimmy Salmon
//
//	FreeCraft is free software; you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published
//	by the Free Software Foundation; only version 2 of the License.
//
//	FreeCraft is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
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

#include "freecraft.h"
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
**	Palette N27, for credits cursor
*/
unsigned char* Pal27;

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
    U,			// Uncompressed Graphics	(name,pal,gfu)
    I,			// Image			(name,pal,img)
    W,			// Wav				(name,wav)
    X,			// Text				(name,text,ofs)
    X2,			// Text2			(name,text)
    C,			// Cursor			(name,cursor)
    FLC,		// FLC
    VOC,		// VOC
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

// Tilesets
{T,0,"forest/terrain",					 190 __},
{T,0,"swamp/terrain",					 193 __},
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
{C,0,"cursors/magnifying glass",			 262, 267 _2},
{C,0,"cursors/small green crosshair",			 262, 268 _2},
{C,0,"cursors/watch",					 262, 269 _2},
{C,0,"cursors/up arrow",				 262, 270 _2},
{C,0,"cursors/upper-right arrow",			 262, 271 _2},
{C,0,"cursors/right arrow",				 262, 272 _2},
{C,0,"cursors/lower-right arrow",			 262, 273 _2},
{C,0,"cursors/down arrow",				 262, 274 _2},
{C,0,"cursors/lower-left arrow",			 262, 275 _2},
{C,0,"cursors/left arrow",				 262, 276 _2},
{C,0,"cursors/upper-left arrow",			 262, 277 _2},

// Unit graphics
{U,0,"human/units/footman",				 217, 279 _2},
{U,0,"orc/units/grunt",					 217, 280 _2},
{U,0,"human/units/peasant",				 217, 281 _2},
{U,0,"orc/units/peon",					 217, 282 _2},
{U,0,"human/units/catapult",				 217, 283 _2},
{U,0,"orc/units/catapult",				 217, 284 _2},
{U,0,"human/units/knight",				 217, 285 _2},
{U,0,"orc/units/raider",				 217, 286 _2},
{U,0,"human/units/archer",				 217, 287 _2},
{U,0,"orc/units/spearman",				 217, 288 _2},
{U,0,"human/units/conjurer",				 217, 289 _2},
{U,0,"orc/units/warlock",				 217, 290 _2},
{U,0,"human/units/cleric",				 217, 291 _2},
{U,0,"orc/units/necrolyte",				 217, 292 _2},
{U,0,"human/units/midevh",				 217, 293 _2},
{U,0,"orc/units/lothar",				 217, 294 _2},
{U,0,"units/wounded",					 217, 295 _2},
{U,0,"units/grizelda,garona",				 217, 296 _2},
{U,0,"units/ogre",					 217, 297 _2},
{U,0,"units/spider",					 217, 298 _2},
{U,0,"units/slime",					 217, 299 _2},
{U,0,"units/fire elemental",				 217, 300 _2},
{U,0,"units/scorpion",					 217, 301 _2},
{U,0,"units/brigand",					 217, 302 _2},
{U,0,"units/the dead",					 217, 303 _2},
{U,0,"units/skeleton",					 217, 304 _2},
{U,0,"units/daemon",					 217, 305 _2},
{U,0,"units/water elemental",				 217, 306 _2},
{U,0,"neutral/units/dead bodies",			 217, 326 _2},
{U,0,"human/units/peasant with wood",			 217, 327 _2},
{U,0,"orc/units/peon with wood",			 217, 328 _2},
{U,0,"human/units/peasant with gold",			 217, 329 _2},
{U,0,"orc/units/peon with gold",			 217, 330 _2},

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
{U,0,"human/icon selection boxes",			 217, 359 _2},
{U,0,"orc/icon selection boxes",			 217, 360 _2},
{U,0,"portrait icons",					 217, 361 _2},
{U,0,"tilesets/forest/portrait icons",			 191, 361 _2},
{U,0,"tilesets/swamp/portrait icons",			 194, 361 _2},

// Images
{I,0,"ui/logo",						 217, 216 _2},
{I,0,"ui/human/top resource bar",			 217, 218 _2},
{I,0,"ui/orc/top resource bar",				 217, 219 _2},
{I,0,"ui/human/right panel",				 217, 220 _2},
{I,0,"ui/orc/right panel",				 217, 221 _2},
{I,0,"ui/human/button panel",				 217, 222 _2},
{I,0,"ui/orc/button panel",				 217, 223 _2},
{I,0,"ui/human/info box",				 217, 224 _2},
{I,0,"ui/orc/info box",					 217, 225 _2},
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
{I,0,"ui/gold icon 1",					 217, 406 _2},
{I,0,"ui/lumber icon 1",				 217, 407 _2},
{I,0,"ui/gold icon 2",					 217, 408 _2},
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
{W,0,"the orcs are approaching",			 497	__},
{W,0,"there are enemies nearby",			 498	__},
{W,0,"human/work completed",				 502	__},
{W,0,"they're destroying our city",			 504	__},
{W,0,"we are under attack",				 505	__},
{W,0,"the town is under attack",			 506	__},
{W,0,"your command",					 508	__},
{W,0,"yes",						 513	__},
{W,0,"yes m'lord",					 514	__},
{W,0,"yes2",						 520	__},
{W,0,"your will sire",					 521	__},
{W,0,"my lord",						 522	__},
{W,0,"my liege",					 523	__},
{W,0,"your bidding",					 524	__},
{W,0,"stop poking me",					 527	__},
{W,0,"what2",						 528	__},
{W,0,"what do you want",				 529	__},
{W,0,"why do you keep touching me",			 530	__},
{W,0,"dead spider,scorpion",				 531	__},
{W,0,"normal spell",					 532	__},
{W,0,"build road",					 533	__},
{W,0,"temple",						 534	__},
{W,0,"church",						 535	__},
{W,0,"kennel",						 536	__},
{W,0,"stable",						 537	__},
{W,0,"blacksmith",					 538	__},
{W,0,"fire crackling",					 539	__},
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

{VOC,0,"building",					 474	__},
{VOC,0,"explosion",					 475	__},
{VOC,0,"catapult rock fired",				 476	__},
{VOC,0,"tree chopping 1",				 477	__},
{VOC,0,"tree chopping 2",				 478	__},
{VOC,0,"tree chopping 3",				 479	__},
{VOC,0,"tree chopping 4",				 480	__},
{VOC,0,"building collapse 1",				 481	__},
{VOC,0,"building collapse 2",				 482	__},
{VOC,0,"building collapse 3",				 483	__},
{VOC,0,"chime",						 484	__},
{VOC,0,"cancel",					 486	__},
{VOC,0,"sword attack 1",				 487	__},
{VOC,0,"sword attack 2",				 488	__},
{VOC,0,"sword attack 3",				 489	__},
{VOC,0,"fist attack",					 490	__},
{VOC,0,"catapult fire explosion",			 491	__},
{VOC,0,"fireball",					 492	__},
{VOC,0,"arrow,spear",					 493	__},
{VOC,0,"arrow,spear hit",				 494	__},
{VOC,0,"the humans draw near",				 495	__},
{VOC,0,"the pale dogs approach",			 496	__},
{VOC,0,"owwwwaaaggg",					 499	__},
{VOC,0,"unit dying",					 500	__},
{VOC,0,"orc/work complete",				 501	__},
{VOC,0,"we're being attacked",				 503	__},
{VOC,0,"your command master",				 507	__},
{VOC,0,"quite right",					 509	__},
{VOC,0,"loook",						 510	__},
{VOC,0,"loke tar",					 511	__},
{VOC,0,"dabu",						 512	__},
{VOC,0,"humm",						 515	__},
{VOC,0,"hummmmmmm",					 516	__},
{VOC,0,"ooowwwaa",					 517	__},
{VOC,0,"huh huh huh",					 518	__},
{VOC,0,"ooouuwww",					 519	__},
{VOC,0,"what",						 525	__},
{VOC,0,"whaaaaaaat",					 526	__},

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
	printf("FLC file size incorrect: %d != %ld\n",i,stat_buf.st_size);
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

//----------------------------------------------------------------------------
//	Tileset
//----------------------------------------------------------------------------

/**
**	Convert a tileset to my format.
*/
int ConvertTileset(char* file,int index)
{
    unsigned char* palp;
    unsigned char* image;
    int len;
    char buf[1024];

    palp=ExtractEntry(ArchiveOffsets[index+1],&len);
    if( !palp ) {
	return 0;
    }
    if( len<768 ) {
	palp=realloc(palp,768);
    }
    image=ExtractEntry(ArchiveOffsets[index],&len);
    if( !image ) {
	free(palp);
	return 0;
    }

    ConvertPalette(palp);

    sprintf(buf,"%s/%s/%s.png",Dir,TILESET_PATH,file);
    CheckPath(buf);
    SavePNG(buf,image,8,len/8,palp);

    free(image);
    free(palp);

    return 0;
}

//----------------------------------------------------------------------------
//	Graphics
//----------------------------------------------------------------------------

/**
**	Decode a entry(frame) into image.
*/
void DecodeGfuEntry(int index,unsigned char* start
	,unsigned char* image,int ix,int iy,int iadd)
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

    sp=start+offset-6;
    dp=image+xoff-ix+(yoff-iy)*iadd;
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
    int minx;
    int miny;
    int best_width;
    int best_height;
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

    // Find best image size
    minx=999;
    miny=999;
    best_width=0;
    best_height=0;
    for( i=0; i<count; ++i ) {
	unsigned char* p;
	int xoff;
	int yoff;
	int width;
	int height;

	p=bp+i*8;
	xoff=FetchByte(p);
	yoff=FetchByte(p);
	width=FetchByte(p);
	height=FetchByte(p);
	if( FetchLE32(p)&0x80000000 ) {	// high bit of width
	    width+=256;
	}
	if( xoff<minx ) minx=xoff;
	if( yoff<miny ) miny=yoff;
	if( xoff+width>best_width ) best_width=xoff+width;
	if( yoff+height>best_height ) best_height=yoff+height;
    }
    // FIXME: the image isn't centered!!

#if 0
    // Taken out, must be rewritten.
    if( max_width-best_width<minx ) {
	minx=max_width-best_width;
	best_width-=minx;
    } else {
	best_width=max_width-minx;
    }
    if( max_height-best_height<miny ) {
	miny=max_height-best_height;
	best_height-=miny;
    } else {
	best_height=max_width-miny;
    }

    //best_width-=minx;
    //best_height-=miny;
#endif

    DebugLevel3("Best image size %3d, %3d\n" _C_ best_width _C_ best_height);

    minx=0;
    miny=0;

    if( count%5==0 ) {
	best_width=max_width;
	best_height=max_height;
	IPR=5;
	length=((count+IPR-1)/IPR)*IPR;
    } else {
	max_width=best_width;
	max_height=best_height;
	IPR=1;
	length=count;
    }

    image=malloc(best_width*best_height*length);

    //	Image:	0, 1, 2, 3, 4,
    //		5, 6, 7, 8, 9, ...
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    // Set all to transparent.
    memset(image,255,best_width*best_height*length);

    for( i=0; i<count; ++i ) {
	DecodeGfuEntry(i,bp
	    ,image+best_width*(i%IPR)+best_height*best_width*IPR*(i/IPR)
	    ,minx,miny,best_width*IPR);
    }

    *wp=best_width*IPR;
    *hp=best_height*(length/IPR);

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

    width=FetchLE16(bp);
    height=FetchLE16(bp);

    DebugLevel3("Image: width %3d height %3d\n" _C_ width _C_ height);

    image=malloc(width*height);
    if( !image ) {
	printf("Can't allocate image\n");
	exit(-1);
    }
    memcpy(image,bp,width*height);

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

    palp=ExtractEntry(ArchiveOffsets[pale],NULL);
    if( !palp ) {
	return 0;
    }
    if (pale == 27 && imge == 28) {
	Pal27 = palp;
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
    if (pale != 27 && imge != 28) {
	free(palp);
    }

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

    if (pale == 27 && cure == 314 && Pal27 ) { // Credits arrow (Blue arrow NW)
	palp = Pal27;
    } else {
	palp=ExtractEntry(ArchiveOffsets[pale],NULL);
	if( !palp ) {
	    return 0;
	}
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


//----------------------------------------------------------------------------
//	Main loop
//----------------------------------------------------------------------------

/**
**	Display the usage.
*/
void Usage(const char* name)
{
    printf("war1tool for FreeCraft V" VERSION ", (c) 1999-2003 by the FreeCraft Project\n\
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
	    default:
		break;
	}
    }

    return 0;
}

//@}
