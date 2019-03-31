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
   local prefix = string.upper(string.sub(race, 1, 1))
   local campaign_steps = {
      CreateMapStep(race, "01"),
      CreateMapStep(race, "02"),
      CreateMapStep(race, "03"),
      CreateMapStep(race, "04"),
      CreateMapStep(race, "05"),
      CreateMapStep(race, "06"),
      CreateMapStep(race, "07"),
      CreateMapStep(race, "08"),
      CreateMapStep(race, "09"),
      CreateMapStep(race, "10"),
      CreateMapStep(race, "11"),
      CreateMapStep(race, "12"),
      CreateEndingStep("graphics/ui/" .. race .. "/victory_1.png",
                       "campaigns/" .. race .. "/ending_1.txt",
                       "campaigns/" .. race .. "/ending_1.wav"),
      CreateEndingStep("graphics/ui/" .. race .. "/victory_1.png",
						"campaigns/" .. race .. "/ending_2.txt",
						"campaigns/" .. race .. "/ending_2.wav.gz")
   }
   local campaign_menu = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }
   return {menu = campaign_menu, steps = campaign_steps}
end
