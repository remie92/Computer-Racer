term.clear()
term.setCursorPos(1,1)
print("Welcome to the PineJam Car Game! (I need a better name....)")
print()
print("To play, setup the options first! The first one will appear under this text.")
print()
print("Controls: Arrow Keys to move, Space to jump.")
print()
print("Texured Plane? (y/n) (Default: No)")
planeYN=read()
if planeYN=="y" or planeYN=="Y" then
    planeStr="plane"
else
    planeStr="blankplane"
end

print()
print("Random Car? (y/n) (Default: No)")
randomCar=read()
if randomCar=="y" or randomCar=="Y" then
    randomCar=1
else
    randomCar=0
end
print()
print("Road crazyness (1-100) (Default: 35)")
local roadCrazyness=tonumber(read())
if roadCrazyness==nil then
    roadCrazyness=50
end

doSmoke=true

local Pine3D = require("Pine3D")

-- movement and turn speed of the camera
local speed = 15 -- units per second
local turnSpeed = 140 -- degrees per second

-- create a new frame
local ThreeDFrame = Pine3D.newFrame()

-- initialize our own camera and update the frame camera
local camera = {
  x = 0,
  y = 0,
  z = 0,
  rotX = 0,
  rotY = 0,
  rotZ = 0,
}
ThreeDFrame:setCamera(camera)


carStr="car"
if randomCar==1 then
  carValue=math.random(2,6)
    carStr="car"..carValue
    if carValue==4 then
        doSmoke=false
    end
if carValue==6 then
        doSmoke=false
    end
  end

