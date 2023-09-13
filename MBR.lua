local image = require("image")
local system = require("system")
local fs=require("filesystem")
local PathToRes=fs.path(system.getCurrentScript())

local function LoadModule(path)
	local Suc,Res = loadfile(PathToRes..path)
	if not Suc then error(Res) end
	return Suc()
end

local GUI = require("GUI")
local buffer = require("screen")
local image = require("image")
local event = require("event")
local computer = require("computer")
local DisplayWidth,DisplayHeight = buffer.getResolution()
local GameScreenX,GameScreenY,GameScreenWidth,GameScreenHeight = 28,3,100,44
local enemySpawnPoint = {GameScreenX,GameScreenY,(GameScreenWidth+GameScreenX)/2+8,GameScreenY,GameScreenWidth+GameScreenX-8,GameScreenY}
local winFlag = 1
local momContainer = GUI.workspace()

local function debug(x,y,container,comment)
  local debugInfo = GUI.object(x, y, 10, 10)

  debugInfo.draw = function()
    buffer.drawText(x,y,0x00DBFF,comment..":")

    for i=1, #container.children do
      local obj = container.children[i]
      local objType = obj.type or "----"
      if obj.debugFlag == 1 then
        buffer.drawText(x,y+i,0x00DBFF,"#" .. i .. " type:".. objType .. " x=" .. obj.localX .. " y=" .. obj.localY)
      else
        buffer.drawText(x,y+i,0x00DBFF,"#" .. i .. " type:".. objType .. " x=" .. obj.localX .. " y=" .. obj.localY)
      end
    end
  end
  return debugInfo
end 

local function textToObject(x,y,comment,textColor)
  local debugInfo = GUI.object(x, y, 1, string.len(comment))
  local color = textColor or 0x0

  debugInfo.text = comment
  debugInfo.type = "text"
  debugInfo.draw = function()
    buffer.drawText(x,y,color,debugInfo.text)
  end
  return debugInfo
end 

buffer.drawText(1,2,0x00DBFF,":(")
buffer.drawText(1,2,0x00DBFF," Critical Stop")
buffer.drawText(1,2,0x00DBFF," Error:00000001")
momContainer:draw()
momContainer:start(0)
