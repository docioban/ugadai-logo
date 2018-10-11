local composer = require("composer")

local scene = composer.newScene()

local function goBack(event)
	composer.removeScene("scenes.fotoScene")
	composer.gotoScene("scenes.level1", {effect = "slideRight", time = 400})
end

function scene:create (event)
	local sceneGroup = self.view

	local back = display.newImageRect(sceneGroup, "icon/back.png", 35, 35)
	back.x = 25
	back.y = -15

	local image = display.newImageRect(sceneGroup, _IMAGE, display.contentWidth - 20, 220)
	image.x = display.contentCenterX
	image.y = 200

	back:addEventListener("tap", goBack)
end

scene:addEventListener("create", scene)

return scene
