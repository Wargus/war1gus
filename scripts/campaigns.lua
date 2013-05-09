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
   local prefix = string.sub(race, 1, 1)
   local campaign_steps = {
      CreateVideoStep("videos/" .. prefix .. "map01.avi"),
      CreateMapStep("campaigns/" .. race .. "/01.smp"),
      CreateVideoStep("videos/" .. prefix .. "map02.avi"),
      CreateMapStep("campaigns/" .. race .. "/02.smp"),
      CreateVideoStep("videos/" .. prefix .. "map03.avi"),
      CreateMapStep("campaigns/" .. race .. "/03.smp"),
      CreateVideoStep("videos/" .. prefix .. "map04.avi"),
      CreateMapStep("campaigns/" .. race .. "/04.smp"),
      CreateVideoStep("videos/" .. prefix .. "map05.avi"),
      CreateMapStep("campaigns/" .. race .. "/05.smp"),
      CreateVideoStep("videos/" .. prefix .. "map06.avi"),
      CreateMapStep("campaigns/" .. race .. "/06.smp"),
      CreateVideoStep("videos/" .. prefix .. "map07.avi"),
      CreateMapStep("campaigns/" .. race .. "/07.smp"),
      CreateVideoStep("videos/" .. prefix .. "map08.avi"),
      CreateMapStep("campaigns/" .. race .. "/08.smp"),
      CreateVideoStep("videos/" .. prefix .. "map09.avi"),
      CreateMapStep("campaigns/" .. race .. "/09.smp"),
      CreateVideoStep("videos/" .. prefix .. "map10.avi"),
      CreateMapStep("campaigns/" .. race .. "/10.smp"),
      CreateVideoStep("videos/" .. prefix .. "map11.avi"),
      CreateMapStep("campaigns/" .. race .. "/11.smp"),
      CreateVideoStep("videos/" .. prefix .. "map12.avi"),
      CreateMapStep("campaigns/" .. race .. "/12.smp"),
      CreateVideoStep("videos/" .. prefix .. "finale.avi"),
   }
   local campaign_menu = { 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23 }
   return {menu = campaign_menu, steps = campaign_steps}
end
