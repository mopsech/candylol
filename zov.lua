-- Violence District Mobile GUI | Full Professional Recode
-- Черно-белая расцветка с Icon Pack
-- Полнофункциональный ColorPicker и выпадающие списки

--[[
    VIOLENCE DISTRICT HUB v4.0
    Профессиональная версия для мобильных устройств
    Черно-белый дизайн с Material Icons
]]

-- Сервисы
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Глобальные настройки
_G.VDSettings = _G.VDSettings or {
    ESP = {
        Master = false,
        Players = {
            Killers = { Enabled = true, Aura = true, Distance = true, Name = true },
            Survivors = { Enabled = true, Aura = true, Health = true, Hooks = true, Name = true }
        },
        Objects = {
            Generators = { Enabled = true, Progress = true, RepairSpeed = true, ETA = true },
            Hooks = { Enabled = false },
            Pallets = { Enabled = false },
            Windows = { Enabled = false },
            Gates = { Enabled = true }
        },
        Settings = {
            Style = "Standard",
            MaxDistance = 1000,
            DistanceFade = false,
            Tracers = false
        },
        Colors = {
            Killer = Color3.fromRGB(255, 255, 255),
            SurvivorHealthy = Color3.fromRGB(200, 200, 200),
            SurvivorInjured = Color3.fromRGB(150, 150, 150),
            Generators = Color3.fromRGB(220, 220, 220)
        }
    },
    Farm = {
        AutoSurvivor = false,
        AutoSkillCheck = false,
        SkillCheckMode = "Perfect",
        PerfectChance = 100,
        NoSkillChecks = false
    },
    Modifiers = {
        SpeedBoost = false,
        SpeedMultiplier = 1.5,
        InstantHeal = false,
        AutoMoonwalk = false
    },
    Combat = {
        AutoParry = false,
        ParryRange = 15,
        ParryDelay = "Instant",
        GeneralAimbot = false,
        AimbotFOV = 200
    },
    Visuals = {
        RTX = false,
        FullBright = false,
        NoFog = false,
        Crosshair = false
    },
    Config = {
        Premium = false,
        MenuKey = Enum.KeyCode.K
    }
}

-- Черно-белая цветовая схема
local Theme = {
    Background = Color3.fromRGB(15, 15, 15),
    Card = Color3.fromRGB(25, 25, 25),
    CardHover = Color3.fromRGB(35, 35, 35),
    Primary = Color3.fromRGB(255, 255, 255),
    Secondary = Color3.fromRGB(180, 180, 180),
    Tertiary = Color3.fromRGB(120, 120, 120),
    Border = Color3.fromRGB(45, 45, 45),
    Disabled = Color3.fromRGB(60, 60, 60)
}

-- Material Design Icons (rbxassetid)
local Icons = {
    Eye = "rbxassetid://3926305904",
    Farm = "rbxassetid://3926307971",
    Settings = "rbxassetid://3926305904",
    Combat = "rbxassetid://3926305904",
    Palette = "rbxassetid://3926305904",
    Save = "rbxassetid://3926305904",
    Close = "rbxassetid://3926305904",
    Check = "rbxassetid://3926305904",
    ChevronDown = "rbxassetid://3926305904",
    ChevronRight = "rbxassetid://3926305904",
    Circle = "rbxassetid://3926305904"
}

-- Утилиты
local Utility = {}

function Utility:Tween(object, properties, duration, style, direction)
    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            duration or 0.2,
            style or Enum.EasingStyle.Quad,
            direction or Enum.EasingDirection.Out
        ),
        properties
    )
    tween:Play()
    return tween
end

function Utility:MakeDraggable(frame, handle)
    local dragging, dragInput, mousePos, framePos
    handle = handle or frame

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Utility:Corner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

function Utility:Stroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

function Utility:Padding(parent, all)
    local padding = Instance.new("UIPadding")
    if type(all) == "table" then
        padding.PaddingTop = UDim.new(0, all.Top or 0)
        padding.PaddingBottom = UDim.new(0, all.Bottom or 0)
        padding.PaddingLeft = UDim.new(0, all.Left or 0)
        padding.PaddingRight = UDim.new(0, all.Right or 0)
    else
        padding.PaddingTop = UDim.new(0, all or 0)
        padding.PaddingBottom = UDim.new(0, all or 0)
        padding.PaddingLeft = UDim.new(0, all or 0)
        padding.PaddingRight = UDim.new(0, all or 0)
    end
    padding.Parent = parent
    return padding
end

function Utility:Icon(parent, iconId, size)
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, size or 20, 0, size or 20)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = Theme.Primary
    icon.Parent = parent
    return icon
end

-- Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ViolenceDistrictHubV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

-- Главный контейнер (уменьшенный размер)
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 360, 0, 480)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipDescendants = true
Main.Parent = ScreenGui
Utility:Corner(Main, 12)
Utility:Stroke(Main, Theme.Border, 1)

-- Тень
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
Shadow.ZIndex = -1
Shadow.Parent = Main

-- Топ бар
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Theme.Card
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopBarBottom = Instance.new("Frame")
TopBarBottom.Size = UDim2.new(1, 0, 0, 12)
TopBarBottom.Position = UDim2.new(0, 0, 1, -12)
TopBarBottom.BackgroundColor3 = Theme.Card
TopBarBottom.BorderSizePixel = 0
TopBarBottom.Parent = TopBar

