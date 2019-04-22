--  (c) Copyright 2005-2006 by François Beerten and Jimmy Salmon
--  (c) Copyright 2010      by Pali Rohár

function bool2int(boolvalue)
  if boolvalue == true then
    return 1
  else
    return 0
  end
end

function int2bool(int)
  if int == 0 then
    return false
  else
    return true
  end
end

function ErrorMenu(errmsg)
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Error:", 144, 11)

  local l = MultiLineLabel(errmsg)
  l:setFont(Fonts["large"])
  l:setAlignment(MultiLineLabel.CENTER)
  l:setVerticalAlignment(MultiLineLabel.CENTER)
  l:setLineWidth(270)
  l:setWidth(270)
  l:setHeight(41)
  l:setBackgroundColor(dark)
  menu:add(l, 9, 38)

  menu:addHalfButton("~!OK", "o", 83, 80, function() menu:stop() end)

  menu:run()
end

function addPlayersList(menu, numplayers)
  local i
  local players_name = {}
  local players_state = {}
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local numplayers_text

  menu:writeLargeText("Players", sx * 11, sy*3)
  for i=1,8 do
    players_name[i] = menu:writeText("Player"..i, sx * 11, sy*4 + i*18)
    players_state[i] = menu:writeText("Preparing", sx * 11 + 80, sy*4 + i*18)
  end
  numplayers_text = menu:writeText("Open slots : " .. numplayers - 1, sx *11, sy*4 + 144)

  local function updatePlayers()
    local connected_players = 0
    local ready_players = 0
    players_state[1]:setCaption("Creator")
    players_name[1]:setCaption(Hosts[0].PlyName)
    for i=2,8 do
      if Hosts[i-1].PlyName == "" then
        players_name[i]:setCaption("")
        players_state[i]:setCaption("")
      else
        connected_players = connected_players + 1
        if ServerSetupState.Ready[i-1] == 1 then
          ready_players = ready_players + 1
          players_state[i]:setCaption("Ready")
        else
          players_state[i]:setCaption("Preparing")
        end
        players_name[i]:setCaption(Hosts[i-1].PlyName)
     end
    end
    numplayers_text:setCaption("Open slots : " .. numplayers - 1 - connected_players)
    numplayers_text:adjustSize()
    return (connected_players > 0 and ready_players == connected_players)
  end

  return updatePlayers
end

