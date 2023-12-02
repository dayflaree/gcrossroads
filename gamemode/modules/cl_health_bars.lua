local red = Color(255, 0, 0)
local green = Color(144,167,74)
local text = color_white

local maxdist = 1000
local w, h = 300, 30

surface.CreateFont("HudPlayerName", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

hook.Add("PostDrawOpaqueRenderables", "RenderPlayerHealthBars", function()
    for _, v in ipairs(ents.FindByClass("gmbloxchar")) do
        if not IsValid(v:GetController()) then continue end
        local ply = v:GetController()
        if ply == LocalPlayer() or v:IsDormant() or LocalPlayer():GetPos():Distance(v:GetPos()) >= maxdist or (v.hplerp or 1) <= 0 then continue end

        local pos = v:GetPos()
        local ang = EyeAngles()

        ang = Angle(0, ang.y, 0)
        ang:RotateAroundAxis( ang:Up(), -90 )
        ang:RotateAroundAxis( ang:Forward(), 90 )

        pos = pos + (vector_up * 35)

        local hp = v:GetHealthRoblox()
        local hppercent = hp / 100
        v.hplerp = Lerp(FrameTime() * 8, v.hplerp or 1, hppercent) -- FrameTime() * speed

        cam.Start3D2D(pos, ang, 0.1)
            surface.SetDrawColor(red)
            surface.DrawRect(0 - (w * 0.5), 0, w, h)

            surface.SetDrawColor(green)
            surface.DrawRect(0 - (w * 0.5), 0, math.max(w * v.hplerp, 0), h)

            draw.DrawText(ply:GetName(), "HudPlayerName", 0, -45, text, TEXT_ALIGN_CENTER)

        cam.End3D2D()
    end
end)