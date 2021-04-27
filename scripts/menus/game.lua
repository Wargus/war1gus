function WarGameMenu(background, width, height)
  width = width or 152 -- default values
  height = height or 136 -- default values

  local menu = MenuScreen()
  
  if (background == nil) then
    menu:setOpaque(true)
    menu:setBaseColor(dark)
  else
    local bgg = CGraphic:New(background)
    bgg:Load()
    bgg:Resize(width, height)
    local bg = ImageWidget(bgg)
    menu:add(bg, 0, 0)
  end

  function menu:resize(w, h)
    menu:setSize(w, h)
    if GameCycle > 0 then
      menu:setPosition(78 + (Video.Width - 88 - menu:getWidth()) / 2,
        (Video.Height - menu:getHeight()) / 2)
    else
      menu:setPosition((Video.Width - menu:getWidth()) / 2,
        (Video.Height - menu:getHeight()) / 2)
    end
  end

  menu:resize(width, height)
  menu:setBorderSize(0)
  menu:setDrawMenusUnder(true)

  AddMenuHelpers(menu)

  return menu
end



function RunGameMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Game Menu", 64, 5)

  menu:addHalfButton("Save (~<F11~>)", "f11", 12, 20,
    function() RunSaveMenu() end)
  menu:addHalfButton("Load (~<F12~>)", "f12", 12 + 6 + 60, 20,
    function() RunGameLoadGameMenu() end)
  menu:addFullButton("Options (~<F5~>)", "f5", 12, 20 + 18*1,
    function() RunGameOptionsMenu() end)
  menu:addFullButton("Help (~<F1~>)", "f1", 12, 20 + 18*2,
    function() RunHelpMenu() end)
  menu:addFullButton("Scenario ~!Objectives", "o", 12, 20 + 18*3,
    function() RunObjectivesMenu() end)
  menu:addFullButton("~!End Scenario", "e", 12, 20 + 18*4,
    function() RunEndScenarioMenu() end)
  menu:addFullButton("Return to Game (~<Esc~>)", "escape", 12, 144 - 30,
    function() menu:stop() end)

  menu:run(false)
end

