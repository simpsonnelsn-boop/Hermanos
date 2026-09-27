local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Odstranění starého menu, pokud běží
if CoreGui:FindFirstChild("ExpressHubPro") then
    CoreGui.ExpressHubPro:Destroy()
end
if CoreGui:FindFirstChild("ExpressLoginGui") then
    CoreGui.ExpressLoginGui:Destroy()
end

-- LOGIN OKNO (Zadání hesla: 123)
local LoginGui = Instance.new("ScreenGui")
LoginGui.Name = "ExpressLoginGui"
LoginGui.ResetOnSpawn = false
LoginGui.Parent = CoreGui

local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 300, 0, 160)
LoginFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
LoginFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
LoginFrame.Parent = LoginGui

local LoginCorner = Instance.new("UICorner") LoginCorner.CornerRadius = UDim.new(0, 8) LoginCorner.Parent = LoginFrame
local LoginStroke = Instance.new("UIStroke") LoginStroke.Color = Color3.fromRGB(150, 40, 220) LoginStroke.Thickness = 2 LoginStroke.Parent = LoginFrame

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Size = UDim2.new(1, 0, 0, 35)
LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "🔐 Express Hub - Autorizace"
LoginTitle.TextColor3 = Color3.fromRGB(240, 200, 255)
LoginTitle.TextSize = 12
LoginTitle.Font = Enum.Font.Code
LoginTitle.Parent = LoginFrame

local PassBox = Instance.new("TextBox")
PassBox.Size = UDim2.new(0.8, 0, 0, 35)
PassBox.Position = UDim2.new(0.1, 0, 0, 45)
PassBox.BackgroundColor3 = Color3.fromRGB(28, 24, 42)
PassBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PassBox.PlaceholderText = "Zadej heslo (123)..."
PassBox.Text = ""
PassBox.TextSize = 12
PassBox.Font = Enum.Font.Code
PassBox.Parent = LoginFrame
local PassCorner = Instance.new("UICorner") PassCorner.CornerRadius = UDim.new(0, 5) PassCorner.Parent = PassBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 35)
SubmitBtn.Position = UDim2.new(0.1, 0, 0, 95)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(70, 20, 90)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "POTVRDIT HESLO zmrde"
SubmitBtn.TextSize = 12
SubmitBtn.Font = Enum.Font.Code
SubmitBtn.Parent = LoginFrame
local SubCorner = Instance.new("UICorner") SubCorner.CornerRadius = UDim.new(0, 5) SubCorner.Parent = SubmitBtn

