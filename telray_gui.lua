-- 📦 Tel-Ray GUI (szkielet z 3 zakładkami)
local player = game.Players.LocalPlayer

-- Tworzenie GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TelRayGUI"

-- Główna ramka
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0, 100, 0, 100)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

-- Pasek zakładek (sidebar)
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 130, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

-- Główna zawartość
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -130, 1, 0)
content.Position = UDim2.new(0, 130, 0, 0)
content.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Lista zakładek
local tabs = {"Player", "Tel-Ray", "Settings"}
local tabButtons = {}
local tabFrames = {}

local selectedTab = "Tel-Ray"

-- Tworzenie przycisków zakładek
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

-- 🟦 Przykładowa zawartość zakładek
local label1 = Instance.new("TextLabel", tabFrames["Player"])
label1.Text = "Player Tools (tu będzie KillAura)"
label1.Size = UDim2.new(1, -20, 0, 30)
label1.Position = UDim2.new(0, 10, 0, 10)
label1.BackgroundTransparency = 1
label1.TextColor3 = Color3.new(1,1,1)
label1.Font = Enum.Font.SourceSansBold
label1.TextSize = 18
label1.TextXAlignment = Enum.TextXAlignment.Left

local label2 = Instance.new("TextLabel", tabFrames["Tel-Ray"])
label2.Text = "Tel-Ray's Tomb Controls"
label2.Size = UDim2.new(1, -20, 0, 30)
label2.Position = UDim2.new(0, 10, 0, 10)
label2.BackgroundTransparency = 1
label2.TextColor3 = Color3.new(1,1,1)
label2.Font = Enum.Font.SourceSansBold
label2.TextSize = 18
label2.TextXAlignment = Enum.TextXAlignment.Left

local label3 = Instance.new("TextLabel", tabFrames["Settings"])
label3.Text = "Settings / Credits / Save Config"
label3.Size = UDim2.new(1, -20, 0, 30)
label3.Position = UDim2.new(0, 10, 0, 10)
label3.BackgroundTransparency = 1
label3.TextColor3 = Color3.new(1,1,1)
label3.Font = Enum.Font.SourceSansBold
label3.TextSize = 18
label3.TextXAlignment = Enum.TextXAlignment.Left
