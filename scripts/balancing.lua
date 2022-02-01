-- Everything in here is *changes* on top of the normal unit definitions for
-- better balancing in multiplayer and with War1gus features such as dynamic fog
-- of war and autocasting and such.

-----------------------------------------------------------------------
-- Sightrange Rebalancing Buildings
-----------------------------------------------------------------------

DefineUnitType("unit-human-farm",			{SightRange = 5})
DefineUnitType("unit-orc-farm",				{SightRange = 5})
DefineUnitType("unit-human-town-hall",		{SightRange = 5})
DefineUnitType("unit-orc-town-hall",		{SightRange = 5})
DefineUnitType("unit-human-barracks",		{SightRange = 5})
DefineUnitType("unit-orc-barracks", 		{SightRange = 5})
DefineUnitType("unit-human-lumber-mill",	{SightRange = 5})
DefineUnitType("unit-orc-lumber-mill", 		{SightRange = 5})
DefineUnitType("unit-human-stable",			{SightRange = 5})
DefineUnitType("unit-orc-kennel",			{SightRange = 5})
DefineUnitType("unit-human-blacksmith", 	{SightRange = 5})
DefineUnitType("unit-orc-blacksmith", 		{SightRange = 5})
DefineUnitType("unit-human-church",			{SightRange = 5})
DefineUnitType("unit-orc-temple",			{SightRange = 5})
DefineUnitType("unit-human-tower",			{SightRange = 5})
DefineUnitType("unit-orc-tower",			{SightRange = 5})
DefineUnitType("unit-stormwind-keep", 		{SightRange = 5})
DefineUnitType("unit-blackrock-spire", 		{SightRange = 5})

-----------------------------------------------------------------------
-- Sightrange Rebalancing Units
-----------------------------------------------------------------------

DefineUnitType("unit-peasant",			{SightRange = 4})
DefineUnitType("unit-peon",				{SightRange = 4})
DefineUnitType("unit-footman",			{SightRange = 4})
DefineUnitType("unit-grunt",			{SightRange = 4})
DefineUnitType("unit-archer",			{SightRange = 6})
DefineUnitType("unit-spearman",			{SightRange = 6})
DefineUnitType("unit-orc-catapult",		{SightRange = 4})
DefineUnitType("unit-human-catapult",	{SightRange = 4})
DefineUnitType("unit-raider",			{SightRange = 5})
DefineUnitType("unit-knight",			{SightRange = 4})
DefineUnitType("unit-conjurer",			{SightRange = 4})
DefineUnitType("unit-warlock",			{SightRange = 4, MaxAttackRange = 3})
DefineUnitType("unit-cleric",			{SightRange = 5, MaxAttackRange = 2})
DefineUnitType("unit-necrolyte",		{SightRange = 5})

DefineUnitType("unit-scorpion",			{SightRange = 4, Armor = 5})
DefineUnitType("unit-spider",			{SightRange = 4, MaxAttackRange = 3, Missile = "missile-web"})
DefineUnitType("unit-dead",				{SightRange = 4})
DefineUnitType("unit-daemon",			{SightRange = 5})
DefineUnitType("unit-water-elemental",	{SightRange = 6})

-----------------------------------------------------------------------
-- Cost Rebalancing Buildings
-----------------------------------------------------------------------

DefineUnitType("unit-human-town-hall",		{Costs = {"time", 250, "gold", 500,		"wood", 500},Armor = 10, Supply = 3})
DefineUnitType("unit-orc-town-hall",		{Costs = {"time", 250, "gold", 500,		"wood", 500},Armor = 10, Supply = 3})

DefineUnitType("unit-human-farm",			{Costs = {"time", 200, "gold", 500,		"wood", 300},Armor = 0})
DefineUnitType("unit-orc-farm",				{Costs = {"time", 200, "gold", 500,		"wood", 300},Armor = 0})
DefineUnitType("unit-human-barracks",		{Costs = {"time", 400, "gold", 600, 	"wood", 500},Armor = 10})
DefineUnitType("unit-orc-barracks",			{Costs = {"time", 400, "gold", 600, 	"wood", 500},Armor = 10})
DefineUnitType("unit-human-lumber-mill",	{Costs = {"time", 250, "gold", 600, 	"wood", 150},Armor = 5})
DefineUnitType("unit-orc-lumber-mill",		{Costs = {"time", 250, "gold", 600, 	"wood", 150},Armor = 5})

DefineUnitType("unit-human-stable",		  	{Costs = {"time", 300, "gold", 1000,	"wood", 400},Armor = 0})
DefineUnitType("unit-orc-kennel",			{Costs = {"time", 300, "gold", 1000, 	"wood", 400},Armor = 0})
DefineUnitType("unit-human-blacksmith",		{Costs = {"time", 300, "gold", 900, 	"wood", 400},Armor = 5})
DefineUnitType("unit-orc-blacksmith",		{Costs = {"time", 300, "gold", 900, 	"wood", 400},Armor = 5})

DefineUnitType("unit-human-church",			{Costs = {"time", 300, "gold", 700, 	"wood", 500},Armor = 5})
DefineUnitType("unit-orc-temple",			{Costs = {"time", 300, "gold", 700, 	"wood", 500},Armor = 5})
DefineUnitType("unit-human-tower",			{Costs = {"time", 400, "gold", 1400, 	"wood", 300},Armor = 10})
DefineUnitType("unit-orc-tower",			{Costs = {"time", 400, "gold", 1400, 	"wood", 300},Armor = 10})

DefineUnitType("unit-wall",					{Costs = {"time", 30,  "gold", 0,		"wood", 50}, Armor = 20})

DefineUnitType("unit-gold-mine",			{MaxOnBoard = 2})

DefineDependency("unit-human-barracks", { "unit-human-farm"} )
DefineDependency("unit-orc-barracks", { "unit-orc-farm"} )
DefineDependency("unit-human-lumber-mill", { "unit-human-barracks"} )
DefineDependency("unit-orc-lumber-mill", { "unit-orc-barracks"} )

-----------------------------------------------------------------------
-- Cost Rebalancing Units
-----------------------------------------------------------------------

DefineUnitType("unit-peasant",			{Costs = {"time", 75,  "gold", 350, "wood", 0},	AutoRepairRange = 4,})
DefineUnitType("unit-peon",				{Costs = {"time", 75,  "gold", 350, "wood", 0},	AutoRepairRange = 4,})
DefineUnitType("unit-footman",			{Costs = {"time", 200, "gold", 400, "wood", 0},})
DefineUnitType("unit-grunt",			{Costs = {"time", 200, "gold", 400, "wood", 0},})

DefineUnitType("unit-archer",			{Costs = {"time", 220, "gold", 350, "wood", 50},})
DefineUnitType("unit-spearman",			{Costs = {"time", 220, "gold", 350, "wood", 50},})
DefineUnitType("unit-orc-catapult",		{Costs = {"time", 300, "gold", 650, "wood", 300},})
DefineUnitType("unit-human-catapult",	{Costs = {"time", 300, "gold", 650, "wood", 300},})

DefineUnitType("unit-raider",			{Costs = {"time", 250, "gold", 750, "wood", 100},})
DefineUnitType("unit-knight",			{Costs = {"time", 250, "gold", 750, "wood", 100},})

DefineUnitType("unit-cleric",			{Costs = {"time", 250, "gold", 500, "wood", 50},})
DefineUnitType("unit-necrolyte",		{Costs = {"time", 250, "gold", 500, "wood", 50},})
DefineUnitType("unit-conjurer",			{Costs = {"time", 300, "gold", 800, "wood", 100},})
DefineUnitType("unit-warlock",			{Costs = {"time", 300, "gold", 800, "wood", 100},})

