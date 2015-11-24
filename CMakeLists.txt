#    CMakeLists.txt
#    Copyright (C) 2013  Tim Felgentreff <timfelgentreff@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

project(war1gus)
cmake_minimum_required(VERSION 2.6)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})

file(GLOB war1tool_SRCS
  "scripts/*.lua"
  "scripts/**/*.lua"
  "campaigns/**/*.sms"
  "campaigns/**/*.lua"
  "maps/*.sms"
  "war1tool.c"
  "xmi2mid.cpp"
  "scale2x.c"
  "README"
  )

set(war1tool_HDRS xmi2mid.h scale2x.h)

find_package(PNG REQUIRED)
find_package(ZLIB REQUIRED)

include_directories(${PNG_INCLUDE_DIR} ${ZLIB_INCLUDE_DIRS})
set(war1tool_LIBS ${PNG_LIBRARIES} ${ZLIB_LIBRARIES})

add_executable(war1tool ${war1tool_SRCS} ${war1tool_HDRS})
target_link_libraries(war1tool ${war1tool_LIBS})
install(TARGETS war1tool DESTINATION "bin")

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_COMPILER_IS_GNUC)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99")
endif()

if (WIN32 AND MSVC)
  if(MSVC_VERSION GREATER 1800)       # if > VC13
    message("The project must be compiled with VS2013 or older.")
    set(CMAKE_GENERATOR_TOOLSET "v120" CACHE STRING "Platform Toolset" FORCE)
  endif()

  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /SAFESEH:NO")
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /SAFESEH:NO")
  set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} /SAFESEH:NO")
  add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
  set_target_properties(war1tool PROPERTIES LINK_FLAGS "${LINK_FLAGS} /NODEFAULTLIB:MSVCRT")
endif()

# Launcher

find_package(Stratagus)
if(STRATAGUS_FOUND)
  set(BINDIR "bin" CACHE PATH "Where to install user binaries")
  set(GAMEDIR "games" CACHE PATH "Where to install games binaries")
  set(SHAREDIR "share/games/stratagus/wargus" CACHE PATH "Where to install data files")
  set(DATAROOTDIR "${CMAKE_INSTALL_PREFIX}/share" CACHE PATH "Sets the root of data directories to a non-default location")
  set(ICONDIR "${DATAROOTDIR}/pixmaps" CACHE PATH "Sets the icon directory for desktop entry to a non-default location.")
  set(DESKTOPDIR "${DATAROOTDIR}/applications" CACHE PATH "Sets the desktop file directory for desktop entry to a non-default location.")
  if(NOT IS_ABSOLUTE "${GAMEDIR}")
    set(GAMEDIRABS "${CMAKE_INSTALL_PREFIX}/${GAMEDIR}")
  else()
    set(GAMEDIRABS "${GAMEDIR}")
  endif()
  if(NOT IS_ABSOLUTE "${SHAREDIR}")
    set(DATA_PATH "${CMAKE_INSTALL_PREFIX}/${SHAREDIR}")
  else()
    set(DATA_PATH "${SHAREDIR}")
  endif()

  include_directories(${X11_INCLUDE_DIR} ${STRATAGUS_INCLUDE_DIR})
  if (NOT WIN32)
    find_package(GTK2 REQUIRED gtk)
    if (NOT GTK2_FOUND)
      add_definitions("-DNOGTK")
    endif()
    find_package(X11 REQUIRED)
    set(war1gus_LIBS ${war1gus_LIBS} ${X11_X11_LIB})
    add_definitions(-DDATA_PATH="${DATA_PATH}")
    add_definitions(-DSCRIPTS_PATH="${DATA_PATH}")
    add_definitions(-DSTRATAGUS_BIN="${STRATAGUS}")
  elseif (WIN32)
    set(war1gus_SRCS ${war1gus_SRCS} war1gus.rc)
    find_package(MakeNSIS)
    enable_language(RC)
    include(CMakeDetermineRCCompiler)
    option(ENABLE_NSIS "Create Stratagus Window NSIS Installer" OFF)
    if(ENABLE_NSIS AND MAKENSIS_FOUND)
      file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/COPYING DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
      file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/war1gus.ico DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
      add_custom_command(OUTPUT War1gus${MAKENSIS_SUFFIX}
        COMMAND ${MAKENSIS}
        ARGS ${MAKENSIS_FLAGS} -DCMAKE_CURRENT_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}" -DCMAKE_CURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/war1gus.nsi
        DEPENDS war1gus.nsi war1gus war1tool COPYING war1gus.ico
        COMMENT "Generating War1gus Windows NSIS Installer" VERBATIM
        )
      add_custom_target(nsis ALL DEPENDS War1gus${MAKENSIS_SUFFIX})
    endif()
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
  endif()
  set(war1gus_SRCS war1gus.cpp)
  add_executable(war1gus WIN32 ${war1gus_SRCS} ${war1gus_HDRS})
  target_link_libraries(war1gus ${war1gus_LIBS})
  set(GAMEDIR "games" CACHE PATH "Where to install games binaries")
  install(TARGETS war1gus DESTINATION ${GAMEDIR})
endif()
