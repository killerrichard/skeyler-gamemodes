---------------------------
--       Bunny Hop       -- 
-- Created by xAaron113x --
---------------------------

include("shared.lua")
include("sh_levels.lua") 
include("sh_viewoffsets.lua") 
include("player_class/player_bhop.lua")
include("cl_difficulty_menu.lua")

GM.DifficultyMenu = false 
function GM:CreateDifficultyMenu() 
	self:SetGUIBlur(true) 

	if self.DifficultyMenu then 
		if self.DifficultyMenu:IsVisible() then 
			gui.EnableScreenClicker(false)
			self.DifficultyMenu:SetVisible(false) 
			self:SetGUIBlur(false) 
			return 
		end 
		self.DifficultyMenu:SetVisible(true) 
		gui.EnableScreenClicker(true)
		return 
	end 

	self.DifficultyMenu = vgui.Create("SS_DifficultyMenu") 
	gui.EnableScreenClicker(true)
end 
concommand.Add("open_difficulties", function() GAMEMODE:CreateDifficultyMenu() end)

timer.Create("HullstuffSadface",5,0,function()
	if(LocalPlayer() && LocalPlayer():IsValid() && LocalPlayer().SetHull && LocalPlayer().SetHullDuck) then
		if(LocalPlayer().SetViewOffset && LocalPlayer().SetViewOffsetDucked && !viewset) then
			LocalPlayer():SetViewOffset(Vector(0, 0, 64))
			LocalPlayer():SetViewOffsetDucked(Vector(0, 0, 47))
			viewset = true
		end
		LocalPlayer():SetHull(Vector(-16, -16, 0), Vector(16, 16, 62))
		LocalPlayer():SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 45))
	end
end)