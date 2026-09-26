getgenv().script_mode = "PVP" -- PVP, FARM

-- Načtení základních služeb Robloxu
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Odstranění starého menu, pokud už nějaké běželo
if CoreGui:FindFirstChild("CeskyHubGui") then
    CoreGui.CeskyHubGui:Destroy()
end

-- Vytvoření hlavního grafického okna (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CeskyHubGui"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Nadpis okna
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "ČESKÝ HUB // DELTA"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.TextSize = 14
Title.Font = Enum.Font.Code
Title.Parent = MainFrame

-- Tlačítko 1: Rychlost chůze
local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0, 280, 0, 40)
SpeedButton.Position = UDim2.new(0.5, -140, 0, 55)
SpeedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedButton.Text = "Rychlost: VYPNUTO"
SpeedButton.TextColor3 = Color3.fromRGB(200, 200, 200)
SpeedButton.TextSize = 13
SpeedButton.Font = Enum.Font.Code
SpeedButton.Parent = MainFrame

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 6)
BtnCorner1.Parent = SpeedButton

local speedActive = false
SpeedButton.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        if speedActive then
            SpeedButton.BackgroundColor3 = Color3.fromRGB(20, 100, 20)
            SpeedButton.Text = "Rychlost: ZAPNUTO (50)"
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = 50
        else
            SpeedButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SpeedButton.Text = "Rychlost: VYPNUTO"
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        end
    end
end)

-- Tlačítko 2: Vysoký skok
local JumpButton = Instance.new("TextButton")
JumpButton.Size = UDim2.new(0, 280, 0, 40)
JumpButton.Position = UDim2.new(0.5, -140, 0, 110)
JumpButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
JumpButton.Text = "Vysoký skok: VYPNUTO"
JumpButton.TextColor3 = Color3.fromRGB(200, 200, 200)
JumpButton.TextSize = 13
JumpButton.Font = Enum.Font.Code
JumpButton.Parent = MainFrame

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = JumpButton

local jumpActive = false
JumpButton.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        if jumpActive then
            JumpButton.BackgroundColor3 = Color3.fromRGB(20, 100, 20)
            JumpButton.Text = "Vysoký skok: ZAPNUTO"
            char:FindFirstChildOfClass("Humanoid").JumpPower = 120
        else
            JumpButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            JumpButton.Text = "Vysoký skok: VYPNUTO"
            char:FindFirstChildOfClass("Humanoid").JumpPower = 50
        end
    end
end)

-- Tlačítko 3: ESP (Zvýraznění hráčů)
local EspButton = Instance.new("TextButton")
EspButton.Size = UDim2.new(0, 280, 0, 40)
EspButton.Position = UDim2.new(0.5, -140, 0, 165)
EspButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
EspButton.Text = "ESP (Zvýraznění): VYPNUTO"
EspButton.TextColor3 = Color3.fromRGB(200, 200, 200)
EspButton.TextSize = 13
EspButton.Font = Enum.Font.Code
EspButton.Parent = MainFrame

local BtnCorner3 = Instance.new("UICorner")
BtnCorner3.CornerRadius = UDim.new(0, 6)
BtnCorner3.Parent = EspButton

local espActive = false
EspButton.MouseButton1Click:Connect(function()
    espActive = not espActive
    if espActive then
        EspButton.BackgroundColor3 = Color3.fromRGB(20, 100, 20)
        EspButton.Text = "ESP (Zvýraznění): ZAPNUTO"
    else
        EspButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        EspButton.Text = "ESP (Zvýraznění): VYPNUTO"
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("CeskyHighlight") then
                p.Character.CeskyHighlight:Destroy()
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if espActive then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not p.Character:FindFirstChild("CeskyHighlight") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "CeskyHighlight"
                    hl.FillColor = Color3.fromRGB(255, 0, 0)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                end
            end
        end
    end
end)

-- Tlačítko 4: Zavření menu
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 280, 0, 40)
CloseButton.Position = UDim2.new(0.5, -140, 0, 240)
CloseButton.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
CloseButton.Text = "Zavřít Menu"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 13
CloseButton.Font = Enum.Font.Code
CloseButton.Parent = MainFrame

local BtnCorner4 = Instance.new("UICorner")
BtnCorner4.CornerRadius = UDim.new(0, 6)
BtnCorner4.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
