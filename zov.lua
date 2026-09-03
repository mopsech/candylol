-- Violence District Mobile GUI | Полная версия
-- Оптимизировано для мобильных устройств

-- Загрузка необходимых сервисов
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Глобальная таблица настроек
_G.Settings = _G.Settings or {
    ESP = {
        Master = false,
        Players = {
            Killers = { Enabled = true, Aura = true, Distance = true, Name = true },
            Survivors = { Enabled = true, Aura = true, Health = true, Hooks = true, Name = true }
        },
        Objects = {
            Generators = { Enabled = true, Progress = true, RepairSpeed = true, ETA = true, Notification90 = true, Distance = true },
            Hooks = { Enabled = false, Distance = true },
            Pallets = { Enabled = false, Distance = true },
            Windows = { Enabled = false, Distance = true },
            Gates = { Enabled = true, Progress = true, Distance = true },
            Blood = { Enabled = false, Distance = true },
            Zombies = { Enabled = false, Distance = true }
        },
        Settings = {
            Style = "Standard",
            MaxDistance = 1000,
            DistanceFade = false,
            FadeStart = 500,
            FadeEnd = 1000,
            BackgroundCard = true,
            Tracers = false,
            TracerTarget = "Bottom",
            TracerStyle = "Line",
            Radar = false
        },
        Colors = {
            Killer = Color3.fromRGB(255, 42, 109),
            SurvivorHealthy = Color3.fromRGB(0, 255, 0),
            SurvivorInjured = Color3.fromRGB(255, 165, 0),
            SurvivorDowned = Color3.fromRGB(255, 0, 0),
            Generators = Color3.fromRGB(255, 255, 0),
            Hooks = Color3.fromRGB(139, 69, 19),
            Pallets = Color3.fromRGB(139, 69, 19),
            Windows = Color3.fromRGB(173, 216, 230),
            Gates = Color3.fromRGB(0, 255, 255),
            Blood = Color3.fromRGB(139, 0, 0),
            Tracers = Color3.fromRGB(255, 255, 255)
        },
        CensorNames = false
    },
    Farm = {
        AutoSurvivor = false,
        ServerHop = false,
        TotalAFK = false,
        AutoSkillCheck = false,
        SkillCheckMode = "Perfect",
        PerfectChance = 100,
        SkillCheckSpeed = 1.0,
        NoSkillChecks = false,
        AutoKiller = false,
        AntiWiggle = false
    },
    Modifiers = {
        TeamFilter = "Both",
        VaultSpeed = "Normal",
        SpeedBoost = false,
        SpeedMultiplier = 1.5,
        AccountPerks = false,
        InstantHeal = false,
        WindowNoclip = false,
        AutoEscape = false,
        AutoMoonwalk = false,
        ReverseMoonwalk = false,
        DisableAtWindows = false,
        SwaySpeed = 1.0,
        SwayAmplitude = 1.0,
        Shake = 0,
        RainbowCharacter = false,
        RainbowMode = "Highlight",
        EquippedPerks = { Slot1 = nil, Slot2 = nil, Slot3 = nil },
        CustomEmoteWheel = false,
        EmoteWheelKey = "G",
        EmoteWheelMode = "Hold"
    },
    Combat = {
        AutoParry = false,
        ParryUseItem = false,
        ParryRange = 15,
        ParryDelay = "Instant",
        CheckDirection = true,
        PingCompensation = true,
        VisualCircle = false,
        IgnoreFrenzy = false,
        IgnoreAbysswalkerDash = false,
        HideParryUI = false,
        GeneralAimbot = false,
        AimbotMode = "Hold",
        AimbotKey = "RMB",
        AimbotPart = "Head",
        AimbotPriority = "Closest",
        AimbotSmoothing = "Smooth",
        AimbotFOV = 200,
        ShowFOVCircle = false,
        AimbotTeamFilter = "Both",
        PredictMovement = true,
        Revolver = {
            AutoFarm = false,
            Aimbot = false,
            AimbotKey = "RMB",
            AimbotPart = "Head",
            Priority = "Closest",
            Smoothing = "Smooth",
            FOV = 200,
            OffsetX = 0,
            OffsetY = 0,
            Prediction = true,
            BulletSpeed = 1000,
            SilentAim = false,
            SilentFOV = 150,
            ShowSilentFOV = false,
            SilentColor = "White",
            SilentTarget = "Both",
            HighlightTarget = false,
            BypassRestrictions = false
        },
        Veil = {
            SpearTrajectory = false,
            TrajectoryNoclip = false,
            TrajectoryColor = "Cyan",
            SpearAimbot = false,
            AimbotKey = "RMB",
            AimbotPart = "Torso",
            Priority = "Closest",
            Smoothing = "Smooth",
            FOV = 200,
            SpearSpeed = 150,
            Gravity = 196.2,
            SilentAim = false,
            SilentFOV = 150,
            ShowSilentFOV = false,
            SilentColor = "Cyan",
            Priority = "Closest",
            HighlightTarget = false
        },
        Masked = {
            CurrentBuff = "Normal"
        },
        Stalker = {
            NoRecharge = false,
            KillGrab = false,
            StalkWhileMoving = false
        },
        Abysswalker = {
            InfiniteCorruption = false,
            AutoCrouch = false,
            AutoCrouchDistance = 30,
            NoStun = false
        }
    },
    Visuals = {
        RTX = false,
        DepthOfField = false,
        Preset = "Default",
        Saturation = 50,
        Contrast = 10,
        TimeOfDay = "Day",
        CustomLighting = false,
        LightingColor = Color3.fromRGB(255, 255, 255),
        GodRays = false,
        GodRaysIntensity = 50,
        Fog = false,
        FogColor = Color3.fromRGB(128, 128, 128),
        FogStart = 0,
        FogEnd = 500,
        Atmosphere = 0,
        Bloom = false,
        BloomIntensity = 50,
        BloomSize = 24,
        BloomThreshold = 0.5,
        Crosshair = false,
        CrosshairStyle = "Cross",
        CrosshairColor = Color3.fromRGB(255, 255, 255),
        CrosshairSize = 10,
        FullBright = false,
        NoFog = false,
        ThirdPersonKiller = false,
        InfiniteZoom = false,
        Flashlight = {
            Effect = "Normal",
            Color = Color3.fromRGB(255, 255, 255)
        },
        CustomBackground = false,
        BackgroundID = "",
        BackgroundTransparency = 0.5,
        BackgroundScale = 1.0,
        Network = {
            FakeLag = false,
            FakeLagDelay = 100,
            Desync = false,
            Ghost = false,
            GhostAlwaysOnTop = true,
            GhostTransparency = 0.5,
            GhostColor = Color3.fromRGB(255, 255, 255)
        }
    },
    Config = {
        Premium = false,
        Profiles = {},
        AutoSwitchSurvivor = "Default",
        AutoSwitchKiller = "Default",
        Keybinds = {
            OpenMenu = Enum.KeyCode.K,
            SpeedBoost = Enum.KeyCode.LeftShift,
            AutoMoonwalk = Enum.KeyCode.M,
            AutoSkillCheck = Enum.KeyCode.H,
            InstantHeal = Enum.KeyCode.J
        },
        UI = {
            InfoBanner = true,
            DisableNotifications = false,
            ShowToggleNotifications = true,
            ActiveFunctionsOverlay = true,
            SpectatorList = true,
            Theme = "Default"
        }
    }
}

