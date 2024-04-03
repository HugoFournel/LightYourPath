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
      endflags   = {},     
      difficulty = 0,
   }


-- Constructor
function Level:new(platforms, grounds, difficulty, endflags)
   local o = {}
   setmetatable(o, {__index = self})

   --Attributes
   o.platforms  = platforms or {}
   o.grounds    = grounds   or {}
   o.difficulty = difficulty or 0
   o.endflags   = endflags or {}
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


-- Add a end flags to the list of level s end flags
function Level:AddEndFlag(platform)
   -- Checking end flags conditions before adding it
       --TO DO
   --

   add(self.endflags,platform)

end

-- Change the current value of all platform visible attribute
function Level:SwitchLight()
   for i = 1 , #self.platforms do 
      local platform = self.platforms[i]
      platform.visible = not platform.visible
   end
end

-- Checking collision with end flags
function Level:CheckCollisionEnd(player)
   for i = 1, #self.endflags do 
      local endflag =  self.endflags[i]
      if player:CheckCollision(endflag) then
         self:SwitchLight()
         player.x = 8
         player.y = 100
         player.score += 1
         sfx(3)
      end
   end
 end

 -- Checking collision with platforms
function Level:CheckCollisionPlatform(player)
   for i = 1, #self.platforms do
     local platform = self.platforms[i]
 
     if player:CheckCollision(platform) then
       -- The player is on the platform
        player.y = platform.y - player.h - 1
        player.vy = 0
        player.can_jump = true
        platform.visible = true
     end  
   end
end

-- Checking collision with grounds
function Level:CheckCollisionGround(player)
   for i = 1, #self.grounds do
      local platform = self.grounds[i]

      if player:CheckCollision(platform) then
         -- The player is on the ground
         player.y = platform.y - player.h - 1
         player.vy = 0
         player.can_jump = true
         platform.visible = true
      end  
   end
end
 -- Fonction de verification de collision
function Level:CheckCollision(player)
   self:CheckCollisionPlatform(player)
   self:CheckCollisionGround(player)
   self:CheckCollisionEnd(player)
end
 
 