-- XONE MOBILE v2
-- LocalScript
-- Для собственного Roblox Studio проекта

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Player = Players.LocalPlayer

local S = {
    Aim = false,
    Silent = false,
    ESP = false,
    Box = false,
    Skeleton = false,
    Names = true,
    Health = true,
    FOV = 150,
    Smooth = 0.18,
    AimPart = "Head",
    Background = Color3.fromRGB(15, 15, 23),
    Transparency = 0.05,
    FOVColor = Color3.fromRGB(150, 80, 255),
    CircleVisible = true
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "XONE_MOBILE"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

-- WATERMARK
local Watermark = Instance.new("TextButton")
Watermark.Size = UDim2.fromOffset(105, 35)
Watermark.Position = UDim2.new(0, 12, 0, 80)
Watermark.BackgroundColor3 = Color3.fromRGB(110, 65, 240)
Watermark.Text = "XONE"
Watermark.TextColor3 = Color3.new(1,1,1)
Watermark.Font = Enum.Font.GothamBlack
Watermark.TextSize = 17
Watermark.Parent = GUI
Instance.new("UICorner", Watermark).CornerRadius = UDim.new(0, 9)

-- MAIN MENU
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(280, 440)
Main.Position = UDim2.new(0.5, -140, 0.5, -220)
Main.BackgroundColor3 = S.Background
Main.BackgroundTransparency = S.Transparency
Main.BorderSizePixel = 0
Main.Visible = true
Main.Parent = GUI
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke")
Stroke.Color = S.FOVColor
Stroke.Thickness = 1.5
Stroke.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "XONE MOBILE  /  V2"
Title.TextColor3 = S.FOVColor
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.Parent = Main

local Container = Instance.new("ScrollingFrame")
Container.Position = UDim2.fromOffset(10, 50)
Container.Size = UDim2.new(1, -20, 1, -60)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 3
Container.CanvasSize = UDim2.fromOffset(0, 700)
Container.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 7)
Layout.Parent = Container

local function Button(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(38, 38, 53)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 13
    b.Parent = Container
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function Toggle(name, key)
    local b
    b = Button(name .. ": OFF", function()
        S[key] = not S[key]
        b.Text = name .. ": " .. (S[key] and "ON" or "OFF")
    end)
    return b
end

local function Change(name, callback)
    return Button(name, callback)
end

-- AIM
Toggle("AIMBOT", "Aim")
Toggle("SILENT AIM", "Silent")

Change("FOV: +25", function()
    S.FOV = math.min(S.FOV + 25, 500)
end)

Change("FOV: -25", function()
    S.FOV = math.max(S.FOV - 25, 25)
end)

Change("SMOOTH AIM: +", function()
    S.Smooth = math.min(S.Smooth + 0.05, 1)
end)

Change("SMOOTH AIM: -", function()
    S.Smooth = math.max(S.Smooth - 0.05, 0.05)
end)

Change("TARGET PART: HEAD / TORSO", function()
    S.AimPart = S.AimPart == "Head" and "HumanoidRootPart" or "Head"
end)

-- ESP
Toggle("ESP", "ESP")
Toggle("ESP BOX", "Box")
Toggle("ESP SKELETON", "Skeleton")
Toggle("ESP NAMES", "Names")
Toggle("ESP HEALTH", "Health")

-- APPEARANCE
Change("FOV COLOR: PURPLE", function()
    S.FOVColor = Color3.fromRGB(150, 80, 255)
    CircleStroke.Color = S.FOVColor
    Stroke.Color = S.FOVColor
end)

Change("FOV COLOR: RED", function()
    S.FOVColor = Color3.fromRGB(255, 65, 75)
    CircleStroke.Color = S.FOVColor
    Stroke.Color = S.FOVColor
end)

Change("BACKGROUND: DARK", function()
    S.Background = Color3.fromRGB(15, 15, 23)
    Main.BackgroundColor3 = S.Background
end)

Change("BACKGROUND: BLUE", function()
    S.Background = Color3.fromRGB(15, 35, 65)
    Main.BackgroundColor3 = S.Background
end)

Change("BACKGROUND: PURPLE", function()
    S.Background = Color3.fromRGB(45, 20, 65)
    Main.BackgroundColor3 = S.Background
end)

Change("BACKGROUND TRANSPARENCY", function()
    S.Transparency = S.Transparency == 0.05 and 0.35 or
        (S.Transparency == 0.35 and 0.65 or 0.05)
    Main.BackgroundTransparency = S.Transparency
end)

-- FOV CIRCLE
local Circle = Instance.new("Frame")
Circle.Name = "FOV_CIRCLE"
Circle.AnchorPoint = Vector2.new(0.5, 0.5)
Circle.Size = UDim2.fromOffset(S.FOV * 2, S.FOV * 2)
Circle.BackgroundTransparency = 1
Circle.Parent = GUI

Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = S.FOVColor
CircleStroke.Thickness = 1.5
CircleStroke.Parent = Circle

-- WATERMARK OPEN / CLOSE
Watermark.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- SILENT AIM TARGET API
-- Weapon LocalScript can call this BindableFunction.
local AimAPI = Instance.new("BindableFunction")
AimAPI.Name = "XONE_GetAimTarget"
AimAPI.Parent = GUI

local CurrentTarget = nil

local function GetTarget()
    local center = Camera.ViewportSize / 2
    local nearest = nil
    local nearestDistance = S.FOV

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player then
            local char = plr.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local part = char and char:FindFirstChild(S.AimPart)

            if hum and part and hum.Health > 0 then
                local pos, visible = Camera:WorldToViewportPoint(part.Position)

                if visible and pos.Z > 0 then
                    local distance = (
                        Vector2.new(pos.X, pos.Y) - center
                    ).Magnitude

                    if distance < nearestDistance then
                        nearestDistance = distance
                        nearest = part
                    end
                end
            end
        end
    end

    return nearest
end

AimAPI.OnInvoke = function()
    if not S.Silent then return nil end
    return CurrentTarget and CurrentTarget.Position
end

-- ESP OBJECTS
local ESPObjects = {}

local function CreateLine(parent)
    local line = Instance.new("Frame")
    line.BorderSizePixel = 0
    line.BackgroundColor3 = Color3.fromRGB(160, 110, 255)
    line.AnchorPoint = Vector2.new(0.5, 0.5)
    line.Parent = parent
    return line
end

local function DrawLine(line, a, b)
    local delta = b - a
    line.Position = UDim2.fromOffset(
        (a.X + b.X) / 2,
        (a.Y + b.Y) / 2
    )
    line.Size = UDim2.fromOffset(2, delta.Magnitude)
    line.Rotation = math.deg(math.atan2(delta.Y, delta.X)) + 90
end

local function CreateESP(plr)
    if plr == Player then return end

    local data = ESPObjects[plr]

    if not data then
        local folder = Instance.new("Folder")
        folder.Name = "ESP_" .. plr.Name
        folder.Parent = GUI

        local box = Instance.new("Frame")
        box.BackgroundTransparency = 1
        box.BorderSizePixel = 0
        box.Parent = folder

        local boxStroke = Instance.new("UIStroke")
        boxStroke.Color = Color3.fromRGB(160, 110, 255)
        boxStroke.Thickness = 1.5
        boxStroke.Parent = box

        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromOffset(180, 22)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1,1,1)
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = 12
        label.Parent = folder

        local lines = {}
        for i = 1, 15 do
            lines[i] = CreateLine(folder)
        end

        data = {
            Folder = folder,
            Box = box,
            Label = label,
            Lines = lines
        }

        ESPObjects[plr] = data
    end

    return data
