--      (c) Copyright 2010      by Pali Rohár

function AddSoundOptions(menu, offx, offy, centerx, bottom)
  local b

  local titleLabel = Label("Sound Options")
  b = menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)

  local makeSlider = function(getvalue, setvalue, isenabled, setenabled, title, offstart)
     local b = Label(title)
     b:setFont(CFont:Get("game"))
     b:adjustSize();
     menu:add(b, 8, offy + 18 * offstart)

     local slider = Slider(0, 127)
     slider:setValue(getvalue())
     slider:setActionCallback(function() setvalue(slider:getValue()) end)
     slider:setWidth(99)
     slider:setHeight(9)
     slider:setBaseColor(dark)
     slider:setForegroundColor(clear)
     slider:setBackgroundColor(clear)

     local effectscheckbox = {}
     effectscheckbox = menu:addCheckBox(
	"Enabled",
	offx + 8, offy + 18 * (offstart + 0.5),
	function()
	   slider:setEnabled(effectscheckbox:isMarked())
	   setenabled(effectscheckbox:isMarked())
	end
     )
     effectscheckbox:setMarked(isenabled())
     effectscheckbox:adjustSize()
     menu:add(slider, offx + 10, offy + 18 * (offstart + 1))
     
     b = Label("min")
     b:setFont(CFont:Get("game"))
     b:adjustSize();
     menu:addCentered(b, offx + 22, offy + 18 * (offstart + 1.5) + 3)
     
     b = Label("max")
     b:setFont(CFont:Get("game"))
     b:adjustSize();
     menu:addCentered(b, offx + 109, offy + 18 * (offstart + 1.5) + 3)
  end


  makeSlider(
     GetEffectsVolume,
     SetEffectsVolume,
     IsEffectsEnabled,
     SetEffectsEnabled,
     "Sounds",
     1)
  makeSlider(
     GetMusicVolume,
     SetMusicVolume,
     IsMusicEnabled,
     function (bool)
	SetMusicEnabled(bool)
	MusicStopped()
     end,
     "Music",
     3.2)
 
  b = menu:addFullButton("~!OK", "o", centerx, menu:getHeight() - 8 - 13,
    function()
      preferences.EffectsVolume = GetEffectsVolume()
      preferences.EffectsEnabled = IsEffectsEnabled()
      preferences.MusicVolume = GetMusicVolume()
      preferences.MusicEnabled = IsMusicEnabled()
      SavePreferences()
      menu:stop()
    end)
end

function RunGameSoundOptionsMenu()
  local menu = WarGameMenu(panel(1))

  AddSoundOptions(menu, 14, 0, 12, 136)

  if (GameCycle > 0) then
    menu:run(false)
  else
    menu:run()
  end
end

