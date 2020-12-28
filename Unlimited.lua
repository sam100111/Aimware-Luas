
--- GUI STUFF
local w, h = draw.GetScreenSize()
local x = w/2
local y = h/2
local current_angle = 0
local drawLeft = 0
local drawRight = 0
local drawBack = 0

setFont = draw.SetFont
createFont = draw.CreateFont
getScreenSize = draw.GetScreenSize
getLocal = entities.GetLocalPlayer
color = draw.Color
text = draw.TextShadow

--- LOADER
