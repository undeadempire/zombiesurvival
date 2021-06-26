AddCSLuaFile()

SWEP.PrintName = "Suicide Bomb"
SWEP.Description = "A pack of explosives that can be detonated killing yourself and zeds around you."
SWEP.Slot = 4
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFOV = 50
	SWEP.BobScale = 0.5
	SWEP.SwayScale = 0.5
end

SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = Model("models/weapons/w_c4_planted.mdl")
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
Swep.Primary.Delay = 1.5

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.WalkSpeed = SPEED_NORMAL

SWEP.NoMagazine = true
SWEP.Undroppable = true
SWEP.NoPickupNotification = true

SWEP.HoldType = "slam"

SWEP.NoDeploySpeedChange = true

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