-- Логотип текстовый
local Logo = Instance.new("TextLabel")
Logo.Position = UDim2.new(0, 12, 0, 0)
Logo.Size = UDim2.new(0, 150, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "VIOLENCE"
Logo.TextColor3 = Theme.Primary
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 16
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

-- Версия
local Version = Instance.new("TextLabel")
Version.Position = UDim2.new(0, 80, 0, 0)
Version.Size = UDim2.new(0, 80, 1, 0)
Version.BackgroundTransparency = 1
Version.Text = "v4.0"
Version.TextColor3 = Theme.Tertiary
Version.Font = Enum.Font.Gotham
Version.TextSize = 10
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = TopBar

-- Кнопка закрытия
local CloseBtn = Instance.new("TextButton")
CloseBtn.AnchorPoint = Vector2.new(1, 0.5)
CloseBtn.Position = UDim2.new(1, -8, 0.5, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.BackgroundColor3 = Theme.Card
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = ""
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar
Utility:Corner(CloseBtn, 6)

local CloseIcon = Instance.new("TextLabel")
CloseIcon.Size = UDim2.new(1, 0, 1, 0)
CloseIcon.BackgroundTransparency = 1
CloseIcon.Text = "×"
CloseIcon.TextColor3 = Theme.Primary
CloseIcon.Font = Enum.Font.GothamBold
CloseIcon.TextSize = 20
CloseIcon.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    Utility:Tween(CloseBtn, {BackgroundColor3 = Theme.CardHover})
end)

CloseBtn.MouseLeave:Connect(function()
    Utility:Tween(CloseBtn, {BackgroundColor3 = Theme.Card})
end)

CloseBtn.MouseButton1Click:Connect(function()
    Utility:Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    task.wait(0.3)
    ScreenGui.Enabled = false
end)

-- Контент область
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Position = UDim2.new(0, 0, 0, 45)
Content.Size = UDim2.new(1, 0, 1, -100)
Content.BackgroundTransparency = 1
Content.Parent = Main

-- ScrollingFrame для контента
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 2
ContentScroll.ScrollBarImageColor3 = Theme.Primary
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = Content

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 6)
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Parent = ContentScroll

Utility:Padding(ContentScroll, {Left = 8, Right = 8, Top = 8, Bottom = 8})

-- Нижняя панель табов
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.Position = UDim2.new(0, 0, 1, -55)
TabBar.Size = UDim2.new(1, 0, 0, 55)
TabBar.BackgroundColor3 = Theme.Card
TabBar.BorderSizePixel = 0
TabBar.Parent = Main

local TabBarTop = Instance.new("Frame")
TabBarTop.Size = UDim2.new(1, 0, 0, 12)
TabBarTop.BackgroundColor3 = Theme.Card
TabBarTop.BorderSizePixel = 0
TabBarTop.Parent = TabBar

local TabBarDivider = Instance.new("Frame")
TabBarDivider.Size = UDim2.new(1, 0, 0, 1)
TabBarDivider.BackgroundColor3 = Theme.Border
TabBarDivider.BorderSizePixel = 0
TabBarDivider.Parent = TabBar

local TabContainer = Instance.new("Frame")
TabContainer.Position = UDim2.new(0, 8, 0, 6)
TabContainer.Size = UDim2.new(1, -16, 1, -12)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = TabBar

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.VerticalAlignment = Enum.VerticalAlignment.Center
TabList.Padding = UDim.new(0, 4)
TabList.Parent = TabContainer

-- Переменные
local CurrentTab = nil
local Tabs = {}
local ActiveDropdown = nil

-- Библиотека UI
local Library = {}

-- Создание вкладки
function Library:CreateTab(name, icon)
    local Tab = {}
    Tab.Name = name
    Tab.Elements = {}

    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name
    TabBtn.Size = UDim2.new(0, 52, 0, 45)
    TabBtn.BackgroundColor3 = Theme.Background
    TabBtn.BorderSizePixel = 0
    TabBtn.AutoButtonColor = false
    TabBtn.Text = ""
    TabBtn.Parent = TabContainer
    Utility:Corner(TabBtn, 8)

    local TabIcon = Instance.new("TextLabel")
    TabIcon.Position = UDim2.new(0, 0, 0, 4)
    TabIcon.Size = UDim2.new(1, 0, 0, 20)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Text = icon
    TabIcon.TextColor3 = Theme.Secondary
    TabIcon.Font = Enum.Font.GothamBold
    TabIcon.TextSize = 16
    TabIcon.Parent = TabBtn

    local TabLabel = Instance.new("TextLabel")
    TabLabel.Position = UDim2.new(0, 0, 0, 26)
    TabLabel.Size = UDim2.new(1, 0, 0, 14)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Text = name
    TabLabel.TextColor3 = Theme.Secondary
    TabLabel.Font = Enum.Font.Gotham
    TabLabel.TextSize = 8
    TabLabel.Parent = TabBtn

    local Indicator = Instance.new("Frame")
    Indicator.AnchorPoint = Vector2.new(0.5, 1)
    Indicator.Position = UDim2.new(0.5, 0, 1, -2)
    Indicator.Size = UDim2.new(0.6, 0, 0, 2)
    Indicator.BackgroundColor3 = Theme.Primary
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = TabBtn
    Utility:Corner(Indicator, 1)

    Tab.Button = TabBtn
    Tab.Icon = TabIcon
    Tab.Label = TabLabel
    Tab.Indicator = Indicator

    TabBtn.MouseButton1Click:Connect(function()
        Library:SelectTab(Tab)
    end)

    TabBtn.MouseEnter:Connect(function()
        if CurrentTab ~= Tab then
            Utility:Tween(TabBtn, {BackgroundColor3 = Theme.CardHover})
        end
    end)

    TabBtn.MouseLeave:Connect(function()
        if CurrentTab ~= Tab then
            Utility:Tween(TabBtn, {BackgroundColor3 = Theme.Background})
        end
    end)

    table.insert(Tabs, Tab)
    return Tab