-----------------------------------------------------------------------
-- Grunt/Footman Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-footman", {
				HitPoints = 70,
                Armor = 1,
				BasicDamage = 7
})
DefineUnitType("unit-grunt", {
				HitPoints = 70,
                Armor = 0,
				BasicDamage = 8
})

-----------------------------------------------------------------------
-- Raider/Knight Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-knight", {
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-raider", {
                  Demand = 2,
                  Armor = 0,
				  PiercingDamage = 2
})

-----------------------------------------------------------------------
-- Archer/Spearman Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-archer", {
                  PiercingDamage = 1,
                  BasicDamage = 6,
                  Armor = 0
})
DefineUnitType("unit-spearman", {
                  PiercingDamage = 2,
                  BasicDamage = 6,
                  Armor = 0
})

-----------------------------------------------------------------------
-- Catapult Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-human-catapult", {                  
                  Demand = 2,
                  RepairHp = 4,
                  RepairCosts = { "gold", 1, "wood", 1 },
		  PoisonDrain = 0,
                  organic = false,
				  Corpse = nil,
                  BasicDamage = 100,
                  MaxAttackRange = 8,
                  MinAttackRange = 3,
				  GroundAttack = true,
})
DefineUnitType("unit-orc-catapult", {                  
                  Demand = 2,
                  RepairHp = 4,
                  RepairCosts = { "gold", 1, "wood", 1 },
		  PoisonDrain = 0,
                  organic = false,
				  Corpse = nil,
                  BasicDamage = 100,
                  MaxAttackRange = 8,
                  MinAttackRange = 3,
				  GroundAttack = true,
})

DefineMissileType("missile-catapult-rock", {
                  Speed = 1,
                  Range = 2,
                  SplashFactor = 2,
                  NumDirections = 9
})

local CatapultRock = CIcon:New("icon-rock")
CatapultRock.G = CPlayerColorGraphic:New("contrib/graphics/ui/icon-attack-catapult.png", 27, 19)
CatapultRock.Frame = 0

DefineButton( { Pos = 3, Level = 0, Icon = "icon-rock",
  Action = "attack",
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-orc-catapult", "unit-human-catapult"}})
 
DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-CatapultAmmo1",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-CatapultAmmo1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-orc-catapult"} } )

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-CatapultAmmo1",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-CatapultAmmo1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-human-catapult"} } )
  
local attackGroundIcon = CIcon:New("icon-attack-ground")
attackGroundIcon.G = CPlayerColorGraphic:New("contrib/graphics/ui/icon-attack-ground.png", 27, 19)
attackGroundIcon.Frame = 0
  
 DefineButton( { Pos = 5, Level = 0, Icon = "icon-attack-ground",
  Action = "attack-ground",
  Key = "d", Hint = "ATTACK GROUN~!D",
  ForUnit = {"unit-orc-catapult", "unit-human-catapult"}})

local HoldFireButtonAction = function(unit)
TransformUnit(unit, "unit-".. GetPlayerData(GetThisPlayer(), "RaceName").. "-catapult-noattack") 
end

local FreeFireButtonAction = function(unit)
SetPlayerData(GetThisPlayer(), "Resources", "gold",
                      GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-".. GetPlayerData(GetThisPlayer(), "RaceName").. "-catapult", "Costs", "gold"))
SetPlayerData(GetThisPlayer(), "Resources", "wood",
                      GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-".. GetPlayerData(GetThisPlayer(), "RaceName").. "-catapult", "Costs", "wood"))		  
TransformUnit(unit, "unit-".. GetPlayerData(GetThisPlayer(), "RaceName").. "-catapult") 
end

DefineButton( { Pos = 6, Level = 0, Icon = "icon-attack-ground",
  Key = "f", Hint = "~!FIRE AT WILL",
  ForUnit = {"unit-human-catapult-noattack", "unit-orc-catapult-noattack"},
  Action = "callback",
  Value = FreeFireButtonAction}) 
  
-----------------------------------------------------------------------
-- Orc catapult Hold Fire transform
-----------------------------------------------------------------------

DefineButton( { Pos = 6, Level = 0, Icon = "icon-orc-holdfire",
  Key = "f", Hint = "HOLD ~!FIRE",
  ForUnit = {"unit-orc-catapult"},
  Action = "callback",
  Value = HoldFireButtonAction}) 

DefineUnitType("unit-orc-catapult-noattack",
               { Name = "Catapult",
                 Image = {"file", "orc/units/catapult.png", "size", {32, 32}},
                 Icon = "icon-orc-catapult",
                 DrawLevel = 60,
                 TileSize = { 1, 1 },
                 BoxSize = {15, 15},
                 Type = "land",
				 organic = false,
				 Corpse = nil,
                 CanAttack = false,
                 LandUnit = true,
				 Sounds = {
					"attack", "orc acknowledge",
					"selected", "orc selected",
					"acknowledge", "orc acknowledge",
					"ready", "orc ready",
					"help", "orc help 3",
					"dead", "orc dead"
				 },
				 SelectableByRectangle = true,
                 Animations = "animations-orc-catapult", 
                 HitPoints = 120,
                 Demand = 3, 
                 CanTargetLand = false, 
                 SightRange = 5, 
})

-----------------------------------------------------------------------
-- Human catapult Hold Fire transform
-----------------------------------------------------------------------

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-holdfire",
  Key = "f", Hint = "HOLD ~!FIRE",
  ForUnit = {"unit-human-catapult"},
  Action = "callback",
  Value = HoldFireButtonAction})

DefineUnitType("unit-human-catapult-noattack",
               { Name = "Catapult",
                 Image = {"file", "human/units/catapult.png", "size", {32, 32}},
                 Icon = "icon-human-catapult",
                 DrawLevel = 60,
                 TileSize = { 1, 1 },
                 BoxSize = {15, 15},
                 Type = "land",
				 organic = false,
				 Corpse = nil,
                 CanAttack = false,
                 LandUnit = true,
				 Sounds = {
					"attack", "human acknowledge",
					"selected", "human selected",
					"acknowledge", "human acknowledge",
					"ready", "human ready",
					"help", "human help 3",
					"dead", "human dead"
				 },
				 SelectableByRectangle = true,
                 Animations = "animations-human-catapult", 
                 HitPoints = 120,
                 Demand = 3, 
                 CanTargetLand = false, 
                 SightRange = 5, 
})

-----------------------------------------------------------------------
-- Elemental and Demon Rebalancing
-----------------------------------------------------------------------

CasterToSummonedMap = {}
SummonedToCasterMap = {}

-- add callback to connect caster with elemental, so they deaths are linked
local SummonSpellCallback = function(spellname, caster, x, y, summoned)
   print(spellname .. " cast by " .. caster .. " at " .. x .. "@" .. y .. " spawning " .. summoned)
   local ident = GetUnitVariable(caster, "Ident")
   if ident == "unit-conjurer" then
      TransformUnit(caster, "unit-conjurer-during-summoning")
   elseif ident == "unit-warlock" then
      TransformUnit(caster, "unit-warlock-during-summoning")
   else
      return true
   end
   CasterToSummonedMap[caster] = summoned
   SummonedToCasterMap[summoned] = caster
   return true
end

DefineSpell("spell-summon-elemental", "manacost", 100, "action", {{"lua-callback", SummonSpellCallback}})
DefineSpell("spell-summon-daemon", "manacost", 100, "action", {{"lua-callback", SummonSpellCallback}})

DefineMissileType("missile-demon-hate",
  { File = "missiles/fireball.png", Size = {32, 32}, Frames = 25, NumDirections = 9,
    DrawLevel = 200, ImpactSound = "fireball attack", Damage = 15,
    Class = "missile-class-point-to-point", Sleep = 1, Speed = 7, Range = 128 } )

