local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

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


	MySQL.query("vRP/get_userbyreg", {reg = data}, function(rows, affected)

		for key, value in pairs(rows[1]) do
    		local user_id = value
    		if user_id ~= nil then
        		MySQL.query("vRP/get_user_identity", {user_id = user_id}, function(rows, affected)
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
	            
			            --TriggerClientEvent("pc:send", source, 1, identity)

					else
						print("Bilen er ikke registreret!")
					end
				end)

        	end
		end

	end)

--[[	
	vRP.getUserByRegistration(data, function(user_id)
		if user_id ~= nil then
        	vRP.getUserIdentity(user_id, function(identity)
          		if identity then
            -- display identity and business
		            local name = identity.name
		            local firstname = identity.firstname
		            local age = identity.age.. " år"
		            local phone = identity.phone
		            local registration = identity.registration
		            local bname = ""
		            local bcapital = 0
		            local home = ""
		            local number = ""

		            vRP.getUserBusiness(user_id, function(business)
		              if business then
		                bname = business.name
		                bcapital = business.capital
		              end

			        vRP.getUserAddress(user_id, function(address)
			          local home = ""
			          local number = ""
			          if address then
			            home = address.home.. " nr. "
			            number = address.number
			          else 
						home = "Hjemløs"
						number = ""
			          end

			            local content = lang.police.identity.info({name,firstname,age,registration,phone,bname,bcapital,home,number})
			            vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
			            vRP.request(player, lang.police.menu.check.request_hide(), 1000, function(player,ok)
			            vRPclient.removeDiv(player,{"police_identity"})
			        end)
        		end)
            end)
          else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end)
      else
     TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.not_found()}, type = "error", queue = "global", timeout = 4000, layout = "centerLeft",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      end
	end)	

	]]
end)