end

-- Выбор вкладки
function Library:SelectTab(tab)
    if CurrentTab then
        Utility:Tween(CurrentTab.Button, {BackgroundColor3 = Theme.Background})
        Utility:Tween(CurrentTab.Icon, {TextColor3 = Theme.Secondary})
        Utility:Tween(CurrentTab.Label, {TextColor3 = Theme.Secondary})
        CurrentTab.Indicator.Visible = false
    end

    CurrentTab = tab
    Utility:Tween(tab.Button, {BackgroundColor3 = Theme.Card})
    Utility:Tween(tab.Icon, {TextColor3 = Theme.Primary})
    Utility:Tween(tab.Label, {TextColor3 = Theme.Primary})
    tab.Indicator.Visible = true

    -- Очистка контента
    for _, child in pairs(ContentScroll:GetChildren()) do
        if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end

    -- Загрузка элементов
    for _, element in pairs(tab.Elements) do
        element.Parent = ContentScroll
    end

    ContentScroll.CanvasPosition = Vector2.new(0, 0)
end

-- Создание секции
function Library:CreateSection(tab, text)
    local Section = Instance.new("Frame")
    Section.Name = "Section"
    Section.Size = UDim2.new(1, 0, 0, 28)
    Section.BackgroundTransparency = 1
    Section.LayoutOrder = #tab.Elements

    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, 0, 1, 0)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Text = text
    SectionLabel.TextColor3 = Theme.Primary
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextSize = 11
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.Parent = Section
    Utility:Padding(SectionLabel, {Left = 4})

    table.insert(tab.Elements, Section)
    return Section
end

-- Создание Toggle
function Library:CreateToggle(tab, text, default, callback)
    local Toggle = Instance.new("Frame")
    Toggle.Name = "Toggle"
    Toggle.Size = UDim2.new(1, 0, 0, 38)
    Toggle.BackgroundColor3 = Theme.Card
    Toggle.BorderSizePixel = 0
    Toggle.LayoutOrder = #tab.Elements
    Utility:Corner(Toggle, 6)

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.Primary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.Parent = Toggle

    local Switch = Instance.new("TextButton")
    Switch.AnchorPoint = Vector2.new(1, 0.5)
    Switch.Position = UDim2.new(1, -10, 0.5, 0)
    Switch.Size = UDim2.new(0, 42, 0, 22)
    Switch.BackgroundColor3 = Theme.Disabled
    Switch.BorderSizePixel = 0
    Switch.AutoButtonColor = false
    Switch.Text = ""
    Switch.Parent = Toggle
    Utility:Corner(Switch, 11)

    local Knob = Instance.new("Frame")
    Knob.Position = UDim2.new(0, 2, 0.5, 0)
    Knob.AnchorPoint = Vector2.new(0, 0.5)
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.BackgroundColor3 = Theme.Primary
    Knob.BorderSizePixel = 0
    Knob.Parent = Switch
    Utility:Corner(Knob, 9)

    local State = default or false

    local function Update()
        if State then
            Utility:Tween(Switch, {BackgroundColor3 = Theme.Primary})
            Utility:Tween(Knob, {
                Position = UDim2.new(1, -20, 0.5, 0),
                BackgroundColor3 = Theme.Background
            })
        else
            Utility:Tween(Switch, {BackgroundColor3 = Theme.Disabled})
            Utility:Tween(Knob, {
                Position = UDim2.new(0, 2, 0.5, 0),
                BackgroundColor3 = Theme.Primary
            })
        end

        if callback then
            pcall(callback, State)
        end
    end

    if State then
        Switch.BackgroundColor3 = Theme.Primary
        Knob.Position = UDim2.new(1, -20, 0.5, 0)
        Knob.BackgroundColor3 = Theme.Background
    end

    Switch.MouseButton1Click:Connect(function()
        State = not State
        Update()
    end)

    table.insert(tab.Elements, Toggle)

    return {
        Set = function(val)
            State = val
            Update()
        end,
        Get = function()
            return State
        end
    }
end

