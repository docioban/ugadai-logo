-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--local background = display.setDefault("background", 109/255, 104/255, 117/255)
display.setStatusBar(display.HiddenStatusBar)

local composer = require("composer")
display.setStatusBar(display.HiddenStatusBar)

composer.gotoScene("scenes.level", {effect = "fade", time = 500})
