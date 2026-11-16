-- XONE MEGA v4
-- LocalScript
-- StarterPlayer > StarterPlayerScripts
-- Training targets must have CollectionService tag "TrainingTarget"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Config = {
    Accent = Color3.fromRGB(145,85,255),
    Background = Color3.fromRGB(14,15,23),

    Aim = false,
    ESP = true,
    Box = true,
    Names = true,
    Health = true,
    Skeleton = false,
    ShowCircle = true,

    FOV = 150,
    AimSmooth = 0.18
}

local GUI = Instance.new("ScreenGui")
GUI.Name = "XONE_MEGA_V4"
GUI.ResetOnSpawn = false
GUI.DisplayOrder = 100
GUI.Parent = Player:WaitForChild("PlayerGui")

-- WATERMARK

local Watermark = Instance.new("TextButton")
Watermark.Size = UDim2.fromOffset(125,38)
Watermark.Position = UDim2.new(0,12,0,90)
Watermark.BackgroundColor3 = Config.Accent
Watermark.Text = "XONE MEGA"
Watermark.TextColor3 = Color3.new(1,1,1)
Watermark.Font = Enum.Font.GothamBlack
Watermark.TextSize = 14
Watermark.Parent = GUI

Instance.new("UICorner",Watermark).CornerRadius = UDim.new(0,9)

-- MAIN WINDOW

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(330,440)
Main.Position = UDim2.new(0.5,-165,0.5,-220)
Main.BackgroundColor3 = Config.Background
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Border = Instance.new("UIStroke")
Border.Color = Config.Accent
Border.Thickness = 1.5
Border.Parent = Main

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1,-50,0,45)
Header.Position = UDim2.fromOffset(12,0)
Header.BackgroundTransparency = 1
Header.Text = "XONE MEGA v4"
Header.TextColor3 = Config.Accent
Header.Font = Enum.Font.GothamBlack
Header.TextSize = 19
Header.TextXAlignment = Enum.TextXAlignment.Left
Header.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(32,32)
Close.Position = UDim2.new(1,-40,0,7)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(80,35,45)
Close.Font = Enum.Font.GothamBold
Close.Parent = Main

Instance.new("UICorner",Close).CornerRadius = UDim.new(0,7)

local Content = Instance.new("ScrollingFrame")
Content.Position = UDim2.fromOffset(10,52)
Content.Size = UDim2.new(1,-20,1,-62)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.CanvasSize = UDim2.fromOffset(0,700)
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,7)
Layout.Parent = Content

local function Section(name)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-5,0,27)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Config.Accent
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = Content
end

local function Button(name,callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,-5,0,37)
    b.BackgroundColor3 = Color3.fromRGB(37,38,52)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamSemibold
    b.TextSize = 12
    b.Text = name
    b.Parent = Content

    Instance.new("UICorner",b).CornerRadius = UDim.new(0,7)
    b.Activated:Connect(callback)
    return b
end

local function Toggle(name,key)
    local b

    local function Update()
        b.Text = name .. ": " .. (Config[key] and "ON" or "OFF")
        b.BackgroundColor3 = Config[key]
            and Color3.fromRGB(75,45,125)
            or Color3.fromRGB(37,38,52)
    end

    b = Button("",function()
        Config[key] = not Config[key]
        Update()
    end)

    Update()
    return b
end

-- AIM

Section("COMBAT")

Toggle("Aim Assist","Aim")
Toggle("FOV Circle","ShowCircle")

Button("FOV + 25",function()
    Config.FOV = math.min(Config.FOV + 25,500)
end)

Button("FOV - 25",function()
    Config.FOV = math.max(Config.FOV - 25,25)
end)

Button("Aim Smooth +",function()
    Config.AimSmooth = math.min(Config.AimSmooth + 0.05,1)
end)

Button("Aim Smooth -",function()
    Config.AimSmooth = math.max(Config.AimSmooth - 0.05,0.05)
end)

-- VISUALS

Section("VISUALS")

Toggle("ESP Highlight","ESP")
Toggle("ESP Box","Box")
Toggle("ESP Names","Names")
Toggle("ESP Health","Health")
Toggle("ESP Skeleton","Skeleton")

