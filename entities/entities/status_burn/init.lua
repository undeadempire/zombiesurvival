INC_SERVER()

function ENT:Think()
	local owner = self:GetOwner()

	if not self:GetDTBool(0) then
		self:SetDTFloat(0, self.Damage)
		dmg = math.floor(self:GetDamage()/(self.DieTime - CurTime()))
		self:SetDTBool(0, true)
	end

	if self:GetDamage() <= 0 or owner:WaterLevel() > 0 or not owner:Alive() then
		self:Remove()
		return
	end

	owner:TakeSpecialDamage(dmg, DMG_BURN, self.Applier and self.Applier:IsValid() and self.Applier:IsPlayer() and self.Applier:Team() ~= owner:Team() and self.Applier or owner, self.Applier)
	self:AddDamage(-dmg)

	self:NextThink(CurTime() + 0.5)
	return true
end
