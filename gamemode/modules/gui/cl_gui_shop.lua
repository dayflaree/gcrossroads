GM.ShopConfig = GM.ShopConfig or {}
local cfg = GM.ShopConfig
local PANEL = {}

local red = Color(255, 0, 0)

surface.CreateFont("gCrossroads.Shop.Title", {
	font = "Trebuchet MS",
	size = 28,
	weight = 400,
	antialias = true,
    extended = true
})

surface.CreateFont("gCrossroads.Shop.Item", {
	font = "Trebuchet MS",
	size = 24,
	weight = 400,
	antialias = true,
    extended = true
})

surface.CreateFont("gCrossroads.Shop.Button", {
	font = "Trebuchet MS",
	size = 36,
	weight = 400,
	antialias = true,
    extended = true
})

function PANEL:Init()

    self.top = vgui.Create("Panel", self)
    self.top:Dock(TOP)
    self.top:SetTall(40)
    self.top.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Background, true, true, false, false)
    end

    self.title = vgui.Create("DLabel", self.top)
    self.title:Dock(LEFT)
    self.title:DockMargin(10, 0, 0, 0)
    self.title:SetTextColor(cfg.Colors.Text)
    self.title:SetText("Gear Shop")
    self.title:SetFont("gCrossroads.Shop.Title")
    self.title:SizeToContents()

    self.closebtn = vgui.Create("DButton", self.top)
    self.closebtn:Dock(RIGHT)
    self.closebtn:SetWidth(self.top:GetTall())
    self.closebtn:SetText("X")
    self.closebtn:SetFont("gCrossroads.Shop.Title")
    self.closebtn:SetTextColor(cfg.Colors.Text)
    self.closebtn.CloseButton = red
    self.closebtn.Alpha = 0
    self.closebtn.DoClick = function()
        self:Remove()
    end
    self.closebtn.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, ColorAlpha(frame.CloseButton, frame.Alpha), false, true, false, false)
    end

    self.closebtn.OnCursorEntered = function(frame)
        frame.Alpha = Lerp(2, frame.Alpha, 100)
    end

    self.closebtn.OnCursorExited = function(frame)
        frame.Alpha = Lerp(2, frame.Alpha, 0)
    end

    self.inspect_panel = vgui.Create("Panel", self)
    self.inspect_panel:Dock(RIGHT)
    self.inspect_panel:SetWidth(270)
    self.inspect_panel.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Background, true, true, true, true)
    end

    self.inspect_name = vgui.Create("DLabel", self.inspect_panel)
    self.inspect_name:Dock(TOP)
    self.inspect_name:SetTall(100)
    self.inspect_name:SetText("None")
    self.inspect_name:SetFont("gCrossroads.Shop.Item")
    self.inspect_name:SetTextColor(cfg.Colors.Text)
    self.inspect_name:SetContentAlignment(5)

    self.inspect_icon = vgui.Create("DImage", self.inspect_panel)
    self.inspect_icon:Dock(TOP)
    self.inspect_icon:DockMargin(71, 0, 71, 0)
    self.inspect_icon:SetTall(128)

    self.inspect_button = vgui.Create("DButton", self.inspect_panel)
    self.inspect_button:Dock(BOTTOM)
    self.inspect_button:DockMargin(20, 0, 20, 20)
    self.inspect_button:SetTall(70)
    self.inspect_button:SetText("AMONGUS")
    self.inspect_button:SetTextColor(cfg.Colors.Text)
    self.inspect_button:SetFont("gCrossroads.Shop.Button")
    self.inspect_button.Color = cfg.Colors.Locked
    self.inspect_button.Paint = function(frame, w, h)
        draw.RoundedBoxEx(8, 0, 0, w, h, frame.Color, true, true, true, true)
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
    self.focusedgear = self.focusedgear or false
    if gear == self.focusedgear then
        return
    end
    local geartbl = cfg.StoreItems[gear]
    local unlocked_gear = GetUnlockedGear()
    local equipped_gear = GetEquippedGear()

    self.inspect_name:SetText(geartbl.Name)
    self.inspect_icon:SetImage(geartbl.Icon)

    -- Button logic
    if equipped_gear[geartbl.GearName] == true then
        self.inspect_button:SetText("Unequip")
        self.inspect_button.Color = cfg.Colors.Unequip
        self.inspect_button.DoClick = function()
            UnEquipGear(gear)
            timer.Simple(0, function()
                if not IsValid(self) then return end
                self:FocusGear(gear)
            end)
        end
    elseif geartbl.Cost == 0 or unlocked_gear[geartbl.GearName] == true then
        self.inspect_button.Color = cfg.Colors.Equip
        self.inspect_button:SetText("Equip")

        self.inspect_button.DoClick = function()
            EquipGear(gear)
            timer.Simple(0, function()
                if not IsValid(self) then return end
                self:FocusGear(gear)
            end)
        end
    elseif geartbl.Cost != 0 and unlocked_gear[geartbl.GearName] != true and geartbl.Unlockable == true then
        self.inspect_button.Color = cfg.Colors.Purchase
        self.inspect_button:SetText(tostring(geartbl.Cost .. " BOBUX"))
        self.inspect_button.DoClick = function()
            -- Buy the gear
        end
    else
        self.inspect_button.Color = cfg.Colors.Locked
        self.inspect_button:SetText("Locked")
    end
    self.inspect_button:SetTextColor(cfg.Colors.Text)
    self.inspect_button:SetFont("gCrossroads.Shop.Button")

end

function PANEL:SetupItems()
    local item_focused = false
    local unlocked_gear = GetUnlockedGear()
    local equipped_gear = GetEquippedGear()
    for i, v in ipairs(cfg.StoreItems) do

        -- If gear panel is clicked use self:FocusGear
        local gear = self.shop:Add("Panel")
        gear:Dock(TOP)
        gear:DockMargin(1, 2, 1, 0)
        gear:SetHeight(64)
        gear:SetCursor("hand")
        gear.gear = cfg.GearName
        gear.Paint = function(frame, w, h)
            draw.RoundedBoxEx(8, 0, 0, w, h, cfg.Colors.Item, true, true, true, true)
        end
        gear.OnMouseReleased = function()
            if IsValid(self) then
                self:FocusGear(i)
            end
        end

        local icon = vgui.Create("DImage", gear)
        icon:Dock(LEFT)
        icon:SetWidth(64)
        icon:SetImage(v.Icon)

        local gearname = vgui.Create("DLabel", gear)
        gearname:Dock(FILL)
        gearname:SetText(v.Name)
        gearname:SetFont("gCrossroads.Shop.Item")
        gearname:SetContentAlignment(4)
        --gearname:SizeToContents()

        

        if item_focused == false then
            item_focused = true 
            self:FocusGear(i)
        end
    end
end

function PANEL:PerformLayout()
end

vgui.Register("gCrossroads.Shop", PANEL)

local vgui_shop = false 
function OpenShop()
    if IsValid(vgui_shop) then
        vgui_shop:Remove()
        return 
    end
    local shop = vgui.Create("gCrossroads.Shop")
    shop:SetSize(700, 900)
    shop:Center()
    shop:MakePopup()
    vgui_shop = shop
end