local DaemonDeath = function(daemon, warlock)
   print("Death of " .. daemon .. " spawned from " .. warlock)
   -- daemons are nasty creatures, they destroy when they are forced to
   -- return and kill the warlock
   local spos = GetUnitVariable(daemon, "PixelPos")
   for i,unit in ipairs(GetUnitsAroundUnit(warlock, 6, false)) do
      if GetUnitVariable(unit, "Ident") ~= "unit-daemon" then
         local pos = GetUnitVariable(unit, "PixelPos")
         CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, daemon, unit, true, true)
      end
   end
   for i,unit in ipairs(GetUnitsAroundUnit(warlock, 2, false)) do
      if GetUnitVariable(unit, "Ident") ~= "unit-daemon" then
         local pos = GetUnitVariable(unit, "PixelPos")
         CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, daemon, unit, true, true)
      end
   end
   local pos = GetUnitVariable(warlock, "PixelPos")
   CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, daemon, warlock, true, true)
   CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, daemon, warlock, true, true)
   CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, daemon, warlock, true, true)
   AddMessage(_("A daemons chaos magic returns to the hells ..."))
end

local ElementalDeath = function(elemental, conjurer)
   print("Death of " .. elemental .. " spawned from " .. conjurer)
   TransformUnit(conjurer, "unit-conjurer")
end

-- add death callback to elemental
local SummonedDeathCallback = function(summoned, x, y)
   -- elemental will die, release the conjurer from concentration
   local caster = SummonedToCasterMap[summoned]
   if caster then
      CasterToSummonedMap[caster] = nil
   end
   SummonedToCasterMap[summoned] = nil
   if caster then
      local casterIdent = GetUnitVariable(caster, "Ident")
      local hp = GetUnitVariable(caster, "HitPoints")
      -- there can be races, so be extra careful
      if hp > 0 then
         if casterIdent == "unit-conjurer-during-summoning" then
            ElementalDeath(summoned, caster)
         elseif casterIdent == "unit-warlock-during-summoning" then
            DaemonDeath(summoned, caster)
         end
      end
   end
end

DefineUnitType("unit-water-elemental", {
                  HitPoints = 200,
                  PiercingDamage = 0,
                  BasicDamage = 30,
                  OnDeath = SummonedDeathCallback
})
DefineUnitType("unit-daemon", {
                  BasicDamage = 35,
                  OnDeath = SummonedDeathCallback
})

-- define summoner states and deaths
local SummonerDeathCallback = function(caster, x, y)
   -- caster will die, kill any summoned unit, if exists
   local activeSummoned = CasterToSummonedMap[caster]
   CasterToSummonedMap[caster] = nil
   if activeSummoned then
      SummonedToCasterMap[activeSummoned] = nil
   end
   if activeSummoned then
      local hp = GetUnitVariable(activeSummoned, "HitPoints")
      if hp > 0 then
         local summonedIdent = GetUnitVariable(activeSummoned, "Ident")
         local casterIdent = GetUnitVariable(caster, "Ident")
         if casterIdent == "unit-conjurer-during-summoning" then
            if summonedIdent == "unit-water-elemental" then
               if x < 0 then
                  -- called from SummonerCancelButtonAction. remove the unit
                  DamageUnit(-1, activeSummoned, 1000)
               else
                  -- as per the manual, "should they [Water Elementals] escape
                  -- the control of their master, they become free creatures to
                  -- do as they will"
                  AddMessage(_("An elemental escapes its bonds to roam the world ..."))
                  -- In our case, what we do is make the elemental neutral but
                  -- order it to attack someone near the conjurer. It'll run out
                  -- of TTL eventually, anyway...

                  local prevPlayer = GetUnitVariable(activeSummoned, "Player")
                  local enemyPlayer = 0
                  local neutralPlayer = 0
                  for i=15,1,-1 do
                     if i ~= prevPlayer then
                        if GetPlayerData(i, "AiEnabled") then
                           local dip = GetDiplomacy(i, prevPlayer)
                           if dip == "enemy" or dip == "crazy" then
                              enemyPlayer = i
                              break
                           elseif dip == "neutral" then
                              neutralPlayer = i
                           end
                        end
                     end
                  end

                  if enemyPlayer == 0 then
                     if neutralPlayer == 0 then
                        -- did not find even a neutral player? what do we do?
                        DamageUnit(-1, activeSummoned, 1000)
                     else
                        SetUnitVariable(activeSummoned, "Player", neutralPlayer)
                        SetDiplomacy(neutralPlayer, "enemy", prevPlayer)
                     end
                  else
                     SetUnitVariable(activeSummoned, "Player", enemyPlayer)
                  end

                  local posx = GetUnitVariable(activeSummoned, "PosX")
                  local posy = GetUnitVariable(activeSummoned, "PosY")
                  local dx = GetUnitVariable(caster, "PosX")
                  local dy = GetUnitVariable(caster, "PosY")
                  OrderUnit(15, summonedIdent, {posx, posy}, {
                               dx - 10, dy - 10,
                               dx + 10, dy + 10
                  }, "attack")
               end
            end
         elseif casterIdent == "unit-warlock-during-summoning" then
            if summonedIdent == "unit-daemon" then
               local spos = GetUnitVariable(activeSummoned, "PixelPos")
               if x >= 0 then
                  for i,unit in ipairs(GetUnitsAroundUnit(caster, 6, false)) do
                     if GetUnitVariable(unit, "Ident") ~= "unit-daemon" then
                        local pos = GetUnitVariable(unit, "PixelPos")
                        CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, activeSummoned, unit, true, true)
                     end
                  end
                  for i,unit in ipairs(GetUnitsAroundUnit(caster, 2, false)) do
                     if GetUnitVariable(unit, "Ident") ~= "unit-daemon" then
                        local pos = GetUnitVariable(unit, "PixelPos")
                        CreateMissile("missile-demon-hate", {spos.x, spos.y}, {pos.x, pos.y}, activeSummoned, unit, true, true)
                     end
                  end
               end
               local cpos = GetUnitVariable(caster, "PixelPos")
               CreateMissile("missile-demon-hate", {spos.x, spos.y}, {cpos.x, cpos.y}, activeSummoned, caster, false, true)
               CreateMissile("missile-demon-hate", {spos.x, spos.y}, {cpos.x, cpos.y}, activeSummoned, caster, false, true)
               DamageUnit(-1, activeSummoned, 1000)
               AddMessage(_("A daemon escapes its bond and furiously returns to the hells ..."))
            end
         end
      end
   end
end

