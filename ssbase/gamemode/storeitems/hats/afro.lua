ITEM.ID = "afro"							--Should be a unique string that identifies the item
ITEM.Name = "Afro"						--The name the item should display
 
ITEM.Price = 2000
 
ITEM.Model = "models/mrgiggles/skeyler/hats/afro.mdl"			--Model used by the item

ITEM.Type = "hat"								--Also works for stuff like "mask" and such. Used for item compatibility

ITEM.Bone = "ValveBiped.Bip01_Head1"			--Bone the item is attached to. ONLY NEED TO DEFINE FOR HATS/ACCESSORIES.
ITEM.BoneMerge = false							--May be used for certain accessories to bonemerge the item instead. ONLY NEED TO DEFINE FOR HATS/ACCESSORIES.

ITEM.Colorable = false							--Used if the model is colorable via setcolor (or in a models case, setplayercolor)
ITEM.Tintable = false							--Used if the model is colorable, but a translation is needed to $selfillumtint 

ITEM.Rotate = 135

ITEM.CamPos = Vector(50, 30, 0)						-- Used the modify the position of the camera on DModelPanels 
ITEM.LookAt = Vector(0, 0, 0) 							-- Used to change the angle at which the camera views the model 
ITEM.Fov = 20 

ITEM.Functions = {} 								--anything that can be called but not a gmod hook but more of a "store hook" goes here

ITEM.Functions["Equip"] = function ()
												--e.g miku hair attach with the models Equip
end

ITEM.Functions["Unequip"] = function ()
												--e.g miku hair attach with the models Equip
end

ITEM.Hooks = {}

ITEM.Hooks["Think"] = function ()
												--could run some shit in think hook maybe clientside only (e.g. repositioning or HEALTH CALCULATIONS OR SOMETHING LIKE THAT)
end

ITEM.Models = {} 
ITEM.Models["tron"] = {pos=Vector(0, -1.05, 2.85), ang=Angle(90, 0, -90), scale=0.95} 