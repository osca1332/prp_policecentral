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


function fetchLicense(user_id)
	local dmv
	MySQL.Async.fetchAll("SELECT DmvTest FROM vrp_users WHERE id=@uid", {uid=user_id}, function(rows)
		local license = rows[1].DmvTest
		return tostring(license)
	end)
end


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



                local temp = {
                  uid = identity.user_id,
                  name = identity.name,
                  first = identity.firstname,
                  cpr = identity.registration,
                  phone = identity.phone,
                  age = identity.age,
                  record = rec,
              	}	
              	local dli = fetchLicense(identity.user_id)
                if dli == "3" then
                	temp.license = "Ja"
                else
                	temp.license = "Nej"
                end
              	TriggerClientEvent("pc:send", pl, 1, temp)
            end)

		else
			TriggerClientEvent("pc:send", pl, -1, identity, reocrd, fetchLicense(identity.user_id))
		end
	end)
end)

RegisterNetEvent("nameCheck")
AddEventHandler("nameCheck", function(fname, lname)

	local pl = source
	MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE UPPER(firstname)=UPPER(@first) AND UPPER(name)=UPPER(@last)", {first = fname, last= lname}, function(rows)
		local identity = rows[1]
		if identity ~= nil then 
			MySQL.Async.fetchAll("SELECT dvalue FROM vrp_user_data WHERE dkey = 'vRP:police_records' and user_id=@id", {id=identity.user_id}, function(rows)
				local rec
                if rows[1] ~= nil then
                  rec = rows[1].dvalue
                else
                  rec = "..."
                end
                local temp = {
                  uid = identity.user_id,
                  name = identity.name,
                  first = identity.firstname,
                  cpr = identity.registration,
                  phone = identity.phone,
                  age = identity.age,
                  record = rec,
              	}	
              	local dli = fetchLicense(identity.user_id)
                if dli == "3" then
                	temp.license = "Ja"
                else
                	temp.license = "Nej"
                end
              	TriggerClientEvent("pc:send", pl, 1, temp)
            end)
		else
			TriggerClientEvent("pc:send", pl, -1, identity, record, fetchLicense(identity.user_id))
		end
	end)
end)

RegisterNetEvent("phoneCheck")
AddEventHandler("phoneCheck", function(phone)

	local pl = source
	MySQL.Async.fetchAll("SELECT * FROM vrp_user_identities WHERE phone=@ph", {ph = phone}, function(rows)
		local identity = rows[1]
		if identity ~= nil then 
			MySQL.Async.fetchAll("SELECT dvalue FROM vrp_user_data WHERE dkey = 'vRP:police_records' and user_id=@id", {id=identity.user_id}, function(rows)
				local rec
                if rows[1] ~= nil then
                  rec = rows[1].dvalue
                else
                  rec = "..."
                end
                local temp = {
                  uid = identity.user_id,
                  name = identity.name,
                  first = identity.firstname,
                  cpr = identity.registration,
                  phone = identity.phone,
                  age = identity.age,
                  record = rec,
                  
              	}	
              	local dli = fetchLicense(identity.user_id)
                if dli == "3" then
                	temp.license = "Ja"
                else
                	temp.license = "Nej"
                end
              	TriggerClientEvent("pc:send", pl, 1, temp)
            end)

		else
			TriggerClientEvent("pc:send", pl, -1, identity, record, fetchLicense(identity.user_id))
		end
	end)
end)