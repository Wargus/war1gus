local houtcome = "ui/human/outcome_windows.png"
local ooutcome =  "ui/orc/outcome_windows.png"
local defeatscene = "ui/defeat_scene.png"
local victoryscene = "ui/victory_scene.png"

function RunResultsMenu()
  local background
  local result = "Humpf"
  local scene
  local human = (GetPlayerData(GetThisPlayer(), "RaceName") == "human")
  local sound

  if (human) then
     sound = "human"
     background = houtcome
  else
     sound = "orc"
     background = ooutcome
  end

  if (GameResult == GameVictory) then
    result = "Victory!"
    scene = victoryscene
    video = "win"
    sound = sound .. "-victory"
    PlayMusic(VictoryMusic)
  elseif (GameResult == GameDefeat) then
    result = "Defeat!"
    scene = defeatscene
    video = "lose"
    sound = sound .. "-defeat"
    PlayMusic(DefeatMusic)
  elseif (GameResult == GameDraw) then
    result = "Draw!"
    scene = victoryscene
  else
    return -- quit to menu
  end

  local menu = WarMenu(nil, background)
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2
  local multx = Video.Width / 320
  local multy = Video.Height / 200

  local names_font = Fonts["small-title"]

  menu:addLabel(result, 125 / 2 * multx, 52 / 2 * multy, Fonts["small-title"])

  local movieW = math.ceil(368 / 2 * Video.Width / 320)
  local movieH = math.ceil(224 / 2 * Video.Height / 200)
  local movieX = 234 / 2 * Video.Width / 320
  local movieY = 24 / 2 * Video.Height / 200
  local sceneg = CGraphic:New(scene)
  sceneg:Load()
  sceneg:Resize(movieW, movieH)
  local scenew = ImageWidget(sceneg)
  menu:add(scenew, movieX, movieY)

  local scenem = Movie()
  if scenem:Load("videos/"..video.."1.ogv", movieW, movieH) then
     local movieWidget = ImageWidget(scenem)
     menu:add(movieWidget, movieX, movieY)

     local function playLoop()
        if not scenem:IsPlaying() then
           scenem = Movie()
           if scenem:Load("videos/"..video.."2.ogv", movieW, movieH) then
              menu:remove(movieWidget)
              movieWidget = ImageWidget(scenem)
              menu:add(movieWidget, movieX, movieY)
           end
        end
     end
     local listener = LuaActionListener(playLoop)
     menu:addLogicCallback(listener)
  end

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
  
  local lineHeight = 17 / 2 * multy

  StopAllChannels()
  PlaySound(sound, true)

  local font = Fonts["large"]
  if Video.Width >= 1024 then
     font = Fonts["small-title"]
  end

  menu:addLabel(kills.you, 115 / 2 * multx, 280 / 2 * multy, font, true)
  menu:addLabel(kills.enemy, 115 / 2 * multx, 280 / 2 * multy + lineHeight, font, true)
  menu:addLabel(units.you, 115 / 2 * multx, 346 / 2 * multy, font, true)
  menu:addLabel(units.enemy, 115 / 2 * multx, 346 / 2 * multy + lineHeight, font, true)

  menu:addLabel(razings.you, 315 / 2 * multx, 280 / 2 * multy, font, true)
  menu:addLabel(razings.enemy, 315 / 2 * multx, 280 / 2 * multy + lineHeight, font, true)
  menu:addLabel(buildings.you, 315 / 2 * multx, 346 / 2 * multy, font, true)
  menu:addLabel(buildings.enemy, 315 / 2 * multx, 346 / 2 * multy + lineHeight, font, true)

  menu:addLabel(gold.you, 515 / 2 * multx, 280 / 2 * multy, font, true)
  menu:addLabel(gold.enemy, 515 / 2 * multx, 280 / 2 * multy + lineHeight, font, true)
  menu:addLabel(wood.you, 515 / 2 * multx, 346 / 2 * multy, font, true)
  menu:addLabel(wood.enemy, 515 / 2 * multx, 346 / 2 * multy + lineHeight, font, true)

  local btn = menu:addHalfButton("~!Save Replay", "s", 24 / 2 * multx, 180 / 2 * multy,
                                 function() RunSaveReplayMenu() end)
  btn:setSize(190 / 2 * multx, 28 / 2)

  btn = menu:addHalfButton("~!Continue", "c", 24 / 2 * multx, 210 / 2 * multy,
                           function() StopMusic(); menu:stop() end)
  btn:setSize(190 / 2 * multx, 28 / 2)
  btn:requestFocus()

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
