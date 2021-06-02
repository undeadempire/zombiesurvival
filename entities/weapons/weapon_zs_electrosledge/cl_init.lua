INC_CLIENT()

SWEP.ViewModelFOV = 75

SWEP.VElements = {
	["powerbox"] = { type = "Model", model = "models/props_lab/powerbox02d.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "element_name+", pos = Vector(0, 0, 0), angle = Angle(178, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["element_name+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-1, -1.558, 2.596), angle = Angle(-90, 0, 90), size = Vector(0.09, 0.09, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1, -15.065), angle = Angle(180, 0, 90), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["sledge"] = { type = "Model", model = "models/weapons/w_sledgehammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.9, 2, 0), angle = Angle(0, 0, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["element_name+"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name", pos = Vector(-1, -1.558, 2.596), angle = Angle(-90, 0, 90), size = Vector(0.09, 0.09, 0.09), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["powerbox"] = { type = "Model", model = "models/props_lab/powerbox02d.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "element_name+", pos = Vector(0, 0, 0), angle = Angle(178, 0, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["element_name"] = { type = "Model", model = "models/props_lab/teleportring.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "sledge", pos = Vector(-0.519, 0, 24.416), angle = Angle(0, 180, 80.649), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


function SWEP:DrawHUD()
	if GetGlobalBool("classicmode") then return end
	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()

	local screenscale = BetterScreenScale()
	
	surface.SetFont("ZSHUDFont")
	if self.Aoe == 1 then
	local pulse = self:GetPrimaryAmmoCount() / 15
	local text = "Repair Pulses: " .. math.floor(pulse) .. "" 
	local nTEXW, nTEXH = surface.GetTextSize(text)
	
	draw.SimpleTextBlurry(text, "ZSHUDFont", ScrW() - nTEXW * 0.75 - 32 * screenscale, ScrH() - nTEXH * 1.5, pulse > 0 and COLOR_LIMEGREEN or COLOR_RED, TEXT_ALIGN_CENTER)
	else end
end