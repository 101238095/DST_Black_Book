local fixlunarthrall = function(self, target)
    if target and target:IsValid() then
        if FindEntity(target, 60, nil, {"t_b_b_building_avoidable_lunarthrall_plant_lightning_rod"}) then
            return true
        end
    end
    return false
end

AddComponentPostInit("lunarthrall_plantspawner", function(i)
    local SpawnGestalt = i.SpawnGestalt
    i.SpawnGestalt = function(s, target, ...)
        if fixlunarthrall(s, target) then
            return false
        end
        return SpawnGestalt(s, target, ...)
    end

    local SpawnPlant = i.SpawnPlant
    i.SpawnPlant = function(s, target, ...)
        if fixlunarthrall(s, target) then
            return false
        end
        return SpawnPlant(s, target, ...)
    end

end)