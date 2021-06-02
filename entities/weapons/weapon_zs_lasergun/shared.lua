if ( SERVER ) then

AddCSLuaFile( "shared.lua" )

SWEP.HoldType = "ar2"

end

if ( CLIENT ) then
SWEP.PrintName = "Laser Minigun"
SWEP.Description = "A consumble high damage minigun holding 200 bullets. "
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.IconLetter = "b"

SWEP.ViewModelFlip		= false

killicon.AddFont("cse_deagle","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))

end

SWEP.DrawCrosshair = true
SWEP.DrawAmmo = true

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel			= "models/weapons/v_mach_m248para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m248para.mdl"

SWEP.Weight = 1
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false


SWEP.Primary.Recoil = 4
SWEP.Primary.Damage =100
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = 200
SWEP.Primary.Delay = 0.30
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "dummy"
SWEP.RequiredClip = 1

SWEP.Secondary.Recoil = 0.1
SWEP.Secondary.Damage = 100
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Cone = 0.0
SWEP.Secondary.ClipSize = 500
SWEP.Secondary.Delay = 0.01
SWEP.Secondary.DefaultClip = 200
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "pistol"


function SWEP:PrimaryAttack()


if ( !self:CanPrimaryAttack() ) then return end

self.Weapon:EmitSound(Sound("weapons/blaster.wav"))

self:ShootBullet( 0, 0, 0 )

self:TakePrimaryAmmo( 1 )

self.Owner:ViewPunch( Angle( 0, 0, 0 ) )
self.Weapon:SetNextPrimaryFire( CurTime() + 0.15 )

local trace = self.Owner:GetEyeTrace()
local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetNormal( trace.HitNormal )
effectdata:SetEntity( trace.Entity )
effectdata:SetAttachment( trace.PhysicsBone )
util.Effect( "super_explosion", effectdata )

local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetStart( self.Owner:GetShootPos() )
effectdata:SetAttachment( 1 )
effectdata:SetEntity( self.Weapon )
util.Effect( "ToolTracer", effectdata )
if (SERVER) then
local owner=self.Owner
if self.Owner.SENT then
owner=self.Owner.SENT.Entity
end

local explosion = ents.Create( "env_explosion" )
explosion:SetPos(trace.HitPos)
explosion:SetKeyValue( "iMagnitude" , "100" )
explosion:SetPhysicsAttacker(owner)
explosion:SetOwner(owner)
explosion:Spawn()
explosion:Fire("explode","",0)
explosion:Fire("kill","",0 )

end
end

function SWEP:SecondaryAttack()


if ( !self:CanPrimaryAttack() ) then return end

self.Weapon:EmitSound(Sound("weapons/ar2/fire1.wav"))

self:ShootBullet( 0, 0, 0 )

self:TakePrimaryAmmo( 1 )

self.Owner:ViewPunch( Angle( 0, 0, 0 ) )
self.Weapon:SetNextPrimaryFire( CurTime() + 0.01 )

local trace = self.Owner:GetEyeTrace()
local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetNormal( trace.HitNormal )
effectdata:SetEntity( trace.Entity )
effectdata:SetAttachment( trace.PhysicsBone )
util.Effect( "", effectdata )

local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetStart( self.Owner:GetShootPos() )
effectdata:SetAttachment( 1 )
effectdata:SetEntity( self.Weapon )
util.Effect( "", effectdata )
if (SERVER) then
local owner=self.Owner
if self.Owner.SENT then
owner=self.Owner.SENT.Entity
end

local explosion = ents.Create( "env_explosion" )
explosion:SetPos(trace.HitPos)
explosion:SetKeyValue( "iMagnitude" , "100" )
explosion:SetPhysicsAttacker(owner)
explosion:SetOwner(owner)
explosion:Spawn()
explosion:Fire("explode","",0)
explosion:Fire("kill","",0 )

end
end