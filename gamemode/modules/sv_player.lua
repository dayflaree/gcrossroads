function GM:PlayerSpawn( ply, transiton )

	player_manager.SetPlayerClass( ply, "player_gcrossroads" )

	--BaseClass.PlayerSpawn( self, ply, transiton )

end

hook.Add("PlayerSpawn", "SpawnGMBloxCharacter", function(ply)
    if not IsValid(ply) or ply.HasGMBlox == true or IsValid(ply.GMBloxChar) then return end

    if ply:Team() == TEAM_UNASSIGNED then
        ply:SetTeam(100)
    end

    timer.Simple(0, function() 
        if not IsValid(ply) then return end

        if IsValid(ply.GMBloxChar) then
            ply.GMBloxChar:Remove()
        end

        local spawn = hook.Run("PlayerSelectSpawn", ply, false)

        local char = ents.Create("gmbloxchar")
        char:Spawn()

        char:SetController(ply)
        char:SetPos(spawn:GetPos())
        char:SetAngles(Angle(90, 0, 0))

        ply:Spectate(OBS_MODE_CHASE)
        ply:SpectateEntity(char)
        ply:Flashlight(false)
        ply:AllowFlashlight(false)
        ply:StripWeapons()

        char.PreFlagNoTarget = ply:GetFlags(FL_NOTARGET)
        char.PreFlagAimTarget = ply:GetFlags(FL_AIMTARGET)

        ply:RemoveFlags(FL_NOTARGET)
        ply:RemoveFlags(FL_AIMTARGET)
        ply.HasGMBlox = true

        ply.GMBloxChar = char
    end)
end)

hook.Add("PlayerInitialSpawn", "Player:SelectTeam", function(ply)
    ply:SetTeam(100)
end)

hook.Add("PlayerDeath", "KillGMBloxChar", function(ply)
    if not IsValid(ply) or not IsValid(ply.GMBloxChar) then return end
    ply.GMBloxChar:SetHealthRoblox(-1)
    ply.HasGMBlox = false
    ply.GMBloxChar = NULL 
end)