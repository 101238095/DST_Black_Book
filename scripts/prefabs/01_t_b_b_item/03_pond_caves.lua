-- 带黑书tag 才能做的洞穴池塘
local assets =
{
    Asset("ANIM", "anim/pond_cave.zip"),
    Asset( "IMAGE", "images/map_icons/t_b_b_pond_cave.tex" ),
	Asset( "ATLAS", "images/map_icons/t_b_b_pond_cave.xml"),
}

local prefabs =
{
    "pond_cave",
}

return MakePlacer("pond_cave_placer","pond_cave","pond_cave","idle")
