AddCSLuaFile()

SWEP.Base = "weapon_zs_gunturret"

SWEP.PrintName = "Modular Turret"
SWEP.Description = "An automated turret that fires a weapon given to it.\nPress PRIMARY ATTACK to deploy the turret.\nPress SECONDARY ATTACK and RELOAD to rotate the turret.\nPress USE on a deployed turret to give it a weapon to use or\nammo for its current weapon.\nPress USE on a deployed turret with no owner (blue light) to reclaim it."

SWEP.Primary.Damage = 8.75

SWEP.GhostStatus = "ghost_gunturret_modular"
SWEP.DeployClass = "prop_gunturret_modular"
SWEP.TurretAmmoType = ""
SWEP.TurretAmmoStartAmount = 0
SWEP.TurretSpread = 2

SWEP.Primary.Ammo = "turret_modular"

--Change to something like firerate
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_TURRET_SPREAD, -0.9)
