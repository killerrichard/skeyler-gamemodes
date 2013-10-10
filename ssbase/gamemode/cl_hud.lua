---------------------------
--       Bunny Hop       -- 
-- Created by xAaron113x --
---------------------------

HUD_DO_NOT_DRAW = {}
function GM:HUDAddShouldNotDraw(name) 
	HUD_DO_NOT_DRAW[name] = true 
end 

function GM:HUDShouldDraw(name) 
	if HUD_DO_NOT_DRAW[name] then return false end 

	if self.GUIBlur and name == "CHudCrosshair" then return false end 
	return true 
end 

surface.CreateFont("HUD_Money", {font="Myriad Pro", size=20, weight=1000})
surface.CreateFont("HUD_HP_Percent", {font="Myriad Pro", size=24, weight=700})
surface.CreateFont("HUD_HP", {font="Myriad Pro", size=16, weight=1000})
surface.CreateFont("HUD_CENTER", {font="Myriad Pro", size=18, weight=1000})
surface.CreateFont("HUD_Level", {font="Myriad Pro", size=20, weight=900})
surface.CreateFont("HUD_Level_Blue", {font="Myriad Pro", size=24, weight=1000})
surface.CreateFont("HUD_Timer", {font="Century Gothic", size=40, weight=1000}) 
surface.CreateFont("HUD_Timer_Small", {font="Century Gothic", size=24, weight=1000}) 

surface.CreateFont("HUD_WEPS", {font="HalfLife2", size=80, weight=550}) 


HUD_LEFT = Material("skeyler/hud_box_left.png") 
HUD_CENTER = Material("skeyler/hud_box_center.png") 
HUD_RIGHT = Material("skeyler/hud_box_ammo.png") 
HUD_RIGHT_CIRCLE = Material("skeyler/hud_box_ammo_circle.png") 
HUD_HP = Material("skeyler/hud_bar_health.png") 
HUD_XP = Material("skeyler/hud_bar_xp.png") 
HUD_AMMO = Material("skeyler/hud_bar_ammo.png") 
HUD_BAR_CENTER = Material("skeyler/hud_bar_center.png") 
HUD_COIN = Material("skeyler/skeyler_coin.png") 


GM.HudAlpha = 0 
GM.HUDHPSmooth = 0 
GM.HUDHP = 0
GM.HUDVelFrac = 1 
GM.HUDVel = 0 

local weaponImgs = {
	ar2 = "l", 
	pistol = "d", 
	smg = "a", 
	crossbow = "g", 
	shotgun = "b",
	rpg = "i", 
	grenade = "k", 
	bugbait = "k", 
	melee = "c", 
	revolver = "e", 
	physgun = "m", 
}

function GetWeaponIcon(wep) 

end 

