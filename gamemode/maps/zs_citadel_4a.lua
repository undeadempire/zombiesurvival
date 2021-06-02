-- Removes stupid ammo crates in the only room anyone would ever want to hold out in.
-- Unlocks doors of secret rooms.

hook.Add("InitPostEntityMap", "Adding", function()
	
	local ent = ents.Create("info_player_zombie")
	if ent:IsValid() then
		ent:SetPos(Vector(2087, 693, 2332))
		ent:Spawn()
	end

end)
