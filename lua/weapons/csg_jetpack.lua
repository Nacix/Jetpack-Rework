AddCSLuaFile()

SWEP.ViewModel = Model( "models/weapons/c_arms_animations.mdl" )
SWEP.WorldModel = ""

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.PrintName	= "Jetpack"
SWEP.Category	= "Tasty's SWEPs"

SWEP.Slot		= 4
SWEP.SlotPos	= 1

SWEP.DrawAmmo		= false
SWEP.DrawCrosshair	= false
SWEP.Spawnable		= true
SWEP.AdminOnly		= false

if SERVER then
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

function SWEP:SetupDataTables()
	self:NetworkVar( "Int", 0, "Fuel" )
	if ( SERVER ) then
		self:SetFuel(100)
	end
end

function SWEP:Initialize()
	self:SetHoldType( "normal" )
	--self:GetOwner().isActive = true
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
		local ply = self:GetOwner()
		local ex = ply:GetNWEntity('Jetted')
		if IsValid(ex) then
			ex:Remove()
			ply:SetNWEntity('Jetted',NULL)
			ply.LastJetExecuted = CurTime()
		else
			if !ply:IsOnGround() then return end
			if (ply.LastJetExecuted or 0) + 1.33 >= CurTime() then return end
			local jp = ents.Create('sneakyjetpack')
			jp:SetSlotName('sneakyjetpack')
			jp:Spawn()
			jp:Attach(ply)
			ply.Jetted = jp
			ply:SetNWEntity('Jetted',jp)
		end
		ply:EmitSound('buttons/button14.wav')
end

-- local skinint = 1 (Tasty)

function SWEP:SecondaryAttack()
--[[
Tasty
	if CLIENT then return end
	local ply = self:GetOwner()
	local ex = ply:GetNWEntity('Jetted')
	if !IsValid(ex) then return end
	skinint = (skinint + 1)%3
	ex:SetSkin(skinint)
	ply:EmitSound('buttons/button16.wav')
Tasty
--]]
end

function SWEP:Deploy()
	return true
end

function SWEP:Equip()

end

function SWEP:ShouldDropOnDie() return false end


if SERVER then return end

--function SWEP:DrawHUD() end
--function SWEP:PrintWeaponInfo( x, y, alpha ) end

--function SWEP:HUDShouldDraw( name )
	--if ( name == "CHudWeaponSelection" ) then return true end
	--if ( name == "CHudChat" ) then return true end
	--return false
--end