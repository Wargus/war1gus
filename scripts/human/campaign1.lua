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
--	Define the campaign
--
--	(define-campagin 'ident 'name "name" 'campaign (list elements)

campaign_steps = {
  CreateMapStep("campaigns/human/01.cm"),
  CreateMapStep("campaigns/human/02.cm"),
  CreateMapStep("campaigns/human/03.cm"),
  CreateMapStep("campaigns/human/04.cm"),
  CreateMapStep("campaigns/human/05.cm"),
  CreateMapStep("campaigns/human/06.cm"),
  CreateMapStep("campaigns/human/07.cm"),
  CreateMapStep("campaigns/human/08.cm"),
  CreateMapStep("campaigns/human/09.cm"),
  CreateMapStep("campaigns/human/10.cm"),
  CreateMapStep("campaigns/human/11.cm"),
  CreateMapStep("campaigns/human/12.cm"),
}

campaign_menu = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 }
