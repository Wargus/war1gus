-- Everything in here is *changes* on top of the normal unit definitions for
-- better balancing in multiplayer and with War1gus features such as dynamic fog
-- of war and autocasting and such.

-----------------------------------------------------------------------
-- Sightrange Rebalancing Buildings
-----------------------------------------------------------------------

DefineUnitType("unit-human-farm", {SightRange = 5})
DefineUnitType("unit-orc-farm", {SightRange = 5})
DefineUnitType("unit-human-town-hall", {SightRange = 5})
DefineUnitType("unit-orc-town-hall", {SightRange = 5})
DefineUnitType("unit-human-barracks", {SightRange = 5})
DefineUnitType("unit-orc-barracks", {SightRange = 5})
DefineUnitType("unit-human-lumber-mill", {SightRange = 5})
DefineUnitType("unit-orc-lumber-mill", {SightRange = 5})
DefineUnitType("unit-stable", {SightRange = 5})
DefineUnitType("unit-kennel", {SightRange = 5})
DefineUnitType("unit-human-blacksmith", {SightRange = 5})
DefineUnitType("unit-orc-blacksmith", {SightRange = 5})
DefineUnitType("unit-church", {SightRange = 5})
DefineUnitType("unit-temple", {SightRange = 5})
DefineUnitType("unit-human-tower", {SightRange = 5})
DefineUnitType("unit-orc-tower", {SightRange = 5})
DefineUnitType("unit-stormwind-keep", {SightRange = 5})
DefineUnitType("unit-blackrock-spire", {SightRange = 5})

-----------------------------------------------------------------------
-- Sightrange Rebalancing Units
-----------------------------------------------------------------------

DefineUnitType("unit-peasant", {SightRange = 4})
DefineUnitType("unit-peon", {SightRange = 4})
DefineUnitType("unit-footman", {SightRange = 4})
DefineUnitType("unit-grunt", {SightRange = 4})
DefineUnitType("unit-archer", {SightRange = 6})
DefineUnitType("unit-spearman", {SightRange = 6})
DefineUnitType("unit-orc-catapult", {SightRange = 4})
DefineUnitType("unit-human-catapult", {SightRange = 4})
DefineUnitType("unit-raider", {SightRange = 4})
DefineUnitType("unit-knight", {SightRange = 4})
DefineUnitType("unit-raider1", {SightRange = 4})
DefineUnitType("unit-knight1", {SightRange = 4})
DefineUnitType("unit-raider2", {SightRange = 4})
DefineUnitType("unit-knight2", {SightRange = 4})
DefineUnitType("unit-conjurer", {SightRange = 4})
DefineUnitType("unit-warlock", {SightRange = 4})
DefineUnitType("unit-cleric", {SightRange = 5})
DefineUnitType("unit-necrolyte", {SightRange = 5})

-----------------------------------------------------------------------
-- Catapult Rebalancing
-----------------------------------------------------------------------

DefineUnitType("unit-human-catapult", {
                  Costs = {"time", 250, "gold", 900, "wood", 200},
                  Demand = 4,
                  BasicDamage = 150,
                  MaxAttackRange = 8,
                  MinAttackRange = 3,
})
DefineUnitType("unit-orc-catapult", {
                  Costs = {"time", 250, "gold", 900, "wood", 200},
                  Demand = 4,
                  BasicDamage = 150,
                  MaxAttackRange = 8,
                  MinAttackRange = 3,
})

