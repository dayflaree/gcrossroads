GM.ShopConfig = {}
local cfg = GM.ShopConfig

cfg.Colors = {
    ["Text"] = Color(255, 255, 255),
    ["Background"] = Color(25, 25, 25),
    ["Accent"] = Color(52, 52, 255),
    ["Item"] = Color(52, 52, 255, 70)
}

cfg.StoreItems = {
    /*
    {
        ["Name"] = "Display Name",
        ["GearName"] = "", -- Internal name of the gear
        ["Icon"] = "path/to/icon.png",
        ["Unlockable"] = true,
        ["Cost"] = 1, -- Cost in currency
    },
    */
    {
        ["Name"] = "Rocket Launcher",
        ["GearName"] = "rocketlauncher",
        ["Icon"] = "gmblox/vgui/Rocket.png",
        ["Unlockable"] = true,
        ["Cost"] = 0,
    },
    {
        ["Name"] = "Sword",
        ["GearName"] = "sword",
        ["Icon"] = "gmblox/vgui/bloxy.png",
        ["Unlockable"] = true,
        ["Cost"] = 10,
    },
    {
        ["Name"] = "Bloxy Cola",
        ["GearName"] = "bloxycola",
        ["Icon"] = "gmblox/vgui/bloxy.png",
        ["Unlockable"] = true,
        ["Cost"] = 100,
    },
}