-- Цветовая схема
local Theme = {
    Background = Color3.fromRGB(13, 13, 13),
    Card = Color3.fromRGB(26, 26, 26),
    Accent = Color3.fromRGB(255, 42, 109),
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(160, 160, 176),
    Border = Color3.fromRGB(40, 40, 40)
}

-- Иконки для вкладок
local TabIcons = {
    ESP = "rbxassetid://3926305904",
    Farm = "rbxassetid://3926307971",
    Modifiers = "rbxassetid://3926305904",
    Combat = "rbxassetid://3926305904",
    Visuals = "rbxassetid://3926305904",
    Config = "rbxassetid://3926305904"
}

-- Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViolenceDistrictGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Защита от удаления
if gethui then
    ScreenGui.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
else
    ScreenGui.Parent = CoreGui
end

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.35, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Округление углов
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Тень
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://297694300"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(95, 95, 905, 905)
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- Верхняя часть (заголовок)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 80)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

-- Логотип
local LogoContainer = Instance.new("Frame")
LogoContainer.Name = "LogoContainer"
LogoContainer.Size = UDim2.new(0, 64, 0, 64)
LogoContainer.Position = UDim2.new(0.5, -32, 0, 8)
LogoContainer.BackgroundTransparency = 1
LogoContainer.Parent = Header

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Image = "https://raw.githubusercontent.com/mopsech/candyhub/main/candy.png"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = LogoContainer

-- Если логотип не загрузится, показываем заглушку
local LogoFallback = Instance.new("TextLabel")
LogoFallback.Name = "LogoFallback"
LogoFallback.Size = UDim2.new(1, 0, 1, 0)
LogoFallback.BackgroundTransparency = 1
LogoFallback.Text = "VD"
LogoFallback.TextColor3 = Theme.Accent
LogoFallback.Font = Enum.Font.GothamBold
LogoFallback.TextSize = 32
LogoFallback.Visible = false
LogoFallback.Parent = LogoContainer

-- Проверка загрузки логотипа
task.spawn(function()
    task.wait(2)
    if Logo.Image == "" then
        LogoFallback.Visible = true
    end
end)

-- Название
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(0.8, 0, 0, 20)
Title.Position = UDim2.new(0.1, 0, 1, -25)
Title.BackgroundTransparency = 1
Title.Text = "VIOLENCE DISTRICT HUB"
Title.TextColor3 = Theme.TextPrimary
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Header

-- Версия
local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(0.8, 0, 0, 15)
Version.Position = UDim2.new(0.1, 0, 1, -10)
Version.BackgroundTransparency = 1
Version.Text = "v2.5 | Mobile Optimized"
Version.TextColor3 = Theme.TextSecondary
Version.Font = Enum.Font.Gotham
Version.TextSize = 10
Version.Parent = Header

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Theme.Card
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Theme.TextPrimary
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Нижняя панель с категориями
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Size = UDim2.new(1, 0, 0, 60)
TabBar.Position = UDim2.new(0, 0, 1, -60)
TabBar.BackgroundColor3 = Theme.Card
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

-- Разделительная линия
local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.Position = UDim2.new(0, 0, 0, 0)
Divider.BackgroundColor3 = Theme.Border
Divider.BorderSizePixel = 0
Divider.Parent = TabBar

-- Контейнер для контента
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -20, 1, -150)
ContentContainer.Position = UDim2.new(0, 10, 0, 85)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- ScrollingFrame для контента
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Theme.Accent
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = ContentContainer

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 8)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollFrame

-- Автоматическое обновление размера CanvasSize
ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ScrollLayout.AbsoluteContentSize.Y + 10)
end)

-- Функция создания кнопки вкладки
local CurrentTab = nil
local function CreateTabButton(name, icon, order)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(1/6, -5, 1, -10)
    TabButton.Position = UDim2.new((order-1)/6, (order-1)*5, 0, 5)
    TabButton.BackgroundColor3 = Theme.Card
    TabButton.BorderSizePixel = 0
    TabButton.Text = ""
    TabButton.AutoButtonColor = false
    TabButton.Parent = TabBar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = TabButton
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 24, 0, 24)
    Icon.Position = UDim2.new(0.5, -12, 0, 5)
    Icon.BackgroundTransparency = 1
    Icon.Image = icon
    Icon.ImageColor3 = Theme.TextSecondary
    Icon.Parent = TabButton
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 1, -23)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.TextSecondary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 10
    Label.Parent = TabButton
    
    local Highlight = Instance.new("Frame")
    Highlight.Name = "Highlight"
    Highlight.Size = UDim2.new(0.8, 0, 0, 2)
    Highlight.Position = UDim2.new(0.1, 0, 1, -2)
    Highlight.BackgroundColor3 = Theme.Accent
    Highlight.BorderSizePixel = 0
    Highlight.Visible = false
    Highlight.Parent = TabButton
    
    TabButton.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.BackgroundColor3 = Theme.Card
            CurrentTab:FindFirstChild("Icon").ImageColor3 = Theme.TextSecondary
            CurrentTab:FindFirstChild("Label").TextColor3 = Theme.TextSecondary
            CurrentTab:FindFirstChild("Highlight").Visible = false
        end
        
        CurrentTab = TabButton
        TabButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Icon.ImageColor3 = Theme.Accent
        Label.TextColor3 = Theme.Accent
        Highlight.Visible = true
        
        -- Очистка контента
        for _, child in pairs(ScrollFrame:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        -- Загрузка контента вкладки
        LoadTabContent(name)
    end)
    
    return TabButton
