function RunConfirmErase(name,menu)
  local confirm = WarGameMenu(panel(3))

  confirm:resize(300 / 2,120 / 2)

  confirm:addLabel(name, 300 / 2 / 2, 11 / 2)
  confirm:addLabel("File exists, are you sure ?", 300 / 2 / 2, 31 / 2)

  confirm:addHalfButton("~!Yes", "y", 1 * (300 / 2 / 3) - 99 / 2, 120 / 2 - 16 / 2 - 27 / 2,
    function()
        SaveGame(name)
        UI.StatusLine:Set("Saved game to: " .. name)
        confirm:stop()
        menu:stop()
    end)

  confirm:addHalfButton("~!No", "n", 3 * (300 / 2 / 3) - 121 / 2 - 10 / 2, 120 / 2 - 16 / 2 - 27 / 2,
    function() confirm:stop() end)

  confirm:run(false)
end

function RunSaveMenu()
  local menu = WarGameMenu(panel(3))
  menu:resize(384 / 2, 256 / 2)

  menu:addLabel("Save Game", 384 / 2 / 2, 11 / 2)

  local t = menu:addTextInputField("game.sav",
    (384 / 2 - 300 / 2 - 18 / 2) / 2, 11 / 2 + 36 / 2, 318 / 2)

  local browser = menu:addBrowser("~save", ".sav.gz$",
    (384 / 2 - 300 / 2 - 18 / 2) / 2, 11 / 2 + 36 / 2 + 22 / 2, 318 / 2, 126 / 2)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (384 / 2 / 3) - 121 / 2 - 10 / 2, 256 / 2 - 16 / 2 - 27 / 2,
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

  menu:addHalfButton("~!Cancel", "c", 3 * (384 / 2 / 3) - 121 / 2 - 10 / 2, 256 / 2 - 16 / 2 - 27 / 2,
    function() menu:stop() end)

  menu:run(false)
end

