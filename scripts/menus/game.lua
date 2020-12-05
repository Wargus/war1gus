function WarGameMenu(background)
  local menu = MenuScreen()

  if (background == nil) then
    menu:setOpaque(true)
    menu:setBaseColor(dark)
  else
    local bgg = CGraphic:New(background)
    bgg:Load()
    local bg = ImageWidget(bgg)
    menu:add(bg, 0, 0)
  end

  function menu:resize(w, h)
    menu:setSize(w, h)
    menu:setPosition(156 / 2 + (Video.Width - 176 / 2 - menu:getWidth()) / 2,
      (Video.Height - menu:getHeight()) / 2)
  end

  menu:resize(304 / 2, 272 / 2)
  menu:setBorderSize(0)
  menu:setDrawMenusUnder(true)

  AddMenuHelpers(menu)

  return menu
end



function RunGameMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Game Menu", 128 / 2, 11 / 2)

  menu:addHalfButton("Save (~<F11~>)", "f11", 25 / 2, 40 / 2,
    function() RunSaveMenu() end)
  menu:addHalfButton("Load (~<F12~>)", "f12", 25 / 2 + 12 / 2 + 121 / 2, 40 / 2,
    function() RunGameLoadGameMenu() end)
  menu:addFullButton("Options (~<F5~>)", "f5", 25 / 2, 40 / 2 + 36 / 2*1,
    function() RunGameOptionsMenu() end)
  menu:addFullButton("Help (~<F1~>)", "f1", 25 / 2, 40 / 2 + 36 / 2*2,
    function() RunHelpMenu() end)
  menu:addFullButton("Scenario ~!Objectives", "o", 25 / 2, 40 / 2 + 36 / 2*3,
    function() RunObjectivesMenu() end)
  menu:addFullButton("~!End Scenario", "e", 25 / 2, 40 / 2 + 36 / 2*4,
    function() RunEndScenarioMenu() end)
  menu:addFullButton("Return to Game (~<Esc~>)", "escape", 25 / 2, 288 / 2 - 60 / 2,
    function() menu:stop() end)

  menu:run(false)
end

