--made by xtandeasd3v
local module = {}
module.__index = module
setmetatable({}, module)
local RunService = game:GetService("RunService")
function module.CreateHitbox(model : BasePart & Model, range : number, options : {})

	local self = setmetatable({}, module)
	local Touched = Instance.new("BindableEvent")
	self.Touched = Touched.Event
	self.Coroutines = {}
	local primarypart = options["PrimaryPart"] or model.PrimaryPart or model
	local transparency = options["Transparency"] or 0
	local Color = options["Color3"] or Color3.fromRGB(163, 162, 165)
	if primarypart:IsA("Model") then
		error("Please Put a PrimaryPart.")
	end
	if typeof(transparency) ~= "number" then
		error("Transparency cant be a "..typeof(transparency).." please enter valid Number.")
	end
	if typeof(Color) ~= "Color3" then
		error("Color cant be a "..typeof(Color).." please enter valid Color3 Value.")
	end
	local hitbox = Instance.new("Part")
	hitbox.Parent = primarypart
	local weld = Instance.new("Weld", hitbox)
	weld.Part0 = primarypart
	weld.Part1 = hitbox
	hitbox.CanCollide = false
	hitbox.Name = "hitbox"
	hitbox.Transparency = transparency
	hitbox.Color = Color
	self.Model = model or primarypart or options["PrimaryPart"]
	local size = model:GetExtentsSize().Y or primarypart.Size.Y
	hitbox.Size = Vector3.new(range, size, range) 
	self.Hitbox = hitbox
	function self:TouchDamageStart(damage : number, seconds)
		if self.TouchDamage ~= true then
			self.TouchDamage = true
			local thread = coroutine.create(function()
				local db = false
				while task.wait(seconds) do
					local finded = {}
					for i,hit in pairs(game.Workspace:GetPartsInPart(hitbox)) do
						
						if hit.Parent then
							if hit.Parent ~= model or hit ~= primarypart then
								if game.Players:GetPlayerFromCharacter(hit.Parent) then
									local player = game.Players:GetPlayerFromCharacter(hit.Parent)
									local character = hit.Parent
									if character:FindFirstChildOfClass("Humanoid") then
										if character:FindFirstChildOfClass("Humanoid").Health > 0 then
											if table.find(finded, hit.Parent) == nil then
												table.insert(finded, hit.Parent)
												character:FindFirstChildOfClass("Humanoid"):TakeDamage(damage)
											end
										end
									end
								end
							end
						end
					end
				end

			end)
			coroutine.resume(thread)
			self.Coroutines["Touch"] = thread
		else
			error("Please stop other TouchDamage Event.")
		end

	end
	
	coroutine.resume(coroutine.create(function()
		while true do
			for i,v in pairs(workspace:GetPartsInPart(hitbox)) do
				if v ~= nil then
					Touched:Fire(v)
				end
			end
			task.wait(0.5)
		end
	end))
	
	
	function self:TouchDamageStop()
		if self.TouchDamage ~= false then
			self.TouchDamage = false
			if self.Coroutines["Touch"] ~= nil then
				coroutine.close(self.Coroutines["Touch"])
			end
		end
	end
	
	
	function self:Destroy()
		hitbox:Destroy()
		table.clear(self.Coroutines)
	end
	
	return self
end

return module
