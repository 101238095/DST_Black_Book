
--- 中文文本

if TUNING["The_Black_Book.Strings"] == nil then
    TUNING["The_Black_Book.Strings"] = {}
end

local this_language = "ch"
--------- 默认加载中文文本，如果其他语言的文本缺失，直接调取 中文文本。 03_TUNING_Common_Func.lua
--------------------------------------------------------------------------------------------------
--- 默认显示名字:  name
--- 默认显示描述:  inspect_str
--- 默认制作栏描述: recipe_desc
--------------------------------------------------------------------------------------------------
TUNING["The_Black_Book.Strings"][this_language] = TUNING["The_Black_Book.Strings"][this_language] or {
    -- 要求一一对应减少查找时间
    -- ["fwd_in_pdt_skin_test_item"] = {
    --     ["name"] = "皮肤测试物品",
    --     ["inspect_str"] = "inspect单纯的测试皮肤",
    --     ["recipe_desc"] = "测试描述666",
    -- },
    -- 01_t_b_b_item
        ["gardening_book"] = {
        ["name"] = "黑书",
        ["inspect_str"] = "一本神奇的书",
        ["recipe_desc"] = "有了这本书可以制作很多东西",
    },
        ["gardening_book_pro"] = {
        ["name"] = "黑书pro",
        ["inspect_str"] = "一本更神奇的书",
        ["recipe_desc"] = "这本书受到了建造护符的影响",
    },
        ["planted_flower"] = {
        ["name"] = "花",
        ["recipe_desc"] = "你没看错就是这么神奇",
    },
        ["pond_cave"] = {
        ["name"] = "洞穴池塘",
        ["recipe_desc"] = "你没看错就是这么神奇",
    },







    -- 03_t_b_b_container
    ["mega_freezer"] = {
        ["name"] = "大冰柜",
        ["inspect_str"] = "里面非常寒冷",
        ["recipe_desc"] = "能储存成吨的食物",
    },











}