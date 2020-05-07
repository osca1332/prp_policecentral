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
		local person = {
    	}
		if #rows > 0 then
			for i = 1, #rows do
				person[i] = rows[i]
				person[i].rec = MySQL.Sync.fetchScalar("SELECT dvalue FROM vrp_user_data WHERE dkey='vRP:police_records' AND user_id=@uid", {uid=person[i].user_id})
			end
		end

		
		TriggerClientEvent("prp:returnQuery", pl, person)
	end)
end)

