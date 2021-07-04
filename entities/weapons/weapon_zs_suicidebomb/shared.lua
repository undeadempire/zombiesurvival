AddCSLuaFile()

SWEP.PrintName = "The Seppuku"
SWEP.Description = "A pack of explosives that can be detonated killing yourself and zeds around you."
SWEP.Slot = 4
SWEP.SlotPos = 0

SWEP.Base = "weapon_zs_base"

SWEP.ViewModelFOV = 75
SWEP.BobScale = 0.5
SWEP.SwayScale = 0.5

SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")
SWEP.UseHands = true
SWEP.HoldType = "slam"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 15
SWEP.Undroppable = true

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true

SWEP.NoDeploySpeedChange = true