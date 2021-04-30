return function(Text: string, Parent: instance): Frame
	local Key = Instance.new("Frame")
	local Container = Instance.new("Frame")
	local Background = Instance.new("Frame")
	local Body = Instance.new("Frame")
	local Key2 = Instance.new("TextLabel")
	local UICorner = Instance.new("UICorner")
	local UICorner2 = Instance.new("UICorner")
	local UIPadding = Instance.new("UIPadding")
	local UIPadding2 = Instance.new("UIPadding")
	local UIScale = Instance.new("UIScale")
	
	Key.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Key.BackgroundTransparency = 1
	Key.BorderSizePixel = 0
	Key.Name = "Key"
	Key.Size = UDim2.new(0, 0, 0, 50)
	Key.Parent = Parent

	Container.AnchorPoint = Vector2.new(0.5, 0.5)
	Container.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	Container.BorderSizePixel = 0
	Container.Name = "Container"
	Container.Position = UDim2.new(0.5, 0, 0.5, 0)
	Container.Size = UDim2.new(1, 0, 1, 4)
	Container.Parent = Key

	Background.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Background.BorderSizePixel = 0
	Background.Name = "Background"
	Background.Size = UDim2.new(1, 0, 1, 0)
	Background.Parent = Container

	UICorner.Parent = Container

	Body.AnchorPoint = Vector2.new(0.5, 0)
	Body.BackgroundTransparency = 1
	Body.BorderSizePixel = 0
	Body.Name = "Body"
	Body.AutomaticSize = Enum.AutomaticSize.X
	Body.Position = UDim2.new(0.5, 0, 0, 0)
	Body.Size = UDim2.new(0, 0, 1, 0)
	Body.Parent = Container

	UIPadding.PaddingBottom = UDim.new(0, 2)
	UIPadding.PaddingLeft = UDim.new(0, 2)
	UIPadding.PaddingRight = UDim.new(0, 2)
	UIPadding.PaddingTop = UDim.new(0, 2)
	UIPadding.Parent = Container

	UIScale.Parent = Container

	UICorner2.CornerRadius = UDim.new(0, 6)
	UICorner2.Parent = Background

	Key2.AnchorPoint = Vector2.new(0, 0.5)
	Key2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Key2.BackgroundTransparency = 1
	Key2.BorderSizePixel = 0
	Key2.Font = Enum.Font.GothamBold
	Key2.Name = "Key"
	Key2.Position = UDim2.new(0, 0, 0.5, 0)
	Key2.Size = UDim2.new(0, 0, 0, 18)
	Key2.AutomaticSize = Enum.AutomaticSize.X
	Key2.Text = Text
	Key2.TextSize = 18
	Key2.TextColor3 = Color3.fromRGB(255, 255, 255)
	Key2.Parent = Body

	UIPadding2.PaddingLeft = UDim.new(0, 16)
	UIPadding2.PaddingRight = UDim.new(0, 16)
	UIPadding2.Parent = Body
	
	Key2:GetPropertyChangedSignal("Text"):Connect(function()
		Key.Size = UDim2.new(0, math.clamp(Body.AbsoluteSize.X + 4, 54, math.huge), 0, 50)
	end)
	
	Key.Size = UDim2.new(0, math.clamp(Body.AbsoluteSize.X + 4, 54, math.huge), 0, 50)
	return Key
end