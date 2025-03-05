-- 带黑书tag才能做的冰柜(原代码来自负重)
local assets =
{
    Asset("ANIM", "anim/mega_freezer.zip"),
    Asset( "IMAGE", "images/map_icons/mega_freezer.tex" ), 
    Asset( "ATLAS", "images/map_icons/mega_freezer.xml" ),
}
local RUMMAGE = ACTIONS.RUMMAGE
if RUMMAGE then
    if RUMMAGE.distance == nil or RUMMAGE.distance < 3 then
        RUMMAGE.distance = 3
    end

end
-- local containers = require("containers")
-- containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, 49)
-- print("Item position:", item.Transform:GetWorldPosition())
---- 安装容器界面
local function container_Widget_change(theContainer)
    -----------------------------------------------------------------------------------
    ----- 容器界面名 --- 要独特一点，避免冲突
    local container_widget_name = "mega_freezer_widget"

    -----------------------------------------------------------------------------------
    ----- 检查和注册新的容器界面
    local all_container_widgets = require("containers")  --- 所有容器的总表
    local params = all_container_widgets.params             ---- 总参数表。 index 为该界面名字。
    if params[container_widget_name] == nil then            ---- 如果该界面不存在总表，则按以下规则注册。
        params[container_widget_name] = {
            widget =
            {
                slotpos = {},
                animbank = "ui_fish_box_5x4",   --- 格子背景动画
                animbuild = "ui_fish_box_5x4",  --- 格子背景动画
                pos = Vector3(0, 200, 0),       --- 基点坐标
                side_align_tip = 160,

            },
            type = "chest",
            acceptsstacks = true,               --- 是否允许叠堆 
        }
        ------ 格子的布局(5X4)
        for y = 2.5, -0.5, -1 do
            for x = -1, 3 do
                table.insert(params[container_widget_name].widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
            end
        end
        ---尝试用一下官方的写法 来控制item 的进出（成功，官方的冰箱，这样不用去声明一些食物类型）
        params[container_widget_name].itemtestfn =  function(container_com, item, slot)
            
            if item:HasTag("icebox_valid") then
                return true
            end

            --Perishable
            if not (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled")) then
                return false
            end

            if item:HasTag("smallcreature") then   -- 小生物可以
                return true
            end

            --Edible
            for k, v in pairs(FOODTYPE) do
                if item:HasTag("edible_"..v) then
                    return true
                end
            end

            return false
        end
    end
    -------------------------------------------------------------------------------------------
    ----- 检查、注册完 容器界面后，安装界面给  container 组件。replica 和 component  都是用的相同函数 安装
    theContainer:WidgetSetup(container_widget_name)
    ------------------------------------------------------------------------
    --- 开关声音。如果注释掉，则是默认的开关声音。
        -- if theContainer.widget then
        --     theContainer.widget.closesound = "turnoftides/common/together/water/splash/small"
        --     theContainer.widget.opensound = "turnoftides/common/together/water/splash/small"
        -- end
    ------------------------------------------------------------------------
end

local function add_container_before_not_ismastersim_return(inst)
    -------------------------------------------------------------------------------------------------
    ------ 添加背包container组件    --- 必须在 SetPristine 之后，
        if TheWorld.ismastersim then
            inst:AddComponent("container")
            -- inst.components.container.openlimit = 1  ---- 限制1个人打开
            container_Widget_change(inst.components.container)
        else
            ------- 在客户端必须执行容器界面注册。不能像科雷那样只在服务端注册。
            inst.OnEntityReplicated = function(inst)
                container_Widget_change(inst.replica.container)
            end
        end
    -------------------------------------------------------------------------------------------------
end
-------------------------------------------------------------------------------------
-- 产冰块
local function spawnIce(inst)
    local n = math.random(0, 2)
    for i = 1,n do
        inst.components.container:GiveItem(SpawnPrefab("ice"))
    end
    if n >= 1 then
        inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/iceboulder_smash")
    end
end
local function onWatchWorldState(inst)
    --- 延迟执行吧，不然这一瞬间执行的东西太多了
        inst:DoTaskInTime(5, spawnIce)
    end
-------------------------------------------------------------------------------------
---- 打开、关闭 容器的时候触发的事件。可以用来播放动画
local function onopen(inst)
    inst.AnimState:PlayAnimation("opened")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_open")
end

local function onclose(inst)
    inst.AnimState:PlayAnimation("closed")
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_close")
end
-------------------------------------------------------------------------------------
local function onhammered(inst, worker)
    inst.components.lootdropper:DropLoot()
    inst.components.container:DropEverything()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("metal")
    inst:Remove()
end
local function onhit(inst, worker)
    inst.components.container:DropEverything()
    -- inst.AnimState:PlayAnimation("idle")
    inst.components.container:Close()
end
-------------------------------------------------------------------------------------
local function fn()
-------------------------------------------------------------------------------------
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.MiniMapEntity:SetIcon("mega_freezer.tex")       -- 减少卡顿？能吗？ 反正我写了无所谓~

    -- inst:SetDeploySmartRadius(0)         -- 智能放置半径

    MakeObstaclePhysics(inst, 0.5)---设置一下距离

    inst.AnimState:SetBank("mega_freezer")
    inst.AnimState:SetBuild("mega_freezer")
    inst.AnimState:PlayAnimation("closed")

    inst:AddTag("fridge")  --- 有这个才能给暖石降温
    inst:AddTag("structure")
    inst:AddTag("mega_freezer")


    -- 新更新的反鲜写法
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(-500000)  -- 嗖的一下就反鲜了 ~
    
    -- inst:AddComponent("container")
    
    inst.entity:SetPristine()
-------------------------------------------------------------------------------------
    add_container_before_not_ismastersim_return(inst)   --- 安装容器界面

-------------------------------------------------------------------------------------
if not TheWorld.ismastersim then
    return inst
end
-------------------------------------------------------------------------------------

    inst:AddComponent("inspectable")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
-------------------------------------------------------------------------------------
    inst:AddComponent("lootdropper")
---- 被敲打拆除设置次数
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
-------------------------------------------------------------------------------------
    inst:ListenForEvent("onbuilt",function()
        inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
        ---- 刚刚制作出来才会触发的代码，通常用来触发 建造动画。
    end)
-------------------------------------------------------------------------------------
inst:WatchWorldState( "isday", onWatchWorldState)
inst:WatchWorldState( "iscaveday", onWatchWorldState)

    return inst
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return Prefab("mega_freezer", fn, assets),
    MakePlacer("mega_freezer_placer", "mega_freezer", "mega_freezer", "closed")