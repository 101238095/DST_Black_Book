----------------------------------------------------------------------------------------------------------------------------------------------
--- 新建一个分类，然后往这个分类里加自己的东西

----------------------------------------------------------------------------------------------------------------------------------------------
-- AddRecipeFilter({name="PANDA_SPELL",atlas = "images/spell_images/SpellTag.xml",	image = "SpellTag.tex"},2)
local function GetStringsTable(prefab_name)
    return TUNING["The_Black_Book.fn"].GetStringsTable(prefab_name) or {}
end


----------------------------------------------------------------------------------------------------------------------------------------------
-- -- 添加分类栏目
-- table.insert(Assets,      Asset("ATLAS", "images/ui_images/fwd_in_pdt_buildings.xml")                         )     --  -- 载入贴图文件
-- table.insert(Assets,      Asset("IMAGE", "images/ui_images/fwd_in_pdt_buildings.tex")                         )     --  -- 载入贴图文件
-- RegisterInventoryItemAtlas("images/ui_images/fwd_in_pdt_buildings.xml", "fwd_in_pdt_buildings.tex")  -- 注册贴图文件【必须要做】
-- AddRecipeFilter({name="FWD_IN_PDT", atlas = "images/ui_images/fwd_in_pdt_buildings.xml",	image = "fwd_in_pdt_buildings.tex"})
-- STRINGS.UI.CRAFTING_FILTERS["FWD_IN_PDT"] = GetStringsTable("fwd_in_pdt_ui_craftingmenu")["FWD_IN_PDT"] or ""
-- --------------------------------------------------------------------------------------------------------------------------------------------
-- require("recipes_filter")
--------------------------------------------------------------------------------------------------------------------------------------------
-- 【笔记】AddRecipe2参数说明

-- name (string)：配方的名称，通常用prefab名
-- ingredients (table)：配方所需的原料表。
-- tech (string)：解锁该配方所需的科技
-- (可选) config (table)：一个可选的配置表，包含 Recipe2 类构造函数中的可选字段。
-- (可选) filters (table)：一个可选的过滤器列表，包含要将配方添加到的过滤器名称。
-- 其中， config表key如下：
-- (可选)placer(string)：放置物 prefab，用于显示一个建筑的临时放置物，在放下建筑后就会消失。
-- (可选) min_spacing (num)：建造物的最小间距。
-- (可选)nounlock (bool)：如果为 false，只能在对应的科技建筑旁制作。否则在初次解锁后，就可以在任意地点制作。
-- (可选)numtogive (num)：制作成功后，玩家将获得的物品数量。
-- (可选)builder_tag (string)：要求具备的制作者标签。如果人物没有此标签，便无法制作物品，可以用于人物的专属物品。
-- (必须)atlas (string)：物品图标所在的 atlas 文件路径，用于制作栏显示图片，其实不填也行，但图标会是空的。
-- (可选)image (string)：物品图标的文件名，其实 atlas 中已包含，不必再填。
-- (可选)testfn (function)：放置时的检测函数，比如有些建筑对地形有特殊要求，可以使用此函数检测。
-- (可选)product (string)：产出物，表示制作成功后产生的物品。默认
-- (可选)build_mode (string)：建造模式，必须使用常量表BUILDMODE，形如BUILDMODE.LAND，具体取值为无限制（NONE）、地上（LAND）和水上（WATER）。
-- (可选)build_distance (num)：建造距离，表示玩家与建筑之间的最大距离。
----------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
-- 【笔记】过滤器相关
-- 创建自定义过滤器需要用到ModAPI AddRecipeFilter ，流程如下。

-- 首先，定义一个过滤器（filter_def），它是一个table，包含以下key：

