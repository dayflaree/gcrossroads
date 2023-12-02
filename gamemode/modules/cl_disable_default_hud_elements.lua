local hide = {
	["CHudAmmo"] = true,
	["CHudBattery"] = true,
	["CHudCrosshair"] = true,
	["CHudDamageIndicator"] = true,
	["CHudDeathNotice"] = true,
	["CHudGeiger"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudSquadStatus"] = true,
	["CHudTrain"] = true,
	["CHudVehicle"] = true,
	["CHudWeapon"] = true,
	["CHudWeaponSelection"] = true,
	["CHudZoom"] = true,
	["CHUDQuickInfo"] = true,
	["CHudSuitPower"] = true,
	["CHudHealth"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end

	-- Don't return anything here, it may break other addons that rely on this hook.
end )

hook.Add("DrawDeathNotice", "nodn", function()
	return 0,0
end)

hook.Add("Initialize", "nodn", function()
	GM = GM or GAMEMODE
	function GM:AddDeathNotice()
		return
	end
end)