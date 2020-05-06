local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPas = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","prp_policecentral")
ASclient = Tunnel.getInterface("prp_policecentral","prp_policecentral")
Tunnel.bindInterface("prp_policecentral",vRPas)
local lang = vRP.lang

local record = nil




RegisterNetEvent("pc:perm")
AddEventHandler("pc:perm", function()
	local user_id = vRP.getUserId({source})
  	if vRP.hasGroup({user_id, "Politi-Job"}) then
  		TriggerClientEvent("pc:open",source)
  	end
end)



RegisterNetEvent("prp:searchDb")
AddEventHandler("prp:searchDb", function(query) 
	local pl = source
	
	local query = "SELECT * FROM `vrp_user_identities` WHERE '25' in (firstname , age ,registration , name, phone)"
	
end)




RegisterNetEvent("licenseCheck")
AddEventHandler("licenseCheck", function(data)

	local pl = source
	MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE registration=@registration", {registration = data}, function(rows)
		local identity = rows[1]
		if identity ~= nil then
			MySQL.Async.fetchAll("SELECT dvalue FROM vrp_user_data WHERE dkey = 'vRP:police_records' and user_id=@id", {id=identity.user_id}, function(rows)
				local rec
        if rows[1] ~= nil then
          rec = rows[1].dvalue
        else
          rec = "..."
        end



        MySQL.Async.fetchAll("SELECT * FROM vrp_users WHERE id = @uid", {uid=identity.user_id}, function(rows)
          
          temp = {
            uid = identity.user_id,
            name = identity.name,
            first = identity.firstname,
            cpr = identity.registration,
            phone = identity.phone,
            age = identity.age,
            record = rec,
            license = "..."
          }


          if #rows > 0 then
            temp.license = rows[1].DmvTest
          else
            temp.license = 1
          end
            
          if temp.license == 3 then
            temp.license = "Ja"
          elseif temp.license == 2 then
            temp.license = "Frataget"
          else
            temp.license = "Nej"
          end
          TriggerClientEvent("pc:send", pl, 1, temp)
        end)
      end)

		else
			TriggerClientEvent("pc:send", pl, -1, temp)
		end
	end)
end)

