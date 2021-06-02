INC_SERVER()

--[[The Hammer Heal
function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if not hitent:IsValid() then return end

	local owner = self:GetOwner()

	if (hitent:GetClass() == "prop_door_rotating") then
		local damage = self.MeleeDamage * 4.5;

		local dmginfo = DamageInfo();
			dmginfo:SetDamagePosition(tr.HitPos);
			dmginfo:SetAttacker(owner);
			dmginfo:SetInflictor(self);
			dmginfo:SetDamageType(self.DamageType);
			dmginfo:SetDamage(damage);
			dmginfo:SetDamageForce(math.min(self.MeleeDamage, 50) * 50 * owner:GetAimVector());

		hitent:TakeDamageInfo(dmginfo);
		return;
	end

	if hitent.HitByHammer and hitent:HitByHammer(self, owner, tr) then
		return
	end

	if hitent:IsNailed() then
		if owner:IsSkillActive(SKILL_BARRICADEEXPERT) then
			hitent.ReinforceEnd = CurTime() + 2
			hitent.ReinforceApplier = owner
		end

		local healstrength = self.HealStrength * GAMEMODE.NailHealthPerRepair * (owner.RepairRateMul or 1)
		local oldhealth = hitent:GetBarricadeHealth()
		if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0.01 then return end

		hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), healstrength)))
		local healed = hitent:GetBarricadeHealth() - oldhealth
		hitent:SetBarricadeRepairs(math.max(hitent:GetBarricadeRepairs() - healed, 0))
		self:PlayRepairSound(hitent)
		gamemode.Call("PlayerRepairedObject", owner, hitent, healed, self)

		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			effectdata:SetMagnitude(1)
		util.Effect("nailrepaired", effectdata, true, true)

		return true
	end
end ]]