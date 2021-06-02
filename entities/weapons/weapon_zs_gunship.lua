//Gunship Cannon by Hds46.
if ( SERVER ) then
	AddCSLuaFile()
end

SWEP.Base = "weapon_zs_base"

SWEP.DrawCrosshair = false
SWEP.Weight = 5
SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.HoldType = "pistol"
SWEP.AnimPrefix		= "ar2"
SWEP.ViewModelFOV = 74
SWEP.Slot = 2
SWEP.Purpose = "Gunship Cannon by Hds46"
SWEP.AutoSwitchTo = true
SWEP.Contact = "ermolaaleksey@yandex.ru"
SWEP.Author = "Hds46"
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.AdminOnly			= false
SWEP.SlotPos = 1
SWEP.AutoSwitchFrom = false
SWEP.Base = "weapon_base"
SWEP.Category = "HL2"
SWEP.DrawAmmo = true
SWEP.PrintName = "Gunship Cannon"
SWEP.BounceWeaponIcon   = false
SWEP.IconLetter  = "x"
if game.SinglePlayer() then
SWEP.Primary.ClipSize			= 200
SWEP.Primary.DefaultClip			= 200
else
SWEP.Primary.ClipSize			= 200
SWEP.Primary.DefaultClip			= 200
end
SWEP.Primary.Sound = "npc/combine_gunship/gunship_weapon_fire_loop6.wav"
SWEP.Primary.AttackStopSound = "npc/combine_gunship/attack_stop2.wav"
------------------------------------
-- Unused
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Recoil				= 10
SWEP.Primary.Spread =  0.1
SWEP.Primary.Damage				= 140
------------------------------------
SWEP.UseHands = true


SWEP.Primary.NumberofShots =  7 
SWEP.Primary.Delay =  0.05
SWEP.Primary.Force =  25000
SWEP.Primary.Automatic   		= true
SWEP.Primary.Ammo         		= "ar2"



SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.ViewModelDefPos = Vector (0, 0, 0)
SWEP.ViewModelDefAng = Vector (0, 0, 0)
SWEP.ShowWorldModel = true
SWEP.ShowViewModel = false


list.Add( "NPCUsableWeapons", { class = "swep_gunship",	title = "Gunship Cannon" }  )
local csh = Material("Sprites/Hud/v_crosshair1")


SWEP.VElements = {
	["reference_gun"] = { type = "Model", model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.595, -3.2, -0.805), angle = Angle(-1.305, 6.078, 0), size = Vector(0.465, 0.488, 0.465), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/gibs/gunship_gibs_nosegun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.112, -2.441, -1.854), angle = Angle(-7.496, -0.908, 0), size = Vector(0.519, 0.519, 0.538), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


if CLIENT then
killicon.Add(  "swep_gunship","Hds46/swep_gunship_icon", Color( 255, 255, 255, 255 ))
language.Add( "AirboatGun_ammo", "Gunship Cannon Ammo" )
SWEP.WepSelectIcon      = Material("Hds46/gunship_cannon_icon.png")
SWEP.BounceWeaponIcon   = false
local AmmoDisplay = {}
function SWEP:CustomAmmoDisplay()
                                

		AmmoDisplay.Draw = true
		AmmoDisplay.PrimaryClip = self.Weapon:Clip1()
		AmmoDisplay.PrimaryAmmo = -1
		AmmoDisplay.SecondaryClip = -1
		AmmoDisplay.SecondaryAmmo = -1

		return AmmoDisplay

end
end

if SERVER then
AccessorFunc( SWEP, "fNPCMinBurst", "NPCMinBurst" )
AccessorFunc( SWEP, "fNPCMaxBurst", "NPCMaxBurst" )
AccessorFunc( SWEP, "fNPCFireRate", "NPCFireRate" )
AccessorFunc( SWEP, "fNPCMinRestTime", "NPCMinRest" )
AccessorFunc( SWEP, "fNPCMaxRestTime", "NPCMaxRest" )
util.AddNetworkString( "GunMuzzle" )
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	surface.SetDrawColor(255, 255, 255, alpha)
	surface.SetMaterial( self.WepSelectIcon )
	
	local fsin = 0
	
	if (self.BounceWeaponIcon == true) then
		fsin = math.sin(CurTime() * 10) * 5
	end
	
	// Borders
	//y = y + 25
	//x = x + 25
	wide = wide - 45
	
    surface.DrawTexturedRect( x + 20, y , 224, 125 )
	
    self:PrintWeaponInfo(x + wide + 20, y + tall * 0.95, alpha)
end

function SWEP:OnRestore()
    util.PrecacheSound( "npc/combine_gunship/gunship_weapon_fire_loop6.wav")
    util.PrecacheSound( "npc/combine_gunship/attack_stop2.wav" )
	if SERVER then
	self:SetNPCFireRate( 0.1 )
	self:SetNPCMinBurst( 3 )
	self:SetNPCMaxBurst( 10 )
	self:SetNPCFireRate( 0.1 )
	self:SetNPCMinRest( 0.5 )
	self:SetNPCMaxRest( 2 )
	end
	self.Cooldown = 0
	self.BeamCooldown = 0
end

