CLASS.Base = "freshdead"

CLASS.Name = "Agile Dead"
CLASS.TranslationName = "class_agile_dead"
CLASS.Description = "description_agile_dead"
CLASS.Help = "controls_agile_dead"

CLASS.BetterVersion = "Fast Zombie"

CLASS.SWEP = "weapon_zs_agiledead"

CLASS.Unlocked = true

CLASS.Health = 100
CLASS.Points = CLASS.Health/GM.NoHeadboxZombiePointRatio
CLASS.Speed = 210

CLASS.UsePlayerModel = true
CLASS.UsePreviousModel = false

if SERVER then
	function CLASS:OnKilled() end
end

local ACT_HL2MP_SWIM_PISTOL = ACT_HL2MP_SWIM_PISTOL
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_GMOD_GESTURE_RANGE_ZOMBIE = ACT_GMOD_GESTURE_RANGE_ZOMBIE
local ACT_HL2MP_ZOMBIE_SLUMP_RISE = ACT_HL2MP_ZOMBIE_SLUMP_RISE
local ACT_HL2MP_IDLE_CROUCH_ZOMBIE = ACT_HL2MP_IDLE_CROUCH_ZOMBIE
local ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01

local math_Clamp = math.Clamp
local math_min = math.min

if SERVER then
	function CLASS:AltUse(pl) end
	function CLASS:OnKilled(pl, attacker, inflictor, suicide, headshot, dmginfo) end
end

function CLASS:Move(pl, mv)
	local wep = pl:GetActiveWeapon()
	if wep.Move and wep:Move(mv) then
		return true
	end

	if mv:GetForwardSpeed() <= 0 then
		mv:SetMaxSpeed(math_min(mv:GetMaxSpeed(), 120))
		mv:SetMaxClientSpeed(math_min(mv:GetMaxClientSpeed(), 120))
	end
end

function CLASS:ScalePlayerDamage(pl, hitgroup, dmginfo)
	return true
end

function CLASS:IgnoreLegDamage(pl, dmginfo)
	return true
end

function CLASS:CalcMainActivity(pl, velocity)
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.GetClimbing and wep:GetClimbing() then
		return ACT_ZOMBIE_CLIMB_UP, -1
	end

	return ACT_HL2MP_RUN_ZOMBIE, -1
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local wep = pl:GetActiveWeapon()
	if wep:IsValid() and wep.GetClimbing and wep:GetClimbing() then
		local vel = pl:GetVelocity()
		local speed = vel:LengthSqr()
		if speed > 64 then
			pl:SetPlaybackRate(math_Clamp(speed / 3600, 0, 1) * (vel.z < 0 and -1 or 1) * 0.25)
		else
			pl:SetPlaybackRate(0)
		end

		return true
	end

	if not pl:OnGround() or pl:WaterLevel() >= 3 then
		pl:SetPlaybackRate(1)

		if pl:GetCycle() >= 1 then
			pl:SetCycle(pl:GetCycle() - 1)
		end

		return true
	end
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_ZOMBIE_SPECIAL, true)
		return ACT_INVALID
	elseif event == PLAYERANIMEVENT_RELOAD then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
		return ACT_INVALID
	end
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/fresh_dead"
