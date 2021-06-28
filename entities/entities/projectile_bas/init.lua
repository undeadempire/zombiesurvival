INC_SERVER()

ENT.SubProjectile = "projectile_emi_sub"

ENT.LifeTime = 60

function ENT:Initialize()
	self:SetModel("models/dav0r/hoverball.mdl")
	self:PhysicsInitSphere(1)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetModelScale(0.4)
	self:SetupGenericProjectile(false)
	self.DeathTime = CurTime() + 60

	self:EmitSound("weapons/physcannon/energy_sing_flyby2.wav", 70, math.random(125, 135))
	self:Fire("kill", "", 60)

	self.NextShoot = 0
end

function ENT:Think()
	local owner = self:GetOwner()

	if self.PhysicsData then
		self:Hit(self.PhysicsData.HitPos, self.PhysicsData.HitNormal, self.PhysicsData.HitEntity)
	end

	if self.Exploded or not owner:IsValidLivingHuman() then
		self:Remove()
	end

	if CurTime() > self.NextShoot then
		self.NextShoot = CurTime() + 0.1

		if not owner:IsValidLivingHuman() then owner = self end

		self:FireBulletsLua(self:GetPos() + self:GetForward() * 10, self:GetForward(), 5, 1, self.ProjDamage, owner, 0.01, "tracer_pcutter", BulletCallback, nil, nil, nil, nil, self)
	end
end

function ENT:OnRemove()
	self:Hit(self:GetPos(), Vector(0, 0, 1), NULL)
end

function ENT:Hit(vHitPos, vHitNormal, eHitEntity)
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if not owner:IsValid() then owner = self end

	vHitPos = vHitPos or self:GetPos()
	vHitNormal = vHitNormal or Vector(0, 0, 1)

	local effectdata = EffectData()
		effectdata:SetOrigin(vHitPos)
		effectdata:SetNormal(vHitNormal)
	util.Effect("explosion_emi", effectdata)
end

function ENT:PhysicsCollide(data, phys)
	if not self:HitFence(data, phys) then
		self.PhysicsData = data
	end

	self:NextThink(CurTime())
end
