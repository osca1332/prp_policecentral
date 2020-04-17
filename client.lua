










vRPbsT = {}
Tunnel.bindInterface("prp_policecentral",vRPbsT)
Proxy.addInterface("prp_policecentral",vRPbsT)
vRPbsS = Tunnel.getInterface("prp_policecentral","prp_policecentral")
vRP = Proxy.getInterface("vRP")


local display = false


function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end



RegisterNUICallback("main", function(data)
	chat(data.text, {0,0,244})
	SetDisplay(false)
end)


RegisterNUICallback("error", function(data)
	chat(data.error, {255,0,0})
	SetDisplay(false)
end)


RegisterNUICallback("exit", function(data)
	--chat("Exited", {0,255,0})
	SetDisplay(false)
end)



RegisterNUICallback("licenseCheck", function(data)
	TriggerServerEvent("licenseCheck", tostring(data.text), tostring(data.type))
	SetDisplay(false)
end)








Citizen.CreateThread(function()
    while display == true do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)




function chat(text, color)
	TriggerEvent("chat:addMessage", {
		color=color,
		multiline=true,
		args={text}
	})

end


RegisterCommand("p", function()
	SetDisplay(not display)

end)




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(1, 166) then
			TriggerServerEvent("pc:perm")
		end
	end

end)


RegisterNetEvent("pc:open")
AddEventHandler("pc:open", function()
	SetDisplay(not display)
end)


		
RegisterNetEvent("pc:send")
AddEventHandler("pc:send", function(id, data)
	if id == 1 then
		SetDisplay(false)
		SendNUIMessage({
	        type = "id",
	        name = data.name,
	        first = data.firstname,
	        cpr = data.registration,
	        phone = data.phone
	    })

	end
end)