-- Создание Slider
function Library:CreateSlider(tab, text, min, max, default, suffix, callback)
    local Slider = Instance.new("Frame")
    Slider.Name = "Slider"
    Slider.Size = UDim2.new(1, 0, 0, 48)
    Slider.BackgroundColor3 = Theme.Card
    Slider.BorderSizePixel = 0
    Slider.LayoutOrder = #tab.Elements
    Utility:Corner(Slider, 6)

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.new(0, 10, 0, 6)
    Label.Size = UDim2.new(0.6, 0, 0, 14)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.Primary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Slider

    local Value = Instance.new("TextLabel")
    Value.Position = UDim2.new(0.6, 0, 0, 6)
    Value.Size = UDim2.new(0.4, -10, 0, 14)
    Value.BackgroundTransparency = 1
    Value.Text = tostring(default) .. (suffix or "")
    Value.TextColor3 = Theme.Primary
    Value.Font = Enum.Font.GothamBold
    Value.TextSize = 11
    Value.TextXAlignment = Enum.TextXAlignment.Right
    Value.Parent = Slider

    local Track = Instance.new("Frame")
    Track.Position = UDim2.new(0, 10, 1, -18)
    Track.Size = UDim2.new(1, -20, 0, 4)
    Track.BackgroundColor3 = Theme.Disabled
    Track.BorderSizePixel = 0
    Track.Parent = Slider
    Utility:Corner(Track, 2)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Primary
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    Utility:Corner(Fill, 2)

    local Thumb = Instance.new("Frame")
    Thumb.AnchorPoint = Vector2.new(0.5, 0.5)
    Thumb.Position = UDim2.new(1, 0, 0.5, 0)
    Thumb.Size = UDim2.new(0, 12, 0, 12)
    Thumb.BackgroundColor3 = Theme.Primary
    Thumb.BorderSizePixel = 0
    Thumb.Parent = Fill
    Utility:Corner(Thumb, 6)

    local CurrentValue = default
    local Dragging = false

    local function Update(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        CurrentValue = math.floor(min + (max - min) * pos)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Value.Text = tostring(CurrentValue) .. (suffix or "")

        if callback then
            pcall(callback, CurrentValue)
        end
    end

    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            Update(input)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)

    table.insert(tab.Elements, Slider)

    return {
        Set = function(val)
            CurrentValue = math.clamp(val, min, max)
            local pos = (CurrentValue - min) / (max - min)
            Fill.Size = UDim2.new(pos, 0, 1, 0)
            Value.Text = tostring(CurrentValue) .. (suffix or "")
        end,
        Get = function()
            return CurrentValue
        end
    }
end

-- Создание Button
function Library:CreateButton(tab, text, callback)
    local Button = Instance.new("TextButton")
    Button.Name = "Button"
    Button.Size = UDim2.new(1, 0, 0, 36)
    Button.BackgroundColor3 = Theme.Card
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Text = text
    Button.TextColor3 = Theme.Primary
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 12
    Button.LayoutOrder = #tab.Elements
    Utility:Corner(Button, 6)
    Utility:Stroke(Button, Theme.Border, 1)

    Button.MouseEnter:Connect(function()
        Utility:Tween(Button, {BackgroundColor3 = Theme.CardHover})
    end)

    Button.MouseLeave:Connect(function()
        Utility:Tween(Button, {BackgroundColor3 = Theme.Card})
    end)

    Button.MouseButton1Click:Connect(function()
        Utility:Tween(Button, {BackgroundColor3 = Theme.Background}, 0.1)
        task.wait(0.1)
        Utility:Tween(Button, {BackgroundColor3 = Theme.Card}, 0.1)

        if callback then
            pcall(callback)
        end
    end)

    table.insert(tab.Elements, Button)
    return Button
end

