-- XONE MEGA v5
-- LocalScript
-- StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local GUI = Instance.new("ScreenGui")
GUI.Name = "XONE_MEGA_V5"
GUI.ResetOnSpawn = false
GUI.Parent = Player:WaitForChild("PlayerGui")

local Config = {
    Accent = Color3.fromRGB(145,85,255),
    FOV = 150,
    Circle = true,
    Crosshair = true,
    CrosshairSize = 8,
    Sensitivity = 1,
    Transparency = 0.05
}

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,radius)
    c.Parent = obj
end

local Watermark = Instance.new("TextButton")
Watermark.Size = UDim2.fromOffset(125,38)
Watermark.Position = UDim2.new(0,12,0,90)
Watermark.BackgroundColor3 = Config.Accent
Watermark.Text = "XONE MEGA"
Watermark.TextColor3 = Color3.new(1,1,1)
Watermark.Font = Enum.Font.GothamBlack
Watermark.TextSize = 14
Watermark.Parent = GUI
corner(Watermark,9)

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(320,430)
Main.Position = UDim2.new(.5,-160,.5,-215)
Main.BackgroundColor3 = Color3.fromRGB(15,16,25)
Main.BackgroundTransparency = Config.Transparency
Main.Visible = false
Main.Parent = GUI
corner(Main,13)

local border = Instance.new("UIStroke")
border.Color = Config.Accent
border.Thickness = 1.5
border.Parent = Main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-50,0,45)
title.Position = UDim2.fromOffset(12,0)
title.BackgroundTransparency = 1
title.Text = "XONE MEGA v5"
title.TextColor3 = Config.Accent
title.Font = Enum.Font.GothamBlack
title.TextSize = 19
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = Main

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(32,32)
close.Position = UDim2.new(1,-40,0,7)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(90,35,45)
close.Parent = Main
corner(close,7)

local content = Instance.new("ScrollingFrame")
content.Position = UDim2.fromOffset(10,52)
content.Size = UDim2.new(1,-20,1,-62)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.CanvasSize = UDim2.fromOffset(0,600)
content.Parent = Main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,8)
layout.Parent = content

local function button(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-5,0,38)
    b.BackgroundColor3 = Color3.fromRGB(37,38,52)
    b.TextColor3 = Color3.new(1,1,1)
    b.Text = text
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12
    b.Parent = content
    corner(b,7)
    b.Activated:Connect(callback)
    return b
end

local function section(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-5,0,27)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Config.Accent
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
end

local function toggle(text,key)
    local b
    local function update()
        b.Text = text .. ": " .. (Config[key] and "ON" or "OFF")
        b.BackgroundColor3 = Config[key]
            and Color3.fromRGB(75,45,125)
            or Color3.fromRGB(37,38,52)
    end
    b = button("",function()
        Config[key] = not Config[key]
        update()
    end)
    update()
end

-- CROSSHAIR

local Cross = Instance.new("Frame")
Cross.AnchorPoint = Vector2.new(.5,.5)
Cross.BackgroundTransparency = 1
Cross.Size = UDim2.fromOffset(30,30)
Cross.Parent = GUI

local function makeLine(size)
    local line = Instance.new("Frame")
    line.AnchorPoint = Vector2.new(.5,.5)
    line.BackgroundColor3 = Config.Accent
    line.BorderSizePixel = 0
    line.Parent = Cross
    return line
end

local horizontal = makeLine()
horizontal.Size = UDim2.new(0,20,0,2)

local vertical = makeLine()
vertical.Size = UDim2.new(0,2,0,20)

-- FOV CIRCLE

local Circle = Instance.new("Frame")
Circle.AnchorPoint = Vector2.new(.5,.5)
Circle.BackgroundTransparency = 1
Circle.Parent = GUI
corner(Circle,100)

local circleStroke = Instance.new("UIStroke")
circleStroke.Color = Config.Accent
circleStroke.Thickness = 1.5
circleStroke.Parent = Circle

-- CONTROLS

section("ПРИЦЕЛ")
toggle("Показывать прицел","Crosshair")
toggle("Показывать FOV","Circle")

button("Размер прицела +",function()
    Config.CrosshairSize = math.min(20,Config.CrosshairSize+2)
end)

button("Размер прицела -",function()
    Config.CrosshairSize = math.max(2,Config.CrosshairSize-2)
end)

section("FOV")

button("Радиус +25",function()
    Config.FOV = math.min(500,Config.FOV+25)
end)

button("Радиус -25",function()
    Config.FOV = math.max(25,Config.FOV-25)
end)

section("ЧУВСТВИТЕЛЬНОСТЬ")

button("Чувствительность +",function()
    Config.Sensitivity = math.min(5,Config.Sensitivity+.1)
end)

button("Чувствительность -",function()
    Config.Sensitivity = math.max(.1,Config.Sensitivity-.1)
end)

section("ТЕМА")

button("Фиолетовая",function()
    Config.Accent = Color3.fromRGB(145,85,255)
end)

button("Красная",function()
    Config.Accent = Color3.fromRGB(255,65,75)
end)

button("Синяя",function()
    Config.Accent = Color3.fromRGB(50,150,255)
end)

button("Сбросить настройки",function()
    Config.FOV = 150
    Config.CrosshairSize = 8
    Config.Sensitivity = 1
    Config.Circle = true
    Config.Crosshair = true
end)

Watermark.Activated:Connect(function()
    Main.Visible = not Main.Visible
end)

close.Activated:Connect(function()
    Main.Visible = false
end)

RunService.RenderStepped:Connect(function()
    local camera = workspace.CurrentCamera
    if not camera then return end

    local center = camera.ViewportSize/2

    Cross.Position = UDim2.fromOffset(center.X,center.Y)
    horizontal.Size = UDim2.fromOffset(Config.CrosshairSize*2,2)
    vertical.Size = UDim2.fromOffset(2,Config.CrosshairSize*2)

    Cross.Visible = Config.Crosshair

    Circle.Position = UDim2.fromOffset(center.X,center.Y)
    Circle.Size = UDim2.fromOffset(Config.FOV*2,Config.FOV*2)
    Circle.Visible = Config.Circle

    border.Color = Config.Accent
    title.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
    circleStroke.Color = Config.Accent
    horizontal.BackgroundColor3 = Config.Accent
    vertical.BackgroundColor3 = Config.Accent
end)

print("XONE MEGA v5 LOADED")
