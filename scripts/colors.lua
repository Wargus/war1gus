--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      colors.lua - Color schemes
--
--      (c) Copyright 2001-2004 by Lutz Sammer and Jimmy Salmon
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
--      $Id$

-- In WC1 the palette swaps were hard-coded
-- DefinePlayerColorIndex(176, 8) -- This is for orcs
-- DefinePlayerColorIndex(200, 8) -- This is for humans
-- war1tool.c force-moves all references in orc units to human color index
DefinePlayerColorIndex(200, 8)

wc1.HumanMultiColors = {
     "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
	 "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
     "orange", {{82, 34, 4}, {122, 51, 6}, {143, 60, 7}, {173, 73, 9}, {196, 82, 10}, {224, 94, 11}, {242, 102, 12}, {255, 107, 13}},
     "violet", {{81,34,92}, {93,39,105}, {109,46,122}, {122,51,138}, {138,58,156}, {158,66,178}, {183,77,207}, {213,89,240}},
     "green", {{6,82,25}, {9,117,36}, {11,143,44}, {12,163,50}, {13,181,56}, {15,199,61}, {16,219,68}, {18,240,74}},
     "black", {{0,0,0}, {12,12,11}, {25,25,22}, {39,41,35}, {51,54,45}, {64,66,56}, {76,79,67}, {91,94,80}},
     "white", {{74,75,82}, {88,89,97}, {111,113,122}, {135,136,148}, {160,162,176}, {186,188,204}, {211,213,232}, {232,235,255}},
     "yellow", {{66,66,3}, {78,79,4}, {96,97,5}, {114,115,6}, {129,130,6}, {162,163,8}, {194,196,10}, {232,235,12}},
     "blue", {{0,8,36}, {0,16,64}, {0,28,96}, {0,40,128}, {0,52,156}, {8,64,188}, {12,80,220}, {20,96,252}},
	 "red", {{84,0,0}, {108,0,0}, {132,0,0}, {156,0,0}, {180,0,0}, {204,0,0}, {228,0,0}, {252,0,0}},
     "orange", {{82, 34, 4}, {122, 51, 6}, {143, 60, 7}, {173, 73, 9}, {196, 82, 10}, {224, 94, 11}, {242, 102, 12}, {255, 107, 13}},
     "violet", {{81,34,92}, {93,39,105}, {109,46,122}, {122,51,138}, {138,58,156}, {158,66,178}, {183,77,207}, {213,89,240}},
     "green", {{6,82,25}, {9,117,36}, {11,143,44}, {12,163,50}, {13,181,56}, {15,199,61}, {16,219,68}, {18,240,74}},
     "black", {{0,0,0}, {12,12,11}, {25,25,22}, {39,41,35}, {51,54,45}, {64,66,56}, {76,79,67}, {91,94,80}},
	 "yellow", {{66,66,3}, {78,79,4}, {96,97,5}, {114,115,6}, {129,130,6}, {162,163,8}, {194,196,10}, {232,235,12}},
     "white", {{74,75,82}, {88,89,97}, {111,113,122}, {135,136,148}, {160,162,176}, {186,188,204}, {211,213,232}, {232,235,255}},
}

-------
local i

wc1.OrcMultiColors = {wc1.HumanMultiColors[3], wc1.HumanMultiColors[4],wc1.HumanMultiColors[1], wc1.HumanMultiColors[2]}
for i=5,30,1 do
   wc1.OrcMultiColors[i] = wc1.HumanMultiColors[i]
end

wc1.HumanCampaignColors = {wc1.HumanMultiColors[1], wc1.HumanMultiColors[2]}
for i=3,28,1 do
  if i % 2 == 0 then
    wc1.HumanCampaignColors[i] = wc1.HumanMultiColors[4]
  else
    wc1.HumanCampaignColors[i] = wc1.HumanMultiColors[3]
  end
end
wc1.HumanCampaignColors[29] = wc1.HumanMultiColors[29]
wc1.HumanCampaignColors[30] = wc1.HumanMultiColors[30]

wc1.OrcCampaignColors = {wc1.OrcMultiColors[1], wc1.OrcMultiColors[2]}
for i=3,28,1 do
  if i % 2 == 0 then
    wc1.OrcCampaignColors[i] = wc1.OrcMultiColors[4]
  else
    wc1.OrcCampaignColors[i] = wc1.OrcMultiColors[3]
  end
end
wc1.OrcCampaignColors[29] = wc1.OrcMultiColors[29]
wc1.OrcCampaignColors[30] = wc1.OrcMultiColors[30]

function SetColorScheme()
  if preferences.MultiColoredCampaigns and currentRace == "orc" then
    DefinePlayerColors(wc1.OrcMultiColors)
  else if preferences.MultiColoredCampaigns and currentRace == "human" then
    DefinePlayerColors(wc1.HumanMultiColors)
  else if currentRace == "orc" then
    DefinePlayerColors(wc1.OrcCampaignColors)
  else
    DefinePlayerColors(wc1.HumanCampaignColors)
  end end end
end
