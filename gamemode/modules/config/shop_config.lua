GM.ShopConfig = {}
local cfg = GM.ShopConfig

cfg.Colors = {
    ["Text"] = Color(255, 255, 255),
    ["Background"] = Color(25, 25, 25),
    ["Accent"] = Color(52, 52, 255),
    ["Item"] = Color(52, 52, 255, 70),
    ["Equip"] = Color(0, 210, 0),
    ["Unequip"] = Color(210, 0, 0),
    ["Purchase"] = Color(255, 232, 21),
    ["Locked"] = Color(150, 150, 150)
}

cfg.StoreItems = {
    /*
    {
        ["Name"] = "Display Name",
        ["GearName"] = "", -- Internal name of the gear
        ["Icon"] = "path/to/icon.png",
        ["Unlockable"] = true,
        ["Cost"] = 1, -- Cost in currency, 0 for unlocked by default
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
        ["Icon"] = "gmblox/vgui/Sword128.png",
        ["Unlockable"] = true,
        ["Cost"] = 0,
    },
    {
        ["Name"] = "Bloxy Cola",
        ["GearName"] = "bloxycola",
        ["Icon"] = "gmblox/vgui/bloxy.png",
        ["Unlockable"] = true,
        ["Cost"] = 0,
    },
}