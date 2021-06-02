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

function ENT:ModifyReloadSpeed(self, weapon, modifier)
	--print("reload")
	if not weapon.ReloadSpeedDefault then
		weapon.ReloadSpeedDefault = weapon.ReloadSpeed
	end
	--self:SetDTFloat(1, weapon.ReloadSpeed)
	if modifier and modifier > 0 and modifier < 1 then
		--local newrspd = self:GetDTFloat(1) * modifier
		local newrspd = weapon.ReloadSpeed * modifier
		weapon.ReloadSpeed = newrspd
	elseif modifier == 1 then
		weapon.ReloadSpeed = weapon.ReloadSpeedDefault
	end
end

function ENT:ModifySwingSpeed(self, weapon, modifier)
	--print("swing")
	if not weapon.SwingTimeDefault then
		weapon.SwingTimeDefault = weapon.SwingTime
	end
	--self:SetDTFloat(2, weapon.Primary.Delay)
	if modifier and modifier > 0 and modifier < 1 then
		local modifier = modifier + 1
		--local newswspd = self:GetDTFloat(2) * modifier
		local newswspd = weapon.SwingTime * modifier
		weapon.SwingTime = newswspd
	elseif modifier == 1 then
		weapon.SwingTime = weapon.SwingTimeDefault
	end
end

function ENT:ModifyEatSpeed(self, weapon, modifier)
	--print("eat")
	if not weapon.FoodEatTimeDefault then
		weapon.FoodEatTimeDefault = weapon.FoodEatTime
	end
	--self:SetDTFloat(2, weapon.FoodEatTime)
	if modifier and modifier > 0 and modifier < 1 then
		local modifier = modifier + 1
		--local neweatspd = self:GetDTFloat(2) * modifier
		local neweatspd = weapon.FoodEatTime * modifier
		weapon.FoodEatTime = neweatspd
	elseif modifier == 1 then
		weapon.FoodEatTime = weapon.FoodEatTimeDefault
	end
end

function ENT:WeaponConditional(self, weapon)
	local base = weapon.Base
	--print(base)
	if string.find(base, "weapon_zs_basemelee") then 
		return 0
	elseif string.find(base, "weapon_zs_basefood") then
		return 2
	elseif string.find(base, "weapon_zs_basethrown") or string.find(base, "weapon_zs_basetrinket") then
		return 3
	elseif string.find(base, "weapon_zs_base") then --or string.find(base, "weapon_zs_baseshotgun") or string.find(base, "weapon_zs_baseproj") then
		return 1
	else 
		print("Fatigue conditional failed.")
		return 4
	end
end

function ENT:ModifyBothSpeed(self, weapon, modifier)
	local con = self:WeaponConditional(self, weapon)
	if con == 0 then
		--print("swing")
		self:ModifySwingSpeed(self, weapon, modifier)
	elseif con == 1 then
		--print("reload")
		self:ModifyReloadSpeed(self, weapon, modifier)
	elseif con == 2 then
		--print("food")
		self:ModifyEatSpeed(self, weapon, modifier)
		return
	elseif con == 3 or 4 then
		--print("thrown, trinket")
		return
	--[[elseif con == 4 then
		--print("failed")
		return]]
	end
end

function ENT:Think()
	local status = self
	local owner = self:GetOwner()
	local weapon = owner:GetActiveWeapon()

	if self:GetDTInt(1) == 0 and self:GetDTFloat(2) == 0 and not self:GetDTBool(1) then
		self:ModifyBothSpeed(self, weapon, 0.75)
		self:SetDTBool(1, true)
		function weapon:Holster(wep)
			if status:IsValid() then
				if not IsFirstTimePredicted() then return end
				switchto = wep
				if status:IsValid() then
					status:SetDTBool(1, false)
					status:ModifyBothSpeed(status, self, 1)
					status:ResetHolster()
				end
				return false
			end
		end
	end

	if self.DieTime <= CurTime() then
		self:Remove()
	end
end

function ENT:ResetHolster()
	local owner = self:GetOwner()
	local weapon = owner:GetActiveWeapon()
	function weapon:Holster() return true end
	owner:SelectWeapon(switchto)
	self:ModifyBothSpeed(self, switchto, 0.75)
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	local weapon = owner:GetActiveWeapon()
	self:ModifyBothSpeed(self, weapon, 1)
	function weapon:Holster() return true end
	--function weapon:Holster() return true end
end
