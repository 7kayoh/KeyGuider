local module = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Common = ReplicatedStorage.Common
local Flipper = require(Common.Flipper)
local Component = require(script.component)

local springProps = {
    frequency = 2,
	dampingRatio = 0.6,
}
local outSpringProps = {
    frequency = 3,
	dampingRatio = 0.8,
}

function module.new(Parent)
    local ScreenGui = Instance.new("ScreenGui")
    local Guider = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.Padding = UDim.new(0, 15)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Guider.AnchorPoint = Vector2.new(0.5, 1)
    Guider.Position = UDim2.new(0.5, 0, 1, -100)
    Guider.Size = UDim2.new(1, 0, 0, 50)
    Guider.BackgroundTransparency = 1
    Guider.Name = "Guider"
    ScreenGui.Name = script.Name
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    UIListLayout.Parent = Guider
    Guider.Parent = ScreenGui
    ScreenGui.Parent = Parent

    local meta = setmetatable({
        _object = ScreenGui,
        keys = {},
        onComplete = Instance.new("BindableEvent")
    }, module)

    meta:Deploy()
    return meta
end

function module:AddKey(Key: EnumItem)
    if Enum.KeyCode[Key.Name] then
        self.keys[Key.Name] = {
            _object = Component(Key.Name, self._object.Guider),
            motor = Flipper.SingleMotor.new(0)
        }
        
        self.keys[Key.Name].motor:onStep(function(value)
            if self.keys and self.keys[Key.Name] then
                if self.keys[Key.Name]._object and self.keys[Key.Name]._object:FindFirstChild("Container") then
                    self.keys[Key.Name]._object.Container.UIScale.Scale = value
                end
            end
        end)

        self.keys[Key.Name].motor:setGoal(Flipper.Spring.new(1, springProps))
    end
end

function module:Deploy()
    self._inputBegan = UserInputService.InputBegan:Connect(function(inputObject, isGameProcessed)
        if isGameProcessed and not self.keys[inputObject.KeyCode.Name] then
            local totalChecked, total = 0, 0
            self.keys[inputObject.KeyCode.Name].motor:setGoal(Flipper.Spring.new(0, outSpringProps))
            self.keys[inputObject.KeyCode.Name].checked = true

            for _, key in pairs(self.keys) do
                total += 1
                if key.checked then
                    totalChecked += 1
                end
            end

            if totalChecked == total then
                self.onComplete:Fire(true)
                self:Destroy()
            end
        end
    end)

    self._inputEnded = UserInputService.InputEnded:Connect(function(inputObject, isGameProcessed)
        if not isGameProcessed and self.keys[inputObject.KeyCode.Name] then
            self.keys[inputObject.KeyCode.Name].motor:setGoal(Flipper.Spring.new(1, springProps))
            self.keys[inputObject.KeyCode.Name].checked = false
        end
    end)
end

function module:Destroy()
    local counter, total = 0, 0
    local isDone = Instance.new("BindableEvent")
    self._inputBegan:Disconnect()
    self._inputEnded:Disconnect()
    self.onComplete:Destroy()
    for _, key in pairs(self.keys) do
        total += 1
        key.motor:setGoal(Flipper.Spring.new(0, outSpringProps))
        key.motor:onComplete(function()
            key.motor:onStep(function() end)
            key._object:Destroy()
            key._object = nil
            key = nil
            counter += 1

            if counter == total then
                isDone:Fire()
            end
        end)
    end
    isDone.Event:Wait()
    isDone:Destroy()
    self._object:Destroy()
    self.keys = nil
    self._object = nil
    self.onComplete = nil
end

module.__index = module
return module