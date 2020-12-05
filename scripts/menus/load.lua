function LoadGame(s)
  LoadGameFile = nil
  currentCampaign = nil
  loop = true

  while (loop) do
    InitGameVariables()
    StartSavedGame(s)
    if (GameResult ~= GameRestart) then
      loop = false
    end
  end

  RunResultsMenu()

  InitGameSettings()
  SetPlayerData(GetThisPlayer(), "RaceName", "orc")

  if (GameResult == GameVictory) then
    IncreaseCampaignState(currentRace, currentState)
  end

  if currentCampaign ~= nil then
    if GameResult == GameVictory then
      position = position + 1
    elseif (GameResult == GameDefeat) then
    elseif (GameResult == GameDraw) then
    elseif (GameResult == GameNoResult) then
      return
    else
      RunCampaignSubmenu(currentRace) -- quit to menu
      return
    end
    RunCampaign(currentCampaign)
  end
end

function AddLoadGameItems(menu)
  menu:addLabel("Load Game", 384 / 2 / 2, 11 / 2)
  local browser = menu:addBrowser("~save", "^.*%.sav%.?g?z?$",
    (384 / 2 - 300 / 2 - 18 / 2) / 2, 11 / 2 + (36 / 2 * 1.5), 318 / 2, 126 / 2)

  menu:addHalfButton("~!Load", "l", (384 / 2 - 300 / 2 - 18 / 2) / 2, 256 / 2 - 16 / 2 - 27 / 2,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      LoadGameFile = "~save/" .. browser:getSelectedItem()
      if (menu.ingame) then
        StopGame(GameNoResult)
        menu:stopAll()
      else
        menu:stop()
      end
    end)
  menu:addHalfButton("~!Cancel", "c", 384 / 2 - ((384 / 2 - 300 / 2 - 18 / 2) / 2) - 121 / 2, 256 / 2 - 16 / 2 - 27 / 2,
                     function()
                        if not menu.ingame then
                           RunSinglePlayerSubMenu();
                        end
                        menu:stop()
  end)
end

function RunLoadGameMenu()
  local menu = WarMenu(nil, panel(3), false)
  menu:setSize(384 / 2, 256 / 2)
  menu:setPosition((Video.Width - 384 / 2) / 2, (Video.Height - 256 / 2) / 2)
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = false
  menu:run()
end

function RunGameLoadGameMenu()
  local menu = WarGameMenu(panel(3))
  menu:resize(384 / 2, 256 / 2)
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = true
  menu:run(false)
end

