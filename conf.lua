local gameConf = require('game-conf')

function love.conf(t)
  t.identity = nil                   -- The name of the save directory (string)
  t.version = "11.5"                -- The LÖVE version this game was made for (string)
  t.console = true                  -- Attach a console (boolean, Windows only)

  t.window.title = "Asteroid"        -- The window title (string)
  t.window.icon = nil                -- Filepath to an image to use as the window's icon (string)
  t.window.width = gameConf.width              -- The window width (number)
  t.window.height = gameConf.height            -- The window height (number)
  t.window.borderless = false        -- Remove all border visuals from the window (boolean)
  t.window.resizable = true        -- Let the window be user-resizable (boolean)
  t.window.minwidth = 1              -- Minimum window width if the window is resizable (number)
  t.window.minheight = 1             -- Minimum window height if the window is resizable (number)
  t.window.fullscreen = false        -- Enable fullscreen (boolean)
  t.window.fullscreentype = "exclusive" -- Standard fullscreen or desktop fullscreen mode (string)
  t.window.vsync = true              -- Enable vertical sync (boolean)
  t.window.fsaa = 0                  -- The number of samples to use with multi-sampled antialiasing (number)
  t.window.display = 1               -- Index of the monitor to show the window in (number)
  t.window.highdpi = false           -- Enable high-dpi mode for the window on a Retina display (boolean). Added in 0.9.1
  t.window.srgb = false              -- Enable sRGB gamma correction when drawing to the screen (boolean). Added in 0.9.1
end
