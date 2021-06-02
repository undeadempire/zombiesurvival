AddCSLuaFile()

SWEP.PrintName = "Electrosledge"
SWEP.Description = "The addition of a powered electrobattery allows this powerful melee weapon to heal multiple props."

SWEP.ViewModel = "models/weapons/v_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.UseHands = true

SWEP.MeleeDamage = 85
SWEP.MeleeRange = 72
SWEP.MeleeSize = 1.75
SWEP.MeleeKnockBack = 225

SWEP.HealStrength1 = 4
SWEP.Aoe = 0

SWEP.Primary.Delay = 1.3

SWEP.Tier = 3

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.1, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1, 1)

GAMEMODE:AddNewRemantleBranch(SWEP, 1, "AoE Electrosledge", "Repairs props in an area, alt-fire is more powerful at the cost of pulse ammo.", function(remanta)
	remanta.HealStrength1 = 1.8
	remanta.HealStrength2 = 3.0
	remanta.MaxDistance1 = 30
	remanta.MaxDistance2 = 90
	remanta.Primary.ClipSize = 30
	remanta.Primary.Ammo = "pulse"
	remanta.Primary.DefaultClip = 60
	remanta.MeleeDamage = 85
	remanta.MeleeDamage2 = 60
	remanta.Secondary.Automatic = false
	remanta.Aoe = 1
end)

function SWEP:TakeAmmo()
	self:TakeCombinedPrimaryAmmo(15)
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
if not self:CanPrimaryAttack() then return end
	self:SetNextAttack(true)
	self:StartSwinging(true)
	if SERVER then
function self:OnMeleeHit(hitent, hitflesh, tr)
	local owner = self:GetOwner()
	if (hitent:GetClass() == "prop_door_rotating") then
		local damage = self.MeleeDamage * 5;
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
	if not hitent:IsNailed() then return end
	if self.Aoe == 1 then
		-- Sentinel Repairing
	if hitent.HitByHammer and hitent:HitByHammer(self, owner, tr) then
		return
	end

	if hitent:IsNailed() then
		if owner:IsSkillActive(SKILL_BARRICADEEXPERT) then
			hitent.ReinforceEnd = CurTime() + 2
			hitent.ReinforceApplier = owner
		end
		--[[ if owner:IsSkillActive(SKILL_HAMMERDISCIPLINE) then
			local oldspeed = self.Primary.Delay
			self.Primary.Delay = (oldspeed * .75)
		end ]]
	end

	local pos = hitent:GetPos()
	local hs1 = self.HealStrength1 * GAMEMODE.NailHealthPerRepair * (owner.RepairRateMul or 1)

	for _, hitent in pairs(ents.FindInSphere(pos, self.MaxDistance1)) do
		if not hitent:IsValid() or hitent == self or not WorldVisible(pos, hitent:NearestPoint(pos)) then
			continue
		end

		local healed = false

		if hitent:IsNailed() then
			local oldhealth = hitent:GetBarricadeHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0.01 then continue end

			hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), hs1)))
			healed = hitent:GetBarricadeHealth() - oldhealth
			hitent:SetBarricadeRepairs(math.max(hitent:GetBarricadeRepairs() - healed, 0))

		elseif hitent.GetObjectHealth then
			-- Taking the nil tr parameter for granted for now
			if hitent.HitByWrench and hitent:HitByWrench(self, owner, nil) then continue end

			local oldhealth = hitent:GetObjectHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxObjectHealth() or hitent.m_LastDamaged and CurTime() < hitent.m_LastDamaged + 4 then continue end

			hitent:SetObjectHealth(math.min(hitent:GetMaxObjectHealth(), hitent:GetObjectHealth() + hs1/2))
			healed = hitent:GetObjectHealth() - oldhealth
		end

		if healed then
			hitent:EmitSound("npc/dog/dog_servo"..math.random(7, 8)..".wav", 70, math.random(100, 105))
			gamemode.Call("PlayerRepairedObject", owner, hitent, healed, self)

			local effectdata = EffectData()
				effectdata:SetOrigin(hitent:GetPos())
				effectdata:SetNormal((self:GetPos() - hitent:GetPos()):GetNormalized())
				effectdata:SetMagnitude(1)
			util.Effect("nailrepaired", effectdata, true, true)

		end
	end
	--else end
	elseif self.Aoe == 0 then
		-- Hammer Repairing
		local owner = self:GetOwner()
		if (hitent:GetClass() == "prop_door_rotating") then
			local damage = self.MeleeDamage * 5;
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
	if not hitent:IsValid() or hitent:IsValidZombie() then return end
		if hitent.HitByHammer and hitent:HitByHammer(self, owner, tr) then
			return
		end

	if hitent:IsNailed() then
		if owner:IsSkillActive(SKILL_BARRICADEEXPERT) then
			hitent.ReinforceEnd = CurTime() + 2
			hitent.ReinforceApplier = owner
		end

		local hs1 = self.HealStrength1 * GAMEMODE.NailHealthPerRepair * (owner.RepairRateMul or 1)
		local oldhealth = hitent:GetBarricadeHealth()
		if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0.01 then return end

		hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), hs1)))
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
else end
end
end
end