-- Создание Dropdown (выпадающий список)
function Library:CreateDropdown(tab, text, options, default, callback)
    local Dropdown = Instance.new("Frame")
    Dropdown.Name = "Dropdown"
    Dropdown.Size = UDim2.new(1, 0, 0, 38)
    Dropdown.BackgroundColor3 = Theme.Card
    Dropdown.BorderSizePixel = 0
    Dropdown.ClipDescendants = false
    Dropdown.LayoutOrder = #tab.Elements
    Utility:Corner(Dropdown, 6)

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.Primary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Dropdown

    local CurrentIndex = 1
    for i, v in ipairs(options) do
        if v == default then
            CurrentIndex = i
            break
        end
    end

    local Selected = Instance.new("TextButton")
    Selected.Position = UDim2.new(0.45, 0, 0.5, 0)
    Selected.AnchorPoint = Vector2.new(0, 0.5)
    Selected.Size = UDim2.new(0.5, -10, 0, 26)
    Selected.BackgroundColor3 = Theme.Background
    Selected.BorderSizePixel = 0
    Selected.AutoButtonColor = false
    Selected.Text = ""
    Selected.Parent = Dropdown
    Utility:Corner(Selected, 5)
    Utility:Stroke(Selected, Theme.Border, 1)

    local SelectedText = Instance.new("TextLabel")
    SelectedText.Position = UDim2.new(0, 8, 0, 0)
    SelectedText.Size = UDim2.new(1, -24, 1, 0)
    SelectedText.BackgroundTransparency = 1
    SelectedText.Text = options[CurrentIndex]
    SelectedText.TextColor3 = Theme.Primary
    SelectedText.Font = Enum.Font.Gotham
    SelectedText.TextSize = 10
    SelectedText.TextXAlignment = Enum.TextXAlignment.Left
    SelectedText.TextTruncate = Enum.TextTruncate.AtEnd
    SelectedText.Parent = Selected

    local Arrow = Instance.new("TextLabel")
    Arrow.AnchorPoint = Vector2.new(1, 0.5)
    Arrow.Position = UDim2.new(1, -6, 0.5, 0)
    Arrow.Size = UDim2.new(0, 12, 0, 12)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = Theme.Secondary
    Arrow.Font = Enum.Font.GothamBold
    Arrow.TextSize = 8
    Arrow.Parent = Selected

    -- Выпадающий список
    local DropList = Instance.new("Frame")
    DropList.Position = UDim2.new(0.45, 0, 1, 4)
    DropList.Size = UDim2.new(0.5, -10, 0, 0)
    DropList.BackgroundColor3 = Theme.Card
    DropList.BorderSizePixel = 0
    DropList.Visible = false
    DropList.ZIndex = 10
    DropList.Parent = Dropdown
    Utility:Corner(DropList, 5)
    Utility:Stroke(DropList, Theme.Border, 1)

    local DropScroll = Instance.new("ScrollingFrame")
    DropScroll.Size = UDim2.new(1, 0, 1, 0)
    DropScroll.BackgroundTransparency = 1
    DropScroll.BorderSizePixel = 0
    DropScroll.ScrollBarThickness = 2
    DropScroll.ScrollBarImageColor3 = Theme.Primary
    DropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    DropScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    DropScroll.Parent = DropList

    local DropLayout = Instance.new("UIListLayout")
    DropLayout.Padding = UDim.new(0, 2)
    DropLayout.Parent = DropScroll

    Utility:Padding(DropScroll, 4)

    local IsOpen = false

    local function Toggle()
        IsOpen = not IsOpen

        if IsOpen then
            if ActiveDropdown and ActiveDropdown ~= DropList then
                ActiveDropdown.Visible = false
            end
            ActiveDropdown = DropList

            local itemHeight = 28
            local maxHeight = math.min(#options * itemHeight + 8, 150)
            DropList.Size = UDim2.new(0.5, -10, 0, maxHeight)
            DropList.Visible = true
            Utility:Tween(Arrow, {Rotation = 180})
        else
            DropList.Visible = false
            Utility:Tween(Arrow, {Rotation = 0})
            ActiveDropdown = nil
        end
    end

    Selected.MouseButton1Click:Connect(Toggle)

    -- Создание опций
    for i, option in ipairs(options) do
        local Option = Instance.new("TextButton")
        Option.Size = UDim2.new(1, 0, 0, 26)
        Option.BackgroundColor3 = i == CurrentIndex and Theme.Background or Theme.Card
        Option.BorderSizePixel = 0
        Option.AutoButtonColor = false
        Option.Text = option
        Option.TextColor3 = Theme.Primary
        Option.Font = Enum.Font.Gotham
        Option.TextSize = 10
        Option.TextXAlignment = Enum.TextXAlignment.Left
        Option.Parent = DropScroll
        Utility:Corner(Option, 4)
        Utility:Padding(Option, {Left = 8})

        Option.MouseEnter:Connect(function()
            if i ~= CurrentIndex then
                Utility:Tween(Option, {BackgroundColor3 = Theme.CardHover})
            end
        end)

        Option.MouseLeave:Connect(function()
            if i ~= CurrentIndex then
                Utility:Tween(Option, {BackgroundColor3 = Theme.Card})
            end
        end)

        Option.MouseButton1Click:Connect(function()
            -- Сброс предыдущего выбора
            for _, child in pairs(DropScroll:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = Theme.Card
                end
            end

            CurrentIndex = i
            SelectedText.Text = option
            Option.BackgroundColor3 = Theme.Background
            Toggle()

            if callback then
                pcall(callback, option)
            end
        end)
    end

    table.insert(tab.Elements, Dropdown)

    return {
        Set = function(option)
            for i, v in ipairs(options) do
                if v == option then
                    CurrentIndex = i
                    SelectedText.Text = v
                    for _, child in pairs(DropScroll:GetChildren()) do
                        if child:IsA("TextButton") then
                            child.BackgroundColor3 = Theme.Card
                        end
                    end
                    DropScroll:GetChildren()[i].BackgroundColor3 = Theme.Background
                    break
                end
            end
        end,
        Get = function()
            return options[CurrentIndex]
        end
    }
end

-- Создание ColorPicker (полноценный)
function Library:CreateColorPicker(tab, text, default, callback)
    local ColorPicker = Instance.new("Frame")
    ColorPicker.Name = "ColorPicker"
    ColorPicker.Size = UDim2.new(1, 0, 0, 38)
    ColorPicker.BackgroundColor3 = Theme.Card
    ColorPicker.BorderSizePixel = 0
    ColorPicker.ClipDescendants = false
    ColorPicker.LayoutOrder = #tab.Elements
    Utility:Corner(ColorPicker, 6)

    local Label = Instance.new("TextLabel")
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Theme.Primary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ColorPicker

    local ColorBox = Instance.new("TextButton")
    ColorBox.AnchorPoint = Vector2.new(1, 0.5)
    ColorBox.Position = UDim2.new(1, -10, 0.5, 0)
    ColorBox.Size = UDim2.new(0, 50, 0, 24)
    ColorBox.BackgroundColor3 = default or Color3.fromRGB(255, 255, 255)
    ColorBox.BorderSizePixel = 0
    ColorBox.AutoButtonColor = false
    ColorBox.Text = ""
    ColorBox.Parent = ColorPicker
    Utility:Corner(ColorBox, 5)
    Utility:Stroke(ColorBox, Theme.Border, 1)

    local CurrentColor = default or Color3.fromRGB(255, 255, 255)

    -- Окно выбора цвета
    local PickerWindow = Instance.new("Frame")
    PickerWindow.AnchorPoint = Vector2.new(0.5, 0)
    PickerWindow.Position = UDim2.new(0.5, 0, 1, 4)
    PickerWindow.Size = UDim2.new(1, 0, 0, 0)
    PickerWindow.BackgroundColor3 = Theme.Card
    PickerWindow.BorderSizePixel = 0
    PickerWindow.Visible = false
    PickerWindow.ZIndex = 100
    PickerWindow.Parent = ColorPicker
    Utility:Corner(PickerWindow, 6)
    Utility:Stroke(PickerWindow, Theme.Border, 1)

    local IsOpen = false
    local CurrentHue = 0
    local CurrentSat = 1
    local CurrentVal = 1

    -- Палитра SV
    local Palette = Instance.new("ImageButton")
    Palette.Position = UDim2.new(0, 10, 0, 10)
    Palette.Size = UDim2.new(1, -50, 0, 150)
    Palette.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    Palette.BorderSizePixel = 0
    Palette.AutoButtonColor = false
    Palette.Parent = PickerWindow
    Utility:Corner(Palette, 5)

    local PaletteGradient = Instance.new("UIGradient")
    PaletteGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }
    PaletteGradient.Rotation = 0
    PaletteGradient.Parent = Palette

    local PaletteOverlay = Instance.new("ImageLabel")
    PaletteOverlay.Size = UDim2.new(1, 0, 1, 0)
    PaletteOverlay.BackgroundTransparency = 1
    PaletteOverlay.Image = "rbxassetid://4155801252"
    PaletteOverlay.ImageColor3 = Color3.fromRGB(0, 0, 0)
    PaletteOverlay.Parent = Palette

    local PaletteCursor = Instance.new("Frame")
    PaletteCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    PaletteCursor.Position = UDim2.new(1, 0, 0, 0)
    PaletteCursor.Size = UDim2.new(0, 8, 0, 8)
    PaletteCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    PaletteCursor.BorderSizePixel = 0
    PaletteCursor.Parent = Palette
    Utility:Corner(PaletteCursor, 4)
    Utility:Stroke(PaletteCursor, Color3.fromRGB(0, 0, 0), 2)

    -- Слайдер Hue
    local HueSlider = Instance.new("ImageButton")
    HueSlider.Position = UDim2.new(1, -30, 0, 10)
    HueSlider.Size = UDim2.new(0, 20, 0, 150)
    HueSlider.BackgroundTransparency = 1
    HueSlider.Image = "rbxassetid://3641079629"
    HueSlider.AutoButtonColor = false
    HueSlider.Parent = PickerWindow
    Utility:Corner(HueSlider, 5)

    local HueCursor = Instance.new("Frame")
    HueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    HueCursor.Position = UDim2.new(0.5, 0, 0, 0)
    HueCursor.Size = UDim2.new(1, 4, 0, 4)
    HueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HueCursor.BorderSizePixel = 0
    HueCursor.Parent = HueSlider
    Utility:Stroke(HueCursor, Color3.fromRGB(0, 0, 0), 2)

    -- Превью цвета
    local Preview = Instance.new("Frame")
    Preview.Position = UDim2.new(0, 10, 0, 170)
    Preview.Size = UDim2.new(1, -20, 0, 30)
    Preview.BackgroundColor3 = CurrentColor
    Preview.BorderSizePixel = 0
    Preview.Parent = PickerWindow
    Utility:Corner(Preview, 5)
    Utility:Stroke(Preview, Theme.Border, 1)

    -- RGB текст
    local RGBLabel = Instance.new("TextLabel")
    RGBLabel.Size = UDim2.new(1, 0, 1, 0)
    RGBLabel.BackgroundTransparency = 1
    RGBLabel.Text = string.format("RGB(%d, %d, %d)", 
        math.floor(CurrentColor.R * 255),
        math.floor(CurrentColor.G * 255),
        math.floor(CurrentColor.B * 255)
    )
    RGBLabel.TextColor3 = Theme.Primary
    RGBLabel.Font = Enum.Font.GothamBold
    RGBLabel.TextSize = 10
    RGBLabel.Parent = Preview

    -- Функции обновления цвета
    local function UpdateColor()
        local hue = CurrentHue / 360
        local color = Color3.fromHSV(hue, CurrentSat, CurrentVal)
        CurrentColor = color
        ColorBox.BackgroundColor3 = color
        Preview.BackgroundColor3 = color
        RGBLabel.Text = string.format("RGB(%d, %d, %d)", 
            math.floor(color.R * 255),
            math.floor(color.G * 255),
            math.floor(color.B * 255)
        )
        Palette.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)

        if callback then
            pcall(callback, color)
        end
    end

    -- Обработка палитры
    local PaletteDragging = false
    Palette.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            PaletteDragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            PaletteDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if PaletteDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local posX = math.clamp((input.Position.X - Palette.AbsolutePosition.X) / Palette.AbsoluteSize.X, 0, 1)
            local posY = math.clamp((input.Position.Y - Palette.AbsolutePosition.Y) / Palette.AbsoluteSize.Y, 0, 1)
            
            CurrentSat = posX
            CurrentVal = 1 - posY
            PaletteCursor.Position = UDim2.new(posX, 0, posY, 0)
            UpdateColor()
        end
    end)

    -- Обработка Hue слайдера
    local HueDragging = false
    HueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            HueDragging = true
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if HueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local posY = math.clamp((input.Position.Y - HueSlider.AbsolutePosition.Y) / HueSlider.AbsoluteSize.Y, 0, 1)
            CurrentHue = posY * 360
            HueCursor.Position = UDim2.new(0.5, 0, posY, 0)
            UpdateColor()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            HueDragging = false
        end
    end)

    -- Открытие/закрытие
    ColorBox.MouseButton1Click:Connect(function()
        IsOpen = not IsOpen
        if IsOpen then
            if ActiveDropdown then
                ActiveDropdown.Visible = false
                ActiveDropdown = nil
            end
            PickerWindow.Size = UDim2.new(1, 0, 0, 210)
            PickerWindow.Visible = true
        else
            PickerWindow.Visible = false
        end
    end)

    table.insert(tab.Elements, ColorPicker)

    return {
        Set = function(color)
            CurrentColor = color
            ColorBox.BackgroundColor3 = color
            Preview.BackgroundColor3 = color
            
            local h, s, v = color:ToHSV()
            CurrentHue = h * 360
            CurrentSat = s
            CurrentVal = v
            
            HueCursor.Position = UDim2.new(0.5, 0, h, 0)
            PaletteCursor.Position = UDim2.new(s, 0, 1 - v, 0)
            Palette.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        end,
        Get = function()
            return CurrentColor
        end
    }
