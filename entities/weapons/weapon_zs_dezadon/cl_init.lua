INC_CLIENT()

SWEP.Slot = 3
SWEP.SlotPos = 0

SWEP.HUD3DBone = "Base"
SWEP.HUD3DPos = Vector(3, -0.5, -13)
SWEP.HUD3DAng = Angle(180, 0, 0)
SWEP.HUD3DScale = 0.03
SWEP.IronSightsPos = Vector(-6.841, -5.226, 3.819)
SWEP.IronSightsAng = Vector(0, 0, 0)
yaw = 0
if CLIENT then
	SWEP.HUD3DBone = "ValveBiped.Gun"
	SWEP.HUD3DPos = Vector(2, 0, -5)
	SWEP.HUD3DScale = 0.025

	SWEP.ViewModelFlip = false
end

SWEP.VElements = {
	["handle+"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -1.558, 8.831), angle = Angle(90, 0, 0), size = Vector(0.367, 0.237, 0.107), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["stock+"] = { type = "Model", model = "models/phxtended/tri2x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0.25, -0.5, -8.832), angle = Angle(-180, 90, -90), size = Vector(0.172, 0.107, 0.172), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle+++"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -1.558, 8.831), angle = Angle(90, 0, -60), size = Vector(0.367, 0.237, 0.107), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["clip"] = { type = "Model", model = "models/props_phx/construct/metal_plate1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(2.596, 1.557, 15.064), angle = Angle(90, 30, 0), size = Vector(0.237, 0.107, 1.039), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Gun", rel = "base", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.039, 0.039, 0.2), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["stock++"] = { type = "Model", model = "models/props_c17/playground_swingset_seat01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 2.596, -6.753), angle = Angle(-180, 90, 180), size = Vector(0.107, 0.107, 0.107), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pulse+"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, -10.91), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 2.183), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["light"] = { type = "Sprite", sprite = "effects/blueflare1", bone = "ValveBiped.Bip01_Spine4", rel = "pulse", pos = Vector(0, 0, 11.947), size = { x = 10, y = 10 }, color = Color(0, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["pulse"] = { type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, 0, 8.831), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 2.183), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["base"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Gun", rel = "", pos = Vector(-0.5, 1, -8), angle = Angle(0, 0, 0), size = Vector(0.041, 0.041, 0.2), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle++"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -1.558, 8.831), angle = Angle(90, 0, -30), size = Vector(0.367, 0.237, 0.107), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "base", pos = Vector(0, -1.558, 8.831), angle = Angle(90, 0, -90), size = Vector(0.367, 0.237, 0.107), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

--[[SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, -3), angle = Angle(0, 0, 0) },
	["Base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 3), angle = Angle(0, 0, 0) }
}]]

--[[while true do
	yaw = yaw + 1
	wept.VElements["pulse"].angle = Angle(0, yaw, 0)
end]]