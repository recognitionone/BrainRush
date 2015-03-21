local composer = require( "composer" )
local scene = composer.newScene()
local score = require( "score" )
system.setIdleTimer( false )

local scoreText = score.init({
   x = display.contentCenterX,
   y = -100,
   maxDigits = 3,
   leadingZeros = false,
   filename = "scorefile.txt",
})



local _W = display.contentWidth
local _H = display.contentHeight

local myObject
local myButton
local myObject2
local myButton2
local myScore
local isMyButtonWhite = true
local isMyObjectWhite = true
local isMyButtonWhite2 = true
local isMyObjectWhite2 = true
local myTime = 1500

local function onObjectTouch( event )
	if event.phase == "began" then		
		myButton:setFillColor(1,0,1)		
		isMyButtonWhite = false
	elseif event.phase == "ended" then			
		myButton:setFillColor(1,1,1)		
		isMyButtonWhite = true
	end
	return true
end

local function onObjectTouch2( event )
	if event.phase == "began" then		
		myButton2:setFillColor(0,1,0)		
		isMyButtonWhite2 = false
	elseif event.phase == "ended" then			
		myButton2:setFillColor(1,1,1)		
		isMyButtonWhite2 = true
	end
	return true
end

local function createMyObject()
	myObject = display.newRect( _W/2-60, 0, 50, 50)	
	
	isMyObjectWhite = true
	z = math.random(1,2)
	myTime = myTime - 20
	if z == 1 then
		myObject:setFillColor(0,1,0)
		isMyObjectWhite = false
	end		
	transition.to( myObject, { time=myTime, y=(_H+25)} )
	
	timer.performWithDelay(myTime/2, function()
		myObject2 = display.newRect( _W/2+60, 0, 50, 50)
		isMyObjectWhite2 = true
		z2 = math.random(1,2)
		
		if z2 == 1 then
			myObject2:setFillColor(0,1,0)
			isMyObjectWhite2 = false
		end		
		transition.to( myObject2, { time=myTime, y=(_H+25)} )
	end, 1)
end

local function removeMyObject()
	if myObject ~= nil then
		myObject:removeSelf()
		myObject = nil
	end
end

local function endCreateMyObjectTimer()
	if createMyObjectTimer ~= nil then
		timer.cancel(createMyObjectTimer)
		createMyObjectTimer = nil
	end
end

local function gameEnded()		
	endCreateMyObjectTimer()
	
	composer.gotoScene( "menu", "fade", 400  )				
end

function detectCollision()
	if myObject ~= nil and myObject.y >= _H-25 then	
		if isMyObjectWhite == true then
			if isMyButtonWhite == true then
				score.add(1)
				print("white white match")
				removeMyObject()	
				createMyObject()
			else
				gameEnded()
				print("no match")
				removeMyObject()	
		
			end
		elseif isMyObjectWhite == false then
			if isMyButtonWhite == false then
				score.add(1)
				print("green green match")
				removeMyObject()	
				createMyObject()
			else
				gameEnded()
				print("no match")
				removeMyObject()	
		
			end
		end
		myScore.text = score.get()	
		
		
	end
end










function scene:create( event )
	local sceneGroup = self.view
	
	score.set(0)
	
	background = display.newRect(_W/2, _H/2, _W*2, _H*2)
	background:setFillColor(0/255,137/255,166/255)
	sceneGroup:insert( background )

	myButton = display.newRect( _W/2-60, _H-25, 50, 50)
	myButton.id = "myButtonWhite"
	sceneGroup:insert(myButton)
	
	myButton2 = display.newRect( _W/2+60, _H-25, 50, 50)
	myButton2.touch = onObjectTouch2
	myButton2.id = "myButton2White"
	sceneGroup:insert(myButton2)
	
	myScore = display.newText(score.get(), _W-20, 20, "Track", 15)
	sceneGroup:insert(myScore)
	
	
end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if "did" == phase then
		composer.removeScene( "menu" )
		composer.removeHidden()
		myButton:addEventListener( "touch", onObjectTouch )	
		myButton2:addEventListener( "touch", onObjectTouch2 )	
		createMyObject()				
		detectCollisionTimer = timer.performWithDelay(1, detectCollision, -1)					
		timer.performWithDelay(myTime*100, gameEnded, 1)
		
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if "will" == phase then
		removeMyObject()
		score.save()
		myButton:removeEventListener( "touch", onObjectTouch )
		endCreateMyObjectTimer()
		if detectCollisionTimer ~= nil then
			timer.cancel(detectCollisionTimer)
			detectCollisionTimer = nil
		end

	end
	score.save()
end

function scene:destroy( event )
	local sceneGroup = self.view
	endCreateMyObjectTimer()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene