---------------------------- 
--         SSBase         -- 
-- Created by Skeyler.com -- 
---------------------------- 

--FIX ME (and do icons and shit)

ITEM.ID = "pooltube"										-- Should be a unique string that identifies the item
ITEM.Name = "Duck Inner Tube"								-- The name the item should display
 
ITEM.Price = 2000
 
ITEM.Model = "models/captainbigbutt/skeyler/accessories/duck_tube.mdl"	-- Model used by the item

ITEM.Type = "pelvictube"									-- Also works for stuff like "mask" and such. Used for item compatibility

ITEM.Colorable = true										-- Used if the model is colorable via setcolor (or in a models case, setplayercolor)
ITEM.Tintable = false										-- Used if the model is colorable, but a translation is needed to $selfillumtint 

ITEM.Rotate = 45

ITEM.CamPos = Vector(45, 26, 2)								-- Used the modify the position of the camera on DModelPanels 
ITEM.LookAt = Vector(0, 0, 2) 								-- Used to change the angle at which the camera views the model 
ITEM.Fov = 20 

ITEM.Slot = SS.STORE.SLOT.ACCESSORY_3						-- What inventory slot this item shoud be placed in.

ITEM.Functions = {} 										-- Anything that can be called but not a gmod hook but more of a "store hook" goes here

ITEM.Functions["Equip"] = function ()						-- e.g miku hair attach with the models Equip
end

ITEM.Functions["Unequip"] = function ()						-- e.g miku hair attach with the models Equip
end

ITEM.Hooks = {}												-- Could run some shit in think hook maybe clientside only (e.g. repositioning or HEALTH CALCULATIONS OR SOMETHING LIKE THAT)

ITEM.Hooks["Think"] = function ()
end

/* ACCESSORY VARIABLES */
ITEM.Bone = "ValveBiped.Bip01_Pelvis"						-- Bone the item is attached to. ONLY NEED TO DEFINE FOR HATS/ACCESSORIES.
ITEM.BoneMerge = false										-- May be used for certain accessories to bonemerge the item instead. ONLY NEED TO DEFINE FOR HATS/ACCESSORIES.

ITEM.Models = {} 
ITEM.Models[SS.STORE.MODEL.DANTE] = {{0, 0, 0, pos=Vector(0, 0, -0.25), ang=Angle(-90, 0, 90), scale=1.12}}
ITEM.Models[SS.STORE.MODEL.ELIN] = {{0, 0, 0, pos=Vector(0, -1, 1), ang=Angle(-90, 0, 90), scale=1.115}}
ITEM.Models[SS.STORE.MODEL.MIKU] = {{0, 0, 0, pos=Vector(0, 0, 0.75), ang=Angle(-90, 0, 90), scale=1.125}}
ITEM.Models[SS.STORE.MODEL.TRON] = {{0, 0, 0, pos=Vector(0, -0.5, 0.75), ang=Angle(-90, 0, 90), scale=1.125}}
ITEM.Models[SS.STORE.MODEL.USIF] = {{0, 0, 0, pos=Vector(0, -1, 0), ang=Angle(-90, 0, 90), scale=1.135}}
ITEM.Models["models/captainbigbutt/skeyler/playermodels/zer0.mdl"] = {{0, 0, 0, pos=Vector(0, -1, 1), ang=Angle(-90, 0, 90), scale=1.075}}
/* ************* */