end

-- Создание Label
function Library:CreateLabel(tab, text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 28)
    Label.BackgroundColor3 = Theme.Card
    Label.BorderSizePixel = 0
    Label.Text = text
    Label.TextColor3 = Theme.Secondary
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 10
    Label.TextWrapped = true
    Label.LayoutOrder = #tab.Elements
    Utility:Corner(Label, 6)
    Utility:Padding(Label, 8)

    table.insert(tab.Elements, Label)

    return {
        SetText = function(newText)
            Label.Text = newText
        end
    }
end

-- Создание вкладок
local ESPTab = Library:CreateTab("ESP", "👁️")
local FarmTab = Library:CreateTab("Farm", "⚙️")
local ModTab = Library:CreateTab("Mods", "🛠️")
local CombatTab = Library:CreateTab("Combat", "⚔️")
local VisualTab = Library:CreateTab("Visual", "🎨")
local ConfigTab = Library:CreateTab("Config", "💾")

-- ==================== ВКЛАДКА ESP ====================
Library:CreateSection(ESPTab, "ОСНОВНЫЕ НАСТРОЙКИ")
Library:CreateToggle(ESPTab, "Мастер ESP", _G.VDSettings.ESP.Master, function(v)
    _G.VDSettings.ESP.Master = v
end)

