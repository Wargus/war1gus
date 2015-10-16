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

file(GLOB war1gus_SRCS
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

set(war1gus_HDRS xmi2mid.h scale2x.h)

find_package(PNG REQUIRED)
find_package(ZLIB REQUIRED)

include_directories(${PNG_INCLUDE_DIR} ${ZLIB_INCLUDE_DIRS})
set(war1gus_LIBS ${PNG_LIBRARIES} ${ZLIB_LIBRARIES})

add_executable(war1tool ${war1gus_SRCS} ${war1gus_HDRS})
target_link_libraries(war1tool ${war1gus_LIBS})
install(TARGETS war1tool DESTINATION "bin")

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
