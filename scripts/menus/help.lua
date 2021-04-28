function RunHelpMenu()
  local menu = WarGameMenu(panel(1))

  local titleLabel = Label("Help Menu")
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)

  menu:addFullButton("Keystroke ~!Help", "h", 12, 20 + 18*0,
    function() RunKeystrokeHelpMenu() end)
  menu:addFullButton("~!Tips", "t", 12, 20 + 18*1,
    function() RunTipsMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 12, 114,
    function() menu:stop() end)

  menu:run(false)
end

local keystrokes = {
  {"Alt-F", "- toggle full screen"},
  {"Alt-G", "- toggle grab mouse"},
  {"Ctrl-S", "- mute sound"},
  {"Ctrl-M", "- mute music"},
  {"+", "- increase game speed"},
  {"-", "- decrease game speed"},
  {"Ctrl-P", "- pause game"},
  {"PAUSE", "- pause game"},
  {"PRINT", "- make screen shot"},
  {"Alt-H", "- help menu"},
  {"Alt-R", "- restart scenario"},
  {"Alt-Q", "- quit to main menu"},
  {"Alt-X", "- quit game"},
  {"Alt-B", "- toggle expand map"},
  {"Alt-M", "- game menu"},
  {"ENTER", "- write a message"},
  {"SPACE", "- goto last event"},
  {"TAB", "- hide/unhide terrain"},
  {"Ctrl-T", "- track unit"},
  {"Alt-I", "- find idle peon"},
  {"Alt-C", "- center on selected unit"},
  {"Alt-V", "- next view port"},
  {"Ctrl-V", "- previous view port"},
  {"^", "- select nothing"},
  {"#", "- select group"},
  {"##", "- center on group"},
  {"Ctrl-#", "- define group"},
  {"Shift-#", "- add to group"},
  {"Alt-#", "- add to alternate group"},
  {"F2-F4", "- recall map position"},
  {"Shift F2-F4", "- save map postition"},
  {"F5", "- game options"},
  {"F7", "- sound options"},
  {"F8", "- speed options"},
  {"F9", "- preferences"},
  {"F10", "- game menu"},
  {"BACKSPACE", "- game menu"},
  {"F11", "- save game"},
  {"F12", "- load game"},
}

function RunKeystrokeHelpMenu()
  local menu = WarGameMenu(panel(1), 176, 176)

  local c = Container()
  c:setOpaque(false)

  for i=1,table.getn(keystrokes) do
    local l = Label(keystrokes[i][1])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 0, 10 * (i - 1))
    local l = Label(keystrokes[i][2])
    l:setFont(Fonts["game"])
    l:adjustSize()
    c:add(l, 40, 10 * (i - 1))
  end

  local s = ScrollArea()
  c:setSize(160 - s:getScrollbarWidth(), 10 * table.getn(keystrokes))
  s:setBaseColor(dark)
  s:setBackgroundColor(dark)
  s:setForegroundColor(clear)
  s:setSize(160, 108)
  s:setContent(c)
  menu:add(s, 8, 30)

  menu:addLabel("Keystroke Help Menu", 88, 5)
  menu:addFullButton("Previous (~<Esc~>)", "escape",
    (88) - (63), 176 - 20, function() menu:stop() end)

  menu:run(false)
end

local tips = {
  "You can select all of your currently visible units of the same type by holding down the CTRL key and selecting a unit or by \"double clicking\" on a unit.",
  "The more workers you have collecting resources, the faster your economy will grow.",
  "Building more than one barracks will let you train more units faster.",
  "Use your workers to repair damaged buildings.",
  "Explore your surroundings early in the game.",

  "You can demolish trees and rocks.",
  "Keep all workers working. Use ALT-I to find idle workers.",
  "You can make units automatically cast spells by selecting a unit, holding down CTRL and clicking on the spell icon.  CTRL click again to turn off.",

  -- Shift tips
  "You can give an unit an order which is executed after it finishes the current work, if you hold the SHIFT key.",
  "You can give way points, if you press the SHIFT key, while you click right for the move command.",
  "You can order a worker to build one building after the other, if you hold the SHIFT key, while you place the building.",
  "You can build many of the same building, if you hold the ALT and SHIFT keys while you place the buildings.",

  "Use CTRL-V or ALT-V to cycle through the viewport configuration, you can then monitor your base and lead an attack.",

  "Know a useful tip?  Then add it here!",
}

function RunTipsMenu()
  local menu = WarGameMenu(panel(1))
  menu:resize(152, 121)

  menu:addLabel("Tips", 72, 5)

  local l = MultiLineLabel()
  l:setFont(Fonts["game"])
  l:setSize(130, 64)
  l:setLineWidth(130)
  menu:add(l, 7, 17)

  function l:prevTip()
    preferences.TipNumber = preferences.TipNumber - 1
    if (preferences.TipNumber < 1) then
      preferences.TipNumber = table.getn(tips)
    end
    SavePreferences()
  end
  function l:nextTip()
    preferences.TipNumber = preferences.TipNumber + 1
    if (preferences.TipNumber > table.getn(tips)) then
      preferences.TipNumber = 1
    end
    SavePreferences()
  end
  function l:updateCaption()
    self:setCaption(tips[preferences.TipNumber])
  end

  if (preferences.TipNumber == 0) then
    l:nextTip()
  end
  l:updateCaption()

  local showtips = {}
  showtips = menu:addCheckBox("Show tips at startup", 7, 128 - 37,
    function()
      preferences.ShowTips = showtips:isMarked()
      SavePreferences()
    end)
  showtips:setMarked(preferences.ShowTips)

  menu:addHalfButton("~!Next Tip", "n", 2, 128 - 20,
    function() l:nextTip(); l:updateCaption() end)
  menu:addHalfButton("~!Close", "c", 79, 128 - 20,
    function() l:nextTip(); menu:stop() end)

  menu:run(false)
end