local w, h, Text, tw, th, tw2, th2, wep, frac = ScrW(), ScrH(), "", 0, 0, 0, 0, 0, 0
function GM:HUDPaint() 
	if self.GUIBlur then 
		self.HudAlpha = math.Approach(self.HudAlpha, 0, 5) 
	else 
		self.HudAlpha = math.Approach(self.HudAlpha, 255, 5) 
		if self.HudAlpha <= 0 then return end 
	end 

	if LocalPlayer():Alive() then 
		self.HUDHPSmooth = math.min(LocalPlayer():GetMaxHealth(), math.Approach(self.HUDHPSmooth, LocalPlayer():Health(), 5)) 
		self.HUDHP = math.ceil(LocalPlayer():Health()/100*100)
		if self.HUDShowVel then 
			self.HUDVel = LocalPlayer():GetVelocity():Length2D()
			self.HUDVelFrac = math.Approach(self.HUDVelFrac, math.min(1200, self.HUDVel)/1200, 0.01) 
		end 
	else 
		self.HUDHPSmooth = math.Approach(self.HUDHPSmooth, 0, 1) 
		self.HUDHP = 0 
		if self.HUDShowVel then self.HUDVelFrac = math.Approach(1, self.HUDVelFrac, 0.01)  end 
	end 

	if self.HUDShowTimer then 
		/* Top HUD (Timer) */
		Text = "00:00:00.00"
		if LocalPlayer():GetNetworkedInt("STimer_TotalTime", 0) != 0 then 
			Text = FormatTime(LocalPlayer():GetNetworkedInt("STimer_TotalTime", 0)) 
		elseif LocalPlayer():GetNetworkedInt("STimer_StartTime", 0) != 0 then 
			Text = FormatTime(CurTime()-LocalPlayer():GetNetworkedInt("STimer_StartTime", 0))
		end 

		surface.SetFont("HUD_Timer") 
		tw, th = surface.GetTextSize(Text) 
		surface.SetTextColor(0, 0, 0, self.HudAlpha) 
		surface.SetTextPos(w/2-tw/2+1, 40+1) 
		surface.DrawText(Text) 
		surface.SetTextColor(255, 255, 255, self.HudAlpha) 
		surface.SetTextPos(w/2-tw/2, 40) 
		surface.DrawText(Text) 

		surface.SetFont("HUD_Timer_Small") 
		tw = surface.GetTextSize(Text) 
		surface.SetTextColor(0, 0, 0, self.HudAlpha) 
		surface.SetTextPos(w/2-tw/2+1, 40+th+1) 
		surface.DrawText(Text) 
		surface.SetTextColor(253, 189, 77, self.HudAlpha) 
		surface.SetTextPos(w/2-tw/2, 40+th) 
		surface.DrawText(Text) 
	end 

	/* Left HUD */
	surface.SetDrawColor(255, 255, 255, self.HudAlpha) 
	surface.SetMaterial(HUD_LEFT) 
	surface.DrawTexturedRect(45, h-165, 512, 256) 

	surface.SetDrawColor(255, 255, 255, self.HudAlpha*0.85) 
	
	render.SetScissorRect(175, h-121, 179+(172*(self.HUDHPSmooth/LocalPlayer():GetMaxHealth())), h-89, true)
	surface.SetMaterial(HUD_HP) 
	surface.DrawTexturedRect(175, h-122, 256, 32)
	render.SetScissorRect(175, h-121, 179+(172*(self.HUDHPSmooth/LocalPlayer():GetMaxHealth())), h-89, false)

	surface.SetMaterial(HUD_XP) 
	surface.DrawTexturedRect(176, h-106, 128, 16)

	Text = tostring(self.HUDHP).."%"
	surface.SetTextColor(255, 255, 255, self.HudAlpha) 
	surface.SetFont("HUD_HP_Percent") 
	tw, th = surface.GetTextSize(Text) 
	surface.SetTextPos(179, h-119-th) 
	surface.DrawText(Text) 

	surface.SetTextColor(147, 147, 147, self.HudAlpha) 
	surface.SetFont("HUD_HP") 
	surface.SetTextPos(355, h-120)
	surface.DrawText("HP") 

	surface.SetTextPos(309, h-105)
	surface.DrawText("EXP") 

	surface.SetMaterial(HUD_COIN) 
	surface.SetDrawColor(255, 255, 255, self.HudAlpha) 
	surface.DrawTexturedRect(180, h-85, 32, 32) 

	Text = FormatNum(LocalPlayer():GetMoney())
	surface.SetFont("HUD_Money") 
	tw, th = surface.GetTextSize(Text) 
	surface.SetTextPos(205, h-73-th/2)
	surface.SetTextColor(110, 110, 110, self.HudAlpha) 
	surface.DrawText(Text) 

	surface.SetFont("HUD_Level_Blue") 
	surface.SetTextColor(102, 167, 201, self.HudAlpha) 
	tw, th = surface.GetTextSize(" "..tostring(LocalPlayer():GetLevel())) 
	surface.SetTextPos(378-tw, h-76-th/2) 
	surface.DrawText(" "..tostring(LocalPlayer():GetLevel())) 

	surface.SetFont("HUD_Level")
	surface.SetTextColor(195, 195, 195, self.HudAlpha) 
	tw2, th2 = surface.GetTextSize("lvl") 
	surface.SetTextPos(378-tw-tw2, h-73-th2/2)
	surface.DrawText("lvl") 

	/* Center HUD */
	if self.HUDShowVel then 
		surface.SetFont("HUD_CENTER") 
		tw = surface.GetTextSize("VELOCITY") 
		surface.SetTextPos((w/2)-99, h-115)
		surface.SetTextColor(0, 0, 0, self.HudAlpha) 
		surface.DrawText("VELOCITY")
		surface.SetTextPos((w/2)-100, h-116)
		surface.SetTextColor(255, 255, 255, self.HudAlpha) 
		surface.DrawText("VELOCITY") 

		Text = tostring(math.floor(self.HUDVel)) 
		tw = surface.GetTextSize(Text) 
		surface.SetTextPos((w/2)+90-tw, h-115)
		surface.SetTextColor(0, 0, 0, self.HudAlpha) 
		surface.DrawText(Text) 
		surface.SetTextPos((w/2)+90-tw, h-116)
		surface.SetTextColor(255, 255, 255, self.HudAlpha) 
		surface.DrawText(Text) 

		surface.SetDrawColor(255, 255, 255, self.HudAlpha)
		surface.SetMaterial(HUD_CENTER) 
		surface.DrawTexturedRect((w/2)-121, h-106, 256, 64) 

		render.SetScissorRect((w/2)-100, h-86, (w/2)-100+(190*self.HUDVelFrac), h-74, true)
		surface.SetDrawColor(255, 255, 255, self.HudAlpha*0.85)
		surface.SetMaterial(HUD_BAR_CENTER) 
		surface.DrawTexturedRect((w/2)-103, h-89, 256, 32) 
		render.SetScissorRect((w/2)-100, h-86, (w/2)-100+(190*self.HUDVelFrac), h-74, false) 
	end 

	/* Right HUD (Ammo) */
	surface.SetDrawColor(255, 255, 255, self.HudAlpha) 
	surface.SetMaterial(HUD_RIGHT) 
	surface.DrawTexturedRect(w-356, h-106, 256, 64) 
	
	surface.SetDrawColor(255, 255, 255, self.HudAlpha)
	surface.SetMaterial(HUD_RIGHT_CIRCLE) 
	surface.DrawTexturedRect(w-179, h-173, 256, 256) 

	Text = "" 
	wep = LocalPlayer():GetActiveWeapon() 
	if !wep or !wep:IsValid() or !wep.Clip1 or wep:Clip1() == -1 or GetPrimaryClipSize(wep) == 0 then 
		if GetPrimaryClipSize(wep) then 
			Text = tostring(GetPrimaryClipSize(wep)).." / "
		else 
			Text = "0 / " 
		end 
		frac = math.Approach(frac, 1, 0.01)
		if wep and wep:IsValid() then 
			Text = Text..tostring(LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType())) 
		else 
			Text = Text.."0"
		end 
	else 
		Text = tostring(wep:Clip1()).." / "..tostring(LocalPlayer():GetAmmoCount(wep:GetPrimaryAmmoType()))
		frac = math.Approach(frac, wep:Clip1()/GetPrimaryClipSize(wep), 0.01) 
	end 

