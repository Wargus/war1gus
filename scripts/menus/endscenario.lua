function RunEndScenarioMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("End Scenario", 128 / 2, 11 / 2)
  local b = menu:addFullButton("~!Restart Scenario", "r", 25 / 2, 40 / 2 + (36 / 2 * 0),
    function() RunRestartConfirmMenu() end)
  if (IsNetworkGame()) then
    b:setEnabled(false)
  end
  menu:addFullButton("~!Surrender", "s", 25 / 2, 40 / 2 + (36 / 2 * 1),
    function() RunSurrenderConfirmMenu() end)
  menu:addFullButton("~!Quit to Menu", "q", 25 / 2, 40 / 2 + (36 / 2 * 2),
    function() RunQuitToMenuConfirmMenu() end)
  menu:addFullButton("E~!xit Program", "x", 25 / 2, 40 / 2 + (36 / 2 * 3),
    function() RunExitConfirmMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 25 / 2, 228 / 2,
    function() menu:stop() end)

  menu:run(false)
end

function RunRestartConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128 / 2, 11 / 2)
  menu:addLabel("want to restart", 128 / 2, 11 / 2 + (24 / 2 * 1))
  menu:addLabel("the scenario?", 128 / 2, 11 / 2 + (24 / 2 * 2))
  menu:addFullButton("~!Restart Scenario", "r", 25 / 2, 11 / 2 + (24 / 2 * 3) + 29 / 2,
    function() StopGame(GameRestart); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 25 / 2, 228 / 2,
    function() menu:stop() end)

  menu:run(false)
end

function RunSurrenderConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128 / 2, 11 / 2)
  menu:addLabel("want to surrender", 128 / 2, 11 / 2 + (24 / 2 * 1))
  menu:addLabel("to your enemies?", 128 / 2, 11 / 2 + (24 / 2 * 2))
  menu:addFullButton("~!Surrender", "s", 25 / 2, 11 / 2 + (24 / 2 * 3) + 29 / 2,
    function() StopGame(GameDefeat); menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 25 / 2, 228 / 2,
    function() menu:stop() end)

  menu:run(false)
end

function RunQuitToMenuConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128 / 2, 11 / 2)
  menu:addLabel("want to quit to", 128 / 2, 11 / 2 + (24 / 2 * 1))
  menu:addLabel("the main menu?", 128 / 2, 11 / 2 + (24 / 2 * 2))
  menu:addFullButton("~!Quit to Menu", "q", 25 / 2, 11 / 2 + (24 / 2 * 3) + 29 / 2,
    function() StopMusic(); StopGame(GameQuitToMenu); Editor.Running = EditorNotRunning; menu:stopAll() end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 25 / 2, 228 / 2,
    function() menu:stop() end)

  menu:run(false)
end

function RunExitConfirmMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Are you sure you", 128 / 2, 11 / 2)
  menu:addLabel("want to exit", 128 / 2, 11 / 2 + (24 / 2 * 1))
  menu:addLabel("Stratagus?", 128 / 2, 11 / 2 + (24 / 2 * 2))
  menu:addFullButton("E~!xit Program", "x", 25 / 2, 11 / 2 + (24 / 2 * 3) + 29 / 2,
    function() Exit(0) end)
  menu:addFullButton("Cancel (~<Esc~>)", "escape", 25, 228,
    function() menu:stop() end)

  menu:run(false)
end

