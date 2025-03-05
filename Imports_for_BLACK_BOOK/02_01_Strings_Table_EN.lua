
--- 英文文本

if TUNING["The_Black_Book.Strings"] == nil then
    TUNING["The_Black_Book.Strings"] = {}
end

local this_language = "en"
if TUNING["The_Black_Book.Language"] then
    if type(TUNING["The_Black_Book.Language"]) == "function" and TUNING["The_Black_Book.Language"]() ~= this_language then
        return
    elseif type(TUNING["The_Black_Book.Language"]) == "string" and TUNING["The_Black_Book.Language"] ~= this_language then
        return
    end
end

TUNING["The_Black_Book.Strings"][this_language] = TUNING["The_Black_Book.Strings"][this_language] or {

    -- 01_t_b_b_item

        ["gardening_book"] = {
        ["name"] = "A Blcak Book",
        ["inspect_str"] = "A magic book.",
        ["recipe_desc"] = "If you have the black book, you can create many items.",
    },
        ["gardening_book_pro"] = {
        ["name"] = "A Blcak Book PRO",
        ["inspect_str"] = "A magic book.",
        ["recipe_desc"] = "This book was influenced by the greenamulet.",
    },
        ["planted_flower"] = {
        ["name"] = "Flower",
        ["recipe_desc"] = "So magic.",
    },
        ["pond_cave"] = {
        ["name"] = "Pond Cave.",
        ["recipe_desc"] = "So magic.",
    },







    -- 03_t_b_b_container
        ["mega_freezer"] = {
        ["name"] = "A Big Freezer.",
        ["inspect_str"] = "It's very cold in here.",
        ["recipe_desc"] = "Used to store tons of food.",
    },













}