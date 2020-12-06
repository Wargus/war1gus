function RunConfirmErase(name,menu)
  local confirm = WarGameMenu(panel(3))

  confirm:resize(150,60)

  confirm:addLabel(name, 75, 5)
  confirm:addLabel("File exists, are you sure ?", 75, 15)

  confirm:addHalfButton("~!Yes", "y", 1 * (150 / 3) - 49, 60 - 8 - 13,
    function()
        SaveGame(name)
        UI.StatusLine:Set("Saved game to: " .. name)
        confirm:stop()
        menu:stop()
    end)

  confirm:addHalfButton("~!No", "n", 3 * (150 / 3) - 60 - 5, 60 - 8 - 13,
    function() confirm:stop() end)

  confirm:run(false)
end

function RunSaveMenu()
  local menu = WarGameMenu(panel(3))
  menu:resize(192, 128)

  menu:addLabel("Save Game", 96, 5)

  local t = menu:addTextInputField("game.sav",
    (192 - 150 - 9) / 2, 5 + 18, 159)

  local browser = menu:addBrowser("~save", ".sav.gz$",
    (192 - 150 - 9) / 2, 5 + 18 + 11, 159, 63)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (192 / 3) - 60 - 5, 128 - 8 - 13,
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

  menu:addHalfButton("~!Cancel", "c", 3 * (192 / 3) - 60 - 5, 128 - 8 - 13,
    function() menu:stop() end)

  menu:run(false)
end

