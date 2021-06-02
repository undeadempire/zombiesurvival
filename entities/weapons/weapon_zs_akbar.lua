AddCSLuaFile()

SWEP.PrintName = "'Akbar' Assault Rifle"
SWEP.Description = "Reliable assault rifle with a very fast reload speed. Not quite as accurate as other assault rifles, but still precise enough nonetheless."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70

	SWEP.HUD3DBone = "v_weapon.AK47_Parent"
	SWEP.HUD3DPos = Vector(-1, -4.5, -4)
	SWEP.HUD3DAng = Angle(0, 0, 0)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.UseHands = true

SWEP.ReloadSound = Sound("Weapon_AK47.Clipout")
SWEP.Primary.Sound = Sound("Weapon_AK47.Single")
SWEP.Primary.Damage = 23
SWEP.HeadshotMulti = 2.2
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.14

SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 2.65
SWEP.ConeMin = 0.975

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 3

SWEP.IronSightsPos = Vector(-0, 00, 0)

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.344)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.172)

GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Tabuk' DMR", "Single-fire only but higher damage and accuracy", function(wept)
	wept.Primary.Automatic = false
	wept.Primary.Delay = 0.4
	wept.Primary.Damage = 28
	wept.ConeMax = 1.85
	wept.ConeMin = 0.8
end)
