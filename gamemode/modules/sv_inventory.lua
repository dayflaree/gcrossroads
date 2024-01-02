GM.ShopConfig = GM.ShopConfig or {}
local cfg = GM.ShopConfig
local plymeta = FindMetaTable("Player")

util.AddNetworkString("gCrossroads:SendGearToServer")
net.Receive("gCrossroads:SendGearToServer", function(_, ply)
    local gearlist = util.JSONToTable(net.ReadString())
    local unlocks = ply:GetUnlocks()
    for v, enabled in pairs(gearlist) do
        for _, k in ipairs(cfg.StoreItems) do
            if v != k.GearName or k.Cost == 0 or enabled == false then
                continue
            end

            if not unlocks[v] then
                gearlist[v] = nil
                break 
            end
        end
    end

    ply.EquippedGear = gearlist
end)

function plymeta:SyncUnlockedGear()
    local unlocks = self:GetUnlocks()
end