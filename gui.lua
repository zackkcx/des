-- 📦 Tel-Ray GUI z przeciąganiem, minimalizacją i KillAurą (pełna wersja)
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- 🌒 Screen GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TelRayGUI"

-- 📦 Główne okno
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0, 100, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true

-- 🖱️ Przeciąganie
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
local tabButtons, tabFrames = {}, {}
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

-- 🟥 Minimalizacja
local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -30, 0, 0)
minBtn.Text = "-"
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 20
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
minBtn.BorderSizePixel = 0

-- 🔘 Kółko do przywrócenia GUI
local circleBtn = Instance.new("TextButton", gui)
circleBtn.Size = UDim2.new(0, 40, 0, 40)
circleBtn.Position = UDim2.new(0, 10, 0, 10)
circleBtn.BackgroundTransparency = 0.4
circleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
circleBtn.Text = "+"
circleBtn.TextColor3 = Color3.new(1,1,1)
circleBtn.Font = Enum.Font.SourceSansBold
circleBtn.TextSize = 28
circleBtn.Visible = false
circleBtn.BorderSizePixel = 0

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

-- 🧱 Player Tab with KillAura
local labelPlayer = Instance.new("TextLabel", tabFrames["Player"])
labelPlayer.Text = "KillAura & Player Tools"
labelPlayer.Size = UDim2.new(1, -20, 0, 30)
labelPlayer.Position = UDim2.new(0, 10, 0, 10)
labelPlayer.TextColor3 = Color3.new(1,1,1)
labelPlayer.BackgroundTransparency = 1
labelPlayer.Font = Enum.Font.SourceSansBold
labelPlayer.TextSize = 20
labelPlayer.TextXAlignment = Enum.TextXAlignment.Left

local killAuraEnabled = false

local auraToggle = Instance.new("TextButton", tabFrames["Player"])
auraToggle.Size = UDim2.new(0, 200, 0, 30)
auraToggle.Position = UDim2.new(0, 10, 0, 60)
auraToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
auraToggle.TextColor3 = Color3.new(1,1,1)
auraToggle.Font = Enum.Font.SourceSans
auraToggle.TextSize = 16
auraToggle.Text = "⛔ KillAura"
auraToggle.BorderSizePixel = 0

auraToggle.MouseButton1Click:Connect(function()
    killAuraEnabled = not killAuraEnabled
    auraToggle.Text = killAuraEnabled and "✅ KillAura" or "⛔ KillAura"
end)

local cooldownBox = Instance.new("TextBox", tabFrames["Player"])
cooldownBox.Size = UDim2.new(0, 200, 0, 25)
cooldownBox.Position = UDim2.new(0, 10, 0, 100)
cooldownBox.PlaceholderText = "Attack Cooldown (sec)"
cooldownBox.Text = "0.3"
cooldownBox.TextColor3 = Color3.new(1,1,1)
cooldownBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
cooldownBox.BorderSizePixel = 0
cooldownBox.Font = Enum.Font.SourceSans
cooldownBox.TextSize = 14

local mobLimitBox = Instance.new("TextBox", tabFrames["Player"])
mobLimitBox.Size = UDim2.new(0, 200, 0, 25)
mobLimitBox.Position = UDim2.new(0, 10, 0, 135)
mobLimitBox.PlaceholderText = "Max Mob Limit"
mobLimitBox.Text = "3"
mobLimitBox.TextColor3 = Color3.new(1,1,1)
mobLimitBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mobLimitBox.BorderSizePixel = 0
mobLimitBox.Font = Enum.Font.SourceSans
mobLimitBox.TextSize = 14

local multiplierBox = Instance.new("TextBox", tabFrames["Player"])
multiplierBox.Size = UDim2.new(0, 200, 0, 25)
multiplierBox.Position = UDim2.new(0, 10, 0, 170)
multiplierBox.PlaceholderText = "Attack Multiplier"
multiplierBox.Text = "2"
multiplierBox.TextColor3 = Color3.new(1,1,1)
multiplierBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
multiplierBox.BorderSizePixel = 0
multiplierBox.Font = Enum.Font.SourceSans
multiplierBox.TextSize = 14

task.spawn(function()
	while true do
		if killAuraEnabled then
			pcall(function()
				local char = player.Character
				if not (char and char:FindFirstChild("HumanoidRootPart")) then return end

				local cooldown = tonumber(cooldownBox.Text) or 0.3
				local mobLimit = tonumber(mobLimitBox.Text) or 3
				local multiplier = tonumber(multiplierBox.Text) or 2

				local hitCount = 0
				for _, mob in pairs(workspace:GetDescendants()) do
					if mob:IsA("Model") and mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
						if mob.Humanoid.Health > 0 then
							local dist = (mob.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
							if dist < 20 then
								char.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
								for i = 1, multiplier do
									game:GetService("VirtualUser"):ClickButton1(Vector2.new())
								end
								hitCount += 1
								if hitCount >= mobLimit then break end
								task.wait(0.1)
							end
						end
					end
				end
				task.wait(cooldown)
			end)
		end
		task.wait(0.05)
	end
end)

-- 📌 Zakładki pozostałe
local labelDungeon = Instance.new("TextLabel", tabFrames["Tel-Ray"])
labelDungeon.Text = "Tel-Ray Dungeon Controls"
labelDungeon.Size = UDim2.new(1, -20, 0, 30)
labelDungeon.Position = UDim2.new(0, 10, 0, 10)
labelDungeon.TextColor3 = Color3.new(1,1,1)
labelDungeon.BackgroundTransparency = 1
labelDungeon.Font = Enum.Font.SourceSansBold
labelDungeon.TextSize = 20
labelDungeon.TextXAlignment = Enum.TextXAlignment.Left

local labelSettings = Instance.new("TextLabel", tabFrames["Settings"])
labelSettings.Text = "Settings / Info"
labelSettings.Size = UDim2.new(1, -20, 0, 30)
labelSettings.Position = UDim2.new(0, 10, 0, 10)
labelSettings.TextColor3 = Color3.new(1,1,1)
labelSettings.BackgroundTransparency = 1
labelSettings.Font = Enum.Font.SourceSansBold
labelSettings.TextSize = 20
labelSettings.TextXAlignment = Enum.TextXAlignment.Left


-- 📦 KillAura z GUI w zakładce "Player"
-- Upewnij się, że GUI już istnieje i ma tabFrames["Player"]

local toggle = Instance.new("TextButton", tabFrames["Player"])
toggle.Size = UDim2.new(0, 200, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 220)
toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggle.TextColor3 = Color3.new(1,1,1)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 16
toggle.Text = "🔴 KillAura: OFF"
toggle.BorderSizePixel = 0

local auraActive = false
toggle.MouseButton1Click:Connect(function()
    auraActive = not auraActive
    toggle.Text = auraActive and "🟢 KillAura: ON" or "🔴 KillAura: OFF"
end)

task.spawn(function()
    while true do
        if auraActive then
            pcall(function()
                local char = player.Character
                if not (char and char:FindFirstChild("HumanoidRootPart")) then return end

                for _, mob in pairs(workspace:GetDescendants()) do
                    if mob:IsA("Model") and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                        local hum = mob:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local dist = (mob.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                            if dist <= 30 then
                                char.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                                for i = 1, 2 do
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,0)
                                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,0)
                                    task.wait(0.05)
                                end
                                task.wait(0.2)
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end)