local SummonerCancelButtonAction = function(caster)
   SummonerDeathCallback(caster, -1, -1)
   local casterIdent = GetUnitVariable(caster, "Ident")
   local hp = GetUnitVariable(caster, "HitPoints")
   if hp > 0 then
      if casterIdent == "unit-conjurer-during-summoning" then
	           SetPlayerData(GetThisPlayer(), "Resources", "gold",
                      GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-conjurer", "Costs", "gold"))
			   SetPlayerData(GetThisPlayer(), "Resources", "wood",
                      GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-conjurer", "Costs", "wood"))
         TransformUnit(caster, "unit-conjurer")
      elseif casterIdent == "unit-warlock-during-summoning" then
	           SetPlayerData(GetThisPlayer(), "Resources", "gold",
                      GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-warlock", "Costs", "gold"))
			   SetPlayerData(GetThisPlayer(), "Resources", "wood",
                      GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-warlock", "Costs", "wood"))	  
         TransformUnit(caster, "unit-warlock")
         AddMessage(_("A daemon is forced back to the hells ..."))
      end
   end
end

DefineAnimations("animations-conjurer-summoning",
                 {Still = {
                     "frame 20", "wait 16",
                     "frame 35", "wait 16",
                     }})

DefineUnitType("unit-conjurer-during-summoning",
               { Name = "Element Summoner",
                 Image = {"file", "human/units/conjurer.png", "size", {32, 32}},
                 Icon = "icon-conjurer",
                 DrawLevel = 60,
                 TileSize = { 1, 1 },
                 BoxSize = {15, 15},
                 Type = "land",
                 Corpse = "unit-human-dead-body",
                 CanAttack = false,
                 LandUnit = true,
                 Sounds = {
                    "selected", "raise dead",
                    "help", "human help 3",
                    "dead", "human dead"
                 },
                 Animations = "animations-conjurer-summoning",
                 Speed = 0,
                 HitPoints = 40,
                 Armor = 0,
                 Mana = {Max = 100, Enable = true, Increase = 0},
                 AnnoyComputerFactor = 200,
                 MaxAttackRange = 0,
                 Demand = 1,
                 RightMouseAction = "none",
                 CanTargetLand = false,
                 SelectableByRectangle = false, -- annoying otherwise
                 SightRange = 2, -- eyes are closed during summoning!
                 BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
                 OnDeath = SummonerDeathCallback
})

DefineButton({ Pos = 5, Level = 0, Icon = "icon-cancel",
  AlwaysShow = true,
  Key = "esc", Hint = "~<ESC~> BREAK SUMMONING",
  ForUnit = {"unit-conjurer-during-summoning"},
  Action = "callback",
  Value = SummonerCancelButtonAction})

DefineAnimations("animations-warlock-summoning",
                 {Still = {
                     "frame 20", "wait 16",
                     "frame 35", "wait 16",
                     "frame 50", "wait 16",
                     }})

DefineUnitType("unit-warlock-during-summoning",
               { Name = "Demon Summoner",
                 Image = {"file", "orc/units/warlock.png", "size", {32, 32}},
                 Icon = "icon-warlock",
                 DrawLevel = 60,
                 TileSize = { 1, 1 },
                 BoxSize = {15, 15},
                 Type = "land",
                 Corpse = "unit-orc-dead-body",
                 CanAttack = false,
                 LandUnit = true,
                 Sounds = {
                    "selected", "raise dead",
                    "help", "orc help 3",
                    "dead", "orc dead"
                 },
                 Animations = "animations-warlock-summoning",
                 Speed = 0,
                 HitPoints = 40,
                 Armor = 0,
                 Mana = {Max = 100, Enable = true, Increase = 0},
                 AnnoyComputerFactor = 200,
                 MaxAttackRange = 0,
                 Demand = 1,
                 RightMouseAction = "none",
                 CanTargetLand = false,
                 SelectableByRectangle = false, -- annoying otherwise
                 SightRange = 2, -- eyes are closed during summoning!
                 BasicDamage = 0, PiercingDamage = 0, Missile = "missile-none",
                 OnDeath = SummonerDeathCallback
})

DefineButton({ Pos = 5, Level = 0, Icon = "icon-cancel",
  AlwaysShow = true,
  Key = "esc", Hint = "~<ESC~> BREAK SUMMONING",
  ForUnit = {"unit-warlock-during-summoning"},
  Action = "callback",
  Value = SummonerCancelButtonAction})

-----------------------------------------------------------------------
-- Upgrades Rebalancing
-----------------------------------------------------------------------

local upgrades = {
   {orc = {"axe1", {"grunt", "raider"}, "axe2"},
    human = {"sword1", {"footman", "knight"}, "sword2"},
    cost = {   1200,   750,     400,     0,     0,     0,     0},
    },
   {orc = {"axe2", {"grunt", "raider"}, "axe3"},
    human = {"sword2", {"footman", "knight"}, "sword3"},
    cost = {   1200,   1500,     800,     0,     0,     0,     0},
    },

   {orc = {"spear1", {"spearman"}, "spear2"},
    human = {"arrow1", {"archer"}, "arrow2"},
    cost = {   1400,   750,		400,     0,     0,     0,     0},
    },
   {orc = {"spear2", {"spearman"}, "spear3"},
    human = {"arrow2", {"archer"}, "arrow3"},
    cost = {   1400,   1500,     800,     0,     0,     0,     0},
    },

   {orc = {"orc-shield1", {"grunt", "raider"}, "orc-shield2"},
    human = {"human-shield1", {"footman", "knight"}, "human-shield2"},
    cost = {   1200,   750, 	400,     0,     0,     0,     0},
   },  
   {orc = {"orc-shield2", {"grunt", "raider"}, "orc-shield3"},
    human = {"human-shield2", {"footman", "knight"}, "human-shield3"},
    cost = {   1200,   1500,     800,     0,     0,     0,     0}, 
    },

   {orc = {"wolves1", {"raider"}},
    human = {"horse1", {"knight"}},
    cost = {   700,   750, 	400,     0,     0,     0,     0},
    },
   {orc = {"wolves2", {"raider"}},
    human = {"horse2", {"knight"}},
    cost = {   700,   1500,     800,     0,     0,     0,     0},
   },	
    
   {orc = {"dark-vision", {"necrolyte"}},
    human = {"far-seeing", {"cleric"}},
    cost = {   120,   750,     0,     0,     0,     0,     0}
	},

   {orc = {"unholy-armor", {"necrolyte"}},
    human = {"invisibility", {"cleric"}},
    cost = {   120,   750,     0,     0,     0,     0,     0}
	},
}

for idx,spec in ipairs(upgrades) do
   DefineUpgradeFromSpec(spec)
end

-----------------------------------------------------------------------
-- Orcs can heal at their temple
-----------------------------------------------------------------------
DefineMissileType("missile-temple-heal",
  { File = "missiles/healing.png", Size = {16, 16}, Frames = 6, NumDirections = 1,
    DrawLevel = 250, Class = "missile-class-stay", Sleep = 10, Speed = 0, Range = 1 } )

DefineUnitType("unit-orc-temple", {
   OnEachSecond = function (temple)
      local freq = GetUnitVariable(temple, "RegenerationFrequency")
      local doheal = freq <= 1
      local dodraw = (freq % 2 == 1)
      if dodraw then
         for i,unit in ipairs(GetUnitsAroundUnit(temple, 2, false)) do
            if GetUnitVariable(unit, "organic") then
               local hp = GetUnitVariable(unit, "HitPoints")
               local maxhp = GetUnitVariable(unit, "HitPoints", "Max")
               if hp < maxhp then
                  if doheal then
                     SetUnitVariable(unit, "HitPoints", hp + 1)
                  end
                  CreateMissile("missile-temple-heal", {8, 8}, {8, 8}, unit, unit, false)
               end
            end
         end
      end
      if doheal then
         SetUnitVariable(temple, "RegenerationFrequency", 2)
      else
         SetUnitVariable(temple, "RegenerationFrequency", freq - 1)
      end
   end
})

-----------------------------------------------------------------------
-- Human recharge mana at their Church
-----------------------------------------------------------------------

DefineUnitType("unit-human-church", {
   OnEachSecond = function (church)
      local freq = GetUnitVariable(church, "RegenerationFrequency")
      local doheal = freq <= 1
      local dodraw = (freq % 2 == 1)
      if dodraw then
         for i,unit in ipairs(GetUnitsAroundUnit(church, 2, false)) do
            if GetUnitVariable(unit, "organic") then
               local hp = GetUnitVariable(unit, "Mana")
               local maxhp = GetUnitVariable(unit, "Mana", "Max")
               if hp < maxhp then
                  if doheal then
                     SetUnitVariable(unit, "Mana", hp + 1)
                  end
                  CreateMissile("missile-temple-heal", {8, 8}, {8, 8}, unit, unit, false)
               end
            end
         end
      end
      if doheal then
         SetUnitVariable(church, "RegenerationFrequency", 3)
      else
         SetUnitVariable(church, "RegenerationFrequency", freq - 1)
      end
   end
})


-----------------------------------------------------------------------
-- Orc watch tower
-----------------------------------------------------------------------

DefineConstruction(
   "construction-orc-watch-tower",
   {
      Files = { 
         File = "tilesets/forest/human/buildings/farm_construction.png",
         Size = {48, 48} 
      }, 
      Constructions = {
         {
            Percent = 0,
            File = "construction",
            Frame = 0
         },
         {
            Percent = 33,
            File = "main",
            Frame = -2,
         },
         {
            Percent = 66,
            File = "main",
            Frame = -3,
         }
      }
   }
)

local DefineOrcTowerIcon = function()
   local iconname
   if war1gus.tileset == "forest" or war1gus.tileset == "forest_campaign" then
      iconname = "contrib/graphics/ui/orc/icon-orc-watch-tower-forest.png"
   else
      iconname = "contrib/graphics/ui/orc/icon-orc-watch-tower-swamp.png"
   end
   local orcWatchTowerIcon = CIcon:New("icon-orc-watch-tower")
   orcWatchTowerIcon.G = CPlayerColorGraphic:New(iconname, 27, 19)
   orcWatchTowerIcon.Frame = 0
end
DefineOrcTowerIcon()
OnTilesetChangeFunctions:add(DefineOrcTowerIcon)

DefineAnimations(
   "animations-orc-watch-tower", 
   {Still = {"frame 0", "wait 5"},
    Attack = {"frame 0", "attack", "wait 95"}, -- attack speed
    Death = {"frame 0", "wait 1"}}
)

DefineUnitType("unit-orc-watch-tower", { Name = _("Watch Tower"),
  Image = {
     "file", "contrib/graphics/buildings/orc-watch-tower.png",
     "size", {48, 48}
  },
  Animations = "animations-orc-watch-tower", Icon = "icon-orc-watch-tower",
  Costs = {"time", 200, "gold", 500, "wood", 350},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-orc-watch-tower",
  Speed = 0,
  HitPoints = 130,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {32, 32},
  SightRange = 9, ComputerReactionRange = 6, PersonReactionRange = 6,
  Armor = 0, BasicDamage = 4, PiercingDamage = 4, Missile = "missile-arrow",
  RightMouseAction = "attack",
  MaxAttackRange = 6,
  Priority = 50, AnnoyComputerFactor = 60,
  Points = 200,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-building-collapse",
  Type = "land",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  Building = true, VisibleUnderFog = true,
  DetectCloak = true,
  Elevated = true,
  BuildingRules =
            {
                -- all buildings except the town hall
                {
                    "distance",{ Distance = 5, DistanceType = "<", Owner = "self" }
                }
            },
            AiBuildingRules =
            {
                -- all buildings except the town hall
                {
                    "distance",{ Distance = 2, DistanceType = ">=", Type = "unit-gold-mine" },
                    "distance",{ Distance = 2, DistanceType = ">=", Owner = "self" }
                }
            },
  Sounds = {
    "ready", "orc work complete",
    "selected", "orc-selected",
    "help", "orc help 1",
    "dead", "building destroyed"} } )

DefineButton( { Pos = 5, Level = 1, Icon = "icon-orc-watch-tower",
   Action = "build", Value = "unit-orc-watch-tower",
   Key = "w", Hint = "BUILD ~!WATCH TOWER",
   ForUnit = {"unit-peon"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-spear1",
   Action = "attack",
   Key = "a", Hint = "~!ATTACK",
   ForUnit = {"unit-orc-watch-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield1",
   Action = "stop",
   Key = "s", Hint = "~!STOP",
   ForUnit = {"unit-orc-watch-tower"} } )

DefineAllow("unit-orc-watch-tower", "AAAAAAAAAAAAAAAA")

DefineDependency("unit-orc-watch-tower", { "unit-orc-lumber-mill"} )

-----------------------------------------------------------------------
-- Human guard tower
-----------------------------------------------------------------------

DefineConstruction(
   "construction-human-guard-tower",
   {
      Files = { 
         File = "tilesets/forest/human/buildings/farm_construction.png",
         Size = {48, 48} 
      }, 
      Constructions = {
         {
            Percent = 0,
            File = "construction",
            Frame = 0
         },
         {
            Percent = 33,
            File = "main",
            Frame = -2,
         },
         {
            Percent = 66,
            File = "main",
            Frame = -3,
         }
      }
   }
)

local DefineHumanTowerIcon = function()
   local iconname
   if war1gus.tileset == "forest" or war1gus.tileset == "forest_campaign" then
      iconname = "contrib/graphics/ui/human/icon-human-guard-tower-forest.png"
   else
      iconname = "contrib/graphics/ui/human/icon-human-guard-tower-swamp.png"
   end
   local humanGuardTowerIcon = CIcon:New("icon-human-guard-tower")
   humanGuardTowerIcon.G = CPlayerColorGraphic:New(iconname, 27, 19)
   humanGuardTowerIcon.Frame = 0
end
DefineHumanTowerIcon()
OnTilesetChangeFunctions:add(DefineHumanTowerIcon)

DefineAnimations(
   "animations-human-guard-tower", 
   {Still = {"frame 0", "wait 5"},
    Attack = {"frame 0", "attack", "wait 95"}, -- attack speed
    Death = {"frame 0", "wait 1"}}
)

DefineUnitType("unit-human-guard-tower", { Name = _("Guard Tower"),
  Image = {
     "file", "contrib/graphics/buildings/human-guard-tower.png",
     "size", {48, 48}
  },
  Animations = "animations-human-guard-tower", Icon = "icon-human-guard-tower",
  Costs = {"time", 300, "gold", 500, "wood", 450},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Construction = "construction-human-guard-tower",
  Speed = 0,
  HitPoints = 130,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {32, 32},
  SightRange = 9, ComputerReactionRange = 6, PersonReactionRange = 6,
  Armor = 5, BasicDamage = 4, PiercingDamage = 4, Missile = "missile-arrow",
  RightMouseAction = "attack",
  MaxAttackRange = 6,
  Priority = 50, AnnoyComputerFactor = 60,
  Points = 200,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-building-collapse",
  Type = "land",
  CanAttack = true,
  CanTargetLand = true, CanTargetSea = true, CanTargetAir = true,
  Building = true, VisibleUnderFog = true,
  DetectCloak = true,
  Elevated = true,
  BuildingRules =
            {
                -- all buildings except the town hall
                {
                    "distance",{ Distance = 5, DistanceType = "<", Owner = "self" }
                }
            },
            AiBuildingRules =
            {
                -- all buildings except the town hall
                {
                    "distance",{ Distance = 2, DistanceType = ">=", Type = "unit-gold-mine" },
                    "distance",{ Distance = 2, DistanceType = ">=", Owner = "self" }
                }
            },
  Sounds = {
    "ready", "human work complete",
    "selected", "human-selected",
    "help", "human help 1",
    "dead", "building destroyed"} } )

DefineButton( { Pos = 5, Level = 1, Icon = "icon-human-guard-tower",
   Action = "build", Value = "unit-human-guard-tower",
   Key = "g", Hint = "BUILD ~!GUARD TOWER",
   ForUnit = {"unit-peasant"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow1",
   Action = "attack",
   Key = "a", Hint = "~!ATTACK",
   ForUnit = {"unit-human-guard-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
   Action = "stop",
   Key = "s", Hint = "~!STOP",
   ForUnit = {"unit-human-guard-tower"} } )

DefineAllow("unit-human-guard-tower", "AAAAAAAAAAAAAAAA")

DefineDependency("unit-human-guard-tower", { "unit-human-lumber-mill"} )

-----------------------------------------------------------------------
-- Town hall salvage buttons
-----------------------------------------------------------------------

local orcSalvageIcon = CIcon:New("icon-orc-town-hall-salvage")
orcSalvageIcon.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-salvage-th.png", 27, 19)
orcSalvageIcon.Frame = 0

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-town-hall-salvage",
  Action = "button", Value = 1,
  Description = "Salvage this town hall for gold to rebuild somewhere else.",
  Key = "v", Hint = "SAL~!VAGE",
  ForUnit = {"unit-orc-town-hall"} } )
  
DefineButton( { Pos = 2, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "esc", Hint = "~<ESC~> - CANCEL",
  ForUnit = {"unit-orc-town-hall"} } )

DefineButton( { Pos = 1, Level = 1, Icon = "icon-orc-town-hall-salvage",
   AlwaysShow = true,
   Action = "callback", Value = function(townHall)
      DamageUnit(-1, townHall, GetUnitVariable(townHall, "HitPoints"))
      SetPlayerData(GetThisPlayer(), "Resources", "gold",
                      GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-orc-town-hall", "Costs", "gold"))
     -- SetPlayerData(GetThisPlayer(), "Resources", "wood",
      --                GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-orc-town-hall", "Costs", "wood"))
   end,
   Allowed = "check-units-or", AllowArg = {"unit-peon"},
   Description = "Confirm salvaging of this Town Hall. YOU NEED AT LEAST 1 PEON!",
   Key = "s", Hint = "~!SALVAGE CONFIRM",
   ForUnit = {"unit-orc-town-hall", "unit-orc-blackrock-spire"} } )




local humanSalvageIcon = CIcon:New("icon-human-town-hall-salvage")
humanSalvageIcon.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-salvage-th.png", 27, 19)
humanSalvageIcon.Frame = 0

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-town-hall-salvage",
  Action = "button", Value = 1,
  Description = "Salvage this town hall for gold to rebuild somewhere else.",
  Key = "v", Hint = "SAL~!VAGE",
  ForUnit = {"unit-human-town-hall"} } )
  
DefineButton( { Pos = 2, Level = 1, Icon = "icon-cancel",
  Action = "button", Value = 0,
  Key = "esc", Hint = "~<ESC~> - CANCEL",
  ForUnit = {"unit-human-town-hall"} } )

DefineButton( { Pos = 1, Level = 1, Icon = "icon-human-town-hall-salvage",
   AlwaysShow = true,
   Action = "callback", Value = function(townHall)
      DamageUnit(-1, townHall, GetUnitVariable(townHall, "HitPoints"))
      SetPlayerData(GetThisPlayer(), "Resources", "gold",
                        GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-human-town-hall", "Costs", "gold"))
   --   SetPlayerData(GetThisPlayer(), "Resources", "wood",
    --                    GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-human-town-hall", "Costs", "wood"))
   end,
   Allowed = "check-units-or", AllowArg = {"unit-peasant"},
   Description = "Confirm salvaging of this Town Hall. YOU NEED AT LEAST 1 PEASANT!",
   Key = "s", Hint = "~!SALVAGE CONFIRM",
   ForUnit = {"unit-human-town-hall", "unit-human-stormwind-keep"} } )

-----------------------------------------------------------------------
-- Orc saliva upgrades
-----------------------------------------------------------------------

local orcSalivaIcon1 = CIcon:New("icon-orc-saliva1")
orcSalivaIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-saliva1.png", 27, 19)
orcSalivaIcon1.Frame = 0

local orcSalivaUpgrade1 = CUpgrade:New("upgrade-orc-saliva1")
orcSalivaUpgrade1.Icon = orcSalivaIcon1
orcSalivaUpgrade1.Costs[0] = 700 -- time
orcSalivaUpgrade1.Costs[1] = 750 -- gold
orcSalivaUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-orc-saliva1",
  {"Level", 1},
  {"regeneration-rate", 1},
  {"regeneration-frequency", 6},
  {"apply-to", "unit-raider"})

DefineAllow("upgrade-orc-saliva1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-saliva1",
  Action = "research", Value = "upgrade-orc-saliva1",
  Allowed = "check-single-research",
  Key = "h", Hint = "RESEARCH ~!HEALING SALIVA",
  ForUnit = {"unit-orc-kennel"} } )

local orcSalivaIcon2 = CIcon:New("icon-orc-saliva2")
orcSalivaIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-saliva2.png", 27, 19)
orcSalivaIcon2.Frame = 0

local orcSalivaUpgrade2 = CUpgrade:New("upgrade-orc-saliva2")
orcSalivaUpgrade2.Icon = orcSalivaIcon2
orcSalivaUpgrade2.Costs[0] = 700 -- time
orcSalivaUpgrade2.Costs[1] = 1500 -- gold
orcSalivaUpgrade2.Costs[2] = 800 -- wood

DefineModifier("upgrade-orc-saliva2",
   {"Level", 1},
   {"regeneration-rate", 1},
   {"regeneration-frequency", 4},
   {"apply-to", "unit-raider"})

DefineAllow("upgrade-orc-saliva2", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-saliva2",
   Action = "research", Value = "upgrade-orc-saliva2",
   Allowed = "check-upgrade", AllowArg = {"upgrade-orc-saliva1"},
   Key = "h", Hint = "RESEARCH ~!HEALING SALIVA",
   ForUnit = {"unit-orc-kennel"} } )

DefineDependency("upgrade-orc-saliva2", { "upgrade-orc-saliva1"} )

-----------------------------------------------------------------------
-- Human barding upgrades
-----------------------------------------------------------------------

local humanBardingIcon1 = CIcon:New("icon-human-barding1")
humanBardingIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-barding1.png", 27, 19)
humanBardingIcon1.Frame = 0

local humanBardingUpgrade1 = CUpgrade:New("upgrade-human-barding1")
humanBardingUpgrade1.Icon = humanBardingIcon1
humanBardingUpgrade1.Costs[0] = 700 -- time
humanBardingUpgrade1.Costs[1] = 750 -- gold
humanBardingUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-barding1",
  {"Level", 1},
  {"Armor", 1},
  {"apply-to", "unit-knight"})

DefineAllow("upgrade-human-barding1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-barding1",
  Action = "research", Value = "upgrade-human-barding1",
  Allowed = "check-single-research",
  Key = "r", Hint = "~!RESEARCH BARDING",
  ForUnit = {"unit-human-stable"} } )

local humanBardingIcon2 = CIcon:New("icon-human-barding2")
humanBardingIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-barding2.png", 27, 19)
humanBardingIcon2.Frame = 0

local humanBardingUpgrade2 = CUpgrade:New("upgrade-human-barding2")
humanBardingUpgrade2.Icon = humanBardingIcon2
humanBardingUpgrade2.Costs[0] = 700 -- time
humanBardingUpgrade2.Costs[1] = 750 -- gold
humanBardingUpgrade2.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-barding2",
   {"Level", 1},
   {"Armor", 1},
   {"apply-to", "unit-knight"})

DefineAllow("upgrade-human-barding2", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-barding2",
   Action = "research", Value = "upgrade-human-barding2",
   Allowed = "check-upgrade", AllowArg = {"upgrade-human-barding1"},
   Key = "r", Hint = "~!RESEARCH BARDING",
   ForUnit = {"unit-human-stable"} } )

DefineDependency("upgrade-human-barding2", { "upgrade-human-barding1"} )

-----------------------------------------------------------------------
-- Orc light armor upgrades
-----------------------------------------------------------------------

local orcLightArmorIcon1 = CIcon:New("icon-orc-LightArmor1")
orcLightArmorIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-Light-Armor1.png", 27, 19)
orcLightArmorIcon1.Frame = 0

local orcLightArmorUpgrade1 = CUpgrade:New("upgrade-orc-LightArmor1")
orcLightArmorUpgrade1.Icon = orcLightArmorIcon1
orcLightArmorUpgrade1.Costs[0] = 700 -- time
orcLightArmorUpgrade1.Costs[1] = 750 -- gold
orcLightArmorUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-orc-LightArmor1",
  {"Level", 1},
  {"Armor", 1},
  {"apply-to", "unit-spearman"}, {"apply-to", "unit-necrolyte"}, {"apply-to", "unit-warlock"})

