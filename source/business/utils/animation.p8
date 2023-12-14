pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- animation.p8
-- by hav
-- Animation class

Animation =
   {
      name = "",
      sprites = {},
      sfx     =  0
   }


-- Constructor
function Animation:new(name,sprites,sfx)
   local o = {}
   setmetatable(o, {__index = self})

   --Attributes
   o.name = name or ""
   o.sprites = sprites or {}
   o.sfx = sfx or 0

   --
   return o
end
