SWEP.PrintName = "'Dezadon' Chem Shotbeamer"
SWEP.Description = "Not like most chem weapons, as it arcs a mixture of toxins and energy to its target."

SWEP.Base = "weapon_zs_base"
SWEP.ReloadSpeed = 0.55
SWEP.PumpSound = Sound("ambient/energy/weld2.wav")
SWEP.ReloadSound = Sound("ambient/energy/whiteflash.wav")

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 58
SWEP.HoldType = "shotgun"
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Gun"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Primary.Damage = 12
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.3
SWEP.Primary.KnockbackScale = 12
SWEP.Knockback = 140
SWEP.Primary.MaxDistance = 550

SWEP.Primary.ClipSize = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "chemical"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.ConeMax = 6
SWEP.ConeMin = 4.4

SWEP.Recoil = 3

SWEP.Tier = 5
SWEP.MaxStock = 3

SWEP.WalkSpeed = SPEED_SLOWEST
SWEP.FireAnimSpeed = 0.24
SWEP.FireSoundPitch = 125

SWEP.TracerName = "tracer_healray"

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.02)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Vedazon' Chem Laser", "Shoots fast and bigger clip size, one laser per shot, consumes ammo quickly", function(wept)
	--wept.Primary.ClipSize = wept.Primary.ClipSize * 2
	--wept.Primary.Damage = wept.Primary.Damage * 4
	--wept.Primary.Delay = wept.Primary.Delay * 0.5
	wept.Primary.ClipSize = 20
	wept.Primary.Damage = wept.Primary.Damage * 3.2
	wept.Primary.Delay = wept.Primary.Delay * 0.3
	
	wept.Primary.NumShots = 1
	wept.Knockback = 40
	wept.Recoil = 0
end)

function SWEP:SendReloadAnimation()
	self:SendWeaponAnim(ACT_VM_DRAW)
end
--[[function SWEP:Initialize()
	self.FiringSound = CreateSound(self, "^thrusters/rocket02.wav")
	self.FiringSound:SetSoundLevel(85)
	if CLIENT then self.VentingSound = CreateSound(self, "ambient/levels/labs/teleport_alarm_loop1.wav") end

	self.BaseClass.Initialize(self)
end]]

--[[function SWEP:Deploy()
	local owner = self:GetOwner()
	if not self.PostOwner then
		self.PostOwner = owner
	end

	return self.BaseClass.Deploy(self)
end]]

--[[function SWEP:Holster()
	self:EndGluonState()

	return self.BaseClass.Holster(self)
end]]

--[[function SWEP:OnRemove()
	self.BaseClass.OnRemove(self)
	self:EndGluonState()
end]]

function SWEP:EmitStartFiringSound()
	self:EmitSound("beams/beamstart5.wav", 75, 200 + math.random(0,20))
end

function SWEP:GluonDamage()
	return self.Primary.Damage
end

function SWEP:PrimaryAttack()
	local owner = self:GetOwner()
	
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

	self:TakePrimaryAmmo(1)

	self:ShootBullets(self:GluonDamage(), self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = 2.3

	if IsFirstTimePredicted() then
		self:EmitStartFiringSound()
		owner:ViewPunch(0.5 * self.Recoil * Angle(math.Rand(-0.1, -0.1), math.Rand(-0.1, 0.1), 0))
	end
	
	owner:SetGroundEntity(NULL)
	owner:SetVelocity(-self.Knockback * owner:GetAimVector())
end

--[[function SWEP:CanPrimaryAttack()
	if self:GetPrimaryAmmoCount() <= 0 then
		return false
	end

	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() or self:GetReloadFinish() > 0 then return false end

	return self:GetNextPrimaryFire() <= CurTime()
end]]

--[[function SWEP.BulletCallback(attacker, tr, dmginfo)
	dmginfo:SetDamageType(DMG_DISSOLVE)

	if tr.HitWorld then
		util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
	end

	if attacker:GetActiveWeapon().LegDamage then
		local ent = tr.Entity
		if ent:IsValidZombie() then
			ent:AddLegDamageExt(4.5, attacker, attacker:GetActiveWeapon(), SLOWTYPE_PULSE)
		end
	end

	return {impact = false}
end]]

--[[function SWEP:SecondaryAttack()
end]]

--[[function SWEP:StopGluonSounds()
	self.FiringSound:Stop()
	if CLIENT then self.VentingSound:Stop() end
end]]

--[[function SWEP:EndGluonState()
	local owner = self.PostOwner or self:GetOwner()
	if owner:IsValid() then
		owner.GluonInactiveTime = CurTime()
		owner.GunSway = false
	end

	self:StopGluonSounds()
end]]