DefineAllow("upgrade-orc-LightArmor1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-LightArmor1",
  Action = "research", Value = "upgrade-orc-LightArmor1",
  Allowed = "check-single-research",
  Key = "r", Hint = "UPGRADE LIGHT A~!RMOR",
  ForUnit = {"unit-orc-blacksmith"} } )

local orcLightArmorIcon2 = CIcon:New("icon-orc-LightArmor2")
orcLightArmorIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-Light-Armor2.png", 27, 19)
orcLightArmorIcon2.Frame = 0

local orcLightArmorUpgrade2 = CUpgrade:New("upgrade-orc-LightArmor2")
orcLightArmorUpgrade2.Icon = orcLightArmorIcon2
orcLightArmorUpgrade2.Costs[0] = 700 -- time
orcLightArmorUpgrade2.Costs[1] = 750 -- gold
orcLightArmorUpgrade2.Costs[2] = 400 -- wood

DefineModifier("upgrade-orc-LightArmor2",
   {"Level", 1},
   {"Armor", 1},
   {"apply-to", "unit-spearman"}, {"apply-to", "unit-necrolyte"}, {"apply-to", "unit-warlock"})

DefineAllow("upgrade-orc-LightArmor2", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-LightArmor2",
   Action = "research", Value = "upgrade-orc-LightArmor2",
   Allowed = "check-upgrade", AllowArg = {"upgrade-orc-LightArmor1"},
   Key = "r", Hint = "UPGRADE LIGHT A~!RMOR",
   ForUnit = {"unit-orc-blacksmith"} } )

