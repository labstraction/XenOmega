return {
  { -- Interceptor
    collider = { -16, -24, 40, -16, 40, 16, -16, 24 },
    graphic = {
      {
        line = { -16, -24, 40, -16, 0, -16, 0, -8, 24, 0, 0, 8, 0, 16, 40, 16, -16, 24, -16, 16, -8, 16, -8, 8, -16, 0, -8, -8, -8, -16, -16, -16 },
        color = '#FFFFFF',
        width = 3
      }
    },
    emitters = {
      { event = 'thrust', x = -16, y = -24, angle = 0, speed = 0, rate = 0.1, life = 0.5, size = 2, color = { 255, 255, 255 } }
    },
    thrust = 100000,
    lateral = 30000,
    brake = 30000,
    torque = 100000,
    fuel = 800
  },
  { -- Starfighter
  collider = {-14, -18, 32, 0, -14, 18}, -- Triangolo allungato
  graphic = {
    {
      line = {
        -- Corpo centrale a delta
        -14, 0, 32, 0, -- Linea centrale
        -8, -18, 0, -24, 8, -18, -- Ala sinistra
        -8, 18, 0, 24, 8, 18, -- Ala destra
        32, 0, 24, -8, 24, 8, 32, 0 -- Propulsori posteriori
      },
      color = '#00FF88',
      width = 2
    }
  },
  emitters = {
    {event = 'thrust', x = 32, y = 0, angle = 180, speed = 0, rate = 0.15, life = 0.3, size = 3, color = {0, 255, 136}}
  },
  thrust = 150000,
  lateral = 40000,
  brake = 20000,
  torque = 140000,
  fuel = 600
},
{ -- Freighter
  collider = {-20, -24, 48, -24, 48, 24, -20, 24}, -- Rettangolo
  graphic = {
    {
      line = {
        -- Scafo principale
        -20, -24, 48, -24, 48, 24, -20, 24, -20, -24,
        -- Detagli strutturali
        -12, -16, 36, -16, 36, 16, -12, 16, -12, -16,
        -- Propulsori
        48, -16, 56, -8, 56, 8, 48, 16,
        -- Cabina
        -4, -8, -4, 8, 4, 8, 4, -8, -4, -8
      },
      color = '#FF6600',
      width = 4
    }
  },
  emitters = {
    {event = 'thrust', x = 56, y = -8, angle = 180, speed = 0, rate = 0.25, life = 0.8, size = 5, color = {255, 102, 0}},
    {event = 'thrust', x = 56, y = 8, angle = 180, speed = 0, rate = 0.25, life = 0.8, size = 5, color = {255, 102, 0}}
  },
  thrust = 60000,
  lateral = 15000,
  brake = 50000,
  torque = 60000,
  fuel = 1500
}
}
