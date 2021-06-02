AddCSLuaFile()

SWEP.PrintName = "'Drugger' Stun Baton"
SWEP.Description = "This baton inflicts excruciating blinding to intelligent zombies. Not as effective against cultist zombies."

if CLIENT then
	SWEP.ViewModelFOV = 50
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee"

SWEP.Tier = 3

SWEP.MeleeDamage = 45
SWEP.LegDamage = 25
SWEP.MeleeRange = 49
SWEP.MeleeSize = 1.5
SWEP.Primary.Delay = 0.4

SWEP.SwingTime = 0.25
SWEP.SwingRotation = Angle(60, 0, 0)
SWEP.SwingOffset = Vector(0, -50, 0)
SWEP.SwingHoldType = "grenade"

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.06)

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.AllowQualityWeapons = true


function SWEP:PlaySwingSound()
	self:EmitSound("Weapon_StunStick.Swing")
end

function SWEP:PlayHitSound()
	self:EmitSound("Weapon_StunStick.Melee_HitWorld")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("Weapon_StunStick.Melee_Hit")
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() then
		hitent:AddLegDamageExt(self.LegDamage, self:GetOwner(), self, SLOWTYPE_PULSE)
	end
end

if SERVER then
function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if hitent:IsValid() and hitent:IsPlayer() and hitent:GetZombieClassTable().Name ~= "Shade" and CurTime() >= (hitent._NextLeadPipeEffect or 0) then
		hitent._NextLeadPipeEffect = CurTime() + 0.1

		--hitent:GiveStatus("disorientation")
		local x = math.Rand(0.75, 1)
		x = x * (math.random(2) == 2 and 1 or -1)

		local ang = Angle(1 - x, x, 0) * 38
		hitent:ViewPunch(ang)

		local eyeangles = hitent:EyeAngles()
		eyeangles:RotateAroundAxis(eyeangles:Up(), ang.yaw)
		eyeangles:RotateAroundAxis(eyeangles:Right(), ang.pitch)
		eyeangles.pitch = math.Clamp(ang.pitch, -180, 180)
		eyeangles.roll = 0
		hitent:SetEyeAngles(eyeangles)
	end
end
end
