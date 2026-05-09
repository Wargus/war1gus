local ARGS = ...

Load("scripts/stratagus.lua")
SetTitleScreens({})
CustomStartup = function() end

local function log(message)
  print(message)
  if io and io.stdout then
    io.stdout:flush()
  end
end

local function usage()
  print("Server startup file for War1gus options. Options are passed as comma-separated pairs")
  print("\t[server|client]")
  print("\t[numplayers=[number of connections to wait for before game starts]]")
  print("\t[ip=server-ip] -- only valid for client")
  print("\t[port=server-port] -- only valid for client")
  print("\t[race=(orc|human)]")
  print("\t[map=[map.smp]] -- only valid for server")
  print("\t[player=[nickname]]")
  print("\t[fow=(1|0)] -- only valid for server")
  print("\t[units=1] -- only valid for server (1 is for one peasant only)")
  print("\t[resources=(Low|Medium|High)] -- only valid for server")
  print("\t[reveal=(0|1)] -- only valid for server")
end

if (ARGS == "help") then
  usage()
else
  local isServer = string.match(ARGS, "(server)")
  local isClient = string.match(ARGS, "(client)")
  if (not (isClient or isServer)) then
    print("ERROR: Must say if client or server\n")
    usage()
    return
  end

  local ip = string.match(ARGS, "ip=([^,]+)")
  local port = tonumber(string.match(ARGS, "port=([^,]+)"))
  local racename = string.match(ARGS, "race=([^,]+)") or "default"
  local resources = string.match(ARGS, "resources=([^,]+)") or "default"
  local units = string.match(ARGS, "units=([^,]+)") or "default"
  local mapfile = string.match(ARGS, "map=([^,]+)")
  local nickname = string.match(ARGS, "player=([^,]+)")
  local numplayers = tonumber(string.match(ARGS, "numplayers=([^,]+)"))
  local fow = tonumber(string.match(ARGS, "fow=([^,]+)"))
  local reveal = tonumber(string.match(ARGS, "reveal=([^,]+)"))

  if (nickname) then SetLocalPlayerName(nickname) end

  if (isServer) then
    if (not (mapfile and numplayers)) then
      print("ERROR: Server must at least pass map and number of players\n")
      usage()
      return
    end

    CustomStartup = function()
      log("PYTEST_WAR1_MULTIPLAYER_SERVER_STARTUP")
      InitGameSettings()
      InitNetwork1()
      local playerCount = 0
      local description = ""
      local OldPresentMap = PresentMap
      PresentMap = function(desc, nplayers, w, h, id)
        description = desc
        OldPresentMap(desc, nplayers, w, h, id)
      end
      local oldDefinePlayerTypes = DefinePlayerTypes
      DefinePlayerTypes = function(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
        local ps = {p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15}
        playerCount = 0
        for _, s in pairs(ps) do
          if s == "person" then
            playerCount = playerCount + 1
          end
        end
        oldDefinePlayerTypes(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15)
      end
      Load(mapfile)
      log("PYTEST_WAR1_MULTIPLAYER_SERVER_MAP_LOADED " .. playerCount)
      if (playerCount == 0) then
        print("ERROR: could not open map " .. mapfile)
        return
      end
      if (playerCount == 1) then
        print("ERROR: not a multiplayer map " .. mapfile)
        return
      end
      RunServerMultiGameMenu(mapfile, description, playerCount,
        {race = racename,
          autostartNum = numplayers,
          resources = resources,
          units = units,
          fow = fow,
          revealmap = reveal})
    end
  else
    if (not ip) then
      print("ERROR: Client must at least pass server ip\n")
      usage()
      return
    end
    CustomStartup = function()
      log("PYTEST_WAR1_MULTIPLAYER_CLIENT_STARTUP")
      InitGameSettings()
      log("PYTEST_WAR1_MULTIPLAYER_CLIENT_INIT_SETTINGS_DONE")
      InitNetwork1()
      log("PYTEST_WAR1_MULTIPLAYER_CLIENT_INIT_NETWORK_DONE")
      NetworkSetupServerAddress(ip, port or 0)
      log("PYTEST_WAR1_MULTIPLAYER_CLIENT_ADDRESS_DONE")
      NetworkInitClientConnect()
      log("PYTEST_WAR1_MULTIPLAYER_CLIENT_CONNECT_DONE")
      RunJoiningGameMenu(racename, true)
      log("PYTEST_WAR1_MULTIPLAYER_CLIENT_MENU_DONE")
    end
  end
end