DefineDependency("upgrade-orc-LightArmor2", { "upgrade-orc-LightArmor1"} )

-----------------------------------------------------------------------
-- Human light armor upgrades
-----------------------------------------------------------------------

local humanLightArmorIcon1 = CIcon:New("icon-human-LightArmor1")
humanLightArmorIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-Light-Armor1.png", 27, 19)
humanLightArmorIcon1.Frame = 0

local humanLightArmorUpgrade1 = CUpgrade:New("upgrade-human-LightArmor1")
humanLightArmorUpgrade1.Icon = humanLightArmorIcon1
humanLightArmorUpgrade1.Costs[0] = 700 -- time
humanLightArmorUpgrade1.Costs[1] = 750 -- gold
humanLightArmorUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-LightArmor1",
  {"Level", 1},
  {"Armor", 1},
  {"apply-to", "unit-archer"}, {"apply-to", "unit-cleric"}, {"apply-to", "unit-conjurer"})

DefineAllow("upgrade-human-LightArmor1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-LightArmor1",
  Action = "research", Value = "upgrade-human-LightArmor1",
  Allowed = "check-single-research",
  Key = "r", Hint = "UPGRADE LIGHT A~!RMOR",
  ForUnit = {"unit-human-blacksmith"} } )

local humanLightArmorIcon2 = CIcon:New("icon-human-LightArmor2")
humanLightArmorIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-Light-Armor2.png", 27, 19)
humanLightArmorIcon2.Frame = 0

