local QBCore = exports['qb-core']:GetCoreObject()
local type 

RegisterCommand("fps", function()
	exports['qb-menu']:openMenu({
        {
            header = "🔥MENU FPS BOOSTER🔥", -- Titolo del menu
            isMenuHeader = true, -- Se true, il titolo del menu non sara' cliccabile dal player
        },
        {
            header = "Ripristina",
            txt = "Ripristina le texture",
            params = {
                event = "sisco-fpsbooster:client:event",
                args = {
                   type = "ripristina"
                }
            }
        },
        {
            header = "Ultra basso",
            txt = "Texture ulta basse",
            params = {
                event = "sisco-fpsbooster:client:event",
                args = {
                    type = "ultrabasso"
                }
            }
        },
        {
            header = "Basso",
            txt = "Texture basse",
            params = {
                event = "sisco-fpsbooster:client:event",
                args = {
                    type = "basso"
                }
            }
        },
        {
            header = "Medio",
            txt = "Texture medie",
            params = {
                event = "sisco-fpsbooster:client:event",
                args = {
                    type = "medio"
                }
            }
        },
    })
end)

RegisterNetEvent('sisco-fpsbooster:client:event', function(data)
    if data.type == "ripristina" then
        FPSBoosterUM(true,true,true,true,5.0,5.0,5.0,10.0,10.0,true,false,"Texture ripristinate!")
    elseif data.type == "ultrabasso" then
        FPSBoosterUM(false,false,true,false,0.0,0.0,0.0,0.0,0.0,false,nil,"Texture ultra basse impostate!")
    elseif data.type == "basso" then
        FPSBoosterUM(false,false,true,false,0.0,0.0,0.0,5.0,5.0,false,nil,"Texture basse impostate!")
    elseif data.type == "medio" then
        FPSBoosterUM(true,false,true,false,5.0,3.0,3.0,3.0,3.0,false,false,"Texture medie impostate!")
    end
    type = data.type
end)

-- Rendering distanza e gestore di entità (ha bisogno di una revisione)
CreateThread(function()
    while true do
        if type == "ultrabasso" then
            -- Trova il ped più vicino e lo imposta come alfa
            for ped in GetWorldPeds() do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                    SetEntityAsNoLongerNeeded(ped)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end

                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end

            -- Trova l'oggetto più vicino e lo imposta come alfa
            for obj in GetWorldObjects() do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    elseif GetEntityAlpha(obj) ~= 170 then
                        SetEntityAlpha(obj, 170)
                    end
                end
                Wait(1)
            end


            DisableOcclusionThisFrame()
            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            OverrideLodscaleThisFrame(0.4)
            SetArtificialLightsState(true)
        elseif type == "basso" then
            -- Trova il ped più vicino e lo imposta come alfa
            for ped in GetWorldPeds() do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                    SetEntityAsNoLongerNeeded(ped)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                SetPedAoBlobRendering(ped, false)

                Wait(1)
            end

            -- Trova l'oggetto più vicino e lo imposta come alfa
            for obj in GetWorldObjects() do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    elseif GetEntityAlpha(ped) ~= 210 then
                        SetEntityAlpha(ped, 210)
                    end
                end
                Wait(1)
            end

            SetDisableDecalRenderingThisFrame()
            RemoveParticleFxInRange(GetEntityCoords(PlayerPedId()), 10.0)
            OverrideLodscaleThisFrame(0.6)
            SetArtificialLightsState(true)
        elseif type == "medio" then
            -- Trova il ped più vicino e lo imposta come alfa
            for ped in GetWorldPeds() do
                if not IsEntityOnScreen(ped) then
                    SetEntityAlpha(ped, 0)
                    SetEntityAsNoLongerNeeded(ped)
                else
                    if GetEntityAlpha(ped) == 0 then
                        SetEntityAlpha(ped, 255)
                    end
                end

                SetPedAoBlobRendering(ped, false)
                Wait(1)
            end
        
            -- Trova l'oggetto più vicino e lo imposta come alfa
            for obj in GetWorldObjects() do
                if not IsEntityOnScreen(obj) then
                    SetEntityAlpha(obj, 0)
                    SetEntityAsNoLongerNeeded(obj)
                else
                    if GetEntityAlpha(obj) == 0 then
                        SetEntityAlpha(obj, 255)
                    end
                end
                Wait(1)
            end

            OverrideLodscaleThisFrame(0.8)
        else
            Wait(500)
        end
        Wait(8)
    end
end)

-- Disattiva a chi la imposta la pioggia, il vento e altre piccole cose che non richiedono il frame tick
CreateThread(function()
    while true do
        if type == "ultrabasso" or type == "basso" then
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            ClearPedBloodDamage(PlayerPedId())
            ClearPedWetness(PlayerPedId())
            ClearPedEnvDirt(PlayerPedId())
            ResetPedVisibleDamage(PlayerPedId())
            ClearExtraTimecycleModifier()
            ClearTimecycleModifier()
            ClearOverrideWeather()
            ClearHdArea()
            DisableVehicleDistantlights(false)
            DisableScreenblurFade()
            SetRainLevel(0.0)
            SetWindSpeed(0.0)
            Wait(300)
        elseif type == "medio" then
            ClearAllBrokenGlass()
            ClearAllHelpMessages()
            LeaderboardsReadClearAll()
            ClearBrief()
            ClearGpsFlags()
            ClearPrints()
            ClearSmallPrints()
            ClearReplayStats()
            LeaderboardsClearCacheData()
            ClearFocus()
            ClearHdArea()
            SetWindSpeed(0.0)
            Wait(1000)
        else
            Wait(1500)
        end
    end
end)

-- Enumeratore ntità (https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2#file-entityiter-lua)
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end

            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)

            local next = true
            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next

            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
end

function GetWorldObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function GetWorldPeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function GetWorldVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetWorldPickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function FPSBoosterUM(shadow,air,entity,dynamic,tracker,depth,bounds,distance,tweak,sirens,lights,notify)
    RopeDrawShadowEnabled(shadow)
    CascadeShadowsClearShadowSampleType()
    CascadeShadowsSetAircraftMode(air)
    CascadeShadowsEnableEntityTracker(entity)
    CascadeShadowsSetDynamicDepthMode(dynamic)
    CascadeShadowsSetEntityTrackerScale(tracker)
    CascadeShadowsSetDynamicDepthValue(depth)
    CascadeShadowsSetCascadeBoundsScale(bounds)
    SetFlashLightFadeDistance(distance)
    SetLightsCutoffDistanceTweak(tweak)
    DistantCopCarSirens(sirens)
    SetArtificialLightsState(lights)
    QBCore.Functions.Notify(notify,"success")
end