-- name (string)：过滤器的 ID，需要将该名称添加到 STRINGS.UI.CRAFTING_FILTERS[name]。
-- atlas (string 或 function)：图标的图集，可以是字符串或函数。
-- image (string 或 function)：显示在制作菜单中的图标，可以是字符串或函数。
-- (可选) image_size (table)：自定义图像尺寸，默认64。
-- (可选) custom_pos (table)：自定义的过滤器位置，默认为false。 如果为 true，则过滤器图标不会被添加到网格中，而是把这个分类下的物品都放在mod物品分类下。
-- recipes (table)：不要使用！ 请创建过滤器后，将过滤器传递给 AddRecipe2() 或 AddRecipeToFilter() 函数。
-- 然后，调用 AddRecipeFilter ，将过滤器传入：

-- AddRecipeFilter(filter_def, index)
-- 其中，index表示过滤器在界面中的位置，如果不提供，则会添加到最后。

-- 最后，在创建配方时，使用 AddRecipe2 或 AddCharacterRecipe 函数，将配方添加到相应的过滤器中。例如：AddRecipe2(name, ingredients, tech, config, filters) ，
-- 其中filters 是一个包含过滤器名称的列表，配方会被添加到这些过滤器中。

-- 下面是一个创建自定义过滤器的示例：

-- -- 加载资源
-- Assets = {
--     Asset("ATLAS", "images/craft_samansha_icon.xml"),
-- }

-- -- 定义一个新的过滤器对象
-- local filter_samansha_def = {
--     name = "SAMANSHA",
--     atlas = "images/craft_samansha_icon.xml",
--     image = "craft_samansha_icon.tex"
-- }

-- -- 添加自定义过滤器
-- AddRecipeFilter(filter_samansha_def, 1) -- 这个1貌似是所在位置
-- STRINGS.UI.CRAFTING_FILTERS.SAMANSHA ="自定义过滤器" -- 制作栏中显示的名字 -- 【注意：这里要全程大写 别写错了】
----------------------------------------------------------------------------------------------------------------------------------------------
-- 冰箱
--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("mega_freezer","STRUCTURES")     ---- 添加物品到目标标签
AddRecipe2(
    "mega_freezer",            --  --  inst.prefab  实体名字
    { Ingredient("bearger_fur", 1),Ingredient("bluegem", 1),Ingredient("gears", 2) }, 
    TECH.SCIENCE_TWO, --- TECH.二本科技
    {
        min_spacing = 0,
        -- build_distance = 10,
        -- nounlock=true,
        no_deconstruction=false,
        builder_tag = "gardeing_master",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        placer = "mega_freezer_placer",                       -------- 建筑放置器        
        atlas = "images/map_icons/mega_freezer.xml",
        image = "mega_freezer.tex",
    },
    {"STRUCTURES"}
)
--------------------------------------------------------------------------------------------------------------------------------------------
-- 花
--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("planted_flower","MODS")     ---- 添加物品到目标标签
AddRecipe2(
    "planted_flower",            --  --  inst.prefab  实体名字
    { Ingredient("seeds", 3)}, 
    TECH.NONE, --- TECH.不需要科技  但是需要builder_tag
    {
        -- nounlock=true,
        no_deconstruction=false,
        builder_tag = "gardeing_master",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        placer = "planted_flower_placer",                       -------- 建筑放置器        
        atlas = "images/map_icons/planted_flower.xml",
        image = "planted_flower.tex",
    },
    {}
)
--------------------------------------------------------------------------------------------------------------------------------------------
-- 洞穴池塘
--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("pond_cave","MODS")     ---- 添加物品到目标标签
AddRecipe2(
    "pond_cave",            --  --  inst.prefab  实体名字
    { Ingredient("pondeel", 20)}, 
    TECH.NONE, --- TECH.不需要科技  但是需要builder_tag
    {
        -- nounlock=true,
        no_deconstruction=false,
        builder_tag = "gardeing_master",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        placer = "pond_cave_placer",                       -------- 建筑放置器        
        atlas = "images/map_icons/t_b_b_pond_cave.xml",
        image = "t_b_b_pond_cave.tex",
    },
    {}
)
--------------------------------------------------------------------------------------------------------------------------------------------