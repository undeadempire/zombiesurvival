AddCSLuaFile()

--[[if SERVER then
resource.AddFile("materials/zombiesurvival/killicons/weapon_zs_jurisdiction.vmt")
end]]

--Made by DRBANG

SWEP.HoldType = "crossbow"
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["ValveBiped.Base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}


SWEP.PrintName = "'Jurisdiction' Double Barrel"
SWEP.Description = "The raw power of this double barrel is enough to pierce through hordes of zombies."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70

	SWEP.VElements = {
		["Hold"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Crossbow_base", rel = "", pos = Vector(0, 0.518, -3.636), angle = Angle(0, 0, 0), size = Vector(0.09, 0.09, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Hold++"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Base", rel = "Hold", pos = Vector(0, -0.519, 0), angle = Angle(0, 0, -15), size = Vector(0.09, 0.09, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Barrel+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x6.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hinge", pos = Vector(1, -0.9, -4.5), angle = Angle(0, 0, 0), size = Vector(0.041, 0.041, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["Trigger"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hold+", pos = Vector(0, 0.518, 0), angle = Angle(0, 0, -45.584), size = Vector(0.079, 0.079, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Hold+"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Base", rel = "Hold", pos = Vector(0, 0.518, 0), angle = Angle(0, 0, -15), size = Vector(0.09, 0.09, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Back"] = { type = "Model", model = "models/hunter/triangles/1x1x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hold", pos = Vector(0, -1.9, 0.699), angle = Angle(180, 0, 0), size = Vector(0.041, 0.041, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Trigger+"] = { type = "Model", model = "models/props_canal/canal_cap001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hold+", pos = Vector(0, 1.2, 0), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Hinge"] = { type = "Model", model = "models/props_borealis/door_wheel001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hold", pos = Vector(0, -1, 5.714), angle = Angle(0, 90, 0), size = Vector(0.172, 0.172, 0.172), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel"] = { type = "Model", model = "models/hunter/tubes/tube1x1x6.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hinge", pos = Vector(1, 1, -4.5), angle = Angle(0, 0, 0), size = Vector(0.041, 0.041, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["Back+"] = { type = "Model", model = "models/props_c17/metalladder002b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Back", pos = Vector(0, 0.518, -1.558), angle = Angle(0, -87.663, 0), size = Vector(0.107, 0.09, 0.107), color = Color(255, 105, 198, 255), surpresslightning = false, material = "phoenix_storms/wire/pcb_red", skin = 0, bodygroup = {} },
		["Core"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hold", pos = Vector(1.557, 0.518, 7.791), angle = Angle(90, 0, -73.637), size = Vector(0.237, 0.237, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel+++"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hinge", pos = Vector(1, 1, -4.5), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Barrel++"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Hinge", pos = Vector(1, -0.9, -4.5), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} }
	}



	SWEP.WElements = {
		["Back"] = { type = "Model", model = "models/hunter/triangles/1x1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold", pos = Vector(0, -1.9, 0.699), angle = Angle(180, 0, 0), size = Vector(0.041, 0.041, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Trigger+"] = { type = "Model", model = "models/props_canal/canal_cap001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold+", pos = Vector(0, 1.2, 0), angle = Angle(0, 0, 0), size = Vector(0.017, 0.017, 0.029), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Barrel+"] = { type = "Model", model = "models/hunter/tubes/tube1x1x6.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hinge", pos = Vector(1, -0.9, -4.5), angle = Angle(0, 0, 0), size = Vector(0.041, 0.041, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["Barrel+++"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hinge", pos = Vector(1, 1, -4.5), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Hold+"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold", pos = Vector(0, 0.518, 0), angle = Angle(0, 0, -15), size = Vector(0.09, 0.09, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Hold++"] = { type = "Model", model = "models/props_docks/channelmarker_gib01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold", pos = Vector(0, -0.519, 0), angle = Angle(0, 0, -15), size = Vector(0.09, 0.09, 0.172), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Hold"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.675, 0, -1.558), angle = Angle(0, -90, -90), size = Vector(0.09, 0.09, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
		["Hinge"] = { type = "Model", model = "models/props_borealis/door_wheel001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold", pos = Vector(0, -1, 5.714), angle = Angle(0, 90, 0), size = Vector(0.172, 0.172, 0.172), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel"] = { type = "Model", model = "models/hunter/tubes/tube1x1x6.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hinge", pos = Vector(1, 1, -4.5), angle = Angle(0, 0, 0), size = Vector(0.041, 0.041, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/gear", skin = 0, bodygroup = {} },
		["Back+"] = { type = "Model", model = "models/props_c17/metalladder002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Back", pos = Vector(0, 0.518, -1.558), angle = Angle(0, -87.663, 0), size = Vector(0.107, 0.09, 0.107), color = Color(255, 105, 198, 255), surpresslightning = false, material = "phoenix_storms/wire/pcb_red", skin = 0, bodygroup = {} },
		["Core"] = { type = "Model", model = "models/Items/BoxFlares.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold", pos = Vector(1.557, 0.518, 7.791), angle = Angle(90, 0, -73.637), size = Vector(0.237, 0.237, 0.237), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Trigger"] = { type = "Model", model = "models/props_junk/meathook001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hold+", pos = Vector(0, 0.518, 0), angle = Angle(0, 0, -45.584), size = Vector(0.079, 0.079, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Barrel++"] = { type = "Model", model = "models/props_phx/construct/metal_wire_angle360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "Hinge", pos = Vector(1, -0.9, -4.5), angle = Angle(0, 0, 0), size = Vector(0.021, 0.021, 0.18), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} }
	}

	SWEP.HUD3DBone = "ValveBiped.Crossbow_base"
	SWEP.HUD3DPos = Vector(2, -0.65, -3.3)
	SWEP.HUD3DScale = 0.015
end

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("weapons/zs_sawnoff/sawnoff_fire1.ogg")
SWEP.Primary.Damage = 15
SWEP.Primary.NumShots = 11
SWEP.Primary.Delay = 0.6
SWEP.Primary.ClipSize = 2
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "buckshot"
SWEP.SecondaryConeMult = 2
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadSound = Sound("weapons/zs_sawnoff/barrelup.ogg")
SWEP.ReloadFinishSound = Sound("weapons/zs_sawnoff/barreldown.ogg")
SWEP.ReloadPlugSound = Sound("Weapon_Shotgun.Reload")

SWEP.ConeMax = 6.3
SWEP.ConeMin = 5.425
SWEP.Recoil = 7.5

SWEP.WalkSpeed = SPEED_SLOWER
SWEP.ReloadSpeed = 0.8
SWEP.ReloadDelay = 0.8

SWEP.Tier = 4

SWEP.DryFireSound = Sound("Weapon_Shotgun.Empty")

SWEP.Pierces = 4

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.07)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_BULLET_PIERCES, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Authority' Slug DB", "Single accurate slug round, less total damage", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 5.5
	wept.Primary.NumShots = 1
	wept.ConeMin = wept.ConeMin * 0.15
	wept.ConeMax = wept.ConeMax * 0.3
end)

SWEP.ReloadStartActivity = ACT_VM_RELOAD
SWEP.ReloadActivity = ACT_VM_HOLSTER

function SWEP:StartReloading()
	local delay = self:GetReloadDelay()
	self:SetDTFloat(3, CurTime() + delay)
	self:SetDTBool(2, true) -- force one shell load
	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, delay))

	self:GetOwner():DoReloadEvent()

	if self.ReloadStartActivity then
		self:SendWeaponAnim(self.ReloadStartActivity)
		self:ProcessReloadAnim()
		self:SetNextPlugSound(CurTime() + delay * 0.9)
		self:SetNextStateChange(CurTime() + delay * 0.8)
	end

	--self:EmitSound(self.ReloadSound)
end

function SWEP:StopReloading()
	self:SetDTFloat(3, 0)
	self:SetDTBool(2, false)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.45)
	self:SetNextStateChange(CurTime())

	if self:Clip1() > 0 then
		self:EmitSound(self.ReloadFinishSound)
		self:SendWeaponAnim(ACT_VM_IDLE)
		self:ProcessReloadAnim()
	end
end

function SWEP:Think()
	if self:ShouldDoReload() then
		self:DoReload()
	end

	if self:GetNextPlugSound() ~= 0 and CurTime() > self:GetNextPlugSound() then
		if self:Clip1() ~= 2 then
			self:EmitSound(self.ReloadPlugSound)
		end
		self:SetNextPlugSound(0)
	end

	if self:GetNextStateChange() ~= 0 and CurTime() > self:GetNextStateChange() then
		self:SetSawnoffState((self:GetSawnoffState() + 1) % 2)
		self:SetNextStateChange(0)
	end

	self:NextThink(CurTime())
	return true
end

function SWEP:DoReload()
	if not self:CanReload() then
		self:StopReloading()
		return
	end

	local delay = self:GetReloadDelay()
	if self.ReloadActivity then
		--self:SendWeaponAnim(self.ReloadActivity)
		--self:ProcessReloadAnim()
		self:SetNextPlugSound(CurTime() + delay * 0.9)

		timer.Simple(0, function() if IsValid(self) then self:SendWeaponAnim(ACT_VM_RELOAD) end end)
	end

	self:GetOwner():RemoveAmmo(1, self.Primary.Ammo, false)
	self:SetClip1(self:Clip1() + 1)

	self:SetDTBool(2, false)
	self:SetDTFloat(3, CurTime() + delay)

	self:SetNextPrimaryFire(CurTime() + math.max(self.Primary.Delay, delay))
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() or self:GetOwner():GetBarricadeGhosting() then return false end
	if self:Clip1() <= 0 then
		self:EmitSound("Weapon_Shotgun.Empty")
		self:SetNextPrimaryFire(CurTime() + 0.25)

		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:SecondaryAttack()
	if not self:CanPrimaryAttack() then return end
	local multiplier = self:Clip1()
	owner = self:GetOwner()

	self.Primary.NumShots = self.Primary.NumShots * multiplier
	self.RequiredClip = multiplier
	self.OldEmitFireSound = self.EmitFireSound
	self.EmitFireSound = self.EmitFireSoundDouble

	self:PrimaryAttack()

	self.Primary.NumShots = self.Primary.NumShots / multiplier
	self.RequiredClip = 1
	self.EmitFireSound = self.OldEmitFireSound

	--[[
	self.OldConeMax = self.ConeMax
	self.OldConeMin = self.ConeMin
	self.ConeMax = self.OldConeMax * self.SecondaryConeMult
	self.ConeMin = self.OldConeMin * self.SecondaryConeMult
	]]
end

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 80, math.random(97, 103), 1, CHAN_WEAPON + 20)
end

function SWEP:EmitFireSoundDouble()
	if self:Clip1() == 2 then
		self:EmitSound(self.Primary.Sound, 80, math.random(80, 85), 1, CHAN_WEAPON + 20)
	else
		self:OldEmitFireSound()
	end
end

function SWEP:GetNextPlugSound()
	return self:GetDTFloat(10)
end

function SWEP:SetNextPlugSound(nexttime)
	self:SetDTFloat(10, nexttime)
end

function SWEP:GetNextStateChange()
	return self:GetDTFloat(11)
end

function SWEP:SetNextStateChange(nexttime)
	self:SetDTFloat(11, nexttime)
end

function SWEP:GetSawnoffState()
	return self:GetDTInt(10)
end

function SWEP:SetSawnoffState(state)
	self:SetDTInt(10, state)
end

if CLIENT then
	function SWEP:PreDrawViewModel(vm)
		self.BaseClass.PreDrawViewModel(self, vm)

		local ang = self.VElements["Hinge"].angle
		ang.Pitch = math.Approach(ang.roll, self:GetSawnoffState() == 1 and 30 or 0, FrameTime() * 10000)
	end
end
