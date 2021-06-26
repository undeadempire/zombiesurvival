INC_CLIENT()

SWEP.DrawCrosshair = false

SWEP.Slot = 4
SWEP.SlotPos = 0

function SWEP:Initialize()
	self:SetHoldType( "slam" )
	self:SendWeaponAnim( ACT_GMOD_IN_CHAT )
end
function SWEP:Think()
	self:SendWeaponAnim( ACT_GMOD_IN_CHAT)
end
function SWEP:Reload()
	self.Owner:DropWeapon(self.Owner:GetActiveWeapon())
end
