local houtcome = "ui/human/outcome_windows.png"
local ooutcome =  "ui/orc/outcome_windows.png"
local defeatscene = "ui/defeat_scene.png"
local victoryscene = "ui/victory_scene.png"

function RunResultsMenu()
  local background
  local result = "Humpf"
  local scene
  local human = (GetPlayerData(GetThisPlayer(), "RaceName") == "human")

  if (human) then
     background = houtcome
  else
     background = ooutcome
  end

  if (GameResult == GameVictory) then
    result = "Victory!"
    scene = victoryscene
    if (human) then
      PlayMusic("music/Human Victory.ogg")
    else
      PlayMusic("music/Orc Victory.ogg")
    end
  elseif (GameResult == GameDefeat) then
    result = "Defeat!"
    scene = defeatscene
    if (human) then
      PlayMusic("music/Human Defeat.ogg")
    else
      PlayMusic("music/Orc Defeat.ogg")
    end
  elseif (GameResult == GameDraw) then
    result = "Draw!"
    scene = victoryscene
  else
    return -- quit to menu
  end

  local menu = WarMenu(nil, background)
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local multx = Video.Width / 640
  local multy = Video.Height / 400

  local names_font = Fonts["small-title"]

  menu:addLabel(result, 125 * multx, 52 * multy, Fonts["small-title"])

  sceneg = CGraphic:New(scene)
  sceneg:Load()
  scenew = ImageWidget(sceneg)
  menu:add(scenew, 234, 24)

  local kills = {you = 0, enemy = 0, neutral = 0}
  local units = {you = 0, enemy = 0, neutral = 0}
  local razings = {you = 0, enemy = 0, neutral = 0}
  local buildings = {you = 0, enemy = 0, neutral = 0}
  local gold = {you = 0, enemy = 0, neutral = 0}
  local wood = {you = 0, enemy = 0, neutral = 0}

  for i=0,14 do
    if (GetPlayerData(i, "TotalUnits") > 0 ) then
      local name = ""
      if (ThisPlayer.Index == i) or (ThisPlayer:IsAllied(Players[i])) then
  	 name = "you"
      elseif (ThisPlayer:IsEnemy(Players[i])) then
  	 name = "enemy"
      else
  	-- ignored for now
        name = "neutral"
      end
      kills[name] = kills[name] + GetPlayerData(i, "TotalKills")
      units[name] = units[name] + GetPlayerData(i, "TotalUnits")
      razings[name] = razings[name] + GetPlayerData(i, "TotalRazings")
      buildings[name] = buildings[name] + GetPlayerData(i, "TotalBuildings")
      gold[name] = gold[name] + GetPlayerData(i, "TotalResources", "gold")
      wood[name] = wood[name] + GetPlayerData(i, "TotalResources", "wood")        
    end
  end
  
  local lineHeight = 17 * multy

  menu:addLabel(kills.you, 115 * multx, 280 * multy, Fonts["large"], true)
  menu:addLabel(kills.enemy, 115 * multx, 280 * multy + lineHeight, Fonts["large"], true)
  menu:addLabel(units.you, 115 * multx, 346 * multy, Fonts["large"], true)
  menu:addLabel(units.enemy, 115 * multx, 346 * multy + lineHeight, Fonts["large"], true)

  menu:addLabel(razings.you, 315 * multx, 280 * multy, Fonts["large"], true)
  menu:addLabel(razings.enemy, 315 * multx, 280 * multy + lineHeight, Fonts["large"], true)
  menu:addLabel(buildings.you, 315 * multx, 346 * multy, Fonts["large"], true)
  menu:addLabel(buildings.enemy, 315 * multx, 346 * multy + lineHeight, Fonts["large"], true)

  menu:addLabel(gold.you, 515 * multx, 280 * multy, Fonts["large"], true)
  menu:addLabel(gold.enemy, 515 * multx, 280 * multy + lineHeight, Fonts["large"], true)
  menu:addLabel(wood.you, 515 * multx, 346 * multy, Fonts["large"], true)
  menu:addLabel(wood.enemy, 515 * multx, 346 * multy + lineHeight, Fonts["large"], true)

  menu:addFullButton("~!Save Replay", "s", 16 * multx, 180 * multy,
    function() RunSaveReplayMenu() end)

  menu:addFullButton("~!Continue", "c", 16 * multx, 210 * multy,
    function() StopMusic(); menu:stop() end)

  menu:run()
end

--
--  TODO : Reenable ranking.
--  TODO : progress bar instead of label
--[[
DefineRanks("human", {
  0, "Servant",
  2000, "Peasant",
  5000, "Squire",
  8000, "Footman",
  18000, "Corporal",
  28000, "Sergeant",
  40000, "Lieutenant",
  55000, "Captain",
  70000, "Major",
  85000, "Knight",
  105000, "General",
  125000, "Admiral",
  145000, "Marshall",
  165000, "Lord",
  185000, "Grand Admiral",
  205000, "Highlord",
  230000, "Thundergod",
  255000, "God",
  280000, "Designer",
})

DefineRanks("orc", {
  0, "Slave",
  2000, "Peon",
  5000, "Rogue",
  8000, "Grunt",
  18000, "Slasher",
  28000, "Marauder",
  40000, "Commander",
  55000, "Captain",
  70000, "Major",
  85000, "Knight",
  105000, "General",
  125000, "Master",
  145000, "Marshall",
  165000, "Chieftain",
  185000, "Overlord",
  205000, "War Chief",
  230000, "Demigod",
  255000, "God",
  280000, "Designer",
})
--]]
