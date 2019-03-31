--       _________ __                 __
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      units.lua - Define the used unit-types.
--
--      (c) Copyright 1998-2004 by Lutz Sammer and Jimmy Salmon
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--      $Id$

-- =============================================================================
-- Helper functions
--

wc1_buildings = { orc = { }, human = { } }
wc1_units = { orc = { }, human = { }, neutral = { } }
wc1_upgrades = { orc = { }, human = { } }
UnitEquivalents = UnitEquivalents or { }

function DefineBuildingFromSpec(building)
    local orcident
    local humanident
    for race, name in pairs(building.Names) do
        local size
        if (type(building.Size) == "table" and building.Size[race]) then
            size = building.Size[race]
        else
            size = building.Size
        end
        local filename = string.lower(string.gsub(name, " ", "_"))
        local fullname = race .. "-" .. string.gsub(filename, "_", "-")
        if race == "human" then humanident = fullname end
        if race == "orc" then orcident = fullname end
        local files = {
            forest = ("tilesets/forest/" .. race ..
            "/buildings/" .. filename .. "_construction.png"),
            swamp = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. "_construction.png"),
            forest_campaign = ("tilesets/forest/" .. race ..
            "/buildings/" .. filename .. "_construction.png"),
            swamp_campaign = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. "_construction.png"),
            dungeon = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. "_construction.png"),
            dungeon_campaign = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. "_construction.png")
        }

        if not building.NotConstructable then
            DefineConstruction(
            "construction-" .. fullname,
            {
                Files =
                {
                    File = files[war1gus.tileset],
                    Size = size
                },
                Constructions =
                {
                    {
                        Percent = 0,
                        File = "construction",
                        Frame = 0
                    },
                    {
                        Percent = 33,
                        File = "construction",
                        Frame = 1
                    },
                    {
                        Percent = 67,
                        File = "construction",
                        Frame = 2
                    }
                }
            } )
        end

        UnitTypeFiles["unit-" .. fullname] = {
            forest = ("tilesets/forest/" .. race ..
            "/buildings/" .. filename .. ".png"),
            swamp = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. ".png"),
            forest_campaign = ("tilesets/forest/" .. race ..
            "/buildings/" .. filename .. ".png"),
            swamp_campaign = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. ".png"),
            dungeon = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. ".png"),
            dungeon_campaign = ("tilesets/swamp/" .. race ..
            "/buildings/" .. filename .. ".png")
        }

        local unitType = {
            Name = name,
            Image = { "size", size },
            Animations = "animations-building",
            Icon = "icon-" .. fullname,
            Costs = building.Costs,
            RepairHp = 4,
            RepairCosts = { "gold", 1, "wood", 1 },
            Construction = "construction-" .. fullname,
            HitPoints = building.HitPoints,
            DrawLevel = 20,
            TileSize = { size[1] / 32 - 1, size[2] / 32 - 1 },
            BoxSize = { size[1] -33, size[2] -33 },
            SightRange = 1,
            Armor = 20,
            BasicDamage = 0,
            PiercingDamage = 0,
            Missile = "missile-none",
            RightMouseAction = "none",
            Speed = 0,
            Type = "land",
            CanAttack = false,
            Coward = false,
            Priority = 20,
            AnnoyComputerFactor = 45,
            Points = 100,
            Supply = 0,
            CanStore = { },
            Corpse = "unit-destroyed-3x3-place",
            ExplodeWhenKilled = "missile-building-collapse",
            Type = "land",
            Building = true,
            BuilderOutside = false,
            RepairRange = 0,
            VisibleUnderFog = true,
            BuildingRules =
            {
                -- all buildings except the town hall
                {
                    "distance",{ Distance = 1, DistanceType = "=", Type = "unit-road" },
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
            Sounds =
            {
                "ready",race .. " work complete",
                "selected",fullname .. "-selected",
                "help",race .. " help 4",
                "dead","building destroyed"
            }
        }

        for k, v in pairs(building) do
            if unitType[k] then
                if type(v) == "table" and v[race] then
                    unitType[k] = v[race]
                else
                    unitType[k] = v
                end
            end
        end

        DefineUnitType("unit-" .. fullname, unitType)
        table.insert(wc1_buildings[race], "unit-" .. fullname)

        if building.Dependency then
            DefineDependency(
            "unit-" .. fullname,
            { "unit-" .. race .. "-" .. building.Dependency[race] }
            )
        end
    end

    if humanident and orcident then
        UnitEquivalents["unit-" .. orcident] = "unit-" .. humanident
        UnitEquivalents["unit-" .. humanident] = "unit-" .. orcident
    end
end

function DefineUnitFromSpec(unit)
    local humanident
    local orcident

    for race, name in pairs(unit.Names) do
        local filename = string.lower(string.gsub(name, " ", "_"))
        local unitname = string.gsub(filename, "_", "-")

        if unit.Names.orc and unit.Names.orc == unit.Names.human then
            unitname = race .. "-" .. filename
        end

        if race == "human" then humanident = unitname end
        if race == "orc" then orcident = unitname end

        local size = { 64, 64 }
        if unit.Size and unit.Size[race] then
            size = unit.Size[race]
        end

        local unitType = {
            Name = name,
            Animations = "animations-" .. unitname,
            Icon = "icon-" .. unitname,
            Image =
            {
                "file",race .. "/units/" .. filename .. ".png",
                "size",size
            },
            Costs = { },
            HitPoints = unit.HitPoints,
            DrawLevel = 60,
            MaxAttackRange = 1,
            TileSize = { 1, 1 },
            BoxSize = { 31, 31 },
            SightRange = 3,
            Speed = 9,
            organic = true,
            ComputerReactionRange = 4,
            PersonReactionRange = 6,
            Armor = 3,
            BasicDamage = 0,
            PiercingDamage = 0,
            Missile = "missile-none",
            DecayRate = 0,
            NoFriendlyFire = true,
            Priority = 63,
            Points = 100,
            Demand = 1,
            Type = "land",
            RightMouseAction = "attack",
            CanAttack = true,
            Coward = false,
            CanTargetLand = true,
            Vanishes = false,
            NonSolid = false,
            IsNotSelectable = false,
            RepairRange = 0,
            Sounds =
            {
                "attack",race .. " acknowledge",
                "selected",race .. " selected",
                "acknowledge",race .. " acknowledge",
                "ready",race .. " ready",
                "help",race .. " help 3",
                "dead",race .. " dead"
            },
            SelectableByRectangle = true
        }

        if unit.organic == nil or unit.organic == true then
            if race == "orc" then
                unitType.Corpse = "unit-orc-dead-body"
            else
                unitType.Corpse = "unit-human-dead-body"
            end
        end

        if unit.Mana ~= nil then
           unitType.Mana = unit.Mana
        end

        for k, v in pairs(unit) do
            if unitType[k] then
                if type(v) == "table" and v[race] then
                    unitType[k] = v[race]
                else
                    unitType[k] = v
                end
            end
        end

        if unit.CanGatherResources then
            unitType.CanGatherResources = unit.CanGatherResources
            for idx, tbl in ipairs(unit.CanGatherResources) do
                local resource = ""
                for idx, v in ipairs(tbl) do
                    if v == "resource-id" then
                        resource = tbl[idx + 1]
                        break
                    end
                end
                tbl[table.getn(tbl) + 1] = "file-when-loaded"
                tbl[table.getn(tbl) + 1] = race .. "/units/" .. unitname ..
                "_with_" .. resource .. ".png"
            end
        end

        if unit.CanCastSpell then
            unitType.CanCastSpell = unit.CanCastSpell[race]
        end

        DefineUnitType("unit-" .. unitname, unitType)
        table.insert(wc1_units[race], "unit-" .. unitname)

        if unit.Dependencies then
            -- always depends on buildings
            local deps = { }
            for idx, dep in ipairs(unit.Dependencies[race]) do
                deps[idx] = "unit-" .. race .. "-" .. dep
            end
            DefineDependency("unit-" .. unitname, deps)
        end
    end

    if humanident and orcident then
        UnitEquivalents["unit-" .. orcident] = "unit-" .. humanident
        UnitEquivalents["unit-" .. humanident] = "unit-" .. orcident
    end
end

-- spec definition
function DefineUpgradeFromSpec(spec)
    for _, race in ipairs( { "orc", "human" }) do
        local name = spec[race][1]
        local iconname = spec[race][3] or name
        local units = spec[race][2]

        u = CUpgrade:New("upgrade-" .. name)
        u.Icon = Icons["icon-" .. iconname]

        for j, amount in ipairs(spec.cost) do
            u.Costs[j - 1] = amount
        end

        local applicants = { }
        for idx, unit in ipairs(units) do
            applicants[idx] = { "apply-to", "unit-" .. unit }
        end

        if spec.modifier then
            local modifier = { spec.modifier[1], spec.modifier[2] }
            if type(modifier[2]) == "table" then
                modifier[2] = modifier[2][race]
            end
            DefineModifier("upgrade-" .. name, modifier, unpack(applicants))
        else
            DefineModifier("upgrade-" .. name, unpack(applicants))
        end

        table.insert(wc1_upgrades[race], "upgrade-" .. name)

        if spec.dependency then
            DefineDependency(
            "upgrade-" .. name,
            { "upgrade-" .. spec.dependency[race] }
            )
        end
    end
end

function CreateAllowanceFunction(race)
    local all = { }
    for _, unit in ipairs(wc1_units[race]) do
        table.insert(all, unit)
    end
    for _, building in ipairs(wc1_buildings[race]) do
        table.insert(all, building)
    end
    for _, upgrade in ipairs(wc1_upgrades[race]) do
        table.insert(all, upgrade)
    end

    return function(flags)
        for _, unitName in ipairs(all) do
            DefineAllow(unitName, flags)
        end
    end
end

function CreateRoads(positions)
    local occupied_positions = { }

    for _, pos in ipairs(positions) do
        if not occupied_positions[pos.x] then
            occupied_positions[pos.x] = { }
        end
        if not occupied_positions[pos.x][pos.y] then
            occupied_positions[pos.x][pos.y] = true
            CreateUnit("unit-road", pos.player, { pos.x, pos.y })
        end
    end
end

function CreateWalls(positions)
    local occupied_positions = { }

    for _, pos in ipairs(positions) do
        if not occupied_positions[pos.x] then
            occupied_positions[pos.x] = { }
        end
        if not occupied_positions[pos.x][pos.y] then
            occupied_positions[pos.x][pos.y] = true
            CreateUnit("unit-wall", pos.player, { pos.x, pos.y })
        end
    end
end