-- SETTINGS

Section("SETTINGS")

Button("Purple Theme",function()
    Config.Accent = Color3.fromRGB(145,85,255)
    Border.Color = Config.Accent
    Header.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
end)

Button("Red Theme",function()
    Config.Accent = Color3.fromRGB(255,65,75)
    Border.Color = Config.Accent
    Header.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
end)

Button("Blue Theme",function()
    Config.Accent = Color3.fromRGB(50,150,255)
    Border.Color = Config.Accent
    Header.TextColor3 = Config.Accent
    Watermark.BackgroundColor3 = Config.Accent
end)

Button("Reset FOV",function()
    Config.FOV = 150
end)

Watermark.Activated:Connect(function()
    Main.Visible = not Main.Visible
end)

Close.Activated:Connect(function()
    Main.Visible = false
end)

-- FOV CIRCLE

local Circle = Instance.new("Frame")
Circle.AnchorPoint = Vector2.new(0.5,0.5)
Circle.BackgroundTransparency = 1
Circle.Parent = GUI

Instance.new("UICorner",Circle).CornerRadius = UDim.new(1,0)

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Config.Accent
CircleStroke.Thickness = 1.5
CircleStroke.Parent = Circle

-- TARGET ESP

local TargetObjects = {}

local Connections = {
    {"UpperTorso","LowerTorso"},
    {"UpperTorso","Head"},
    {"UpperTorso","LeftUpperArm"},
    {"LeftUpperArm","LeftLowerArm"},
    {"UpperTorso","RightUpperArm"},
    {"RightUpperArm","RightLowerArm"},
    {"LowerTorso","LeftUpperLeg"},
    {"LeftUpperLeg","LeftLowerLeg"},
    {"LowerTorso","RightUpperLeg"},
    {"RightUpperLeg","RightLowerLeg"}
}

local function CreateTarget(model)
    if TargetObjects[model] then return end

    local root = model:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local data = {}

    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Adornee = model
    highlight.FillColor = Config.Accent
    highlight.OutlineColor = Color3.new(1,1,1)
    highlight.FillTransparency = 0.75
    highlight.Enabled = false
    highlight.Parent = GUI
    data.Highlight = highlight

    -- Billboard ESP
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "XONE_ESP"
    billboard.Adornee = root
    billboard.Size = UDim2.fromOffset(100,120)
    billboard.StudsOffset = Vector3.new(0,3.5,0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = false
    billboard.Parent = GUI

    local box = Instance.new("Frame")
    box.Size = UDim2.fromScale(1,1)
    box.BackgroundTransparency = 1
    box.Parent = billboard

    local stroke = Instance.new("UIStroke")
    stroke.Color = Config.Accent
    stroke.Thickness = 1.5
    stroke.Parent = box

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1,0,0,20)
    nameLabel.Position = UDim2.new(0,0,0,-22)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.new(1,1,1)
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 12
    nameLabel.Parent = box

    local healthBack = Instance.new("Frame")
    healthBack.Size = UDim2.new(1,0,0,5)
    healthBack.Position = UDim2.new(0,0,1,3)
    healthBack.BackgroundColor3 = Color3.fromRGB(50,50,50)
    healthBack.BorderSizePixel = 0
    healthBack.Parent = box

    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.fromScale(1,1)
    healthFill.BackgroundColor3 = Color3.fromRGB(50,220,90)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBack

    data.Billboard = billboard
    data.Box = box
    data.Stroke = stroke
    data.NameLabel = nameLabel
    data.HealthBack = healthBack
    data.HealthFill = healthFill
    data.Beams = {}

    -- Skeleton beams for R15 rigs
    local attachments = {}

    for _,edge in ipairs(Connections) do
        local part0 = model:FindFirstChild(edge[1])
        local part1 = model:FindFirstChild(edge[2])

        if part0 and part1 and part0:IsA("BasePart")
            and part1:IsA("BasePart") then

            local a0 = Instance.new("Attachment")
            a0.Parent = part0

            local a1 = Instance.new("Attachment")
            a1.Parent = part1

            local beam = Instance.new("Beam")
            beam.Attachment0 = a0
            beam.Attachment1 = a1
            beam.Width0 = 0.045
            beam.Width1 = 0.045
            beam.FaceCamera = true
            beam.Color = ColorSequence.new(Config.Accent)
            beam.Enabled = false
            beam.Parent = model

            table.insert(data.Beams,{Beam=beam,A0=a0,A1=a1})
        end
    end

    TargetObjects[model] = data
