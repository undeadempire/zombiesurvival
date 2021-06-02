INC_SERVER()

SWEP.OriginalMeleeDamage = SWEP.MeleeDamage

function SWEP:Deploy()
	self.BaseClass.BaseClass.Deploy(self)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if not hitent:IsPlayer() then
		self.MeleeDamage = 30
	elseif hitent:IsPlayer() then
		hitent:GiveStatus("fatigue", 10)
		
		local bleed = hitent:GiveStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(self.BleedDamage)
			bleed.Damager = self:GetOwner()
		end
	end
end

function SWEP:PostOnMeleeHit(hitent, hitflesh, tr)
	self.MeleeDamage = self.OriginalMeleeDamage
end
