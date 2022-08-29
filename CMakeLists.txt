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
cmake_minimum_required(VERSION 3.10)
cmake_policy(VERSION 3.10..3.20.2)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

if(EXISTS ${WIN32_CMAKE_PREFIX_PATH})
	list(APPEND CMAKE_PREFIX_PATH "${WIN32_CMAKE_PREFIX_PATH}")
	message("Using prefix path ${CMAKE_PREFIX_PATH}")
endif()

if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/third-party/CMakeLists.txt")
  add_subdirectory(third-party)
else()
  message(WARNING "Third-party directory not populated, cannot vendor any dependencies.")
endif()

option(ENABLE_VENDORED_LIBS OFF)

file(GLOB war1tool_SRCS
  "scripts/*.lua"
  "scripts/**/*.lua"
  "campaigns/**/*.sms"
  "campaigns/**/*.lua"
  "maps/*.sms"
  "war1tool.cpp"
  "xmi2mid.cpp"
  "scale2x.cpp"
  "README"
  )

set(war1tool_HDRS xmi2mid.h scale2x.h)

if(ENABLE_VENDORED_LIBS)
  vendored_png()
  vendored_zlib()
else()
  find_package(PNG REQUIRED)
  find_package(ZLIB REQUIRED)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_COMPILER_IS_GNUC)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0 -g -ggdb")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -g -ggdb")
endif()

if(WIN32 AND MSVC)
	add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
else()
	include(CheckCXXSourceCompiles)
	set(FS_SRC "
	#include <experimental/filesystem> 
	namespace fs = std::experimental::filesystem;
	int main(int argc, char **argv) {
		fs::path p = fs::path(\".\");
		if (fs::absolute(p).is_absolute()) {
			return 0;
		} else {
			return 1;
		}
	}
	")
	check_cxx_source_compiles("${FS_SRC}" HAS_17_FS)
	if(NOT HAS_17_FS)
		set(CMAKE_REQUIRED_LIBRARIES stdc++fs)
		check_cxx_source_compiles("${FS_SRC}" HAS_EXP_17_FS_WITH_STDC)
		if(HAS_EXP_17_FS_WITH_STDC)
			set(war1gus_LIBS ${war1gus_LIBS} stdc++fs)
			set(war1tool_LIBS ${war1tool_LIBS} stdc++fs)
		else()
			set(CMAKE_REQUIRED_LIBRARIES c++fs)
			check_cxx_source_compiles("${FS_SRC}" HAS_EXP_17_FS_WITH_CLIB)
			if(HAS_EXP_17_FS_WITH_CLIB)
				set(war1gus_LIBS ${war1gus_LIBS} c++fs)
				set(war1tool_LIBS ${war1tool_LIBS} c++fs)
			else()
				message(FATAL_ERROR "I don't know how to compile with C++17 filesystem support on your system")
			endif()
		endif()
	endif()
endif()

if(WIN32 AND MSVC AND NOT CMAKE_PREFIX_PATH)
  # use a default
  set(CMAKE_PREFIX_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../dependencies)
endif()

include_directories(${PNG_INCLUDE_DIR} ${ZLIB_INCLUDE_DIRS})
set(war1tool_LIBS ${war1tool_LIBS} ${PNG_LIBRARIES} ${ZLIB_LIBRARIES})

set(BINDIR "bin" CACHE PATH "Where to install user binaries")
add_executable(war1tool ${war1tool_SRCS} ${war1tool_HDRS})
target_link_libraries(war1tool ${war1tool_LIBS})
install(TARGETS war1tool DESTINATION ${BINDIR})

# Launcher

find_package(Stratagus)
if(STRATAGUS_FOUND)
  set(GAMEDIR "games" CACHE PATH "Where to install games binaries")
  set(SHAREDIR "share/games/stratagus/war1gus" CACHE PATH "Where to install data files")
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

  include_directories(${STRATAGUS_INCLUDE_DIR})
  if (NOT WIN32)
    add_definitions(-DDATA_PATH="${DATA_PATH}")
    add_definitions(-DSCRIPTS_PATH="${DATA_PATH}")
    add_definitions(-DSTRATAGUS_BIN="${STRATAGUS}")
    configure_file (
      "${PROJECT_SOURCE_DIR}/war1gus.desktop.in"
      "${PROJECT_BINARY_DIR}/war1gus.desktop"
    )
    install(FILES "${PROJECT_BINARY_DIR}/war1gus.png" DESTINATION ${ICONDIR})
    install(FILES "${PROJECT_BINARY_DIR}/war1gus.xpm" DESTINATION ${ICONDIR})
    install(FILES "${PROJECT_BINARY_DIR}/war1gus.desktop" DESTINATION ${DESKTOPDIR})
    install(DIRECTORY campaigns contrib maps scripts shaders DESTINATION ${SHAREDIR})
  elseif (WIN32)
    set(war1gus_SRCS ${war1gus_SRCS} war1gus.rc)
    find_package(MakeNSIS)
    enable_language(RC)
    include(CMakeDetermineRCCompiler)
    option(ENABLE_NSIS "Create Stratagus Window NSIS Installer" ON)
    if(ENABLE_NSIS AND MAKENSIS_FOUND)
      file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/COPYING DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
      file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/war1gus.ico DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
      add_custom_target(nsis ALL
        COMMAND ${MAKENSIS} ${MAKENSIS_FLAGS} -DPORTABLE=1 -DCMAKE_CURRENT_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}" -DCMAKE_CURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/war1gus.nsi
        COMMAND ${MAKENSIS} ${MAKENSIS_FLAGS} -DCMAKE_CURRENT_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}" -DCMAKE_CURRENT_BINARY_DIR="${CMAKE_CURRENT_BINARY_DIR}" ${CMAKE_CURRENT_SOURCE_DIR}/war1gus.nsi
        DEPENDS war1gus.nsi war1gus war1tool COPYING war1gus.ico
        COMMENT "Generating War1gus Windows NSIS Installers" VERBATIM
        SOURCES war1gus.nsi)
    endif()
    add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_NO_DEPRECATE=1)
  endif()
  set(war1gus_SRCS war1gus.cpp)
  add_executable(war1gus WIN32 ${war1gus_SRCS} ${war1gus_HDRS})
  target_link_libraries(war1gus ${war1gus_LIBS})
  set(GAMEDIR "games" CACHE PATH "Where to install games binaries")
  install(TARGETS war1gus DESTINATION ${GAMEDIR})
endif()

if(ENABLE_VENDORED_LIBS)
  add_dependencies(war1gus png zlib)
  add_dependencies(war1tool png zlib)
endif()

# uninstall target
if(NOT TARGET uninstall)
    configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake_uninstall.cmake.in"
        "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
        IMMEDIATE @ONLY)

    add_custom_target(uninstall
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake)
endif()
