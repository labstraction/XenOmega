return {
    { -- Interceptor
      shape = {-16, -24, 40, -16, 40, 16, -16, 24},
      draw = {-16, -24, 40, -16, 0, -16, 0, -8, 24, 0, 0, 8, 0, 16, 40, 16, -16, 24, -16, 16, -8, 16, -8, 8, -16, 0, -8, -8, -8, -16, -16, -16},
      emitters = {
        {event = 'thrust' ,x = -16, y = -24, angle = 0, speed = 0, rate = 0.1, life = 0.5, size = 2, color = {255, 255, 255}}
      },
      thrust = 100000,
      lateral = 8000,
      brake = 4000,
      torque = 100000,
      fuel = 800
    },
    { -- Freighter
      shape = {-20, -10, 20, -10, 20, 10, -20, 10},
      draw = {-20, -10, 20, -10, 20, 10, -20, 10},
      thrust = 1500,
      lateral = 400,
      brake = 6000,
      torque = 8000,
      fuel = 1500
    },
    { -- Fighter
      shape = {0, -15, -10, 10, 10, 10},
      draw = {0, -15, -10, 10, 10, 10},
      thrust = 2500,
      lateral = 1200,
      brake = 3000,
      torque = 15000,
      fuel = 600
    }
  }

