--      (c) Copyright 2010      by Pali Rohár

function Briefing(title, objs, bg, text, voices)
  SetPlayerData(GetThisPlayer(), "RaceName", currentRace)

  local menu = WarMenu(nil, bg)

  if (currentRace == "human") then
    PlayMusic(HumanBriefingMusic)
    LoadUI("human", Video.Width, Video.Height)

    warriorg = CGraphic:New("graphics/428.png", 240 / 5, 48) -- TODO: animate
    warriorg:Load()
	warriorg:Resize((240 / 5) * (Video.Width / 640), 48 * Video.Height / 400)
    wizardg = CGraphic:New("graphics/429.png", 134, 84) -- TODO: animate
    wizardg:Load()
	wizardg:Resize(134 * Video.Width / 640, 84 * Video.Height / 400)

    warriorw = ImageWidget(warriorg)
    wizardw = ImageWidget(wizardg)

    menu:add(warriorw, 166 * Video.Width / 640, 74 * Video.Height / 400)
    menu:add(wizardw, 414 * Video.Width / 640, 58 * Video.Height / 400)
  elseif (currentRace == "orc") then
    PlayMusic(OrcBriefingMusic)
    LoadUI("orc", Video.Width, Video.Height)

    femaleg = CGraphic:New("graphics/426.png", 560 / 5, 134) -- TODO: animate
    maleg = CGraphic:New("graphics/427.png", 690 / 5, 116) -- TODO: animate
    femaleg:Load()
	femaleg:Resize(560 / 5 * Video.Width / 640, 134 * Video.Height / 400)
    maleg:Load()
	maleg:Resize(690 / 5 * Video.Width / 640, 116 * Video.Height / 400)
    
    femalew = ImageWidget(femaleg)
    malew = ImageWidget(maleg)

    menu:add(femalew, 36 * Video.Width / 640, 134 * Video.Height / 400)
    menu:add(malew, 404 * Video.Width / 640, 104 * Video.Height / 400)
  else
    StopMusic()
  end

  Objectives = objs

  if (title ~= nil) then
    menu:addLabel(title, (70 + 340) / 2 * Video.Width / 640, 28 * Video.Height / 480, Fonts["large"], true)
  end

  local t = LoadBuffer(text)
  t = "\n\n\n\n\n\n" .. t .. "\n\n\n\n\n\n\n\n\n\n\n\n\n"
  local sw = ScrollingWidget(320, 170 * Video.Height / 480)
  sw:setBackgroundColor(Color(0,0,0,0))
  sw:setSpeed(0.28)
  local l = MultiLineLabel(t)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.LEFT)
  l:setLineWidth(320)
  l:adjustSize()
  sw:add(l, 0, 0)
  menu:add(sw, 70 * Video.Width / 640, 80 * Video.Height / 480)

  if (objs ~= nil) then
    menu:addLabel("Objectives:", 372 * Video.Width / 640, 306 * Video.Height / 480, Fonts["large"], false)

    local objectives = ""
    table.foreachi(objs, function(k,v) objectives = objectives .. v .. "\n" end)

    local l = MultiLineLabel(objectives)
    l:setFont(Fonts["large"])
    l:setAlignment(MultiLineLabel.LEFT)
    l:setLineWidth(250 * Video.Width / 640)
    l:adjustSize()
    menu:add(l, 372 * Video.Width / 640, (306 * Video.Height / 480) + 30)
  end

  local voice = 0
  local channel = -1

  menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
    function()
      if (channel ~= -1) then
        voice = table.getn(voices)
        StopChannel(channel)
      end
      menu:stop()
      StopMusic()
    end)


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

function CreateEndingStep(bg, text, voice)
  return function()
      print ("Ending in " .. bg .. " with " .. text .. " and " .. voice)
	  local menu = WarMenu(nil, bg, true)
	  StopMusic()
	  local t = LoadBuffer(text)
	  t = "\n\n\n\n\n\n\n\n\n\n" .. t .. "\n\n\n\n\n\n\n\n\n\n\n\n\n"
	  local sw = ScrollingWidget(320, 170 * Video.Height / 480)
	  sw:setBackgroundColor(Color(0,0,0,0))
	  sw:setSpeed(0.28)
	  local l = MultiLineLabel(t)
	  l:setFont(Fonts["large"])
	  l:setAlignment(MultiLineLabel.LEFT)
	  l:setVerticalAlignment(MultiLineLabel.TOP)
	  l:setLineWidth(320)
	  l:adjustSize()
	  sw:add(l, 0, 0)
	  menu:add(sw, 70 * Video.Width / 640, 80 * Video.Height / 480)
	  local channel = -1
	  menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
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
    local offx = (Video.Width - 640) / 2
    local offy  = (Video.Height - 480) / 2
    menu:addLabel(title, offx + 320, offy + 240 - 67, Fonts["large-title"], true)
    menu:addLabel(text, offx + 320, offy + 240 - 25, Fonts["small-title"], true)
    menu:addHalfButton("~!Continue", "c", 455 * Video.Width / 640, 440 * Video.Height / 480,
      function() menu:stop() end)
    menu:run()
    GameResult = GameVictory
  end
end

function CreateMapStep(map)
  return function()
    -- If there is a pre-setup step, run it, if that fails, don't worry
    pcall(function () Load(string.gmatch(map, "[^\.]+")() .. "_prerun.lua") end)
    Load(map)
    RunMap(map, preferences.FogOfWar)
    if (GameResult == GameVictory) then
      IncreaseCampaignState(currentRace, currentState)
    end
  end
end

function CreateVideoStep(video)
  return function()
    PlayMovie(video)
    GameResult = GameVictory
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
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  local show_buttons = GetCampaignState(race)
  local half = math.ceil(show_buttons/2)

  for i=1,half do
    menu:addFullButton(CampaignButtonTitle(race, i), ".", offx + 63, offy + 64 + (36 * i), CampaignButtonFunction(campaign, race, i, menu))
  end

  for i=1+half,show_buttons do
    menu:addFullButton(CampaignButtonTitle(race, i), ".", offx + 329, offy + 64 + (36 * (i - half)), CampaignButtonFunction(campaign, race, i, menu))
  end

  menu:addFullButton("~!Previous Menu", "p", offx + 193, offy + 212 + (36 * 5),
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
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  menu:addFullButton("~!Orc campaign", "o", offx + 193, offy + 212 + (36 * 0),
    function() RunCampaignSubmenu("orc"); menu:stop() end)
  menu:addFullButton("~!Human campaign", "h", offx + 193, offy + 212 + (36 * 1),
    function() RunCampaignSubmenu("human"); menu:stop() end)

  menu:addFullButton("~!Previous Menu", "p", offx + 193, offy + 212 + (36 * 5),
    function() RunSinglePlayerSubMenu(); menu:stop() end)

  menu:run()
end

