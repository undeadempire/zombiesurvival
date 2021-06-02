AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Ricochete' Magnum"
SWEP.Description = "This gun's bullets will bounce off of walls which will then deal extra damage."
SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.HUD3DBone = "Python"
	SWEP.HUD3DPos = Vector(0.85, 0, -2.5)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "revolver"

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_357.Single")
SWEP.Primary.Delay = 0.7
SWEP.Primary.Damage = 61
SWEP.Primary.NumShots = 1

SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Tier = 2

SWEP.ConeMax = 3.5
SWEP.ConeMin = 2
SWEP.BounceMulti = 1.5

SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.7, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.35, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.07, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Backlash' Magnum", "Gets more accurate for each direct hit, but less damage on non-bounced shots", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 0.85
	wept.BounceMulti = 1.764
	wept.GetCone = function(self)
		return BaseClass.GetCone(self) * (1 - self:GetDTInt(9)/13)
	end
	wept.FinishReload = function(self)
		self:SetDTInt(9, 0)
		BaseClass.FinishReload(self)
	end
end)

GAMEMODE:AddNewRemantleBranch(SWEP, 2, "'Peacemaker' Magnum", "Reaper stacks on kill, ricochete does less, and reloads slower", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 1.2
	wept.Primary.Delay = wept.Primary.Delay * 0.9
	--wept.ConeMax = wept.ConeMax * 0.8
	--wept.ConeMin = wept.ConeMin * 0.9
	wept.BounceMulti = 0.35
	wept.Primary.ClipSize = 5
	wept.ReloadSpeed = wept.ReloadSpeed * 0.9
	
	function wept:OnZombieKilled()
	local killer = self:GetOwner()

	if killer:IsValid() then
		local reaperstatus = killer:GiveStatus("reaper", 14)
		if reaperstatus and reaperstatus:IsValid() then
			reaperstatus:SetDTInt(1, math.min(reaperstatus:GetDTInt(1) + 1, 2))
			killer:EmitSound("hl1/ambience/particle_suck1.wav", 55, 150 + reaperstatus:GetDTInt(1) * 30, 0.45)
		end
	end
end
end)

function SWEP:Draw3DHUD(vm, pos, ang)
	self.BaseClass.Draw3DHUD(self, vm, pos, ang)

	local wid, hei = 180, 200
	local x, y = wid * -0.6, hei * -0.5

	cam.Start3D2D(pos, ang, self.HUD3DScale)
		local owner = self:GetOwner()
		local ownerstatus = owner:GetStatus("reaper")
		if ownerstatus then
			local text = ""
			for i = 0, ownerstatus:GetDTInt(1)-1 do
				text = text .. "+"
			end
			draw.SimpleTextBlurry(text, "ZS3D2DFontSmall", x + wid/2, y + hei * 0.15, Color(60, 30, 175, 230), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	cam.End3D2D()
end

local function DoRicochet(attacker, hitpos, hitnormal, normal, damage)
	local RicoCallback = function(att, tr, dmginfo)
		local ent = tr.Entity
		local wep = att:GetActiveWeapon()
		if wep.Branch == 1 and ent:IsValidZombie() then
			wep:SetDTInt(9, wep:GetDTInt(9) + 2)
		end
	end

	attacker.RicochetBullet = true
	if attacker:IsValid() then
		attacker:FireBulletsLua(hitpos, 2 * hitnormal * hitnormal:Dot(normal * -1) + normal, 0, 1, damage, nil, nil, "tracer_rico", RicoCallback, nil, nil, nil, nil, attacker:GetActiveWeapon())
	end
	attacker.RicochetBullet = nil
end
function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if SERVER and tr.HitWorld and not tr.HitSky then
		local hitpos, hitnormal, normal, dmg = tr.HitPos, tr.HitNormal, tr.Normal, dmginfo:GetDamage() * attacker:GetActiveWeapon().BounceMulti
		timer.Simple(0, function() DoRicochet(attacker, hitpos, hitnormal, normal, dmg) end)
	end

	if SERVER then
		local wep = attacker:GetActiveWeapon()
		if wep.Branch == 1 and ent:IsValidZombie() then
			wep:SetDTInt(9, wep:GetDTInt(9) + 1)
		end
	end
end
