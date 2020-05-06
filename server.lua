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



RegisterNetEvent("p_check")
AddEventHandler("p_check", function(data)
	local pl = source
	MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE @usid in (firstname , age ,registration , name, phone)", {usid = data}, function(rows)
		local temp = {
    }
		if #rows > 0 then
      for i = 1, #rows do
        temp[i] = rows[i].name..", "..rows[i].firstname
      end
		end
		
		TriggerClientEvent("prp:returnQuery", pl, temp)
	end)
end)

