# CharacterHitbox
this module allows you to create hitbox easily.

### How to create hitbox?
```lua
local module = require(game:GetService("ServerScriptService").CharacterHitbox)
local npc = game.Workspace.NPC
local hitbox = module.CreateHitbox(npc, 5, {
  ["Transparency"] = 0.3,
})

--module.CreateHitbox(model, size, options)
--Options = Transparency, PrimaryPart

```

### What is the hitbox functions?
```lua
hitbox:TouchDamageStart(1, 0.5)
--hitbox:TouchDamageStart(damage, debounce)
hitbox:TouchDamageStop()
--stops the above function
hitbox.Touched:Connect(function(hit)
  
end)
--default touched event of hitbox
hitbox:Destroy()
--destroys hitbox
```
