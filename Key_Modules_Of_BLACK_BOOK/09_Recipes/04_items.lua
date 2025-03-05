--------------------------------------------------------------------------------------------------------------------------------------------
--[[
        物品【不含placer】
]]--
--------------------------------------------------------------------------------------------------------------------------------------------
-- 列表留在这里了 想调用随时用
-- CHARACTER               冒险家物品
-- TOOLS                   工具
-- LIGHT                   光源
-- PROTOTYPERS             原型工具和制作站
-- REFINE                  精炼材料
-- WEAPONS                 武器
-- ARMOUR                  盔甲
-- CLOTHING                服装
-- RESTORATION             治疗
-- MAGIC                   暗影魔法
-- DECOR                   装饰
-- STRUCTURES              建筑
-- CONTAINERS              储物方案
-- COOKING                 烹饪
-- GARDENING               食物和耕种
-- FISHING                 钓鱼
-- SEAFARING               航行
-- RIDING                  骑乘皮弗娄牛
-- WINTER                  冬季物品
-- SUMMER                  夏季物品
-- RAIN                    雨具
-- EVERYTHING              所有物品
-- FAVORITES               收藏夹
-- CRAFTING_STATION        制作站
-- SPECIAL EVENT           特殊活动
-- MODS                    模组物品
--------------------------------------------------------------------------------------------------------------------------------------------
---- 黑书
--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("gardening_book","MODS")     ---- 添加物品到目标标签
AddRecipe2(
    "gardening_book",            --  --  inst.prefab  实体名字
    { Ingredient("nightmarefuel", 10) , Ingredient("papyrus", 2) }, 
    TECH.SCIENCE_TWO, --- 二本
    {
        -- nounlock=true,
        no_deconstruction=false,
        -- builder_tag = "npng_tag.has_green_amulet",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        -- placer = "fwd_in_pdt_item_talisman_that_repels_snakes",                       -------- 建筑放置器        
        atlas = "images/inventoryimages/gardening_book.xml",
        image = "gardening_book.tex",
    },
    {"MAGIC"}
)
-- RemoveRecipeFromFilter("gardening_book","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
---- 黑书pro
--------------------------------------------------------------------------------------------------------------------------------------------
AddRecipeToFilter("gardening_book_pro","MODS")     ---- 添加物品到目标标签
AddRecipe2(
    "gardening_book_pro",            --  --  inst.prefab  实体名字
    { Ingredient("gardening_book", 1) ,Ingredient("yellowamulet", 1), Ingredient("greenamulet", 1), Ingredient("thulecite", 5) }, 
    TECH.ANCIENT_FOUR, --- 完整科学站
    {
        -- nounlock=true,
        no_deconstruction=false,
        -- builder_tag = "npng_tag.has_green_amulet",    --------- -- 【builder_tag】只给指定tag的角色能制造这件物品，角色添加/移除 tag 都能立马解锁/隐藏该物品
        -- placer = "fwd_in_pdt_item_talisman_that_repels_snakes",                       -------- 建筑放置器        
        atlas = "images/inventoryimages/gardening_book.xml",
        image = "gardening_book.tex",
    },
    {"MAGIC"}
)
-- RemoveRecipeFromFilter("gardening_book","MODS")                       -- -- 在【模组物品】标签里移除这个。

--------------------------------------------------------------------------------------------------------------------------------------------
