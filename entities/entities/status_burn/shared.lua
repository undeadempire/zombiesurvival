AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

ENT.Ephemeral = true

AccessorFuncDT(ENT, "Duration", "Float", 0)
AccessorFuncDT(ENT, "StartTime", "Float", 4)

function ENT:Initialize()
	self:DrawShadow(false)
	if self:GetDTFloat(1) == 0 then
		self:SetDTFloat(1, CurTime())
	end
	if not self:GetDTBool(0) then
		--Think Breaker
		self:SetDTBool(0, false)
	end
	--self:SetDTFloat(0, self.Damage)
	self.Receiver = self:GetOwner()
end

function ENT:AddDamage(damage)
	self:SetDamage(self:GetDamage() + damage)
end

function ENT:SetDamage(damage)
	self:SetDTFloat(0, damage)--math.min(50, damage))
end

function ENT:GetDamage()
	return self:GetDTFloat(0)
end