Library:CreateSection(ESPTab, "ИГРОКИ")
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

Library:CreateSection(ESPTab, "ОБЪЕКТЫ")
Library:CreateToggle(ESPTab, "Генераторы", _G.VDSettings.ESP.Objects.Generators.Enabled, function(v)
    _G.VDSettings.ESP.Objects.Generators.Enabled = v
end)

Library:CreateToggle(ESPTab, "Прогресс генераторов", _G.VDSettings.ESP.Objects.Generators.Progress, function(v)
    _G.VDSettings.ESP.Objects.Generators.Progress = v
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

Library:CreateSection(ESPTab, "НАСТРОЙКИ")
Library:CreateDropdown(ESPTab, "Стиль ESP", {
    "Старый",
    "Стандартный",
    "Компактный",
    "Минимальный",
    "Подсветка"
}, _G.VDSettings.ESP.Settings.Style, function(v)
    _G.VDSettings.ESP.Settings.Style = v
end)

Library:CreateSlider(ESPTab, "Дальность", 100, 2000, _G.VDSettings.ESP.Settings.MaxDistance, "m", function(v)
    _G.VDSettings.ESP.Settings.MaxDistance = v
end)

Library:CreateToggle(ESPTab, "Прозрачность по дистанции", _G.VDSettings.ESP.Settings.DistanceFade, function(v)
    _G.VDSettings.ESP.Settings.DistanceFade = v
end)

Library:CreateToggle(ESPTab, "Трейсеры", _G.VDSettings.ESP.Settings.Tracers, function(v)
    _G.VDSettings.ESP.Settings.Tracers = v
end)

Library:CreateSection(ESPTab, "ЦВЕТА")
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

-- ==================== ВКЛАДКА FARM ====================
Library:CreateSection(FarmTab, "АВТОФАРМ ВЫЖИВШЕГО")
Library:CreateToggle(FarmTab, "Автофарм выжившего", _G.VDSettings.Farm.AutoSurvivor, function(v)
    _G.VDSettings.Farm.AutoSurvivor = v
end)

Library:CreateButton(FarmTab, "Мгновенный побег", function()
    print("Instant escape!")
end)

Library:CreateSection(FarmTab, "СКИЛЛЧЕКИ")
Library:CreateToggle(FarmTab, "Авто-скиллчек", _G.VDSettings.Farm.AutoSkillCheck, function(v)
    _G.VDSettings.Farm.AutoSkillCheck = v
end)

Library:CreateDropdown(FarmTab, "Режим", {
    "Perfect",
    "Normal",
    "Hybrid"
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
    print("Generator buff!")
end)

-- ==================== ВКЛАДКА MODS ====================
Library:CreateSection(ModTab, "ДВИЖЕНИЕ")
Library:CreateToggle(ModTab, "Буст скорости", _G.VDSettings.Modifiers.SpeedBoost, function(v)
    _G.VDSettings.Modifiers.SpeedBoost = v
end)

Library:CreateSlider(ModTab, "Множитель", 1, 3, _G.VDSettings.Modifiers.SpeedMultiplier, "x", function(v)
    _G.VDSettings.Modifiers.SpeedMultiplier = v
end)

Library:CreateToggle(ModTab, "Авто-лунная походка", _G.VDSettings.Modifiers.AutoMoonwalk, function(v)
    _G.VDSettings.Modifiers.AutoMoonwalk = v
end)

Library:CreateSection(ModTab, "ЛЕЧЕНИЕ")
Library:CreateToggle(ModTab, "Мгновенное лечение", _G.VDSettings.Modifiers.InstantHeal, function(v)
    _G.VDSettings.Modifiers.InstantHeal = v
end)

Library:CreateButton(ModTab, "Мгновенная перевязка", function()
    print("Instant bandage!")
end)

Library:CreateSection(ModTab, "ПАЛЛЕТЫ И ОКНА")
Library:CreateButton(ModTab, "Сбросить все паллеты", function()
    print("Dropping pallets...")
end)

Library:CreateButton(ModTab, "Блокировка окон", function()
    print("Blocking windows...")
end)

-- ==================== ВКЛАДКА COMBAT ====================
Library:CreateSection(CombatTab, "АВТОПАРРИ")
Library:CreateToggle(CombatTab, "Автопарри", _G.VDSettings.Combat.AutoParry, function(v)
    _G.VDSettings.Combat.AutoParry = v
end)

Library:CreateSlider(CombatTab, "Дальность", 6, 25, _G.VDSettings.Combat.ParryRange, "m", function(v)
    _G.VDSettings.Combat.ParryRange = v
end)

Library:CreateDropdown(CombatTab, "Задержка", {
    "Instant",
    "50ms",
    "100ms",
    "150ms",
    "200ms"
}, _G.VDSettings.Combat.ParryDelay, function(v)
    _G.VDSettings.Combat.ParryDelay = v
end)

Library:CreateSection(CombatTab, "АИМБОТ")
Library:CreateToggle(CombatTab, "Общий аимбот", _G.VDSettings.Combat.GeneralAimbot, function(v)
    _G.VDSettings.Combat.GeneralAimbot = v
end)

Library:CreateSlider(CombatTab, "FOV радиус", 50, 500, _G.VDSettings.Combat.AimbotFOV, "px", function(v)
    _G.VDSettings.Combat.AimbotFOV = v
end)

Library:CreateSection(CombatTab, "МАСКИРОВАННЫЕ")
Library:CreateButton(CombatTab, "Richter - Скрытность", function()
    print("Richter activated")
end)

Library:CreateButton(CombatTab, "Alex - Бензопила", function()
    print("Alex activated")
end)

Library:CreateButton(CombatTab, "Brandon - Скорость", function()
    print("Brandon activated")
end)

-- ==================== ВКЛАДКА VISUAL ====================
Library:CreateSection(VisualTab, "ГРАФИКА")
Library:CreateToggle(VisualTab, "RTX Graphics", _G.VDSettings.Visuals.RTX, function(v)
    _G.VDSettings.Visuals.RTX = v
end)

Library:CreateToggle(VisualTab, "Full Bright", _G.VDSettings.Visuals.FullBright, function(v)
    _G.VDSettings.Visuals.FullBright = v
    
    if v then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").ClockTime = 12
        game:GetService("Lighting").FogEnd = 100
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

Library:CreateSection(VisualTab, "ПРИЦЕЛ")
Library:CreateToggle(VisualTab, "Прицел", _G.VDSettings.Visuals.Crosshair, function(v)
    _G.VDSettings.Visuals.Crosshair = v
end)

-- ==================== ВКЛАДКА CONFIG ====================
Library:CreateSection(ConfigTab, "СТАТУС")
Library:CreateLabel(ConfigTab, _G.VDSettings.Config.Premium and "✓ ПРЕМИУМ" or "✗ FREE")

Library:CreateSection(ConfigTab, "УПРАВЛЕНИЕ")
Library:CreateButton(ConfigTab, "Сохранить конфиг", function()
    if writefile then
        local json = HttpService:JSONEncode(_G.VDSettings)
        writefile("VDHub_Config.json", json)
        print("✓ Saved")
    end
end)

Library:CreateButton(ConfigTab, "Загрузить конфиг", function()
    if readfile and isfile and isfile("VDHub_Config.json") then
        local json = readfile("VDHub_Config.json")
        _G.VDSettings = HttpService:JSONDecode(json)
        print("✓ Loaded")
    end
end)

Library:CreateButton(ConfigTab, "Сброс настроек", function()
    _G.VDSettings = nil
    print("✓ Reset")
end)

Library:CreateButton(ConfigTab, "Выгрузить скрипт", function()
    ScreenGui:Destroy()
end)

-- Делаем GUI перетаскиваемым
Utility:MakeDraggable(Main, TopBar)

-- Открытие первой вкладки
Library:SelectTab(ESPTab)

-- Анимация появления
Main.Size = UDim2.new(0, 0, 0, 0)
Utility:Tween(Main, {Size = UDim2.new(0, 360, 0, 480)}, 0.4, Enum.EasingStyle.Back)

-- Управление видимостью
local MenuVisible = true
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == _G.VDSettings.Config.MenuKey then
        MenuVisible = not MenuVisible
        ScreenGui.Enabled = MenuVisible
    end
end)

-- Уведомление
task.spawn(function()
    local Notif = Instance.new("Frame")
    Notif.AnchorPoint = Vector2.new(0.5, 0)
    Notif.Position = UDim2.new(0.5, 0, 0, -50)
    Notif.Size = UDim2.new(0, 280, 0, 45)
    Notif.BackgroundColor3 = Theme.Card
    Notif.BorderSizePixel = 0
    Notif.Parent = ScreenGui
    Utility:Corner(Notif, 8)
    Utility:Stroke(Notif, Theme.Primary, 1)

    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, 0, 1, 0)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = "✓ Violence District Hub v4.0"
    NotifText.TextColor3 = Theme.Primary
    NotifText.Font = Enum.Font.GothamBold
    NotifText.TextSize = 12
    NotifText.Parent = Notif

    Utility:Tween(Notif, {Position = UDim2.new(0.5, 0, 0, 15)}, 0.4)
    task.wait(3)
    Utility:Tween(Notif, {Position = UDim2.new(0.5, 0, 0, -50)}, 0.4)
    task.wait(0.4)
    Notif:Destroy()
end)

print("Violence District Hub v4.0 loaded!")
print("Press K to toggle menu")
