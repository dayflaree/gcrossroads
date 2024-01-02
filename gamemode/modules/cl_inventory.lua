GM.ShopConfig = GM.ShopConfig or {}
local cfg = GM.ShopConfig
local equipped_gear = {}
local unlocked_gear = {}
local cooldown = 0

net.Receive("gCrossroads:SyncUnlockedGear", function()
    local gear_list = util.JSONToTable(net.ReadString())
    unlocked_gear = gear_list
end)

function GetEquippedGear()
    return equipped_gear
end

function GetEquippedGearForChar()
    local tbl = {}
    for i, v in pairs(equipped_gear) do
        if v == false then
            continue
        end
        table.insert(tbl, i)
    end
    return tbl
end

function GetUnlockedGear()
    return unlocked_gear
end

function EquipGear(gear)
    if cooldown >= CurTime() then return end
    local geartbl = cfg.StoreItems[gear]

    -- Check if already equipped
    if equipped_gear[geartbl.GearName] == true then
        return 
    end

    --print("Equipping " .. geartbl.GearName)
    -- Equip it
    equipped_gear[geartbl.GearName] = true
    SyncGear()
    cooldown = CurTime() + 1
end

function UnEquipGear(gear)
    if cooldown >= CurTime() then return end
    local geartbl = cfg.StoreItems[gear]

    -- Make sure its equipped
    if equipped_gear[geartbl.GearName] != true then
        return 
    end
    
    -- Unequip it
    equipped_gear[geartbl.GearName] = false
    SyncGear()
    cooldown = CurTime() + 1
end

function SyncGear()
    net.Start("gCrossroads:SendGearToServer")
        net.WriteString(util.TableToJSON(equipped_gear))
    net.SendToServer()

    local char = LocalPlayer():GetNWEntity("gCrossroads.Char", NULL)
    if IsValid(char) then
        char.Inventory = GetEquippedGearForChar()
        char:ReBuildGearButtons()
    end
end