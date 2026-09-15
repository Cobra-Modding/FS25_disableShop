-- ============================================================
-- FS25_DisableShop.lua
-- by Marcus (Cobra Modding)
-- 
--
-- Version 1.0.0.0
--
--
-- Keine Änderung am Skript ohne meine Erlaubnis
-- ============================================================

DisableShop = {}

DisableShop.checkInterval = 500
DisableShop.checkTimer = 0
DisableShop.wasFound = false


function DisableShop:loadMap(mapName)
    self.checkTimer = 0

    print("DisableShop: loaded")
end


function DisableShop:disableShopAction()
    if g_inputBinding == nil then
        return
    end

    if g_inputBinding.contexts == nil then
        return
    end

    if g_inputBinding.nameActions == nil then
        return
    end

    local action = g_inputBinding.nameActions["TOGGLE_STORE"]

    if action == nil then
        return
    end

    local found = false

    for contextName, context in pairs(g_inputBinding.contexts) do

        if context.actionEvents ~= nil
        and context.actionEvents[action] ~= nil then

            g_inputBinding:setContextEventsActive(
                contextName,
                "TOGGLE_STORE",
                false
            )

            found = true
        end
    end

    if found and not self.wasFound then
        print("DisableShop: TOGGLE_STORE disabled")
        self.wasFound = true
    end
end


function DisableShop:update(dt)
    self.checkTimer = self.checkTimer + dt

    if self.checkTimer >= self.checkInterval then
        self.checkTimer = 0

        self:disableShopAction()
    end
end


function DisableShop:deleteMap()
end


addModEventListener(DisableShop)