function RunPreferencesMenu()
  local menu = WarGameMenu(panel(1), 152, 180)
 
  menu:addFullButton("~!OK", "o", 12, menu:getHeight() - 8 - 13,
    function()
      preferences.FogOfWar = GetFogOfWar()
      preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
      preferences.GameSpeed = GetGameSpeed()
      SavePreferences()
      menu:stop()
    end)
    
  local titleLabel = Label("Preferences")
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)

  -- fog of war
  local fog = {}
  fog = menu:addCheckBox("Fog of War", 8, 20 + 18 * 0,
    function()
	  SetFogOfWar(fog:isMarked())
	  preferences.FogOfWar = fog:isMarked()
	  SavePreferences()
	end)
  fog:setMarked(GetFogOfWar())
  if (IsReplayGame() or IsNetworkGame()) then
    fog:setEnabled(false)
  end

  -- Command keys
  local ckey = {}
  ckey = menu:addCheckBox("Show cmd keys", menu:getWidth() / 2, 20 + 18 * 0,
    function() UI.ButtonPanel.ShowCommandKey = ckey:isMarked() end)
  ckey:setMarked(UI.ButtonPanel.ShowCommandKey)

  if GameCycle == 0 then
    b = menu:addCheckBox("Allow multiple Town Halls", 8, 20 + 18 * 0.5,
      function()
        preferences.AllowMultipleTownHalls = not preferences.AllowMultipleTownHalls
        Load("scripts/buttons.lua")
        Load("scripts/buildings.lua")
        SavePreferences()
      end)
    b:setMarked(preferences.AllowMultipleTownHalls)

    b = menu:addCheckBox("Use simplified color scheme", 8, 20 + 18 * 1.0,
      function()
      preferences.MultiColoredCampaigns = not preferences.MultiColoredCampaigns
      SetColorScheme()
      SavePreferences()
    end)
    b:setMarked(not preferences.MultiColoredCampaigns)

    b = menu:addCheckBox("Rebalanced Unit Stats", 8, 20 + 18 * 1.5,
      function()
        if preferences.RebalancedStats then
          preferences.RebalancedStats = false
          local menu = WarMenu(nil, panel(4), false)
          menu:setSize(144, 64)
          menu:setPosition((Video.Width - 144) / 2, (Video.Height - 64) / 2)
          menu:setDrawMenusUnder(true)
          local l = MultiLineLabel("You must restart the game to change to original game stats.")
          l:setFont(Fonts["large"])
          l:setAlignment(MultiLineLabel.CENTER)
          l:setVerticalAlignment(MultiLineLabel.CENTER)
          l:setLineWidth(135)
          l:setWidth(135)
          l:setHeight(20)
          l:setBackgroundColor(dark)
          menu:add(l, 4, 19)
          menu:addHalfButton("~!OK", "o", 41, 40, function() menu:stop() end)
          menu:run()
        else
          Load("scripts/balancing.lua")
          preferences.RebalancedStats = true
        end
        SavePreferences()
      end)
    b:setMarked(preferences.RebalancedStats)
  else
    menu:addLabel("Game Speed", 8, 20 + 18 * 0.5, Fonts["game"], false)
    local gamespeed = {}
    gamespeed = menu:addSlider(15, 75, menu:getWidth() - 16 * 2, 9, 16, 20 + 18 * 1.0,
      function() SetGameSpeed(gamespeed:getValue()) end)
    gamespeed:setValue(GetGameSpeed())
    menu:addLabel("slow", 17, 20 + (18 * 1.5), Fonts["small"], false)
    local l = Label("fast")
    l:setFont(Fonts["small"])
    l:adjustSize()
    menu:add(l, menu:getWidth() - l:getWidth() - 17, 20 + (18 * 1.5))
  end

  local b = menu:addCheckBox("Fullscreen", 8, 20 + 18 * 2.0,
    function()
      ToggleFullScreen()
      preferences.VideoFullScreen = Video.FullScreen
    end)
  b:setMarked(Video.FullScreen)

  b = menu:addCheckBox("Show Orders", menu:getWidth() / 2, 20 + 18 * 2.0,
    function()
       preferences.ShowOrders = not preferences.ShowOrders
       if preferences.ShowOrders then
          Preference.ShowOrders = 1
       else
          Preference.ShowOrders = 0
       end
       SavePreferences()
    end)
  b:setMarked(preferences.ShowOrders)

  if GameCycle == 0 then
    b = menu:addCheckBox("Train Queue", 8, 20 + 18 * 2.5,
      function()
      preferences.TrainingQueue = not preferences.TrainingQueue
      SetTrainingQueue(not not preferences.TrainingQueue)
        SavePreferences()
      end)
    b:setMarked(preferences.TrainingQueue)
  end

  b = menu:addCheckBox("Show Damage", menu:getWidth() / 2, 20 + 18 * 2.5,
    function()
       preferences.ShowDamage = not preferences.ShowDamage
       if preferences.ShowDamage then
          SetDamageMissile("missile-hit")
       else
          SetDamageMissile(nil)
       end
       SavePreferences()
    end)
  b:setMarked(preferences.ShowOrders)

  local simplifiedAutoTargeting
  if (not IsNetworkGame()) then
     simplifiedAutoTargeting = menu:addCheckBox(_("Simplified auto targeting"), 8, 20 + 18 * 3.0 + 5, function()end)
     simplifiedAutoTargeting:setMarked(Preference.SimplifiedAutoTargeting)
     simplifiedAutoTargeting:setActionCallback(
       function()
          Preference.SimplifiedAutoTargeting = simplifiedAutoTargeting:isMarked()
          preferences.SimplifiedAutoTargeting = Preference.SimplifiedAutoTargeting
          SavePreferences()
     end)
  end

  local sightBlocking = menu:addCheckBox(_("Block sight in dungeons"), 8, 20 + 18 * 3.5 + 5, function()end)
  sightBlocking:setMarked(preferences.DungeonSightBlocking)
  sightBlocking:setActionCallback(
    function()
        preferences.DungeonSightBlocking = sightBlocking:isMarked()
        if GameSettings.Inside then
          if preferences.DungeonSightBlocking then
            SetFieldOfViewType("shadow-casting")
          else
            SetFieldOfViewType("simple-radial")
          end
        end
        SavePreferences()
  end)

  menu:addLabel("Fog of war type:", 8, 20 + 18 * 4.5, Fonts["game"], false)
  local fogOfWarTypes    = {"tiled", "enhanced", "fast"}
  local fogOfWarTypeList = {_("tiled"), _("enhanced"), _("fast")}
  local fogOfWarType = menu:addDropDown(fogOfWarTypeList, 8, 20 + 18 * 5.0, function(dd)end)
  fogOfWarType:setSelected(GetFogOfWarType())
  fogOfWarType:setActionCallback(
    function()
      preferences.FogOfWarType = fogOfWarTypes[fogOfWarType:getSelected() + 1]
      SetFogOfWarType(preferences.FogOfWarType)
      if (preferences.FogOfWarType ~= "enhanced" and GameSettings.Inside) then -- tiled and fast fog don't work with shadow caster fov
        preferences.DungeonSightBlocking = false;
        sightBlocking:setMarked(preferences.DungeonSightBlocking)
      end
      SavePreferences()
  end)
  fogOfWarType:setSize(60, fogOfWarType:getHeight())

  local fowBilinear = menu:addCheckBox(_("Bilinear int."), menu:getWidth() / 2, 20 + 18 * 5.0, function()end)
  fowBilinear:setMarked(GetIsFogOfWarBilinear())
  fowBilinear:setActionCallback(
    function()
        preferences.FogOfWarBilinear = fowBilinear:isMarked()
        SetFogOfWarBilinear(preferences.FogOfWarBilinear)
        SavePreferences()
  end)

  menu:addLabel("Max Selection", 8, 20 + 18 * 6.0, Fonts["game"], false)
  local maxselections = {"4 (WC1 default)", "9", "12", "18", "50"}
  maxselection = menu:addDropDown(maxselections, 8, 20 + 18 * 6.5,
    function(dd)
	  local selected = maxselections[maxselection:getSelected() + 1]
	  local count = tonumber(string.gmatch(selected, "%d+")())
	  preferences.MaxSelection = count
	  SavePreferences()
	  SetMaxSelectable(count)
	end)
  for idx,str in ipairs(maxselections) do
    local count = tonumber(string.gmatch(str, "%d+")())
  	if preferences.MaxSelection == count then
  	  maxselection:setSelected(idx - 1)
  	  break
  	end
  end
  maxselection:setSize(60, maxselection:getHeight())

  if GetShaderNames then
    local shaderNames = GetShaderNames()
    if #shaderNames > 0 then
       menu:addLabel(_("Shader"), menu:getWidth() / 2 + 5, 20 + 18 * 6.0, Fonts["game"], false)
       local shaderName = menu:addDropDown(shaderNames, 8 + 75, 20 + 18 * 6.5, function(dd) end)
       local function getCurrentShaderIndex()
          local currentShader = GetShader()
          for idx,name in pairs(shaderNames) do
             if name == currentShader then
                return idx
             end
          end
       end
       shaderName:setSelected(getCurrentShaderIndex() - 1)
       shaderName:setActionCallback(function()
             local newShader = shaderNames[shaderName:getSelected() + 1];
             if SetShader(newShader) then
                Preference.VideoShader = newShader
                wc1.preferences.VideoShader = newShader
             end
       end)
       shaderName:setSize(60, shaderName:getHeight())
    end
  end



  if (GameCycle > 0) then
    menu:run(false)
  else
    menu:run()
  end
