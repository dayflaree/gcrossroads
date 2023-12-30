local cfg = GAMEMODE.ShopConfig
local PANEL = {}

local red = Color(255, 0, 0)

function PANEL:Init()

    self.top = vgui.Create("Panel", self)
    self.top:Dock(TOP)
    self.top:SetHeight(40)
    self.top.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Background, true, true, false, false)
    end

    self.title = vgui.Create("DLabel", self.top)
    self.title:Dock(LEFT)
    self.title:DockMargin(10, 0, 0, 0)
    self.title:SetTextColor(cfg.Colors.Text)
    self.title:SetText("Gear Shop")
    self.title:SizeToContents()

    self.closebtn = vgui.Create("DButton", self.top)
    self.closebtn:Dock(RIGHT)
    self.closebtn:SetText("X")
    self.closebtn:SetTextColor(cfg.Colors.Text)
    self.closebtn.CloseButton = red
    self.closebtn.Alpha = 0
    self.closebtn.DoClick = function()
        self:Remove()
    end
    self.closebtn.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, ColorAlpha(frame.CloseButton, frame.Alpha), false, true, false, false)
    end

    self.inspect_panel = vgui.Create("Panel", self)
    self.inspect_panel:Dock(RIGHT)
    self.inspect_panel:SetWidth(270)
    self.inspect_panel.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Background, true, true, true, true)
    end

    self.shop = vgui.Create("DScrollPanel", self)
    self.shop:Dock(FILL)
    self.shop.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Background, true, true, true, true)
    end

    self:SetupItems()
end

function PANEL:Paint(w, h)
    draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Background, true, true, true, true)
end

function PANEL:FocusGear(gear)
    -- Make self.inspect_panel focus on the gear
end

function PANEL:SetupItems()
    for _, v in ipairs(cfg.StoreItems) do

        -- If gear panel is clicked use self:FocusGear
        local gear = self.shop:Add("Panel")
        gear:Dock(TOP)
        gear:SetHeight(64)
        gear.gear = cfg.GearName
        gear.Paint = function(frame, w, h)
            draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Item, true, true, true, true)
        end

        local icon = vgui.Create("DImage", gear)
        icon:Dock(LEFT)
        icon:SetWidth(64)
        icon:SetImage(v.Icon)

        local gearname = vgui.Create("DLabel", gear)
        gearname:Dock(FILL)
        gearname:SetText(v.Name)
        gearname:SetContentAlignment(4)
        gearname:SizeToContents()
    end
end

function PANEL:PerformLayout()
end

vgui.Register("gCrossroads.Shop", PANEL)

function OpenShop()
    local shop = vgui.Create("gCrossroads.Shop")
    shop:SetSize(700, 900)
    shop:Center()
    shop:MakePopup()
end