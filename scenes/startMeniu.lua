local composer = require("composer")
local scene = composer.newScene()

local function gotoLevel()
	composer.gotoScene("scenes.level", {effect = "slideLeft", time = 400})
end

local function gotoSetings()
	local options ={
	    isModal = true,
	    effect = "fade",
	    time = 400,
	}
	composer.showOverlay("scenes.setings", options)
end

function scene:create(event)

	local sceneGroup = self.view

	local background = display.setDefault("background", 253/255, 255/255, 252/255)

	local widget = require("widget")

	grupTopBar = display.newGroup()

	display.newRect(grupTopBar, display.contentCenterX, -15, display.contentWidth, 60):setFillColor(46/255, 196/255, 182/255)
	display.newRoundedRect(grupTopBar, 100, -15, 90, 40, 10):setFillColor(1/255, 22/255, 39/255)

	coin = 20
	local options = {
		parent = grupTopBar,
		text = coin,
		font = native.systemFontBold,
		x = 75,
		y = -15,
		fontSize = 24
	}

	myCoin = display.newText(options)
	myCoin:setFillColor(253/255, 255/255, 252/255)

	local iconImage = display.newImageRect(grupTopBar, "icon/coin.png", 50, 50)
	iconImage.x = 125
	iconImage.y = -10

	local setingsImage = display.newImageRect(grupTopBar, "icon/settings.png", 47, 47)
	setingsImage.x = 280
	setingsImage.y = -15

	local options = {
		label= "play",
		width = 200,
		height = 70,
		shape = "roundedRect",
		cornerRadius = 20,
		fontSize = 30,
		fillColor = { default={ 46/255, 196/255, 182/255 }, over={1/255, 22/255, 39/255}},
		labelColor = { default={253/255, 255/255, 252/255}, over={46/255, 196/255, 182/255}},
	}
	local button = widget.newButton(options)
	button.x = display.contentCenterX
	button.y = display.contentCenterY

	button:addEventListener("tap", gotoLevel)
	setingsImage:addEventListener("tap", gotoSetings)

	sceneGroup:insert(button)
--	sceneGroup:insert(grupTopBar)
end

scene:addEventListener("create", scene)

return scene
