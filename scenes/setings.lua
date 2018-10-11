local composer = require("composer")
local scene = composer.newScene()
local json = require("json")
local widget = require("widget")

local function readSetiongs()
	local path = system.pathForFile("setings.json", system.ResourceDirectory)

	local file = io.open(path, "r")
	local line = json.decode(file:read("*a"))
	io.close(file)
	return line
end

function scene:create( event )
	local sceneGroup = self.view
	display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY,
	display.contentWidth, display.contentHeight + 100):setFillColor(1/255, 22/255, 39/255, 0.8)
	display.newRoundedRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth - 20, 400, 20):setFillColor(46/255, 196/255, 182/255)
	local options = {
		parent = sceneGroup,
		text = "Setings",
		x = display.contentCenterX,
		y = 80,
		fontSize = 35,
		font = native.systemFontBold,
	}
	display.newText(options)
	local setings = readSetiongs()
	local soundOn = display.newImageRect("icon/soundOn.png", 100, 100)
	local soundOff = display.newImageRect("icon/soundOff.png", 100, 100)
	soundOn.x = 150
	soundOn.y = 200
	soundOff.x = 150
	soundOff.y = 200
	if setings.sound == true then
		soundOff.isVisible = false
	else
		soundOn.isVisible = false
	end
	local function changeSoundOn(event)
		if event.target.isVisible == true then
			soundOn.isVisible = false
			soundOff.isVisible = true
			setings.sound = false
		end
	end
	local function changeSoundOff(event)
		if event.target.isVisible == true then
			soundOff.isVisible = false
			soundOn.isVisible = true
			setings.sound = true
		end
	end
	soundOn:addEventListener("tap", changeSoundOn)
	soundOff:addEventListener("tap", changeSoundOff)

	local buttonOptions = {
		label = "Ok",
		shape = "roundedRect",
		width = display.contentWidth - 40,
		height = 48,
		x = display.contentCenterX,
		y = 400,
		cornerRadius = 10,
		fillColor = { default={231/255, 29/255, 54/255}, over={113 / 255, 103 / 255, 124 / 255, 0.7} },
		labelColor = { default={255/255, 159/255, 28/255}, over={148 / 255, 93 / 255, 94 / 255} },
		onPress = function( event )
			local path = system.pathForFile("setings.json", system.ResourceDirectory)

			local file = io.open(path, "w")
			local line = json.encode(setings)
			file:write(line)
			io.close(file)
			composer.hideOverlay("slideRight", 400)
		end
	}
	local buttonOk = widget.newButton(buttonOptions)

	sceneGroup:insert(soundOn)
	sceneGroup:insert(soundOff)
	sceneGroup:insert(buttonOk)
end

scene:addEventListener("create", scene)
return scene