end

local Bones = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
    {"RightLowerLeg", "RightFoot"}
}

local function UpdateESP(plr)
    local data = CreateESP(plr)
    if not data then return end

    local char = plr.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local head = char and char:FindFirstChild("Head")

    if not S.ESP or not char or not hum or not root or
        hum.Health <= 0 then
        data.Folder.Visible = false
        return
    end

    data.Folder.Visible = true

    local top = head and Camera:WorldToViewportPoint(
        head.Position + Vector3.new(0, 0.5, 0)
    )

    local bottom = Camera:WorldToViewportPoint(
        root.Position - Vector3.new(0, 3, 0)
    )

    if not top or top.Z <= 0 or bottom.Z <= 0 then
        data.Folder.Visible = false
        return
    end

    local height = math.abs(bottom.Y - top.Y)
    local width = height * 0.48

    data.Box.Visible = S.Box
    data.Box.Position = UDim2.fromOffset(
        top.X - width / 2, top.Y
    )
    data.Box.Size = UDim2.fromOffset(width, height)

    data.Label.Visible = S.Names or S.Health

    local info = {}
    if S.Names then table.insert(info, plr.DisplayName) end
    if S.Health then
        table.insert(info, "HP " .. math.floor(hum.Health))
    end

    data.Label.Text = table.concat(info, " | ")
    data.Label.Position = UDim2.fromOffset(
        top.X - 90, top.Y - 23
    )

    for i, bone in ipairs(Bones) do
        local a = char:FindFirstChild(bone[1])
        local b = char:FindFirstChild(bone[2])
        local line = data.Lines[i]

        line.Visible = S.Skeleton and a ~= nil and b ~= nil

        if line.Visible then
            local pa = Camera:WorldToViewportPoint(a.Position)
            local pb = Camera:WorldToViewportPoint(b.Position)

            if pa.Z > 0 and pb.Z > 0 then
                DrawLine(
                    line,
                    Vector2.new(pa.X, pa.Y),
                    Vector2.new(pb.X, pb.Y)
                )
            else
                line.Visible = false
            end
        end
    end
end

Players.PlayerRemoving:Connect(function(plr)
    if ESPObjects[plr] then
        ESPObjects[plr].Folder:Destroy()
        ESPObjects[plr] = nil
    end
end)

-- MAIN UPDATE
RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera

    local center = Camera.ViewportSize / 2

    Circle.Position = UDim2.fromOffset(center.X, center.Y)
    Circle.Size = UDim2.fromOffset(S.FOV * 2, S.FOV * 2)
    Circle.Visible = S.CircleVisible and (S.Aim or S.Silent)

    CurrentTarget = GetTarget()

    if S.Aim and CurrentTarget then
        local destination = CFrame.lookAt(
            Camera.CFrame.Position,
            CurrentTarget.Position
        )

        Camera.CFrame = Camera.CFrame:Lerp(
            destination,
            S.Smooth
        )
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        UpdateESP(plr)
    end
end)

print("XONE MOBILE V2 LOADED")