end

local function RemoveTarget(model)
    local data = TargetObjects[model]
    if not data then return end

    data.Highlight:Destroy()
    data.Billboard:Destroy()

    for _,item in ipairs(data.Beams) do
        item.Beam:Destroy()
        item.A0:Destroy()
        item.A1:Destroy()
    end

    TargetObjects[model] = nil
end

-- AIM TARGET SELECTION

local function IsVisible(target,part)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {Player.Character}

    local direction = part.Position - Camera.CFrame.Position
    local result = workspace:Raycast(
        Camera.CFrame.Position,
        direction,
        params
    )

    return result == nil or result.Instance:IsDescendantOf(target)
end

local function GetBestTarget()
    local center = Camera.ViewportSize / 2
    local bestTarget = nil
    local bestDistance = Config.FOV

    for _,model in ipairs(CollectionService:GetTagged("TrainingTarget")) do
        if model:IsA("Model") and model ~= Player.Character then
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            local head = model:FindFirstChild("Head")

            if humanoid and humanoid.Health > 0 and head then
                local screen,visible = Camera:WorldToViewportPoint(head.Position)

                if visible and screen.Z > 0 then
                    local distance = (
                        Vector2.new(screen.X,screen.Y) - center
                    ).Magnitude

                    if distance < bestDistance and IsVisible(model,head) then
                        bestDistance = distance
                        bestTarget = head
                    end
                end
            end
        end
    end

    return bestTarget
end

-- UPDATE

RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera

    local center = Camera.ViewportSize / 2

    Circle.Position = UDim2.fromOffset(center.X,center.Y)
    Circle.Size = UDim2.fromOffset(Config.FOV*2,Config.FOV*2)
    Circle.Visible = Config.ShowCircle
    CircleStroke.Color = Config.Accent

    -- Refresh target list
    for _,model in ipairs(CollectionService:GetTagged("TrainingTarget")) do
        if model:IsA("Model") then
            CreateTarget(model)
        end
    end

    for model,data in pairs(TargetObjects) do
        if not model.Parent or not CollectionService:HasTag(model,"TrainingTarget") then
            RemoveTarget(model)
        else
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            local root = model:FindFirstChild("HumanoidRootPart")

            local alive = humanoid and humanoid.Health > 0 and root

            data.Highlight.Enabled = alive and Config.ESP
            data.Billboard.Enabled = alive and (
                Config.Box or Config.Names or Config.Health
            )

            data.Stroke.Enabled = Config.Box
            data.NameLabel.Visible = Config.Names
            data.NameLabel.Text = model.Name
            data.HealthBack.Visible = Config.Health

            if humanoid then
                local percent = math.clamp(
                    humanoid.Health / math.max(humanoid.MaxHealth,1),
                    0,1
                )
                data.HealthFill.Size = UDim2.fromScale(percent,1)
            end

            data.Highlight.FillColor = Config.Accent
            data.Stroke.Color = Config.Accent

            for _,item in ipairs(data.Beams) do
                item.Beam.Enabled = alive and Config.Skeleton
                item.Beam.Color = ColorSequence.new(Config.Accent)
            end
        end
    end

    -- Aim Assist for tagged training targets only
    if Config.Aim then
        local target = GetBestTarget()

        if target then
            local desired = CFrame.lookAt(
                Camera.CFrame.Position,
                target.Position
            )

            Camera.CFrame = Camera.CFrame:Lerp(
                desired,
                Config.AimSmooth
            )
        end
    end
end)

-- Cleanup
Players.PlayerRemoving:Connect(function()
    for model in pairs(TargetObjects) do
        RemoveTarget(model)
    end
end)

print("XONE MEGA v4 LOADED")
