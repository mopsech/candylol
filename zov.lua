-- Violence District Mobile GUI | Full Recode
-- Оптимизировано для мобильных устройств и ПК

--[[
    VIOLENCE DISTRICT HUB
    Версия: 3.0 Mobile
    Создано специально для мобильных устройств
]]

-- Сервисы
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Глобальные настройки
_G.VDSettings = _G.VDSettings or {
    ESP = {
        Master = false,
        Players = {
            Killers = { Enabled = true, Aura = true, Distance = true, Name = true },
            Survivors = { Enabled = true, Aura = true, Health = true, Hooks = true, Name = true }
        },
        Objects = {
            Generators = { Enabled = true, Progress = true, RepairSpeed = true, ETA = true, Distance = true },
            Hooks = { Enabled = false },
            Pallets = { Enabled = false },
            Windows = { Enabled = false },
            Gates = { Enabled = true, Progress = true }
        },
        Settings = {
            Style = "Standard",
            MaxDistance = 1000,
            DistanceFade = false,
            Tracers = false,
            Radar = false
        },
        Colors = {
            Killer = Color3.fromRGB(255, 42, 109),
            SurvivorHealthy = Color3.fromRGB(0, 255, 0),
            SurvivorInjured = Color3.fromRGB(255, 165, 0),
            SurvivorDowned = Color3.fromRGB(255, 0, 0),
            Generators = Color3.fromRGB(255, 255, 0)
        }
    },
    Farm = {
        AutoSurvivor = false,
        AutoSkillCheck = false,
        SkillCheckMode = "Perfect",
        PerfectChance = 100,
        NoSkillChecks = false,
        AutoKiller = false
    },
    Modifiers = {
        SpeedBoost = false,
        SpeedMultiplier = 1.5,
        InstantHeal = false,
        AutoMoonwalk = false,
        RainbowCharacter = false
    },
    Combat = {
        AutoParry = false,
        ParryRange = 15,
        ParryDelay = "Instant",
        GeneralAimbot = false,
        AimbotFOV = 200,
        ShowFOVCircle = false
    },
    Visuals = {
        RTX = false,
        FullBright = false,
        NoFog = false,
        Crosshair = false,
        CrosshairSize = 10
    },
    Config = {
        Premium = false,
        MenuKey = Enum.KeyCode.K
    }
}

-- Цветовая схема
local Colors = {
    Background = Color3.fromRGB(10, 10, 10),
    Card = Color3.fromRGB(26, 26, 26),
    Accent = Color3.fromRGB(255, 42, 109),
    TextPrimary = Color3.fromRGB(255, 255, 255),
    TextSecondary = Color3.fromRGB(160, 160, 176),
    Border = Color3.fromRGB(40, 40, 40),
    Success = Color3.fromRGB(0, 255, 0),
    Warning = Color3.fromRGB(255, 165, 0),
    Error = Color3.fromRGB(255, 0, 0)
}

-- Утилиты
local Utility = {}

function Utility:Tween(object, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

function Utility:MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, mousePos, framePos

    handle = handle or frame

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Utility:Tween(frame, {
                Position = UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
            }, 0.1)
        end
    end)
end

function Utility:CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

function Utility:CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Colors.Border
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

function Utility:CreatePadding(parent, all)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, all or 0)
    padding.PaddingBottom = UDim.new(0, all or 0)
    padding.PaddingLeft = UDim.new(0, all or 0)
    padding.PaddingRight = UDim.new(0, all or 0)
    padding.Parent = parent
    return padding
end

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViolenceDistrictHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

-- Защита GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- Главный контейнер
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.AnchorPoint = Vector2.new(0.5, 0.5)
MainContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
MainContainer.Size = UDim2.new(0, 420, 0, 580)
MainContainer.BackgroundColor3 = Colors.Background
MainContainer.BorderSizePixel = 0
MainContainer.Parent = ScreenGui
Utility:CreateCorner(MainContainer, 16)

-- Тень для главного контейнера
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.ZIndex = 0
Shadow.Parent = MainContainer

-- Верхняя панель (Header)
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 100)
Header.BackgroundTransparency = 1
Header.Parent = MainContainer

-- Логотип
local LogoFrame = Instance.new("Frame")
LogoFrame.Name = "LogoFrame"
LogoFrame.AnchorPoint = Vector2.new(0.5, 0)
LogoFrame.Position = UDim2.new(0.5, 0, 0, 15)
LogoFrame.Size = UDim2.new(0, 60, 0, 60)
LogoFrame.BackgroundColor3 = Colors.Card
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = Header
Utility:CreateCorner(LogoFrame, 30)