function RunOnlineMenu()
   local menu = WarMenu("Online Menu")
   InitGameSettings()
   InitNetwork1()

   local timeout = 50

   menu:writeText("Metaserver", 20, 20)
   local serverInput = menu:addTextInputField(wc1.preferences.MetaServer .. ":" .. tostring(wc1.preferences.MetaPort), 20, 35, 150)

   menu:writeText("Nickname", 20, 60)
   local nickInput = menu:addTextInputField(wc1.preferences.PlayerName, 20, 75, 150)
   local nick = wc1.preferences.PlayerName
   local function nickInputCb()
      MetaClient:Send("LEAVE " .. nick)
      nick = nickInput:getText()
      needsLogin = true
      timeout = 1
   end

   menu:writeText("Active Users", 20, 100)
   local nickListHeight = Video.Height / 4
   local nickListTop = 115
   local nickListBox = menu:addListBox(20, nickListTop, 150, nickListHeight, {})
   local nickList = {}

   local chat = menu:addListBox(180, 50, Video.Width - 200, nickListHeight + nickListTop - 50, {})
   local chatList = {}
   local chatInput = menu:addTextInputField("", 180, nickListHeight + nickListTop + 5, Video.Width - 260)
   local function chatInputCb()
      MetaClient:Send("MESSAGE " .. chatInput:getText())
      chatInput:setText("")
      timeout = 5
   end
   chatInput:addActionListener(LuaActionListener(chatInputCb));
   local sendButton = menu:addHalfButton(
      "~!Send", "s", 0, 0,
      function()
         chatInputCb()
      end
   )
   sendButton:setSize(60, 20)
   sendButton:setPosition(Video.Width - 80, nickListHeight + nickListTop + 5)

   menu:writeText("Status: ", 20, Video.Height - 60)
   local serverStatus = menu:addListBox(100, Video.Height - 60, 300, 30, {})
   local statusList = {}

   local gameListTop = nickListHeight + nickListTop + 60
   menu:writeText("Games", 20, gameListTop - 20)
   local gamesListBox = menu:addListBox(20, gameListTop, Video.Width - 40 - 90, nickListHeight, {})
   local gamesList = {}

   local map
   local description
   local playercount
   local gameid
   local hasCreatedGame = false
   local hasJoinedGame = false

   local joinButton = menu:addHalfButton(
      "~!Join", "j", 0, 0,
      function()
         if gamesListBox:getSelected() > 0 then
            local selectedGame = gamesList[gamesListBox:getSelected() + 1]
            for id in selectedGame.gmatch("(%d+)") do
               MetaClient:Send("JOIN " .. chatInput:getText() ..
                                  " " .. MetaClient:GetInternalIP() .. " " ..
                                  tostring(MetaClient:GetInternalPort()))
               hasJoinedGame = true
            end
         end
      end
   )
   joinButton:setSize(80, 30)
   joinButton:setPosition(Video.Width - 20 - 80, gameListTop)

   local createButton = menu:addFullButton(
      "~!Create", "c", 0, 0,
      function()
         RunCreateMultiGameMenu(function(mapfile, desc, numplayers)
               map = mapfile
               description = desc
               playercount = numplayers
               timeout = 5
               MetaClient:Send(
                  "CREATE \"War1gus" .. wc1.Version .. "\" \"" ..
                     desc .. "\" \"" .. map .. "\" " .. tostring(numplayers) ..
                     " " .. MetaClient:GetInternalIP() .. " " ..
                     tostring(MetaClient:GetInternalPort()))
               hasCreatedGame = true
         end)
      end
   )
   createButton:setSize(80, 30)
   createButton:setPosition(Video.Width - 20 - 80, gameListTop + 40)

   local prevButton = menu:addFullButton(
      "~!Leave", "l", 0, 0,
      function()
         MetaClient:Send("LEAVE " .. nick)
         menu:stop()
      end
   )
   prevButton:setSize(80, 30)
   prevButton:setPosition(Video.Width - 20 - 80, gameListTop + 80)

   local needsRefresh = true
   local needsLogin = true
   local needsConnection = true

   local function process_metaserver_events()
      while MetaClient:GetLogSize() > 0 do
         log = MetaClient:GetNextMessage()
         if string.match(log.entry, "LOGIN_REQUIRED") then
            needsLogin = true
            statusList[#statusList+1] = "Login required, choose a nick"
            serverStatus:setList(statusList)
            serverStatus:setVerticalScrollAmount(serverStatus:getVerticalMaxScroll())
         elseif string.match(log.entry, "LOGIN_FAILED") then
            needsLogin = true
            statusList[#statusList+1] = "Login failed, nickname already taken"
            serverStatus:setList(statusList)
            serverStatus:setVerticalScrollAmount(serverStatus:getVerticalMaxScroll())
         elseif string.match(log.entry, "LOGIN_OK") then
            needsLogin = false
            SetLocalPlayerName(nickInput:getText())
            statusList[#statusList+1] = "Login ok"
            serverStatus:setList(statusList)
            serverStatus:setVerticalScrollAmount(serverStatus:getVerticalMaxScroll())
            timeout = 0
         elseif string.match(log.entry, "LIST_OK") then
            timeout = 100
         elseif string.match(log.entry, "MESSAGE") then
            timeout = 0
            local idx = nil
            idx = string.find(log.entry, "%s")
            if idx then
               local msg = nil
               msg = string.sub(log.entry, idx)
               local append = true
               for i,emsg in ipairs(chatList) do
                  if emsg == msg then
                     append = false
                     break
                  end
               end
               if append then
                  chatList[#chatList+1] = msg
                  chat:setList(chatList)
               end
            end
            chat:setVerticalScrollAmount(chat:getVerticalMaxScroll())
         elseif string.match(log.entry, "USERNAME") then
            timeout = 0
            local idx = nil
            idx = string.find(log.entry, "%s")
            if idx then
               local user = nil
               user = string.sub(log.entry, idx)
               local append = true
               for i,euser in ipairs(nickList) do
                  if euser == user then
                     append = false
                     break
                  end
               end
               if append then
                  nickList[#nickList+1] = user
                  nickListBox:setList(nickList)
               end
            end
         elseif string.match(log.entry, "GAME") then
            timeout = 0
            local idx = nil
            idx = string.find(log.entry, "%s")
            if idx then
               local game = nil
               game = string.sub(log.entry, idx)
               local append = true
               for i,egame in ipairs(chatList) do
                  if egame == game then
                     append = false
                     break
                  end
               end
               if append then
                  gamesList[#gamesList+1] = game
                  gamesListBox:setList(gamesList)
               end
            end
         elseif string.match(log.entry, "CREATE_MALFORMED") then
            statusList[#statusList+1] = "Problem creating game, metaserver incompatible with this game"
            serverStatus:setList(statusList)
            serverStatus:setVerticalScrollAmount(serverStatus:getVerticalMaxScroll())
            hasCreatedGame = false
         elseif string.match(log.entry, "CREATE_OK") then
            if hasCreatedGame then
               local gameid = nil
               for id in string.gmatch(log.entry, "CREATE_OK (%d+\.%d+)") do
                  gameid = tonumber(id)
                  break
               end
               RunServerMultiGameMenu(map, description, playercount, gameid)
               hasCreatedGame = false
            end
         elseif string.match(log.entry, "JOIN_MALFORMED") then
            hasJoinedGame = false
            statusList[#statusList+1] = "Problem creating game, metaserver incompatible with this game"
            serverStatus:setList(statusList)
            serverStatus:setVerticalScrollAmount(serverStatus:getVerticalMaxScroll())
         elseif string.match(log.entry, "JOIN_FAILED") then
            hasJoinedGame = false
            statusList[#statusList+1] = "Problem joining game, game already closed"
            serverStatus:setList(statusList)
            serverStatus:setVerticalScrollAmount(serverStatus:getVerticalMaxScroll())
         elseif string.match(log.entry, "JOIN_OK") then
            if hasJoinedGame then
               for ip,port in string.gmatch(str, "(%d+.%d+.%d+.%d+):(%d+)") do
                  if (NetworkSetupServerAddress(ip, tonumber(port)) ~= 0) then
                     ErrorMenu("Invalid server name " .. ip)
                  else
                     NetworkInitClientConnect()
                     if (RunJoiningGameMenu() ~= 0) then
                        -- connect failed
                     else
                        -- connection worked and we returned, don't try the next IP
                        break
                     end
                  end
               end
               hasJoinedGame = false
            end
         end
         MetaClient:PopNextMessage()
      end
   end

   local function keepalive()
      if needsRefresh then
         needsRefresh = false
         timeout = 0
         MetaClient:Send("LIST")
      else
         MetaClient:Send("PING")
      end
   end

   local function login()
      if nickInput:getText() ~= nick then
         nick = nickInput:getText()
         needsLogin = true
      end
      if needsLogin then
         if nick ~= "" then
            needsLogin = false
            MetaClient:Send("LOGIN " .. nick)
            timeout = 0
         end
      end
      return not needsLogin
   end

   local function connect()
      if serverInput:getText() ~= (wc1.preferences.MetaServer .. ":" .. tostring(wc1.preferences.MetaPort)) then
         print("Server changed")
         needsConnection = true
      end
      if needsConnection then
         print("Connecting")
         local ip = string.find(serverInput:getText(), ":")
         local host
         local port
         if ip ~= nil then
            host = string.sub(serverInput:getText(), 1, ip - 1)
            port = tonumber(string.sub(serverInput:getText(), ip + 1))
            if (port == 0) then port = 7775 end
         else
            host = string.sub(serverInput:getText(), 1)
            port = 7775
         end
         if host ~= "" then
            MetaClient:Close()
            wc1.preferences.MetaServer = host
            wc1.preferences.MetaPort = port
            SavePreferences()
            MetaClient:SetMetaServer(host, port)
            if MetaClient:Init() == 0 then
               needsConnection = false
               timeout = 0
            end
         end
      end
      return not needsConnection
   end

   local function loop()
      if timeout == 0 then
         timeout = 100
         if connect() then
            if login() then
               keepalive()
            end
            process_metaserver_events()
         end
      else
         timeout = timeout - 1
      end
   end

   listener = LuaActionListener(loop)
   menu:addLogicCallback(listener)
   menu:run()
   ExitNetwork1()
end

joincounter = 0

function RunJoiningMapMenu(s)
  local menu
  local listener
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local numplayers = 3
  local state
  local d

  menu = WarMenu("Joining game: Map")

  menu:writeLargeText("Map", sx, sy*3)
  menu:writeText("File:", sx, sy*3+30)
  maptext = menu:writeText(NetworkMapName, sx+50, sy*3+30)
  menu:writeText("Players:", sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText("Description:", sx, sy*3+70)
  descr = menu:writeText(description, sx+20, sy*3+90)

  local fow = menu:addCheckBox("Fog of war", sx, sy*3+120, function() end)
  fow:setMarked(true)
  ServerSetupState.FogOfWar = 1
  fow:setEnabled(false)
  local revealmap = menu:addCheckBox("Reveal map", sx, sy*3+150, function() end)
  revealmap:setEnabled(false)

  menu:writeText("~<Your Race:~>", sx, sy*11)
  local race = menu:addDropDown({"Map Default", "Human", "Orc"}, sx + 100, sy*11, function() end)
  local raceCb = function(dd)
     GameSettings.Presets[NetLocalHostsSlot].Race = race:getSelected()
     LocalSetupState.Race[NetLocalHostsSlot] = race:getSelected()
  end
  race:setActionCallback(raceCb)
  race:setSize(190, 20)

  menu:writeText("Units:", sx, sy*11+25)
  local units = menu:addDropDown({"Map Default", "One Peasant Only"}, sx + 100, sy*11+25,
    function(dd) end)
  units:setSize(190, 20)
  units:setEnabled(false)

  menu:writeText("Resources:", sx, sy*11+50)
  local resources = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, sx + 100, sy*11+50,
    function(dd) end)
  resources:setSize(190, 20)
  resources:setEnabled(false)

  local OldPresentMap = PresentMap
  PresentMap = function(desc, nplayers, w, h, id)
    numplayers = nplayers
    players:setCaption(""..nplayers)
    players:adjustSize()
    descr:setCaption(desc)
    descr:adjustSize()
    OldPresentMap(desc, nplayers, w, h, id)
  end

  -- Security: The map name is checked by the stratagus engine.
  Load(NetworkMapName)
  local function readycb(dd)
     LocalSetupState.Ready[NetLocalHostsSlot] = bool2int(dd:isMarked())
  end
  menu:addCheckBox("~!Ready", sx*11,  sy*14, readycb)

  local updatePlayersList = addPlayersList(menu, numplayers)

  joincounter = 0
  local function listen()
    NetworkProcessClientRequest()
    fow:setMarked(int2bool(ServerSetupState.FogOfWar))
    GameSettings.NoFogOfWar = not int2bool(ServerSetupState.FogOfWar)
    revealmap:setMarked(int2bool(ServerSetupState.RevealMap))
    GameSettings.RevealMap = ServerSetupState.RevealMap
    units:setSelected(ServerSetupState.UnitsOption)
    GameSettings.NumUnits = ServerSetupState.UnitsOption
    resources:setSelected(ServerSetupState.ResourcesOption)
    GameSettings.Resources = ServerSetupState.ResourcesOption
    updatePlayersList()
    state = GetNetworkState()
    -- FIXME: don't use numbers
    if (state == 15) then -- ccs_started, server started the game
      SetThisPlayer(1)
      joincounter = joincounter + 1
      if (joincounter == 30) then
        SetFogOfWar(fow:isMarked())
        if revealmap:isMarked() == true then
          RevealMap()
        end
        NetworkGamePrepareGameSettings()
        war1gus.InCampaign = false
        RunMap(NetworkMapName, fow:isMarked())
        PresentMap = OldPresentMap
        menu:stop()
      end
    elseif (state == 10) then -- ccs_unreachable
      ErrorMenu("Cannot reach server")
      menu:stop()
    end
  end
  listener = LuaActionListener(listen)
  menu:addLogicCallback(listener)

  menu:addFullButton("~!Cancel", "c", Video.Width / 2 - 100, Video.Height - 100,
    function() NetworkDetachFromServer(); menu:stop() end)

  menu:run()
end

function RunJoiningGameMenu(s)
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Connecting to server", 144, 11)

  local percent = 0

  local sb = StatBoxWidget(258, 30)
  sb:setCaption("Connecting...")
  sb:setPercent(percent)
  menu:add(sb, 15, 38)
  sb:setBackgroundColor(dark)

  local function checkconnection()
    NetworkProcessClientRequest()
    percent = percent + 100 / (24 * GetGameSpeed()) -- 24 seconds * fps
    sb:setPercent(percent)
    local state = GetNetworkState()
    -- FIXME: do not use numbers
    if (state == 3) then -- ccs_mapinfo
      -- got ICMMap => load map
      RunJoiningMapMenu()
      menu:stop(0)
    elseif (state == 4) then -- ccs_badmap
      ErrorMenu("Map not available")
      menu:stop(1)
    elseif (state == 10) then -- ccs_unreachable
      ErrorMenu("Cannot reach server")
      menu:stop(1)
    elseif (state == 12) then -- ccs_nofreeslots
      ErrorMenu("Server is full")
      menu:stop(1)
    elseif (state == 13) then -- ccs_serverquits
      ErrorMenu("Server gone")
      menu:stop(1)
    elseif (state == 16) then -- ccs_incompatibleengine
      ErrorMenu("Incompatible engine version")
      menu:stop(1)
    elseif (state == 17) then -- ccs_incompatibleluafiles
      ErrorMenu("Incompatible lua files")
      menu:stop(1)
    end
  end
  local listener = LuaActionListener(checkconnection)
  menu:addLogicCallback(listener)

  menu:addHalfButton("Cancel (~<Esc~>)", "escape", 83, 80,
    function() menu:stop(1) end)

  menu:run()
end

function RunJoinIpMenu()
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(288, 128)
  menu:setPosition((Video.Width - 288) / 2, (Video.Height - 128) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Enter server IP-address:", 144, 11)
  local server = menu:addTextInputField("localhost", 40, 38, 212)

  menu:addHalfButton("~!OK", "o", 15, 80,
    function(s)
      -- FIXME: allow port ("localhost:1234")
      if (NetworkSetupServerAddress(server:getText()) ~= 0) then
        ErrorMenu("Invalid server name")
        return
      end
      NetworkInitClientConnect()
      if (RunJoiningGameMenu() ~= 0) then
        -- connect failed, don't leave this menu
        return
      end
      menu:stop()
    end
  )
  menu:addHalfButton("~!Cancel", "c", 145, 80, function() menu:stop() end)

  menu:run()
end

function RunServerMultiGameMenu(map, description, numplayers, optionalGameid)
  local menu
  local sx = Video.Width / 20
  local sy = Video.Height / 20
  local startgame
  local d

  menu = WarMenu("Create MultiPlayer game")

  menu:writeLargeText("Map", sx, sy*3)
  menu:writeText("File:", sx, sy*3+30)
  maptext = menu:writeText(map, sx+50, sy*3+30)
  menu:writeText("Players:", sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText("Description:", sx, sy*3+70)
  descr = menu:writeText("Unknown map", sx+20, sy*3+90)

  local function fowCb(dd)
    ServerSetupState.FogOfWar = bool2int(dd:isMarked())
    NetworkServerResyncClients()
    GameSettings.NoFogOfWar = not dd:isMarked()
  end
  local fow = menu:addCheckBox("Fog of war", sx, sy*3+120, fowCb)
  fow:setMarked(true)
  local function revealMapCb(dd)
    ServerSetupState.RevealMap = bool2int(dd:isMarked())
    NetworkServerResyncClients()
    GameSettings.RevealMap = bool2int(dd:isMarked())
  end
  local revealmap = menu:addCheckBox("Reveal map", sx, sy*3+150, revealMapCb)

  menu:writeText("Race:", sx, sy*11)
  local race = menu:addDropDown({"Map Default", "Human", "Orc"}, sx + 100, sy*11, function(dd) end)
  local raceCb = function(arg)
     GameSettings.Presets[0].Race = race:getSelected()
     ServerSetupState.Race[0] = race:getSelected()
     LocalSetupState.Race[0] = race:getSelected()
     NetworkServerResyncClients()
  end
  race:setActionCallback(raceCb)
  race:setSize(190, 20)

  menu:writeText("Units:", sx, sy*11+25)
  d = menu:addDropDown({"Map Default", "One Peasant Only"}, sx + 100, sy*11+25,
    function(dd)
      GameSettings.NumUnits = dd:getSelected()
      ServerSetupState.UnitsOption = GameSettings.NumUnits
      NetworkServerResyncClients()
    end)
  d:setSize(190, 20)

  menu:writeText("Resources:", sx, sy*11+50)
  d = menu:addDropDown({"Map Default", "Low", "Medium", "High"}, sx + 100, sy*11+50,
    function(dd)
      GameSettings.Resources = dd:getSelected()
      ServerSetupState.ResourcesOption = GameSettings.Resources
      NetworkServerResyncClients()
    end)
  d:setSize(190, 20)

  local updatePlayers = addPlayersList(menu, numplayers)

  NetworkMapName = map
  NetworkInitServerConnect(numplayers)
  ServerSetupState.FogOfWar = 1
  startgame = menu:addFullButton("~!Start Game", "s", sx * 11,  sy*14,
    function(s)
      SetFogOfWar(fow:isMarked())
      if revealmap:isMarked() == true then
        RevealMap()
      end
      NetworkServerStartGame()
      NetworkGamePrepareGameSettings()
      war1gus.InCampaign = false
      RunMap(map, fow:isMarked())
      menu:stop()
    end
  )
  startgame:setVisible(false)
  local waitingtext = menu:writeText("Waiting for players", sx*11, sy*14)
  local function updateStartButton(ready)
    startgame:setVisible(ready)
    waitingtext:setVisible(not ready)
  end

  local pingTimeout = 100
  local listener = LuaActionListener(function(s)
        if optionalGameid ~= nil then
           -- keep connection to metaserver alive
           pingTimeout = pingTimeout - 1
           if pingTimeout < 0 then
              pingTimeout = 100
              MetaClient:Send("PING")
              while MetaClient:GetLogSize() > 0 do
                 MetaClient:PopNextMessage()
              end
           end
        end
        updateStartButton(updatePlayers())
  end)
  menu:addLogicCallback(listener)

  menu:addFullButton("~!Cancel", "c", Video.Width / 2 - 100, Video.Height - 100,
                     function()
                        if optionalGameid ~= nil then
                           MetaClient:Send("CANCEL " .. tostring(optionalGameid))
                        end
                        menu:stop()
                     end
  )

  menu:run()
end

function RunCreateMultiGameMenu(callback)
  local menu
  local map = "No Map"
  local description = "No map"
  local mapfile = "maps/forest1.smp.gz"
  local numplayers = 3
  local sx = Video.Width / 20
  local sy = Video.Height / 20

  menu = WarMenu("Create MultiPlayer game")

  menu:writeText("File:", sx, sy*3+30)
  maptext = menu:writeText(mapfile, sx+50, sy*3+30)
  menu:writeText("Players:", sx, sy*3+50)
  players = menu:writeText(numplayers, sx+70, sy*3+50)
  menu:writeText("Description:", sx, sy*3+70)
  descr = menu:writeText(description, sx+20, sy*3+90)

  local OldPresentMap = PresentMap
  PresentMap = function(desc, nplayers, w, h, id)
    numplayers = nplayers
    players:setCaption(""..numplayers)
    players:adjustSize()
    description = desc
    descr:setCaption(desc)
    descr:adjustSize()
    OldPresentMap(desc, nplayers, w, h, id)
  end

  Load(mapfile)
  local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$", sx*10, sy*2+20, sx*8, sy*11)
  local function cb(s)
    mapfile = browser.path .. browser:getSelectedItem()
    Load(mapfile)
    maptext:setCaption(mapfile)
    maptext:adjustSize()
  end
  browser:setActionCallback(cb)

  menu:addFullButton("~!Create Game", "c", sx,  sy*11,
    function(s)
      callback(mapfile, description, numplayers)
      menu:stop()
    end
  )

  menu:addFullButton("Cancel (~<Esc~>)", "escape", sx,  sy*12+25,
    function() menu:stop() end)

  menu:run()
  PresentMap = OldPresentMap
end

function RunMultiPlayerGameMenu(s)
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local nick

  InitGameSettings()
  InitNetwork1()

  menu:writeText(_("Nickname :"), 208 + offx, 264 + offy)
  nick = menu:addTextInputField(GetLocalPlayerName(), offx + 298, 260 + offy)

  menu:addFullButton("~!Join Game", "j", 208 + offx, 320 + (36 * 0) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunJoinIpMenu()
      menu:stop()
    end)
  menu:addFullButton("~!Create Game", "c", 208 + offx, 320 + (36 * 1) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunCreateMultiGameMenu(RunServerMultiGameMenu)
      menu:stop()
    end)

  menu:addFullButton("~!Previous Menu", "p", 208 + offx, 320 + (36 * 2) + offy,
    function() menu:stop() end)

  menu:run()

  ExitNetwork1()
end
