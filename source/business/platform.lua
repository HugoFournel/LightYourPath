pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- platform.lua
-- by hav
-- Platform class

Platform =
   {
      x =  0,
      y =  0,
      w =  0,
      h =  0,
      visible = true
   }


-- Constructor
function Platform:new(x,y,w,h,visible)
   local o = {}
   setmetatable(o, {__index = self})

   --Attributes
   o.x = x or 0
   o.y = y or 0
   o.w = w or 0
   o.h = h or 0
   o.visible = visible or true
   --
   
   return o
end
