local composer = require("composer")
local json = require("json")
local scene = composer.newScene()

local function gotoLevel(event)
	if event.phase == "ended"  then
		_LEVEL = event.target.id
		composer.removeScene("scenes.level")
		composer.gotoScene("scenes.level1", {effect = "slideLeft", time = 500})
	elseif event.phase == "began" then
		event.target:setFillColor(1, 159/255, 28/255)
	end
end

local function readFile()
	local path = system.pathForFile("levelsDetail.json", system.ResourceDirectory)

	local file = io.open(path, "r")
	_CONTENTS = json.decode(file:read("*a"))
	io.close(file)
end

function scene:create(event)

---------------------------------------------------------------------------------------
	local background = display.setDefault("background", 253/255, 255/255, 252/255)
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
	local function gotoSetings()
		local options ={
		    isModal = true,
		    effect = "fade",
		    time = 400,
		}
		composer.showOverlay("scenes.setings", options)
	end
	setingsImage:addEventListener("tap", gotoSetings)
---------------------------------------------------------------------------------------
	local sceneGroup = self.view
	display.setDefault("background", 253/255, 255/255, 252/255)

	readFile()
	local Locationy = 65
	local block = {}

	for i = 1, 3 do
		block[i] = display.newRoundedRect(sceneGroup, display.contentCenterX, Locationy, display.contentWidth - 20, 80, 20)
		block[i]:setFillColor(231/255, 29/255, 54/255)
		local options = {
			parent = sceneGroup,
			text = "Level "..i,
			font = native.systemFontBold,
			x = 80,
			y = Locationy,
			fontSize = 25
		}
		display.newText(options):setFillColor(253/255, 1, 252/255)
		if _CONTENTS[i].open then	-- if is open
			local options = {
				parent = sceneGroup,
				text = _CONTENTS[i].ok .. "/18",
				font = native.systemFontBold,
				x = 270,
				y = Locationy,
				fontSize = 20
			}
			display.newText(options):setFillColor(253/255, 1, 252/255)
			block[i].id = i
			block[i]:addEventListener("touch", gotoLevel)
		else		-- if is close
			local options = {
				parent = sceneGroup,
				text = "Close",
				font = native.systemFontBold,
				x = 270,
				y = Locationy,
				fontSize = 20
			}
			display.newText(options):setFillColor(253/255, 1, 252/255)
		end
		Locationy = Locationy + 100
	end
end

scene:addEventListener("create", scene)

return scene
