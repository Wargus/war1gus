function RunEndScenarioMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("End Scenario", 64, 5)
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

  menu:addLabel("Are you sure you", 64, 5)
  menu:addLabel("want to restart", 64, 5 + (12 * 1))
  menu:addLabel("the scenario?", 64, 5 + (12 * 2))
  menu:addFullButton("~!Restart Scenario", "r", 12, 5 + (12 * 3) + 14,
    function() StopGame(GameRestart); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunSurrenderConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 64, 5)
  menu:addLabel("want to surrender", 64, 5 + (12 * 1))
  menu:addLabel("to your enemies?", 64, 5 + (12 * 2))
  menu:addFullButton("~!Surrender", "s", 12, 5 + (12 * 3) + 14,
    function() StopGame(GameDefeat); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunQuitToMenuConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 64, 5)
  menu:addLabel("want to quit to", 64, 5 + (12 * 1))
  menu:addLabel("the main menu?", 64, 5 + (12 * 2))
  menu:addFullButton("~!Quit to Menu", "q", 12, 5 + (12 * 3) + 14,
    function() StopMusic(); StopGame(GameQuitToMenu); Editor.Running = EditorNotRunning; menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

function RunExitConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 64, 5)
  menu:addLabel("want to exit", 64, 5 + (12 * 1))
  menu:addLabel("Stratagus?", 64, 5 + (12 * 2))
  menu:addFullButton("E~!xit Program", "x", 12, 5 + (12 * 3) + 14,
    function() Exit(0) end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 25, 228,
    function() menu:stop() end)

  menu:run(false)
end

