--      (c) Copyright 2010      by Pali Rohár

function SetupAnimation(filename, w, h, x, y, framecntX, framecntY, backwards, pauseFrameCnt, speedScale, menu)
   local g = CGraphic:New(filename)
   local headW = math.ceil(w / framecntX * (Video.Width / 320) + 0.5)
   local headH = math.ceil(h / framecntY * (Video.Height / 200) + 0.5)
   g:Load()
   g:Resize(headW * framecntX, headH * framecntY)
   local head = ImageWidget(g)
   local headClip = Container()
   headClip:setOpaque(false)
   headClip:setBorderSize(0)
   headClip:setWidth(headW)
   headClip:setHeight(headH)
   headClip:add(head, 0, 0)
   menu:add(headClip, x * Video.Width / 320, y * Video.Height / 200)

   local animTable = {}

   if framecntX > 1 then
      -- animation: frames horizontally
      for i=0,framecntX-1,1 do
         for j=0,speedScale,1 do
            animTable[#animTable + 1] = { -i * headW, 0 }
         end
      end
      if backwards then
         for i=framecntX-1,0,-1 do
            for j=0,speedScale,1 do
               animTable[#animTable + 1] = { -i * headW, 0 }
            end
         end
      end
   else
      -- animation: frames vertically
      for i=0,framecntY-1,1 do
         for j=0,speedScale,1 do
            animTable[#animTable + 1] = { 0, -i * headH }
         end
      end
      if backwards then
         for i=framecntY-1,0,-1 do
            for j=0,speedScale,1 do
               animTable[#animTable + 1] = { 0, -i * headH }
            end
         end
      end
   end

   for i=0,pauseFrameCnt,1 do
      animTable[#animTable + 1] = { 0, 0 }
   end

  local frame = 1
  local function animationCb()
     headClip:remove(head)
     headClip:add(head, animTable[frame][1], animTable[frame][2])
     frame = frame + 1
     if frame > #animTable then
        frame = 1
     end
  end

  return {animationCb, headClip}
end

function Briefing(title, objs, bgImg, mapbg, mapVideo, text, voices)
  SetPlayerData(GetThisPlayer(), "RaceName", currentRace)

  local menu = WarMenu()

  local voice = 0
  local channel = -1

  local bg1 = CGraphic:New(bgImg)
  bg1:Load()
  bg1:Resize(Video.Width, Video.Height)
  local bg2 = nil
  if CanAccessFile(mapbg) then
     bg2 = CGraphic:New(mapbg)
     bg2:Load()
     bg2:Resize(Video.Width, Video.Height)
  end

  local bg = ImageButton()
  bg:setNormalImage(bg1)
  menu:add(bg, 0, 0)

  local animations = {}

  if (currentRace == "human") then
    PlayMusic(HumanBriefingMusic)
    LoadUI("human", Video.Width, Video.Height)

    animations[1] = SetupAnimation("graphics/428.png", 120, 24, 83, 37, 5, 1, false, 20, 2, menu)
    animations[2] = SetupAnimation("graphics/429.png", 67, 42 * 21, 207, 29, 1, 21, false, 0, 2, menu)
    animations[3] = SetupAnimation("graphics/430.png", 24, 504, 21, 17, 1, 21, true, 0, 0, menu)
    animations[4] = SetupAnimation("graphics/431.png", 20, 462, 275, 16, 1, 21, true, 0, 0, menu)

    bg1:SetPaletteColor(255, 48, 56, 56)
    -- -- color cycle the shadow pixels to give a sense of flickering light
    -- local coloridx = 1
    -- local colors = {{48, 56, 56}, {44, 48, 48}, {36, 48, 44}, {52, 64, 64}, {56, 68, 64}, {68, 80, 76}, {72, 84, 80}}
    -- local function animateFlicker()
    --    bg1:SetPaletteColor(255, colors[coloridx][1], colors[coloridx][2], colors[coloridx][3])
    --    coloridx = coloridx + 1
    --    if coloridx > #colors then
    --       coloridx = 1
    --    end
    -- end
    -- animations[5] = {animateFlicker, nil}

  elseif (currentRace == "orc") then
    PlayMusic(OrcBriefingMusic)
    LoadUI("orc", Video.Width, Video.Height)

    animations[1] = SetupAnimation("graphics/426.png", 280, 67, 18, 67, 5, 1, true, 20, 2, menu)
    animations[2] = SetupAnimation("graphics/427.png", 345, 58, 202, 52, 5, 1, true, 0, 2, menu)
    animations[3] = SetupAnimation("graphics/425.png", 50, 1023, 145, 70, 1, 31, false, 0, 0, menu)
  else
    StopMusic()
  end

  local frameTime = 0
  local function animateHeads()
     frameTime = frameTime + 1
     if frameTime % 3 == 0 then
        for i=1,#animations,1 do
           animations[i][1]()
        end
     end
  end

  listener = LuaActionListener(animateHeads)
  menu:addLogicCallback(listener)

  Objectives = objs

  if (title ~= nil) then
     local headline = title
     if (objs ~= nil) then
        headline = title .. " - " .. objectives[1]
     end
     menu:addLabel(headline, 0.1 * Video.Width, 0.1 * Video.Height, Fonts["large"], false)
  end

  local t = LoadBuffer(text)
  local sw = ScrollingWidget(0.7 * 320, 0.6 * 200)
  sw:setBackgroundColor(Color(0,0,0,0))
  sw:setSpeed(0.28)

  local listener
  local l = MultiLineLabel(t)
  l:setForegroundColor(Color(0, 0, 0, 255))
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.CENTER)
  l:setVerticalAlignment(MultiLineLabel.CENTER)
  l:setLineWidth(0.7 * 320)
  l:adjustSize()
  l:setHeight(0.9 * 200)
  sw:add(l, 0, 0)
  menu:add(sw, 0.15 * Video.Width, 0.2 * Video.Height)

  function PlayNextVoice()
    voice = voice + 1
    if (voice <= table.getn(voices)) then
      channel = PlaySoundFile(voices[voice], PlayNextVoice);
    else
      channel = -1
    end
  end
  PlayNextVoice()

  local speed = GetGameSpeed()
  SetGameSpeed(30)

  local currentAction = nil
  local overall
  function action2()
     if (channel ~= -1) then
        voice = table.getn(voices)
        StopChannel(channel)
     end
     StopMusic()
     MusicStopped()

     local scenem = Movie()
     if scenem:Load(mapVideo, Video.Width, Video.Height) then
        currentAction = function() menu:stop() end
        local movieWidget = ImageWidget(scenem)
        menu:add(movieWidget, 0, 0)
        menu:add(overall, 0, 0)
        local function playEnd()
           if not scenem:IsPlaying() then
              menu:stop()
           end
        end
        listener = LuaActionListener(playEnd)
        menu:addLogicCallback(listener)
     end
  end
  function action1()
     if bg2 ~= nil then
        bg:setNormalImage(bg2)
        for i=1,#animations,1 do
           if animations[i][2] then
              animations[i][2]:setVisible(false)
           end
        end
        currentAction = action2
     else
        action2()
     end
  end
  currentAction = action1

  overall = ImageButton()
  overall:setWidth(Video.Width)
  overall:setHeight(Video.Height)
  overall:setBorderSize(0)
  overall:setBaseColor(Color(0, 0, 0, 0))
  overall:setForegroundColor(Color(0, 0, 0, 0))
  overall:setBackgroundColor(Color(0, 0, 0, 0))
  overall:setActionCallback(function()
        currentAction()
  end)
  overall:setHotKey("return")

  l:setActionCallback(action2)
  sw:setActionCallback(action2)

  menu:add(overall, 0, 0)
  menu:run()

  SetGameSpeed(speed)
end

function GetCampaignState(race)
  if (race == "orc") then
    return preferences.CampaignOrc
  elseif (race == "human") then
    return preferences.CampaignHuman
  end
  return 1
end

function IncreaseCampaignState(race, state)
  -- Loaded saved game could have other old state
  -- Make sure that we use saved state from config file
  if (race == "orc") then
    if (state ~= preferences.CampaignOrc) then return end
    preferences.CampaignOrc = preferences.CampaignOrc + 1
  elseif (race == "human") then
    if (state ~= preferences.CampaignHuman) then return end
    preferences.CampaignHuman = preferences.CampaignHuman + 1
  end
  -- Make sure that we immediately save state
  SavePreferences()
end

function CreateEndingStep(bg, text, voice, video)
  return function()
      print ("Ending in " .. bg .. " with " .. text .. " and " .. voice)
	  local menu = WarMenu(nil, bg, true)
	  StopMusic()

          if (video ~= nil) then
             PlayMovie(video)
          end

          if currentRace == "orc" then
             -- there's animations here
             local animation = SetupAnimation("graphics/460.png", 153, 651, 89, 0, 1, 31, true, 0, 2, menu)
             local frameTime = 0
             local function animateHeads()
                frameTime = frameTime + 1
                if frameTime % 3 == 0 then
                   animation[1]()
                end
             end
             listener = LuaActionListener(animateHeads)
             menu:addLogicCallback(listener)
          end
          
	  local t = LoadBuffer(text)
	  t = "\n\n\n\n\n\n\n\n\n\n" .. t .. "\n\n\n\n\n\n\n\n\n\n\n\n\n"
	  local sw = ScrollingWidget(160, 85 * Video.Height / 200)
	  sw:setBackgroundColor(Color(0,0,0,80))
	  sw:setSpeed(0.12)
	  local l = MultiLineLabel(t)
	  l:setFont(Fonts["large"])
	  l:setAlignment(MultiLineLabel.LEFT)
	  l:setVerticalAlignment(MultiLineLabel.CENTER)
	  l:setLineWidth(160)
	  l:adjustSize()
	  sw:add(l, 0, 0)
	  menu:add(sw, 35 * Video.Width / 320, 40 * Video.Height / 200)
	  local channel = -1
	  menu:addHalfButton("~!Continue", "c", 227 * Video.Width / 320, 220 * Video.Height / 200,
		function()
		  if (channel ~= -1) then
			StopChannel(channel)
		  end
		  menu:stop()
		  StopMusic()
		end)
          channel = PlaySoundFile(voice, function() end);
	  menu:run()
	  GameResult = GameVictory
  end
end

function CreatePictureStep(bg, sound, title, text)
  return function()
    SetPlayerData(GetThisPlayer(), "RaceName", currentRace)
    PlayMusic(sound)
    local menu = WarMenu(nil, bg)
    local offx = (Video.Width - 320) / 2
    local offy  = (Video.Height - 200) / 2
    menu:addLabel(title, offx + 160, offy + 120 - 33, Fonts["large-title"], true)
    menu:addLabel(text, offx + 160, offy + 120 - 12, Fonts["small-title"], true)
    menu:addHalfButton("~!Continue", "c", 227 * Video.Width / 320, 220 * Video.Height / 200,
      function() menu:stop() end)
    menu:run()
    GameResult = GameVictory
  end
end

function CreateMapStep(race, map)
  return function()
    -- If there is a pre-setup step, run it, if that fails, don't worry
    local prefix = "campaigns/" .. race .. "/"
    pcall(function () Load(prefix .. map .. "_prerun.lua") end)
    Load(prefix .. map .. "_c2.sms")
    Load(prefix .. "campaign_titles.lua")

    local race_prefix = string.lower(string.sub(race, 1, 1))

    Briefing(
       campaign_titles[tonumber(map)],
       objectives,
       "../graphics/ui/" .. race .. "/briefing.png",
       "../graphics/" .. race_prefix .. "map" .. map .. ".png",
       "videos/" .. race_prefix .. "map" .. map .. ".ogv",
       prefix .. map .. "_intro.txt",
       {prefix .. map .. "_intro.wav"}
    )

    war1gus.InCampaign = true
    Load(prefix .. map .. ".smp")
    RunMap(prefix .. map .. ".smp", preferences.FogOfWar)
    war1gus.InCampaign = false
    if (GameResult == GameVictory) then
      IncreaseCampaignState(currentRace, currentState)
    end
  end
end

function CreateVictoryStep(bg, text, voices)
  return function()
    Briefing(nil, nil, bg, text, voices)
    GameResult = GameVictory
  end
end

function CampaignButtonTitle(race, i)
  Load("campaigns/" .. race .. "/campaign_titles.lua")
  title = campaign_titles[i] or "xxx"

  if ( string.len(title) > 20 ) then
	  title = string.sub(title, 1, 19) .. "..."
  end

  return title
end

function CampaignButtonFunction(campaign, race, i, menu)
  return function()
    position = campaign.menu[i]
    currentCampaign = campaign
    currentRace = race
    currentState = i
    menu:stop()
    RunCampaign(campaign)
  end
end

function RunCampaignSubmenu(race)
  Load("scripts/campaigns.lua")
  campaign = CreateCampaign(race)

  currentRace = race
  SetPlayerData(GetThisPlayer(), "RaceName", currentRace)

  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2

  local show_buttons = GetCampaignState(race)
  local half = math.ceil(show_buttons/2)

  for i=1,half do
    menu:addFullButton(CampaignButtonTitle(race, i), ".", offx + 31, offy + 32 + (18 * (i - 1)), CampaignButtonFunction(campaign, race, i, menu))
  end

  for i=1+half,show_buttons do
    menu:addFullButton(CampaignButtonTitle(race, i), ".", offx + 164, offy + 32 + (18 * (i - 1 - half)), CampaignButtonFunction(campaign, race, i, menu))
  end

  menu:addFullButton("~!Previous Menu", "p", offx + 96, offy + 106 + (18 * 4),
    function() menu:stop(); currentCampaign = nil; currentRace = nil; currentState = nil; RunCampaignGameMenu() end)
  menu:run()

end

function RunCampaign(campaign)
  if (campaign ~= currentCampaign or position == nil) then
    position = 1
  end

  currentCampaign = campaign

  while (position <= table.getn(campaign.steps)) do
    campaign.steps[position]()
    if (GameResult == GameVictory) then
      position = position + 1
    elseif (GameResult == GameDefeat) then
    elseif (GameResult == GameDraw) then
    elseif (GameResult == GameNoResult) then
      currentCampaign = nil
      return
    else
      break -- quit to menu
    end
  end

  RunCampaignSubmenu(currentRace)

  currentCampaign = nil
end

function RunCampaignGameMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2

  menu:addFullButton("~!Orc campaign", "o", offx + 96, offy + 106 + (18 * 0),
    function() RunCampaignSubmenu("orc"); menu:stop() end)
  menu:addFullButton("~!Human campaign", "h", offx + 96, offy + 106 + (18 * 1),
    function() RunCampaignSubmenu("human"); menu:stop() end)

  menu:addFullButton("~!Previous Menu", "p", offx + 96, offy + 106 + (18 * 4),
    function() RunSinglePlayerSubMenu(); menu:stop() end)

  menu:run()
end

