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
  menu:addLabel("Load Game", 96, 5)
  local browser = menu:addBrowser("~save", "^.*%.sav%.?g?z?$",
    (menu:getWidth() - 150 - 9) / 2, 5 + (18 * 1.5), 159, 63)

  menu:addHalfButton("~!Load", "l", 9 ,  menu:getHeight() - 8 - 13,
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
  menu:addHalfButton("~!Cancel", "c", menu:getWidth() - 60 - 9, menu:getHeight() - 8 - 13,
                     function()
                        if not menu.ingame then
                           RunSinglePlayerSubMenu();
                        end
                        menu:stop()
  end)
end

function RunLoadGameMenu()
  local menu = WarMenu(nil, panel(1), {192, 128})
  
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = false
  menu:run()
end

function RunGameLoadGameMenu()
  local menu = WarGameMenu(panel(1), 192, 128)
  menu:setDrawMenusUnder(true)

  AddLoadGameItems(menu)

  menu.ingame = true
  menu:run(false)
end

