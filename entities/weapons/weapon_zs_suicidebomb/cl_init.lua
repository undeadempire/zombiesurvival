INC_CLIENT()

SWEP.DrawCrosshair = false

SWEP.Slot = 4
SWEP.SlotPos = 0

function SWEP:Deploy()
	gamemode.Call("WeaponDeployed", self:GetOwner(), self)

	return true
end

function SWEP:DrawHUD()
	if GetConVar("crosshair"):GetInt() ~= 1 then return end
	self:DrawCrosshairDot()
end

function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)

	if CLIENT then return end

	for _, ent in pairs(ents.FindByClass("prop_detpack")) do
		if ent:GetOwner() == self:GetOwner() and ent:GetExplodeTime() == 0 then
			ent:SetExplodeTime(CurTime() + ent.ExplosionDelay)
		end
	end
end

function SWEP:DrawWeaponSelection(x, y, w, h, alpha)
	self:BaseDrawWeaponSelection(x, y, w, h, alpha)
end
