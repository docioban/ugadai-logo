local composer = require("composer")
local widget = require("widget")
local json = require("json")

local scene = composer.newScene()

_ICON = 0

local function goBack(event)
	local path = system.pathForFile("levelsDetail.json", system.ResourceDirectory)

	local file = io.open(path, "w")
	local content = json.encode(_CONTENTS)
	file:write(content)
	io.close(file)
	composer.removeScene("scenes.level1")
	composer.gotoScene("scenes.level", {effect = "slideRight", time = 400})
end

local function gotoImage(event)
	_ICON = event.target.id
	if _CONTENTS[_LEVEL].every[event.target.id] == 1 then
		_IMAGE = event.target.adres
		composer.gotoScene("scenes.fotoScene", {effect = "slideLeft", time = 500})
	else
		composer.removeScene("scenes.level1")
		composer.gotoScene("scenes.playScene", {effect = "slideLeft", time = 500})
	end
end

local function iconLevel()
	local icn = {}
	if _LEVEL == 1 then
		icn[1] = "Level1/Apple.png"
		icn[2] = "Level1/Cola.png"
		icn[3] = "Level1/Ford.png"
		icn[4] = "Level1/Lg.png"
		icn[5] = "Level1/Loreal.png"
		icn[6] = "Level1/McDonalds.png"
		icn[7] = "Level1/Microsoft.png"
		icn[8] = "Level1/Nivea.png"
		icn[9] = "Level1/Samsung.png"
		icn[10] = "Level1/Wikipedia.png"
		icn[11] = "Level1/Tesla.png"
		icn[12] = "Level1/Ibm.png"
		icn[13] = "Level1/Ebay.png"
		icn[14] = "Level1/Nike.png"
		icn[15] = "Level1/Disney.png"
		icn[16] = "Level1/Steam.png"
		icn[17] = "Level1/Google.png"
		icn[18] = "Level1/PayPal.png"
	end
	return icn
end

function scene:create (event)
	local sceneGroup = self.view
	local scrollView = widget.newScrollView({
		left = 0,
		top = 15,
		width = display.contentWidth,
		height = display.contentHeight + 30,
		scrollWidth = 600,
        scrollHeight = 400
	})
	local background = display.setDefault(scrollView, "background", 241/255, 250/255, 238/255)
	grupTopBar:toBack()
	local back = display.newImageRect(sceneGroup, "icon/back.png", 35, 35)
	back.x = 25
	back.y = -15

	local icon = iconLevel()
	local x = {60, 160, 260}
	local y = {50, 140, 230, 320, 410, 500}
	local n = 1
	local image = {}
	for i = 1, 6 do
		for j = 1, 3 do
			image.n = display.newImageRect(icon[n], 80, 60)
			image.n.adres = icon[n]
			image.n.id = n
			image.n.x = x[j]
			image.n.y = y[i]
			if _CONTENTS[_LEVEL].every[n] == 1 then
				local isCompletImg = display.newImageRect("icon/ok.png", 35, 35)
				isCompletImg.x = x[j] + 30
				isCompletImg.y = y[i] + 20
			 	scrollView:insert(isCompletImg)
			end
			scrollView:insert(image.n)
			image.n:toBack()
			image.n:addEventListener("tap", gotoImage)
			n = n + 1
		end
	end
	sceneGroup:insert(scrollView)
	back:addEventListener("tap", goBack)
end

function scene:destroy (event)
end

scene:addEventListener("create", scene)
scene:addEventListener("destroy", scene)

return scene
