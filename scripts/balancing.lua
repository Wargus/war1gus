-- Everything in here is *changes* on top of the normal unit definitions for
-- better balancing in multiplayer and with War1gus features such as dynamic fog
-- of war and autocasting and such.

-----------------------------------------------------------------------
-- Sightrange Rebalancing Buildings
-----------------------------------------------------------------------

DefineUnitType("unit-human-farm", 			  {SightRange = 5})
DefineUnitType("unit-orc-farm", 			    {SightRange = 5})
DefineUnitType("unit-human-town-hall", 	  {SightRange = 5})
DefineUnitType("unit-orc-town-hall", 		  {SightRange = 5})
DefineUnitType("unit-human-barracks", 	  {SightRange = 5})
DefineUnitType("unit-orc-barracks", 		  {SightRange = 5})
DefineUnitType("unit-human-lumber-mill",	{SightRange = 5})
DefineUnitType("unit-orc-lumber-mill", 		{SightRange = 5})
DefineUnitType("unit-human-stable", 		  {SightRange = 5})
DefineUnitType("unit-orc-kennel", 			  {SightRange = 5})
DefineUnitType("unit-human-blacksmith", 	{SightRange = 5})
DefineUnitType("unit-orc-blacksmith", 		{SightRange = 5})
DefineUnitType("unit-human-church", 		  {SightRange = 5})
DefineUnitType("unit-orc-temple", 			  {SightRange = 5})
DefineUnitType("unit-human-tower", 			  {SightRange = 5})
DefineUnitType("unit-orc-tower", 			    {SightRange = 5})
DefineUnitType("unit-stormwind-keep", 		{SightRange = 5})
DefineUnitType("unit-blackrock-spire", 		{SightRange = 5})

-----------------------------------------------------------------------
-- Sightrange Rebalancing Units
-----------------------------------------------------------------------

DefineUnitType("unit-peasant", 			  {SightRange = 4})
DefineUnitType("unit-peon", 			    {SightRange = 4})
DefineUnitType("unit-footman", 		  	{SightRange = 4})
DefineUnitType("unit-grunt", 			    {SightRange = 4})
DefineUnitType("unit-archer", 			  {SightRange = 6})
DefineUnitType("unit-spearman", 		  {SightRange = 6})
DefineUnitType("unit-orc-catapult", 	{SightRange = 4})
DefineUnitType("unit-human-catapult", {SightRange = 4})
DefineUnitType("unit-raider", 			  {SightRange = 4})
DefineUnitType("unit-knight", 			  {SightRange = 4})
DefineUnitType("unit-raider1", 			  {SightRange = 4})
DefineUnitType("unit-knight1", 			  {SightRange = 4})
DefineUnitType("unit-raider2", 			  {SightRange = 4})
DefineUnitType("unit-knight2", 			  {SightRange = 4})
DefineUnitType("unit-conjurer", 		  {SightRange = 4})
DefineUnitType("unit-warlock", 			  {SightRange = 4, MaxAttackRange = 3})
DefineUnitType("unit-cleric", 			  {SightRange = 5, MaxAttackRange = 2})
DefineUnitType("unit-necrolyte", 		  {SightRange = 5})

-----------------------------------------------------------------------
-- Cost Rebalancing Buildings
-----------------------------------------------------------------------

DefineUnitType("unit-human-farm",			    {Costs = {"time", 200, "gold", 500,		"wood", 300},})
DefineUnitType("unit-orc-farm",			    	{Costs = {"time", 200, "gold", 500,		"wood", 300},})
DefineUnitType("unit-human-barracks",		  {Costs = {"time", 300, "gold", 600, 	"wood", 500},})
DefineUnitType("unit-orc-barracks",			  {Costs = {"time", 300, "gold", 600, 	"wood", 500},})
DefineUnitType("unit-human-lumber-mill",	{Costs = {"time", 250, "gold", 600, 	"wood", 150},})
DefineUnitType("unit-orc-lumber-mill",		{Costs = {"time", 250, "gold", 600, 	"wood", 150},})