end

function SetVideoSize(width, height)
  if (Video:ResizeScreen(width, height) == false) then
    return
  end
  bckground:Resize(Video.Width, Video.Height)
  backgroundWidget = ImageWidget(bckground)
  Load("scripts/ui.lua")
  preferences.VideoWidth = Video.Width
  preferences.VideoHeight = Video.Height
  SavePreferences()
end

function BuildVideoOptionsMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 176) / 2
  local offy = (Video.Height - 176) / 2
  local checkTexture
  local b
  local resolution
  local maxselection
  local top = 70

  menu:addLabel("Video Resolution", offx, offy + top, Fonts["game"], false)
  local resolutions = {
     "320x200 (1x)",
     "400x250 (1.25x)",
     "480x300 (1.5x)",
     "640x400 (2x)",
     "800x500 (2.5x)",
     "960x600 (3x)",
     "1280x800 (4x)",
     "480x270 (1.5x wide)",
     "640x360 (2x wide)",
     "960x540 (3x wide)"
  }
  resolution = menu:addDropDown(resolutions, offx + 125, offy + top,
    function(dd)
    local selected = resolutions[resolution:getSelected() + 1]
    for x, y in string.gmatch(selected, "(%d+)x(%d+)") do
      SetVideoSize(tonumber(x), tonumber(y))
    end
    menu:stop()
    RunVideoOptionsMenu()
	end)
  for idx,str in ipairs(resolutions) do
    local found = false
    for x, y in string.gmatch(str, "(%d+)x(%d+)") do
      if Video.Width == tonumber(x) and Video.Height == tonumber(y) then
        resolution:setSelected(idx - 1)
        found = true
        break
      end
    end
    if found then
      break
    end
  end

  menu:addHalfButton("~!OK", "o", Video.Width / 2 - 20, offy + top + 100,
    function()
	  menu:stop()
	end)
  return menu:run()