local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(1, -10, 1, -10)
Logo.Position = UDim2.new(0, 5, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Image = "https://raw.githubusercontent.com/mopsech/candyhub/main/candy.png"
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = LogoFrame

-- Заглушка для логотипа
local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "VD"
LogoText.TextColor3 = Colors.Accent
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 28
LogoText.Visible = false
LogoText.Parent = LogoFrame

-- Проверка загрузки логотипа
task.spawn(function()
    task.wait(3)
    if Logo.Image == "" or not Logo.IsLoaded then
        LogoText.Visible = true
    end
end)

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(0.5, 0)
Title.Position = UDim2.new(0.5, 0, 0, 78)
Title.Size = UDim2.new(0.8, 0, 0, 16)
Title.BackgroundTransparency = 1
Title.Text = "VIOLENCE DISTRICT"
Title.TextColor3 = Colors.TextPrimary
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Header

-- Версия
local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.AnchorPoint = Vector2.new(0.5, 0)
Version.Position = UDim2.new(0.5, 0, 0, 95)
Version.Size = UDim2.new(0.8, 0, 0, 12)
Version.BackgroundTransparency = 1
Version.Text = "v3.0 Mobile | Premium"
Version.TextColor3 = Colors.TextSecondary
Version.Font = Enum.Font.Gotham
Version.TextSize = 11
Version.Parent = Header

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Position = UDim2.new(1, -45, 0, 10)
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.BackgroundColor3 = Colors.Card
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Colors.TextPrimary
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.AutoButtonColor = false
CloseButton.Parent = Header
Utility:CreateCorner(CloseButton, 8)

CloseButton.MouseEnter:Connect(function()
    Utility:Tween(CloseButton, {BackgroundColor3 = Colors.Error})
end)

CloseButton.MouseLeave:Connect(function()
    Utility:Tween(CloseButton, {BackgroundColor3 = Colors.Card})
end)

CloseButton.MouseButton1Click:Connect(function()
    Utility:Tween(MainContainer, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    task.wait(0.3)
    ScreenGui.Enabled = false
end)

-- Контейнер для контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Position = UDim2.new(0, 10, 0, 110)
ContentFrame.Size = UDim2.new(1, -20, 1, -180)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainContainer

-- ScrollingFrame для контента
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Name = "ContentScroll"
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 3
ContentScroll.ScrollBarImageColor3 = Colors.Accent
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = ContentFrame

-- Layout для контента
local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Parent = ContentScroll

-- Разделитель между контентом и вкладками
local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Position = UDim2.new(0, 0, 1, -71)
Divider.Size = UDim2.new(1, 0, 0, 1)
Divider.BackgroundColor3 = Colors.Border
Divider.BorderSizePixel = 0
Divider.Parent = MainContainer

-- Нижняя панель с вкладками
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Position = UDim2.new(0, 0, 1, -70)
TabBar.Size = UDim2.new(1, 0, 0, 70)
TabBar.BackgroundColor3 = Colors.Card
TabBar.BorderSizePixel = 0
TabBar.Parent = MainContainer

-- Закругление нижней части
local BottomCorner = Instance.new("Frame")
BottomCorner.Size = UDim2.new(1, 0, 0, 16)
BottomCorner.Position = UDim2.new(0, 0, 0, 0)
BottomCorner.BackgroundColor3 = Colors.Background
BottomCorner.BorderSizePixel = 0
BottomCorner.Parent = TabBar

-- Контейнер для кнопок вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Position = UDim2.new(0, 5, 0, 5)
TabContainer.Size = UDim2.new(1, -10, 1, -10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = TabBar

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabContainer

-- Переменные для вкладок
local CurrentTab = nil
local Tabs = {}

-- Библиотека элементов UI
local Library = {}

-- Создание вкладки
function Library:CreateTab(name, icon)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0, 60, 0, 60)
    TabButton.BackgroundColor3 = Colors.Background
    TabButton.BorderSizePixel = 0
    TabButton.AutoButtonColor = false
    TabButton.Text = ""
    TabButton.Parent = TabContainer
    Utility:CreateCorner(TabButton, 10)

    -- Иконка (эмодзи)
    local Icon = Instance.new("TextLabel")
    Icon.Name = "Icon"
    Icon.Position = UDim2.new(0, 0, 0, 8)
    Icon.Size = UDim2.new(1, 0, 0, 24)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextColor3 = Colors.TextSecondary
    Icon.Font = Enum.Font.GothamBold
    Icon.TextSize = 20
    Icon.Parent = TabButton

    -- Название вкладки
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Position = UDim2.new(0, 0, 0, 34)
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Colors.TextSecondary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 9
    Label.Parent = TabButton

    -- Индикатор активной вкладки
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.AnchorPoint = Vector2.new(0.5, 1)
    Indicator.Position = UDim2.new(0.5, 0, 1, -3)
    Indicator.Size = UDim2.new(0.7, 0, 0, 2)
    Indicator.BackgroundColor3 = Colors.Accent
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = TabButton
    Utility:CreateCorner(Indicator, 1)

    -- Таб контент
    local TabContent = {
        Name = name,
        Button = TabButton,
        Icon = Icon,
        Label = Label,
        Indicator = Indicator,
        Elements = {}
    }

    -- Обработка нажатия
    TabButton.MouseButton1Click:Connect(function()
        Library:SelectTab(TabContent)
    end)

    -- Эффект наведения
    TabButton.MouseEnter:Connect(function()
        if CurrentTab ~= TabContent then
            Utility:Tween(TabButton, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)})
        end
    end)

    TabButton.MouseLeave:Connect(function()
        if CurrentTab ~= TabContent then
            Utility:Tween(TabButton, {BackgroundColor3 = Colors.Background})
        end
    end)

    table.insert(Tabs, TabContent)
    return TabContent