DefineUnitType("unit-human-stable",		  	{Costs = {"time", 300, "gold", 1000,	"wood", 400},})
DefineUnitType("unit-orc-kennel",			    {Costs = {"time", 300, "gold", 1000, 	"wood", 400},})
DefineUnitType("unit-human-blacksmith",		{Costs = {"time", 300, "gold", 900, 	"wood", 400},})
DefineUnitType("unit-orc-blacksmith",		  {Costs = {"time", 300, "gold", 900, 	"wood", 400},})

DefineUnitType("unit-human-church",		  	{Costs = {"time", 400, "gold", 800, 	"wood", 500},})
DefineUnitType("unit-orc-temple",			    {Costs = {"time", 400, "gold", 800, 	"wood", 500},})
DefineUnitType("unit-human-tower",		  	{Costs = {"time", 400, "gold", 1400, 	"wood", 300},})
DefineUnitType("unit-orc-tower",			    {Costs = {"time", 400, "gold", 1400, 	"wood", 300},})

DefineUnitType("unit-wall",					      {Costs = {"time", 30,  "gold", 0,		"wood", 50},})

DefineUnitType("unit-gold-mine", 		    	{MaxOnBoard = 2})

-----------------------------------------------------------------------
-- Cost Rebalancing Units
-----------------------------------------------------------------------

DefineUnitType("unit-peasant", 				{Costs = {"time", 75,  "gold", 350, "wood", 0},})
DefineUnitType("unit-peon", 				  {Costs = {"time", 75,  "gold", 350, "wood", 0},})
DefineUnitType("unit-footman", 				{Costs = {"time", 150, "gold", 400, "wood", 0},})
DefineUnitType("unit-grunt", 				  {Costs = {"time", 150, "gold", 400, "wood", 0},})
DefineUnitType("unit-archer", 				{Costs = {"time", 200, "gold", 450, "wood", 50},})
DefineUnitType("unit-spearman", 			{Costs = {"time", 200, "gold", 450, "wood", 50},})
DefineUnitType("unit-orc-catapult", 	{Costs = {"time", 300, "gold", 650, "wood", 300},})
DefineUnitType("unit-human-catapult", {Costs = {"time", 300, "gold", 650, "wood", 300},})

DefineUnitType("unit-raider", 				{Costs = {"time", 250, "gold", 750, "wood", 100},}										  )
DefineUnitType("unit-knight", 				{Costs = {"time", 250, "gold", 750, "wood", 100},})
DefineUnitType("unit-raider1", 				{Costs = {"time", 250, "gold", 750, "wood", 100},})
DefineUnitType("unit-knight1", 				{Costs = {"time", 250, "gold", 750, "wood", 100},})
DefineUnitType("unit-raider2", 				{Costs = {"time", 250, "gold", 750, "wood", 100},})
DefineUnitType("unit-knight2", 				{Costs = {"time", 250, "gold", 750, "wood", 100},})

DefineUnitType("unit-cleric", 				{Costs = {"time", 300, "gold", 600, "wood", 50},})
DefineUnitType("unit-necrolyte", 			{Costs = {"time", 300, "gold", 600, "wood", 50},})
DefineUnitType("unit-conjurer", 			{Costs = {"time", 350, "gold", 800, "wood", 100},})
DefineUnitType("unit-warlock", 				{Costs = {"time", 350, "gold", 800, "wood", 100},})

-----------------------------------------------------------------------
-- Catapult Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-human-catapult", {                  
                  Demand = 3,
                  BasicDamage = 150,
                  MaxAttackRange = 8,
                  MinAttackRange = 3,
})
DefineUnitType("unit-orc-catapult", {                  
                  Demand = 3,
                  BasicDamage = 150,
                  MaxAttackRange = 8,
                  MinAttackRange = 3,
})

DefineMissileType("missile-catapult-rock", {
                  Speed = 1,
                  Range = 2,
                  SplashFactor = 4,
                  NumDirections = 9
})

-----------------------------------------------------------------------
-- Grunt/Footman Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-footman", {
                  Armor = 0
})
DefineUnitType("unit-grunt", {
                  Armor = 0
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
                  Armor = 1
})
DefineUnitType("unit-knight1", {
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-raider1", {
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-knight2", {
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-raider2", {
                  Demand = 2,
                  Armor = 1
})