function SWEP:Initialize() //Tells the script what to do when the player "Initializes" the SWEP.
    util.PrecacheSound( "npc/combine_gunship/gunship_weapon_fire_loop6.wav")
    util.PrecacheSound( "npc/combine_gunship/attack_stop2.wav" )
	self:SetWeaponHoldType( self.HoldType )
	if SERVER then
	self:SetNPCFireRate( 0.1 )
	self:SetNPCMinBurst( 3 )
	self:SetNPCMaxBurst( 10 )
	self:SetNPCFireRate( 0.1 )
	self:SetNPCMinRest( 0.5 )
	self:SetNPCMaxRest( 2 )
	end
	
	self.Cooldown = 0
	
	self.BeamCooldown = 0
	
	if IsValid(self.Owner) and self.Owner:IsNPC() and SERVER and !string.find(self.Owner:GetClass(),"npc_combine_s") and !string.find(self.Owner:GetClass(),"npc_metropolice") then
	for k,v in pairs(ents.GetAll()) do
	if IsValid(v) and v:IsNPC() then
	if string.find(v:GetClass(),"npc_helicopter") or string.find(v:GetClass(),"npc_combinegunship") or string.find(v:GetClass(),"npc_combinedropship") or string.find(v:GetClass(),"prop_vehicle_apc") then
	self.Owner:AddEntityRelationship(v,1,99)
	end
	end
	end
	end
	
	// other initialize code goes here

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) and self.Owner:IsPlayer() then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
				end
			end
		end
		
	end
end

function SWEP:DamageChance(chance,chancenum)
        for i=1,chancenum do
		if chance == i then return chance end
		end
end

function SWEP:NPCClassify(name,trace,dmginfo)
if string.find(trace.Entity:GetClass(),name) then return true end
end

if CLIENT then
net.Receive( "GunMuzzle", function()
	local gun = net.ReadEntity()
	if ( IsValid(gun) && gun:IsCarriedByLocalPlayer() && LocalPlayer():ShouldDrawLocalPlayer() ) then
	local eff = EffectData()
    eff:SetOrigin(gun:GetPos())
    eff:SetStart(gun:GetPos())
    eff:SetEntity(gun)
    eff:SetAttachment(1)
    eff:SetScale(20)
    eff:SetRadius(20)
    eff:SetMagnitude(20)
    util.Effect("AirboatMuzzleFlash",eff)
	end
end)
end

function SWEP:NPCShoot_Primary( pos, dir )
	if !( IsValid( self.Owner ) ) then return end
	if !( self.Cooldown < CurTime() ) then return end
	if self.Owner:IsPlayer() then return end
	
	self.Cooldown = CurTime() + 5
	timer.Create("npc_attack" .. self.Owner:EntIndex(),0.1,50,function()
	if IsValid(self) and IsValid(self.Owner) and self.Owner:IsNPC() then
	if !IsValid(self.Owner:GetEnemy()) then
	timer.Remove("npc_attack" .. self.Owner:EntIndex())
	timer.Remove("npc_attack_stop" .. self.Owner:EntIndex())
	if ( self.ShootLoop ) then 
	self.ShootLoop:ChangeVolume( 0, 0.02 ) 
	self.ShootLoop:Stop() 
	self.ShootLoop = nil
	end
	self.Cooldown = CurTime() + 0.5
	return
	end
	if IsValid(self.Owner:GetEnemy()) then
	local trace = {}
    trace.start = self.Owner:GetShootPos()
    trace.endpos = self.Owner:GetEnemy():GetPos() + Vector(0,0,self.Owner:GetEnemy():OBBMaxs().z/(( self.Owner:GetEnemy():GetClass()=="npc_hunter" ) and 1.5 or (self.Owner:GetEnemy():GetClass()=="npc_headcrab_black" ) and 6 or (self.Owner:GetEnemy():GetClass()=="npc_combinedropship" ) and 0.36 or 2))
    trace.filter = {self.Owner}
    local traceworld = util.TraceLine(trace)
    if traceworld.Entity != self.Owner:GetEnemy() then
    timer.Remove("npc_attack" .. self.Owner:EntIndex())
	timer.Remove("npc_attack_stop" .. self.Owner:EntIndex())
	if ( self.ShootLoop ) then 
	self.ShootLoop:ChangeVolume( 0, 0.02 ) 
	self.ShootLoop:Stop() 
	self.ShootLoop = nil
	end
	self.Cooldown = CurTime() + 0.5
	return
	end
	end
	self:PrimaryAttack()
	end
	end)
	timer.Create("npc_attack_stop" .. self.Owner:EntIndex(),5,1,function()
    if IsValid(self) and IsValid(self.Owner) and self.Owner:IsNPC() then
	if ( self.ShootLoop ) then
    self.ShootLoop:ChangeVolume( 0, 0.02 ) 
	self.ShootLoop:Stop() 
	self.ShootLoop = nil
	end
	end
	end)
end
   
