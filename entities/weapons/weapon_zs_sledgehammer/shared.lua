AddCSLuaFile()

SWEP.PrintName = "Sledgehammer"
SWEP.Description = "A heavy, but powerful melee weapon. A target struck by the force of it will receive considerable knockback."

if CLIENT then
	SWEP.ViewModelFOV = 75
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/v_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 75
SWEP.MeleeRange = 64
SWEP.MeleeSize = 1.75
SWEP.MeleeKnockBack = 200 -- I agree that the knockback should have been reduced

SWEP.Primary.Delay = 1.3

SWEP.Tier = 2

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(60, 0, -80)
SWEP.SwingOffset = Vector(0, -30, 0)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.1, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1, 1)

--[[ GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Teflon' Repair Sledgehammer", "Deals less damage but is able to repair nailed props", function(wept)
	wept.Primary.Delay = wept.Primary.Delay * 0.95
	wept.HealStrength = 3.6
	wept.MeleeDamage = wept.MeleeDamage * 0.85
end) ]]
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Wrecker' Heavy Sledgehammer", "Does more damage and a has bit more range, but swings much slow than the regular sledge", function(wept)
	wept.MeleeRange = 80
	wept.MeleeKnockBack = 270
	wept.SwingTime = 1.0
	wept.MeleeDamage = wept.MeleeDamage * 1.3
end)

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