-----------------------------------------------------------------------
-- Archer/Spearman Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-archer", {
                  PiercingDamage = 1,
                  BasicDamage = 3
})
DefineUnitType("unit-spearman", {
                  PiercingDamage = 2,
                  BasicDamage = 3
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

DefineSpell("spell-summon-elemental", "action", {{"lua-callback", SummonSpellCallback}})
DefineSpell("spell-summon-daemon", "action", {{"lua-callback", SummonSpellCallback}})

-- add death callback to elemental
local SummonedDeathCallback = function(summoned, x, y)
   -- elemental will die, release the conjurer from concentration
   local caster = SummonedToCasterMap[summoned]
   table.remove(CasterToSummonedMap, caster)
   table.remove(SummonedToCasterMap, summoned)
   if caster and caster > 0 then
      local casterIdent = GetUnitVariable(caster, "Ident")
      local hp = GetUnitVariable(caster, "HitPoints")
      -- there can be races, so be extra careful
      if hp > 0 then
         if casterIdent == "unit-conjurer-during-summoning" then
            TransformUnit(caster, "unit-conjurer")
         elseif casterIdent == "unit-warlock-during-summoning" then
            TransformUnit(caster, "unit-warlock")
         end
      end
   end
end

DefineUnitType("unit-water-elemental",{OnDeath = SummonedDeathCallback})
DefineUnitType("unit-daemon",{OnDeath = SummonedDeathCallback})

-- define summoner states and deaths
local SummonerDeathCallback = function(caster, attacker, damage)
   -- caster will die, kill any summoned unit, if exists
   local activeSummoned = CasterToSummonedMap[caster]
   table.remove(CasterToSummonedMap, caster)
   table.remove(SummonedToCasterMap, activeSummoned)
   if activeSummoned and activeSummoned > 0 then
      local hp = GetUnitVariable(activeSummoned, "HitPoints")
      if hp > 0 then
         local summonedIdent = GetUnitVariable(activeSummoned, "Ident")
         local casterIdent = GetUnitVariable(caster, "Ident")
         if casterIdent == "unit-conjurer-during-summoning" then
            if summonedIdent == "unit-water-elemental" then
               RemoveUnit(activeSummoned)
            end
         elseif casterIdent == "unit-warlock-during-summoning" then
            if summonedIdent == "unit-daemon" then
               RemoveUnit(activeSummoned)
            end
         end
      end
   end
end

local SummonerCancelButtonAction = function(caster)
   SummonerDeathCallback(caster, -1, 0)
   local casterIdent = GetUnitVariable(caster, "Ident")
   local hp = GetUnitVariable(caster, "HitPoints")
   if hp > 0 then
      if casterIdent == "unit-conjurer-during-summoning" then
         TransformUnit(caster, "unit-conjurer")
      elseif casterIdent == "unit-warlock-during-summoning" then
         TransformUnit(caster, "unit-warlock")
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
   {orc = {"axe1", {"grunt", "raider", "raider1", "raider2"}, "axe2"},
    human = {"sword1", {"footman", "knight", "knight1", "knight2"}, "sword2"},
    cost = {   1200,   750,     400,     0,     0,     0,     0},
    },
   {orc = {"axe2", {"grunt", "raider", "raider1", "raider2"}, "axe3"},
    human = {"sword2", {"footman", "knight", "knight1", "knight2"}, "sword3"},
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

   {orc = {"orc-shield1", {"grunt", "raider", "raider1", "raider2"}, "orc-shield2"},
    human = {"human-shield1", {"footman", "knight", "knight1", "knight2"}, "human-shield2"},
    cost = {   1200,   750, 	400,     0,     0,     0,     0},
   },  
   {orc = {"orc-shield2", {"grunt", "raider", "raider1", "raider2"}, "orc-shield3"},
    human = {"human-shield2", {"footman", "knight", "knight1", "knight2"}, "human-shield3"},
    cost = {   1200,   1500,     800,     0,     0,     0,     0}, 
    },

   {orc = {"wolves1", {"raider"}},
    human = {"horse1", {"knight"}},
    cost = {   700,   750, 	400,     0,     0,     0,     0},
    },
   {orc = {"wolves2", {"raider1"}},
    human = {"horse2", {"knight1"}},
    cost = {   700,   1500,     800,     0,     0,     0,     0},
   },	
}

for idx,spec in ipairs(upgrades) do
   DefineUpgradeFromSpec(spec)
end
