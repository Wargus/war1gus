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
  menu:setSize(144, 64)
  menu:setPosition((Video.Width - 144) / 2, (Video.Height - 64) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Error:", 72, 5)

  local l = MultiLineLabel(errmsg)
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
end

function addPlayersList(menu, numplayers)
  local i
  local players_name = {}
  local players_state = {}
  local sx = Video.Width / 10
  local sy = Video.Height / 10
  local numplayers_text

  menu:writeLargeText("Players", sx * 11, sy*3)
  for i=1,8 do
    players_name[i] = menu:writeText("Player"..i, sx * 11, sy*4 + i*9)
    players_state[i] = menu:writeText("Preparing", sx * 11 + 40, sy*4 + i*9)
  end
  numplayers_text = menu:writeText("Open slots : " .. numplayers - 1, sx *11, sy*4 + 72)

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


joincounter = 0

function RunJoiningMapMenu(s)
  local menu
  local listener
  local sx = Video.Width / 10
  local sy = Video.Height / 10
  local numplayers = 3
  local state
  local d

  menu = WarMenu("Joining game: Map")
  
  local menubox = HBox({
        LFiller(),
        VBox({
              LFiller(),
              HBox({
                    "~<File: ",
                    LLabel("~<" .. NetworkMapName):id("maptext")
              }):withPadding(5),
              HBox({
                    "~<Players: ",
                    LLabel("~<" .. numplayers):id("players")
              }):withPadding(5),
              HBox({
                    "~<Description: ",
                    LLabel(description):id("description")
              }):withPadding(5),
              HBox({
                    VBox({
                          "Fog of war",
                          "Resources",
                          "Number of units",
                          "Terrain",
                          "Auto targeting",
                          "Allow multiple townhalls",
                          "Allow townhall upgrades",
                          "Enable training queue",
                          "Unit stats",
                          "Unit vision",
                    }):withPadding(5),
                    VBox({
                          LCheckBox(""):id("fow"),
                          LLabel("Map default"):id("resources"),
                          LLabel("Map default"):id("numunits"),
                          LLabel("Map default"):id("revealmap"),
                          LCheckBox(""):id("autotarget"),
                          LCheckBox(""):id("multitown"),
                          LCheckBox(""):id("towncastle"),
                          LLabel(""):id("rebalancedstats"),
                          LCheckBox(""):id("trainingqueue"),
                          LLabel(""):id("fieldofviewtype")
                    }):withPadding(5)
              }),
              LFiller()
        }):withPadding(5),
        LFiller(),
        VBox({
              LFiller(),
              VBox({
                    LListBox(Video.Width / 3, Video.Height / 3):id("chat"),
                    HBox({
                          "Chat: ",
                          LTextInputField("", function()
                           OnlineService.sendmessage(menu.chatinput:getText())
                           menu.chatinput:setText("")
                          end):id("chatinput")
                    })
              }):withPadding(1),
              HBox({
                    "~<Your Race:~> ",
                    LDropDown({"Map Default", "Human", "Orc"}, function(dd)
                          GameSettings.Presets[NetLocalHostsSlot].Race = race:getSelected()
                          LocalSetupState.Race[NetLocalHostsSlot] = race:getSelected()
                    end)
              }),
              LCheckBox("Ready", function(dd)
                           LocalSetupState.Ready[NetLocalHostsSlot] = bool2int(dd:isMarked())
              end),
              LButton("~!Cancel", "c", function() NetworkDetachFromServer(); menu:stop() end),
              LFiller()
        }):withPadding(10),
        LFiller()
  }):withPadding(5)

  menubox.width = Video.Width
  menubox.height = Video.Height
  menubox.x = 0
  menubox.y = 0
  menubox:addWidgetTo(menu)
  
  local chatList = {}
  local AddMessage = AddOnlineChatMessage(chatList, menu.chat)
  OnlineService.setup({ShowChat = AddMessage})

  menu.fow:setEnabled(false)
  menu.revealmap:setEnabled(false)
  menu.autotarget:setEnabled(false)
  menu.multitown:setEnabled(false)
  menu.towncastle:setEnabled(false)
  menu.trainingqueue:setEnabled(false)
  if preferences.RebalancedStats then
     menu.rebalancedstats:setCaption("Rebalanced")
  else
     menu.rebalancedstats:setCaption("Original")
  end
  menu.rebalancedstats:adjustSize()
  local OldPresentMap = PresentMap
  PresentMap = function(desc, nplayers, w, h, id)
    numplayers = nplayers
    menu.players:setCaption("~<"..nplayers)
    menu.players:adjustSize()
    menu.description:setCaption("~<" .. desc)
    menu.description:adjustSize()
    OldPresentMap(desc, nplayers, w, h, id)
  end

  -- Security: The map name is checked by the stratagus engine.
  Load(NetworkMapName)

  local updatePlayersList = addPlayersList(menu, numplayers)

  joincounter = 0
  local function listen()
    NetworkProcessClientRequest()
    menu.fow:setMarked(int2bool(ServerSetupState.FogOfWar))
    GameSettings.NoFogOfWar = not int2bool(ServerSetupState.FogOfWar)
    
    local revealTypes = {"Hidden", "Known", "Explored"}
    menu.revealmap:setCaption(revealTypes[ServerSetupState.RevealMap + 1])
    GameSettings.RevealMap = ServerSetupState.RevealMap

    GameSettings.NumUnits = ServerSetupState.UnitsOption
    if ServerSetupState.UnitsOption == 0 then
       menu.numunits:setCaption("Map default")
       GameSettings.NumUnits = -1
    elseif ServerSetupState.UnitsOption == 1 then
       menu.numunits:setCaption("Only 1 peasant")
    else
       menu.numunits:setCaption("Only " .. ServerSetupState.UnitsOption .. " units")
    end

    if ServerSetupState.ResourcesOption == 0 then
       menu.resources:setCaption("Map default")
       GameSettings.Resources = -1
    else
       menu.resources:setCaption("Level " .. ServerSetupState.ResourcesOption)
       GameSettings.Resources = ServerSetupState.ResourcesOption
    end

    GameSettings.MapRichness = ServerSetupState.MapRichness
    RestoreSharedSettingsFromBits(ServerSetupState.MapRichness)
    menu.autotarget:setMarked(preferences.SimplifiedAutoTargeting)
    menu.multitown:setMarked(preferences.AllowMultipleTownHalls)
    menu.towncastle:setMarked(preferences.AllowTownHallUpgrade)
    menu.trainingqueue:setMarked(preferences.TrainingQueue)
    if preferences.FieldOfViewType == "simple-radial" then
       menu.fieldofviewtype:setCaption("Radial")
    else
       menu.fieldofviewtype:setCaption("Shadow Casting")
    end
    menu.fieldofviewtype:adjustSize()

    updatePlayersList()
    state = GetNetworkState()
    -- FIXME: don't use numbers
    if (state == 15) then -- ccs_started, server started the game
      SetThisPlayer(1)
      joincounter = joincounter + 1
      if (joincounter == 30) then
        if StoreSharedSettingsInBits() ~= GameSettings.MapRichness then
           -- try one more time, then give up
           RestoreSharedSettingsFromBits(GameSettings.MapRichness, function(msg)
                 ErrorMenu(msg)
                 menu:stop()
           end)
        end
        NetworkGamePrepareGameSettings()
        war1gus.InCampaign = false
        RunMap(NetworkMapName, menu.fow:isMarked(), GameSettings.RevealMap)
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

  menu:run()
end

function RunJoiningGameMenu(s)
  local menu = WarMenu(nil, panel(4), false)
  menu:setSize(144, 64)
  menu:setPosition((Video.Width - 144) / 2, (Video.Height - 64) / 2)
  menu:setDrawMenusUnder(true)

  menu:addLabel("Connecting to server", 72, 5)

  local percent = 0

  local sb = StatBoxWidget(129, 15)
  sb:setCaption("Connecting...")
  sb:setPercent(percent)
  menu:add(sb, 7, 19)
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

  menu:addHalfButton("Cancel (~<Esc~>)", "escape", 41, 40,
    function() menu:stop(1) end)

  menu:run()
end

function RunJoinIpMenu()
  local menu = WarMenu()
  local offx = Video.Width / 2
  local offy = Video.Height / 2 - 30
  local padding = 4

  InitGameSettings()
  InitNetwork1()

  local connectLabel = menu:writeText("Connect to IP:", offx, offy)
  connectLabel:setX(offx - connectLabel:getWidth() - padding) -- place left of center
  local server = menu:addTextInputField("", offx + padding, offy) -- place right of connectLabel

  local serverLabel = menu:addLabel(_("Discovered servers"), offx, offy + server:getHeight() + padding)
  local servers = {}
  local serverlist = menu:addListBox(offx - 50, serverLabel:getY() + serverLabel:getHeight() + padding, 100, 50, servers)
  local function ServerListUpdate()
    servers = NetworkDiscoverServers(true)
    serverlist:setList(servers)
  end
  ServerListUpdate()
  local counter = 30
  local listener = LuaActionListener(function(s)
        if counter == 0 then
           counter = 300
           ServerListUpdate()
        else
           counter = counter - 1
        end
  end)
  menu:addLogicCallback(listener)

  local okBtn = menu:addHalfButton("~!Connect", "c", offx, serverlist:getY() + serverlist:getHeight() + padding * 4,
    function(s)
      local serverText = server:getText()
      if #serverText == 0 then
        local idx = serverlist:getSelected() + 1
        if idx > 0 then
          serverText = servers[idx]
        end
      end
      local ip = string.match(serverText, "[0-9\.]+")
      if (NetworkSetupServerAddress(ip) ~= 0) then
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
  okBtn:setX(offx - okBtn:getWidth() - padding)

  menu:addHalfButton("~!Previous Menu", "p", offx + padding, okBtn:getY(), function() menu:stop() end)

  menu:run()
end

function RunServerMultiGameMenu(map, description, numplayers)
  local menu
  local sx = Video.Width / 10
  local sy = Video.Height / 10
  local startgame
  local d

  menu = WarMenu("Create MultiPlayer game")

  local menubox = HBox({
        LFiller(),
        VBox({
              LFiller(),
              HBox({
                    "~<File: ",
                    LLabel("~<" .. map):id("maptext")
              }):withPadding(5),
              HBox({
                    "~<Players: ",
                    LLabel("~<" .. numplayers):id("players")
              }):withPadding(5),
              HBox({
                    "~<Description: ",
                    LLabel(description):id("description")
              }):withPadding(5),
              HBox({
                    VBox({
                          "Fog of war",
                          "Resources",
                          "Number of units",
                          "Terrain",
                          "Auto targeting",
                          "Allow multiple townhalls",
                          "Allow townhall upgrades",
                          "Enable training queue",
                          "Unit stats",
                          "Unit vision",
                    }):withPadding(5),
                    VBox({
                          LCheckBox("", function(dd)
                                       ServerSetupState.FogOfWar = bool2int(dd:isMarked())
                                       NetworkServerResyncClients()
                                       GameSettings.NoFogOfWar = not dd:isMarked()
                          end
                          ):id("fow"),
                          LDropDown({"Map Default", "Low", "Medium", "High"}, function(dd)
                                GameSettings.Resources = dd:getSelected()
                                ServerSetupState.ResourcesOption = GameSettings.Resources
                                if GameSettings.Resources == 0 then
                                   GameSettings.Resources = -1
                                end
                                NetworkServerResyncClients()
                          end):id("resources"),
                          LDropDown({"Map Default", "One Peasant Only"}, function(dd)
                                GameSettings.NumUnits = dd:getSelected()
                                ServerSetupState.UnitsOption = GameSettings.NumUnits
                                if GameSettings.NumUnits == 0 then
                                   GameSettings.NumUnits = -1
                                end
                                NetworkServerResyncClients()
                          end):id("numunits"),
                          LDropDown({"Hidden", "Known", "Explored"}, function(dd)
                                       ServerSetupState.RevealMap = dd:getSelected()
                                       NetworkServerResyncClients()
                                       GameSettings.RevealMap = dd:getSelected()
                          end):id("revealmap"),
                          LCheckBox("", function(dd)
                                       preferences.SimplifiedAutoTargeting = dd:isMarked()
                                       ServerSetupState.MapRichness = StoreSharedSettingsInBits()
                                       GameSettings.MapRichness = StoreSharedSettingsInBits()
                                       NetworkServerResyncClients()
                                       RestoreSharedSettingsFromBits(GameSettings.MapRichness)
                          end):id("autotarget"),
                          LCheckBox("", function(dd)
                                       preferences.AllowMultipleTownHalls = dd:isMarked()
                                       ServerSetupState.MapRichness = StoreSharedSettingsInBits()
                                       GameSettings.MapRichness = StoreSharedSettingsInBits()
                                       NetworkServerResyncClients()
                                       RestoreSharedSettingsFromBits(GameSettings.MapRichness)
                          end):id("multitown"),
                          LCheckBox("", function(dd)
                                       preferences.AllowTownHallUpgrade = dd:isMarked()
                                       ServerSetupState.MapRichness = StoreSharedSettingsInBits()
                                       GameSettings.MapRichness = StoreSharedSettingsInBits()
                                       NetworkServerResyncClients()
                                       RestoreSharedSettingsFromBits(GameSettings.MapRichness)
                          end):id("towncastle"),
                          LCheckBox("", function(dd)
                                       preferences.TrainingQueue = dd:isMarked()
                                       ServerSetupState.MapRichness = StoreSharedSettingsInBits()
                                       GameSettings.MapRichness = StoreSharedSettingsInBits()
                                       NetworkServerResyncClients()
                                       RestoreSharedSettingsFromBits(GameSettings.MapRichness)
                          end):id("trainingqueue"),
                          LLabel(""):id("rebalancedstats"),
                          LDropDown({"Radial", "Shadow Casting"}, function(dd)
                                if dd:getSelected() == 0 then
                                   preferences.FieldOfViewType = "simple-radial"
                                   preferences.DungeonSightBlocking = false
                                else
                                   preferences.FieldOfViewType = "shadow-casting"
                                   preferences.DungeonSightBlocking = true
                                end
                                ServerSetupState.MapRichness = StoreSharedSettingsInBits()
                                GameSettings.MapRichness = StoreSharedSettingsInBits()
                                NetworkServerResyncClients()
                                RestoreSharedSettingsFromBits(GameSettings.MapRichness)
                          end):id("fieldofviewtype"),
                    }):withPadding(5)
              }),
              LFiller()
        }):withPadding(5),
        LFiller(),
        VBox({
              LFiller(),
              VBox({
                    LListBox(Video.Width / 3, Video.Height / 3):id("chat"),
                    HBox({
                          "Chat: ",
                          LTextInputField("", function()
                           OnlineService.sendmessage(menu.chatinput:getText())
                           menu.chatinput:setText("")
                          end):id("chatinput")
                    })
              }):withPadding(1),
              HBox({
                    "~<Your Race:~> ",
                    LDropDown({"Map Default", "Human", "Orc"}, function(dd)
                          GameSettings.Presets[0].Race = race:getSelected()
                          ServerSetupState.Race[0] = race:getSelected()
                          LocalSetupState.Race[0] = race:getSelected()
                          NetworkServerResyncClients()
                    end)
              }),
              LButton("~!Start Game", "s", function(s)
                        NetworkServerStartGame()
                        NetworkGamePrepareGameSettings()
                        war1gus.InCampaign = false
                        RunMap(map, menu.fow:isMarked(), GameSettings.RevealMap)
                        menu:stop()
              end):id("startgame"),
              LLabel("Waiting for players"):id("waitingtext"),
              LButton("~!Cancel", "c", function()
                         InitGameSettings()
                         OnlineService.stopadvertising()
                         menu:stop()
              end),
              LFiller()
        }):withPadding(10),
        LFiller()
  }):withPadding(5)


  menubox.width = Video.Width
  menubox.height = Video.Height
  menubox.x = 0
  menubox.y = 0
  menubox:addWidgetTo(menu)

  local chatList = {}
  local AddMessage = AddOnlineChatMessage(chatList, menu.chat)
  OnlineService.setup({ShowChat = AddMessage})

  menu.fow:setMarked(true)
  menu.startgame:setVisible(false)

  local updatePlayers = addPlayersList(menu, numplayers)

  NetworkMapName = map
  NetworkInitServerConnect(numplayers)
  ServerSetupState.MapRichness = StoreSharedSettingsInBits()
  GameSettings.MapRichness = StoreSharedSettingsInBits()
  ServerSetupState.FogOfWar = 1

  menu.autotarget:setMarked(preferences.SimplifiedAutoTargeting)
  menu.multitown:setMarked(preferences.AllowMultipleTownHalls)
  menu.towncastle:setMarked(preferences.AllowTownHallUpgrade)
  menu.trainingqueue:setMarked(preferences.TrainingQueue)
  if preferences.RebalancedStats then
     menu.rebalancedstats:setCaption("Rebalanced")
  else
     menu.rebalancedstats:setCaption("Original")
  end
  menu.rebalancedstats:adjustSize()
  if preferences.FieldOfViewType == "simple-radial" then
     menu.fieldofviewtype:setSelected(0)
  else
     menu.fieldofviewtype:setSelected(1)
  end

  local function updateStartButton(ready)
     menu.startgame:setVisible(ready)
     menu.waitingtext:setVisible(not ready)
  end

  local listener = LuaActionListener(function(s) updateStartButton(updatePlayers()) end)
  menu:addLogicCallback(listener)
  OnlineService.startadvertising()

  menu:run()
end

function RunCreateMultiGameMenu(s)
  local menu
  local map = "No Map"
  local description = "No map"
  local mapfile = "maps/forest1.smp.gz"
  local numplayers = 3
  local sx = Video.Width / 10
  local sy = Video.Height / 10

  menu = WarMenu("Create MultiPlayer game")

  menu:writeText("File:", sx, sy*3+15)
  maptext = menu:writeText(mapfile, sx+25, sy*3+15)
  menu:writeText("Players:", sx, sy*3+25)
  players = menu:writeText(numplayers, sx+35, sy*3+25)
  menu:writeText("Description:", sx, sy*3+35)
  descr = menu:writeText(description, sx+10, sy*3+45)

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
  local browser = menu:addBrowser("maps/", "^.*%.smp%.?g?z?$", sx*5, sy*2+10, sx*8, sy*5)
  local function cb(s)
    mapfile = browser.path .. browser:getSelectedItem()
    Load(mapfile)
    maptext:setCaption(mapfile)
    maptext:adjustSize()
  end
  browser:setActionCallback(cb)

  menu:addFullButton("~!Create Game", "c", sx,  sy*6,
    function(s)
      if (browser:getSelected() < 0) then
        return
      end
      RunServerMultiGameMenu(mapfile, description, numplayers)
      menu:stop()
    end
  )

  menu:addFullButton("Cancel (~<Esc~>)", "escape", sx,  sy*7+12,
    function() menu:stop() end)

  menu:run()
  PresentMap = OldPresentMap
end

function RunMultiPlayerGameMenu(s)
  local menu = WarMenu()
  local offx = (Video.Width - 320) / 2
  local offy = (Video.Height - 200) / 2 - 30

  InitGameSettings()
  InitNetwork1()

  menu:writeText(_("Nickname :"), 104 + offx, 131 + offy)
  local nick = menu:addTextInputField(GetLocalPlayerName(), offx + 149, 130 + offy)
  menu:writeText(_("Password :"), 104 + offx, 131 + offy + 18)
  local pass = menu:addTextInputField("", offx + 149, 130 + offy + 18)
  pass:setPassword(true)

  local loginBtn = menu:addHalfButton(_("Go ~!Online"), "o", 104 + offx, 160 + (18 * 0) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        wc1.preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      if string.len(pass:getText()) == 0 then
         ErrorMenu("Please enter your password")
      else
         OnlineService.setup({ ShowError = ErrorMenu })
         OnlineService.connect(wc1.preferences.OnlineServer, wc1.preferences.OnlinePort)
         OnlineService.login(nick:getText(), pass:getText())
         RunOnlineMenu()
      end
  end)
  local signupLabel = menu:addLabel(
     _("Sign up"),
     loginBtn:getWidth() + loginBtn:getX() + loginBtn:getWidth() / 2,
     loginBtn:getY() + loginBtn:getHeight() / 4)
  local signUpCb = function(evt, btn, cnt)
     if evt == "mouseClick" then

        local signUpMenu
        signUpMenu = WarMenuWithLayout(panel(1), VBox({
              LFiller(),

              VBox({
                    LFiller(),
                    "Choose a username and password to sign up to",
                    wc1.preferences.OnlineServer,
                    "Don't choose a password you are using elsewhere.",
                    "The password is sent to the server using the same",
                    "method that the original Battle.net clients used,",
                    "which can be broken. The server will store your",
                    "username, password hash, last login time, last IP,",
                    "and game stats (wins/losses/draws. By signing up,",
                    "you agree to this data storage.",
                    LFiller(),
              }),

              HBox({
                    "Username:",
                    LTextInputField(""):expanding():id("newnick"),
              }):withPadding(5),

              HBox({
                    "Password:",
                    LTextInputField(""):expanding():id("newpass"),
              }):withPadding(5),

              HBox({
                    LFiller(),
                    LButton("~!OK", "o", function()
                               if string.len(signUpMenu.newpass:getText()) == 0 then
                                  ErrorMenu("Please choose a password for the new account")
                               else
                                  if signUpMenu.newnick:getText() ~= GetLocalPlayerName() then
                                     SetLocalPlayerName(signUpMenu.newnick:getText())
                                     nick:setText(signUpMenu.newnick:getText())
                                     wc1.preferences.PlayerName = signUpMenu.newnick:getText()
                                     SavePreferences()
                                  end
                                  OnlineService.setup({ ShowError = ErrorMenu })
                                  OnlineService.connect(wc1.preferences.OnlineServer, wc1.preferences.OnlinePort)
                                  OnlineService.signup(signUpMenu.newnick:getText(), signUpMenu.newpass:getText())
                                  RunOnlineMenu()
                               end
                               signUpMenu:stop()
                    end),
                    LButton("~!Cancel", "c", function()
                               signUpMenu:stop()
                    end),
                    LFiller()
              }):withPadding(5),

              LFiller(),

        }):withPadding(5))

        signUpMenu:run()
     end
  end
  local signUpListener = LuaActionListener(signUpCb)
  signupLabel:addMouseListener(signUpListener)

  menu:addFullButton("~!Join Game", "j", 104 + offx, 160 + (18 * 1) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunJoinIpMenu()
      menu:stop()
    end)
  menu:addFullButton("~!Create Game", "c", 104 + offx, 160 + (18 * 2) + offy,
    function()
      if nick:getText() ~= GetLocalPlayerName() then
        SetLocalPlayerName(nick:getText())
        preferences.PlayerName = nick:getText()
        SavePreferences()
      end
      RunCreateMultiGameMenu()
      menu:stop()
    end)

  menu:addFullButton("~!Previous Menu", "p", 104 + offx, 160 + (18 * 3) + offy,
    function() menu:stop() end)

  menu:run()

  ExitNetwork1()
end

function AddOnlineChatMessage(list, listbox)
   return function(str, pre, suf)
      for line in string.gmatch(str, "([^".. string.char(10) .."]+)") do
      if pre and suf then
         table.insert(list, pre .. line .. suf)
      else
         table.insert(list, line)
      end
      end
      listbox:setList(list)
      listbox:scrollToBottom()
   end
end

function RunOnlineMenu()
  local counter = 0

  local menu = WarMenu("Online")

  local margin = 5
  local btnHeight = 19
  local listWidth = 65

  local userLabel = menu:addLabel(_("Users"), margin, margin, nil, false)
  local userList = {}
  local users = menu:addListBox(
     userLabel:getX(),
     userLabel:getY() + userLabel:getHeight(),
     listWidth,
     Video.Height / 4,
     userList
  )

  local friendLabel = menu:addLabel(_("Friends"), margin, users:getY() + users:getHeight() + margin, nil, false)
  local friends = menu:addListBox(
     friendLabel:getX(),
     friendLabel:getY() + friendLabel:getHeight(),
     users:getWidth(),
     users:getHeight(),
     {}
  )

  local channelLabel = menu:addLabel(_("Channels"), margin, friends:getY() + friends:getHeight() + margin, nil, false)
  local channelList = {}
  local selectedChannelIdx = -1
  local channels = menu:addListBox(
     channelLabel:getX(),
     channelLabel:getY() + channelLabel:getHeight(),
     users:getWidth(),
     users:getHeight(),
     channelList
  )
  local channelSelectCb = function()
     OnlineService.joinchannel(channelList[channels:getSelected() + 1])
  end
  channels:setActionCallback(channelSelectCb)

  local gamesLabel = menu:addLabel(_("Games"), users:getX() + users:getWidth() + margin, userLabel:getY(), nil, false)
  local gamesObjectList = {}
  local gamesList = {}
  local games = menu:addListBox(
     gamesLabel:getX(),
     gamesLabel:getY() + gamesLabel:getHeight(),
     Video.Width - (users:getX() + users:getWidth() + margin) - margin,
     Video.Height / 6,
     gamesList
  )

  local messageLabel = menu:addLabel(_("Chat"), games:getX(), games:getY() + games:getHeight() + margin, nil, false)
  local messageList = {}
  local messages = menu:addListBox(
     messageLabel:getX(),
     messageLabel:getY() + messageLabel:getHeight(),
     games:getWidth(),
     Video.Height - (margin + messageLabel:getY() + messageLabel:getHeight()) - (btnHeight * 2) - (margin * 2),
     messageList
   )

  local input = menu:addTextInputField(
     "",
     messages:getX(),
     messages:getY() + messages:getHeight() + margin,
     messages:getWidth()
  )
  function inputActionCb()
        OnlineService.sendmessage(input:getText())
        input:setText("")
  end
  input:setActionCallback(inputActionCb)
  local createGame = menu:addHalfButton(
     _("~!Create Game"),
     "c",
     input:getX(),
     input:getY() + btnHeight,
     function()
        RunCreateMultiGameMenu()
        OnlineService.setup({ShowChat = AddMessage})
     end
  )
  createGame:setWidth((Video.Width - margin * 4 - listWidth) / 3)
  local joinGame = menu:addHalfButton(
     _("~!Join Game"),
     "j",
     createGame:getX() + createGame:getWidth() + margin,
     createGame:getY(),
     function()
        local selectedGame = gamesObjectList[games:getSelected() + 1]
        if selectedGame then
           local ip, port
           for k, v in string.gmatch(selectedGame.Host, "([0-9\.]+):(%d+)") do
              ip = k
              port = tonumber(v)
           end
           print("Attempting to join " .. ip .. ":" .. port)
           NetworkSetupServerAddress(ip, port)
           NetworkInitClientConnect()
           OnlineService.punchNAT(selectedGame.Creator)
           if (RunJoiningGameMenu() ~= 0) then
              -- connect failed, don't leave this menu
              return
           end
           OnlineService.setup({ShowChat = AddMessage})
        else
           ErrorMenu(_("No game selected"))
        end
     end
  )
  joinGame:setWidth(createGame:getWidth())
  local prevMenuBtn = menu:addHalfButton(
     _("~!Previous Menu"),
     "p",
     joinGame:getX() + joinGame:getWidth() + margin,
     joinGame:getY(),
     function()
        OnlineService.disconnect()
        menu:stop()
     end
  )
  prevMenuBtn:setWidth(createGame:getWidth())

  local AddUser = function(name)
     table.insert(userList, name)
     users:setList(userList)
  end

  local ClearUsers = function()
     for i,v in ipairs(userList) do
        table.remove(userList, i)
     end
     users:setList(userList)
  end

  local RemoveUser = function(name)
     for i,v in ipairs(userList) do
        if v == name then
           table.remove(userList, i)
        end
     end
     users:setList(userList)
  end

  local SetFriends = function(...)
     friendsList = {}
     for i,v in ipairs(arg) do
        table.insert(friendsList, v.Name .. "|" .. v.Product .. "(" .. v.Status .. ")")
     end
     friends:setList(friendsList)
  end
  
  local SetGames = function(...)
     gamesList = {}
     gamesObjectList = {}
     for i,game in ipairs(arg) do
        table.insert(gamesList, game.Map .. " " .. game.Creator .. ", type: " .. game.Type .. game.Settings .. ", slots: " .. game.MaxPlayers)
        table.insert(gamesObjectList, game)
     end
     games:setList(gamesList)
  end

  local SetChannels = function(...)
     channelList = {}
     for i,v in ipairs(arg) do
        table.insert(channelList, v)
     end
     channels:setList(channelList)
     channels:setSelected(selectedChannelIdx)
  end

  local SetActiveChannel = function(name)
     ClearUsers()
     local index = {}
     for k,v in pairs(channelList) do
        if v == name then
           selectedChannelIdx = k - 1
           return
        end
     end
     selectedChannelIdx = -1
  end
  
  local AddMessage = AddOnlineChatMessage(messageList, messages)

  local ShowInfo = function(errmsg)
     AddMessage(errmsg, "~<", "~>")
  end

  local lastError = nil
  local ShowError = function(errmsg)
     AddMessage(errmsg, "~red~", "~>")
     lastError = errmsg
  end

  local ShowUserInfo = function(info)
     local s = {"UserInfo", string.char(10)}
     for k, v in pairs(info) do
        s[#s+1] = string.char(10)
        s[#s+1] = k
        s[#s+1] = ": "
        s[#s+1] = v
     end
     s = table.concat(s)
     ShowError(s)
  end

  OnlineService.setup({
        AddUser = AddUser,
        RemoveUser = RemoveUser,
        SetFriends = SetFriends,
        SetGames = SetGames,
        SetChannels = SetChannels,
        SetActiveChannel = SetActiveChannel,
        ShowChat = AddMessage,
        ShowInfo = ShowInfo,
        ShowError = ShowError,
        ShowUserInfo = ShowUserInfo
  })

  -- check if we're connected, exit this menu if connection fails
  local goonline = true
  local timer = 10
  function checkLogin()
     if goonline then
        if timer > 0 then
           timer = timer - 1
        else
           timer = 10
           result = OnlineService.status()
           if result == "connected" then
              goonline = false
           elseif result ~= "connecting" then
              if lastError then
                 ErrorMenu(lastError)
              else
                 ErrorMenu(result)
              end
              menu:stop()
           end
        end
     else
        if timer < 239 then
           timer = timer + 1
        else
           timer = 0
        end
        local mod = timer % 60
        local div = timer / 60
        if mod == 0 then
           local timer
           local cap = "~<Chat"
           for i=1,div,1 do
              cap = cap .. "."
           end
           print(cap)
           messageLabel:setCaption(cap)
           messageLabel:adjustSize()
        end
     end
 end
 local listener = LuaActionListener(function(s) checkLogin() end)
 menu:addLogicCallback(listener)

 menu:run()
end
