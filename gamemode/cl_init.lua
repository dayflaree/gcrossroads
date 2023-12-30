include("shared.lua")

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass

function GM:SpawnMenuEnabled()
	return true
end

hook.Add("SpawnMenuOpen", "gCrossroads:PreventSpawnMenu", function()
	if LocalPlayer():Team() != TEAM_ADMINS then
		return false 
	end
end)