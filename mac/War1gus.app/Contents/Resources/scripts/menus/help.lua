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
  {". / Alt-I", "- find idle worker"},
  {"+/-", "- change game speed"},  
  {"SPACE", "- goto last event"},
  {"F2-F4", "- recall map position"},
  {"ShiftF2-F4", "    save map postition"},  
  {"PRINT", "- screen in game folder"},  
  {"Alt-F", "- toggle full screen"},
  {"F11", "- save game"},
  {"F12", "- load game"},
  {"Alt-V", "- next view port"},
  {"Ctrl-V", "- previous view port"},
  {"ENTER", "- write a message"},	
  {"PAUSE", "- pause game"},  
  {"Ctrl-T", "- track unit"}, 
  {"Alt-C", "- center on selected unit"},
  {"^", "- select nothing"},
  {"#", "- select group"},
  {"##", "- center on group"},
  {"Ctrl-#", "- define group"},
  {"Shift-#", "- add to group"},
  {"Alt-#", "- add to alternate group"},  
  {"Alt-G", "- toggle grab mouse"},
  {"Ctrl-S", "- mute sound"},
  {"Ctrl-M", "- mute music"},
  {"Ctrl-P", "- pause game"}, 
  {"F1/Alt-H", "- help menu"},
  {"Alt-R", "- restart scenario"},  
  {"Alt-Q", "- quit to main menu"},
  {"Alt-X", "- quit game"},
  {"Alt-B", "- toggle expand map"},
  {"Alt-M", "- game menu"},
  {"TAB", "- hide/unhide terrain"},
  {"F5", "- game options"},
  {"F7", "- sound options"},
  {"F8", "- speed options"},
  {"F9", "- preferences"},
  {"F10", "- game menu"},
  {"BACKSPACE", "- game menu"},  
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
  "You can select all of your currently visible units of the same type \n \nby holding down the CTRL key and selecting a unit or by \"double clicking\" on a unit.",
  "The more workers you have collecting resources, \n \nthe faster your economy will grow.",
  "If your workers waiting at the gold mine, \n \nsend them to cutting trees, or another mine.",
  "If your gold mine deplete, \n \nsalvage Town Hall and rebuild it close to next gold mine.",
  "If you have just few units, its better to train more troops, \n \nthan spending resources on upgrading existing ones.",
  "Building more than one barracks will let you train more units faster.",
  "Bind barracks to a number, \n \nand quickly train next units, when you have resources.",
  "Use your workers to repair damaged buildings or catapults.",
  "You can use multiple workers to build one building faster, \n \nbut it cost extra resources.",
  "Heal your units using Clerics spell \n \nor place your orcs near Temple.",
  "Explore your surroundings early in the game.\n \nUse Explore command for your first combat units.",
  "Keep all workers working. \n \nPress dot '.' to find idle workers.",
  "You can make units automatically cast spells \n \nSelect caster, hold down CTRL and click on the spell icon.  \n \n CTRL click again to turn off.",

  -- Shift tips
  "You can give an unit an order which is executed after it finishes the current work, \n \nif you hold the SHIFT key.",
  "You can give way points, \n \nif you press the SHIFT key, while you click right for the move command.",
  "You can order a worker to build one building after the other, \n \nif you hold the SHIFT key, while you place the building.",
  "You can build many of the same building, \n \nif you hold the ALT and SHIFT keys while you place the buildings.",

  "Use CTRL-V or ALT-V to cycle through the viewport configuration, \n \nyou can then monitor your base and lead an attack.",

  "Know a useful tip?  \n \nThen add it here!",
}

function RunTipsMenu()
  local menu = WarGameMenu(panel(1))

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
  showtips = menu:addCheckBox("Show tips at startup", 7, menu:getHeight() - 37,
    function()
      preferences.ShowTips = showtips:isMarked()
      SavePreferences()
    end)
  showtips:setMarked(preferences.ShowTips)

  menu:addHalfButton("~!Next Tip", "n", 9, menu:getHeight() - 20,
    function() l:nextTip(); l:updateCaption() end)
  menu:addHalfButton("~!Close", "c", menu:getWidth() - 60 - 9, menu:getHeight() - 20,
    function() l:nextTip(); menu:stop() end)

  menu:run(false)
end

