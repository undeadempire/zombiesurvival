AddCSLuaFile()

ENT.Base = "prop_gunturret"

ENT.SWEP = "weapon_zs_gunturret_modular"

ENT.AmmoType = ""
ENT.FireDelay = 0
ENT.NumShots = 0
ENT.Damage = 0
ENT.PlayLoopingShootSound = false
ENT.Spread = 5
ENT.SearchDistance = 225
ENT.MaxAmmo = 200

ENT.WeaponString = ""
ENT.WeaponpData = nil

if CLIENT then

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	local ent = ClientsideModel("models/weapons/w_shotgun.mdl")
	if ent:IsValid() then
		ent:SetParent(self)
		ent:SetOwner(self)
		ent:SetLocalPos(vector_origin)
		ent:SetLocalAngles(angle_zero)
		ent:Spawn()
		self.GunAttachment = ent
	end
end

function ENT:DrawTranslucent()
	local nodrawattachs = self:TransAlphaToMe() < 0.4

	local atch = self.GunAttachment
	if atch and atch:IsValid() then
		local ang = self:GetGunAngles()
		ang:RotateAroundAxis(ang:Up(), 180)

		atch:SetPos(self:ShootPos() + ang:Forward() * -8)
		atch:SetAngles(ang)

		atch:SetNoDraw(nodrawattachs or self:GetObjectOwner() == MySelf and self:GetManualControl())
	end

	self.BaseClass.DrawTranslucent(self)
end

function ENT:OnRemove()
	if self.GunAttachment and self.GunAttachment:IsValid() then
		self.GunAttachment:Remove()
	end

	--[[if self.WeaponString then
		local owner = self:GetObjectOwner()
		owner:Give(self.WeaponString)
	end]]

	--local owner = self:GetObjectOwner()
	--owner:GiveAmmo(1, "turret_modular")
	self.ScanningSound:Stop()
	self.ShootingSound:Stop()
end

end

function ENT:PlayShootSound()
	self:EmitSound("Weapon_Shotgun.NPC_Single")
end

function ENT:Use(activator, caller)
	if self.Removing or not activator:IsPlayer() or self:GetMaterial() ~= "" then return end

	if activator:Team() == TEAM_HUMAN then
		if self:GetObjectOwner():IsValid() then
			if activator:GetInfo("zs_nousetodeposit") == "0" then
				if self.WeaponString == "" then
					local pdataWep = activator:GetActiveWeapon()
					self.WeaponpData = pdataWep
					local pdataWepString = tostring(pdataWep)
					--print(pdataWep.Base)
					--if pdataWep.Base ~= "weapon_zs_baseshotgun" or "weapon_zs_base" then print("Incompatible") return end
					local stringWepStart = string.find(pdataWepString, "weapon_")
					local stringWep = string.sub(pdataWepString, stringWepStart, -2)
					self.WeaponString = stringWep
					self.AmmoType = pdataWep.Primary.Ammo 
					self.FireDelay = pdataWep.Primary.Delay
					self.Damage = pdataWep.Primary.Damage
					self.NumShots = pdataWep.Primary.NumShots

					local soundUnDecString = tostring(pdataWep.Primary.Sound)
					--print(soundUnDecString)
					--local soundDecStart = string.find(soundUnDecString, "(")
					--local soundDec = string.sub(soundDecStart, -2)
					self.FireSound = soundUnDecString
					
					function self:PlayShootSound()
						self:EmitSound(self.FireSound)
					end
					--stringWep:Spawn()
					activator:StripWeapon(stringWep)
					--print(stringWep)
					if CLIENT then
						local ent = ClientsideModel(pdataWep.WorldModel)
						if ent:IsValid() then
							ent:SetParent(self)
							ent:SetOwner(self)
							ent:SetLocalPos(vector_origin)
							ent:SetLocalAngles(angle_zero)
							ent:Spawn()
							self.GunAttachment = ent
							print("Model Attacher")
						end
					end
				else
					local curammo = self:GetAmmo()
					local togive = math.min(15, activator:GetAmmoCount(self.AmmoType), self.MaxAmmo - curammo)
					if togive > 0 then
						self:SetAmmo(curammo + togive)
						activator:RemoveAmmo(togive, self.AmmoType)
						activator:RestartGesture(ACT_GMOD_GESTURE_ITEM_GIVE)
						self:EmitSound("npc/turret_floor/click1.wav")
						--gamemode.Call("PlayerRepairedObject", activator, self, togive * 1.5, self)
					end
				end
			end
		else
			self:SetObjectOwner(activator)
			self:GetObjectOwner():SendDeployableClaimedMessage(self)
			if not activator:HasWeapon("weapon_zs_gunturretcontrol") then
				activator:Give("weapon_zs_gunturretcontrol")
			end
		end
	end
end