local humanLightArmorUpgrade2 = CUpgrade:New("upgrade-human-LightArmor2")
humanLightArmorUpgrade2.Icon = humanLightArmorIcon2
humanLightArmorUpgrade2.Costs[0] = 700 -- time
humanLightArmorUpgrade2.Costs[1] = 750 -- gold
humanLightArmorUpgrade2.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-LightArmor2",
   {"Level", 1},
   {"Armor", 1},
   {"apply-to", "unit-archer"}, {"apply-to", "unit-cleric"}, {"apply-to", "unit-conjurer"})

DefineAllow("upgrade-human-LightArmor2", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-LightArmor2",
   Action = "research", Value = "upgrade-human-LightArmor2",
   Allowed = "check-upgrade", AllowArg = {"upgrade-human-LightArmor1"},
   Key = "r", Hint = "UPGRADE LIGHT A~!RMOR",
   ForUnit = {"unit-human-blacksmith"} } )

DefineDependency("upgrade-human-LightArmor2", { "upgrade-human-LightArmor1"} )

-----------------------------------------------------------------------
-- Human catapult upgrades
-----------------------------------------------------------------------

local humanCatapultAmmoIcon1 = CIcon:New("icon-human-CatapultAmmo1")
humanCatapultAmmoIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-catapult-steel-upg.png", 26, 19)
humanCatapultAmmoIcon1.Frame = 0

local humanCatapultAmmoUpgrade1 = CUpgrade:New("upgrade-human-CatapultAmmo1")
humanCatapultAmmoUpgrade1.Icon = humanCatapultAmmoIcon1
humanCatapultAmmoUpgrade1.Costs[0] = 700 -- time
humanCatapultAmmoUpgrade1.Costs[1] = 750 -- gold
humanCatapultAmmoUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-CatapultAmmo1",
  {"Level", 1},
  {"PiercingDamage", 20},
  {"apply-to", "unit-human-catapult"})
  
DefineAllow("upgrade-human-CatapultAmmo1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-CatapultAmmo1",
  Action = "research", Value = "upgrade-human-CatapultAmmo1",
  Allowed = "check-single-research",
  Key = "e", Hint = "RESEARCH ST~!EEL SHRAPNELS",
  ForUnit = {"unit-human-blacksmith"} } )


-----------------------------------------------------------------------
-- orc catapult upgrades
-----------------------------------------------------------------------

local orcCatapultAmmoIcon1 = CIcon:New("icon-orc-CatapultAmmo1")
orcCatapultAmmoIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-catapult-fire-upg.png", 27, 19)
orcCatapultAmmoIcon1.Frame = 0

local orcCatapultAmmoUpgrade1 = CUpgrade:New("upgrade-orc-CatapultAmmo1")
orcCatapultAmmoUpgrade1.Icon = orcCatapultAmmoIcon1
orcCatapultAmmoUpgrade1.Costs[0] = 700 -- time
orcCatapultAmmoUpgrade1.Costs[1] = 750 -- gold
orcCatapultAmmoUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-orc-CatapultAmmo1",
  {"Level", 1},
  {"PiercingDamage", 20},
  {"apply-to", "unit-orc-catapult"})
  
DefineAllow("upgrade-orc-CatapultAmmo1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-CatapultAmmo1",
  Action = "research", Value = "upgrade-orc-CatapultAmmo1",
  Allowed = "check-single-research",
  Key = "b", Hint = "RESEARCH ~!BURNING OIL",
  ForUnit = {"unit-orc-blacksmith"} } )

-----------------------------------------------------------------------
-- advance LoS
-----------------------------------------------------------------------

SetFieldOfViewType("shadow-casting")
SetOpaqueFor("forest")


-----------------------------------------------------------------------
-- New Orders Buttons Humans
-----------------------------------------------------------------------
local humanpatrol = CIcon:New("icon-human-patrol")
humanpatrol.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-patrol.png", 27, 19)
humanpatrol.Frame = 0

local humanExplore = CIcon:New("icon-human-explore")
humanExplore.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-explore.png", 27, 19)
humanExplore.Frame = 0

