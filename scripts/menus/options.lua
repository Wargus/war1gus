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

     local slider = Slider(0, 255)
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
   local shaderNames = (GetShaderNames and GetShaderNames()) or {_("default")}
   local function getCurrentShaderIndex()
      local currentShader = GetShader()
      for idx,name in pairs(shaderNames) do
         if name == currentShader then
            return idx
         end
      end
   end
   local menu
   
   menu = WarMenuWithLayout(
      panel(1),
      VBox({
            LLabel("Preferences"),

            HBox({
                  VBox({
                        LCheckBox("Fog of War", function(fog)
                                     SetFogOfWar(fog:isMarked())
                                     preferences.FogOfWar = fog:isMarked()
                                     SavePreferences()
                        end):id("fog"),
                        ((GameCycle == 0 and
                          LCheckBox("Multiple Townhalls", function(dd)
                                       preferences.AllowMultipleTownHalls = dd:isMarked()
                                       Load("scripts/buttons.lua")
                                       Load("scripts/buildings.lua")
                                       SavePreferences()
                          end):id("multiTown")) or
                           LLabel(("Multiple Townhalls" .. " " ..
                                   (preferences.AllowMultipleTownHalls and _("on") or _("off"))), nil, false)),
                        ((GameCycle == 0 and
                          LCheckBox("Rebalanced stats", function(dd)
                                       if preferences.RebalancedStats then
                                          preferences.RebalancedStats = false
                                          local infoMenu = WarMenu(nil, panel(4), false)
                                          infoMenu:setSize(144, 64)
                                          infoMenu:setPosition((Video.Width - 144) / 2, (Video.Height - 64) / 2)
                                          infoMenu:setDrawMenusUnder(true)
                                          local l = MultiLineLabel("The game will now restart to revert to original game stats.")
                                          l:setFont(Fonts["large"])
                                          l:setAlignment(MultiLineLabel.CENTER)
                                          l:setVerticalAlignment(MultiLineLabel.CENTER)
                                          l:setLineWidth(135)
                                          l:setWidth(135)
                                          l:setHeight(20)
                                          l:setBackgroundColor(dark)
                                          infoMenu:add(l, 4, 19)
                                          infoMenu:addHalfButton("~!OK", "o", 41, 40, function()
                                             SavePreferences()
                                             RestartStratagus()
                                          end)
                                          infoMenu:run()
                                       else
                                          Load("scripts/balancing.lua")
                                          preferences.RebalancedStats = true
                                       end
                                       SavePreferences()
                          end):id("stats")) or
                           LLabel(("Rebalanced stats" .. " " ..
                                   (preferences.RebalancedStats and _("on") or _("off"))), nil, false)),
                        (((not IsNetworkGame()) and 
                              LCheckBox(_("Simplified auto targeting"), function(dd)
                                           Preference.SimplifiedAutoTargeting = dd:isMarked()
                                           preferences.SimplifiedAutoTargeting = Preference.SimplifiedAutoTargeting
                                           SavePreferences()
                              end):id("simpleautotgt")) or
                           LLabel((_("Simplified auto targeting") .. " " ..
                                   (Preference.SimplifiedAutoTargeting and _("on") or _("off"))), nil, false)),
                        LCheckBox(_("Block sight in dungeons"), function(dd)
                                     preferences.DungeonSightBlocking = dd:isMarked()
                                     if GameSettings.Inside then
                                        if preferences.DungeonSightBlocking then
                                           SetFieldOfViewType("shadow-casting")
                                        else
                                           SetFieldOfViewType("simple-radial")
                                        end
                                     end
                                     SavePreferences()
                        end):id("sightblock"),
                        LCheckBox("Training queue", function(dd)
                                     preferences.TrainingQueue = dd:isMarked()
                                     SetTrainingQueue(not not preferences.TrainingQueue)
                                     SavePreferences()
                        end):id("trainingqueue"),

                        HBox({
                              LLabel("Max selection: "),
                              LDropDown({"4 (WC1 default)", "9", "12", "18", "50"}, function(dd)
                                    local idx = dd:getSelected()
                                    if idx == 0 then
                                       preferences.MaxSelection = 4
                                    elseif idx == 1 then
                                       preferences.MaxSelection = 9
                                    elseif idx == 2 then
                                       preferences.MaxSelection = 12
                                    elseif idx == 3 then
                                       preferences.MaxSelection = 18
                                    elseif idx == 4 then
                                       preferences.MaxSelection = 50
                                    end
                                    SavePreferences()
                                    SetMaxSelectable(preferences.MaxSelection)
                              end):id("maxselect")
                        }),
                  }):withPadding(2),
                  VBox({
                        ((GameCycle == 0 and
                          LCheckBox("Simple colors", function(dd)
                                       preferences.MultiColoredCampaigns = not dd:isMarked()
                                       SetColorScheme()
                                       SavePreferences()
                          end):id("simpleColors")) or
                           LLabel(("Simple colors" .. " " ..
                                   (preferences.MultiColoredCampaigns and _("off") or _("on"))), nil, false)),
                        LCheckBox("Show orders", function(dd)
                                     if dd:isMarked() then
                                        preferences.ShowOrders = true
                                        Preference.ShowOrders = 1
                                     else
                                        preferences.ShowOrders = false
                                        Preference.ShowOrders = 0
                                     end
                                     SavePreferences()
                        end):id("showorders"),
                        LCheckBox("Show damage", function(dd)
                                     preferences.ShowDamage = dd:isMarked()
                                     if preferences.ShowDamage then
                                        SetDamageMissile("missile-hit")
                                     else
                                        SetDamageMissile(nil)
                                     end
                                     SavePreferences()
                        end):id("showdmg"),
                        LCheckBox("Show cmd keys", function(ckey)
                                     UI.ButtonPanel.ShowCommandKey = ckey:isMarked()
                        end):id("ckey"),
                        LCheckBox("Fullscreen", function(dd)
                                     ToggleFullScreen()
                                     preferences.VideoFullScreen = Video.FullScreen
                                     SavePreferences()
                        end):id("fullscreen"),

                        HBox({
                              LLabel("Fog: "),
                              LDropDown({_("tiled"), _("enhanced"), _("fast")}, function(dd)
                                    if dd:getSelected() == 0 then
                                       preferences.FogOfWarType = "tiled"
                                    elseif dd:getSelected() == 1 then
                                       preferences.FogOfWarType = "enhanced"
                                    elseif dd:getSelected() == 2 then
                                       preferences.FogOfWarType = "fast"
                                    end
                                    SetFogOfWarType(preferences.FogOfWarType)
                                    if (preferences.FogOfWarType ~= "enhanced" and GameSettings.Inside) then
                                       -- tiled and fast fog don't work with shadow caster fov
                                       preferences.DungeonSightBlocking = false;
                                       menu.sightblock:setMarked(false)
                                    end
                                    SavePreferences()
                              end):id("fogtype")
                        }),
                        LCheckBox(_("Bilinear int."), function(dd)
                                     preferences.FogOfWarBilinear = dd:isMarked()
                                     SetFogOfWarBilinear(preferences.FogOfWarBilinear)
                                     SavePreferences()
                        end):id("fowbilinear"),
                        HBox({
                              LLabel(_("Shader")),
                              LDropDown(shaderNames, function(dd)
                                           if #shaderNames > 1 then
                                              local newShader = shaderNames[dd:getSelected() + 1];
                                              if SetShader(newShader) then
                                                 Preference.VideoShader = newShader
                                                 wc1.preferences.VideoShader = newShader
                                              end
                                           end
                              end):id("shader"),
                        }),
                        ((GameCycle == 0 and
                          LCheckBox(_("Original pixel ratio"), function(dd)
                                       preferences.OriginalPixelRatio = dd:isMarked()
                                       if preferences.OriginalPixelRatio then
                                          SetVerticalPixelSize(1.2)
                                       else
                                          SetVerticalPixelSize(1.0)
                                       end
                                       SavePreferences()
                          end):id("pixelratio")) or
                           LLabel((_("Original pixel ratio") .. " " ..
                                   (preferences.OriginalPixelRatio and _("on") or _("off"))), nil, false)),
                  }):withPadding(2),
            }):withPadding(2),

            HBox({
                  LLabel("Game speed: ", Fonts["game"], false, false),
                  VBox({
                        LSlider(15, 75, function(s)
                                   SetGameSpeed(s:getValue())
                        end):id("gamespeed"):expanding(),
                        HBox({
                              LLabel("slow", Fonts["small"], false),
                              LFiller(),
                              LLabel("fast", Fonts["small"], false),
                        }),
                  }):expanding(),
            }),

            LButton("~!OK", "o",
                    function()
                       preferences.FogOfWar = GetFogOfWar()
                       preferences.ShowCommandKey = UI.ButtonPanel.ShowCommandKey
                       preferences.GameSpeed = GetGameSpeed()
                       SavePreferences()
                       menu:stop()
            end)
      }):withPadding(5)
   )

   menu.fog:setMarked(GetFogOfWar())
   if (IsReplayGame() or IsNetworkGame()) then
      menu.fog:setEnabled(false)
   end
   
   if menu.simpleautotgt then
      menu.simpleautotgt:setMarked(Preference.SimplifiedAutoTargeting)
   end

   if GameCycle == 0 then
      menu.multiTown:setMarked(preferences.AllowMultipleTownHalls)
      menu.simpleColors:setMarked(not preferences.MultiColoredCampaigns)
      menu.stats:setMarked(preferences.RebalancedStats)
      menu.pixelratio:setMarked(preferences.OriginalPixelRatio)
   end
   menu.showorders:setMarked(preferences.ShowOrders)
   menu.trainingqueue:setMarked(preferences.TrainingQueue)
   menu.showdmg:setMarked(preferences.ShowDamage)

   menu.ckey:setMarked(UI.ButtonPanel.ShowCommandKey)
   menu.fullscreen:setMarked(Video.FullScreen)
   menu.sightblock:setMarked(preferences.DungeonSightBlocking)

   menu.gamespeed:setValue(GetGameSpeed())

   if preferences.MaxSelection == 4 then
      menu.maxselect:setSelected(0)
   elseif preferences.MaxSelection == 9 then
      menu.maxselect:setSelected(1)
   elseif preferences.MaxSelection == 12 then
      menu.maxselect:setSelected(2)
   elseif preferences.MaxSelection == 18 then
      menu.maxselect:setSelected(3)
   elseif preferences.MaxSelection == 50 then
      menu.maxselect:setSelected(4)
   end

   menu.fogtype:setSelected(GetFogOfWarType())
   menu.fowbilinear:setMarked(GetIsFogOfWarBilinear())
   menu.shader:setSelected(getCurrentShaderIndex() - 1)   

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
