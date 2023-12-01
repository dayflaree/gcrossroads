include("shared.lua")

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass

function GM:SpawnMenuEnabled()
	return true
end