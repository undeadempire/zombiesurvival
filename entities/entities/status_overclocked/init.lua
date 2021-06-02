INC_SERVER()

function ENT:SetDie(fTime)
	if fTime == 0 or not fTime then
		self.DieTime = 0
	elseif fTime == -1 then
		self.DieTime = 999999999
	else
		self.DieTime = CurTime() + fTime
		self:SetDuration(fTime)
	end
end

function ENT:ModifyReloadSpeed(self, modifier, stack)
	local owner = self:GetOwner()
	local weapon = owner:GetActiveWeapon()
	--local oldrspd = weapon.ReloadSpeedDefault
	--if weapon.Base == "weapon_zs_basemelee" or "weapon_zs_fists" then print("returned") return end
	if self:GetDTFloat(2) == 0 then
		self:SetDTFloat(2, weapon.ReloadSpeed)
	end
	if modifier and modifier > 0 and modifier < 1 then
		self:SetDTFloat(1, weapon.ReloadSpeed)
		--Limiter for stack number, can be changed. Make sure that the section below is changed too.
		if stack >= 1 and stack <= 3 then
			local newrspd = self:GetDTFloat(1) * ((modifier * stack) + 1)
			--[[print(stack..": stack count")
			print(newrspd..": new rspd")]]
			weapon.ReloadSpeed = newrspd
			local stack = stack + 1 
			self:SetDTInt(1, stack)
		end
	elseif modifier == 1 then
		--[[print("reset")
		print(self:GetDTFloat(2))
		print(weapon.ReloadSpeed)]]
		weapon.ReloadSpeed = self:GetDTFloat(2)
	end
end

function ENT:Think()
	local status = self
	local owner = self:GetOwner()
	local weapon = owner:GetActiveWeapon()
	if self:GetDTInt(1) == 0 and not self:GetDTBool(1) then
		function weapon:Holster(wep)
			if status then
				if not IsFirstTimePredicted() then return end
				switchto = wep
				if status:IsValid() then
					status:Remove()
				end
				return false
			end
		end
		self:ModifyReloadSpeed(self, 0.1, 1)
		self:SetDTBool(1, true)
		--self:ModifySwingSpeed(self, 0.5)
	end

	if self.DieTime <= CurTime() then
		self:Remove()
	end
end

function ENT:HumanKilledZombie(pl, attacker, inflictor, dmginfo, headshot, suicide)
	if attacker ~= self:GetOwner() then return end

	if attacker:IsValid() and attacker:IsPlayer() and attacker:Team() == TEAM_HUMAN then
		fervorstatus = attacker:GiveStatus("fervor", math.min(14, self.DieTime - CurTime() + 7))
		if fervorstatus and fervorstatus:IsValid() then
			attacker:EmitSound("hl1/ambience/particle_suck1.wav", 55, 150 + fervorstatus:GetDTInt(1) * 30, 0.45)
		end
		fervorstatus:ModifyReloadSpeed(fervorstatus, 0.10, fervorstatus:GetDTInt(1))
	end
end

function ENT:OnRemove()
	local attacker = self:GetOwner()
	local weapon = attacker:GetActiveWeapon()
	self:ModifyReloadSpeed(self, 1, self:GetDTInt(1))
	function weapon:Holster() return true end
	--print(switchto)
	attacker:SelectWeapon(switchto)
	--self:ForceSelectWeapon(switchto)
end