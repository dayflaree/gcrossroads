
sql.Query([[CREATE TABLE IF NOT EXISTS `gCrossroads_player` (
    identifier int NOT NULL AUTO_INCREMENT,
    steamid varchar(191) NOT NULL PRIMARY KEY,
    lastlogin BIGINT DEFAULT NULL,
    playtime BIGINT DEFAULT 0,
    currency BIGINT DEFAULT 0,
    kills BIGINT DEFAULT 0,
    deaths BIGINT DEFAULT 0,
);]])

sql.Query([[CREATE TABLE IF NOT EXISTS `gCrossroads_unlocks` (
    steamid varchar(191) NOT NULL PRIMARY KEY,
    gear varchar(191) NOT NULL PRIMARY KEY,
    time BIGINT DEFAULT NULL,
);]])

concommand.Add("db_countplayers", function(ply)
    if not ply == Entity(0) then return end

    local res = sql.Query("SELECT * FROM `gCrossroads_player`")
    print("Amount of people in database: " .. table.Count(res))
end)

hook.Add("PlayerInitialSpawn", "gCrossroads:InsertPlayerDatabase", function(ply)
    print(ply:SteamID())
    local res = sql.Query(string.format("SELECT * FROM `gCrossroads_player` WHERE steamid = %s;"), sql.SQLStr(ply:SteamID()))
    if IsValid(res) and istable(res) and not table.IsEmpty(res) then
        print("Player data found for " .. ply:Nick())
        sql.Query(string.format("UPDATE `gCrossroads_player` SET lastlogin = %s WHERE steamid = %s;", sql.SQLStr(os.time()), sql.SQLStr(ply:SteamID())))
    else
        print("No player data found for " .. ply:Nick() .. ", creating...")
        sql.Query(string.format("INSERT INTO `gCrossroads_player` (steamid, lastlogin) VALUES (%s, %s);", sql.SQLStr(ply:SteamID()), sql.SQLStr(os.time())))
    end
end)