---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- 统一注册 【 images\inventoryimages 】 里的所有图标
--- 每个 xml 里面 只有一个 tex

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

if Assets == nil then
    Assets = {}
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[
		
	重构 Asset 类，让普通物品图片 跟着注册 ATLAS_BUILD 素材类。这样，在加载普通物品图片的时候，会自动注册 ATLAS_BUILD 素材类。

	同时创建一个函数声明，这个路径已经被 注册过。

	]]--
	
	local custom_atlas_builds = {}
	local official_atlas_builds = {}
	rawset(_G, "FWD_IN_PDT_IS_CUSTOM_ATLAS_BUILD", function (atlas)
		return custom_atlas_builds[atlas] or false
	end)

	-- 原始的 Asset 类定义 在 prefabs.lua 里。
	-- 获取原始的 _ctor 函数
	local originalCtor = Asset._ctor

	-- 创建一个新的构造函数
	local newCtor = function(self, type, file, param,...)

		-- 如果 type 是 "ATLAS"，则打印 file
		if type == "ATLAS" then --- 普通素材
			-- print("++++",file)
			if string.find(file, "/inventoryimages/") then
				custom_atlas_builds[file] = true
				table.insert(Assets, Asset("ATLAS_BUILD",file,256))
				print("Info: Succeeded in registering item ATLAS_BUILD", file)
			end
		elseif type == "ATLAS_BUILD" and param ~= 256 then
			official_atlas_builds[file] = true
		end
		-- 调用原始的构造函数
		return originalCtor(self, type, file, param,...)		
	end
	-- 替换原始的构造函数
	Asset._ctor = newCtor
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


local files_name = {
	-- 分类放减少排查时间
	-- 01_t_b_b_item
		"gardening_book",				-- 黑书
		
	---------------------------------------------------------------------------------------

}

for k, name in pairs(files_name) do
    table.insert(Assets, Asset( "IMAGE", "images/inventoryimages/".. name ..".tex" ))
    table.insert(Assets, Asset( "ATLAS", "images/inventoryimages/".. name ..".xml" ))
	-- table.insert(Assets, Asset("ATLAS_BUILD", "images/inventoryimages/".. name ..".xml", 256) )
	RegisterInventoryItemAtlas("images/inventoryimages/".. name ..".xml", name .. ".tex")
end


