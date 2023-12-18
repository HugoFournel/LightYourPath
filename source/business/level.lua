pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- level.lua
-- by hav
-- Level class

Level =
   {
      platforms  = {},
      grounds    = {},
      difficulty = 0,
      light      = true
   }


-- Constructor
function Level:new(platforms, grounds, difficulty, light)
   local o = {}
   setmetatable(o, {__index = self})

   --Attributes
   o.platforms  = platforms or {}
   o.grounds    = grounds   or {}
   o.difficulty = difficulty or 0
   o.light      = light or true
   --
   
   return o
end

-- Add a platform to the list of level s platforms
function Level:AddPlatform(platform)
   -- Checking platform conditions before adding it
       --TO DO
   --

   add(self.platforms,platform)

end

-- Add a ground to the list of level s grounds
function Level:AddGround(platform)
   -- Checking ground conditions before adding it
       --TO DO
   --

   add(self.grounds,platform)

end

-- Change the current light setting boolean value
function Level:SwitchLight()
   self.light = not self.light
end