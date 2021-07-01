INC_CLIENT()

SWEP.VElements = {
	["Blinky Boi"] = { type = "Sprite", sprite = "sprites/flare1", bone = "v_weapon.button9", rel = "", pos = Vector(2.25, -0.311, 1.274), size = { x = 0.489, y = 0.489 }, color = Color(255, 190, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true},
	["Screen"] = { type = "Sprite", sprite = "zombiesurvival/killicons/weapon_zs_detpack2", bone = "v_weapon.c4", rel = "", pos = Vector(-3.197, -3.076, 0.4), size = { x = 1.542, y = 1.061 }, color = Color(255, 0, 0, 255), nocull = true, additive = false, vertexalpha = true, vertexcolor = true, ignorez = true}
}

SWEP.WElements = {
	["Blinky Boi"] = { type = "Sprite", sprite = "sprites/flare1", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.394, 9.468, -0.703), size = { x = 2.778, y = 2.853 }, color = Color(255, 190, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.ViewModelBoneMods = {
	["v_weapon.c4"] = { scale = Vector(0.998, 0.893, 0.972), pos = Vector(-0.681, -0.132, -0.124), angle = Angle(3.834, -2.303, -6.883) }
}

SWEP.DrawCrosshair = false
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true