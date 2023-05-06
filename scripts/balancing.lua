-- Everything in here is *changes* on top of the normal unit definitions for
-- better balancing in multiplayer and with War1gus features such as dynamic fog
-- of war and autocasting and such.

-----------------------------------------------------------------------
--- Preference override
-----------------------------------------------------------------------

Preference.SelectionRectangleIndicatesDamage = true

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

DefineUnitType("unit-human-town-hall",		{Costs = {"time", 500, "gold", 1000,	"wood", 700},Armor = 10, Supply = 3})
DefineUnitType("unit-orc-town-hall",		{Costs = {"time", 500, "gold", 1000,	"wood", 700},Armor = 10, Supply = 3})

DefineUnitType("unit-human-farm",			{Costs = {"time", 200, "gold", 500,		"wood", 300},Armor = 0})
DefineUnitType("unit-orc-farm",				{Costs = {"time", 200, "gold", 500,		"wood", 300},Armor = 0})
DefineUnitType("unit-human-barracks",		{Costs = {"time", 400, "gold", 600, 	"wood", 500},Armor = 10})
DefineUnitType("unit-orc-barracks",			{Costs = {"time", 400, "gold", 600, 	"wood", 500},Armor = 10})
DefineUnitType("unit-human-lumber-mill",	{Costs = {"time", 250, "gold", 600, 	"wood", 150},Armor = 0})
DefineUnitType("unit-orc-lumber-mill",		{Costs = {"time", 250, "gold", 600, 	"wood", 150},Armor = 0})

DefineUnitType("unit-human-stable",		  	{Costs = {"time", 300, "gold", 1000,	"wood", 400},Armor = 0})
DefineUnitType("unit-orc-kennel",			{Costs = {"time", 300, "gold", 1000, 	"wood", 400},Armor = 0})
DefineUnitType("unit-human-blacksmith",		{Costs = {"time", 300, "gold", 900, 	"wood", 400},Armor = 0})
DefineUnitType("unit-orc-blacksmith",		{Costs = {"time", 300, "gold", 900, 	"wood", 400},Armor = 0})

DefineUnitType("unit-human-church",			{Costs = {"time", 300, "gold", 700, 	"wood", 500},Armor = 5})
DefineUnitType("unit-orc-temple",			{Costs = {"time", 300, "gold", 700, 	"wood", 500},Armor = 5})
DefineUnitType("unit-human-tower",			{Costs = {"time", 400, "gold", 1400, 	"wood", 300},Armor = 5})
DefineUnitType("unit-orc-tower",			{Costs = {"time", 400, "gold", 1400, 	"wood", 300},Armor = 5})

DefineUnitType("unit-wall",					{Costs = {"time", 30,  "gold", 0,		"wood", 50}, Armor = 20})

DefineUnitType("unit-gold-mine",			{MaxOnBoard = 2})

DefineDependency("unit-human-stable", { "unit-human-blacksmith"} )
DefineDependency("unit-orc-kennel", { "unit-orc-blacksmith"} )
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
                  Armor = 1,
				  BasicDamage = 11
})
DefineUnitType("unit-raider", {
                  Demand = 2,
                  Armor = 0,
				  BasicDamage = 11,
				  PiercingDamage = 2
})

-----------------------------------------------------------------------
-- Archer/Spearman Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-archer", {
				  HitPoints = 50,
                  PiercingDamage = 1,
                  BasicDamage = 7,
                  Armor = 0
})
DefineUnitType("unit-spearman", {
				  HitPoints = 50,
                  PiercingDamage = 2,
                  BasicDamage = 7,
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
                  BasicDamage = 80,
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
                  BasicDamage = 80,
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
	modifier = {"PiercingDamage", -1}, -- == 2-1 =+1 this means the benefit is +1, instead +2
    },
   {orc = {"axe2", {"grunt", "raider"}, "axe3"},
    human = {"sword2", {"footman", "knight"}, "sword3"},
    cost = {   1200,   1500,     800,     0,     0,     0,     0},
	modifier = {"PiercingDamage", -1},
    },

   {orc = {"spear1", {"spearman", "watch-tower"}, "spear2"},
    human = {"arrow1", {"archer", "guard-tower"}, "arrow2"},
    cost = {   1400,   750,		400,     0,     0,     0,     0},
    },
   {orc = {"spear2", {"spearman", "watch-tower"}, "spear3"},
    human = {"arrow2", {"archer", "guard-tower"}, "arrow3"},
    cost = {   1400,   1500,     800,     0,     0,     0,     0},
    },

   {orc = {"orc-shield1", {"grunt", "raider"}, "orc-shield2"},
    human = {"human-shield1", {"footman", "knight"}, "human-shield2"},
    cost = {   1200,   750, 	400,     0,     0,     0,     0},
	modifier = {"Armor", -1},
   },  
   {orc = {"orc-shield2", {"grunt", "raider"}, "orc-shield3"},
    human = {"human-shield2", {"footman", "knight"}, "human-shield3"},
    cost = {   1200,   1500,     800,     0,     0,     0,     0}, 
	modifier = {"Armor", -1},
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
    cost = {   200,   1500,     0,     0,     0,     0,     0}
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
    Attack = {"unbreakable begin", "frame 0", "attack", "wait 95", "frame 0", "unbreakable end", "wait 1",}, -- attack speed
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
   
DefineButton( { Pos = 1, Level = 0, Icon = "icon-spear2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-spear1"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-orc-watch-tower"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-spear3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-spear2"},
  Key = "a", Hint = "~!ATTACK",
  ForUnit = {"unit-orc-watch-tower"} } )   

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-shield1",
   Action = "stop",
   Key = "s", Hint = "~!STOP",
   ForUnit = {"unit-orc-watch-tower"} } )
   
DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-BuildingArmor1",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-BuildingArmor1"},
  Key = "s", Hint = "~!STOP",
   ForUnit = {"unit-orc-watch-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-BuildingArmor2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-BuildingArmor2"},
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
    Attack = {"unbreakable begin", "frame 0", "attack", "wait 95", "frame 0", "unbreakable end", "wait 1",}, -- attack speed
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
   
DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow2",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow1"},
  Key = "a", Hint = "~!ATTACK",
   ForUnit = {"unit-human-guard-tower"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-arrow3",
  Action = "attack",
  Allowed = "check-upgrade", AllowArg = {"upgrade-arrow2"},
  Key = "a", Hint = "~!ATTACK",
   ForUnit = {"unit-human-guard-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-shield1",
   Action = "stop",
   Key = "s", Hint = "~!STOP",
   ForUnit = {"unit-human-guard-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-BuildingArmor1",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-BuildingArmor1"},
  Key = "s", Hint = "~!STOP",
  ForUnit = {"unit-human-guard-tower"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-BuildingArmor2",
  Action = "stop",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-BuildingArmor2"},
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
	if ((GetPlayerData(GetThisPlayer(), "UnitTypesCount", "unit-orc-town-hall") < 2) and (GetPlayerData(GetThisPlayer(), "Resources", "wood") < GetUnitTypeData("unit-orc-town-hall", "Costs", "wood"))) then
         AddMessage("Refusing to salvage town hall, not enough wood to rebuild!!!")
         return
	end			
      DamageUnit(-1, townHall, GetUnitVariable(townHall, "HitPoints"))
      SetPlayerData(GetThisPlayer(), "Resources", "gold",
                      GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-orc-town-hall", "Costs", "gold"))
   end,
   Allowed = "check-units-or", AllowArg = {"unit-peon"},
   Description = "Confirm salvaging of this Town Hall. ~<YOU NEED AT LEAST 1 PEON!~>",
   Key = "s", Hint = "~!SALVAGE CONFIRM",
   ForUnit = {"unit-orc-town-hall", "unit-orc-blackrock-spire"} } )

----------------------
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
	if ((GetPlayerData(GetThisPlayer(), "UnitTypesCount", "unit-human-town-hall") < 2) and (GetPlayerData(GetThisPlayer(), "Resources", "wood") < GetUnitTypeData("unit-human-town-hall", "Costs", "wood"))) then
         AddMessage("Refusing to salvage town hall, not enough wood to rebuild!!!")
	return
	end
      DamageUnit(-1, townHall, GetUnitVariable(townHall, "HitPoints"))
      SetPlayerData(GetThisPlayer(), "Resources", "gold",
                        GetPlayerData(GetThisPlayer(), "Resources", "gold") + GetUnitTypeData("unit-human-town-hall", "Costs", "gold"))
   end,
   Allowed = "check-units-or", AllowArg = {"unit-peasant"},
   Description = "Confirm salvaging of this Town Hall. ~<YOU NEED AT LEAST 1 PEASANT!~>",
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
  Description = "Regenerate Riders Health",
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
   Description = "Riders regeneration is ~<50%~> faster",
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
  Description = "Increase Knights armor by ~<1~>",
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
   Description = "Increase Knights armor by ~<1~>",
   ForUnit = {"unit-human-stable"} } )

DefineDependency("upgrade-human-barding2", { "upgrade-human-barding1"} )

-----------------------------------------------------------------------
-- Orc light armor upgrades
-----------------------------------------------------------------------

local orcLightArmorIcon1 = CIcon:New("icon-orc-LightArmor1")
orcLightArmorIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-light-armor1.png", 27, 19)
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
  Description = "Increase Spearman, Necrolyte and Warlock armor by ~<1~>",
  ForUnit = {"unit-orc-blacksmith"} } )

local orcLightArmorIcon2 = CIcon:New("icon-orc-LightArmor2")
orcLightArmorIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-light-armor2.png", 27, 19)
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
   Description = "Increase Spearman, Necrolyte and Warlock armor by ~<1~>",
   ForUnit = {"unit-orc-blacksmith"} } )

DefineDependency("upgrade-orc-LightArmor2", { "upgrade-orc-LightArmor1"} )

-----------------------------------------------------------------------
-- Human light armor upgrades
-----------------------------------------------------------------------

local humanLightArmorIcon1 = CIcon:New("icon-human-LightArmor1")
humanLightArmorIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-light-armor1.png", 27, 19)
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
  Description = "Increase Archer, Cleric and Conjurer armor by ~<1~>",
  ForUnit = {"unit-human-blacksmith"} } )

local humanLightArmorIcon2 = CIcon:New("icon-human-LightArmor2")
humanLightArmorIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-light-armor2.png", 27, 19)
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
   Description = "Increase Archer, Cleric and Conjurer armor by ~<1~>",
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
  Description = "Increase Catapul damage by ~<20~>",
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
  Description = "Increase Catapul damage by ~<20~>",
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
  ForUnit = {"unit-footman", "unit-archer", "unit-knight", "unit-water-elemental", "unit-scorpion", "unit-lothar", "human-group", "unit-brigand", "unit-ogre"}}) 

DefineButton( { Pos = 6, Level = 0, Icon = "icon-human-explore",
  Action = "explore",
  Key = "e", Hint = "~!EXPLORE",
  ForUnit = {"unit-footman", "unit-archer", "unit-knight", "unit-water-elemental", "unit-scorpion", "unit-lothar", "human-group", "unit-brigand", "unit-ogre"}}) 

