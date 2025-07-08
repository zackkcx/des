-- 📦 Tel-Ray GUI z przeciąganiem, minimalizacją i kółkiem powrotu
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- 🌒 Główne GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TelRayGUI"

-- 🔳 Główna ramka
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0, 100, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true

-- 🖱️ Przeciąganie okna
local dragging, dragInput, dragStart, startPos

local function update(input)
	if not dragging then return end
	local delta = input.Position - dragStart
	main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput then
		update(input)
	end
end)

-- 🔳 Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- 🔳 Zawartość
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -130, 1, 0)
content.Position = UDim2.new(0, 130, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- 🔘 Zakładki
local tabs = {"Player", "Tel-Ray", "Settings"}
local tabButtons = {}
local tabFrames = {}
local selectedTab = "Tel-Ray"

for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton", sidebar)
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 40)
	btn.BackgroundColor3 = (name == selectedTab) and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(30, 30, 30)
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16
	btn.BorderSizePixel = 0
	tabButtons[name] = btn

	local tabFrame = Instance.new("Frame", content)
	tabFrame.Name = name
	tabFrame.Size = UDim2.new(1, 0, 1, 0)
	tabFrame.BackgroundTransparency = 1
	tabFrame.Visible = (name == selectedTab)
	tabFrames[name] = tabFrame

	btn.MouseButton1Click:Connect(function()
		selectedTab = name
		for n, b in pairs(tabButtons) do
			b.BackgroundColor3 = (n == selectedTab) and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(30, 30, 30)
		end
		for n, f in pairs(tabFrames) do
			f.Visible = (n == selectedTab)
		end
	end)
end

-- 🔽 Minimalizacja
local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.Text = "-"
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
minBtn.BorderSizePixel = 0

-- 🟢 Przezroczyste kółko przywracające GUI
local circleBtn = Instance.new("TextButton", gui)
circleBtn.Size = UDim2.new(0, 40, 0, 40)
circleBtn.Position = UDim2.new(0, 10, 0, 10)
circleBtn.BackgroundTransparency = 0.6
circleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
circleBtn.Text = "+"
circleBtn.TextColor3 = Color3.new(1,1,1)
circleBtn.Font = Enum.Font.SourceSansBold
circleBtn.TextSize = 28
circleBtn.Visible = false
circleBtn.ZIndex = 20
circleBtn.BorderSizePixel = 0
circleBtn.ClipsDescendants = true
circleBtn.AutoButtonColor = true
circleBtn.Name = "ShowGuiButton"
circleBtn.AnchorPoint = Vector2.new(0, 0)
circleBtn.TextStrokeTransparency = 0.5
circleBtn.TextTransparency = 0.2
circleBtn.BackgroundTransparency = 0.3
circleBtn.TextWrapped = true
circleBtn.TextYAlignment = Enum.TextYAlignment.Center

-- 🔁 Minimalizacja / Maksymalizacja
local minimized = false
minBtn.MouseButton1Click:Connect(function()
	minimized = true
	main.Visible = false
	circleBtn.Visible = true
end)

circleBtn.MouseButton1Click:Connect(function()
	minimized = false
	main.Visible = true
	circleBtn.Visible = false
end)

-- ✅ Przykład zawartości
local label = Instance.new("TextLabel", tabFrames["Tel-Ray"])
label.Text = "Tel-Ray Tomb Controls"
label.Size = UDim2.new(1, -20, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1
label.Font = Enum.Font.SourceSansBold
label.TextSize = 20
label.TextXAlignment = Enum.TextXAlignment.Left
