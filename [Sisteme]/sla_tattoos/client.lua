vRPts = {}
Tunnel.bindInterface("sla_tattoos",vRPts)
TSserver = Tunnel.getInterface("sla_tattoos","sla_tattoos")

function vRPts.cleanPlayer()
	ClearPedDecorations(GetPlayerPed(-1))
end

function vRPts.drawTattoo(tattoo,tattooshop)
  ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(tattooshop), GetHashKey(tattoo))
end