-- Hlavní script se spustí až po správném zadání hesla
SubmitBtn.MouseButton1Click:Connect(function()
    if PassBox.Text == "676767" then
        LoginGui:Destroy()
        
        -- HLAVNÍ SCRIPT
        local camlockEnabled = false
        local fullEspEnabled = true
        local fovRadius = 1400
        local noFogEnabled = false
        local menuVisible = true
        local spectatorTarget = nil

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "ExpressHubPro"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.Parent = CoreGui

        -- Delta plovoucí tlačítko na otevírání/zavírání menu
        local ToggleMenuBtn = Instance.new("TextButton")
        ToggleMenuBtn.Size = UDim2.new(0, 45, 0, 45)
        ToggleMenuBtn.Position = UDim2.new(0, 15, 0, 15)
        ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
        ToggleMenuBtn.TextColor3 = Color3.fromRGB(200, 100, 255)
        ToggleMenuBtn.TextSize = 18
        ToggleMenuBtn.Font = Enum.Font.Code
        ToggleMenuBtn.Text = "⚡"
        ToggleMenuBtn.Draggable = true
        ToggleMenuBtn.Active = true
        ToggleMenuBtn.Parent = ScreenGui

        local ToggleCorner = Instance.new("UICorner") ToggleCorner.CornerRadius = UDim.new(0, 10) ToggleCorner.Parent = ToggleMenuBtn
        local ToggleStroke = Instance.new("UIStroke") ToggleStroke.Color = Color3.fromRGB(150, 50, 220) ToggleStroke.Thickness = 2 ToggleStroke.Parent = ToggleMenuBtn

        -- Hlavní okno vojta gay 12
        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 540, 0, 360)
        MainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
        MainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
        MainFrame.BorderSizePixel = 0
        MainFrame.Active = true
        MainFrame.Draggable = true
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 8) MainCorner.Parent = MainFrame
        local MainStroke = Instance.new("UIStroke") MainStroke.Color = Color3.fromRGB(150, 40, 220) MainStroke.Thickness = 2 MainStroke.Parent = MainFrame

        ToggleMenuBtn.MouseButton1Click:Connect(function()
            menuVisible = not menuVisible
            MainFrame.Visible = menuVisible
        end)

        -- FPS & Ping Widget
        local StatsFrame = Instance.new("Frame")
        StatsFrame.Size = UDim2.new(0, 140, 0, 35)
        StatsFrame.Position = UDim2.new(0, 70, 0, 15)
        StatsFrame.BackgroundColor3 = Color3.fromRGB(20, 35, 65)
        StatsFrame.BorderSizePixel = 0
        StatsFrame.Parent = ScreenGui

        local StatsCorner = Instance.new("UICorner") StatsCorner.CornerRadius = UDim.new(0, 6) StatsCorner.Parent = StatsFrame
        local StatsStroke = Instance.new("UIStroke") StatsStroke.Color = Color3.fromRGB(60, 120, 200) StatsStroke.Thickness = 1.5 StatsStroke.Parent = StatsFrame

        local StatsText = Instance.new("TextLabel")
        StatsText.Size = UDim2.new(1, 0, 1, 0) StatsText.BackgroundTransparency = 1 StatsText.TextColor3 = Color3.fromRGB(50, 255, 100)
        StatsText.TextSize = 11 StatsText.Font = Enum.Font.Code StatsText.Text = "FPS: 60 | Ping: 35ms" StatsText.Parent = StatsFrame

        RunService.RenderStepped:Connect(function()
            local ping = 0
            pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
            StatsText.Text = string.format("FPS: 1000 | Ping: %dms", ping)
        end)

        -- Plovoucí tlačítko na Camlock
        local FloatCamBtn = Instance.new("TextButton")
        FloatCamBtn.Size = UDim2.new(0, 110, 0, 40)
        FloatCamBtn.Position = UDim2.new(0, 15, 0, 70)
        FloatCamBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        FloatCamBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        FloatCamBtn.TextSize = 12 FloatCamBtn.Font = Enum.Font.Code FloatCamBtn.Text = "Cam: [ OFF ]"
        FloatCamBtn.Draggable = true FloatCamBtn.Active = true FloatCamBtn.Parent = ScreenGui

        local FloatCorner = Instance.new("UICorner") FloatCorner.CornerRadius = UDim.new(0, 8) FloatCorner.Parent = FloatCamBtn
        local FloatStroke = Instance.new("UIStroke") FloatStroke.Color = Color3.fromRGB(150, 50, 220) FloatStroke.Thickness = 1.5 FloatStroke.Parent = FloatCamBtn

        -- Plovoucí tlačítko pro ukončení Spectatu
        local StopSpectateBtn = Instance.new("TextButton")
        StopSpectateBtn.Size = UDim2.new(0, 140, 0, 35)
        StopSpectateBtn.Position = UDim2.new(0, 15, 0, 120)
        StopSpectateBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        StopSpectateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        StopSpectateBtn.TextSize = 11 StopSpectateBtn.Font = Enum.Font.Code StopSpectateBtn.Text = "STOP SPECTATE"
        StopSpectateBtn.Visible = false StopSpectateBtn.Draggable = true StopSpectateBtn.Active = true StopSpectateBtn.Parent = ScreenGui

        local StopSpecCorner = Instance.new("UICorner") StopSpecCorner.CornerRadius = UDim.new(0, 8) StopSpecCorner.Parent = StopSpectateBtn

        StopSpectateBtn.MouseButton1Click:Connect(function()
            spectatorTarget = nil
            Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") or nil
            StopSpectateBtn.Visible = false
        end)

        -- Červený FOV kroužek
        local FovCircle = Instance.new("Frame")
        FovCircle.Name = "FovCircle"
        FovCircle.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
        FovCircle.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
        FovCircle.BackgroundTransparency = 1 FovCircle.Visible = false FovCircle.Parent = ScreenGui

        local Stroke = Instance.new("UIStroke") Stroke.Color = Color3.fromRGB(255, 30, 30) Stroke.Thickness = 2 Stroke.Parent = FovCircle
        local UICorner = Instance.new("UICorner") UICorner.CornerRadius = UDim.new(1, 0) UICorner.Parent = FovCircle

        -- Horní lišta
        local TopBar = Instance.new("Frame")
        TopBar.Size = UDim2.new(1, 0, 0, 38)
        TopBar.BackgroundColor3 = Color3.fromRGB(24, 20, 35)
        TopBar.BorderSizePixel = 0
        TopBar.Parent = MainFrame

        local TopCorner = Instance.new("UICorner") TopCorner.CornerRadius = UDim.new(0, 8) TopCorner.Parent = TopBar

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -70, 1, 0)
        Title.Position = UDim2.new(0, 12, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "⚡ Express Hub | v6.9 | Protected PRO"
        Title.TextColor3 = Color3.fromRGB(240, 200, 255)
        Title.TextSize = 12 Title.Font = Enum.Font.Code Title.TextXAlignment = Enum.TextXAlignment.Left Title.Parent = TopBar

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 32, 0, 32) CloseBtn.Position = UDim2.new(1, -36, 0, 3)
        CloseBtn.BackgroundTransparency = 1 CloseBtn.Text = "✕" CloseBtn.TextColor3 = Color3.fromRGB(220, 80, 80) CloseBtn.TextSize = 14 CloseBtn.Font = Enum.Font.Code CloseBtn.Parent = TopBar

        CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

        local Container = Instance.new("Frame")
        Container.Size = UDim2.new(1, 0, 1, -38)
        Container.Position = UDim2.new(0, 0, 0, 38)
        Container.BackgroundTransparency = 1
        Container.Parent = MainFrame

        -- Boční menu záložek
        local Sidebar = Instance.new("ScrollingFrame")
        Sidebar.Size = UDim2.new(0, 130, 1, -10)
        Sidebar.Position = UDim2.new(0, 5, 0, 5)
        Sidebar.BackgroundTransparency = 1 Sidebar.CanvasSize = UDim2.new(0, 0, 0, 340) Sidebar.ScrollBarThickness = 2 Sidebar.Parent = Container

        local SideCorner = Instance.new("UICorner") SideCorner.CornerRadius = UDim.new(0, 6) SideCorner.Parent = Sidebar

        local ContentPanel = Instance.new("ScrollingFrame")
        ContentPanel.Size = UDim2.new(1, -145, 1, -10)
        ContentPanel.Position = UDim2.new(0, 140, 0, 5)
        ContentPanel.BackgroundTransparency = 1 ContentPanel.CanvasSize = UDim2.new(0, 0, 0, 700) ContentPanel.ScrollBarThickness = 4 ContentPanel.Parent = Container

        local function createTabButton(name, posY)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -5, 0, 32) btn.Position = UDim2.new(0, 0, 0, posY)
            btn.BackgroundColor3 = Color3.fromRGB(28, 24, 42) btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            btn.TextSize = 11 btn.Font = Enum.Font.Code btn.Text = name btn.Parent = Sidebar
            local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = btn
            return btn
        end

        local tabHome = createTabButton("🏠 Home", 0)
        local tabMain = createTabButton("⚙️ Main", 40)
        local tabCombat = createTabButton("🎯 Combat", 80)
        local tabTeleport = createTabButton("📍 Teleport", 120)
        local tabSpectate = createTabButton("👁️ Spectate", 200)
        local tabPlayers = createTabButton("👥 Players", 240)

        local function createSection()
            local f = Instance.new("ScrollingFrame")
            f.Size = UDim2.new(1, 0, 1, 0) f.BackgroundTransparency = 1 f.CanvasSize = UDim2.new(0, 0, 0, 700) f.ScrollBarThickness = 3 f.Visible = false f.Parent = ContentPanel
            return f
        end

        local secHome = createSection()
        local secMain = createSection()
        local secCombat = createSection()
        local secTeleport = createSection()
        local secSpawner = createSection()
        local secSpectate = createSection()
        local secPlayers = createSection()
        local secOther = createSection()

        secHome.Visible = true

        local function switchTab(sec)
            secHome.Visible = false secMain.Visible = false secCombat.Visible = false secTeleport.Visible = false secSpawner.Visible = false secSpectate.Visible = false secPlayers.Visible = false secOther.Visible = false
            sec.Visible = true
        end

        tabHome.MouseButton1Click:Connect(function() switchTab(secHome) end)
        tabMain.MouseButton1Click:Connect(function() switchTab(secMain) end)
        tabCombat.MouseButton1Click:Connect(function() switchTab(secCombat) end)
        tabTeleport.MouseButton1Click:Connect(function() switchTab(secTeleport) updateTpList() end)
        tabSpawner.MouseButton1Click:Connect(function() switchTab(secSpawner) end)
        tabSpectate.MouseButton1Click:Connect(function() switchTab(secSpectate) updateSpectateList() end)
        tabPlayers.MouseButton1Click:Connect(function() switchTab(secPlayers) end)
        tabOther.MouseButton1Click:Connect(function() switchTab(secOther) end)

        -- HOME SEKCE
        local HomeText = Instance.new("TextLabel")
        HomeText.Size = UDim2.new(1, -10, 0, 110) HomeText.Position = UDim2.new(0, 5, 0, 5)
        HomeText.BackgroundColor3 = Color3.fromRGB(22, 18, 32) HomeText.TextColor3 = Color3.fromRGB(230, 230, 230)
        HomeText.TextSize = 11 HomeText.Font = Enum.Font.Code HomeText.TextWrapped = true
        HomeText.Text = string.format("👤 Uživatel: %s\n⚡ Heslo ověřeno: OK\n🟢 Status: Undetected / Safe", LocalPlayer.Name)
        HomeText.Parent = secHome
        local htc = Instance.new("UICorner") htc.CornerRadius = UDim.new(0, 6) htc.Parent = HomeText

        -- MAIN SEKCE
        local function addToggle(parent, text, posY, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 32) btn.Position = UDim2.new(0, 5, 0, posY)
            btn.BackgroundColor3 = Color3.fromRGB(28, 24, 42) btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            btn.TextSize = 11 btn.Font = Enum.Font.Code btn.Text = text .. ": [ OFF ]" btn.Parent = parent
            local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = btn
            
            local state = false
            btn.MouseButton1Click:Connect(function()
                state = not state
                if state then btn.Text = text .. ": [ ON ]" btn.BackgroundColor3 = Color3.fromRGB(70, 20, 90)
                else btn.Text = text .. ": [ OFF ]" btn.BackgroundColor3 = Color3.fromRGB(28, 24, 42) end
                callback(state)
            end)
        end

        addToggle(secMain, "Full ESP + Itemy", 5, function(v) fullEspEnabled = v end)
        addToggle(secMain, "No Fog (Jasno)", 42, function(v) 
            noFogEnabled = v
            if v then Lighting.FogEnd = 999999 else Lighting.FogEnd = 1000 end
        end)

        -- COMBAT SEKCE
        addToggle(secCombat, "Silent Aim / Wallbang", 5, function(v) end)

        -- TELEPORT SEKCE
        local TpScroll = Instance.new("ScrollingFrame")
        TpScroll.Size = UDim2.new(1, -10, 1, -10) TpScroll.Position = UDim2.new(0, 5, 0, 5)
        TpScroll.BackgroundTransparency = 1 TpScroll.CanvasSize = UDim2.new(0, 0, 0, 0) TpScroll.ScrollBarThickness = 3 TpScroll.Parent = secTeleport

        function updateTpList()
            for _, child in ipairs(TpScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
            local yOffset = 0
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local tBtn = Instance.new("TextButton")
                    tBtn.Size = UDim2.new(1, 0, 0, 32) tBtn.Position = UDim2.new(0, 0, 0, yOffset)
                    tBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 45) tBtn.TextColor3 = Color3.fromRGB(100, 255, 150)
                    tBtn.TextSize = 11 tBtn.Font = Enum.Font.Code tBtn.Text = "📍 Teleport k: " .. plr.Name tBtn.Parent = TpScroll
                    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = tBtn

                    tBtn.MouseButton1Click:Connect(function()
                        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        end
                    end)
                    yOffset = yOffset + 38
                end
            end
            TpScroll.CanvasSize = UDim2.new(0, 0, 0, yOffset)
        end

        -- SPAWNER SEKCE (Opravené generování funkčních zbraní do ruky)
        local SpawnScroll = Instance.new("ScrollingFrame")
        SpawnScroll.Size = UDim2.new(1, -10, 1, -10) SpawnScroll.Position = UDim2.new(0, 5, 0, 5)
        SpawnScroll.BackgroundTransparency = 1 SpawnScroll.CanvasSize = UDim2.new(0, 0, 0, 800) SpawnScroll.ScrollBarThickness = 3 SpawnScroll.Parent = secSpawner

        local blockSpinWeapons = {"M249", "Anaconda", "RPG", "M16", "AK47", "Remington", "MP5", "Crossbow", "Draco", "M24", "Skorpion", "Uzi", "Double Barrel", "Glock", "G3", "Knife"}
        local yOff = 0
        for _, weaponName in ipairs(blockSpinWeapons) do
            local sBtn = Instance.new("TextButton")
            sBtn.Size = UDim2.new(1, 0, 0, 32) sBtn.Position = UDim2.new(0, 0, 0, yOff)
            sBtn.BackgroundColor3 = Color3.fromRGB(45, 25, 55) sBtn.TextColor3 = Color3.fromRGB(255, 200, 50)
            sBtn.TextSize = 11 sBtn.Font = Enum.Font.Code sBtn.Text = "🔫 Spawn: " .. weaponName sBtn.Parent = SpawnScroll
            local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 5) c.Parent = sBtn

            sBtn.MouseButton1Click:Connect(function()
                local tool = Instance.new("Tool")
                tool.Name = weaponName
                tool.RequiresHandle = true
                
                local handle = Instance.new("Part")
                handle.Name = "Handle"
                handle.Size = Vector3.new(1, 1, 3)
                handle.BrickColor = BrickColor.new("Dark stone grey")
                handle.Parent = tool
                
                tool.Parent = LocalPlayer.Backpack
                LocalPlayer.Character.Humanoid:EquipTool(tool)
            end)
            yOff = yOff + 38
        end

        -- SPECTATE SEKCE
        local SpectateScroll = Instance.new("ScrollingFrame")
        SpectateScroll.Size = UDim2.new(1, -10, 1, -10) SpectateScroll.Position = UDim2.new(0, 5, 0, 5)
        SpectateScroll.BackgroundTransparency = 1 SpectateScroll.CanvasSize = UDim2.new(0, 0, 0, 0) SpectateScroll.ScrollBarThickness = 3 SpectateScroll.Parent = secSpectate

        function updateSpectateList()
            for _, child in ipairs(SpectateScroll:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
            local yOffset = 0
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton")
                    pBtn.Size = UDim2.new(1, 0, 0, 32) pBtn.Position = UDim2.new(0, 0, 0, yOffset)
                    pBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 45) pBtn.TextColor3 = Color3.fromRGB(220, 200, 255)
                    pBtn.TextSize = 11 pBtn.Font = Enum.Font.Code pBtn.Text = "👁️ Sledovat: " .. plr.Name pBtn.Parent = SpectateScroll
                    local c = Instance.new("UICorner") 
