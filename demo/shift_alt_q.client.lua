local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KeyGuider = require(ReplicatedStorage:WaitForChild("KeyGuider")).new(script.Parent)

KeyGuider:AddKey(Enum.KeyCode.LeftShift)
KeyGuider:AddKey(Enum.KeyCode.RightAlt)
KeyGuider:AddKey(Enum.KeyCode.Q)

KeyGuider.onComplete.Event:Connect(function(status: boolean)
    if status then
        warn("Combination LeftShift, RightAlt, Q is now pressed")
    end
end)