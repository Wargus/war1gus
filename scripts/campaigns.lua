--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--			  T H E   W A R   B E G I N S
--	   Stratagus - A free fantasy real time strategy game engine
--
--	campaign1.ccl	-	Define the human campaign 1.
--
--	(c) Copyright 2002 by Lutz Sammer
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
--	$Id$

--=============================================================================

function CreateCampaign(race)
   if race == "human" then
     DefinePlayerColors({
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
       "white", {{74,75,82}, {88,89,97}, {111,113,122}, {135,136,148}, {160,162,176}, {186,188,204}, {211,213,232}, {232,235,255}},
     });
   else
     DefinePlayerColors({
	   "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
       "white", {{74,75,82}, {88,89,97}, {111,113,122}, {135,136,148}, {160,162,176}, {186,188,204}, {211,213,232}, {232,235,255}},
     });
   end

   local prefix = string.sub(race, 1, 1)
   local campaign_steps = {
      CreateVideoStep("videos/" .. prefix .. "MAP01.ogv"),
      CreateMapStep("campaigns/" .. race .. "/01.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP02.ogv"),
      CreateMapStep("campaigns/" .. race .. "/02.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP03.ogv"),
      CreateMapStep("campaigns/" .. race .. "/03.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP04.ogv"),
      CreateMapStep("campaigns/" .. race .. "/04.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP05.ogv"),
      CreateMapStep("campaigns/" .. race .. "/05.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP06.ogv"),
      CreateMapStep("campaigns/" .. race .. "/06.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP07.ogv"),
      CreateMapStep("campaigns/" .. race .. "/07.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP08.ogv"),
      CreateMapStep("campaigns/" .. race .. "/08.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP09.ogv"),
      CreateMapStep("campaigns/" .. race .. "/09.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP10.ogv"),
      CreateMapStep("campaigns/" .. race .. "/10.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP11.ogv"),
      CreateMapStep("campaigns/" .. race .. "/11.smp"),
      CreateVideoStep("videos/" .. prefix .. "MAP12.ogv"),
      CreateMapStep("campaigns/" .. race .. "/12.smp"),
      CreateVideoStep("videos/" .. prefix .. "FINALE.ogv"),
   }
   local campaign_menu = { 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23 }
   return {menu = campaign_menu, steps = campaign_steps}
end