-- 172, 13
	render.SetScissorRect(w-162-172*frac, h-87, w-162, h-74, true)
	surface.SetDrawColor(255, 255, 255, self.HudAlpha*0.85) 
	surface.SetMaterial(HUD_AMMO) 
	surface.DrawTexturedRect(w-334, h-87, 256, 16)
	render.SetScissorRect(w-162-172*frac, h-87, w-162, h-74, false)

	surface.SetFont("HUD_CENTER") 
	surface.SetTextColor(255, 255, 255, self.HudAlpha) 
	surface.SetTextPos(w-334, h-116) 
	surface.DrawText(Text) 
	
	Text = "a"
	if LocalPlayer():Alive() and LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon().GetHoldType and weaponImgs[LocalPlayer():GetActiveWeapon():GetHoldType()] then 
		Text = weaponImgs[LocalPlayer():GetActiveWeapon():GetHoldType()] 
	end 
	surface.SetFont("HUD_WEPS") 
	tw, th = surface.GetTextSize(Text) 
	surface.SetTextColor(35, 35, 35, self.HudAlpha) 
	surface.SetTextPos(w-95-tw/2, h-95-th/2)
	surface.DrawText(Text) 

	Text = "None" 
	if LocalPlayer():Alive() and LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon().GetPrintName then 
		Text = LocalPlayer():GetActiveWeapon():GetPrintName() 
	end 

	surface.SetFont("HUD_CENTER") 
	surface.SetTextColor(35, 35, 35, 255) 
	tw, th = surface.GetTextSize(Text) 
	surface.SetTextPos(w-95-tw/2, h-60-th/2) 
	surface.DrawText(Text) 
end 