end

function RunVideoOptionsMenu()
  BuildVideoOptionsMenu()
end

function RunGameOptionsMenu()
  local menu = WarGameMenu(panel(1))
  menu:setDrawMenusUnder(true)
  
  local titleLabel = Label("Game Options")
  menu:add(titleLabel, menu:getWidth() / 2 - titleLabel:getWidth() / 2, 5)
  menu:addFullButton("Sound (~<F7~>)", "f7", 12, 20 + 18*0,
    function() RunGameSoundOptionsMenu() end)
  menu:addFullButton("Preferences (~<F8~>)", "f8", 12, 20 + 18*1,
    function()
      RunPreferencesMenu()
    end)
  if (GameCycle > 0) then
    menu:addFullButton("Diplomacy (~<F9~>)", "f9", 12, 20 + 18*2,
      function() RunDiplomacyMenu() end)
  else
    menu:addFullButton(_("Video (~<F9~>)"), "f9", 12, 20 + 18*2,
      function() RunVideoOptionsMenu(); menu:stopAll(1) end)
  end  
  menu:addFullButton("Previous (~<Esc~>)", "escape", 12, 144 - 30,
    function() menu:stop() end)

  if (GameCycle > 0) then
    menu:run(false)
  else
    menu:run()
  end
end

function RunOptionsSubMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2

  menu:addFullButton("Sound (~<F7~>)", "f7", offx + 96, offy + 52 + 18*2,
    function() RunGameSoundOptionsMenu() end)
  menu:addFullButton("Preferences (~<F8~>)", "f8", offx + 96, offy + 52 + 18*3,
    function() RunPreferencesMenu() end)
  menu:addFullButton("Video (~<F9~>)", "f9", offx + 96, offy + 52 + 18*4,
    function() RunVideoOptionsMenu() end)
  
  menu:addFullButton("~!Previous Menu", "p", offx + 96, offy + 52 + 18*7,
    function() menu:stop() end)

  return menu:run()
end