DefineButton( { Pos = 4, Level = 0, Icon = "icon-human-standground",
  Action = "stand-ground",
  Key = "t", Hint = "S~!TAND GROUND",
  ForUnit = {"unit-footman", "unit-archer", "unit-knight", "unit-human-catapult", "unit-human-catapult-noattack", "unit-water-elemental", "unit-lothar", "human-group", "unit-brigand", "unit-ogre"}}) 
  
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

DefineButton( { Pos = 4, Level = 0, Icon = "icon-web",
  Action = "cast-spell", Value = "spell-slow", 
  Key = "w", Hint = "ENTANGLE IN ~!WEB",
  Description = "Slow down the target",
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
  Description = "Poison target dealing damage over time",
  ForUnit = {"unit-scorpion"} } )
    
-----------------------------------------------------------------------
-- Fast first townhall
----------------------------------------------------------------------- 

CopyUnitType("unit-human-town-hall", "unit-human-first-town-hall")

UnitTypeFiles["unit-human-first-town-hall"] = UnitTypeFiles["unit-human-town-hall"]
DefineUnitType("unit-human-first-town-hall", {
   Name = "Town hall",
   Costs = {"time", 10, "gold", 1000, "wood", 700},
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
   Costs = {"time", 10, "gold", 1000, "wood", 700},
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

-----------------------------------------------------------------------
-- Human building armor upgrades
-----------------------------------------------------------------------

local humanBuildingArmorIcon1 = CIcon:New("icon-human-BuildingArmor1")
humanBuildingArmorIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-building-armor1.png", 27, 19)
humanBuildingArmorIcon1.Frame = 0

local humanBuildingArmorUpgrade1 = CUpgrade:New("upgrade-human-BuildingArmor1")
humanBuildingArmorUpgrade1.Icon = humanBuildingArmorIcon1
humanBuildingArmorUpgrade1.Costs[0] = 700 -- time
humanBuildingArmorUpgrade1.Costs[1] = 750 -- gold
humanBuildingArmorUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-BuildingArmor1",
  {"Level", 1},
  {"Armor", 4},
  {"apply-to", "unit-human-town-hall"}, {"apply-to", "unit-human-farm"}, {"apply-to", "unit-human-barracks"}, {"apply-to", "unit-human-lumber-mill"}, {"apply-to", "unit-human-blacksmith"}, {"apply-to", "unit-human-stable"}, {"apply-to", "unit-human-church"}, {"apply-to", "unit-human-tower"}, {"apply-to", "unit-human-guard-tower"})

DefineAllow("upgrade-human-BuildingArmor1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-BuildingArmor1",
  Action = "research", Value = "upgrade-human-BuildingArmor1",
  Allowed = "check-single-research",
  Key = "r", Hint = "UPG~!RADE ROOFS",
  Description = "Increase buildings armor by ~<4~>",
  ForUnit = {"unit-human-lumber-mill"} } )

---
local humanBuildingArmorIcon2 = CIcon:New("icon-human-BuildingArmor2")
humanBuildingArmorIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-building-armor2.png", 27, 19)
humanBuildingArmorIcon2.Frame = 0

local humanBuildingArmorUpgrade2 = CUpgrade:New("upgrade-human-BuildingArmor2")
humanBuildingArmorUpgrade2.Icon = humanBuildingArmorIcon2
humanBuildingArmorUpgrade2.Costs[0] = 700 -- time
humanBuildingArmorUpgrade2.Costs[1] = 1500 -- gold
humanBuildingArmorUpgrade2.Costs[2] = 800 -- wood

DefineModifier("upgrade-human-BuildingArmor2",
   {"Level", 1},
   {"Armor", 4},
   {"apply-to", "unit-human-town-hall"}, {"apply-to", "unit-human-farm"}, {"apply-to", "unit-human-barracks"}, {"apply-to", "unit-human-lumber-mill"}, {"apply-to", "unit-human-blacksmith"}, {"apply-to", "unit-human-stable"}, {"apply-to", "unit-human-church"}, {"apply-to", "unit-human-tower"}, {"apply-to", "unit-human-guard-tower"})

DefineAllow("upgrade-human-BuildingArmor2", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-human-BuildingArmor2",
   Action = "research", Value = "upgrade-human-BuildingArmor2",
   Allowed = "check-upgrade", AllowArg = {"upgrade-human-BuildingArmor1"},
   Key = "r", Hint = "UPG~!RADE WALLS",
   Description = "Increase buildings armor by ~<4~>",
   ForUnit = {"unit-human-lumber-mill"} } )

DefineDependency("upgrade-human-BuildingArmor2", { "upgrade-human-BuildingArmor1"} )

-----------------------------------------------------------------------
-- Orc building armor upgrades
-----------------------------------------------------------------------

local orcBuildingArmorIcon1 = CIcon:New("icon-orc-BuildingArmor1")
orcBuildingArmorIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-building-armor1.png", 27, 19)
orcBuildingArmorIcon1.Frame = 0