end

-- Выбор вкладки
function Library:SelectTab(tab)
    -- Деактивация предыдущей вкладки
    if CurrentTab then
        Utility:Tween(CurrentTab.Button, {BackgroundColor3 = Colors.Background})
        Utility:Tween(CurrentTab.Icon, {TextColor3 = Colors.TextSecondary})
        Utility:Tween(CurrentTab.Label, {TextColor3 = Colors.TextSecondary})
        CurrentTab.Indicator.Visible = false
    end

    -- Активация новой вкладки
    CurrentTab = tab
    Utility:Tween(tab.Button, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
    Utility:Tween(tab.Icon, {TextColor3 = Colors.Accent})
    Utility:Tween(tab.Label, {TextColor3 = Colors.Accent})
    tab.Indicator.Visible = true

    -- Очистка контента
    for _, child in pairs(ContentScroll:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    -- Загрузка элементов вкладки
    for _, element in pairs(tab.Elements) do
        element.Parent = ContentScroll
    end
end

-- Создание секции
function Library:CreateSection(tab, text)
    local Section = Instance.new("Frame")
    Section.Name = "Section"
    Section.Size = UDim2.new(1, 0, 0, 35)
    Section.BackgroundTransparency = 1
    Section.LayoutOrder = #tab.Elements

    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, 0, 1, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Text = text
    SectionLabel.TextColor3 = Colors.Accent
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextSize = 13
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.Parent = Section

    Utility:CreatePadding(SectionLabel, 8)

    table.insert(tab.Elements, Section)
    return Section
end

-- Создание Toggle
function Library:CreateToggle(tab, text, default, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = "Toggle"
    Toggle.Size = UDim2.new(1, 0, 0, 45)
    Toggle.BackgroundColor3 = Colors.Card
    Toggle.BorderSizePixel = 0
    Toggle.LayoutOrder = #tab.Elements
    Utility:CreateCorner(Toggle, 8)

    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Position = UDim2.new(0, 12, 0, 0)
    ToggleLabel.Size = UDim2.new(1, -80, 1, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Colors.TextPrimary
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextSize = 12
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.TextWrapped = true
    ToggleLabel.Parent = Toggle

    local ToggleButton = Instance.new("TextButton")
    ToggleButton.AnchorPoint = Vector2.new(1, 0.5)
    ToggleButton.Position = UDim2.new(1, -12, 0.5, 0)
    ToggleButton.Size = UDim2.new(0, 50, 0, 26)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.AutoButtonColor = false
    ToggleButton.Text = ""
    ToggleButton.Parent = Toggle
    Utility:CreateCorner(ToggleButton, 13)

    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Position = UDim2.new(0, 3, 0.5, 0)
    ToggleIndicator.AnchorPoint = Vector2.new(0, 0.5)
    ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleIndicator.BorderSizePixel = 0
    ToggleIndicator.Parent = ToggleButton
    Utility:CreateCorner(ToggleIndicator, 10)

    local State = default or false

    local function UpdateToggle(noCallback)
        State = not State

        if State then
            Utility:Tween(ToggleButton, {BackgroundColor3 = Colors.Accent}, 0.2)
            Utility:Tween(ToggleIndicator, {
                Position = UDim2.new(1, -23, 0.5, 0),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }, 0.2)
        else
            Utility:Tween(ToggleButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}, 0.2)
            Utility:Tween(ToggleIndicator, {
                Position = UDim2.new(0, 3, 0.5, 0),
                BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            }, 0.2)
        end

        if callback and not noCallback then
            pcall(callback, State)
        end
    end

    -- Установка начального состояния без вызова callback
    if State then
        ToggleButton.BackgroundColor3 = Colors.Accent
        ToggleIndicator.Position = UDim2.new(1, -23, 0.5, 0)
        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end

    ToggleButton.MouseButton1Click:Connect(function()
        UpdateToggle()
    end)

    table.insert(tab.Elements, Toggle)

    return {
        SetState = function(newState)
            if State ~= newState then
                UpdateToggle(true)
            end
        end,
        GetState = function()
            return State
        end
    }
end

-- Создание Slider
function Library:CreateSlider(tab, text, min, max, default, suffix, callback)
    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.Size = UDim2.new(1, 0, 0, 55)
    Slider.BackgroundColor3 = Colors.Card
    Slider.BorderSizePixel = 0
    Slider.LayoutOrder = #tab.Elements
    Utility:CreateCorner(Slider, 8)

    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Position = UDim2.new(0, 12, 0, 8)
    SliderLabel.Size = UDim2.new(0.6, 0, 0, 15)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = text
    SliderLabel.TextColor3 = Colors.TextPrimary
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextSize = 12
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = Slider

    local SliderValue = Instance.new("TextLabel")
    SliderValue.Position = UDim2.new(0.6, 0, 0, 8)
    SliderValue.Size = UDim2.new(0.4, -12, 0, 15)
    SliderValue.BackgroundTransparency = 1
    SliderValue.Text = tostring(default) .. (suffix or "")
    SliderValue.TextColor3 = Colors.Accent
    SliderValue.Font = Enum.Font.GothamBold
    SliderValue.TextSize = 12
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    SliderValue.Parent = Slider

    local SliderBar = Instance.new("Frame")
    SliderBar.Position = UDim2.new(0, 12, 1, -20)
    SliderBar.Size = UDim2.new(1, -24, 0, 6)
    SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SliderBar.BorderSizePixel = 0
    SliderBar.Parent = Slider
    Utility:CreateCorner(SliderBar, 3)

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Colors.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBar
    Utility:CreateCorner(SliderFill, 3)

    local SliderDot = Instance.new("Frame")
    SliderDot.AnchorPoint = Vector2.new(0.5, 0.5)
    SliderDot.Position = UDim2.new(1, 0, 0.5, 0)
    SliderDot.Size = UDim2.new(0, 14, 0, 14)
    SliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderDot.BorderSizePixel = 0
    SliderDot.Parent = SliderFill
    Utility:CreateCorner(SliderDot, 7)

    local CurrentValue = default
    local Dragging = false

    local function UpdateSlider(input)
        local relativeX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        CurrentValue = math.floor(min + (max - min) * relativeX)

        SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        SliderValue.Text = tostring(CurrentValue) .. (suffix or "")

        if callback then
            pcall(callback, CurrentValue)
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

    table.insert(tab.Elements, Slider)

    return {
        SetValue = function(value)
            CurrentValue = math.clamp(value, min, max)
            local relativeX = (CurrentValue - min) / (max - min)
            SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            SliderValue.Text = tostring(CurrentValue) .. (suffix or "")
        end,
        GetValue = function()
            return CurrentValue
        end
    }
end

-- Создание Button
function Library:CreateButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = "Button"
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = Colors.Accent
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = text
    Button.TextColor3 = Colors.TextPrimary
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.LayoutOrder = #tab.Elements
    Utility:CreateCorner(Button, 8)

    Button.MouseEnter:Connect(function()
        Utility:Tween(Button, {BackgroundColor3 = Color3.fromRGB(230, 38, 98)})
    end)

    Button.MouseLeave:Connect(function()
        Utility:Tween(Button, {BackgroundColor3 = Colors.Accent})
    end)

    Button.MouseButton1Click:Connect(function()
        Utility:Tween(Button, {BackgroundColor3 = Color3.fromRGB(200, 30, 85)}, 0.1)
        task.wait(0.1)
        Utility:Tween(Button, {BackgroundColor3 = Colors.Accent}, 0.1)

        if callback then
            pcall(callback)
        end
    end)

    table.insert(tab.Elements, Button)
    return Button
end

-- Создание Selector (Dropdown)
function Library:CreateSelector(tab, text, options, default, callback)
    local Selector = Instance.new("Frame")
    Selector.Name = "Selector"
    Selector.Size = UDim2.new(1, 0, 0, 45)
    Selector.BackgroundColor3 = Colors.Card
    Selector.BorderSizePixel = 0
    Selector.LayoutOrder = #tab.Elements
    Utility:CreateCorner(Selector, 8)

    local SelectorLabel = Instance.new("TextLabel")
    SelectorLabel.Position = UDim2.new(0, 12, 0, 0)
    SelectorLabel.Size = UDim2.new(0.45, 0, 1, 0)
    SelectorLabel.BackgroundTransparency = 1
    SelectorLabel.Text = text
    SelectorLabel.TextColor3 = Colors.TextPrimary
    SelectorLabel.Font = Enum.Font.Gotham
    SelectorLabel.TextSize = 12
    SelectorLabel.TextXAlignment = Enum.TextXAlignment.Left
    SelectorLabel.Parent = Selector

    local CurrentIndex = 1
    for i, v in ipairs(options) do
        if v == default then
            CurrentIndex = i
            break
        end
    end

    local SelectorButton = Instance.new("TextButton")
    SelectorButton.Position = UDim2.new(0.5, 5, 0.5, 0)
    SelectorButton.AnchorPoint = Vector2.new(0, 0.5)
    SelectorButton.Size = UDim2.new(0.45, -17, 0, 30)
    SelectorButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SelectorButton.BorderSizePixel = 0
    SelectorButton.AutoButtonColor = false
    SelectorButton.Text = options[CurrentIndex]
    SelectorButton.TextColor3 = Colors.Accent
    SelectorButton.Font = Enum.Font.GothamBold
    SelectorButton.TextSize = 11
    SelectorButton.TextTruncate = Enum.TextTruncate.AtEnd
    SelectorButton.Parent = Selector
    Utility:CreateCorner(SelectorButton, 6)

    SelectorButton.MouseButton1Click:Connect(function()
        CurrentIndex = CurrentIndex % #options + 1
        SelectorButton.Text = options[CurrentIndex]

        if callback then
            pcall(callback, options[CurrentIndex])
        end
    end)

    SelectorButton.MouseEnter:Connect(function()
        Utility:Tween(SelectorButton, {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
    end)

    SelectorButton.MouseLeave:Connect(function()
        Utility:Tween(SelectorButton, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)})
    end)

    table.insert(tab.Elements, Selector)

    return {
        SetOption = function(option)
            for i, v in ipairs(options) do
                if v == option then
                    CurrentIndex = i
                    SelectorButton.Text = v
                    break
                end
            end
        end,
        GetOption = function()
            return options[CurrentIndex]
        end
    }
end

-- Создание ColorPicker
function Library:CreateColorPicker(tab, text, default, callback)
    local ColorPicker = Instance.new("Frame")
    ColorPicker.Name = "ColorPicker"
    ColorPicker.Size = UDim2.new(1, 0, 0, 45)
    ColorPicker.BackgroundColor3 = Colors.Card
    ColorPicker.BorderSizePixel = 0
    ColorPicker.LayoutOrder = #tab.Elements
    Utility:CreateCorner(ColorPicker, 8)

    local PickerLabel = Instance.new("TextLabel")
    PickerLabel.Position = UDim2.new(0, 12, 0, 0)
    PickerLabel.Size = UDim2.new(0.65, 0, 1, 0)
    PickerLabel.BackgroundTransparency = 1
    PickerLabel.Text = text
    PickerLabel.TextColor3 = Colors.TextPrimary
    PickerLabel.Font = Enum.Font.Gotham
    PickerLabel.TextSize = 12
    PickerLabel.TextXAlignment = Enum.TextXAlignment.Left
    PickerLabel.Parent = ColorPicker

    local ColorBox = Instance.new("TextButton")
    ColorBox.AnchorPoint = Vector2.new(1, 0.5)
    ColorBox.Position = UDim2.new(1, -12, 0.5, 0)
    ColorBox.Size = UDim2.new(0, 60, 0, 28)
    ColorBox.BackgroundColor3 = default or Color3.fromRGB(255, 255, 255)
    ColorBox.BorderSizePixel = 0
    ColorBox.AutoButtonColor = false
    ColorBox.Text = ""
    ColorBox.Parent = ColorPicker
    Utility:CreateCorner(ColorBox, 6)
    Utility:CreateStroke(ColorBox, Colors.Border, 2)

    local CurrentColor = default or Color3.fromRGB(255, 255, 255)

    -- Простой ColorPicker через циклическое переключение предустановленных цветов
    local PresetColors = {
        Color3.fromRGB(255, 42, 109),  -- Accent
        Color3.fromRGB(255, 0, 0),     -- Red
        Color3.fromRGB(0, 255, 0),     -- Green
        Color3.fromRGB(0, 0, 255),     -- Blue
        Color3.fromRGB(255, 255, 0),   -- Yellow
        Color3.fromRGB(255, 165, 0),   -- Orange
        Color3.fromRGB(128, 0, 128),   -- Purple
        Color3.fromRGB(0, 255, 255),   -- Cyan
        Color3.fromRGB(255, 255, 255), -- White
        Color3.fromRGB(0, 0, 0)        -- Black
    }

    local ColorIndex = 1

    ColorBox.MouseButton1Click:Connect(function()
        ColorIndex = ColorIndex % #PresetColors + 1
        CurrentColor = PresetColors[ColorIndex]
        ColorBox.BackgroundColor3 = CurrentColor

        if callback then
            pcall(callback, CurrentColor)
        end
    end)

    table.insert(tab.Elements, ColorPicker)

    return {
        SetColor = function(color)
            CurrentColor = color
            ColorBox.BackgroundColor3 = color
        end,
        GetColor = function()
            return CurrentColor
        end
    }
end

-- Создание Label (текстовая метка)
function Library:CreateLabel(tab, text)
    local Label = Instance.new("TextLabel")
    Label.Name = "Label"
    Label.Size = UDim2.new(1, 0, 0, 30)
    Label.BackgroundColor3 = Colors.Card
    Label.BorderSizePixel = 0
    Label.Text = text
    Label.TextColor3 = Colors.TextSecondary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextWrapped = true
    Label.LayoutOrder = #tab.Elements
    Utility:CreateCorner(Label, 8)
    Utility:CreatePadding(Label, 10)

    table.insert(tab.Elements, Label)

    return {
        SetText = function(newText)
            Label.Text = newText
        end
    }
end

-- Создание вкладок
local ESPTab = Library:CreateTab("ESP", "👁️")
local FarmTab = Library:CreateTab("Фарм", "⚙️")
local ModTab = Library:CreateTab("Моды", "🛠️")
local CombatTab = Library:CreateTab("Бой", "⚔️")
local VisualTab = Library:CreateTab("Визуал", "🎨")
local ConfigTab = Library:CreateTab("Конфиг", "💾")

-- ==================== ВКЛАДКА ESP ====================
Library:CreateSection(ESPTab, "👁️ Основные настройки")
Library:CreateToggle(ESPTab, "Мастер ESP", _G.VDSettings.ESP.Master, function(v)
    _G.VDSettings.ESP.Master = v
    print("Master ESP:", v)
end)

Library:CreateSection(ESPTab, "👤 Игроки")
Library:CreateToggle(ESPTab, "Отслеживание убийцы", _G.VDSettings.ESP.Players.Killers.Enabled, function(v)
    _G.VDSettings.ESP.Players.Killers.Enabled = v
end)

Library:CreateToggle(ESPTab, "Подсветка убийцы", _G.VDSettings.ESP.Players.Killers.Aura, function(v)
    _G.VDSettings.ESP.Players.Killers.Aura = v
end)

Library:CreateToggle(ESPTab, "Дистанция убийцы", _G.VDSettings.ESP.Players.Killers.Distance, function(v)
    _G.VDSettings.ESP.Players.Killers.Distance = v
end)

Library:CreateToggle(ESPTab, "Отслеживание выживших", _G.VDSettings.ESP.Players.Survivors.Enabled, function(v)
    _G.VDSettings.ESP.Players.Survivors.Enabled = v
end)

Library:CreateToggle(ESPTab, "Здоровье выживших", _G.VDSettings.ESP.Players.Survivors.Health, function(v)
    _G.VDSettings.ESP.Players.Survivors.Health = v
end)

Library:CreateToggle(ESPTab, "Счетчик крюков", _G.VDSettings.ESP.Players.Survivors.Hooks, function(v)
    _G.VDSettings.ESP.Players.Survivors.Hooks = v
end)

Library:CreateSection(ESPTab, "🔧 Объекты")
Library:CreateToggle(ESPTab, "Генераторы", _G.VDSettings.ESP.Objects.Generators.Enabled, function(v)
    _G.VDSettings.ESP.Objects.Generators.Enabled = v
end)

Library:CreateToggle(ESPTab, "Прогресс генераторов", _G.VDSettings.ESP.Objects.Generators.Progress, function(v)
    _G.VDSettings.ESP.Objects.Generators.Progress = v
end)

Library:CreateToggle(ESPTab, "ETA генераторов", _G.VDSettings.ESP.Objects.Generators.ETA, function(v)
    _G.VDSettings.ESP.Objects.Generators.ETA = v
end)

Library:CreateToggle(ESPTab, "Крюки", _G.VDSettings.ESP.Objects.Hooks.Enabled, function(v)
    _G.VDSettings.ESP.Objects.Hooks.Enabled = v
end)

Library:CreateToggle(ESPTab, "Паллеты", _G.VDSettings.ESP.Objects.Pallets.Enabled, function(v)
    _G.VDSettings.ESP.Objects.Pallets.Enabled = v
end)

Library:CreateToggle(ESPTab, "Окна", _G.VDSettings.ESP.Objects.Windows.Enabled, function(v)
    _G.VDSettings.ESP.Objects.Windows.Enabled = v
end)

Library:CreateToggle(ESPTab, "Ворота", _G.VDSettings.ESP.Objects.Gates.Enabled, function(v)
    _G.VDSettings.ESP.Objects.Gates.Enabled = v
end)

Library:CreateSection(ESPTab, "⚙️ Настройки ESP")
Library:CreateSelector(ESPTab, "Стиль ESP", {
    "Старый",
    "Стандартный",
    "Компактный",
    "Минимальный",
    "Подсветка"
}, _G.VDSettings.ESP.Settings.Style, function(v)
    _G.VDSettings.ESP.Settings.Style = v
end)

Library:CreateSlider(ESPTab, "Дальность ESP", 100, 2000, _G.VDSettings.ESP.Settings.MaxDistance, "m", function(v)
    _G.VDSettings.ESP.Settings.MaxDistance = v
end)

Library:CreateToggle(ESPTab, "Прозрачность по дистанции", _G.VDSettings.ESP.Settings.DistanceFade, function(v)
    _G.VDSettings.ESP.Settings.DistanceFade = v
end)

Library:CreateToggle(ESPTab, "Трейсеры", _G.VDSettings.ESP.Settings.Tracers, function(v)
    _G.VDSettings.ESP.Settings.Tracers = v
end)

Library:CreateToggle(ESPTab, "Радар-миникарта", _G.VDSettings.ESP.Settings.Radar, function(v)
    _G.VDSettings.ESP.Settings.Radar = v
end)

Library:CreateSection(ESPTab, "🎨 Цвета ESP")
Library:CreateColorPicker(ESPTab, "Цвет убийцы", _G.VDSettings.ESP.Colors.Killer, function(v)
    _G.VDSettings.ESP.Colors.Killer = v
end)

Library:CreateColorPicker(ESPTab, "Выживший (здоров)", _G.VDSettings.ESP.Colors.SurvivorHealthy, function(v)
    _G.VDSettings.ESP.Colors.SurvivorHealthy = v
end)

Library:CreateColorPicker(ESPTab, "Выживший (ранен)", _G.VDSettings.ESP.Colors.SurvivorInjured, function(v)
    _G.VDSettings.ESP.Colors.SurvivorInjured = v
end)

Library:CreateColorPicker(ESPTab, "Генераторы", _G.VDSettings.ESP.Colors.Generators, function(v)
    _G.VDSettings.ESP.Colors.Generators = v
end)

-- ==================== ВКЛАДКА ФАРМ ====================
Library:CreateSection(FarmTab, "⚙️ Автофарм выжившего")
Library:CreateToggle(FarmTab, "Автофарм выжившего", _G.VDSettings.Farm.AutoSurvivor, function(v)
    _G.VDSettings.Farm.AutoSurvivor = v
    print("Auto Survivor Farm:", v)
end)

Library:CreateButton(FarmTab, "Мгновенный побег", function()
    print("Instant escape activated!")
end)

Library:CreateSection(FarmTab, "🎯 Скиллчеки")
Library:CreateToggle(FarmTab, "Авто-скиллчек", _G.VDSettings.Farm.AutoSkillCheck, function(v)
    _G.VDSettings.Farm.AutoSkillCheck = v
end)

Library:CreateSelector(FarmTab, "Режим скиллчека", {
    "Идеальный",
    "Обычный",
    "Гибридный"
}, _G.VDSettings.Farm.SkillCheckMode, function(v)
    _G.VDSettings.Farm.SkillCheckMode = v
end)

Library:CreateSlider(FarmTab, "Шанс идеального", 0, 100, _G.VDSettings.Farm.PerfectChance, "%", function(v)
    _G.VDSettings.Farm.PerfectChance = v
end)

Library:CreateToggle(FarmTab, "No Skill Checks", _G.VDSettings.Farm.NoSkillChecks, function(v)
    _G.VDSettings.Farm.NoSkillChecks = v
end)

Library:CreateButton(FarmTab, "Бафф генератора", function()
    print("Generator buff activated!")
end)

Library:CreateSection(FarmTab, "🔪 Фарм убийцы")
Library:CreateToggle(FarmTab, "Автофарм убийцы", _G.VDSettings.Farm.AutoKiller, function(v)
    _G.VDSettings.Farm.AutoKiller = v
end)

-- ==================== ВКЛАДКА МОДИФИКАТОРЫ ====================
Library:CreateSection(ModTab, "🎮 Движение")
Library:CreateToggle(ModTab, "Буст скорости", _G.VDSettings.Modifiers.SpeedBoost, function(v)
    _G.VDSettings.Modifiers.SpeedBoost = v
end)

Library:CreateSlider(ModTab, "Множитель скорости", 1, 3, _G.VDSettings.Modifiers.SpeedMultiplier, "x", function(v)
    _G.VDSettings.Modifiers.SpeedMultiplier = v
end)

Library:CreateToggle(ModTab, "Авто-лунная походка", _G.VDSettings.Modifiers.AutoMoonwalk, function(v)
    _G.VDSettings.Modifiers.AutoMoonwalk = v
end)

Library:CreateSection(ModTab, "💊 Лечение")
Library:CreateToggle(ModTab, "Мгновенное лечение", _G.VDSettings.Modifiers.InstantHeal, function(v)
    _G.VDSettings.Modifiers.InstantHeal = v
end)

Library:CreateButton(ModTab, "Мгновенная перевязка", function()
    print("Instant bandage activated!")
end)

Library:CreateSection(ModTab, "🎨 Визуальные эффекты")
Library:CreateToggle(ModTab, "Радужный персонаж", _G.VDSettings.Modifiers.RainbowCharacter, function(v)
    _G.VDSettings.Modifiers.RainbowCharacter = v
end)

Library:CreateSection(ModTab, "🚪 Паллеты и окна")
Library:CreateButton(ModTab, "Сбросить все паллеты", function()
    print("Dropping all pallets...")
end)

Library:CreateButton(ModTab, "Блокировка окон", function()
    print("Blocking windows...")
end)

-- ==================== ВКЛАДКА БОЙ ====================
Library:CreateSection(CombatTab, "🛡️ Автопарри")
Library:CreateToggle(CombatTab, "Автопарри", _G.VDSettings.Combat.AutoParry, function(v)
    _G.VDSettings.Combat.AutoParry = v
end)

Library:CreateSlider(CombatTab, "Дальность парирования", 6, 25, _G.VDSettings.Combat.ParryRange, "m", function(v)
    _G.VDSettings.Combat.ParryRange = v
end)

Library:CreateSelector(CombatTab, "Задержка реакции", {
    "Мгновенная",
    "50ms",
    "100ms",
    "150ms",
    "200ms"
}, _G.VDSettings.Combat.ParryDelay, function(v)
    _G.VDSettings.Combat.ParryDelay = v
end)

Library:CreateSection(CombatTab, "🎯 Аимбот")
Library:CreateToggle(CombatTab, "Общий аимбот", _G.VDSettings.Combat.GeneralAimbot, function(v)
    _G.VDSettings.Combat.GeneralAimbot = v
end)

Library:CreateSlider(CombatTab, "FOV радиус", 50, 500, _G.VDSettings.Combat.AimbotFOV, "px", function(v)
    _G.VDSettings.Combat.AimbotFOV = v
end)

Library:CreateToggle(CombatTab, "Показывать FOV круг", _G.VDSettings.Combat.ShowFOVCircle, function(v)
    _G.VDSettings.Combat.ShowFOVCircle = v
end)

Library:CreateSection(CombatTab, "🎭 Маскированные")
Library:CreateButton(CombatTab, "Рихтер - Скрытность", function()
    print("Richter buff activated")
end)

Library:CreateButton(CombatTab, "Алекс - Бензопила", function()
    print("Alex buff activated")
end)

Library:CreateButton(CombatTab, "Брэндон - Скорость", function()
    print("Brandon buff activated")
end)

-- ==================== ВКЛАДКА ВИЗУАЛЫ ====================
Library:CreateSection(VisualTab, "🎨 Графика")
Library:CreateToggle(VisualTab, "RTX Graphics", _G.VDSettings.Visuals.RTX, function(v)
    _G.VDSettings.Visuals.RTX = v
end)

Library:CreateToggle(VisualTab, "Full Bright", _G.VDSettings.Visuals.FullBright, function(v)
    _G.VDSettings.Visuals.FullBright = v
    
    -- Реализация Full Bright
    if v then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 100
        game:GetService("Lighting").GlobalShadows = true
    end
end)

Library:CreateToggle(VisualTab, "No Fog", _G.VDSettings.Visuals.NoFog, function(v)
    _G.VDSettings.Visuals.NoFog = v
    
    if v then
        game:GetService("Lighting").FogEnd = 100000
    else
        game:GetService("Lighting").FogEnd = 100
    end
end)

Library:CreateSection(VisualTab, "🎯 Прицел")
Library:CreateToggle(VisualTab, "Прицел", _G.VDSettings.Visuals.Crosshair, function(v)
    _G.VDSettings.Visuals.Crosshair = v
end)

Library:CreateSlider(VisualTab, "Размер прицела", 5, 30, _G.VDSettings.Visuals.CrosshairSize, "px", function(v)
    _G.VDSettings.Visuals.CrosshairSize = v
end)

-- ==================== ВКЛАДКА КОНФИГ ====================
Library:CreateSection(ConfigTab, "🔑 Премиум статус")
Library:CreateLabel(ConfigTab, _G.VDSettings.Config.Premium and "✓ ПРЕМИУМ АКТИВИРОВАН" or "✗ Бесплатная версия")

Library:CreateSection(ConfigTab, "💾 Управление конфигами")
Library:CreateButton(ConfigTab, "Сохранить конфиг", function()
    local success, result = pcall(function()
        if writefile then
            local json = HttpService:JSONEncode(_G.VDSettings)
            writefile("VDHub_Config.json", json)
            return "✓ Конфиг сохранен"
        else
            return "✗ writefile не поддерживается"
        end
    end)
    print(success and result or "✗ Ошибка сохранения")
end)

Library:CreateButton(ConfigTab, "Загрузить конфиг", function()
    local success, result = pcall(function()
        if readfile and isfile then
            if isfile("VDHub_Config.json") then
                local json = readfile("VDHub_Config.json")
                _G.VDSettings = HttpService:JSONDecode(json)
                return "✓ Конфиг загружен"
            else
                return "✗ Файл не найден"
            end
        else
            return "✗ readfile не поддерживается"
        end
    end)
    print(success and result or "✗ Ошибка загрузки")
end)

Library:CreateSection(ConfigTab, "⚠️ Управление")
Library:CreateButton(ConfigTab, "Сброс настроек", function()
    _G.VDSettings = nil
    print("✓ Настройки сброшены")
end)

Library:CreateButton(ConfigTab, "Выгрузить скрипт", function()
    ScreenGui:Destroy()
    print("✓ Скрипт выгружен")
end)

-- Делаем GUI перетаскиваемым
Utility:MakeDraggable(MainContainer, Header)

-- Открытие первой вкладки
Library:SelectTab(ESPTab)

-- Анимация появления
MainContainer.Size = UDim2.new(0, 0, 0, 0)
Utility:Tween(MainContainer, {Size = UDim2.new(0, 420, 0, 580)}, 0.5)

-- Управление видимостью меню
local MenuVisible = true

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == _G.VDSettings.Config.MenuKey then
        MenuVisible = not MenuVisible
        ScreenGui.Enabled = MenuVisible
    end
end)

-- Уведомление о загрузке
task.spawn(function()
    local Notification = Instance.new("Frame")
    Notification.AnchorPoint = Vector2.new(0.5, 0)
    Notification.Position = UDim2.new(0.5, 0, 0, -60)
    Notification.Size = UDim2.new(0, 320, 0, 50)
    Notification.BackgroundColor3 = Colors.Card
    Notification.BorderSizePixel = 0
    Notification.Parent = ScreenGui
    Utility:CreateCorner(Notification, 10)
    Utility:CreateStroke(Notification, Colors.Success, 2)

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, 0, 1, 0)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = "✓ Violence District Hub загружен"
    NotifText.TextColor3 = Colors.Success
    NotifText.Font = Enum.Font.GothamBold
    NotifText.TextSize = 14
    NotifText.Parent = Notification

    Utility:Tween(Notification, {Position = UDim2.new(0.5, 0, 0, 20)}, 0.5)
    task.wait(3)
    Utility:Tween(Notification, {Position = UDim2.new(0.5, 0, 0, -60)}, 0.5)
    task.wait(0.5)
    Notification:Destroy()
end)

print("=================================")
print("Violence District Hub v3.0")
print("Загружен успешно!")
print("Нажмите K для открытия меню")
print("=================================")