end

-- Создание вкладок
local ESPTab = CreateTabButton("ESP", TabIcons.ESP, 1)
local FarmTab = CreateTabButton("Фарм", TabIcons.Farm, 2)
local ModTab = CreateTabButton("Моды", TabIcons.Modifiers, 3)
local CombatTab = CreateTabButton("Бой", TabIcons.Combat, 4)
local VisualTab = CreateTabButton("Визуал", TabIcons.Visuals, 5)
local ConfigTab = CreateTabButton("Конфиг", TabIcons.Config, 6)

-- Функции создания UI элементов

-- Функция создания секции
local function CreateSection(name)
    local Section = Instance.new("Frame")
    Section.Name = name
    Section.Size = UDim2.new(1, 0, 0, 30)
    Section.BackgroundTransparency = 1
    Section.Parent = ScrollFrame
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = "▼ " .. name
    Label.TextColor3 = Theme.Accent
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Section
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 5)
    Padding.Parent = Label
    
    return Section
end

-- Функция создания Toggle
local function CreateToggle(name, default, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = name
    Toggle.Size = UDim2.new(1, 0, 0, 40)
    Toggle.BackgroundColor3 = Theme.Card
    Toggle.BorderSizePixel = 0
    Toggle.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Toggle
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.TextPrimary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Toggle
    
    local Button = Instance.new("TextButton")
    Button.Name = "Button"
    Button.Size = UDim2.new(0, 50, 0, 25)
    Button.Position = UDim2.new(1, -60, 0.5, -12.5)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Toggle
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(1, 0)
    ButtonCorner.Parent = Button
    
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Size = UDim2.new(0, 21, 0, 21)
    Indicator.Position = UDim2.new(0, 2, 0.5, -10.5)
    Indicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Indicator.BorderSizePixel = 0
    Indicator.Parent = Button
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = Indicator
    
    local State = default or false
    
    local function UpdateToggle()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if State then
            TweenService:Create(Button, tweenInfo, {BackgroundColor3 = Theme.Accent}):Play()
            TweenService:Create(Indicator, tweenInfo, {
                Position = UDim2.new(1, -23, 0.5, -10.5),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        else
            TweenService:Create(Button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            TweenService:Create(Indicator, tweenInfo, {
                Position = UDim2.new(0, 2, 0.5, -10.5),
                BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            }):Play()
        end
        
        if callback then
            callback(State)
        end
    end
    
    Button.MouseButton1Click:Connect(function()
        State = not State
        UpdateToggle()
    end)
    
    UpdateToggle()
    
    return Toggle, function() return State end, function(newState) State = newState UpdateToggle() end
end

-- Функция создания Slider
local function CreateSlider(name, min, max, default, suffix, callback)
    local Slider = Instance.new("Frame")
    Slider.Name = name
    Slider.Size = UDim2.new(1, 0, 0, 50)
    Slider.BackgroundColor3 = Theme.Card
    Slider.BorderSizePixel = 0
    Slider.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Slider
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(0.6, 0, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.TextPrimary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Slider
    
    local Value = Instance.new("TextLabel")
    Value.Name = "Value"
    Value.Size = UDim2.new(0.4, -10, 0, 20)
    Value.Position = UDim2.new(0.6, 0, 0, 5)
    Value.BackgroundTransparency = 1
    Value.Text = tostring(default) .. (suffix or "")
    Value.TextColor3 = Theme.Accent
    Value.Font = Enum.Font.GothamBold
    Value.TextSize = 12
    Value.TextXAlignment = Enum.TextXAlignment.Right
    Value.Parent = Slider
    
    local SliderBar = Instance.new("Frame")
    SliderBar.Name = "SliderBar"
    SliderBar.Size = UDim2.new(1, -20, 0, 6)
    SliderBar.Position = UDim2.new(0, 10, 1, -15)
    SliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = Slider
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1, 0)
    BarCorner.Parent = SliderBar
    
    local Fill = Instance.new("Frame")
    Fill.Name = "Fill"
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Accent
    Fill.BorderSizePixel = 0
    Fill.Parent = SliderBar
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = Fill
    
    local Dragging = false
    local CurrentValue = default
    
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        CurrentValue = math.floor(min + (max - min) * pos)
        
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Value.Text = tostring(CurrentValue) .. (suffix or "")
        
        if callback then
            callback(CurrentValue)
        end
    end
    
    SliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            UpdateSlider(input)
        end
    end)
    
    SliderBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSlider(input)
        end
    end)
    
    return Slider, function() return CurrentValue end
end

-- Функция создания Button
local function CreateButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = Theme.Accent
    Button.BorderSizePixel = 0
    Button.Text = name
    Button.TextColor3 = Theme.TextPrimary
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.AutoButtonColor = false
    Button.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(200, 30, 85)}):Play()
        task.wait(0.1)
        TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Theme.Accent}):Play()
        
        if callback then
            callback()
        end
    end)
    
    return Button
end

