AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "'Blaster' Shotgun"
SWEP.Description = "A basic shotgun that can deal significant amounts of damage at close range."

if CLIENT then
	SWEP.ViewModelFlip = false

	SWEP.HUD3DPos = Vector(4, -3.5, -1.2)
	SWEP.HUD3DAng = Angle(90, 0, -30)
	SWEP.HUD3DScale = 0.02
	SWEP.HUD3DBone = "SS.Grip.Dummy"
end

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/v_supershorty/v_supershorty.mdl"
SWEP.WorldModel = "models/weapons/w_supershorty.mdl"
SWEP.UseHands = false

SWEP.ReloadDelay = 0.4

SWEP.Primary.Sound = Sound("Weapon_Shotgun.NPC_Single")
SWEP.Primary.Damage = 8.325
SWEP.Primary.NumShots = 8
SWEP.Primary.Delay = 0.8

SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)
SWEP.ConeMax = 8.75
SWEP.ConeMin = 5

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.PumpSound = Sound("Weapon_M3.Pump")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

SWEP.PumpActivity = ACT_SHOTGUN_PUMP

ispea = false

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Blaster' Slug Gun", "Single accurate slug round, less total damage", function(a)
	a.Primary.Damage = a.Primary.Damage * 5.5
	a.Primary.NumShots = 1
	a.ConeMin = a.ConeMin * 0.15
	a.ConeMax = a.ConeMax * 0.3
end)

branch = GAMEMODE:AddNewRemantleBranch(SWEP, 2, "Pea Sweeper", "uses half ammo,fires faster, less total damage", function(b)
	b.Primary.Damage = b.Primary.Damage * 0.7
	b.Primary.NumShots = 8
	b.ConeMin = b.ConeMin * 1
	b.ConeMax = b.ConeMax * 1	
	b.Primary.Delay = 0.6
	b.ReloadDelay = 0.95
	b.Primary.ClipSize = 4
	function b:SetAltUsage(usage)
	self:SetDTBool(1, usage)
end
branch.Colors = {Color(90, 30, 0), Color(90, 40, 0), Color(90, 50, 0)}
branch.NewNames = {"drizzle", "rain", "monsoon"}
function b:GetAltUsage()
	return self:GetDTBool(1)
end

function b:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self:EmitFireSound()

	local altuse = self:GetAltUsage()
	if not altuse then
		self:TakeAmmo()
	end
	self:SetAltUsage(not altuse)

	self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
	self.IdleAnimation = CurTime() + self:SequenceDuration()
end

if not CLIENT then return end

function b:GetDisplayAmmo(clip, spare, maxclip)
	local minus = self:GetAltUsage() and 0 or 1
	return math.max(0, (clip * 2) - minus), spare * 2, maxclip * 2
end
end)



function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)

	timer.Simple(0.15, function()
		if IsValid(self) then
			self:SendWeaponAnim(ACT_SHOTGUN_PUMP)
			self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)

			if CLIENT and self:GetOwner() == MySelf then
				self:EmitSound("weapons/m3/m3_pump.wav", 65, 100, 0.4, CHAN_AUTO)
			end
		end
	end)
end

