function RunReplayGameMenu()
  local menu = WarMenu(nil, panel(5), false)
  menu:setSize(352 / 2, 352 / 2)
  menu:setPosition((Video.Width - 352 / 2) / 2, (Video.Height - 352 / 2) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Select Game", 352 / 2 / 2, 11 / 2)

  local browser = menu:addBrowser("~logs/", "%.log%.?g?z?$",
    (352 / 2 - 18 / 2 - 288 / 2) / 2, 11 / 2 + 98 / 2, 306 / 2, 108 / 2)

  local reveal = menu:addCheckBox("Reveal Map", 23 / 2, 264 / 2, function() end)

  menu:addHalfButton("~!OK", "o", 39 / 2, 308 / 2,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      InitGameVariables()
      StartReplay("~logs/" .. browser:getSelectedItem(), reveal:isMarked())
      InitGameSettings()
      SetPlayerData(GetThisPlayer(), "RaceName", "orc")
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", 189, 308, function() RunSinglePlayerSubMenu(); menu:stop() end)

  menu:run()
end

function RunSaveReplayMenu()
  local menu = WarGameMenu(panel(3))
  menu:setSize(384 / 2, 256 / 2)
  menu:setPosition((Video.Width - 384 / 2) / 2, (Video.Height - 256 / 2) / 2)

  menu:addLabel("Save Replay", 384 / 2 / 2, 11 / 2)

  local t = menu:addTextInputField("game.log",
    (384 / 2 - 300 / 2 - 18 / 2) / 2, 11 / 2 + 36 / 2, 318 / 2)

  local browser = menu:addBrowser("~logs", ".log$",
    (384 / 2 - 300 / 2 - 18 / 2) / 2, 11 / 2 + 36 / 2 + 22 / 2, 318 / 2, 126 / 2)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (384 / 2 / 3) - 121 / 2 - 10 / 2, 256 / 2 - 16 / 2 - 27 / 2,
    -- FIXME: use a confirm menu if the file exists already
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- append .log
      if (string.find(name, ".log$") == nil) then
        name = name .. ".log"
      end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      SaveReplay(name)
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (384 / 2 / 3) - 121 / 2 - 10 / 2, 256 / 2 - 16 / 2 - 27 / 2,
    function() menu:stop() end)

  menu:run()
end
