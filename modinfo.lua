author = "可爱的小亨、赵sir"
-- from stringutil.lua

local function ChooseTranslationTable_Test(_table)
  if ChooseTranslationTable then
    return ChooseTranslationTable(_table)
  else
    return _table["zh"]
  end
end


----------------------------------------------------------------------------
--- 版本号管理（暂定）：最后一位为内部开发版本号，或者修复小bug的时候进行增量。
---                   倒数第二位为对外发布的内容量版本号，有新内容的时候进行增量。
---                   第二位为大版本号，进行主题更新、大DLC发布的时候进行增量。
---                   第一位暂时预留。 
----------------------------------------------------------------------------
local the_version = "0.0.0.0003"



local function Check_Mod_is_Internal_Version()
  if folder_name and (folder_name == "The_Blcak_Book" or folder_name == "DST_MOD_The_Blcak_Book") then
      return true
  end
  return false
end

local function GetName()
  ----------------------------------------------------------------------------
  ---- 参数表： loc.lua 里面的localizations 表，code 为 这里用的index
  local temp_table = {
      "The Blcak Book",                               ----- 默认情况下(英文)
      ["zh"] = "黑书",                                 ----- 中文
  }

  local temp_table_internal = {
    "The Blcak Book (BETA)",                               ----- 默认情况下(英文)
    ["zh"] = "黑书(BETA)",                                 ----- 中文
  }

  if Check_Mod_is_Internal_Version() then
    return ChooseTranslationTable_Test(temp_table_internal)
  end
  return ChooseTranslationTable_Test(temp_table)
end

local function GetDesc()
    local temp_table = {
      [[
        A magic book.
      ]],
      ["zh"] = [[
		一本很神奇的书
      ]]
    }
    local ret = the_version .. "  \n  "..ChooseTranslationTable_Test(temp_table)
    return ret
end

name = GetName()
description = GetDesc()

version = the_version ------ MOD版本，上传的时候必须和已经在工坊的版本不一样

api_version = 10
icon_atlas = "modicon.xml"
icon = "modicon.tex"
forumthread = ""
dont_starve_compatible = true
dst_compatible = true
all_clients_require_mod = true

-- priority = -10000000000  -- MOD加载优先级 影响某些功能的兼容性，比如官方Com 的 Hook
priority = 10000000000  -- MOD加载优先级 影响某些功能的兼容性，比如官方Com 的 Hook


local function IsChinese()
  if locale == nil then
    return true
  else
    return locale == "zh" or locate == "zht" or locate == "zhr" or false
  end
end

configuration_options =
{
	{
        name = "LANGUAGE",
        label = "Language/语言",
        hover = "Set Language/设置语言",
        options =
        {
          {description = "Auto/自动", data = "auto"},
          {description = "English", data = "en"},
          {description = "中文", data = "ch"},
        },
        default = "auto",
    },
  }
