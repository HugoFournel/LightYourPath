-- hitbox.lua
-- by hav
-- Hitbox class

Hitbox =
   {
      x = 0,
      y = 0,
      w = 0,
      h = 0
   }

function Hitbox:new(x,y,w,h)
   local o = {}
   setmetatable(o, {__index = self})

   --Attributes
   o.x = x or 0
   o.y = y or 0
   o.w = w or 0
   o.h = h or 0
   
   return o
end

function Hitbox:ReturnArea(x,y)
   return self.w * self.h
end


function Hitbox:GetTopLeftCorner()
   return {x,y}
end

function Hitbox:GetTopRightCorner()
   return {x+w,y}
end

function Hitbox:GetBotLeftCorner()
   return {x,y+h}
end

function Hitbox:GetBotLeftCorner()
   return {x+w,y+h}
end