function SWEP:PrimaryAttack()
   if ( !self:CanPrimaryAttack() ) then return end
    if !self.Owner:IsNPC() then
    tr = self.Owner:GetEyeTrace()
	end
    if !self.ShootLoop and SERVER then
    self.ShootLoop = CreateSound(self.Owner,Sound(self.Primary.Sound))
    self.ShootLoop:Play()
    end
	local bullet = {}
	bullet.Attacker 	= self.Owner	
    bullet.Num 			= 1
	bullet.Force		= 20
    bullet.Callback = function(attacker, trace, dmginfo)
	if IsValid(trace.Entity) and trace.Entity and SERVER then
	if self:NPCClassify("npc_combinegunship",trace) then
	local rand = math.random(1,100)
	if self:DamageChance(rand,15) then
	dmginfo:SetDamageType(DMG_BLAST)
	dmginfo:SetDamage(50)
	end
	elseif self:NPCClassify("npc_strider",trace) then
	local rand = math.random(1,100)
	if self:DamageChance(rand,20) then
	dmginfo:SetDamageType(DMG_BLAST)
	dmginfo:SetDamage(30)
	trace.Entity:SetHealth(trace.Entity:Health() + math.random(8,14))
	end
	elseif self:NPCClassify("npc_helicopter",trace) then
	dmginfo:SetDamageType(DMG_AIRBOAT)
	dmginfo:SetDamage(20)
	elseif self:NPCClassify("prop_vehicle_apc",trace) then
	local rand = math.random(1,100)
	dmginfo:SetDamageType(DMG_AIRBOAT)
	dmginfo:SetDamage(10)
	elseif self:NPCClassify("npc_rollermine",trace) then
	local rand = math.random(1,100)
	if self:DamageChance(rand,100) then
	if trace.Entity.HitNum == nil then
	trace.Entity.HitNum = 0
	end
    trace.Entity.HitNum = trace.Entity.HitNum + 1
	if trace.Entity.HitNum >= 8 and !trace.Entity.Destroyed then
	trace.Entity.Destroyed = true
	dmginfo:SetDamageType(DMG_BLAST)
	dmginfo:SetDamage(30)
	end
	end
	dmginfo:SetDamageForce(dmginfo:GetDamageForce()/100)
	elseif self:NPCClassify("npc_turret_floor",trace) then
	local rand = math.random(1,100)
	if self:DamageChance(rand,100) then
	if trace.Entity.HitNum == nil then
	trace.Entity.HitNum = 0
	end
    trace.Entity.HitNum = trace.Entity.HitNum + 1
	if trace.Entity.HitNum >= 20 and !trace.Entity.Destroyed then
	trace.Entity.Destroyed = true
	trace.Entity:Fire("SelfDestruct","",0)
	end
	end
	dmginfo:SetDamageForce(dmginfo:GetDamageForce()*0.058)
	elseif self:NPCClassify("npc_manhack",trace) then
	dmginfo:SetDamageForce(dmginfo:GetDamageForce()*0.3)
	elseif self:NPCClassify("npc_combinedropship",trace) then
	local rand = math.random(1,100)
	if self:DamageChance(rand,5) then
	local explosion = ents.Create("env_explosion")
    explosion:SetPos(trace.HitPos)
    explosion:Spawn()
    explosion:SetKeyValue( "iMagnitude", 100 )
    explosion:SetKeyValue( "iRadiusOverride", 250 )  
    explosion:Fire( "Explode", 0, 0 )
	explosion:Fire( "kill", 0, 10 )
	end
	if self:DamageChance(rand,100) then
	if trace.Entity.HitNum == nil then
	trace.Entity.HitNum = 0
	end
    trace.Entity.HitNum = trace.Entity.HitNum + 1
	if trace.Entity.HitNum >= 30 and !trace.Entity.Destroyed then
	trace.Entity.Destroyed = true
	local rag = ents.Create("prop_ragdoll")
    rag:SetModel(trace.Entity:GetModel())
    rag:SetPos(trace.Entity:GetPos())
    rag:Spawn()
	rag:Fire(  "FadeAndRemove", "", 20 )
	rag:EmitSound(Sound("ambient/explosions/explode_2.wav"))
	for i=1,10 do
    local vec = Vector(math.random()*50-25, math.random()*50-25, math.random()*5+0):GetNormal()
    local explosion = ents.Create("env_explosion")
    explosion:SetPos(rag:GetPos() + (vec * 200))
    explosion:Spawn()
    explosion:SetKeyValue( "iMagnitude", 100 )
    explosion:SetKeyValue( "iRadiusOverride", 250 )  
    explosion:Fire( "Explode", 0, 0 )
	explosion:Fire( "kill", 0, 10 )
    end
	local smokeimpact = ents.Create("ar2explosion")
    smokeimpact:SetPos(rag:GetPos())
    smokeimpact:SetAngles(rag:GetAngles())
    smokeimpact:Spawn()
    smokeimpact:Activate()
    smokeimpact:Fire("kill","",10)
    local shake = ents.Create( "env_shake" )
	shake:SetPos( rag:GetPos() )
	shake:SetKeyValue( "amplitude", "2000" )
	shake:SetKeyValue( "radius", "2000" )
	shake:SetKeyValue( "duration", "3" )
	shake:SetKeyValue( "frequency", "255" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "kill", 0, 10 )
	rag:GetPhysicsObject():SetMass(500)
    for i = 0, rag:GetPhysicsObjectCount( ) do
    local physobj = rag:GetPhysicsObjectNum( i )
    if (physobj) and IsValid(physobj)then
    local pos, ang = trace.Entity:GetBonePosition( trace.Entity:TranslatePhysBoneToBone( i ) )
    physobj:SetPos(pos)
    physobj:SetAngles(ang)
    physobj:EnableMotion(true)
	physobj:SetVelocity((trace.Entity:GetPos() - self.Owner:GetPos())*20)
    end
    end
	for i=1,math.random(10,20) do
	timer.Simple(i - (i*math.Rand(0.25,0.85)),function()
	if IsValid(rag) then
	if SERVER then
    local vec = Vector(math.random()*50-25, math.random()*50-25, math.random()*5+0):GetNormal()
    local expefffect = ents.Create("env_explosion")
    expefffect:SetPos(rag:GetPos() + (vec * 200))
    expefffect:Spawn()
    expefffect:SetKeyValue( "iMagnitude", 0 )
    expefffect:SetKeyValue( "iRadiusOverride", 0 )  
    expefffect:Fire( "Explode", 0, 0 )
    util.ScreenShake(expefffect:GetPos(), 100, 10, 5, 356)
    util.BlastDamage(expefffect, expefffect, expefffect:GetPos(), 250, 100)
    end
	end
	end)
	end
	trace.Entity:Remove()
	end
	end
	end
	end
	local traceeffect = EffectData()
    traceeffect:SetOrigin(trace.HitPos)
    traceeffect:SetNormal(trace.HitNormal)
    util.Effect("AR2Impact", traceeffect)
    end
	bullet.Src 			= self.Owner:GetShootPos()
	bullet.Dir 			= self.Owner:GetAimVector()
	bullet.Spread 		= Vector(0.01,0.01,0)
	bullet.Tracer		= 1
	bullet.TracerName 	= "AirboatGunHeavyTracer"
	bullet.Damage		=  60
            			
	self.Weapon:FireBullets( bullet )
	
	local rnda = 0.1 * -1 
	local rndb = 0.1 * math.random(-1, 1) 
	
	if self.Owner:IsPlayer() then
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) ) 
	end
	
	if self.Owner:IsPlayer() then
	local distancerockets = self.Owner:GetShootPos():Distance(tr.HitPos)
	
	local rand = math.random(1,100)
	
	for i=1, distancerockets, 32 do
	for k,v in pairs(ents.FindInSphere(self.Owner:GetPos() + (self.Owner:GetForward() * i),64)) do
	if (v:GetClass() == "apc_missile" or v:GetClass() == "rpg_missile") and self:DamageChance(rand,20) and !v.Destroyed then
	v:SetHealth(0)
	v.Destroyed = true
	local bulletin = {
	Num = 1,
	Src = v:GetPos(),
	Dir = Vector(0,0,0),
	Spread = Vector(0,0,0),
	Tracer = 0,
	Force = 1,
	Damage = 100
	}
    self.Weapon:FireBullets(bulletin)
	end
	end
	end
	end
	
	if SERVER then
    net.Start( "GunMuzzle" )
    net.WriteEntity( self )
    net.Broadcast()	
    end
	
	if !self.Owner:IsPlayer() then
	local eff = EffectData()
    eff:SetOrigin(self:GetPos())
    eff:SetStart(self:GetPos())
    eff:SetEntity(self)
    eff:SetAttachment(1)
    eff:SetScale(20)
    eff:SetRadius(20)
    eff:SetMagnitude(20)
    util.Effect("AirboatMuzzleFlash",eff)
	end
	
	if !self.Owner:IsNPC() and SERVER then
    util.ScreenShake( self.Owner:GetPos(), ( self.Owner:KeyDown(IN_DUCK) ) and 2 or 5, 2, 1.5, 50 )
	end
 
    if self.Owner:IsPlayer()  then
    self:TakePrimaryAmmo(1) 
	end
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self:SetNextPrimaryFire( CurTime() + 0.1 )
end

