local composer = require("composer")
local scene = composer.newScene()
local widget = require("widget")
local json = require("json")
local emptyButton = {}
local charButton = {}
local groupEmptyButton = display.newGroup()

local function goBack(event)
	composer.removeScene("scenes.playScene")
	composer.gotoScene("scenes.level1", {effect = "slideRight", time = 400})
end

local function goWin()
	composer.removeScene("scenes.playScene")
	composer.gotoScene("scenes.fotoScene", {effect = "slideLeft", time = 700})
end

local function checkWord()
	local word = ""
	for i = 1, emptyButton.n do
		word = word..emptyButton[i]:getLabel()
	end
	if word == emptyButton.word then
		return true
	else
		return false
	end
end

local function readFile()
	local path = system.pathForFile("fotoLevel1.json", system.ResourceDirectory)

	local file = io.open(path, "r")
	local line = json.decode(file:read("*a"))
	io.close(file)
	return line[_ICON]
end

local function isFull()
	for i = 1, emptyButton.n do
		if emptyButton[i]:getLabel() == "" then
			return false
		end
	end
	return true
end

local function addChar(event)
	for i = 1, emptyButton.n do
		if emptyButton[i]:getLabel() == "" then
			emptyButton[i]:setLabel(event.target:getLabel())
			event.target.isVisible = false
			if isFull() then
				if (checkWord()) then
					_CONTENTS[_LEVEL].every[_ICON] = 1
					_CONTENTS[_LEVEL].ok = _CONTENTS[_LEVEL].ok + 1
					timer.performWithDelay(800, goWin)
				else
					transition.to( groupEmptyButton, { time=40, x = groupEmptyButton.x + 3, transition=easing.linear } )
					transition.to( groupEmptyButton, { time=40, delay = 40, x = groupEmptyButton.x - 3, transition=easing.linear } )
					transition.to( groupEmptyButton, { time=40, delay = 40, x = groupEmptyButton.x, transition=easing.linear } )
				end
			end
			return
		end
	end
end
--
local function takeChar(event)
	if event.target:getLabel() ~= "" then
		charButton[event.target:getLabel()].isVisible = true
		event.target:setLabel("")
	end
end

function scene:create (event)
	local sceneGroup = self.view
	local back = display.newImageRect(sceneGroup, "icon/back.png", 35, 35)
	back.x = 25
	back.y = -15
 	local img = readFile()
	_IMAGE = img.foto
	emptyButton.word = img.corect
 	local image = display.newImageRect(sceneGroup, img.foto, 180, 140)
	image.x = display.contentCenterX
	image.y = 100
	-- litere de sus
	groupEmptyButton.x = display.contentCenterX
	groupEmptyButton.y = display.contentCenterY - 20
	local contentsEmptyButton = {
		label= "",
		width = 38,
		height = 38,
		shape = "roundedRect",
		cornerRadius = 20,
		fontSize = 15,
		fillColor = { default={1/255, 22/255, 39/255}, over={1/255, 22/255, 39/255}},
		labelColor = { default={46/255, 196/255, 182/255}, over={46/255, 196/255, 182/255}},
	}
	emptyButton.n = img.n
	if img.lines ~= nil then
		local beginY = 0
		local i = 1
		for l = 2, img.lines[1] + 1 do
			local beginX = (img.lines[l] / 2 * 38 + img.lines[l] - 20) * -1
			for j = 1, img.lines[l] do
				emptyButton[i] = widget.newButton(contentsEmptyButton)
				groupEmptyButton:insert(emptyButton[i])
				emptyButton[i].x = beginX
				emptyButton[i].y = beginY
				beginX = beginX + 40
				emptyButton[i]:addEventListener("tap", takeChar)
				i = i + 1
			end
			beginY = beginY + 40
		end
	else
		local beginX = (img.n / 2 * 38 + img.n - 20) * -1
		for i = 1, img.n do
			emptyButton[i] = widget.newButton(contentsEmptyButton)
			groupEmptyButton:insert(emptyButton[i])
			emptyButton[i].x = beginX
			beginX = beginX + 40
			emptyButton[i]:addEventListener("tap", takeChar)
		end
	end
	sceneGroup:insert(groupEmptyButton)
	--  litere de jos
	local optionsButton = {
		label= "",
		width = 50,
		height = 50,
		shape = "roundedRect",
		cornerRadius = 20,
		fontSize = 20,
		fillColor = { default={ 46/255, 196/255, 182/255 }, over={1/255, 22/255, 39/255}},
		labelColor = { default={253/255, 255/255, 252/255}, over={46/255, 196/255, 182/255}},
	}
	local downButtonX = 40
	local downButtonY = 350
	for i = 1, 15 do
		optionsButton.label = img.chars[i]
		charButton[img.chars[i]] = widget.newButton(optionsButton)
		charButton[img.chars[i]].x = downButtonX
		charButton[img.chars[i]].y = downButtonY
		if i % 5 == 0 then
			downButtonY = downButtonY + 60
			downButtonX = 40
		else
			downButtonX = downButtonX + 60
		end
		sceneGroup:insert(charButton[img.chars[i]])
		charButton[img.chars[i]]:addEventListener("tap", addChar)
	end
	--constructii
	local options = {
		label= "",
		width = 75,
		height = 50,
		x = 25,
		y = 80,
		shape = "roundedRect",
		cornerRadius = 10,
		fillColor = { default={1, 159/255, 28/255}, over={231/255, 29/255, 54/255}},
		labelColor = { default={46/255, 196/255, 182/255}, over={46/255, 196/255, 182/255}},
		onPress = function( event )
			for i = 1, emptyButton.n do
				if emptyButton[i]:getLabel() ~= string.char(emptyButton.word:byte(i)) then
					emptyButton[i]:setLabel(string.char(emptyButton.word:byte(i)))
					coin = coin - 3
					myCoin.text = coin
					if isFull() then
						if (checkWord()) then
							_CONTENTS[_LEVEL].every[_ICON] = 1
							_CONTENTS[_LEVEL].ok = _CONTENTS[_LEVEL].ok + 1
							timer.performWithDelay(800, goWin)
						end
					end
					return
				end
			end
		end
	}
	letterCorect = widget.newButton(options)
	sceneGroup:insert(letterCorect)
	local image = display.newImageRect(sceneGroup, "icon/openLetter.png", 40, 40)
	image.x = 30
	image.y = 80

	local options = {
		label= "",
		width = 75,
		height = 50,
		x = 295,
		y = 80,
		shape = "roundedRect",
		cornerRadius = 10,
		fillColor = { default={1, 159/255, 28/255}, over={231/255, 29/255, 54/255}},
		labelColor = { default={46/255, 196/255, 182/255}, over={46/255, 196/255, 182/255}},
		onPress = function( event )
			for i = 1, emptyButton.n do
				emptyButton[i]:setLabel(string.char(emptyButton.word:byte(i)))
			end
			coin = coin - 10
			myCoin.text = coin
			_CONTENTS[_LEVEL].every[_ICON] = 1
			_CONTENTS[_LEVEL].ok = _CONTENTS[_LEVEL].ok + 1
			timer.performWithDelay(800, goWin)
		end
	}
	wordCorect = widget.newButton(options)
	sceneGroup:insert(wordCorect)
	local image = display.newImageRect(sceneGroup, "icon/openWord.png", 80, 40)
	image.x = 295
	image.y = 80
	------------------------------------------------------------------------------

	back:addEventListener("tap", goBack)
end

scene:addEventListener("create", scene)

return scene
