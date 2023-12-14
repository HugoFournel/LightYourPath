pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- player.p8
-- by hav
-- Player class

-- Table
Player =
   {
      health            = 0,
      score             = 0,
      x                 = 0,
      y                 = 0,
      w                 = 0, 
      h                 = 0, 
      speed             = 0, 
      vy                = 0, 
      gravity           = 0, 
      jump_force        = 0, 
      can_jump          = false, 
      sprite            = 0,
      animation_list    = {},
      current_animation = Animation:new(),
      last_animation    = Animation:new()
   }

-- Constructor
function Player:new (health,score,x,y,w,h,speed,vy,gravity,jump_force,can_jump,sprite)
    local o = {}
    setmetatable(o, {__index = self})
    
    -- Attributes
    o.health            = health or 0
    o.score             = score or 0
    o.x                 = x or 0
    o.y                 = y or 0
    o.w                 = w or 0
    o.h                 = h or 0
    o.speed             = speed or 0
    o.vy                = vy or 0
    o.gravity           = gravity or 0
    o.jump_force        = jump_force or 0
    o.can_jump          = can_jump or false
    o.sprite            = sprite or 0
    o.animation_list    = self:BuildAnimations()
    --
    
    return o
end


-- Player movement function

function Player:Movement()
   -- Horizontal
   printh(self:GetHitbox().x,"@clip")
   if btn(0) and self:GetHitbox().x >= 1 then
     -- LEFT RUN
     self.x -= self.speed
     self.current_animation = self.animation_list["RUNLEFT"]
     self.last_animation = self.current_animation
     
   elseif btn(1) and self:GetHitbox().x + self:GetHitbox().w <= 127 then
     -- RIGHT RUN
     self.x += self.speed
     self.current_animation =  self.animation_list["RUNRIGHT"]
     self.last_animation = self.current_animation
     
   elseif self.last_animation ~= nil and self.last_animation.name == "RUNLEFT" then
      self.current_animation = self.animation_list["IDLELEFT"]
      self.last_animation = self.current_animation
      
   elseif self.last_animation ~= nil and self.last_animation.name == "RUNRIGHT" then
      self.current_animation = self.animation_list["IDLERIGHT"]
      self.last_animation = self.current_animation
  end

  -- Jump
  
  if btnp(4) and self.can_jump then
    self.vy = self.jump_force
    self.can_jump = false
    sfx(1)
  end

  -- Gravity
  self.vy += self.gravity
  self.y += self.vy

  -- Checking if player hit the ground
  self:CheckGroundCollision()
  
end

function Player:CheckGroundCollision()
  -- Ground collision
  -- If ground collision then position is reset and health is decremented
   if self:GetHitbox().y + self:GetHitbox().h >= 131 then
     self.y = 110
     self.x = 4
     self.vy = 0
     self.can_jump = true
     self:TakeDamage(1)
  end
end

-- Player health function

function Player:TakeDamage(amount)
   self.health -= amount
   if not self:CheckDeath() then
      sfx(0)
   end
end

function Player:CheckDeath()
    rep = false
    if self.health <= 0 then
       rep = true
    end
    return rep
end

-- Player collisions

-- Player hitbox rectangle coordinates 
function Player:GetHitbox()
   hitbox = Hitbox:new(self.x,self.y,self.w,self.h)
   return hitbox
end


--Player Animations

-- Build the list of player s animations
function Player:BuildAnimations()
   list = {}

   run_left   = Animation:new("RUNLEFT", {5,6,7}, 20)
   run_right  = Animation:new("RUNRIGHT", {1,2,3}, 20)
   idle_right = Animation:new("IDLERIGHT", {0}, 20)
   idle_left  = Animation:new("IDLELEFT", {4}, 20)

   list["RUNLEFT"]   = run_left
   list["RUNRIGHT"]  = run_right
   list["IDLERIGHT"] = idle_right
   list["IDLELEFT"] = idle_left
   
   return list
end


-- Set the current player sprite depending on animation state
function Player:Animate()

   --Checking if current sprite is part of the current animation
   is_in_list = false
   for i = 1, #player.current_animation.sprites do
      if player.sprite == player.current_animation.sprites[i] then
	 is_in_list = true
      end
   end


   -- Setting new sprite
   if not is_in_list then
      -- Setting sprite to the first animation s sprite
      player.sprite = player.current_animation.sprites[1]
   else
      -- Continue the animation by looping on the animation s sprites
      if  player.current_animation.sprites[i] == player.current_animation.sprites[#player.current_animation.sprites] then
         player.sprite =  player.current_animation.sprites[1]
      else
	 player.sprite = player.current_animation.sprites[player.sprite+1]
      end
   end
end
