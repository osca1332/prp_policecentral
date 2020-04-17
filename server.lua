local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPas = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","prp_policecentral")
ASclient = Tunnel.getInterface("prp_policecentral","prp_policecentral")
Tunnel.bindInterface("prp_policecentral",vRPas)
local lang = vRP.lang




RegisterNetEvent("pc:perm")
AddEventHandler("pc:perm", function()
	local user_id = vRP.getUserId({source})
  	if vRP.hasGroup({user_id, "Politi-Job"}) then
  		TriggerClientEvent("pc:open",source)
  	end
end)



RegisterNetEvent("licenseCheck")
AddEventHandler("licenseCheck", function(data)

	local src = sourec
	MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE registration=@registration", {registration = data}, function(rows)
		local identity = rows[1]
		if identity ~= nil then 
			-- display identity and business
            local name = identity.name
            local firstname = identity.firstname
            local age = identity.age.. " år"
            local phone = identity.phone
            local registration = identity.registration
            print("Navn: "..name..","..firstname)
            print("Alder: "..age)
            print("Telefonnr: "..phone)
    
            TriggerClientEvent("pc:send", src, 1, identity)

		else
			print("Bilen er ikke registreret!")
		end
	end)
end)