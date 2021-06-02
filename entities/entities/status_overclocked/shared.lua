AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

AccessorFuncDT(ENT, "Duration", "Float", 0)
AccessorFuncDT(ENT, "StartTime", "Float", 4)

function ENT:PlayerSet()
	self:SetStartTime(CurTime())
end

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	if SERVER then
		hook.Add("HumanKilledZombie", self, self.HumanKilledZombie)
		--Stack Count
		self:SetDTInt(1, 0)
		--Current Reload Speed
		self:SetDTFloat(1, 0)
		--Think loop breaker
		self:SetDTBool(1, false)
		--Default reload speed
		self:SetDTFloat(2, 0)
		--Holstering Override
		self:SetDTBool(2, false)
		--Weapon to Switch To
		--self:SetDTString(1, "")
	end
end

--[[function ENT:ForceSelectWeapon(wep)
	CUserCmd:SelectWeapon(wep)
end]]