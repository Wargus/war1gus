function RunReplayGameMenu()
  local menu = WarMenu(nil, panel(1), {176, 176})
  menu:setDrawMenusUnder(true)

  menu:addLabel("Select Game", 88, 5)

  local browser = menu:addBrowser("~logs/", "%.log%.?g?z?$",
    (176 - 9 - 144) / 2, 5 + 49, 153, 54)

  local reveal = menu:addCheckBox("Reveal Map", 11, 132, function() end)

  menu:addHalfButton("~!OK", "o", 19, 154,
    function()
      if (browser:getSelected() < 0) then
        return
      end
      war1gus.InCampaign = false
      InitGameVariables()
      local OldReplayLog = ReplayLog
      function ReplayLog(tbl)
         local MapRichness = tbl.MapRichness
         RestoreSharedSettingsFromBits(MapRichness, function(msg)
          print(msg)
          menu:stop()
         end)
         return OldReplayLog(tbl)
      end
      StartReplay("~logs/" .. browser:getSelectedItem(), reveal:isMarked())
      ReplayLog = OldReplayLog
      InitGameSettings()
      SetPlayerData(GetThisPlayer(), "RaceName", "orc")
      menu:stop()
    end)
  menu:addHalfButton("~!Cancel", "c", 94, 154, function() RunSinglePlayerSubMenu(); menu:stop() end)

  menu:run()
end

function RunSaveReplayMenu()
  local menu = WarGameMenu(panel(1), 192, 128)

--  menu:setPosition((Video.Width - 192) / 2, (Video.Height - 128) / 2)
  local titleLabel = Label("Save Replay")
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)
  
  local t = menu:addTextInputField("game.log",
    (192 - 150 - 9) / 2, 5 + 18, 159)

  local browser = menu:addBrowser("~logs", ".log$",
    (192 - 150 - 9) / 2, 5 + 18 + 11, 159, 63)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (192 / 3) - 60 - 5, 128 - 8 - 13,
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

  menu:addHalfButton("~!Cancel", "c", 3 * (192 / 3) - 60 - 5, 128 - 8 - 13,
    function() menu:stop() end)

  menu:run()
end
