-- XONE MEGA v3
-- LocalScript
-- StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Config = {
    Accent = Color3.fromRGB(145, 85, 255),
    Background = Color3.fromRGB(14, 15, 23),
    Transparency = 0.05,
    Speed = 16,
    Jump = 50,
    CameraFOV = 70,
    CircleFOV = 150,
    ShowCircle = true,
    AimTraining = false,
    ESP = false,
    Box = false,
    Skeleton = false,
    Names = true,
    Health = true,
    FullBright = false,
    Fog = false,
    Watermark = true
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "XONE_MEGA"
GUI.ResetOnSpawn = false
GUI.DisplayOrder = 100
GUI.Parent = Player:WaitForChild("PlayerGui")

-- WATERMARK

local Watermark = Instance.new("TextButton")
Watermark.Size = UDim2.fromOffset(115, 38)
Watermark.Position = UDim2.new(0, 12, 0, 90)
Watermark.BackgroundColor3 = Config.Accent
Watermark.Text = "XONE MEGA"
Watermark.TextColor3 = Color3.new(1,1,1)
Watermark.Font = Enum.Font.GothamBlack
Watermark.TextSize = 14
Watermark.Parent = GUI

Instance.new("UICorner", Watermark).CornerRadius =
    UDim.new(0, 9)

-- MAIN PANEL

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(340, 440)
Main.Position = UDim2.new(0.5, -170, 0.5, -220)
Main.BackgroundColor3 = Config.Background
Main.BackgroundTransparency = Config.Transparency
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 13)

local Border = Instance.new("UIStroke")
Border.Color = Config.Accent
Border.Thickness = 1.5
Border.Parent = Main

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, -60, 0, 48)
Header.Position = UDim2.fromOffset(15, 0)
Header.BackgroundTransparency = 1
Header.Text = "XONE MEGA"
Header.TextColor3 = Config.Accent
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 21
Header.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35, 35)
Close.Position = UDim2.new(1, -43, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(65, 35, 45)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 15
Close.Parent = Main

Instance.new("UICorner", Close).CornerRadius =
    UDim.new(0, 8)

-- SIDEBAR

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 105, 1, -60)
Sidebar.Position = UDim2.fromOffset(8, 52)
Sidebar.BackgroundColor3 = Color3.fromRGB(23, 24, 35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

Instance.new("UICorner", Sidebar).CornerRadius =
    UDim.new(0, 9)

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.Parent = Sidebar

-- CONTENT

local Content = Instance.new("ScrollingFrame")
Content.Position = UDim2.fromOffset(122, 57)
Content.Size = UDim2.new(1, -132, 1, -68)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.CanvasSize = UDim2.fromOffset(0, 1000)
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.Parent = Content

local Pages = {}
local CurrentPage = nil

local function NewPage(name)
    local page = Instance.new("Frame")
    page.Name = name
    page.Size = UDim2.new(1, -5, 0, 1000)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = Content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.Parent = page

    Pages[name] = page
    return page
end

local function SwitchPage(name)
    for n, page in pairs(Pages) do
        page.Visible = n == name
    end

    CurrentPage = name
end

local function Tab(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(38, 38, 53)
    button.Text = name
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 12
    button.Parent = Sidebar

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 7)

    button.Activated:Connect(function()
        SwitchPage(name)
    end)

    return button
end

local function Section(page, name)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -5, 0, 28)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Config.Accent
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Parent = page
end