function SWEP:SecondaryAttack()
if !( self:GetNextPrimaryFire() < CurTime() ) then return end
if !( self.BeamCooldown < CurTime() ) then return end
if !( self:Clip1() >= 100) then if SERVER then self.Owner:SendLua("surface.PlaySound('weapons/pistol/pistol_empty.wav')") self:SetNextPrimaryFire( CurTime() + 1 ) return end end
if (CLIENT and !game.SinglePlayer()) then return end
	self:SetNextPrimaryFire( CurTime() + 1 )
	local playertrace = self.Owner:GetEyeTrace()
	local trace = {}
    trace.start = playertrace.HitPos
    trace.endpos = trace.start + Vector(0,0,80000)
    trace.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworld = util.TraceLine(trace)
    if traceworld.HitSky then
    self.BeamCooldown = CurTime() + 3
	self:TakePrimaryAmmo(10) 
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:EmitSound(Sound("weapons/mortar/mortar_fire1.wav"))
	local Ang = self.Owner:GetAngles()
    Ang.pitch = 0
    Ang.roll = Ang.roll
    Ang.yaw = Ang.yaw - 180
	local ent
	timer.Simple(0.5,function()
	local pos
	local tracesensor = {}
    tracesensor.start = playertrace.HitPos
    tracesensor.endpos = tracesensor.start + Vector(0,0,4200)
    tracesensor.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldsensor = util.TraceLine(tracesensor)
    if traceworldsensor.HitSky then
	pos = traceworldsensor.HitPos - Vector(0,0,40)
	else
	pos = playertrace.HitPos + Vector(0,0,4000)
	end
	ent = ents.Create("prop_dynamic")
	ent:SetPos(pos)
	ent:SetAngles(Ang)
	ent:SetModel("models/gibs/gunship_gibs_sensorarray.mdl")
	ent:Spawn()
	ent:Activate()
	ent:Fire("kill","",8)
	ent.IsSensor = true
	if IsValid(self) and IsValid(self.Owner) then
	ent.Caller = self.Owner
	else
	ent.Caller = game:GetWorld()
	end
	ent.BeamDamageCooldown = 0
	timer.Create("angleupdate" .. ent:EntIndex(),0.01,0,function()
	if IsValid(ent) then
	local ang = ent:GetAngles()
    ang.pitch = ang.pitch
    ang.roll = ang.roll
    ang.yaw = ang.yaw + 1
    ent:SetAngles(ang)
	end
	end)
	timer.Simple(4.5,function() 
	if IsValid(ent) then
	timer.Create("sensorfade" .. ent:EntIndex(),0.01,255/4,function()
    if IsValid(ent) then
    if ent:GetColor().a > 0 then
    alpha = ent:GetColor().a
    alpha = alpha - 4
    ent:SetRenderMode( 4 )
    ent:SetColor( Color( 255, 255, 255, alpha ) )
    elseif ent:GetColor().a <= 0 then
    timer.Remove("invisstart" .. ent:EntIndex())
    end
    end
    end)
	end
	end)
	end)
	timer.Simple(1,function()
	if SERVER then
	if IsValid(ent) then
	if game.SinglePlayer() then
	ent:EmitSound(Sound("NPC_Strider.Charge"))
	else
	ent:EmitSound(Sound("npc/strider/charging.wav",SNDLVL_NONE,100,1,CHAN_STATIC))
	end
	ent.BeamTurnedOn = true
	end
	local tracebeam = {}
    tracebeam.start = trace.start
    tracebeam.endpos = trace.start - Vector(0,0,90000)
    tracebeam.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworldbeam = util.TraceLine(tracebeam)
	if traceworldbeam.Hit then
	if IsValid(ent) then
	local LaserBeam = EffectData()
	LaserBeam:SetStart(ent:GetPos())
	LaserBeam:SetOrigin(traceworldbeam.HitPos)
	util.Effect("gunship_bellycannon_beam",LaserBeam)
	end
	local LaserParticle = EffectData()
	LaserParticle:SetOrigin(traceworldbeam.HitPos)
	LaserParticle:SetNormal(traceworldbeam.HitNormal)
	util.Effect("gunship_bellycannon_particle",LaserParticle)
	local shake = ents.Create( "env_shake" )
	shake:SetPos( traceworldbeam.HitPos )
	shake:SetKeyValue( "amplitude", "5" )
	shake:SetKeyValue( "radius", "250" )
	shake:SetKeyValue( "duration", "3" )
	shake:SetKeyValue( "frequency", "255" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "StartShake", "", 0.5 )
	shake:Fire( "StartShake", "", 1 )
	shake:Fire( "StartShake", "", 1.5 )
	shake:Fire( "StartShake", "", 2 )
	shake:Fire( "StartShake", "", 2.5 )
	shake:Fire( "StartShake", "", 3 )
	shake:Fire( "kill", 0, 10 )
	end
	end
	end)
	timer.Simple(3,function()
	local trace2 = {}
    trace2.start = trace.start
    trace2.endpos = trace.start - Vector(0,0,90000)
    trace2.filter = function(ent) if !ent:IsWorld() then return false end end
    local traceworld2 = util.TraceLine(trace2)
	if traceworld2.Hit then
	local pt = EffectData()
	pt:SetOrigin(traceworld2.HitPos)
    pt:SetNormal(traceworld2.HitNormal)
	pt:SetScale(210)
	pt:SetRadius(210)
	pt:SetMagnitude(210)
	util.Effect("AR2Explosion",pt)
	local traceworlddecal = {}
    traceworlddecal.start = traceworld2.HitPos + Vector(0,0,5)
    traceworlddecal.endpos = traceworlddecal.start - (Vector(0,0,1)*50) 
    traceworlddecal.mask = MASK_SOLID_BRUSHONLY
    local trw = util.TraceLine(traceworlddecal)
    local worldpos1 = trw.HitPos + trw.HitNormal
    local worldpos2 = trw.HitPos - trw.HitNormal
	util.Decal("Scorch",worldpos1,worldpos2)
	if SERVER then
	if IsValid(ent) then
	ent.BeamTurnedOn = false
	end
	local smokeimpact = ents.Create("ar2explosion")
	smokeimpact:SetPos(traceworld2.HitPos)
	smokeimpact:Spawn()
	smokeimpact:Activate()
	smokeimpact:Fire("kill","",15)
	smokeimpact:EmitSound(Sound("NPC_Strider.Shoot"))
	local shake = ents.Create( "env_shake" )
	shake:SetPos( traceworld2.HitPos )
	shake:SetKeyValue( "amplitude", "900" )
	shake:SetKeyValue( "radius", "700" )
	shake:SetKeyValue( "duration", "3" )
	shake:SetKeyValue( "frequency", "255" )
	shake:SetKeyValue( "spawnflags", "4" )
	shake:Spawn()
	shake:Activate()
	shake:Fire( "StartShake", "", 0 )
	shake:Fire( "kill", 0, 10 )
	for k,v in pairs(ents.FindInSphere(traceworld2.HitPos,400)) do
	if IsValid(v) then
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(math.Clamp((400 - (traceworld2.HitPos - v:GetPos()):Length()/1.15),40,400))
	if v:GetClass()=="prop_vehicle_apc" then
	dmginfo:SetDamage(math.Clamp((600 - (traceworld2.HitPos - v:GetPos()):Length()/1.15),40,600))
	end
    dmginfo:SetDamageType((((v:GetClass()=="npc_gman" or v:GetClass()=="npc_mossman" or v:GetClass()=="npc_alyx" or v:GetClass()=="npc_barney" or v:GetClass()=="npc_monk") and DMG_GENERIC) or ((v:GetClass()=="prop_vehicle_apc") and DMG_AIRBOAT) or bit.bor(DMG_DISSOLVE,DMG_BLAST)) )
	if IsValid(self) and IsValid(self.Owner) then
    dmginfo:SetAttacker( self.Owner )
	else
	dmginfo:SetAttacker( game.GetWorld() )
	end
	if v:IsPlayer() or v:IsNPC() then
    dmginfo:SetDamageForce((traceworld2.HitPos - v:GetPos())*((!GetConVar("ai_serverragdolls"):GetBool()) and -200 or -100) + Vector(0,0,((!GetConVar("ai_serverragdolls"):GetBool()) and 1000 or 4*4000)))
	else
	if IsValid(v:GetPhysicsObject()) then
	for key, prop in pairs(ents.FindInSphere(traceworld2.HitPos,300)) do
		if IsValid(prop:GetPhysicsObject()) then
			if (math.random(1, 100) < 20) then
			prop:Fire("enablemotion", "", 0)
			constraint.RemoveAll(prop)
			end
		end
	end
	timer.Simple(0.02,function()
	if IsValid(v) and IsValid(v:GetPhysicsObject()) then
	v:GetPhysicsObject():ApplyForceCenter((traceworld2.HitPos - v:GetPos())*-5000)
	end
	end)
	end
	end
	if IsValid(self) then
    dmginfo:SetInflictor( self )
	else
	dmginfo:SetInflictor( game.GetWorld() )
	end
	v:TakeDamageInfo( dmginfo )
	end
	end
	end
	end
	end)
    else
    self.BeamCooldown = CurTime() + 1
	self.Owner:SendLua("surface.PlaySound('buttons/combine_button1.wav')")
    end
