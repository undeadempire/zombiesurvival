AddCSLuaFile()

SWEP.PrintName = "Suicide Bomb"
SWEP.Description = "A pack of explosives that can be detonated killing yourself and zeds around you."
SWEP.Slot = 4
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFOV = 50
	SWEP.BobScale = 0.5
	SWEP.SwayScale = 0.5
end

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = Model("models/weapons/w_c4_planted.mdl")
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true
SWEP.Undroppable = true
SWEP.NoPickupNotification = true

SWEP.HoldType = "slam"

SWEP.NoDeploySpeedChange = true

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

if SERVER then
function SWEP:Think()
	for _, ent in pairs(ents.FindByClass("prop_detpack")) do
		if ent:GetOwner() == self:GetOwner() then
			return
		end
	end

	self:GetOwner():StripWeapon(self:GetClass())
end
end

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

function SWEP:Reload()
	return false
end

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self:GetOwner(), self)

	self:SendWeaponAnim(ACT_SLAM_DETONATOR_IDLE)

	return true
end

function SWEP:Holster()
	return true
end

if not CLIENT then return end

function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
	self:BaseDrawWeaponSelection(x, y, w, h, alpha)
end

function SWEP:Think()
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if owner:IsValidHuman() then
		local pos = self:GetPos()

		util.BlastDamagePlayer(self, owner, pos, 256, 480, DMG_ALWAYSGIB)

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
			effectdata:SetNormal(self:GetUp() * -1)
		util.Effect("decal_scorch", effectdata)

		for i=1, 3 do
			self:EmitSound("npc/env_headcrabcanister/explosion.wav", 75 + i * 5, 100)
		end
		for i=1, 2 do
			ParticleEffect("dusty_explosion_rockets", pos, angle_zero)
		end
	end
end

function ENT:Think()
	if self.Exploded then
		self:Remove()
		return
	end

	if self:GetExplodeTime() ~= 0 then
		if CurTime() >= self:GetExplodeTime() then
			self:Explode()
		elseif self.NextBlip <= CurTime() then
			self.NextBlip = CurTime() + 0.4
			self:EmitSound("weapons/c4/c4_beep1.wav")
		end
	end

	self:NextThink(CurTime())
	return true
end