local function Button(page, name, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(37, 38, 52)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = name
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12
    b.Parent = page

    Instance.new("UICorner", b).CornerRadius =
        UDim.new(0, 7)

    b.Activated:Connect(callback)
    return b
end

local function Toggle(page, name, key, callback)
    local b

    local function Update()
        b.Text = name .. ": " ..
            (Config[key] and "ON" or "OFF")
        b.BackgroundColor3 = Config[key]
            and Color3.fromRGB(70, 45, 120)
            or Color3.fromRGB(37, 38, 52)
    end

    b = Button(page, name, function()
        Config[key] = not Config[key]
        Update()
        if callback then callback(Config[key]) end
    end)

    Update()
    return b
end

-- CREATE PAGES

local Combat = NewPage("Combat")
local Visuals = NewPage("Visuals")
local PlayerPage = NewPage("Player")
local World = NewPage("World")
local Misc = NewPage("Misc")
local Settings = NewPage("Settings")

Tab("Combat")
Tab("Visuals")
Tab("Player")
Tab("World")
Tab("Misc")
Tab("Settings")

-- COMBAT

Section(Combat, "AIM / TRAINING")

Toggle(Combat, "Aim Training", "AimTraining")

Toggle(Combat, "FOV Circle", "ShowCircle")

Button(Combat, "FOV + 25", function()
    Config.CircleFOV = math.min(Config.CircleFOV + 25, 500)
end)

Button(Combat, "FOV - 25", function()
    Config.CircleFOV = math.max(Config.CircleFOV - 25, 25)
end)

Button(Combat, "Camera FOV +", function()
    Config.CameraFOV = math.min(Config.CameraFOV + 5, 120)
    Camera.FieldOfView = Config.CameraFOV
end)

Button(Combat, "Camera FOV -", function()
    Config.CameraFOV = math.max(Config.CameraFOV - 5, 40)
    Camera.FieldOfView = Config.CameraFOV
end)

-- VISUALS

Section(Visuals, "TRAINING TARGET VISUALS")

Toggle(Visuals, "ESP", "ESP")
Toggle(Visuals, "Box", "Box")
Toggle(Visuals, "Skeleton", "Skeleton")
Toggle(Visuals, "Names", "Names")
Toggle(Visuals, "Health", "Health")

-- PLAYER

Section(PlayerPage, "MOVEMENT")

Button(PlayerPage, "Speed +", function()
    Config.Speed = math.min(Config.Speed + 2, 100)
    local hum = Player.Character and
        Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = Config.Speed end
end)

Button(PlayerPage, "Speed -", function()
    Config.Speed = math.max(Config.Speed - 2, 0)
    local hum = Player.Character and
        Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = Config.Speed end
end)

Button(PlayerPage, "Normal Speed", function()
    Config.Speed = 16
    local hum = Player.Character and
        Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end)

Button(PlayerPage, "Jump +", function()
    Config.Jump = math.min(Config.Jump + 5, 150)
    local hum = Player.Character and
        Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = Config.Jump end
end)

Button(PlayerPage, "Normal Jump", function()
    Config.Jump = 50
    local hum = Player.Character and
        Player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = 50 end
end)

-- WORLD

Section(World, "ENVIRONMENT")

Toggle(World, "Full Bright", "FullBright", function(value)
    Lighting.Brightness = value and 3 or 1
    Lighting.Ambient = value
        and Color3.new(1,1,1)
        or Color3.fromRGB(100,100,100)
end)

Toggle(World, "Fog", "Fog", function(value)
    Lighting.FogEnd = value and 150 or 100000
end)

Button(World, "Day", function()
    Lighting.ClockTime = 14
end)

Button(World, "Night", function()
    Lighting.ClockTime = 0
end)

Button(World, "Morning", function()
    Lighting.ClockTime = 7
end)

-- MISC

Section(Misc, "INTERFACE")

Toggle(Misc, "Watermark", "Watermark", function(value)
    Watermark.Visible = value
end)

Button(Misc, "Hide Menu", function()
    Main.Visible = false
end)

Button(Misc, "Reset Interface", function()
    Main.Visible = true
    Main.BackgroundColor3 = Config.Background
    Main.BackgroundTransparency = Config.Transparency
end)

-- SETTINGS

Section(Settings, "COLORS")

Button(Settings, "Purple Theme", function()
    Config.Accent = Color3.fromRGB(145,85,255)
    Border.Color = Config.Accent
    Header.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
end)

Button(Settings, "Red Theme", function()
    Config.Accent = Color3.fromRGB(255,65,75)
    Border.Color = Config.Accent
    Header.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
end)

Button(Settings, "Blue Theme", function()
    Config.Accent = Color3.fromRGB(50,150,255)
    Border.Color = Config.Accent
    Header.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
end)

Button(Settings, "Dark Background", function()
    Config.Background = Color3.fromRGB(14,15,23)
    Main.BackgroundColor3 = Config.Background
end)

Button(Settings, "Purple Background", function()
    Config.Background = Color3.fromRGB(38,20,55)
    Main.BackgroundColor3 = Config.Background
end)

Button(Settings, "Transparency +", function()
    Config.Transparency = math.min(Config.Transparency + 0.1, 0.7)
    Main.BackgroundTransparency = Config.Transparency
end)

Button(Settings, "Transparency -", function()
    Config.Transparency = math.max(Config.Transparency - 0.1, 0)
    Main.BackgroundTransparency = Config.Transparency
end)

-- WATERMARK OPEN / CLOSE

Watermark.Activated:Connect(function()
    Main.Visible = not Main.Visible
end)

Close.Activated:Connect(function()
    Main.Visible = false
end)

-- DRAG MENU

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- FOV CIRCLE

local Circle = Instance.new("Frame")
Circle.AnchorPoint = Vector2.new(0.5,0.5)
Circle.BackgroundTransparency = 1
Circle.Parent = GUI

Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

local CircleBorder = Instance.new("UIStroke")
CircleBorder.Color = Config.Accent
CircleBorder.Thickness = 1.5
CircleBorder.Parent = Circle

-- TRAINING TARGET HIGHLIGHTS

local Highlights = {}

local function UpdateTargets()
    for _, target in ipairs(
        CollectionService:GetTagged("TrainingTarget")
    ) do
        if target:IsA("Model") then
            local highlight = Highlights[target]

            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.FillColor = Config.Accent
                highlight.OutlineColor = Color3.new(1,1,1)
                highlight.Parent = target
                Highlights[target] = highlight
            end

            highlight.Enabled = Config.ESP
                or Config.Box
                or Config.Skeleton
        end
    end

    for target, highlight in pairs(Highlights) do
        if not target.Parent then
            highlight:Destroy()
            Highlights[target] = nil
        end
    end
end

-- RENDER

RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera

    local center = Camera.ViewportSize / 2

    Circle.Position = UDim2.fromOffset(center.X, center.Y)
    Circle.Size = UDim2.fromOffset(
        Config.CircleFOV * 2,
        Config.CircleFOV * 2
    )

    Circle.Visible = Config.ShowCircle

    CircleBorder.Color = Config.Accent

    for target, highlight in pairs(Highlights) do
        highlight.FillColor = Config.Accent
        highlight.Enabled = Config.ESP
    end

    UpdateTargets()
end)

SwitchPage("Combat")

print("XONE MEGA v3 LOADED")