end

function SWEP:Holster()
    if ( self.ShootLoop ) and SERVER then 
	self.ShootLoop:ChangeVolume( 0, 0.02 ) 
	self.ShootLoop:Stop() 
	self.ShootLoop = nil
	end
	if IsValid(self) and IsValid(self.Owner) and self.Owner:IsPlayer() and IsValid(self.Owner:GetViewModel()) then
	self.Owner:GetViewModel():SetMaterial("")
	end
	self:SetMaterial("")
	if CLIENT and IsValid(self.Owner) and self.Owner:IsPlayer() and IsValid(self.Owner:GetViewModel()) then
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		self:ResetBonePositions(vm)
	end
	end
    return true
end

function SWEP:OnRemove()
	self:Holster()
end

function SWEP:OnDrop()
	self:Holster()
end

function SWEP:Reload()
 return false
end

function SWEP:DrawHUD()
	    surface.SetMaterial( csh )
	    surface.SetDrawColor( 0, 63, 255, 255 )
	    surface.DrawTexturedRect( ScrW() / 2 - 32 / 2, ScrH() / 2 - 32 / 2, 32, 32 )
end

/*---------------------------------------------------------
   Think
---------------------------------------------------------*/
function SWEP:Think()
    if IsValid(self) and IsValid(self.Owner) and self.Owner:Alive() and (self.Owner:KeyReleased( IN_ATTACK ) or (self.Weapon:Clip1() <= 0) or (self.Owner:KeyDown(IN_ATTACK) and self.Owner:KeyDown(IN_ATTACK2) and self:GetNextPrimaryFire() < CurTime() and self.BeamCooldown < CurTime() and self:Clip1() >= 100) or (self.Owner:KeyDown(IN_ATTACK) and self.Owner:KeyDown(IN_ATTACK2) and self:Clip1() < 100)) and SERVER then
	if ( self.ShootLoop ) then 
	self.ShootLoop:ChangeVolume( 0, 0.02 ) 
	self.ShootLoop:Stop() 
	self.ShootLoop = nil
	self.Owner:EmitSound(Sound("npc/combine_gunship/attack_stop2.wav"))
	self:SetNextPrimaryFire( CurTime() + 0.8 )
	end
	end
	local Sensors={}
	for k,v in pairs(ents.GetAll()) do
	if IsValid(v) and v.IsSensor and v.Caller == self.Owner then
    table.insert(Sensors,v)
	end
	end
	for i=1, #Sensors, 1 do
    if IsValid(Sensors[i]) then
    if SERVER and Sensors[i].BeamDamageCooldown < CurTime() and Sensors[i].BeamTurnedOn then
	Sensors[i].BeamDamageCooldown = CurTime() + 0.2
	local tracedamage = {}
    tracedamage.start = Sensors[i]:GetPos()
    tracedamage.endpos = tracedamage.start - Vector(0,0,90000)
    tracedamage.filter = function(ent) if (ent:IsWorld() or ent:IsPlayer() or ent:IsNPC()) then return true end end
    local tracedamagebeam = util.TraceLine(tracedamage)
	if IsValid(tracedamagebeam.Entity) and tracedamagebeam.Entity and (tracedamagebeam.Entity:IsPlayer() or tracedamagebeam.Entity:IsNPC()) then
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(5)
    dmginfo:SetDamageType(DMG_DISSOLVE)
	if IsValid(Sensors[i].Caller) then
    dmginfo:SetAttacker( Sensors[i].Caller )
	else
	dmginfo:SetAttacker( game.GetWorld() )
	end
    dmginfo:SetDamageForce(Vector(0,0,-10000))
	if IsValid(self) then
    dmginfo:SetInflictor( self )
	else
	dmginfo:SetInflictor( game.GetWorld() )
	end
	local effectdata = EffectData()
	effectdata:SetOrigin( tracedamagebeam.HitPos )
	util.Effect("cball_explode",effectdata)
	local effectent = ents.Create("point_tesla")
	effectent:SetPos(tracedamagebeam.HitPos)
	effectent:SetKeyValue("texture","models/effects/vol_light001.vmt")
	effectent:SetKeyValue("interval_max",0.4)
	effectent:SetKeyValue("interval_min",0.1)
	effectent:SetKeyValue("lifetime_max",0.1)
	effectent:SetKeyValue("lifetime_min",0.1)
	effectent:SetKeyValue("beamcount_max",1)
	effectent:SetKeyValue("beamcount_min",1)
	effectent:SetKeyValue("thick_max",5)
	effectent:SetKeyValue("m_flRadius",1)
	effectent:SetKeyValue("m_Color","255 255 255")
	effectent:Spawn()
	effectent:Spawn()
	effectent:Fire("DoSpark","",0)
	effectent:Fire("kill","",1)
	tracedamagebeam.Entity:TakeDamageInfo( dmginfo )
    end
    end
    end
	end