DefineMissileType("missile-catapult-rock", {
                  Speed = 1,
                  Range = 2,
                  SplashFactor = 4
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
                  Costs = {"time", 90, "gold", 850},
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-raider", {
                  Costs = {"time", 90, "gold", 850},
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-knight1", {
                  Costs = {"time", 90, "gold", 850},
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-raider1", {
                  Costs = {"time", 90, "gold", 850},
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-knight2", {
                  Costs = {"time", 90, "gold", 850},
                  Demand = 2,
                  Armor = 1
})
DefineUnitType("unit-raider2", {
                  Costs = {"time", 90, "gold", 850},
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
-- Elemental Rebalancing
-----------------------------------------------------------------------

CasterToElementalMap = {}
ElementalToCasterMap = {}

-- add callback to connect caster with elemental, so they deaths are linked
DefineSpell("spell-summon-elemental", "action", {{"lua-callback", function(spellname, caster, x, y, elemental)
   print(spellname .. " cast by " .. caster .. " at " .. x .. "@" .. y .. " spawning " .. elemental)
   TransformUnit(caster, "unit-conjurer-during-summoning")
   CasterToElementalMap[caster] = elemental
   ElementalToCasterMap[elemental] = caster
   return true
end}})

-- add death callback to elemental
DefineUnitType("unit-water-elemental",{OnDeath = function(elemental, x, y)
   -- elemental will die, release the conjurer from concentration
   local caster = ElementalToCasterMap[elemental]
   if caster then
      table.remove(CasterToElementalMap, caster)
      table.remove(ElementalToCasterMap, elemental)
      TransformUnit(caster, "unit-conjurer")
     -- SetUnitVariable(caster, "Mana", 0)
   end
end})

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
                 OnDeath = function(conjurer, attacker, damage)
                    -- conjurer will die, kill any summoned elemental, if exists
                    local activeElemental = CasterToElementalMap[conjurer]
                    if activeElemental then
                       table.remove(CasterToElementalMap, conjurer)
                       table.remove(ElementalToCasterMap, elemental)
                       RemoveUnit(activeElemental)
                    end
                 end
})

DefineButton({ Pos = 5, Level = 0, Icon = "icon-cancel",
  AlwaysShow = true,
  Key = "esc", Hint = "~<ESC~> BREAK SUMMONING",
  ForUnit = {"unit-conjurer-during-summoning"},
  Action = "callback",
  Value = function(caster)
     local elemental = CasterToElementalMap[caster]
     if elemental then
        table.remove(CasterToElementalMap, caster)
        table.remove(ElementalToCasterMap, elemental)
        RemoveUnit(elemental)
        TransformUnit(caster, "unit-conjurer")
       -- SetUnitVariable(caster, "Mana", 0)
     end
end})

-----------------------------------------------------------------------
-- Daemon Rebalancing
-----------------------------------------------------------------------

CasterToDaemonMap = {}
DaemonToCasterMap = {}

-- add callback to connect caster with daemon, so they deaths are linked
DefineSpell("spell-summon-daemon", "action", {{"lua-callback", function(spellname, caster, x, y, daemon)
   print(spellname .. " cast by " .. caster .. " at " .. x .. "@" .. y .. " spawning " .. daemon)
   TransformUnit(caster, "unit-warlock-during-summoning")
   CasterToDaemonMap[caster] = daemon
   DaemonToCasterMap[daemon] = caster
   return true
end}})

-- add death callback to daemon
DefineUnitType("unit-daemon",{OnDeath = function(daemon, x, y)
   -- daemon will die, release the warlock from concentration
   local caster = DaemonToCasterMap[daemon]
   if caster then
      table.remove(CasterToDaemonMap, caster)
      table.remove(DaemonToCasterMap, daemon)
      TransformUnit(caster, "unit-warlock")
     -- SetUnitVariable(caster, "Mana", 0)
   end
end})

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
                 OnDeath = function(warlock, attacker, damage)
                    -- warlock will die, kill any summoned daemon, if exists
                    local activeDaemon = CasterToDaemonMap[warlock]
                    if activeDaemon then
                       table.remove(CasterToDaemonMap, warlock)
                       table.remove(DaemonToCasterMap, daemon)
                       RemoveUnit(activeDaemon)
                    end
                 end
})

DefineButton({ Pos = 5, Level = 0, Icon = "icon-cancel",
  AlwaysShow = true,
  Key = "esc", Hint = "~<ESC~> BREAK SUMMONING",
  ForUnit = {"unit-warlock-during-summoning"},
  Action = "callback",
  Value = function(caster)
     local daemon = CasterToDaemonMap[caster]
     if daemon then
        table.remove(CasterToDaemonMap, caster)
        table.remove(DaemonToCasterMap, daemon)
        RemoveUnit(daemon)
        TransformUnit(caster, "unit-warlock")
      --  SetUnitVariable(caster, "Mana", 0)
     end
end})
