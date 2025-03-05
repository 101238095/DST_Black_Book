--------------------------------------------------------------------------------------------
------ 常用函数放 TUNING 里
--------------------------------------------------------------------------------------------
----- RPC 命名空间
TUNING["The_Black_Book.RPC_NAMESPACE"] = "The_Black_Book_RPC"


--------------------------------------------------------------------------------------------

TUNING["The_Black_Book.fn"] = {}
TUNING["The_Black_Book.fn"].GetStringsTable = function(prefab_name)
    -------- 读取文本表
    -------- 如果没有当前语言的问题，调取中文的那个过去
    -------- 节省重复调用运算处理
    if TUNING["The_Black_Book.fn"].GetStringsTable_last_prefab_name == prefab_name then
        return TUNING["The_Black_Book.fn"].GetStringsTable_last_table or {}
    end


    local LANGUAGE = "ch"
    if type(TUNING["The_Black_Book.Language"]) == "function" then
        LANGUAGE = TUNING["The_Black_Book.Language"]()
    elseif type(TUNING["The_Black_Book.Language"]) == "string" then
        LANGUAGE = TUNING["The_Black_Book.Language"]
    end
    local ret_table = prefab_name and TUNING["The_Black_Book.Strings"][LANGUAGE] and TUNING["The_Black_Book.Strings"][LANGUAGE][tostring(prefab_name)] or nil
    if ret_table == nil and prefab_name ~= nil then
        ret_table = TUNING["The_Black_Book.Strings"]["ch"][tostring(prefab_name)]
    end

    ret_table = ret_table or {}
    TUNING["The_Black_Book.fn"].GetStringsTable_last_prefab_name = prefab_name
    TUNING["The_Black_Book.fn"].GetStringsTable_last_table = ret_table

    return ret_table
end


-- --------------------------------------------------------------------------------------------
-- ---- 统一 func 初始化列表
TUNING["The_Black_Book.World_Com_Func"] = {"map_modifier","normal_api"}
TUNING["The_Black_Book.Player_Com_Func"] = {"player","rpc","skin_player","cross_archived_data_sys","camera","picksound","pre_dodelta","vip","daily_task","normal_api","jade_coin_sys","personal_skin_unlocker"}



--------------------------------------------------------------------------------------------
local function GetStringsTable(prefab_name)
    return TUNING["The_Black_Book.fn"].GetStringsTable(prefab_name)
end
--------------------------------------------------------------------------------------------
--- 自制一个多返回值的pcall ，应对hook 官方 api的可能问题。
--- 返回一个 table ，需要 unpack(list, i, j) 函数
rawset(_G,"t_b_b_pcall",function(fn,...)
    local temp_ret_table = {pcall(fn,...)}
    local crash_flag = true
    local ret_pack = {}
    for k, v in pairs(temp_ret_table) do
        if k == 1 then
            crash_flag = v
        else
            table.insert(ret_pack,v)
        end
    end
    return crash_flag,ret_pack
end)
--------------------------------------------------------------------------------------------