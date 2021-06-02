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
		--Current Reload Speed
		--self:SetDTFloat(1, 0)
		--Current Swing Speed
		--self:SetDTFloat(2, 0)
		--Think Loop Breaker
		self:SetDTBool(1, false)
		--Weapon name
		--self:SetDTString(1, "nil")
	end 
end

