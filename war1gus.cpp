/*
       _________ __                 __
      /   _____//  |_____________ _/  |______     ____  __ __  ______
      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ |
     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
             \/                  \/          \//_____/            \/
  ______________________                           ______________________
                        T H E   W A R   B E G I N S
         Stratagus - A free fantasy real time strategy game engine

    war1gus.cpp - War1gus Game Launcher
    Copyright (C) 2010-2011  Pali Rohár <pali.rohar@gmail.com>
    Copyright (C) 2015 Tim Felgentreff <timfelgentreff@gmail.com>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#define GAME_NAME "War1gus"
#define GAME_CD "Warcraft I DOS DATA.WAR file"
#define GAME_CD_FILE_PATTERNS "DATA.WAR", "data.war"
#define GAME "war1gus"
#define EXTRACTOR_TOOL "war1tool"
#define EXTRACTOR_ARGS "-v -m"
#define CHECK_EXTRACTED_VERSION 1
#define __war1gus_contrib__ "campaigns", "campaigns", \
			    "contrib", "contrib", \
			    "maps", "maps", \
			    "shaders", "shaders", \
			    "scripts", "scripts", \
                           ":optional:", \
                           "music/TimGM6mb.sf2", "music/TimGM6mb.sf2"

#ifdef WIN32
#define CONTRIB_DIRECTORIES { __war1gus_contrib__, NULL }
#else
// for convenience during development, we also try to copy the system
// soundfont to the data directory on linux
#define CONTRIB_DIRECTORIES { __war1gus_contrib__, "/usr/share/sounds/sf2/TimGM6mb.sf2", "music/TimGM6mb.sf2", NULL }
#endif

const char* SRC_PATH() { return __FILE__; }

#ifdef WIN32
#define TITLE_PNG "%s\\graphics\\ui\\title_screen.png"
#else
#define TITLE_PNG "%s/graphics/ui/title_screen.png"
#endif

#include <stratagus-game-launcher.h>
