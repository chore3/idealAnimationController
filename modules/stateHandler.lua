local stateHandler = {}

-- ==================================================

local function noop() end

local states = {
    idle      = { current = false, prev = false, onEvent = noop },
    walk      = { current = false, prev = false, onEvent = noop },
    sprint    = { current = false, prev = false, onEvent = noop },
    crouch    = { current = false, prev = false, onEvent = noop },
    jump      = { current = false, prev = false, onEvent = noop },
    swim      = { current = false, prev = false, onEvent = noop },
    glide     = { current = false, prev = false, onEvent = noop },
    climb     = { current = false, prev = false, onEvent = noop },
    fall      = { current = false, prev = false, onEvent = noop },

    block     = { current = false, prev = false, onEvent = noop },
    chat      = { current = false, prev = false, onEvent = noop },
    inventory = { current = false, prev = false, onEvent = noop },
    fishing   = { current = false, prev = false, onEvent = noop },
    riptide   = { current = false, prev = false, onEvent = noop },
    sleep     = { current = false, prev = false, onEvent = noop },
    dye       = { current = false, prev = false, onEvent = noop },
}

end

-- ==================================================

return stateHandler