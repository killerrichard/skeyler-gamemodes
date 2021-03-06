---------------------------- 
--         SSBase         -- 
-- Created by Skeyler.com -- 
---------------------------- 

ITEM.ID = "tail_bunny"										-- Should be a unique string that identifies the item
ITEM.Name = "Tail (Bunny)"									-- The name the item should display
 
ITEM.Price = 2000
 
ITEM.Model = "models/captainbigbutt/skeyler/accessories/tail_bunny.mdl"	-- Model used by the item

ITEM.Type = "tail"											-- Also works for stuff like "mask" and such. Used for item compatibility

ITEM.Colorable = true										-- Used if the model is colorable via setcolor (or in a models case, setplayercolor)
ITEM.Tintable = false										-- Used if the model is colorable, but a translation is needed to $selfillumtint 

ITEM.Rotate = 45

ITEM.CamPos = Vector(4, 23, 0)							-- Used the modify the position of the camera on DModelPanels 
ITEM.LookAt = Vector(-4, 0, 0) 							-- Used to change the angle at which the camera views the model 
ITEM.Fov = 20 

ITEM.Slot = SS.STORE.SLOT.ACCESSORY_4						-- What inventory slot this item shoud be placed in.

ITEM.Functions = {} 										-- Anything that can be called but not a gmod hook but more of a "store hook" goes here

ITEM.Functions["Equip"] = function ()						-- e.g miku hair attach with the models Equip
end

ITEM.Functions["Unequip"] = function ()						-- e.g miku hair attach with the models Equip
end

ITEM.Hooks = {}												-- Could run some shit in think hook maybe clientside only (e.g. repositioning or HEALTH CALCULATIONS OR SOMETHING LIKE THAT)

ITEM.Hooks["UpdateAnimation"] = function (data, ply)
	if CLIENT then
		if (data) then
			local info = data[SS.STORE.SLOT.ACCESSORY_4]
			
			if (info and info.item and IsValid(info.entity)) then
				if(ply:GetVelocity():Length2D() <= 150 and ply:GetVelocity():Length2D() >= 1 ) then
					ply.idle = false
					ply.walking = true
					ply.running = false
				elseif(ply:GetVelocity():Length2D() > 150) then
					ply.idle = false
					ply.walking = false
					ply.running = true
				elseif(ply:GetVelocity():Length2D() == 0) then
					ply.idle = true
					ply.walking = false
					ply.running = false
				else
					ply.idle = true
					ply.walking = false
					ply.running = false
				end
				
				if ply.idle then
					if info.entity:GetSequence() > 6 then
						info.entity:SetSequence(math.random(1,6))
					end
				elseif ply.walking then 
					if info.entity:GetSequence() != 7 then
						info.entity:SetSequence(7) 
					end
				elseif ply.running then
					if info.entity:GetSequence() < 8 then
						info.entity:SetSequence(math.random(8,11)) 
					end
				end
				if(info.entity.lastthink) then
					info.entity:FrameAdvance(CurTime()-info.entity.lastthink) --this function better fucking work I HAD TO FIND THIS IN DMODELPANEL ITS NOT EVEN DOCUMENTED!
				end
				info.entity.lastthink = CurTime()
			end
		end
	end
end

/* ACCESSORY VARIABLES */
ITEM.Bone = "ValveBiped.Bip01_Spine"						-- Bone the item is attached to. ONLY NEED TO DEFINE FOR HATS/ACCESSORIES.
ITEM.BoneMerge = false										-- May be used for certain accessories to bonemerge the item instead. ONLY NEED TO DEFINE FOR HATS/ACCESSORIES.

ITEM.Models = {} 
ITEM.Models[SS.STORE.MODEL.DANTE] = {{0, 0, 0, pos=Vector(0.3, -1, -0.6), ang=Angle(5, 180, -90), scale=2.0774}}
ITEM.Models[SS.STORE.MODEL.ELIN] = {{0, 0, 0, pos=Vector(0.3, -3.3, -0.6), ang=Angle(5, 180, -90), scale=2.0774}}
ITEM.Models[SS.STORE.MODEL.MIKU] = {{0, 0, 0, pos=Vector(-0.5, -3.7, -0.6), ang=Angle(0, 180, -90), scale=2.0774}}
ITEM.Models[SS.STORE.MODEL.TRON] = {{0, 0, 0, pos=Vector(0.2, -3.5, -0.6), ang=Angle(0, 180, -90), scale=2.0774}}
ITEM.Models[SS.STORE.MODEL.USIF] = {{0, 0, 0, pos=Vector(1.5, -0.75, -0.6), ang=Angle(0, 180, -90), scale=2.0774}}
ITEM.Models[SS.STORE.MODEL.ZERO] = {{0, 0, 0, pos=Vector(0.35, -5.25, -0.6), ang=Angle(0, 180, -90), scale=2.0774}}
/* ************* */