local humanStandground = CIcon:New("icon-human-standground")
humanStandground.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-standground.png", 27, 19)
humanStandground.Frame = 0

local humanHoldfire = CIcon:New("icon-human-holdfire")
humanHoldfire.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-holdfire.png", 27, 19)
humanHoldfire.Frame = 0

DefineButton( { Pos = 5, Level = 0, Icon = "icon-human-patrol",
  Action = "patrol",
  Key = "r", Hint = "PAT~!ROL",
  ForUnit = {"unit-footman", "unit-archer", "unit-knight", "unit-water-elemental", "unit-scorpion", "unit-lothar", "human-group"}}) 

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-explore",
  Action = "explore",
  Key = "e", Hint = "~!EXPLORE",
  ForUnit = {"unit-footman", "unit-archer", "unit-knight", "unit-water-elemental", "unit-scorpion", "unit-lothar", "human-group"}}) 

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-standground",
  Action = "stand-ground",
  Key = "t", Hint = "S~!TAND GROUND",
  ForUnit = {"unit-footman", "unit-archer", "unit-knight", "unit-human-catapult", "unit-human-catapult-noattack", "unit-water-elemental", "unit-lothar", "human-group"}}) 
  
-----------------------------------------------------------------------
-- New Orders Buttons Orcs
-----------------------------------------------------------------------
local orcpatrol = CIcon:New("icon-orc-patrol")
orcpatrol.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-patrol.png", 27, 19)
orcpatrol.Frame = 0

local orcExplore = CIcon:New("icon-orc-explore")
orcExplore.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-explore.png", 27, 19)
orcExplore.Frame = 0

local orcStandground = CIcon:New("icon-orc-standground")
orcStandground.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-standground.png", 27, 19)
orcStandground.Frame = 0

local orcHoldfire = CIcon:New("icon-orc-holdfire")
orcHoldfire.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-holdfire.png", 27, 19)
orcHoldfire.Frame = 0

DefineButton( { Pos = 5, Level = 0, Icon = "icon-orc-patrol",
  Action = "patrol",
  Key = "r", Hint = "PAT~!ROL",
  ForUnit = {"unit-grunt", "unit-spearman", "unit-raider", "unit-daemon", "unit-spider", "unit-the-dead", "unit-garona", "unit-griselda", "orc-group"}}) 

DefineButton( { Pos = 6, Level = 0, Icon = "icon-orc-explore",
  Action = "explore",
  Key = "e", Hint = "~!EXPLORE",
  ForUnit = {"unit-grunt", "unit-spearman", "unit-raider", "unit-daemon", "unit-spider", "unit-the-dead", "unit-garona", "unit-griselda", "orc-group"}}) 

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-standground",
  Action = "stand-ground",
  Key = "t", Hint = "S~!TAND GROUND",
  ForUnit = {"unit-grunt", "unit-spearman", "unit-raider", "unit-orc-catapult","unit-orc-catapult-noattack", "unit-daemon", "unit-the-dead", "unit-garona", "unit-griselda", "orc-group"}}) 

-----------------------------------------------------------------------
-- Spider Web skill
----------------------------------------------------------------------- 

local orcStandground = CIcon:New("icon-web")
orcStandground.G = CPlayerColorGraphic:New("contrib/graphics/ui/icon-web.png", 27, 19)
orcStandground.Frame = 0

DefineButton( { Pos = 4, Level = 0, Icon = "icon-orc-standground",
  Action = "cast-spell", Value = "spell-slow", 
  Key = "w", Hint = "ENTANGLE IN ~!WEB",
  ForUnit = {"unit-spider"} } )
  
-----------------------------------------------------------------------
-- Scorpion Poison skill
----------------------------------------------------------------------- 

local orcHoldfire = CIcon:New("icon-venom")
orcHoldfire.G = CPlayerColorGraphic:New("contrib/graphics/ui/icon-venom.png", 27, 19)
orcHoldfire.Frame = 0  

DefineButton( { Pos = 4, Level = 0, Icon = "icon-venom",
  Action = "cast-spell", Value = "spell-poison", 
  Key = "v", Hint = "~!VENOM",
  ForUnit = {"unit-scorpion"} } )
    
-----------------------------------------------------------------------
-- Fast first townhall
----------------------------------------------------------------------- 

CopyUnitType("unit-human-town-hall", "unit-human-first-town-hall")

UnitTypeFiles["unit-human-first-town-hall"] = UnitTypeFiles["unit-human-town-hall"]
DefineUnitType("unit-human-first-town-hall", {
   Name = "Town hall",
   Costs = {"time", 10, "gold", 400, "wood", 400},
   AiBuildingRules = townHallBuildingRules,
   BuildingRules = townHallBuildingRules,
   OnReady = function (unit)
      SetPlayerData(GetThisPlayer(), "Resources", "gold",
                      GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-human-town-hall", "Costs", "gold"))
      SetPlayerData(GetThisPlayer(), "Resources", "wood",
                      GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-human-town-hall", "Costs", "wood"))
      TransformUnit(unit, "unit-human-town-hall")
   end,
})

DefineButton( { Pos = 4, Level = 1, Icon = "icon-human-town-hall",
    Action = "build", Value = "unit-human-first-town-hall",
    Allowed = "check-units-nor", AllowArg = {
      "unit-human-first-town-hall",
      "unit-human-town-hall",
      "unit-human-farm",
      "unit-human-barracks",
      "unit-human-lumber-mill",
      "unit-human-stable",
      "unit-human-blacksmith",
      "unit-human-church",
      "unit-human-tower"},
    Key = "t", Hint = "ESTABLISH ~!TOWN",
    ForUnit = {"unit-peasant"} } )

DefineAiHelper(
   {"unit-equiv", "unit-human-town-hall", "unit-human-stormwind-keep", "unit-human-first-town-hall"}
)

DefineAllow("unit-human-first-town-hall", "AAAAAAAAAAAAAAAA")

CopyUnitType("unit-orc-town-hall", "unit-orc-first-town-hall")

UnitTypeFiles["unit-orc-first-town-hall"] = UnitTypeFiles["unit-orc-town-hall"]
DefineUnitType("unit-orc-first-town-hall", {
   Name = "Town hall",
   Costs = {"time", 10, "gold", 400, "wood", 400},
   AiBuildingRules = townHallBuildingRules,
   BuildingRules = townHallBuildingRules,
   OnReady = function (unit)
      SetPlayerData(GetThisPlayer(), "Resources", "gold",
                     GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-orc-town-hall", "Costs", "gold"))
      SetPlayerData(GetThisPlayer(), "Resources", "wood",
                     GetPlayerData(GetThisPlayer(), "Resources", "wood") + GetUnitTypeData("unit-orc-town-hall", "Costs", "wood"))
      TransformUnit(unit, "unit-orc-town-hall")
   end,
})

DefineButton( { Pos = 4, Level = 1, Icon = "icon-orc-town-hall",
    Action = "build", Value = "unit-orc-first-town-hall",
    Allowed = "check-units-nor", AllowArg = {
       "unit-orc-first-town-hall",
       "unit-orc-town-hall",
       "unit-orc-farm",
       "unit-orc-barracks",
       "unit-orc-lumber-mill",
       "unit-orc-kennel",
       "unit-orc-blacksmith",
       "unit-orc-temple",
       "unit-orc-tower"},
    Key = "t", Hint = "ESTABLISH ~!TOWN",
    ForUnit = {"unit-peon"} } )

DefineAiHelper(
   {"unit-equiv", "unit-orc-town-hall", "unit-orc-blackrock-spire", "unit-orc-first-town-hall"}
)

DefineAllow("unit-orc-first-town-hall", "AAAAAAAAAAAAAAAA")
