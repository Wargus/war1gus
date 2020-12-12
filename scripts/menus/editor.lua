--  Menu for new map to edit
local function RunEditorNewMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2
  local tilesets = { "forest", "swamp", "dungeon" }
  local mapSizes = {"32", "64", "96", "128", "256"}

  menu:addLabel("Map description :", offx + 104, offy + 52 + 16 * 0, Fonts["game"], false)
  local mapDescription = menu:addTextInputField("", offx + 104, offy + 52 + 16 * 1, 100)
  menu:addLabel("TileSet : ", offx + 104, offy + 52 + 16 * 2, Fonts["game"], false)
  local dropDownTileset = menu:addDropDown(tilesets, offx + 104 + 30, offy + 52 + 16 * 2, function() end)

  menu:addLabel("Size :", offx + 104, offy + 52 + 16 * 3, Fonts["game"], false)
  local mapSizex = menu:addDropDown(mapSizes, offx + 104 + 25, offy + 52 + 16 * 3, function() end)
  mapSizex:setWidth(25)
  menu:addLabel("x", offx + 104 + 55, offy + 52 + 16 * 3, Fonts["game"], false)
  local mapSizey = menu:addDropDown(mapSizes, offx + 104 + 62, offy + 52 + 16 * 3, function() end)
  mapSizey:setWidth(25)

  menu:addFullButton("~!New map", "n", offx + 96, offy + 52 + 18 * 5,
    function()
      -- TODO : check value
      Map.Info.Description = mapDescription:getText()
      Map.Info.MapWidth = mapSizes[1 + mapSizex:getSelected()]
      Map.Info.MapHeight = mapSizes[1 + mapSizey:getSelected()]
      LoadTileModels("scripts/tilesets/" .. tilesets[1 + dropDownTileset:getSelected()] .. ".lua")
--	  Load("scripts/tilesets/" .. tilesets[1 + dropDownTileset:getSelected()] .. ".lua")
      menu:stop()
      StartEditor(nil)
    end)
  menu:addFullButton("~!Cancel", "c", offx + 96, offy + 52 + 18 * 6, function() menu:stop(1) end)
  return menu:run()
end

-- Menu for loading map to edit
local function RunEditorLoadMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2
  local labelMapName
  local labelDescription
  local labelNbPlayer
  local labelMapSize

  -- update label content
  local function MapChanged()
    labelMapName:setCaption("File      : " .. string.sub(mapname, 6))
    labelMapName:adjustSize()

    labelNbPlayer:setCaption("Players  : " .. mapinfo.nplayers)
    labelNbPlayer:adjustSize()

    labelDescription:setCaption("Scenario : " .. mapinfo.description)
    labelDescription:adjustSize()

    labelMapSize:setCaption("Size      : " .. mapinfo.w .. " x " .. mapinfo.h)
    labelMapSize:adjustSize()
  end

  labelMapName = menu:addLabel("", offx + 104, offy + 52 + 16 * 0, Fonts["game"], false)
  labelDescription = menu:addLabel("", offx + 104, offy + 52 + 16 * 1, Fonts["game"], false)
  labelNbPlayer = menu:addLabel("", offx + 104, offy + 52 + 16 * 2, Fonts["game"], false)
  labelMapSize = menu:addLabel("", offx + 104, offy + 52 + 16 * 3, Fonts["game"], false)

  menu:addFullButton("~!Select map", "s", offx + 96, offy + 52 + 18 * 4,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)

  menu:addFullButton("~!Edit map", "e", offx + 96, offy + 52 + 18 * 5, function() menu:stop(); StartEditor(mapname);  end)
  menu:addFullButton("~!Cancel", "c", offx + 96, offy + 52 + 18 * 6, function() menu:stop(1) end)

  GetMapInfo(mapname)
  MapChanged()
  return menu:run()
end

-- root of the editor menu
function RunEditorMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2

  local buttonNewMap =
  menu:addFullButton("~!New map", "n", offx + 96, offy + 52 + 18*3, function() RunEditorNewMapMenu(); menu:stop() end)
  menu:addFullButton("~!Load map", "l", offx + 96, offy + 52 + 18*4, function() RunEditorLoadMapMenu(); menu:stop() end)
  menu:addFullButton("~!Cancel", "c", offx + 96, offy + 52 + 18*5, function() menu:stop() end)
  return menu:run()
end