function SWEP:SecondaryAttack()
	if self.Aoe == 1 then
		local owner = self:GetOwner()
		if owner:GetAmmoCount("pulse") < 15 or not self:CanPrimaryAttack() then return end
			self:SetNextAttack(true)
			self:StartSwinging(true)
		if SERVER then
function self:OnMeleeHit(hitent, hitflesh, tr)	
	if self.Aoe == 1 then
		-- Sentinel Repairing
	if (hitent:GetClass() == "prop_door_rotating") then
		local damage = self.MeleeDamage2 * 5;
		local dmginfo = DamageInfo();
			dmginfo:SetDamagePosition(tr.HitPos);
			dmginfo:SetAttacker(owner);
			dmginfo:SetInflictor(self);
			dmginfo:SetDamageType(self.DamageType);
			dmginfo:SetDamage(damage);
			dmginfo:SetDamageForce(math.min(self.MeleeDamage2, 50) * 50 * owner:GetAimVector());
			hitent:TakeDamageInfo(dmginfo);
		return;
	end
		if not hitent:IsValid() then return end
		local owner = self:GetOwner()
	if hitent:IsValidZombie() or hitent:IsNailed() then
		self:TakeAmmo()
--[[ 		local newdamage = self.MeleeDamage2
		local dmginfo = DamageInfo()
		dmginfo:SetDamage(newdamage)
		hitent:TakeDamageInfo(dmginfo)
 ]]
	if hitent.HitByHammer and hitent:HitByHammer(self, owner, tr) then
		return
	end

	if hitent:IsNailed() then
		if owner:IsSkillActive(SKILL_BARRICADEEXPERT) then
			hitent.ReinforceEnd = CurTime() + 2
			hitent.ReinforceApplier = owner
		end
	end

	local pos = hitent:GetPos()
	local hs2 = self.HealStrength2 * GAMEMODE.NailHealthPerRepair * (owner.RepairRateMul or 1)

	for _, hitent in pairs(ents.FindInSphere(pos, self.MaxDistance2)) do
		if not hitent:IsValid() or hitent == self or not WorldVisible(pos, hitent:NearestPoint(pos)) then
			continue
		end

		local healed = false

		if hitent:IsNailed() then
			local oldhealth = hitent:GetBarricadeHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxBarricadeHealth() or hitent:GetBarricadeRepairs() <= 0.01 then continue end

			hitent:SetBarricadeHealth(math.min(hitent:GetMaxBarricadeHealth(), hitent:GetBarricadeHealth() + math.min(hitent:GetBarricadeRepairs(), hs2)))
			healed = hitent:GetBarricadeHealth() - oldhealth
			hitent:SetBarricadeRepairs(math.max(hitent:GetBarricadeRepairs() - healed, 0))

		elseif hitent.GetObjectHealth then
			-- Taking the nil tr parameter for granted for now
			if hitent.HitByWrench and hitent:HitByWrench(self, owner, nil) then continue end

			local oldhealth = hitent:GetObjectHealth()
			if oldhealth <= 0 or oldhealth >= hitent:GetMaxObjectHealth() or hitent.m_LastDamaged and CurTime() < hitent.m_LastDamaged + 4 then continue end

			hitent:SetObjectHealth(math.min(hitent:GetMaxObjectHealth(), hitent:GetObjectHealth() + hs2/2))
			healed = hitent:GetObjectHealth() - oldhealth
		end

		if healed then
			hitent:EmitSound("npc/dog/dog_servo"..math.random(7, 8)..".wav", 70, math.random(100, 105))
			gamemode.Call("PlayerRepairedObject", owner, hitent, healed, self)

			local effectdata = EffectData()
				effectdata:SetOrigin(hitent:GetPos())
				effectdata:SetNormal((self:GetPos() - hitent:GetPos()):GetNormalized())
				effectdata:SetMagnitude(1)
			util.Effect("nailrepaired", effectdata, true, true)

		end
	end
	end
else end
end	
else end
end
end

--[[
function SWEP:IsSecondSwinging()
	return self:GetSecondSwing() > 0
end

function SWEP:SetSecondSwing(swing)
	self:SetDTFloat(1, swing)
end

function SWEP:GetSecondSwing()
	return self:GetDTFloat(1)
end
]]
function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(86, 90))
end

function SWEP:PlayRepairSound(hitent)
	hitent:EmitSound("npc/dog/dog_servo"..math.random(7, 8)..".wav", 70, math.random(100, 105))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end
