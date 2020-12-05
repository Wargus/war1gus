--      (c) Copyright 2010      by Pali Rohár

function AddSoundOptions(menu, offx, offy, centerx, bottom)
  local b

  b = menu:addLabel("Sound Options", 176 / 2, 11 / 2)

  local makeSlider = function(getvalue, setvalue, isenabled, setenabled, title, offstart)
     local b = Label(title)
     b:setFont(CFont:Get("game"))
     b:adjustSize();
     menu:add(b, 16 / 2, offy + 36 / 2 * offstart)

     local slider = Slider(0 / 2, 255 / 2)
     slider:setValue(getvalue())
     slider:setActionCallback(function() setvalue(slider:getValue()) end)
     slider:setWidth(198 / 2)
     slider:setHeight(18 / 2)
     slider:setBaseColor(dark)
     slider:setForegroundColor(clear)
     slider:setBackgroundColor(clear)

     local effectscheckbox = {}
     effectscheckbox = menu:addCheckBox(
	"Enabled",
	offx + 16 / 2, offy + 36 / 2 * (offstart + 0.5),
	function()
	   slider:setEnabled(effectscheckbox:isMarked())
	   setenabled(effectscheckbox:isMarked())
	end
     )
     effectscheckbox:setMarked(isenabled())
     effectscheckbox:adjustSize()
     menu:add(slider, offx + 20 / 2, offy + 36 / 2 * (offstart + 1))
     
     b = Label("min")
     b:setFont(CFont:Get("game"))
     b:adjustSize();
     menu:addCentered(b, offx + 44 / 2, offy + 36 / 2 * (offstart + 1.5) + 6 / 2)
     
     b = Label("max")
     b:setFont(CFont:Get("game"))
     b:adjustSize();
     menu:addCentered(b, offx + 218 / 2, offy + 36 / 2 * (offstart + 1.5) + 6 / 2)
  end


  makeSlider(
     GetEffectsVolume,
     SetEffectsVolume,
     IsEffectsEnabled,
     SetEffectsEnabled,
     "Sounds",
     1 / 2)
  makeSlider(
     GetMusicVolume,
     SetMusicVolume,
     IsMusicEnabled,
     function (bool)
	SetMusicEnabled(bool)
	MusicStopped()
     end,
     "Music",
     3.5 / 2)
 
  b = menu:addFullButton("~!OK", "o", centerx, bottom - 11 / 2 - 27 / 2,
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

  AddSoundOptions(menu, 28 / 2, 0 / 2, 25 / 2, 272 / 2)

  menu:run(false)
end

function RunPreferencesMenu()
  local menu = WarGameMenu(panel(1))

  menu:addFullButton("~!OK", "o", 25 / 2, 288 / 2 - 60 / 2,
    function()
      preferences.FogOfWar = GetFogOfWar()
      preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
      preferences.GameSpeed = GetGameSpeed()
      SavePreferences()
      menu:stop()
    end)
  
  menu:addLabel("Preferences", 128 / 2, 11 / 2)

  -- fog of war
  local fog = {}
  fog = menu:addCheckBox("Fog of War", 16 / 2, 40 / 2 + 36 / 2 * 0,
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
  ckey = menu:addCheckBox("Show command keys", 16 / 2, 40 / 2 + 36 / 2 * 0.5,
    function() UI.ButtonPanel.ShowCommandKey = ckey:isMarked() end)
  ckey:setMarked(UI.ButtonPanel.ShowCommandKey)

  -- Game speed
  menu:addLabel("Game Speed", 16 / 2, 40 / 2 + 36 / 2 * 1, Fonts["game"], false)
  local gamespeed = {}
  gamespeed = menu:addSlider(15, 75, 208 / 2, 18 / 2, 32 / 2, 40 / 2 + 36 / 2 * 1.5,
    function() SetGameSpeed(gamespeed:getValue()) end)
  gamespeed:setValue(GetGameSpeed())
  menu:addLabel("slow", 34 / 2, 40 / 2 + (36 / 2 * 2) + 6 / 2, Fonts["small"], false)
  local l = Label("fast")
  l:setFont(Fonts["small"])
  l:adjustSize()
  menu:add(l, 230 / 2 - l:getWidth(), 40 / 2 + (36 / 2 * 2) + 6 / 2)

  local b = menu:addCheckBox("Full Screen", 16 / 2, 40 / 2 + 36 / 2 * 2.5,
    function()
      ToggleFullScreen()
      preferences.VideoFullScreen = Video.FullScreen
      SavePreferences()
    end)
  b:setMarked(Video.FullScreen)

  b = menu:addCheckBox("Allow Training Queue", 16 / 2, 40 / 2 + 36 / 2 * 3,
    function()
	  preferences.TrainingQueue = not preferences.TrainingQueue
	  SetTrainingQueue(not not preferences.TrainingQueue)
      SavePreferences()
    end)
  b:setMarked(preferences.TrainingQueue)

  b = menu:addCheckBox("Show Orders", 16 / 2, 40 / 2 + 36 / 2 * 3.5,
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

  b = menu:addCheckBox("Show Damage", 16 / 2, 40 / 2 + 36 / 2 * 4,
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

  menu:addLabel("Max Selection", 16 / 2, 40 / 2 + 36 / 2 * 4.5, Fonts["game"], false)
  local maxselections = {"4 (WC1 default)", "9", "12", "18", "50"}
  maxselection = menu:addDropDown(maxselections, 16 / 2 + 150 / 2, 40 / 2 + 36 / 2 * 4.5,
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
  local offx = (Video.Width - 352 / 2) / 2
  local offy = (Video.Height - 352 / 2) / 2
  local checkTexture
  local b
  local resolution
  local maxselection
  local top = 140 / 2 * Video.Height / 200

  menu:addLabel("Video Resolution", offx + 16 / 2, offy + top, Fonts["game"], false)
  local resolutions = {
     "320x200",
     "480x300",
     "640x400",
     "800x500",
     "960x600",
     "1280x800"
  }
  resolution = menu:addDropDown(resolutions, offx + 16 / 2 + 250 / 2, offy + top,
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

  b = menu:addCheckBox("Full Screen", offx + 16 / 2, offy + top + 15 / 2,
    function()
      ToggleFullScreen()
      preferences.VideoFullScreen = Video.FullScreen
      SavePreferences()
      menu:stop(1)
    end)
  b:setMarked(Video.FullScreen)

  b = menu:addCheckBox("Allow Training Queue", offx + 16 / 2, offy + top + 15 / 2 * 4,
    function()
	  preferences.TrainingQueue = not preferences.TrainingQueue
	  SetTrainingQueue(not not preferences.TrainingQueue)
      SavePreferences()
    end)
  b:setMarked(preferences.TrainingQueue)

  menu:addLabel("Max Unit Selection", offx + 16 / 2, offy + top + 15 / 2 * 5, Fonts["game"], false)
  local maxselections = {"4 (WC1 default)", "9", "12", "18", "50"}
  maxselection = menu:addDropDown(maxselections, offx + 16 / 2 + 250 / 2, offy + top + 15 / 2 * 5,
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
  
  b = menu:addCheckBox("Allow multiple Town Halls", offx + 16 / 2, offy + top + 15 / 2 * 6,
    function()
      preferences.AllowMultipleTownHalls = not preferences.AllowMultipleTownHalls
      Load("scripts/buttons.lua")
      Load("scripts/buildings.lua")
      SavePreferences()
    end)
  b:setMarked(preferences.AllowMultipleTownHalls)

  b = menu:addCheckBox("Use simplified color scheme", offx + 16 / 2, offy + top + 15 / 2 * 7,
    function()
	  preferences.MultiColoredCampaigns = not preferences.MultiColoredCampaigns
	  SetColorScheme()
	  SavePreferences()
	end)
  b:setMarked(not preferences.MultiColoredCampaigns)

  menu:addHalfButton("~!OK", "o", offx + 123 / 2, offy + top + 15 / 2 * 9,
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

  menu:addLabel("Game Options", 128 / 2, 11 / 2)
  menu:addFullButton("Sound (~<F7~>)", "f7", 25 / 2, 40 / 2 + 36 / 2*0,
    function() RunGameSoundOptionsMenu() end)
  menu:addFullButton("Preferences (~<F8~>)", "f8", 25 / 2, 40 / 2 + 36 / 2*1,
    function() RunPreferencesMenu() end)
  menu:addFullButton("Diplomacy (~<F9~>)", "f9", 25 / 2, 40 / 2 + 36 / 2*2,
    function() RunDiplomacyMenu() end)
  menu:addFullButton("Previous (~<Esc~>)", "escape", 25 / 2, 288 / 2 - 60 / 2,
    function() menu:stop() end)

  menu:run(false)
end
