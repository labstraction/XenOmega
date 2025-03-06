local draw = {
    {
        type = 'polygon',
        mode = 'line',
        points = { -16, -24, 40, -16, 0, -16, 0, -8, 24, 0, 0, 8, 0, 16, 40, 16, -16, 24, -16, 16, -8, 16, -8, 8, -16, 0, -8, -8, -8, -16, -16, -16 },
        color = '#FFFFFF',
        width = 3
    }
}

local collider = {
    type = 'polygon',
    points ={ -16, -24, 40, -16, 40, 16, -16, 24 }
}

local engine = {
    mainThrust = 30000,
    torque = 100000,
    fuel = 800
}


return {
    draw = draw,
    collider = collider,
    engine = engine
}