end


function PlayerGiveAmmo(ply, ent)
	if ent:GetClass() == "swep_gunship" then
	for k,v in pairs(ply:GetWeapons()) do
	if IsValid(v) and v:GetClass() == "swep_gunship" then
	if game.SinglePlayer() then
	v:SetClip1(1000)
	else
	v:SetClip1(200)
	end
	ply:EmitSound("HL2Player.PickupWeapon")
	end
	end
	end
end

hook.Add("PlayerCanPickupWeapon", "PlayerGiveAmmo", PlayerGiveAmmo)

function NPCNotFeatHelicopter(ent)
    local EntNPC = ent
    timer.Simple(0.1,function()
	if IsValid(EntNPC) then
    local npcs={}
	for k,v in pairs(ents.GetAll()) do
	if IsValid(v) and v:IsNPC() and IsValid(v:GetActiveWeapon()) and v:GetActiveWeapon():GetClass() != nil and v:GetActiveWeapon():GetClass() != NULL then
	if string.find(v:GetActiveWeapon():GetClass(),"swep_gunship") and !string.find(v:GetClass(),"npc_combine_s") and !string.find(v:GetClass(),"npc_metropolice") then
    table.insert(npcs,v)
	end
	end
	end
	for i=1, #npcs, 1 do
    if EntNPC:IsNPC() and string.find(EntNPC:GetClass(),"npc_helicopter") or string.find(EntNPC:GetClass(),"npc_combinegunship") or string.find(EntNPC:GetClass(),"npc_combinedropship") or string.find(EntNPC:GetClass(),"prop_vehicle_apc") then
    if SERVER then
    npcs[i]:AddEntityRelationship(EntNPC,1,99)
    end
    end
	end
	end
	end)
