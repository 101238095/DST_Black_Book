-- 带黑书tag才能做的花
local assets =
{
    Asset("ANIM", "anim/flowers.zip"),
    Asset( "IMAGE", "images/map_icons/planted_flower.tex" ),
	Asset( "ATLAS", "images/map_icons/planted_flower.xml"),
}

local prefabs =
{
    "planted_flower",
}

return MakePlacer("planted_flower_placer","flowers","flowers","f1")