--
--  Save map from the editor
--
function RunEditorSaveMenu()
  local menu = WarGameMenu(panel(3))

  menu:resize(192, 128)

  menu:addLabel("Save Game", 96, 5)

  local t = menu:addTextInputField("game.smp",
    (384 - 300 - 18) / 1, 5 + 18, 159)

  local browser = menu:addBrowser("maps", ".smp.gz$",
    (384 - 300 - 18) / 1, 5 + 18 + 11, 159, 63)
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
      -- strip .gz
	  local gz_stripped = false
      if (string.find(name, ".gz$") ~= nil) then
        name = string.sub(name, 1, string.len(name) - 3)
		gz_stripped = true
      end
      -- append .smp
      if (string.find(name, ".smp$") == nil) then
        name = name .. ".smp"
      end
	  if (gz_stripped) then
		name = name .. ".gz"
	  end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      --SaveGame(name)
      EditorSaveMap(browser.path .. name)
      UI.StatusLine:Set("Saved game to: " .. browser.path .. name)
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (192 / 3) - 60 - 5, 128 - 8 - 13,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Load a other map to edit.
--
function RunEditorLoadMenu()
-- TODO : fill this function correctly
--[[
--  RunSelectScenarioMenu()
--  if (buttonStatut == 1) then
--    EditorLoadMap(mapname)
--    StartEditor(mapname)
--  end
--]]
end

--
--  Change player properties from the editor
--
function RunEditorPlayerProperties()
-- TODO : manage edition.
-- TODO : find a correct backgroung menu

  print("RunEditorPlayerProperties")

  local menu = WarGameMenu(nil)
  local sizeX = 250
  local sizeY = 240

  menu:resize(sizeX, sizeY)
  menu:addLabel("Players properties", sizeX / 2, 5)

  local offxPlayer = 7
  local offxType = 35
  local offxRace = 85
  local offxAI = 142
  local offxGold = 187
  local offxLumber = 212

  local types = {"neutral", "nobody", "computer", "person", "rescue-passive", "rescue-active"}
  local racenames = {"human", "orc"}
  local ais = {"wc1-land-attack", "wc1-passive"} -- todo add ai

  menu:addLabel("#", 15, 18)
  menu:addLabel("Type", offxType, 18)
  menu:addLabel("Race", offxRace, 18)
  menu:addLabel("AI", offxAI, 18)
  menu:addLabel("Gold", offxGold, 18)
  menu:addLabel("Wood", offxLumber, 18)

  local playersProp = {nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil}
  for i = 0, 14 do
    local playerLine = {
      type = nil,
      race = nil,
      ai = nil,
      gold = nil,
      wood = nil,
    }
    local offy_i = 18 + 12 * (i + 1)
    local index = i -- use for local function

    local function updateProp(ind)
      local b = (playersProp[1 + ind].type:getSelected() ~= 1) -- != nobody
      playersProp[1 + ind].race:setVisible(b)
      playersProp[1 + ind].ai:setVisible(b)
      playersProp[1 + ind].gold:setVisible(b)
      playersProp[1 + ind].wood:setVisible(b)
    end

    playersProp[1 + i] = playerLine

    menu:addLabel("p" .. (i + 1), offxPlayer, offy_i)

    playersProp[1 + i].type = menu:addDropDown(types, offxType - 20, offy_i, function() updateProp(index) end)
    playersProp[1 + i].type:setSelected(Map.Info.PlayerType[i] - 2)
    playersProp[1 + i].type:setWidth(57)

    playersProp[1 + i].race = menu:addDropDown(racenames, offxRace - 10, offy_i, function() end)
    playersProp[1 + i].race:setSelected(Players[i].Race)
    playersProp[1 + i].race:setWidth(65/ 2)

    playersProp[1 + i].ai = menu:addDropDown(ais, offxAI - 32, offy_i, function() end)
    for j = 0,3 do
      if (ais[1 + j] == Players[i].AiName) then playersProp[1 + i].ai:setSelected(j) end
    end
    playersProp[1 + i].ai:setWidth(65)

    playersProp[1 + i].gold = menu:addTextInputField(Players[i].Resources[1], offxGold - 10, offy_i, 20)
    playersProp[1 + i].wood = menu:addTextInputField(Players[i].Resources[2], offxLumber - 10, offy_i, 20)
    updateProp(i)
  end

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 4) - 60 - 5, sizeY - 8 - 13,
    function()
       for i = 0, 14 do
        Map.Info.PlayerType[i] = playersProp[1 + i].type:getSelected() + 2
		Players[i].Type = playersProp[1 + i].type:getSelected() + 2
        Players[i].Race = playersProp[1 + i].race:getSelected()
        Players[i].AiName = ais[1 + playersProp[1 + i].ai:getSelected()]
        Players[i].Resources[1] = playersProp[1 + i].gold:getText()
        Players[i].Resources[2] = playersProp[1 + i].wood:getText()
      end
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (sizeX / 4) - 60 - 5, sizeY - 8 - 13, function() menu:stop() end)

  menu:run(false)