end

hook.Add("OnEntityCreated","NPCNotFeatHelicopter",NPCNotFeatHelicopter)

function RemoveTimerSensor(ent)
if IsValid(ent) and ent.IsSensor then
timer.Remove("angleupdate" .. ent:EntIndex())
end
end
hook.Add("EntityRemoved","RemoveTimerSensor",RemoveTimerSensor)

	
function SWEP:SetupWeaponHoldTypeForAI( t )

	self.ActivityTranslateAI = {};
	
	self.ActivityTranslateAI[ ACT_IDLE ]						= ACT_IDLE_PISTOL;
    self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]					= ACT_IDLE_ANGRY_PISTOL;
    self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]				= ACT_RANGE_ATTACK_PISTOL;
    self.ActivityTranslateAI[ ACT_RELOAD ]						= ACT_RELOAD_PISTOL;
    self.ActivityTranslateAI[ ACT_WALK_AIM ]					= ACT_WALK_AIM_PISTOL;
    self.ActivityTranslateAI[ ACT_RUN_AIM ]						= ACT_RUN_AIM_PISTOL;
    self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]		= ACT_GESTURE_RANGE_ATTACK_PISTOL;
	self.ActivityTranslateAI[ ACT_RELOAD_LOW ]					= ACT_RELOAD_PISTOL_LOW;
    self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]			= ACT_RANGE_ATTACK_PISTOL_LOW;
    self.ActivityTranslateAI[ ACT_COVER_LOW ]					= ACT_COVER_PISTOL_LOW;
    self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]				= ACT_RANGE_AIM_PISTOL_LOW;
    self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]				= ACT_GESTURE_RELOAD_PISTOL;
	
	if( t == "ar2" ) then
		
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1 ]			= ACT_RANGE_ATTACK_SMG1;
		self.ActivityTranslateAI[ ACT_RELOAD ]					= ACT_RELOAD_SMG1;
		self.ActivityTranslateAI[ ACT_IDLE ]					= ACT_IDLE_SMG1;
		self.ActivityTranslateAI[ ACT_IDLE_ANGRY ]				= ACT_IDLE_ANGRY_SMG1;
		self.ActivityTranslateAI[ ACT_WALK ]					= ACT_WALK_RIFLE;
		self.ActivityTranslateAI[ ACT_WALK_AIM ]				= ACT_WALK_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_IDLE_RELAXED ]			= ACT_IDLE_SMG1_RELAXED;
		self.ActivityTranslateAI[ ACT_IDLE_STIMULATED ]			= ACT_IDLE_SMG1_STIMULATED;
		self.ActivityTranslateAI[ ACT_IDLE_AGITATED ]			= ACT_IDLE_ANGRY_SMG1;
		self.ActivityTranslateAI[ ACT_WALK_RELAXED ]			= ACT_WALK_RIFLE_RELAXED;
		self.ActivityTranslateAI[ ACT_WALK_STIMULATED ]			= ACT_WALK_RIFLE_STIMULATED;
		self.ActivityTranslateAI[ ACT_WALK_AGITATED ]			= ACT_WALK_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_RUN_RELAXED ]				= ACT_RUN_RIFLE_RELAXED;
		self.ActivityTranslateAI[ ACT_RUN_STIMULATED ]			= ACT_RUN_RIFLE_STIMULATED;
		self.ActivityTranslateAI[ ACT_RUN_AGITATED ]			= ACT_RUN_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_IDLE_AIM_RELAXED ]		= ACT_IDLE_SMG1_RELAXED;
		self.ActivityTranslateAI[ ACT_IDLE_AIM_STIMULATED ]		= ACT_IDLE_AIM_RIFLE_STIMULATED;
		self.ActivityTranslateAI[ ACT_IDLE_AIM_AGITATED ]		= ACT_IDLE_ANGRY_SMG1;
		self.ActivityTranslateAI[ ACT_WALK_AIM_RELAXED ]		= ACT_WALK_RIFLE_RELAXED;
		self.ActivityTranslateAI[ ACT_WALK_AIM_STIMULATED ]		= ACT_WALK_AIM_RIFLE_STIMULATED;
		self.ActivityTranslateAI[ ACT_WALK_AIM_AGITATED ]		= ACT_WALK_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_RUN_AIM_RELAXED ]			= ACT_RUN_RIFLE_RELAXED;
		self.ActivityTranslateAI[ ACT_RUN_AIM_STIMULATED ]		= ACT_RUN_AIM_RIFLE_STIMULATED;
		self.ActivityTranslateAI[ ACT_RUN_AIM_AGITATED ]		= ACT_RUN_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_WALK_CROUCH ]				= ACT_WALK_CROUCH_RIFLE;
		self.ActivityTranslateAI[ ACT_WALK_CROUCH_AIM ]			= ACT_WALK_CROUCH_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_RUN ]						= ACT_RUN_RIFLE;
		self.ActivityTranslateAI[ ACT_RUN_AIM ]					= ACT_RUN_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_RUN_CROUCH ]				= ACT_RUN_CROUCH_RIFLE;
		self.ActivityTranslateAI[ ACT_RUN_CROUCH_AIM ]			= ACT_RUN_CROUCH_AIM_RIFLE;
		self.ActivityTranslateAI[ ACT_GESTURE_RANGE_ATTACK1 ]	= ACT_GESTURE_RANGE_ATTACK_AR2;
		self.ActivityTranslateAI[ ACT_COVER_LOW ]				= ACT_COVER_SMG1_LOW;
		self.ActivityTranslateAI[ ACT_RANGE_AIM_LOW ]			= ACT_RANGE_AIM_AR2_LOW;
		self.ActivityTranslateAI[ ACT_RANGE_ATTACK1_LOW ]		= ACT_RANGE_ATTACK_SMG1_LOW;
		self.ActivityTranslateAI[ ACT_RELOAD_LOW ]				= ACT_RELOAD_SMG1_LOW;
		self.ActivityTranslateAI[ ACT_GESTURE_RELOAD ]			= ACT_GESTURE_RELOAD_SMG1;

	end

