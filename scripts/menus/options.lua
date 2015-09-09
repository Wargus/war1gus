--      (c) Copyright 2010      by Pali Rohár

function AddSoundOptions(menu, offx, offy, centerx, bottom)
  local b

  b = menu:addLabel("Sound Options", 176, 11)

  b = Label("Effects Volume")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:add(b, offx + 16, offy + 36 * 1)

  -- FIXME: disable if effects turned off
  local soundslider = Slider(0, 255)
  soundslider:setValue(GetEffectsVolume())
  soundslider:setActionCallback(function() SetEffectsVolume(soundslider:getValue()) end)
  soundslider:setWidth(198)
  soundslider:setHeight(18)
  soundslider:setBaseColor(dark)
  soundslider:setForegroundColor(clear)
  soundslider:setBackgroundColor(clear)
  menu:add(soundslider, offx + 32, offy + 36 * 1.5)

  b = Label("min")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 44, offy + 36 * 2 + 6)

  b = Label("max")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 218, offy + 36 * 2 + 6)

  local effectscheckbox = {}
  effectscheckbox = menu:addCheckBox("Enabled", offx + 240, offy + 36 * 1.5,
    function() SetEffectsEnabled(effectscheckbox:isMarked()) end)
  effectscheckbox:setMarked(IsEffectsEnabled())
  effectscheckbox:adjustSize()

  b = Label("Music Volume")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:add(b, offx + 16, offy + 36 * 3)

  -- FIXME: disable if music turned off
  local musicslider = Slider(0, 255)
  musicslider:setValue(GetMusicVolume())
  musicslider:setActionCallback(function() SetMusicVolume(musicslider:getValue()) end)
  musicslider:setWidth(198)
  musicslider:setHeight(18)
  musicslider:setBaseColor(dark)
  musicslider:setForegroundColor(clear)
  musicslider:setBackgroundColor(clear)
  menu:add(musicslider, offx + 32, offy + 36 * 3.5)

  b = Label("min")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 44, offy + 36 * 4 + 6)

  b = Label("max")
  b:setFont(CFont:Get("game"))
  b:adjustSize();
  menu:addCentered(b, offx + 218, offy + 36 * 4 + 6)

  local musiccheckbox = {}
  musiccheckbox = menu:addCheckBox("Enabled", offx + 240, offy + 36 * 3.5,
    function() SetMusicEnabled(musiccheckbox:isMarked()); MusicStopped() end)
  musiccheckbox:setMarked(IsMusicEnabled())
  musiccheckbox:adjustSize();

  b = menu:addFullButton("~!OK", "o", centerx, bottom - 11 - 27,
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
  local menu = WarGameMenu(panel(5))
  menu:resize(352, 352)

  AddSoundOptions(menu, 0, 0, 352/2 - 254/2, 352)

  menu:run(false)
end

function RunPreferencesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Preferences", 128, 11)

  local fog = {}
  fog = menu:addCheckBox("Fog of War", 16, 40 + 36 * 0,
    function()
	  SetFogOfWar(fog:isMarked())
	  preferences.FogOfWar = fog:isMarked()
	  SavePreferences()
	end)
  fog:setMarked(GetFogOfWar())
  if (IsReplayGame() or IsNetworkGame()) then
    fog:setEnabled(false)
  end

  local ckey = {}
  ckey = menu:addCheckBox("Show command key", 16, 40 + 36 * 1,
    function() UI.ButtonPanel.ShowCommandKey = ckey:isMarked() end)
  ckey:setMarked(UI.ButtonPanel.ShowCommandKey)

  menu:addLabel("Game Speed", 16, 40 + 36 * 2, Fonts["game"], false)

  local gamespeed = {}
  gamespeed = menu:addSlider(15, 75, 198, 18, 32, 40 + 36 * 2.5,
    function() SetGameSpeed(gamespeed:getValue()) end)
  gamespeed:setValue(GetGameSpeed())

  menu:addLabel("slow", 34, 40 + (36 * 3) + 6, Fonts["small"], false)
  local l = Label("fast")
  l:setFont(Fonts["small"])
  l:adjustSize()
  menu:add(l, 230 - l:getWidth(), 40 + (36 * 3) + 6)

  menu:addFullButton("~!OK", "o", 25, 288 - 60,
    function()
      preferences.FogOfWar = GetFogOfWar()
      preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
      preferences.GameSpeed = GetGameSpeed()
      SavePreferences()
      menu:stop()
    end)

  menu:run(false)
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

function BuildOptionsMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 352) / 2
  local offy = (Video.Height - 352) / 2
  local checkTexture
  local b
  local resolution
  local maxselection
  local top = 140 * Video.Height / 400

  menu:addLabel("Video Resolution", offx + 16, offy + top, Fonts["game"], false)
  local resolutions = {"640x400", "800x480", "1024x640", "1280x800", "1440x900", "1680x1050"}
  resolution = menu:addDropDown(resolutions, offx + 16 + 250, offy + top,
    function(dd)
	  local selected = resolutions[resolution:getSelected() + 1]
	  local x = tonumber(string.gmatch(selected, "%d+")())
	  local y = tonumber(string.gmatch(selected, "%d+$")())
	  SetVideoSize(x, y)
	  menu:stop()
	  RunOptionsMenu()
	end)
  for idx,str in ipairs(resolutions) do
    local x = tonumber(string.gmatch(str, "%d+")())
	local y = tonumber(string.gmatch(str, "%d+$")())
	if Video.Width == x and Video.Height == y then
	  resolution:setSelected(idx - 1)
	  break
	end
  end

  b = menu:addCheckBox("Full Screen", offx + 16, offy + top + 15,
    function()
      ToggleFullScreen()
      preferences.VideoFullScreen = Video.FullScreen
      SavePreferences()
      menu:stop(1)
    end)
  b:setMarked(Video.FullScreen)

  checkTexture = menu:addCheckBox("Set Maximum OpenGL Texture to 256", offx + 16, offy + top + 15 * 2,
    function()
      if (checkTexture:isMarked()) then
        preferences.MaxOpenGLTexture = 256
      else
        preferences.MaxOpenGLTexture = 0
      end
      SetMaxOpenGLTexture(preferences.MaxOpenGLTexture)
      SavePreferences()
    end)
  if (preferences.MaxOpenGLTexture == 128) then checkTexture:setMarked(true) end

  checkOpenGL = menu:addCheckBox("OpenGL / OpenGL ES 1.1 (restart required)", offx + 16, offy + top + 15 * 3,
    function()
--TODO: Add function for immediately change state of OpenGL
      preferences.UseOpenGL = checkOpenGL:isMarked()
      SavePreferences()
--      menu:stop(1) --TODO: Enable if we have an OpenGL function
    end)
  checkOpenGL:setMarked(preferences.UseOpenGL)

  b = menu:addCheckBox("Allow Training Queue", offx + 16, offy + top + 15 * 4,
    function()
	  preferences.TrainingQueue = not preferences.TrainingQueue
	  SetTrainingQueue(not not preferences.TrainingQueue)
      SavePreferences()
    end)
  b:setMarked(preferences.TrainingQueue)

  menu:addLabel("Max Unit Selection", offx + 16, offy + top + 15 * 5, Fonts["game"], false)
  local maxselections = {"4 (WC1 default)", "9", "12", "18", "50"}
  maxselection = menu:addDropDown(maxselections, offx + 16 + 250, offy + top + 15 * 5,
    function(dd)
	  local selected = maxselections[maxselection:getSelected() + 1]
	  local count = tonumber(string.gmatch(selected, "%d+")())
	  preferences.MaxSelection = count
	  SavePreferences()
	  SetMaxSelectable(count)
	  menu:stop()
	  RunOptionsMenu()
	end)
  for idx,str in ipairs(maxselections) do
    local count = tonumber(string.gmatch(str, "%d+")())
	if preferences.MaxSelection == count then
	  maxselection:setSelected(idx - 1)
	  break
	end
  end
  
  b = menu:addCheckBox("Allow multiple Town Halls", offx + 16, offy + top + 15 * 6,
    function()
      preferences.AllowMultipleTownHalls = not preferences.AllowMultipleTownHalls
      SavePreferences()
      menu:stop(1)
    end)
  b:setMarked(preferences.AllowMultipleTownHalls)

  menu:addHalfButton("~!OK", "o", offx + 123, offy + top + 15 * 9,
    function()
	  menu:stop()
	end)
  return menu:run()
end

function RunOptionsMenu()
  local continue = 1
  while (continue == 1) do
    continue = BuildOptionsMenu()
  end
end

function RunGameOptionsMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Game Options", 128, 11)
  menu:addFullButton("Sound (~<F7~>)", "f7", 25, 40 + 36*0,
    function() RunGameSoundOptionsMenu() end)
  menu:addFullButton("Preferences (~<F8~>)", "f8", 25, 40 + 36*1,
    function() RunPreferencesMenu() end)
  menu:addFullButton("Diplomacy (~<F9~>)", "f9", 25, 40 + 36*2,
    function() RunDiplomacyMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 25, 288 - 60,
    function() menu:stop() end)

  menu:run(false)
end
