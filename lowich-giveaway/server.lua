-- Lowich#8914

ESX = nil 
Citizen.CreateThread(function() 
while ESX == nil do 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
Citizen.Wait(0) 
end 
end)
codeusetime = nil


RegisterNetEvent("kodudogrula")
AddEventHandler("kodudogrula", function(code)
    if code == Config.kod then
        xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll('SELECT * FROM lw_giveaway WHERE kullanici = @kullanici',{
            ['@kullanici'] = xPlayer.getIdentifier()
        },
        function (result)
            if result[1] == nil then
            else
            codeusetime = (result[1].kullanim)
            end

            if result[1] == nil then 
                MySQL.Async.execute('INSERT INTO lw_giveaway (kullanici, kullanim) VALUES (@kullanici, @kullanim)',{ 
                    ['kullanici'] = xPlayer.getIdentifier(),
                    ['kullanim'] = 1
                })
                if Config.paradurum then
				if Config.EnableDiscordLog then
                xPlayer.addMoney(Config.para , Config.paradurum)
		        dclog(xPlayer, '**'..Config.kod..'** Kodunu Kullanarak. **'..Config.para..'$** Para Aldı!')
	end
	end
            if Config.itemdurum then
			if Config.EnableDiscordLog then
                xPlayer.addInventoryItem(Config.item, Config.miktar , Config.itemdurum)
		        dclog(xPlayer, '**'..Config.kod..'** Kodunu Kullanarak. **'..Config.item..'** Aldı!')
	end
    end
            TriggerClientEvent('basarili', -1)
            elseif codeusetime < Config.kullanim then
                MySQL.Async.execute('UPDATE lw_giveaway SET kullanim = @kullanim WHERE kullanici = @kullanici',{ 
                    ['@kullanim'] = codeusetime + 1,
                    ['@kullanici'] = xPlayer.getIdentifier()
                })
                if Config.paradurum then
				if Config.EnableDiscordLog then
                xPlayer.addMoney(Config.para ,Config.paradurum)
		        dclog(xPlayer, '**'..Config.kod..'** Kodunu Kullanarak. **'..Config.para..'$** Para Aldı!')
   end
   end
                if Config.itemdurum then
				if Config.EnableDiscordLog then
                xPlayer.addInventoryItem(Config.item, Config.miktar , Config.itemdurum)
		        dclog(xPlayer, '**'..Config.kod..'** Kodunu Kullanarak. **'..Config.item..'** Aldı!')
	end
    end
                TriggerClientEvent('basarili', -1 )
            elseif codeusetime == Config.kullanim then
                TriggerClientEvent('bilgi', -1)
            end
        end)
    else
        TriggerClientEvent('gecerlikod', -1)
    end
end)

function dclog(xPlayer, text)
	local playerName = Sanitize(xPlayer.getName())
	
	local discord_webhook = GetConvar('discord_webhook', Config.DiscordWebhook)
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
	  ["username"] = Config.WebhookName,
	  ["avatar_url"] = Config.WebhookAvatarUrl,
	  ["embeds"] = {{
		["author"] = {
		  ["name"] = playerName .. ' - ' .. xPlayer.identifier
		},
		["color"] = 1942002,
		["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
	  }}
	}
	data['embeds'][1]['description'] = text
	PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end