end


	
if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end
		
		self.Owner:GetViewModel():SetMaterial("hud/800corner1")

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) and !self.Owner:IsNPC() then
			self:DrawShadow( false )
			self:DrawModel()
		end
		self:DrawShadow( false )
		self:SetMaterial("hud/800corner1")
		if IsValid(self.Owner) and self.Owner:IsNPC() then
		render.SetBlend(0)
		self:DrawModel()
		end
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
end

if CLIENT then

local mat = Material("Effects/blueblacklargebeam")
local mat2	= Material("Effects/blueblackflash")
local sparks = Material("effects/spark")
local combinemuzzle = Material("Effects/combinemuzzle2")


local EFFECT={}


function EFFECT:Init(data)
self.StartPos = data:GetStart()
self.Orig = data:GetOrigin()
if self.StartPos == nil then self.BeamLife = 0 self.BeamLifeEnd = 0 return end
self.BeamLife = CurTime() + 2
self.BeamLifeEnd = CurTime() + 3
self.BeamWidth = 20
self.BeamSpriteSize = 80
local trace = {}
trace.start = self.StartPos
trace.endpos = trace.start - Vector(0,0,90000)
trace.filter = ents.GetAll()

local tr = util.TraceLine(trace)

self:SetRenderBoundsWS(tr.StartPos, tr.HitPos)
end

function EFFECT:Think()
if self.BeamLifeEnd < CurTime() then return false end
return true
end

function EFFECT:Render( )
if self.StartPos == nil then return end
local intrplt 
local invintrplt = (self.BeamLife - CurTime())/3
intrplt = math.Clamp(1 - invintrplt,0,1)

if self.BeamLife < CurTime() then
intrplt = intrplt + invintrplt*3
end

render.SetMaterial( mat )

render.DrawBeam( self.StartPos, self.Orig, intrplt*self.BeamWidth, 0, 0, Color( 255, 255, 255, intrplt*100 ) )

render.SetMaterial(mat2)
local clr = 255*(1*intrplt - 1)
render.DrawSprite(self.StartPos,self.BeamSpriteSize,self.BeamSpriteSize,Color(clr,clr,clr,100))

end

effects.Register(EFFECT, "gunship_bellycannon_beam", true)

local EFFECT2={}


function EFFECT2:Init(data)
self.Orig = data:GetOrigin()
self.Norm = data:GetNormal()
self.ParticleLife = CurTime() + 2
self.ParticleTime = 0
self.ParticleNum = 0
self.MuzzleSize = 50
end

function EFFECT2:Think()
if self.ParticleTime < CurTime() then
local emmiter = ParticleEmitter(self.Orig,false)
for i=0,(math.Round(1 + self.ParticleNum)) do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(math.Rand(-100,-50),math.Rand(50,100)),math.Rand(math.Rand(-100,-50),math.Rand(50,100)),math.Rand(0,50)))
		if particle then
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Clamp(0.1+(self.ParticleNum/math.Rand(30,40)),0.1,1) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(1,5) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
			particle:SetGravity(Vector(0,0,math.Clamp(50+(self.ParticleNum*math.Rand(9,15)),50,2000)))
		end
	end
	self.ParticleTime = CurTime() + 0.1
end
if self.ParticleLife < CurTime() then
local emmiter = ParticleEmitter(self.Orig,false)
for i=0,40 do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(-20,20),math.Rand(-20,20),math.Rand(0,50)))
		if particle then
		    particle:SetVelocity(Vector(math.Rand(-30,30),math.Rand(-30,30),50)*math.Rand(14,25))
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Rand( 1, 1.5 ) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(1,3) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
		end
end
for i=0,20 do
	local particle = emmiter:Add(sparks,self.Orig + Vector(math.Rand(-20,20),math.Rand(-20,20),math.Rand(0,50)))
		if particle then
		    particle:SetVelocity(Vector(math.Rand(-200,200),math.Rand(-200,200),40)*math.Rand(5,12))
			particle:SetLifeTime(0)
			particle:SetDieTime( math.Rand( 1, 1.5 ) )
			particle:SetAirResistance(300)
			particle:SetStartAlpha( math.Rand( 0, 30 ) )
			particle:SetEndAlpha( 255 )
			particle:SetStartSize( math.Rand(1,3) )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )
			particle:SetColor(255,255,255,255)
		end
end
return false 
end
return true
end

function EFFECT2:Render( )
self.ParticleNum = math.Clamp(self.ParticleNum + (FrameTime()*40),0,50)
self.MuzzleSize = math.Clamp(self.MuzzleSize + FrameTime()*150,0,680)
render.SetMaterial(combinemuzzle)
render.DrawQuadEasy(self.Orig,self.Norm,self.MuzzleSize,self.MuzzleSize,Color(255,255,255,255),0)
end

effects.Register(EFFECT2, "gunship_bellycannon_particle", true)

end
