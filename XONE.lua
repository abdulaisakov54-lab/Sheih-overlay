-- XONE MOBILE
-- ESP + AIM ASSIST
-- Для собственного проекта Roblox Studio

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Settings = {
    ESP = false,
    Names = true,
    Health = true,
    Aim = false,
    FOV = 150,
    Smooth = 0.15
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "XONE"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(260, 320)
Main.Position = UDim2.new(0.5, -130, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 12)

local function Button(text, y, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 38)
    b.Position = UDim2.fromOffset(10, y)
    b.BackgroundColor3 = Color3.fromRGB(38, 35, 55)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.Text = text
    b.Parent = Main

    Instance.new("UICorner", b).CornerRadius =
        UDim.new(0, 7)

    b.MouseButton1Click:Connect(callback)
    return b
end

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "XONE MOBILE"
Title.TextColor3 = Color3.fromRGB(160, 110, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 21
Title.Parent = Main

local esp = Button("ESP: OFF", 55, function()
    Settings.ESP = not Settings.ESP
    esp.Text = "ESP: " .. (Settings.ESP and "ON" or "OFF")
end)

local names = Button("Имена: ON", 100, function()
    Settings.Names = not Settings.Names
    names.Text = "Имена: " .. (Settings.Names and "ON" or "OFF")
end)

local health = Button("Здоровье: ON", 145, function()
    Settings.Health = not Settings.Health
    health.Text = "Здоровье: " .. (Settings.Health and "ON" or "OFF")
end)

local aim = Button("AIM ASSIST: OFF", 190, function()
    Settings.Aim = not Settings.Aim
    aim.Text = "AIM ASSIST: " ..
        (Settings.Aim and "ON" or "OFF")
end)

local fov = Button("FOV: 150", 235, function()
    Settings.FOV = Settings.FOV == 150 and 250 or 150
    fov.Text = "FOV: " .. Settings.FOV
end)

-- ESP
local Objects = {}

local function RemoveESP(plr)
    if Objects[plr] then
        Objects[plr]:Destroy()
        Objects[plr] = nil
    end
end

local function CreateESP(plr)
    if plr == Player then return end

    local char = plr.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")

    if not root or not hum then return end

    if not Objects[plr] then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = Color3.fromRGB(130, 70, 255)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = char

        Objects[plr] = highlight
    end

    Objects[plr].Enabled = Settings.ESP

    local billboard = root:FindFirstChild("XONE_INFO")

    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "XONE_INFO"
        billboard.Size = UDim2.fromOffset(150, 40)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = root

        local label = Instance.new("TextLabel")
        label.Name = "Info"
        label.Size = UDim2.fromScale(1, 1)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 1, 1)
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = 13
        label.Parent = billboard
    end

    local label = billboard.Info
    label.Visible = Settings.ESP and
        (Settings.Names or Settings.Health)

    local info = {}

    if Settings.Names then
        table.insert(info, plr.DisplayName)
    end

    if Settings.Health then
        table.insert(info, "HP: " .. math.floor(hum.Health))
    end

    label.Text = table.concat(info, " | ")
end

-- Выбор ближайшего игрока на экране
local function GetTarget()
    local center = Camera.ViewportSize / 2
    local best = nil
    local distance = Settings.FOV

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player then
            local char = plr.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")

            if hum and root and hum.Health > 0 then
                local pos, visible =
                    Camera:WorldToViewportPoint(root.Position)

                if visible and pos.Z > 0 then
                    local d = (
                        Vector2.new(pos.X, pos.Y) - center
                    ).Magnitude

                    if d < distance then
                        distance = d
                        best = root
                    end
                end
            end
        end
    end

    return best
end

-- Обновление
RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera

    for _, plr in ipairs(Players:GetPlayers()) do
        CreateESP(plr)
    end

    if Settings.Aim then
        local target = GetTarget()

        if target then
            local destination = CFrame.lookAt(
                Camera.CFrame.Position,
                target.Position
            )

            Camera.CFrame = Camera.CFrame:Lerp(
                destination,
                Settings.Smooth
            )
        end
    end
end)

Players.PlayerRemoving:Connect(RemoveESP)

print("XONE MOBILE loaded!")