end

--
--  Change player properties from the editor
--
function RunEditorMapProperties()
print("RunEditorMapProperties")
-- TODO : manage edition of all properties.
  local menu = WarGameMenu(--[[panel(3)]])

  local sizeX = 192
  local sizeY = 128

  menu:resize(sizeX, sizeY)
  menu:addLabel("Map properties", sizeX / 2, 5)

  menu:addLabel("Map descritption : ", 22, 5 + 18, nil, false)
  local desc = menu:addTextInputField(Map.Info.Description, 7, 18 * 2, 175)

  menu:addLabel("Size    : " .. Map.Info.MapWidth .. " x " .. Map.Info.MapHeight, 22, 18 * 3, nil, false)
--  menu:addLabel("Size : ", 15, 36 * 3, nil, false)
--  local sizeX = menu:addTextInputField(Map.Info.MapWidth, 75, 36 * 3, 50)
--  menu:addLabel(" x ", 130, 36 * 3, nil, false)
--  local sizeY = menu:addTextInputField(Map.Info.MapHeight, 160, 36 * 3, 50)

  menu:addLabel("Tileset : ", 22, 18 * 4, nil, false)

  local list = { "Forest", "Swamp", "Dungeon"}
  local dropDownTileset = menu:addDropDown(list, 65, 18 * 4, function() end)
  for i = 0,3 do
    if (list[1 + i] == Map.Tileset.Name) then dropDownTileset:setSelected(i)
    end
  end
  dropDownTileset:setEnabled(false) -- TODO : manage this properties

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 3) - 60 - 5, sizeY - 8 - 13,
    function()
      Map.Info.Description = desc:getText()
      -- TODO : Add others properties
      menu:stop()
    end
    )

  menu:addHalfButton("~!Cancel", "c", 3 * (sizeX / 3) - 60 - 5, sizeY - 8 - 13,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Main menu in editor.
--
function RunInEditorMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Editor Menu", 64, 5)

  menu:addHalfButton("Save (~<F11~>)", "f11", 12, 20, RunEditorSaveMenu)
  local buttonEditorLoad = -- To be removed when enabled.
  menu:addHalfButton("Load (~<F12~>)", "f12", 12 + 63, 20, RunEditorLoadMenu)
  menu:addFullButton("Map Properties (~<F5~>)", "f5", 12, 20 + 18 * 1, RunEditorMapProperties)
  menu:addFullButton("Player Properties (~<F6~>)", "f6", 12, 20 + 18 * 2, RunEditorPlayerProperties)

  buttonEditorLoad:setEnabled(false) -- To be removed when enabled.

  menu:addFullButton(
     "E~!xit to Menu", "x", 12, 20 + 18 * 4,
     function()
	Load("scripts/ui.lua")
	Editor.Running = EditorNotRunning;
	menu:stopAll();
     end
  )
  menu:addFullButton("Return to Editor (~<Esc~>)", "escape", 12, 144 - 30, function() menu:stop() end)

  menu:run(false)
end

--
--  Function to edit unit properties in Editor
--
function EditUnitProperties()

  if (GetUnitUnderCursor() == nil) then
    return;
  end
  local menu = WarGameMenu(panel(1))
  local sizeX = 128
  local sizeY = 100 -- 288
  
  menu:resize(sizeX, sizeY)
  menu:addLabel("Unit properties", sizeX / 2, 5)
  
  if (GetUnitUnderCursor().Type.GivesResource == 0) then
    menu:addLabel("Artificial Intelligence", sizeX / 2, 5 + 18)
    local activeCheckBox = menu:addCheckBox("Active", 7, 5 + 36)
    activeCheckBox:setMarked(GetUnitUnderCursor().Active)

    menu:addHalfButton("~!Ok", "o", 7, sizeY - 20,
      function() GetUnitUnderCursor().Active = activeCheckBox:isMarked();  menu:stop() end)
  else
    local resourceName = {"gold", "wood"}
    local resource = GetUnitUnderCursor().Type.GivesResource - 1
    menu:addLabel("Amount of " .. resourceName[1 + resource] .. " :", 12, 5 + 18, nil, false)
	local resourceValue = menu:addTextInputField(GetUnitUnderCursor().ResourcesHeld, sizeX / 2 - 15, 5 + 18 * 2, 30)

    menu:addHalfButton("~!Ok", "o", 7, sizeY - 20,
      function() GetUnitUnderCursor().ResourcesHeld = resourceValue:getText();  menu:stop() end)
  end
  menu:addHalfButton("~!Cancel", "c", 62, sizeY - 20,
    function() menu:stop() end)
  menu:run(false)
end
