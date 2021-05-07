function RunEndScenarioMenu()
  local menu = WarGameMenu(panel(1))

  local titleLabel = Label("End Scenario")
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)

  local b = menu:addFullButton("~!Restart Scenario", "r", 12, 20 + (18 * 0),
    function() RunRestartConfirmMenu() end)
  if (IsNetworkGame()) then
    b:setEnabled(false)
  end
  menu:addFullButton("~!Surrender", "s", 12, 20 + (18 * 1),
    function() RunSurrenderConfirmMenu() end)
  menu:addFullButton("~!Quit to Menu", "q", 12, 20 + (18 * 2),
    function() RunQuitToMenuConfirmMenu() end)
  menu:addFullButton("E~!xit Program", "x", 12, 20 + (18 * 3),
    function() RunExitConfirmMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunRestartConfirmMenu()
  local menu = WarGameMenu(panel(1))
  local title =  { "Are you sure you",
                   "want to restart", 
                   "the scenario?"    }
  for row, value in ipairs(title) do
    local label = Label(value)
    menu:add(label, menu:getWidth() / 2 - label:getWidth() / 2, 5 + (12 * (row -1)))
  end
  menu:addFullButton("~!Restart Scenario", "r", 12, 5 + (12 * 3) + 14,
    function() StopGame(GameRestart); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunSurrenderConfirmMenu()
  local menu = WarGameMenu(panel(1))

  local title =  { "Are you sure you",
                   "want to surrender", 
                   "to your enemies?"   }
  for row, value in ipairs(title) do
    local label = Label(value)
    menu:add(label, menu:getWidth() / 2 - label:getWidth() / 2, 5 + (12 * (row -1)))
  end
  menu:addFullButton("~!Surrender", "s", 12, 5 + (12 * 3) + 14,
    function() StopGame(GameDefeat); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunQuitToMenuConfirmMenu()
  local menu = WarGameMenu(panel(1))

  local title =  { "Are you sure you",
                   "want to quit to", 
                   "the main menu?"   }
  for row, value in ipairs(title) do
    local label = Label(value)
    menu:add(label, menu:getWidth() / 2 - label:getWidth() / 2, 5 + (12 * (row -1)))
  end
  menu:addFullButton("~!Quit to Menu", "q", 12, 5 + (12 * 3) + 14,
    function() StopMusic(); StopGame(GameQuitToMenu); Editor.Running = EditorNotRunning; menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunExitConfirmMenu()
  local menu = WarGameMenu(panel(1))
  
  local title =  { "Are you sure you",
                   "want to exit", 
                   "Stratagus?"       }
  for row, value in ipairs(title) do
    local label = Label(value)
    menu:add(label, menu:getWidth() / 2 - label:getWidth() / 2, 5 + (12 * (row -1)))
  end
  menu:addFullButton("E~!xit Program", "x", 12, 5 + (12 * 3) + 14,
    function() Exit(0) end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

