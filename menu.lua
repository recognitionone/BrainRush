
local composer = require( "composer" )
local scene = composer.newScene()
local score = require( "score" )

local scoreText = score.init({
   x = display.contentCenterX,
   y = -100,
   maxDigits = 3,
   leadingZeros = false,
   filename = "scorefile.txt",
})

local highscore = score.load()
local myscore = score.get()

local _W = display.contentWidth
local _H = display.contentHeight

local function onSceneTouch( self, event )
	if event.phase == "began" then		
		composer.gotoScene( "game", "fade", 400  )		
		return true
	end
end
local startGameButton
local bestScore
local newScore
local background 


function scene:create( event )
	local sceneGroup = self.view
	background = display.newRect(_W, _H, _W*2, _H*2)
	background.x = _W/2
	background.y = _H/2
	background:setFillColor(0/255,137/255,166/255)
	background.touch = onSceneTouch
	sceneGroup:insert( background )

	bestScore = display.newText("Best score: "..highscore, _W/2, _H/2-150, "Track", 15)
	sceneGroup:insert(bestScore)
	
	newScore = display.newText("your new score: "..myscore, _W/2, _H/2-50, "Track", 15)
	sceneGroup:insert(newScore)
	
	
	startGameButton = display.newRect(_W/2, _H/2+150, _H/5, _W/5)
	startGameButton.touch = onSceneTouch
	sceneGroup:insert(startGameButton)
	local startGameButtonText = display.newText("Play", _W/2, _H/2+150, "Track", 20)
	startGameButtonText:setFillColor(0,0,0)
	sceneGroup:insert(startGameButtonText)
	
end

function scene:show( event )
local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "game" )
		composer.removeHidden()
		startGameButton:addEventListener( "touch", startGameButton )
		background:addEventListener( "touch", background )

		
		bestScore.text = "Best score: "..highscore
		newScore.text = "your new score: "..score.get()
		
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		startGameButton:removeEventListener( "touch", startGameButton )
	end
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene