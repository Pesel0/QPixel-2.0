QPX.Users = QPX.Users or {}
QPX.Player = QPX.Player or {}

function QPX.Player.GetUser(self, id)
    return QPX.Users[id] and QPX.Users[id] or false
end

function QPX.Player.GetUsers(self)
    local tmp = {}

    for k, v in pairs(QPX.Users) do
        tmp[#tmp+1]= k
    end

    return tmp
end

local function GetUser(user)
    return QPX.Users[user.source]
end

local function AddMethod(player)
    function player.getVar(self, var)
        return GetUser(self)[var]
    end

    function player.setVar(self, var, data)
        GetUser(self)[var] = data
    end
    
    function player.networkVar(self, var, data)
        self:setVar(var, data)
        TriggerClientEvent("qpixel-base:networkVar", GetUser(self):getVar("source"), var, data)
    end

    function player.getRank(self)
        return GetUser(self).rank
    end

    function player.setRank(self, rank)
        GetUser(self).rank = rank
        self:networkVar("rank", rank)
    end

    function player.setCharacters(self, data)
        GetUser(self).characters = data
    end

    function player.setCharacter(self, data)
        GetUser(self).character = data
    end

    function player.getCash(self)
        return GetUser(self).character.cash
    end

    function player.getBalance(self)
        return GetUser(self).character.bank
    end

    function player.getDirtyMoney(self)
        return GetUser(self).character.dirty_money
    end

    function player.getGangType(self)
        return GetUser(self).character.gang_type
    end

    function player.getStressLevel(self)
        return GetUser(self).character.stress_level
    end

    function player.getJudgeType(self)
        return GetUser(self).character.judge_type
    end

    function player.alterDirtyMoney(self, amt)
        local characterId = GetUser(self.character.id)

        GetUser(self).character.dirty_money = amt

        QPX.DB:UpdateCharacterDirtyMoney(GetUser(self), characterId, amt, function(updatedMoney, err)
            if updatedMoney then
                --We are good here.
            end
        end)
    end

    function player.alterStressLevel(self, amt)
        local characterid = GetUser(self).character.id

        GetUser(self).character.stress_level = amt

        QPX.DB:UpdateCharacterStressLevel(GetUser(self), characterId, amt, function(updatedMoney, err)
            if updatedMoney then
                --We are good here.
            end
        end)
    end

    function player.resetDirtyMoney(self)
        local characterid = GetUser(self).character.id

        GetUser(self).character.dirty_money = 0

        QPX.DB:UpdateCharacterDirtyMoney(GetUser(self), characterId, 0, function(updatedMoney, err)
            if updatedMoney then
                --We are good here.
            end
        end)
    end

    function player.addMoney(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local cash = GetUser(self):getCash() + amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source
        if (amt >= 10000) then
            print("[POSSIBLE EXPLOITER] "..GetPlayerName(src).." has attempted to add $"..amt.." to their account. This is a suspicious activity. Please investigate.")
        end
        amt = math.floor(amt)

        GetUser(self).character.cash = cash

        QPX.DB:UpdateCharacterMoney(GetUser(self), characterId, cash, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:addCash", GetUser(self).source, amt)
                TriggerClientEvent("banking:updateCash", GetUser(self).source, GetUser(self):getCash(), amt)
            end
        end)
    end

    function player.removeMoney(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local cash = GetUser(self):getCash() - amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.cash = GetUser(self).character.cash - amt


            QPX.DB:UpdateCharacterMoney(GetUser(self), characterId, cash, function(updatedMoney, err) 
                if updatedMoney then
                    TriggerClientEvent("banking:removeCash", GetUser(self).source, amt)
                    TriggerClientEvent("banking:updateCash", GetUser(self).source, GetUser(self):getCash(), amt * -1)
                end
            end)
    end

    
    function player.removeBank(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local bank = GetUser(self):getBalance() - amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.bank = GetUser(self).character.bank - amt

        QPX.DB:UpdateCharacterBank(GetUser(self), characterId, bank, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:removeBalance", GetUser(self).source, amt * -1)
                TriggerClientEvent("banking:updateBalance", GetUser(self).source, GetUser(self):getBalance(), amt * -1)
            end
        end)
    end

    function player.addBank(self, amt)
        if not amt or type(amt) ~= "number" then return end
        local bank = GetUser(self):getBalance() + amt
        local characterId = GetUser(self).character.id
        local src = GetUser(self).source

        amt = math.floor(amt)

        GetUser(self).character.bank = bank

        QPX.DB:UpdateCharacterBank(GetUser(self), characterId, bank, function(updatedMoney, err) 
            if updatedMoney then
                TriggerClientEvent("banking:addBalance", GetUser(self).source, amt)
                TriggerClientEvent("banking:updateBalance", GetUser(self).source, GetUser(self):getBalance(), amt)
            end
        end)
    end

    function player.getNumCharacters(self)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters then return 0 end
        return #GetUser(self).characters
    end

    function player.ownsCharacter(self, id)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters or GetUser(self):getNumCharacters() <= 0 then return false end

        for k,v in ipairs(GetUser(self).characters) do 
            if v.id == id then return true end 
        end

        return false
    end

    function player.getGender(self)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters or not GetUser(self).characterLoaded then return false end

        return GetUser(self).character.gender
    end
        
    function player.getCharacters(self)
        return GetUser(self).characters
    end

    function player.getCharacter(self, id)
        if not GetUser(self).charactersLoaded or not GetUser(self).characters or GetUser(self):getNumCharacters() <= 0 then return false end
        if not GetUser(self):ownsCharacter(id) then return false end

        for k,v in ipairs(GetUser(self).characters) do 
            if v.id == id then return v end
        end

        return false
    end

    function player.getCurrentCharacter(self)
        if not GetUser(self).charactersLoaded or not GetUser(self).characterLoaded or GetUser(self):getNumCharacters() <= 0 then return false end
        return GetUser(self).character
    end

    return player
end

    local function CreatePlayer(src)
        local self = {}

        self.source = src
        self.name = GetPlayerName(src)
        self.hexid = QPX.Util:GetHexId(src)
        
        -- if not self.hexid then
        --     DropPlayer(src, "Error fetching steamid")
        --     return
        -- end

        self.comid = QPX.Util:HexIdToComId(self.hexid)
        self.steamid = QPX.Util:HexIdToSteamId(self.hexid)
        self.license = QPX.Util:GetLicense(src)
        self.ip = GetPlayerEP(src)
        self.rank = "user"

        self.characters = {}
        self.character = {}

        self.charactersLoaded = false
        self.characterLoaded = false

        local methods = AddMethod(self)

        QPX.Users[src] = methods

        return methods
    end


function QPX.Player.CreatePlayer(self, src, recrate)
    if recreate then QPX.Users[src] = nil end
    
    if QPX.Users[src] then return QPX.Users[src] end

    return CreatePlayer(src)
end
local pos = {}
RegisterServerEvent('qpixel-base:updatecoords')
AddEventHandler('qpixel-base:updateCoords', function(x,y,z)
    local src = source
    pos[src] = {x,y,z}
end)

RegisterServerEvent("retreive:jail")
AddEventHandler("retreive:jail", function(cid)
    local src = source
    exports.ghmattimysql:execute("SELECT `jail_time` FROM `characters` WHERE id = ?", {cid}, function(result)
        if result[1].jail_time >= 1 then
            TriggerClientEvent('returnOldRouting', src)
            TriggerClientEvent("beginJail2", src, result[1].jail_time, true)
        end
    end)
end)


AddEventHandler("playerDropped", function(reason)
    local src = source
    if reason == nil then reason = "Unknown" end
    local user = QPX.Player:GetUser(src)
    local posE = json.encode(pos[src])
    pos[src] = nil

    QPX.Users[src] = nil

    TriggerEvent('qpixel-base:playerDropped', src, user)
end)

AddEventHandler('playerConnecting', function()
    local pDiscord = 'None'
    local pSteam = 'None'
    local pName = GetPlayerName(source)
    local identifiers = GetPlayerIdentifiers(source)
    
    for k, v in pairs(identifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Steam Name: ** "..pName.."** is connecting **",
          ["description"] = string.format("`User is joining!`\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", identifiers[1], pDiscord),
        }
      }
    PerformHttpRequest("https://discord.com/api/webhooks/1012082873366478899/TCBibQ8muuWsWwXo5lXqFa8_b7Y4f9GmjAQktfTKfuv6iIH3TyzLPrs8suJLuR8bQpqv", function(err, text, headers) end, 'POST', json.encode({username = "qpixel", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    if reason == nil then reason = "Unknown" end
    local user = QPX.Player:GetUser(src)
    local posE = json.encode(pos[src])
    pos[src] = nil
    local pName = GetPlayerName(source)

    local pDiscord = 'None'
    local pSteam = 'None'
    local identifiers = GetPlayerIdentifiers(source)

    for k, v in pairs(identifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end

    QPX.Users[src] = nil

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** Steam Name: ** "..pName.." ** disconnected from the server **",
          ["title"] = string.format("`User left ` Name: "..pName.."\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`\n\n`• Reason: %s`\n━━━━━━━━━━━━━━━━━━", identifiers[1], pDiscord, reason)
        }
      }
    PerformHttpRequest("https://discord.com/api/webhooks/1012082965360164924/1MT9Rjjua9Qw4hbRWrD1d5nvgQJrcj5KIyjVTHgcjVCF2LXSwWaqK9qKQ9q88xGv8A8k", function(err, text, headers) end, 'POST', json.encode({username = "qpixel", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('qpixel-base:logDeath')
AddEventHandler('qpixel-base:logDeath', function(killer, reason)
    local src = source
    local pName = GetPlayerName(src)
    local pName2 = GetPlayerName(killer)
    local identifiers = GetPlayerIdentifiers(src)

    local pDiscord = 'None'
    local pSteam = 'None'

    for k, v in pairs(identifiers) do
        if string.find(v, 'steam') then pSteam = v end
        if string.find(v, 'discord') then pDiscord = v end
    end

    local connect = {
        {
          ["color"] = color,
          ["title"] = "** [qpixel-base] | Death Log **",
          ["title"] = string.format("`Player Died ` Steam Name: "..pName.."\n\n━━━━━━━━━━━━━━━━━━\n\n`• Steam: %s`\n\n`• Discord: %s`\n\n`• Information: %s`\n━━━━━━━━━━━━━━━━━━\n\n`• Killer: %s`\n━━━━━━━━━━━━━━━━━━", identifiers[1], pDiscord, reason, pName2)
        }
      }
    PerformHttpRequest("https://discord.com/api/webhooks/1012083032762630226/qWHlaYrj4jHv9e12H4pjFJ82R2i4sI5nV-DYOzDoI8veOf9krMTl1UFS3zfEJetF8los", function(err, text, headers) end, 'POST', json.encode({username = "qpixel", embeds = connect, avatar_url = "https://i.imgur.com/hMqEEQp.png"}), { ['Content-Type'] = 'application/json' })
end)