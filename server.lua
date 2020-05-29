-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('vferimento',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local vnplayer = vRPclient.getHealth(nplayer)
		if nplayer then
			if vnplayer <= 100 then
				local diagnostic = math.random(1,3)
				if diagnostic == 1 then
					TriggerClientEvent("Notify",source,"aviso","O cidadão se encontra morto!")
					TriggerClientEvent("Notify",nplayer,"aviso","Você se encontra morto!")
				elseif diagnostic == 2 then
					TriggerClientEvent("Notify",nplayer,"aviso","Você se encontra vivo e sem ferimento graves,logo vai pra casa!")
					TriggerClientEvent("Notify",source,"aviso","O cidadão se encontra vivo e sem ferimento graves, realize o procedimento o mais rapido!")
				elseif diagnostic == 3 then
					TriggerClientEvent("Notify",nplayer,"aviso","Você se encontra vivo com ferimento grave, olha pra luz!")
					TriggerClientEvent("Notify",source,"aviso","O cidadão se encontra vivo com ferimento grave, realize o procedimento o mais rapido e encaminhe o mesmo para o hospital !")
				end
			else
				TriggerClientEvent("Notify",source,"aviso","O cidadão se encontra vivo e sem ferimentos!")
			end
		end
	end
end)
