INC_SERVER()

function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)

	if CLIENT then return end

	for _, ent in pairs(ents.FindByClass("prop_detpack")) do
		if ent:GetOwner() == self:GetOwner() and ent:GetExplodeTime() == 0 then
			ent:SetExplodeTime(CurTime() + ent.ExplosionDelay)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	local count = self:GetPrimaryAmmoCount()
	if count ~= self:GetReplicatedAmmo() then
		self:SetReplicatedAmmo(count)
		self:GetOwner():ResetSpeed()
	end
end
