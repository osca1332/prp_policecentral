--[[
    __             _                                 __
   / /   ____ _   (_)____ _ ____ _ ____ _ _____ ____/ /
  / /   / __ `/  / // __ `// __ `// __ `// ___// __  /
 / /___/ /_/ /  / // /_/ // /_/ // /_/ // /   / /_/ /
/_____/\__,_/__/ / \__, / \__,_/ \__,_//_/    \__,_/
            /___/ /____/

Det her er udviklet af Oscar Lajgaard, og udviklet for ProvinsenRP.
Må ikke kopieres. Copyright 2020.

Version: BETA-0.1

]]

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



RegisterNUICallback("searchDB", function(data)
	--chat("Sent Info"..data.text, {0,255,0})
	TriggerServerEvent("p_check", data.text)
end)







RegisterNetEvent("prp:returnQuery")
AddEventHandler("prp:returnQuery", function(obj)
	SendNUIMessage({
		type = "result",
		obj = obj
	})


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
		SendNUIMessage({
	        type = "id",
	        uid = data.uid,
	        name = data.name,
	        first = data.first,
	        cpr = data.cpr,
	        phone = data.phone,
	        age = data.age,
	        record = data.record,
	        license = data.license
	    })
	elseif id == -1 then
		SendNUIMessage({
	        type = "idn",
	    })
	end
end)
