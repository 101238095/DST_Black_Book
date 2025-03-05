-- 黑书 and 黑书pro

local assets =
{
    Asset("ANIM", "anim/book_maxwell.zip"),
	Asset("IMAGE", "images/inventoryimages/gardening_book.tex"),
	Asset("ATLAS", "images/inventoryimages/gardening_book.xml")
}


local function onPickup(inst, owner)
--    print("---- gardening_book onPickup(),"..owner.prefab)
end


local function ondropped(inst)
--    print("---- gardening_book ondropped()")
    if inst.owner then
        if inst.prefab == "gardening_book_pro" and inst.owner.components.builder then inst.owner.components.builder.ingredientmod = 1 end
        inst.owner:RemoveTag("gardeing_master")
        inst.owner = nil
        -- 看看光~
        if inst._light ~= nil then
            if inst._light:IsValid() then
                inst._light:Remove()
            end
            inst._light = nil
        end
    end
end


local function onputininventory(inst, owner)
--    print("---- gardening_book onputininventory(),"..owner.prefab)
    ondropped(inst)

    inst.owner = owner
    if inst.prefab == "gardening_book_pro" and inst.owner.components.builder then inst.owner.components.builder.ingredientmod = TUNING.GREENAMULET_INGREDIENTMOD end
    inst.owner:AddTag("gardeing_master")
    if inst._light == nil or not inst._light:IsValid() then
        inst._light = inst:SpawnChild("minerhatlight")
    end
end


local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("book_maxwell")
    inst.AnimState:SetBuild("book_maxwell")
    inst.AnimState:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "gardening_book"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/gardening_book.xml"
    inst.components.inventoryitem:SetOnPutInInventoryFn(onputininventory)
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPickupFn(onPickup)


    MakeSmallBurnable(inst, TUNING.MED_BURNTIME)
    MakeSmallPropagator(inst)

    return inst
end

return Prefab("gardening_book", fn, assets),
       Prefab("gardening_book_pro", fn, assets)