-- Функция создания Selector
local function CreateSelector(name, options, default, callback)
    local Selector = Instance.new("Frame")
    Selector.Name = name
    Selector.Size = UDim2.new(1, 0, 0, 40)
    Selector.BackgroundColor3 = Theme.Card
    Selector.BorderSizePixel = 0
    Selector.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Selector
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(0.5, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.TextPrimary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Selector
    
    local CurrentIndex = 1
    for i, v in ipairs(options) do
        if v == default then
            CurrentIndex = i
            break
        end
    end
    
    local ValueButton = Instance.new("TextButton")
    ValueButton.Name = "ValueButton"
    ValueButton.Size = UDim2.new(0.45, 0, 0, 30)
    ValueButton.Position = UDim2.new(0.52, 0, 0.5, -15)
    ValueButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ValueButton.BorderSizePixel = 0
    ValueButton.Text = options[CurrentIndex]
    ValueButton.TextColor3 = Theme.Accent
    ValueButton.Font = Enum.Font.GothamBold
    ValueButton.TextSize = 11
    ValueButton.AutoButtonColor = false
    ValueButton.Parent = Selector
    
    local ValueCorner = Instance.new("UICorner")
    ValueCorner.CornerRadius = UDim.new(0, 6)
    ValueCorner.Parent = ValueButton
    
    ValueButton.MouseButton1Click:Connect(function()
        CurrentIndex = CurrentIndex % #options + 1
        ValueButton.Text = options[CurrentIndex]
        
        if callback then
            callback(options[CurrentIndex])
        end
    end)
    
    return Selector, function() return options[CurrentIndex] end
end

-- Функция создания ColorPicker
local function CreateColorPicker(name, default, callback)
    local Picker = Instance.new("Frame")
    Picker.Name = name
    Picker.Size = UDim2.new(1, 0, 0, 40)
    Picker.BackgroundColor3 = Theme.Card
    Picker.BorderSizePixel = 0
    Picker.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Picker
    
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.TextPrimary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Picker
    
    local ColorBox = Instance.new("TextButton")
    ColorBox.Name = "ColorBox"
    ColorBox.Size = UDim2.new(0, 60, 0, 25)
    ColorBox.Position = UDim2.new(1, -70, 0.5, -12.5)
    ColorBox.BackgroundColor3 = default or Color3.fromRGB(255, 255, 255)
    ColorBox.BorderSizePixel = 0
    ColorBox.Text = ""
    ColorBox.AutoButtonColor = false
    ColorBox.Parent = Picker
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = ColorBox
    
    ColorBox.MouseButton1Click:Connect(function()
        -- Простой ColorPicker (упрощенная версия для мобильных)
        -- В полной версии можно реализовать развернутый ColorPicker
        if callback then
            callback(ColorBox.BackgroundColor3)
        end
    end)
    
    return Picker, function() return ColorBox.BackgroundColor3 end, function(color) ColorBox.BackgroundColor3 = color end
end

-- Функция загрузки контента вкладок
function LoadTabContent(tabName)
    if tabName == "ESP" then
        CreateSection("👁️ Основные настройки ESP")
        CreateToggle("Мастер ESP", _G.Settings.ESP.Master, function(v) _G.Settings.ESP.Master = v end)
        
        CreateSection("👤 Игроки")
        CreateToggle("Отслеживание убийцы", _G.Settings.ESP.Players.Killers.Enabled, function(v) _G.Settings.ESP.Players.Killers.Enabled = v end)
        CreateToggle("Подсветка убийцы", _G.Settings.ESP.Players.Killers.Aura, function(v) _G.Settings.ESP.Players.Killers.Aura = v end)
        CreateToggle("Дистанция убийцы", _G.Settings.ESP.Players.Killers.Distance, function(v) _G.Settings.ESP.Players.Killers.Distance = v end)
        
        CreateToggle("Отслеживание выживших", _G.Settings.ESP.Players.Survivors.Enabled, function(v) _G.Settings.ESP.Players.Survivors.Enabled = v end)
        CreateToggle("Здоровье выживших", _G.Settings.ESP.Players.Survivors.Health, function(v) _G.Settings.ESP.Players.Survivors.Health = v end)
        CreateToggle("Счетчик крюков", _G.Settings.ESP.Players.Survivors.Hooks, function(v) _G.Settings.ESP.Players.Survivors.Hooks = v end)
        CreateToggle("Цензура имен", _G.Settings.ESP.CensorNames, function(v) _G.Settings.ESP.CensorNames = v end)
        
        CreateSection("🔧 Объекты")
        CreateToggle("Генераторы", _G.Settings.ESP.Objects.Generators.Enabled, function(v) _G.Settings.ESP.Objects.Generators.Enabled = v end)
        CreateToggle("Прогресс генераторов", _G.Settings.ESP.Objects.Generators.Progress, function(v) _G.Settings.ESP.Objects.Generators.Progress = v end)
        CreateToggle("ETA генераторов", _G.Settings.ESP.Objects.Generators.ETA, function(v) _G.Settings.ESP.Objects.Generators.ETA = v end)
        CreateToggle("Крюки", _G.Settings.ESP.Objects.Hooks.Enabled, function(v) _G.Settings.ESP.Objects.Hooks.Enabled = v end)
        CreateToggle("Паллеты", _G.Settings.ESP.Objects.Pallets.Enabled, function(v) _G.Settings.ESP.Objects.Pallets.Enabled = v end)
        CreateToggle("Окна", _G.Settings.ESP.Objects.Windows.Enabled, function(v) _G.Settings.ESP.Objects.Windows.Enabled = v end)
        CreateToggle("Ворота", _G.Settings.ESP.Objects.Gates.Enabled, function(v) _G.Settings.ESP.Objects.Gates.Enabled = v end)
        CreateToggle("Кровь", _G.Settings.ESP.Objects.Blood.Enabled, function(v) _G.Settings.ESP.Objects.Blood.Enabled = v end)
        
        CreateSection("⚙️ Настройки ESP")
        CreateSelector("Стиль ESP", {"Старый", "Стандартный", "Компактный", "Минимальный", "Подсветка"}, _G.Settings.ESP.Settings.Style, function(v) _G.Settings.ESP.Settings.Style = v end)
        CreateSlider("Дальность ESP", 100, 2000, _G.Settings.ESP.Settings.MaxDistance, "m", function(v) _G.Settings.ESP.Settings.MaxDistance = v end)
        CreateToggle("Прозрачность по дистанции", _G.Settings.ESP.Settings.DistanceFade, function(v) _G.Settings.ESP.Settings.DistanceFade = v end)
        CreateToggle("Трейсеры", _G.Settings.ESP.Settings.Tracers, function(v) _G.Settings.ESP.Settings.Tracers = v end)
        CreateToggle("Радар-миникарта", _G.Settings.ESP.Settings.Radar, function(v) _G.Settings.ESP.Settings.Radar = v end)
        
        CreateSection("🎨 Цвета ESP")
        CreateColorPicker("Цвет убийцы", _G.Settings.ESP.Colors.Killer, function(v) _G.Settings.ESP.Colors.Killer = v end)
        CreateColorPicker("Выживший (здоров)", _G.Settings.ESP.Colors.SurvivorHealthy, function(v) _G.Settings.ESP.Colors.SurvivorHealthy = v end)
        CreateColorPicker("Выживший (ранен)", _G.Settings.ESP.Colors.SurvivorInjured, function(v) _G.Settings.ESP.Colors.SurvivorInjured = v end)
        CreateColorPicker("Генераторы", _G.Settings.ESP.Colors.Generators, function(v) _G.Settings.ESP.Colors.Generators = v end)
        
    elseif tabName == "Фарм" then
        CreateSection("⚙️ Автофарм")
        CreateToggle("Автофарм выжившего", _G.Settings.Farm.AutoSurvivor, function(v) _G.Settings.Farm.AutoSurvivor = v end)
        CreateToggle("Серверный хоп", _G.Settings.Farm.ServerHop, function(v) _G.Settings.Farm.ServerHop = v end)
        CreateToggle("Тотальный AFK фарм", _G.Settings.Farm.TotalAFK, function(v) _G.Settings.Farm.TotalAFK = v end)
        CreateButton("Мгновенный побег", function() print("Instant escape activated") end)
        
        CreateSection("🎯 Скиллчеки")
        CreateToggle("Авто-скиллчек", _G.Settings.Farm.AutoSkillCheck, function(v) _G.Settings.Farm.AutoSkillCheck = v end)
        CreateSelector("Режим скиллчека", {"Идеальный", "Обычный", "Гибридный"}, _G.Settings.Farm.SkillCheckMode, function(v) _G.Settings.Farm.SkillCheckMode = v end)
        CreateSlider("Шанс идеального", 0, 100, _G.Settings.Farm.PerfectChance, "%", function(v) _G.Settings.Farm.PerfectChance = v end)
        CreateSlider("Скорость скиллчека", 0.1, 3.0, _G.Settings.Farm.SkillCheckSpeed, "x", function(v) _G.Settings.Farm.SkillCheckSpeed = v end)
        CreateToggle("No Skill Checks", _G.Settings.Farm.NoSkillChecks, function(v) _G.Settings.Farm.NoSkillChecks = v end)
        CreateButton("Бафф генератора", function() print("Generator buff activated") end)
        
        CreateSection("🔪 Фарм убийцы")
        CreateToggle("Автофарм убийцы", _G.Settings.Farm.AutoKiller, function(v) _G.Settings.Farm.AutoKiller = v end)
        CreateToggle("Анти-вырывание", _G.Settings.Farm.AntiWiggle, function(v) _G.Settings.Farm.AntiWiggle = v end)
        
    elseif tabName == "Моды" then
        CreateSection("🎮 Модификаторы игрока")
        CreateSelector("Фильтр команды", {"Обе", "Выжившие", "Убийца"}, _G.Settings.Modifiers.TeamFilter, function(v) _G.Settings.Modifiers.TeamFilter = v end)
        CreateSelector("Скорость перелазания", {"Нормальная", "Средняя", "Быстрая"}, _G.Settings.Modifiers.VaultSpeed, function(v) _G.Settings.Modifiers.VaultSpeed = v end)
        CreateToggle("Буст скорости", _G.Settings.Modifiers.SpeedBoost, function(v) _G.Settings.Modifiers.SpeedBoost = v end)
        CreateSlider("Множитель скорости", 1, 3, _G.Settings.Modifiers.SpeedMultiplier, "x", function(v) _G.Settings.Modifiers.SpeedMultiplier = v end)
        CreateToggle("Учет перков скорости", _G.Settings.Modifiers.AccountPerks, function(v) _G.Settings.Modifiers.AccountPerks = v end)
        
        CreateSection("💊 Лечение")
        CreateToggle("Мгновенное лечение", _G.Settings.Modifiers.InstantHeal, function(v) _G.Settings.Modifiers.InstantHeal = v end)
        CreateButton("Мгновенная перевязка", function() print("Instant bandage activated") end)
        
        CreateSection("🏃 Движение")
        CreateToggle("Ноклип окон/паллет", _G.Settings.Modifiers.WindowNoclip, function(v) _G.Settings.Modifiers.WindowNoclip = v end)
        CreateToggle("Авто-побег от убийцы", _G.Settings.Modifiers.AutoEscape, function(v) _G.Settings.Modifiers.AutoEscape = v end)
        CreateToggle("Авто-лунная походка", _G.Settings.Modifiers.AutoMoonwalk, function(v) _G.Settings.Modifiers.AutoMoonwalk = v end)
        CreateToggle("Обратная лунная походка", _G.Settings.Modifiers.ReverseMoonwalk, function(v) _G.Settings.Modifiers.ReverseMoonwalk = v end)
        CreateToggle("Отключение у окон", _G.Settings.Modifiers.DisableAtWindows, function(v) _G.Settings.Modifiers.DisableAtWindows = v end)
        
        CreateSection("🎨 Визуальные эффекты")
        CreateToggle("Радужный персонаж", _G.Settings.Modifiers.RainbowCharacter, function(v) _G.Settings.Modifiers.RainbowCharacter = v end)
        CreateSelector("Режим радуги", {"Подсветка", "Части тела", "Силовое поле"}, _G.Settings.Modifiers.RainbowMode, function(v) _G.Settings.Modifiers.RainbowMode = v end)
        
        CreateSection("💪 Перки")
        CreateSelector("Слот 1", {"Нет", "Спринт", "Тихие шаги", "Самолечение"}, _G.Settings.Modifiers.EquippedPerks.Slot1 or "Нет", function(v) _G.Settings.Modifiers.EquippedPerks.Slot1 = v end)
        CreateSelector("Слот 2", {"Нет", "Спринт", "Тихие шаги", "Самолечение"}, _G.Settings.Modifiers.EquippedPerks.Slot2 or "Нет", function(v) _G.Settings.Modifiers.EquippedPerks.Slot2 = v end)
        CreateSelector("Слот 3", {"Нет", "Спринт", "Тихие шаги", "Самолечение"}, _G.Settings.Modifiers.EquippedPerks.Slot3 or "Нет", function(v) _G.Settings.Modifiers.EquippedPerks.Slot3 = v end)
        CreateButton("Обновить список перков", function() print("Refreshing perks...") end)
        
        CreateSection("🎭 Анимации и эмоты")
        CreateToggle("Кастомное колесо эмотов", _G.Settings.Modifiers.CustomEmoteWheel, function(v) _G.Settings.Modifiers.CustomEmoteWheel = v end)
        CreateSelector("Клавиша открытия", {"G", "H", "B", "N"}, _G.Settings.Modifiers.EmoteWheelKey, function(v) _G.Settings.Modifiers.EmoteWheelKey = v end)
        CreateSelector("Режим открытия", {"Удержание", "Переключение"}, _G.Settings.Modifiers.EmoteWheelMode, function(v) _G.Settings.Modifiers.EmoteWheelMode = v end)
        
        CreateSection("🚪 Паллеты и окна")
        CreateButton("Сбросить все паллеты", function() print("Dropping all pallets...") end)
        CreateButton("Блокировка окон", function() print("Blocking windows...") end)
        CreateButton("Блокировка паллет", function() print("Blocking pallets...") end)
        
    elseif tabName == "Бой" then
        CreateSection("🛡️ Автопарри")
        CreateToggle("Автопарри", _G.Settings.Combat.AutoParry, function(v) _G.Settings.Combat.AutoParry = v end)
        CreateToggle("Использовать предмет", _G.Settings.Combat.ParryUseItem, function(v) _G.Settings.Combat.ParryUseItem = v end)
        CreateSlider("Дальность парирования", 6, 25, _G.Settings.Combat.ParryRange, "m", function(v) _G.Settings.Combat.ParryRange = v end)
        CreateSelector("Задержка реакции", {"Мгновенная", "50ms", "100ms", "150ms", "200ms"}, _G.Settings.Combat.ParryDelay, function(v) _G.Settings.Combat.ParryDelay = v end)
        CreateToggle("Проверка направления", _G.Settings.Combat.CheckDirection, function(v) _G.Settings.Combat.CheckDirection = v end)
        CreateToggle("Компенсация пинга", _G.Settings.Combat.PingCompensation, function(v) _G.Settings.Combat.PingCompensation = v end)
        CreateToggle("Визуальный круг", _G.Settings.Combat.VisualCircle, function(v) _G.Settings.Combat.VisualCircle = v end)
        CreateToggle("Игнорирование Френзи", _G.Settings.Combat.IgnoreFrenzy, function(v) _G.Settings.Combat.IgnoreFrenzy = v end)
        CreateToggle("Скрыть UI парирования", _G.Settings.Combat.HideParryUI, function(v) _G.Settings.Combat.HideParryUI = v end)
        
        CreateSection("🎯 Общий аимбот")
        CreateToggle("Аимбот", _G.Settings.Combat.GeneralAimbot, function(v) _G.Settings.Combat.GeneralAimbot = v end)
        CreateSelector("Режим активации", {"Удержание", "Переключение"}, _G.Settings.Combat.AimbotMode, function(v) _G.Settings.Combat.AimbotMode = v end)
        CreateSelector("Кнопка активации", {"ПКМ", "ЛКМ", "E", "Q"}, _G.Settings.Combat.AimbotKey, function(v) _G.Settings.Combat.AimbotKey = v end)
        CreateSelector("Часть тела", {"Голова", "Торс", "RootPart"}, _G.Settings.Combat.AimbotPart, function(v) _G.Settings.Combat.AimbotPart = v end)
        CreateSelector("Приоритет цели", {"Ближайший", "Дальний", "Раненый", "Здоровый"}, _G.Settings.Combat.AimbotPriority, function(v) _G.Settings.Combat.AimbotPriority = v end)
        CreateSelector("Сглаживание", {"Ультраплавное", "Плавное", "Быстрое", "Мгновенное"}, _G.Settings.Combat.AimbotSmoothing, function(v) _G.Settings.Combat.AimbotSmoothing = v end)
        CreateSlider("FOV радиус", 50, 500, _G.Settings.Combat.AimbotFOV, "px", function(v) _G.Settings.Combat.AimbotFOV = v end)
        CreateToggle("Показывать FOV круг", _G.Settings.Combat.ShowFOVCircle, function(v) _G.Settings.Combat.ShowFOVCircle = v end)
        CreateToggle("Предсказание движения", _G.Settings.Combat.PredictMovement, function(v) _G.Settings.Combat.PredictMovement = v end)
        
        CreateSection("🔫 Револьвер")
        CreateToggle("Автофарм револьвером", _G.Settings.Combat.Revolver.AutoFarm, function(v) _G.Settings.Combat.Revolver.AutoFarm = v end)
        CreateToggle("Аимбот для револьвера", _G.Settings.Combat.Revolver.Aimbot, function(v) _G.Settings.Combat.Revolver.Aimbot = v end)
        CreateSlider("Скорость пули", 500, 2000, _G.Settings.Combat.Revolver.BulletSpeed, "m/s", function(v) _G.Settings.Combat.Revolver.BulletSpeed = v end)
        CreateToggle("Сайлент-аим", _G.Settings.Combat.Revolver.SilentAim, function(v) _G.Settings.Combat.Revolver.SilentAim = v end)
        CreateSlider("FOV сайлента", 50, 300, _G.Settings.Combat.Revolver.SilentFOV, "px", function(v) _G.Settings.Combat.Revolver.SilentFOV = v end)
        
        CreateSection("🗡️ Вейл")
        CreateToggle("Траектория копья", _G.Settings.Combat.Veil.SpearTrajectory, function(v) _G.Settings.Combat.Veil.SpearTrajectory = v end)
        CreateToggle("Noclip траектории", _G.Settings.Combat.Veil.TrajectoryNoclip, function(v) _G.Settings.Combat.Veil.TrajectoryNoclip = v end)
        CreateToggle("Аимбот для копья", _G.Settings.Combat.Veil.SpearAimbot, function(v) _G.Settings.Combat.Veil.SpearAimbot = v end)
        CreateSlider("Скорость копья", 50, 300, _G.Settings.Combat.Veil.SpearSpeed, "m/s", function(v) _G.Settings.Combat.Veil.SpearSpeed = v end)
        CreateSlider("Гравитация", 100, 300, _G.Settings.Combat.Veil.Gravity, "", function(v) _G.Settings.Combat.Veil.Gravity = v end)
        
        CreateSection("🎭 Маскированные")
        CreateButton("Рихтер - Скрытность", function() _G.Settings.Combat.Masked.CurrentBuff = "Richter" print("Richter buff activated") end)
        CreateButton("Алекс - Бензопила", function() _G.Settings.Combat.Masked.CurrentBuff = "Alex" print("Alex buff activated") end)
        CreateButton("Брэндон - Скорость", function() _G.Settings.Combat.Masked.CurrentBuff = "Brandon" print("Brandon buff activated") end)
        CreateButton("Кролик - Быстрые перелазания", function() _G.Settings.Combat.Masked.CurrentBuff = "Bunny" print("Bunny buff activated") end)
        CreateButton("Обычный - Без баффов", function() _G.Settings.Combat.Masked.CurrentBuff = "Normal" print("Normal mode activated") end)
        
        CreateSection("👁️ Сталкер")
        CreateToggle("Нет перезарядки", _G.Settings.Combat.Stalker.NoRecharge, function(v) _G.Settings.Combat.Stalker.NoRecharge = v end)
        CreateToggle("Убийственный захват", _G.Settings.Combat.Stalker.KillGrab, function(v) _G.Settings.Combat.Stalker.KillGrab = v end)
        CreateToggle("Сталк во время движения", _G.Settings.Combat.Stalker.StalkWhileMoving, function(v) _G.Settings.Combat.Stalker.StalkWhileMoving = v end)
        CreateButton("Сталк всех", function() print("Stalking all...") end)
        
        CreateSection("🌑 Бездныход")
        CreateToggle("Бесконечная порча", _G.Settings.Combat.Abysswalker.InfiniteCorruption, function(v) _G.Settings.Combat.Abysswalker.InfiniteCorruption = v end)
        CreateToggle("Авто-приседание", _G.Settings.Combat.Abysswalker.AutoCrouch, function(v) _G.Settings.Combat.Abysswalker.AutoCrouch = v end)
        CreateSlider("Дистанция приседания", 10, 50, _G.Settings.Combat.Abysswalker.AutoCrouchDistance, "m", function(v) _G.Settings.Combat.Abysswalker.AutoCrouchDistance = v end)
        CreateToggle("Нет стана", _G.Settings.Combat.Abysswalker.NoStun, function(v) _G.Settings.Combat.Abysswalker.NoStun = v end)
        
    elseif tabName == "Визуал" then
        CreateSection("🎨 Графика")
        CreateToggle("RTX Graphics", _G.Settings.Visuals.RTX, function(v) _G.Settings.Visuals.RTX = v end)
        CreateToggle("Глубина резкости", _G.Settings.Visuals.DepthOfField, function(v) _G.Settings.Visuals.DepthOfField = v end)
        CreateSelector("Визуальный пресет", {"По умолчанию", "Яркий", "Дневной", "Киберпанк", "Закат", "Лунный свет"}, _G.Settings.Visuals.Preset, function(v) _G.Settings.Visuals.Preset = v end)
        CreateSlider("Насыщенность", 0, 100, _G.Settings.Visuals.Saturation, "%", function(v) _G.Settings.Visuals.Saturation = v end)
        CreateSlider("Контраст", 0, 50, _G.Settings.Visuals.Contrast, "%", function(v) _G.Settings.Visuals.Contrast = v end)
        
        CreateSection("🌅 Освещение")
        CreateSelector("Время суток", {"День", "Закат", "Рассвет", "Ночь"}, _G.Settings.Visuals.TimeOfDay, function(v) _G.Settings.Visuals.TimeOfDay = v end)
        CreateToggle("Кастомное освещение", _G.Settings.Visuals.CustomLighting, function(v) _G.Settings.Visuals.CustomLighting = v end)
        CreateToggle("Лучи Бога", _G.Settings.Visuals.GodRays, function(v) _G.Settings.Visuals.GodRays = v end)
        CreateSlider("Интенсивность лучей", 0, 100, _G.Settings.Visuals.GodRaysIntensity, "%", function(v) _G.Settings.Visuals.GodRaysIntensity = v end)
        CreateToggle("Туман", _G.Settings.Visuals.Fog, function(v) _G.Settings.Visuals.Fog = v end)
        CreateSlider("Старт тумана", 0, 500, _G.Settings.Visuals.FogStart, "m", function(v) _G.Settings.Visuals.FogStart = v end)
        CreateSlider("Конец тумана", 100, 1000, _G.Settings.Visuals.FogEnd, "m", function(v) _G.Settings.Visuals.FogEnd = v end)
        
        CreateSection("✨ Эффекты")
        CreateToggle("Блум", _G.Settings.Visuals.Bloom, function(v) _G.Settings.Visuals.Bloom = v end)
        CreateSlider("Интенсивность блума", 0, 100, _G.Settings.Visuals.BloomIntensity, "%", function(v) _G.Settings.Visuals.BloomIntensity = v end)
        CreateSlider("Размер блума", 1, 50, _G.Settings.Visuals.BloomSize, "", function(v) _G.Settings.Visuals.BloomSize = v end)
        CreateToggle("Full Bright", _G.Settings.Visuals.FullBright, function(v) _G.Settings.Visuals.FullBright = v end)
        CreateToggle("No Fog", _G.Settings.Visuals.NoFog, function(v) _G.Settings.Visuals.NoFog = v end)
        
        CreateSection("🎯 Прицел")
        CreateToggle("Прицел", _G.Settings.Visuals.Crosshair, function(v) _G.Settings.Visuals.Crosshair = v end)
        CreateSelector("Стиль прицела", {"Крест", "Точка", "Круг", "T-образный"}, _G.Settings.Visuals.CrosshairStyle, function(v) _G.Settings.Visuals.CrosshairStyle = v end)
        CreateSlider("Размер прицела", 5, 30, _G.Settings.Visuals.CrosshairSize, "px", function(v) _G.Settings.Visuals.CrosshairSize = v end)
        
        CreateSection("📷 Камера")
        CreateToggle("Режим от третьего лица", _G.Settings.Visuals.ThirdPersonKiller, function(v) _G.Settings.Visuals.ThirdPersonKiller = v end)
        CreateToggle("Бесконечный зум", _G.Settings.Visuals.InfiniteZoom, function(v) _G.Settings.Visuals.InfiniteZoom = v end)
        
        CreateSection("🔦 Фонарик")
        CreateSelector("Эффект фонарика", {"Обычный", "Радуга", "Стробоскоп", "Ультраяркий"}, _G.Settings.Visuals.Flashlight.Effect, function(v) _G.Settings.Visuals.Flashlight.Effect = v end)
        CreateColorPicker("Цвет фонарика", _G.Settings.Visuals.Flashlight.Color, function(v) _G.Settings.Visuals.Flashlight.Color = v end)
        
        CreateSection("🖼️ Кастомный фон")
        CreateToggle("Кастомный фон меню", _G.Settings.Visuals.CustomBackground, function(v) _G.Settings.Visuals.CustomBackground = v end)
        CreateSlider("Прозрачность фона", 0, 100, _G.Settings.Visuals.BackgroundTransparency * 100, "%", function(v) _G.Settings.Visuals.BackgroundTransparency = v / 100 end)
        
        CreateSection("🌐 Сетевые манипуляции")
        CreateToggle("Fake Lag", _G.Settings.Visuals.Network.FakeLag, function(v) _G.Settings.Visuals.Network.FakeLag = v end)
        CreateSlider("Задержка Fake Lag", 50, 500, _G.Settings.Visuals.Network.FakeLagDelay, "ms", function(v) _G.Settings.Visuals.Network.FakeLagDelay = v end)
        CreateToggle("Desync", _G.Settings.Visuals.Network.Desync, function(v) _G.Settings.Visuals.Network.Desync = v end)
        CreateToggle("Призрак", _G.Settings.Visuals.Network.Ghost, function(v) _G.Settings.Visuals.Network.Ghost = v end)
        CreateSlider("Прозрачность призрака", 0, 100, _G.Settings.Visuals.Network.GhostTransparency * 100, "%", function(v) _G.Settings.Visuals.Network.GhostTransparency = v / 100 end)
        
    elseif tabName == "Конфиг" then
        CreateSection("🔑 Премиум статус")
        local premiumStatus = Instance.new("TextLabel")
        premiumStatus.Size = UDim2.new(1, 0, 0, 40)
        premiumStatus.BackgroundColor3 = Theme.Card
        premiumStatus.BorderSizePixel = 0
        premiumStatus.Text = _G.Settings.Config.Premium and "✓ ПРЕМИУМ АКТИВИРОВАН" or "✗ Бесплатная версия"
        premiumStatus.TextColor3 = _G.Settings.Config.Premium and Color3.fromRGB(0, 255, 0) or Theme.TextSecondary
        premiumStatus.Font = Enum.Font.GothamBold
        premiumStatus.TextSize = 13
        premiumStatus.Parent = ScrollFrame
        
        local psCorner = Instance.new("UICorner")
        psCorner.CornerRadius = UDim.new(0, 8)
        psCorner.Parent = premiumStatus
        
        CreateSection("💾 Профили конфигов")
        CreateButton("Сохранить текущий профиль", function()
            local success, err = pcall(function()
                local json = HttpService:JSONEncode(_G.Settings)
                writefile("VDHub_Config.json", json)
            end)
            if success then
                print("✓ Конфиг сохранен")
            else
                warn("✗ Ошибка сохранения: " .. tostring(err))
            end
        end)
        
        CreateButton("Загрузить профиль", function()
            local success, err = pcall(function()
                if isfile("VDHub_Config.json") then
                    local json = readfile("VDHub_Config.json")
                    _G.Settings = HttpService:JSONDecode(json)
                    print("✓ Конфиг загружен")
                else
                    warn("✗ Файл конфига не найден")
                end
            end)
            if not success then
                warn("✗ Ошибка загрузки: " .. tostring(err))
            end
        end)
        
        CreateButton("Удалить профиль", function()
            if isfile("VDHub_Config.json") then
                delfile("VDHub_Config.json")
                print("✓ Конфиг удален")
            end
        end)
        
        CreateSection("⌨️ Настройки клавиш")
        CreateSelector("Открыть меню", {"K", "L", "Insert", "Home"}, "K", function(v)
            -- Здесь можно добавить логику смены клавиши
        end)
        
        CreateSection("🎨 Настройки интерфейса")
        CreateToggle("Информационный баннер", _G.Settings.Config.UI.InfoBanner, function(v) _G.Settings.Config.UI.InfoBanner = v end)
        CreateToggle("Отключить уведомления", _G.Settings.Config.UI.DisableNotifications, function(v) _G.Settings.Config.UI.DisableNotifications = v end)
        CreateToggle("Уведомления о переключении", _G.Settings.Config.UI.ShowToggleNotifications, function(v) _G.Settings.Config.UI.ShowToggleNotifications = v end)
        CreateToggle("Оверлей активных функций", _G.Settings.Config.UI.ActiveFunctionsOverlay, function(v) _G.Settings.Config.UI.ActiveFunctionsOverlay = v end)
        CreateToggle("Список зрителей", _G.Settings.Config.UI.SpectatorList, function(v) _G.Settings.Config.UI.SpectatorList = v end)
        CreateSelector("Тема UI", {"Default", "Cyberpunk", "Vampire", "Emerald"}, _G.Settings.Config.UI.Theme, function(v) _G.Settings.Config.UI.Theme = v end)
        
        CreateSection("⚠️ Управление скриптом")
        CreateButton("Сброс настроек", function()
            _G.Settings = nil
            print("✓ Настройки сброшены. Перезагрузите скрипт")
        end)
        
        CreateButton("Выгрузка скрипта", function()
            ScreenGui:Destroy()
            print("✓ Скрипт выгружен")
        end)
    end
end

-- Активация первой вкладки при запуске
task.wait(0.1)
ESPTab.MouseButton1Click:Connect(function() end)
ESPTab.MouseButton1Click:Fire()

-- Анимация появления GUI
MainFrame.Position = UDim2.new(0.5, 0, -1, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.35, 0)
}):Play()

-- Обработка закрытия/открытия меню клавишей
local MenuOpen = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.K then
        MenuOpen = not MenuOpen
        ScreenGui.Enabled = MenuOpen
    end
end)

-- Уведомление о загрузке
local NotificationLabel = Instance.new("TextLabel")
NotificationLabel.Size = UDim2.new(0, 300, 0, 50)
NotificationLabel.Position = UDim2.new(0.5, -150, 0, 20)
NotificationLabel.BackgroundColor3 = Theme.Card
NotificationLabel.BorderSizePixel = 0
NotificationLabel.Text = "✓ Violence District Hub загружен"
NotificationLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
NotificationLabel.Font = Enum.Font.GothamBold
NotificationLabel.TextSize = 14
NotificationLabel.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = NotificationLabel

task.wait(3)
NotificationLabel:Destroy()

print("Violence District Mobile GUI успешно загружен!")
print("Нажмите K для открытия/закрытия меню")