-- define the objects to be rendered
local objects = {
    ThreeDFrame:newObject("models/"..carStr, 0, 0, 0),
    ThreeDFrame:newObject("models/shadow", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
        ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
    ThreeDFrame:newObject("models/smoke", 0, 0, 0),
        ThreeDFrame:newObject("models/numbers", 0, 0, 0),
    ThreeDFrame:newObject("models/numbers", 10, -20, 0),
    ThreeDFrame:newObject("models/numbers", 20, -40, 0),
    -- ThreeDFrame:newObject("models/map", 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 50, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 15, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
    ThreeDFrame:newObject("models/"..planeStr, 0, 0, 0),
}



function addCheckpoint(x,y)
    if math.random()>roadCrazyness/200.0 then
    table.insert(objects, ThreeDFrame:newObject("models/checkpointPath", x, 0, y))
    else
    table.insert(objects, ThreeDFrame:newObject("models/path"..math.random(2,5), x, 0, y))
    end
end

function removeCheckpoint()
    if #objects > 35 then
        table.remove(objects, 35)
    end
end


-- handle all keypresses and store in a lookup table
-- to check later if a key is being pressed
local keysDown = {}
local function keyInput()
  while true do
    -- wait for an event
    local event, key, x, y = os.pullEvent()

    if event == "key" then -- if a key is pressed, mark it as being pressed down
      keysDown[key] = true
    elseif event == "key_up" then -- if a key is released, reset its value
      keysDown[key] = nil
    end
  end
end

local function handleCameraMovement(dt)
  zoom=zoom+(carY*0.3)

  vec=vector.fromAngle(math.rad(-cameraYaw))
  vec:normalize()
  camera.rotY =-cameraYaw+180
  camera.rotZ=-20
  camera.x = vec.x*zoom    +carX
  camera.y = zoom*0.4+0.5+carY
  camera.z = vec.y*zoom    +carZ


  local hundreds = math.floor(points / 100)
local tens = math.floor((points % 100) / 10)
local singles = points % 10

  vec=vector.fromAngle(math.rad(-cameraYaw-20))
 vec:normalize()
  objects[23]:setPos(carX+vec.x*4*0.5, carY-20*hundreds, carZ+vec.y*4*0.5)
  objects[23]:setRot(0, degreesToRadians(cameraYaw+90), 0)

    vec=vector.fromAngle(math.rad(-cameraYaw-30))
 vec:normalize()
  objects[24]:setPos(carX+vec.x*4*0.55, carY-20*tens, carZ+vec.y*4*0.55)
  objects[24]:setRot(0, degreesToRadians(cameraYaw+90), 0)

    vec=vector.fromAngle(math.rad(-cameraYaw-40))
 vec:normalize()
  objects[25]:setPos(carX+vec.x*4*0.6, carY-20*singles, carZ+vec.y*4*0.6)
  objects[25]:setRot(0, degreesToRadians(cameraYaw+90), 0)

  ThreeDFrame:setCamera(camera)
end


function vector:new(x, y, z)
  local obj = {x = x or 0, y = y or 0, z = z or 0}
  setmetatable(obj, self)
  self.__index = self
  return obj
end

function vector.fromAngle(angle, target)
  local x = math.cos(angle)
  local y = math.sin(angle)

  if target then
    target.x = x
    target.y = y
    target.z = 0
    return target
  else
    return vector:new(x, y, 0)
  end
end

function vector:normalize()
  local mag = math.sqrt(self.x^2 + self.y^2 + self.z^2)
  if mag ~= 0 then
    self.x = self.x / mag
    self.y = self.y / mag
    self.z = self.z / mag
  end
  return self
end


function degreesToRadians(deg)
  return deg * math.pi / 180
end

function angleDifference(a, b)
  local diff = (b - a + 540) % 360 - 180
  return diff
end

function math.sign(x)
  return (x > 0) and 1 or (x < 0 and -1 or 0)
end




carX=0
carVel=0
carZ=0
carYaw=270

carY=0

cameraYaw=270

zoom=4

reverse=0

points=0

function updateCameraYaw(dt)
    

if carVel<2 then
    ThreeDFrame:setFoV(80+math.abs(carVel)*0.35) 
    reverse=0
    zoom=5-math.abs(carVel)*0.035
else
    ThreeDFrame:setFoV(80)
    reverse=1
    zoom=5
end


  local diff = angleDifference(cameraYaw, carYaw+reverse*180)
  local rotateSpeed = 90 -- degrees per second

  -- Clamp the change to max allowed per frame
  local maxStep = rotateSpeed * dt*(math.abs(diff/40.0))
  if math.abs(diff) < maxStep then
    cameraYaw = carYaw
  else
    cameraYaw = (cameraYaw + math.sign(diff) * maxStep) % 360
  end
end


function math.dist(x1,y1,x2,y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end


genX=0
genZ=0
genRotation=0
carYVel=0

  currentSmoke=1
  smokeTime=os.clock()

-- handle game logic
local function handleGameLogic(dt)




  if(os.clock()-0.05>smokeTime) then
    vec=vector.fromAngle(math.rad(-carYaw-10+math.sin(os.clock()*2.8)*5))
    if(reverse==1) then
      vec=vector.fromAngle(math.rad(-carYaw-30+math.sin(os.clock()*5.8)*10))
    end 
  vec:normalize()
  smokeX = vec.x*2    
  smokeZ = vec.y*2    
    objects[2+currentSmoke]:setPos(carX+smokeX, math.sin(os.clock())*0.2, carZ+smokeZ)



    smokeTime=os.clock()

    currentSmoke=currentSmoke+1

    if currentSmoke>20 then
      currentSmoke=1
    end
  end


  if doSmoke==false then
    for i=3,23 do
      objects[2+i]:setPos(carX, -1000, carZ)
    end
  end



    if #objects<35 then
        addCheckpoint(genX,genZ)
end


    while #objects <42 do
        addCheckpoint(genX,genZ)

        objects[#objects]:setRot(nil, degreesToRadians(-genRotation), nil)
        genX = genX + 40 * math.cos(degreesToRadians(genRotation-90))
        genZ = genZ + 40 * math.sin(degreesToRadians(genRotation-90))
        genRotation = (genRotation + math.random(-roadCrazyness,roadCrazyness)) % 360
    end


    if(#objects>37) then
        for i=37,#objects do
            if  objects[i]~=nil then
            if (math.dist(carX,carZ,objects[i][1],objects[i][3])<10) then
                removeCheckpoint()
                points=points+1
            end
        end
        end
     
    end

   

    for i=-1,1 do
        for j=-1,1 do
            
            objects[30+i+j*3]:setPos(i*50+(math.floor(carX/50)*50),0,j*50+(math.floor(carZ/50)*50))
        end
    end


      if keysDown[keys.left] then
    carYaw = (carYaw + turnSpeed * dt) % 360
  end
  if keysDown[keys.right] then
    carYaw = (carYaw - turnSpeed * dt) % 360
  end

  updateCameraYaw(dt)

    if keysDown[keys.up] and carY==0 then
    carVel =carVel - speed * dt
  end

    if keysDown[keys.down]and carY==0 then
        carVel = carVel + speed * dt
    end

    if keysDown[keys.space] and carY==0 then
        carYVel = 13
    end

    carYVel = carYVel - 13.0 * dt
    carY = carY + carYVel * dt
    if carY < 0 then
        carY = 0
        carYVel = 0
    end
    if carY==0 then
    carVel=carVel*0.991
    end
    carX = carX + math.cos(degreesToRadians(-carYaw)) * carVel * dt
    carZ = carZ + math.sin(degreesToRadians(-carYaw)) * carVel * dt
  objects[1]:setPos(carX, math.sin(os.clock()*20)*math.abs(carVel*0.003)+carY, carZ)
  objects[1]:setRot(0, degreesToRadians(carYaw+90), 0)
  objects[2]:setPos(carX, 0.1, carZ)
  objects[2]:setRot(0, degreesToRadians(carYaw+90), 0)
end

-- handle the game logic and camera movement in steps
local function gameLoop()
  local lastTime = os.clock()

  while true do
    -- compute the time passed since last step
    local currentTime = os.clock()
    local dt = currentTime - lastTime
    lastTime = currentTime

    -- run all functions that need to be run
    handleGameLogic(dt)
    handleCameraMovement(dt)

    -- use a fake event to yield the coroutine
    os.queueEvent("gameLoop")
    os.pullEventRaw("gameLoop")
  end
end


function drawPoints()
       -- term.setBackgroundColor(colors.gray)
    --term.setTextColor(colors.white)
    ----term.setCursorPos(1,17)
   -- term.write("              ")
    --term.setCursorPos(1,18)
   -- term.write("              ")
    --term.setCursorPos(1,19)
    --term.write("              ")
    --term.setCursorPos(2,18)
    --term.write("Points: "..points)
end

-- render the objects
local function rendering()
  while true do
    -- load all objects onto the buffer and draw the buffer
    drawPoints()
    ThreeDFrame:drawObjects(objects)
    drawPoints()
    ThreeDFrame:drawBuffer()
drawPoints()

    -- use a fake event to yield the coroutine
    os.queueEvent("rendering")
    drawPoints()
    os.pullEventRaw("rendering")
    drawPoints()
  end
end

-- start the functions to run in parallel
parallel.waitForAny(keyInput, gameLoop, rendering)