local orcBuildingArmorUpgrade1 = CUpgrade:New("upgrade-orc-BuildingArmor1")
orcBuildingArmorUpgrade1.Icon = orcBuildingArmorIcon1
orcBuildingArmorUpgrade1.Costs[0] = 700 -- time
orcBuildingArmorUpgrade1.Costs[1] = 750 -- gold
orcBuildingArmorUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-orc-BuildingArmor1",
  {"Level", 1},
  {"Armor", 4},
  {"apply-to", "unit-orc-town-hall"}, {"apply-to", "unit-orc-farm"}, {"apply-to", "unit-orc-barracks"}, {"apply-to", "unit-orc-lumber-mill"}, {"apply-to", "unit-orc-blacksmith"}, {"apply-to", "unit-orc-kennel"}, {"apply-to", "unit-orc-temple"}, {"apply-to", "unit-orc-tower"}, {"apply-to", "unit-orc-watch-tower"})

DefineAllow("upgrade-orc-BuildingArmor1", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-BuildingArmor1",
  Action = "research", Value = "upgrade-orc-BuildingArmor1",
  Allowed = "check-single-research",
  Key = "r", Hint = "UPG~!RADE BUILDINGS FIRE SUPPRESION",
  Description = "Increase buildings armor by ~<4~>",
  ForUnit = {"unit-orc-lumber-mill"} } )

---
local orcBuildingArmorIcon2 = CIcon:New("icon-orc-BuildingArmor2")
orcBuildingArmorIcon2.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-building-armor2.png", 27, 19)
orcBuildingArmorIcon2.Frame = 0

local orcBuildingArmorUpgrade2 = CUpgrade:New("upgrade-orc-BuildingArmor2")
orcBuildingArmorUpgrade2.Icon = orcBuildingArmorIcon2
orcBuildingArmorUpgrade2.Costs[0] = 700 -- time
orcBuildingArmorUpgrade2.Costs[1] = 1500 -- gold
orcBuildingArmorUpgrade2.Costs[2] = 800 -- wood

DefineModifier("upgrade-orc-BuildingArmor2",
   {"Level", 1},
   {"Armor", 4},
  {"apply-to", "unit-orc-town-hall"}, {"apply-to", "unit-orc-farm"}, {"apply-to", "unit-orc-barracks"}, {"apply-to", "unit-orc-lumber-mill"}, {"apply-to", "unit-orc-blacksmith"}, {"apply-to", "unit-orc-kennel"}, {"apply-to", "unit-orc-temple"}, {"apply-to", "unit-orc-tower"}, {"apply-to", "unit-orc-watch-tower"})

DefineAllow("upgrade-orc-BuildingArmor2", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 2, Level = 0, Icon = "icon-orc-BuildingArmor2",
   Action = "research", Value = "upgrade-orc-BuildingArmor2",
   Allowed = "check-upgrade", AllowArg = {"upgrade-orc-BuildingArmor1"},
   Key = "r", Hint = "UPG~!RADE WALLS",
   Description = "Increase buildings armor by ~<4~>",
   ForUnit = {"unit-orc-lumber-mill"} } )

DefineDependency("upgrade-orc-BuildingArmor2", { "upgrade-orc-BuildingArmor1"} )

-----------------------------------------------------------------------
-- Human Catapult speed upgrades
-----------------------------------------------------------------------

local humanCatapultSpeedIcon1 = CIcon:New("icon-human-CatapultSpeed")
humanCatapultSpeedIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/human/icon-human-catapult-speed.png", 27, 19)
humanCatapultSpeedIcon1.Frame = 0

local humanCatapultSpeedUpgrade1 = CUpgrade:New("upgrade-human-CatapultSpeed")
humanCatapultSpeedUpgrade1.Icon = humanCatapultSpeedIcon1
humanCatapultSpeedUpgrade1.Costs[0] = 700 -- time
humanCatapultSpeedUpgrade1.Costs[1] = 750 -- gold
humanCatapultSpeedUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-human-CatapultSpeed",
  {"Level", 1},
  {"Speed", 1},
  {"apply-to", "unit-human-catapult"})

DefineAllow("upgrade-human-CatapultSpeed", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 3, Level = 0, Icon = "icon-human-CatapultSpeed",
  Action = "research", Value = "upgrade-human-CatapultSpeed",
  Allowed = "check-single-research",
  Key = "s", Hint = "UPGRADE CATAPULT ~!SPEED",
  ForUnit = {"unit-human-lumber-mill"} } )

DefineDependency("upgrade-human-CatapultSpeed", { "unit-human-blacksmith"} )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-human-CatapultSpeed",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  Allowed = "check-upgrade", AllowArg = {"upgrade-human-CatapultSpeed"},
  ForUnit = {"unit-human-catapult"} } )

-----------------------------------------------------------------------
-- Orc Catapult speed upgrades
-----------------------------------------------------------------------

local orcCatapultSpeedIcon1 = CIcon:New("icon-orc-CatapultSpeed")
orcCatapultSpeedIcon1.G = CPlayerColorGraphic:New("contrib/graphics/ui/orc/icon-orc-catapult-speed.png", 27, 19)
orcCatapultSpeedIcon1.Frame = 0

local orcCatapultSpeedUpgrade1 = CUpgrade:New("upgrade-orc-CatapultSpeed")
orcCatapultSpeedUpgrade1.Icon = orcCatapultSpeedIcon1
orcCatapultSpeedUpgrade1.Costs[0] = 700  -- time
orcCatapultSpeedUpgrade1.Costs[1] = 750 -- gold
orcCatapultSpeedUpgrade1.Costs[2] = 400 -- wood

DefineModifier("upgrade-orc-CatapultSpeed",
  {"Level", 1},
  {"Speed", 1},
  {"apply-to", "unit-orc-catapult"})

DefineAllow("upgrade-orc-CatapultSpeed", "AAAAAAAAAAAAAAAA")

DefineButton( { Pos = 3, Level = 0, Icon = "icon-orc-CatapultSpeed",
  Action = "research", Value = "upgrade-orc-CatapultSpeed",
  Allowed = "check-single-research",
  Key = "s", Hint = "UPGRADE CATAPULT ~!SPEED",
  ForUnit = {"unit-orc-lumber-mill"} } )

DefineDependency("upgrade-orc-CatapultSpeed", { "unit-orc-blacksmith"} )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-orc-CatapultSpeed",
  Action = "move",
  Key = "m", Hint = "~!MOVE",
  Allowed = "check-upgrade", AllowArg = {"upgrade-orc-CatapultSpeed"},
  ForUnit = {"unit-orc-catapult"} } )

  -----------------------------------------------------------------------
  --- arrows for towers upgrade
  -----------------------------------------------------------------------
   
  DefineModifier("upgrade-spear1",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-orc-spearman"}, {"apply-to", "unit-orc-watch-tower"})
  
    DefineModifier("upgrade-spear2",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-orc-spearman"}, {"apply-to", "unit-orc-watch-tower"})
    
  DefineModifier("upgrade-arrow1",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-human-archer"}, {"apply-to", "unit-human-guard-tower"})
  
    DefineModifier("upgrade-arrow2",
  {"Level", 1},
  {"PiercingDamage", 1},
  {"apply-to", "unit-human-archer"}, {"apply-to", "unit-human-guard-tower"})

-----------------------------------------------------------------------
-- neutral buildings
-----------------------------------------------------------------------

local DefineMagmaRiftIcon = function()
   local iconname
   if war1gus.tileset == "forest" or war1gus.tileset == "forest_campaign" then
      iconname = "contrib/graphics/ui/icon-magma-rift.png"
   else
      iconname = "contrib/graphics/ui/icon-swamp-magma-rift.png"
   end
   local MagmaRiftIcon = CIcon:New("icon-magma-rift")
   MagmaRiftIcon.G = CPlayerColorGraphic:New(iconname, 27, 19)
   MagmaRiftIcon.Frame = 0
end
DefineMagmaRiftIcon()
OnTilesetChangeFunctions:add(DefineMagmaRiftIcon)

local DefineSlimePondIcon = function()
   local iconname
   if war1gus.tileset == "forest" or war1gus.tileset == "forest_campaign" then
      iconname = "contrib/graphics/ui/icon-slime-pond.png"
   else
      iconname = "contrib/graphics/ui/icon-swamp-slime-pond.png"
   end
   local SlimePondIcon = CIcon:New("icon-slime-pond")
   SlimePondIcon.G = CPlayerColorGraphic:New(iconname, 27, 19)
   SlimePondIcon.Frame = 0
end
DefineSlimePondIcon()
OnTilesetChangeFunctions:add(DefineSlimePondIcon)

local DefineWindmillIcon = function()
   local iconname
   if war1gus.tileset == "forest" or war1gus.tileset == "forest_campaign" then
      iconname = "contrib/graphics/ui/icon-windmill.png"
   else
      iconname = "contrib/graphics/ui/icon-swamp-windmill.png"
   end
   local WindmillIcon = CIcon:New("icon-windmill")
   WindmillIcon.G = CPlayerColorGraphic:New(iconname, 27, 19)
   WindmillIcon.Frame = 0
end
DefineWindmillIcon()
OnTilesetChangeFunctions:add(DefineWindmillIcon)

local DefineRuinIcon = function()
   local iconname
   if war1gus.tileset == "forest" or war1gus.tileset == "forest_campaign" then
      iconname = "contrib/graphics/ui/icon-ruin.png"
   else
      iconname = "contrib/graphics/ui/icon-swamp-ruin.png"
   end
   local RuinIcon = CIcon:New("icon-ruin")
   RuinIcon.G = CPlayerColorGraphic:New(iconname, 27, 19)
   RuinIcon.Frame = 0
end
DefineRuinIcon()
OnTilesetChangeFunctions:add(DefineRuinIcon)

DefineAnimations(
   "animations-magma-rift", 
   {Still = {"frame 0", "wait 9", "frame 1", "wait 9", "frame 2", "wait 9", "frame 3", "wait 9", "frame 4", "wait 9", "frame 5", "wait 9", "frame 6", "wait 9", "frame 7", "wait 9", "frame 8", "wait 9", "frame 9", "wait 9", "frame 10", "wait 9", "frame 11", "wait 9", "frame 12", "wait 9", "frame 13", "wait 9", "frame 14", "wait 9", "frame 15", "wait 9", "frame 16", "wait 9"},
    Death = {"frame 0", "wait 1"}}
)

DefineUnitType("unit-magma-rift", { Name = _("Magma Rift"),
  Image = {
     "file", "contrib/graphics/buildings/magma_rift.png",
     "size", {64, 64}
  },
  Animations = "animations-magma-rift", Icon = "icon-magma-rift",
  Costs = {"time", 300, "gold", 500, "wood", 450},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Speed = 0,
  HitPoints = 13000,
  DrawLevel = 40,
  TileSize = {4, 3}, BoxSize = {64, 48},
  SightRange = 9, ComputerReactionRange = 6, PersonReactionRange = 6,
  Armor = 25,
  Priority = 0, AnnoyComputerFactor = 0,
  Points = 200,
  Corpse = "unit-destroyed-4x4-place",
  ExplodeWhenKilled = "missile-building-collapse",
  Type = "land",
  CanAttack = false,
  Building = true, VisibleUnderFog = true,
  DetectCloak = true,
  Elevated = true,
  OnEachSecond = function(unit)
   local cnt = GetUnitVariable(unit, "Supply", "Max")
   if cnt > 150 then
      local ply = GetUnitVariable(unit, "Player")
      SetUnitVariable(unit, "Supply", 0, "Max")
      local x = GetUnitVariable(unit, "PosX")
      local y = GetUnitVariable(unit, "PosY")
      local newUnit = CreateUnit("unit-fire-elemental", ply, {x, y})
      OrderUnit(ply, "unit-fire-elemental", {x - 5, y - 5, x + 9, y + 9}, {0, 0}, "explore")
   else
      SetUnitVariable(unit, "Supply", cnt + 1, "Max")
   end
  end,
  Sounds = {
    "dead", "building destroyed"} } )

DefineAllow("unit-magma-rift", "AAAAAAAAAAAAAAAA")



DefineAnimations(
   "animations-slime-pond", 
   {Still = {"frame 0", "wait 9", "frame 1", "wait 9", "frame 2", "wait 9", "frame 3", "wait 9", "frame 4", "wait 9", "frame 5", "wait 9", "frame 6", "wait 9", "frame 7", "wait 9", "frame 8", "wait 9", "frame 9", "wait 9", "frame 10", "wait 9", "frame 11", "wait 9", "frame 12", "wait 9", "frame 13", "wait 9", "frame 14", "wait 9", "frame 15", "wait 9", "frame 16", "wait 9","frame 17", "wait 9","frame 18", "wait 9","frame 19", "wait 9","frame 20", "wait 9"},
    Death = {"frame 0", "wait 1"}}
)

DefineUnitType("unit-slime-pond", { Name = _("Slime Pond"),
  Image = {
     "file", "contrib/graphics/buildings/slime_pond.png",
     "size", {64, 64}
  },
  Animations =   "animations-slime-pond",  Icon = "icon-slime-pond",
  Costs = {"time", 300, "gold", 500, "wood", 450},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Speed = 0,
  HitPoints = 13000,
  DrawLevel = 40,
  TileSize = {3, 3}, BoxSize = {48, 48},
  SightRange = 9, ComputerReactionRange = 6, PersonReactionRange = 6,
  Armor = 25,
  Priority = 0, AnnoyComputerFactor = 0,
  Points = 200,
  Corpse = "unit-destroyed-4x4-place",
  ExplodeWhenKilled = "missile-building-collapse",
  Type = "land",
  CanAttack = false,
  Building = true, VisibleUnderFog = true,
  DetectCloak = true,
  Elevated = true,
  OnEachSecond = function(unit)
   local cnt = GetUnitVariable(unit, "Supply", "Max")
   if cnt > 80 then
      local ply = GetUnitVariable(unit, "Player")
      SetUnitVariable(unit, "Supply", 0, "Max")
      local x = GetUnitVariable(unit, "PosX")
      local y = GetUnitVariable(unit, "PosY")
      local newUnit = CreateUnit("unit-slime", ply, {x, y})

      local demand = GetUnitVariable(unit, "Demand", "Max")
      if demand < 5 then
         SetUnitVariable(unit, "Demand", demand + 1, "Max")
      else
         SetUnitVariable(unit, "Demand", 0, "Max")
         OrderUnit(ply, "unit-slime", {x - 5, y - 5, x + 9, y + 9}, {0, 0}, "explore")
      end
   else
      SetUnitVariable(unit, "Supply", cnt + 1, "Max")
   end
  end,
  Sounds = {
    "dead", "building destroyed"} } )

DefineAllow("unit-slime-pond", "AAAAAAAAAAAAAAAA")


DefineAnimations(
   "animations-windmill", 
   {Still = {"frame 0", "wait 9", "frame 1", "wait 9", "frame 2", "wait 9", "frame 3", "wait 9"},
    Death = {"frame 0", "wait 1"}}
)

DefineUnitType("unit-windmill", { Name = _("Windmill"),
  Image = {
     "file", "contrib/graphics/buildings/windmill.png",
     "size", {64, 64}
  },
  Animations =   "animations-windmill",  Icon = "icon-windmill",
  Costs = {"time", 300, "gold", 500, "wood", 450},
  Supply = 25,
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Speed = 0,
  HitPoints = 13000,
  DrawLevel = 40,
  TileSize = {3, 3}, BoxSize = {48, 48},
  SightRange = 9, ComputerReactionRange = 6, PersonReactionRange = 6,
  Armor = 25,
  Priority = 0, AnnoyComputerFactor = 0,
  Points = 200,
  Corpse = "unit-destroyed-4x4-place",
  ExplodeWhenKilled = "missile-building-collapse",
  Type = "land",
  CanAttack = false,
  Building = true, VisibleUnderFog = true,
  DetectCloak = true,
  Elevated = true,
  OnEachSecond = function(windmill)
   local neighbours = GetUnitsAroundUnit(windmill, 1, true)
   local ply = -1
   for i,u in ipairs(neighbours) do
      if not GetUnitBoolFlag(u, "Building") then
         local uPly = GetUnitVariable(u, "Player")
         if ply < 0 then
            ply = uPly
         elseif ply ~= uPly then
            return
         end
         if ply >= 0  then
            local curP = GetUnitVariable(windmill, "Player")
            if curP ~= ply then
               local x = GetUnitVariable(windmill, "PosX")
               local y = GetUnitVariable(windmill, "PosY")
               ChangeUnitsOwner({x, y}, {x + 4, y + 4}, curP, ply, "unit-windmill")
            end
         end
      end
   end
  end,
  Sounds = {
    "dead", "building destroyed"} } )
 
DefineAllow("unit-windmill", "AAAAAAAAAAAAAAAA")

DefineAnimations(
   "animations-ruin", 
   {Still = {"frame 0", "wait 5"},
    Death = {"frame 0", "wait 1"}}
)

DefineUnitType("unit-brigand", { Image = { "file", "neutral/units/colored-brigand.png", "size", { 32, 32 } } })

for i,spec in ipairs({
   { Var = "Supply", Gold = 700, Unit = "brigand" },
   { Var = "Demand", Gold = 1200, Unit = "ogre" },
}) do   
   DefinePopup({
      Ident = "popup-" .. spec.Unit,
      BackgroundColor = PopupBackgroundColor,
      BorderColor = PopupBorderColor,
      Contents = {
         { 
            Margin = {1, 1}, HighlightColor = "yellow",
            More = {"ButtonInfo", {InfoType = "Hint", Font = PopupFont}}
         },
         {
            Margin = {1, 1},
            More = {"Line", {Width = 0, Height = 1, Color = PopupBorderColor}}
         },
         {
            Margin = {1, 1}, HighlightColor = "yellow",
            More = {
               "Variable", {
                  Text = function()
                     local avail = math.floor(GetUnitVariable(-1, spec.Var, "Max") / 40)
                     if avail == 0 then
                        return "No " .. spec.Unit .. " currently looking for work."
                     else
                        local name = spec.Unit
                        if avail > 1 then
                           name = name .. "s"
                        end
                        return "~<" .. avail .. "~> " .. name .. " currently looking for work."
                     end
                  end,
                  Font = PopupFont
               }
            }
         },
         {
            Margin = {1, 1}, HighlightColor = "yellow",
            More = {
               "Variable", {
                  Text = function()
                     local avail = math.floor(GetUnitVariable(-1, spec.Var, "Max") / 40)
                     if avail == 0 then
                        return ""
                     elseif avail > 1 then
                        return "They want ~<" .. spec.Gold .. " gold~> each."
                     else
                        return "He wants ~<" .. spec.Gold .. " gold~>."
                     end
                  end,
                  Font = PopupFont
               }
            }
         },
      }
   })
   DefineSpell("spell-hire-" .. spec.Unit,
      "manacost", 0, "range", 0, "target", "self", "cooldown", 5, "action", {
         { "lua-callback", function(ident, caster, goalX, goalY, target)
            local value = GetUnitVariable(caster, spec.Var, "Max")
            if value < 40 then
               AddMessage("No one here looking for a job right now...")
               return false
            end

            local neighbours = GetUnitsAroundUnit(caster, 2, true)
            local ply = -1
            for i,u in ipairs(neighbours) do
               if not GetUnitBoolFlag(u, "Building") then
                  local uPly = GetUnitVariable(u, "Player")
                  if ply >= 0 then
                     if uPly ~= ply then
                        AddMessage("You are not the only one looking to hire...")
                        AddMessage("Get rid of the competition first!")
                        return false
                     end
                  else
                     ply = uPly
                  end
               end
            end
            if ply ~= GetThisPlayer() then
               AddMessage("None of your troops are near to conclude the deal...")
               return false
            end
            local gold = GetPlayerData(ply, "Resources", "gold")
            if gold < spec.Gold then
               AddMessage(_("Not enough gold...mine more gold."))
               return false
            end
            SetUnitVariable(caster, spec.Var, value - 40, "Max")
            CreateUnit("unit-" .. spec.Unit, ply, {goalX, goalY})
            SetPlayerData(ply, "Resources", "gold", gold - spec.Gold)
            return false
         end }
      }
   )
end

DefineUnitType("unit-ruin", { Name = _("Ruin"),
  Image = {
     "file", "contrib/graphics/buildings/ruin.png",
     "size", {48, 48}
  },
  Animations =   "animations-ruin",  Icon = "icon-ruin",
  Costs = {"time", 300, "gold", 500, "wood", 450},
  RepairHp = 4,
  RepairCosts = {"gold", 1, "wood", 1},
  Speed = 0,
  HitPoints = 1000,
  DrawLevel = 40,
  TileSize = {2, 2}, BoxSize = {32, 32},
  SightRange = 9, ComputerReactionRange = 6, PersonReactionRange = 6,
  Armor = 5,
  Priority = 0, AnnoyComputerFactor = 0,
  Points = 200,
  Corpse = "unit-destroyed-2x2-place",
  ExplodeWhenKilled = "missile-building-collapse",
  Type = "land",
  CanAttack = false,
  Building = true, VisibleUnderFog = true,
  DetectCloak = true,
  Elevated = true,
  CanCastSpell = {"spell-hire-brigand", "spell-hire-ogre"},
  OnEachSecond = function(ruin)
   local supply = GetUnitVariable(ruin, "Supply", "Max")
   if supply < 240 then
      SetUnitVariable(ruin, "Supply", supply + 1, "Max")
   end
   local demand = GetUnitVariable(ruin, "Demand", "Max")
   if demand < 240 then
      SetUnitVariable(ruin, "Demand", demand + 1, "Max")
   end
  end,
  Sounds = {
    "dead", "building destroyed"} } )

DefineButton( { Pos = 1, Level = 0, Icon = "icon-brigand",
   Popup = "popup-brigand",
   Action = "cast-spell", Value = "spell-hire-brigand",
   Key = "b", Hint = "HIRE ~!BRIGAND",
   Description = "Brigand is a bit faster, and can outrun units",
   ForUnit = {"unit-ruin"} } )

DefineButton( { Pos = 2, Level = 0, Icon = "icon-ogre",
   Popup = "popup-ogre",
   Action = "cast-spell", Value = "spell-hire-ogre",
   Key = "g", Hint = "HIRE O~!GRE",
   ForUnit = {"unit-ruin"} } )

DefineUnitType("unit-brigand", {
	Speed = 5,
	HitPoints = 60,
	Armor = 1, 
	BasicDamage = 8,
})

DefineUnitType("unit-ogre", {
	Speed = 3,
    HitPoints = 100,
    Demand = 3,
	Armor = 0, 
    BasicDamage = 29,
})

DefineAnimations("animations-ogre",
		 BuildAnimations(GetFrameNumbers(5, {5, 5, 5}),
				 {attackspeed = 10,
				 coolofftime = 50,
				 attacksound = "fist attack"}))

DefineAllow("unit-ruin", "AAAAAAAAAAAAAAAA")
DefineAllow("unit-brigand", "AAAAAAAAAAAAAAAA")
DefineAllow("unit-ogre", "AAAAAAAAAAAAAAAA")

-----------------------------------------------------------------------
-- Low health sprites
-----------------------------------------------------------------------

local g = CPlayerColorGraphic:New("contrib/graphics/units/conjurer-alt.png", 32, 32)
g:OverlayGraphic(CGraphic:New("human/units/conjurer.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/conjurer-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/conjurer-alt-hair.png"))
DefineUnitType("unit-conjurer", {Image = {"alt-file", "contrib/graphics/units/conjurer-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/knight-alt.png", 32, 32)
g:OverlayGraphic(CGraphic:New("human/units/knight.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/knight-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/knight-alt-nohelmet.png"))
DefineUnitType("unit-knight", {Image = {"alt-file", "contrib/graphics/units/knight-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/footman-alt.png", 48, 48)
g:OverlayGraphic(CGraphic:New("human/units/footman.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/footman-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/footman-alt-noshield.png"))
DefineUnitType("unit-footman", {Image = {"alt-file", "contrib/graphics/units/footman-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/cleric-alt.png", 32, 32)
g:OverlayGraphic(CGraphic:New("human/units/cleric.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/cleric-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/cleric-alt-nostick.png"))
DefineUnitType("unit-cleric", {Image = {"alt-file", "contrib/graphics/units/cleric-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/catapult-alt.png", 32, 32)
g:OverlayGraphic(CGraphic:New("human/units/catapult.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/catapult-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/catapult-alt-pin.png"))
DefineUnitType("unit-human-catapult", {Image = {"alt-file", "contrib/graphics/units/catapult-alt.png"}})
DefineUnitType("unit-orc-catapult", {Image = {"alt-file", "contrib/graphics/units/catapult-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/footman-alt.png", 48, 48)
g:OverlayGraphic(CGraphic:New("human/units/footman.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/footman-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/footman-alt-noshield.png"))
DefineUnitType("unit-footman", {Image = {"alt-file", "contrib/graphics/units/footman-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/warlock-alt.png", 32, 32)
g:OverlayGraphic(CGraphic:New("orc/units/warlock.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/warlock-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/warlock-alt-nohood.png"))
DefineUnitType("unit-warlock", {Image = {"alt-file", "contrib/graphics/units/warlock-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/necrolyte-alt.png", 32, 32)
g:OverlayGraphic(CGraphic:New("orc/units/necrolyte.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/necrolyte-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/necrolyte-alt-nohood.png"))
DefineUnitType("unit-necrolyte", {Image = {"alt-file", "contrib/graphics/units/necrolyte-alt.png"}})

local g = CPlayerColorGraphic:New("contrib/graphics/units/raider-alt.png", 48, 48)
g:OverlayGraphic(CGraphic:New("orc/units/raider.png"))
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/raider-alt-mask.png"), true)
g:OverlayGraphic(CGraphic:New("contrib/graphics/units/raider-alt-nobrass.png"))
DefineUnitType("unit-raider", {Image = {"alt-file", "contrib/graphics/units/raider-alt.png"}})
-----------------------------------------------------------------------
-- Low health icons
-----------------------------------------------------------------------

local humanPaletteSwap = {
   "HitPoints", {
     142, -- some skin part
     { -- # health steps
       { -- # of alternatives for step
         {{191, 47, 27}},
       },
       {
         {{224, 141, 104}},
       },
       {
         {{224, 141, 104}},
       },
       {
         {{224, 141, 104}},
       },
     },
   },
 }
 
 local orcPaletteSwap = {
   "HitPoints", {
     172, -- some skin part
     {
       {
         {{124, 0, 0}}
       },
       {
         {{24, 84, 16}}
       },
       {
         {{24, 84, 16}}
       },
       {
         {{24, 84, 16}}
       }
     }
   },
 }
 
for idx,icon in ipairs(icons) do
   local nameToSwap = {
      {"icon-footman", humanPaletteSwap},
      {"icon-grunt", orcPaletteSwap},
      {"icon-conjurer", humanPaletteSwap},
      {"icon-warlock", orcPaletteSwap},
      {"icon-peasant", humanPaletteSwap},
      {"icon-peon", orcPaletteSwap},
      {"icon-knight", humanPaletteSwap},
      {"icon-raider", orcPaletteSwap},
      {"icon-archer", humanPaletteSwap},
      {"icon-spearman", orcPaletteSwap},
      {"icon-cleric", humanPaletteSwap},
      {"icon-necrolyte", orcPaletteSwap},
   }
   for idx2,pair in ipairs(nameToSwap) do
      if pair[1] == icon[1] then
         icon[3] = pair[2]
         break
      end
   end
end
