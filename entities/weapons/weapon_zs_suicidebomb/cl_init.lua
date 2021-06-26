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
function SWEP:PrimaryAttack()
	--if ( !self:CanPrimaryAttack() ) then return end
	self.BaseClass.ShootEffects (self);
	self:SendWeaponAnim( ACT_GMOD_TAUNT_SALUTE )
	local explode = ents.Create( "env_explosion" )
	explode:SetPos( self.Owner:GetPos() )
	explode:SetOwner( self.Owner )
	explode:Spawn()
	explode:SetKeyValue( "iMagnitude", "340" )
	explode:Fire( "Explode", 0, 0 )
	explode:EmitSound( "weapon_AWP.Single", 800, 800 )
	if self.Owner:Alive() then
	self.Owner:Kill()
	end
end