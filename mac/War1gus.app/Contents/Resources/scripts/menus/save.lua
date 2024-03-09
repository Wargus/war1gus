function RunConfirmErase(name,menu)
  local confirm = WarGameMenu(panel(2), 150, 60)

  confirm:addLabel(name, 75, 5)
  confirm:addLabel("File exists, are you sure ?", 75, 15)

  confirm:addHalfButton("~!Yes", "y", 9, confirm:getHeight() - 8 - 13,
    function()
        SaveGame(name)
        UI.StatusLine:Set("Saved game to: " .. name)
        confirm:stop()
        menu:stop()
    end)

  confirm:addHalfButton("~!No", "n", confirm:getWidth() - 60 - 9, confirm:getHeight() - 8 - 13,
    function() confirm:stop() end)

  confirm:run(false)
end

function RunSaveMenu()
  local menu = WarGameMenu(panel(1), 192, 128)
  
  local titleLabel = Label("Save Game")
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)

  local t = menu:addTextInputField("game.sav",
    (menu:getWidth() - 150 - 9) / 2, 5 + 18, 159)

  local browser = menu:addBrowser("~save", ".sav.gz$",
    (menu:getWidth() - 150 - 9) / 2, 5 + 18 + 11, 159, 63)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 9, menu:getHeight() - 8 - 13,
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- strip .gz
      if (string.find(name, ".gz$") ~= nil) then
        name = string.sub(name, 1, string.len(name) - 3)
      end
      -- append .sav
      if (string.find(name, ".sav$") == nil) then
        name = name .. ".sav"
      end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)
      
      if (browser:exists(name .. ".gz")) then
          RunConfirmErase(name,menu)
      else
        SaveGame(name)
        UI.StatusLine:Set("Saved game to: " .. name)
        menu:stop()
      end
    end)
  
  menu:addHalfButton("~!Cancel", "c", menu:getWidth() - 60 - 9, menu:getHeight() - 8 - 13,
    function() menu:stop() end)

  menu:run(false)
end

