--[[
    Violence District Hub (6locc Logic) 
    Портировано на Compkiller UI
    Открытие: Left Alt
]]

local Compkiller = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))();

-- Конфиг менеджер
local ConfigManager = Compkiller:ConfigManager({
    Directory = "VD-6locc",
    Config = "Settings"
});

-- Загрузочный экран
Compkiller:Loader("rbxassetid://120245531583106", 1.5).yield();

-- Создание окна
local MenuKey = "LeftAlt";

local Window = Compkiller.new({
    Name = "6LOCC VD",
    Keybind = MenuKey,
    Logo = "rbxassetid://120245531583106",
    Scale = Compkiller.Scale.Window,
    TextSize = 15,
});

-- Настройки пользователя
local UserSettings = Window.UserSettings:Create();

UserSettings:AddColorPicker({
    Name = "Цвет меню",
    Default = Compkiller.Colors.Highlight,
    Callback = function(f)
        Compkiller.Colors.Highlight = f;
        Compkiller:RefreshCurrentColor();
    end,
});

UserSettings:AddKeybind({
    Name = "Клавиша меню",
    Default = MenuKey,
    Callback = function(f)
        MenuKey = f;
        Window:SetMenuKey(MenuKey)
    end,
});

UserSettings:AddDropdown({
    Name = "Тема",
    Values = {"Default", "Dark Green", "Dark Blue", "Purple Rose", "Skeet"},
    Default = "Default",
    Callback = function(f)
        Compkiller:SetTheme(f)
    end,
});

-- Водяной знак
local Watermark = Window:Watermark();

Watermark:AddText({
    Icon = "user",
    Text = "6LOCC VD",
});

Watermark:AddText({
    Icon = "clock",
    Text = Compkiller:GetDate(),
});

local Time = Watermark:AddText({
    Icon = "timer",
    Text = "TIME",
});

task.spawn(function()
    while true do task.wait()
        Time:SetText(Compkiller:GetTimeNow());
    end
end)

Watermark:AddText({
    Icon = "server",
    Text = Compkiller.Version,
});

-- ============================================
--  ГЛОБАЛЬНЫЕ НАСТРОЙКИ (6locc стиль)
-- ============================================

_G.Settings = _G.Settings or {
    -- ESP
    MasterESP = true,
    KillerESP = { Enabled = false, Aura = true, Distance = true, SelectedKiller = true, ShowName = true },
    SurvivorESP = { Enabled = false, Aura = true, Distance = true, HealthState = true, ShowHookCount = true, ShowName = true, CensorNames = false },
    GeneratorESP = { Enabled = false, Aura = true, ShowProgress = true, ShowRepairSpeed = true, ShowETA = true, AlertThresholdEnabled = true, AlertThreshold = 90, ShowDistance = true, ShowRepairingCount = true, NoText = false },
    HookESP = { Enabled = false, Aura = true, ShowDistance = true, NoText = false },
    PalletESP = { Enabled = false, Aura = true, ShowDistance = true, NoText = false },
    VaultESP = { Enabled = false, Aura = true, ShowDistance = true, NoText = false },
    GateESP = { Enabled = false, Aura = true, ShowProgress = true, ShowDistance = true, NoText = false },
    BloodESP = { Enabled = false, Aura = true, ShowDistance = true, NoText = false },
    SCPESP = { Enabled = false, Aura = true, ShowDistance = true, NoText = false },
    ESPStyle = "Standard",
    ESPBackground = false,
    ESPDistanceFade = false,
    ESPDistanceFadePlayers = true,
    ESPDistanceFadeMap = true,
    ESPFadeStart = 50,
    ESPFadeMax = 200,
    ESPRange = 999999,
    ESPTracers = false,
    TracerTarget = "Both",
    TracerStyle = "Line",
    TracerOrigin = "Bottom",
    TracerColorMode = "Role Color",
    Minimap = { Enabled = false },
    ESPColors = {
        Killer = Color3.fromRGB(255, 50, 50),
        SurvivorHealthy = Color3.fromRGB(50, 255, 100),
        SurvivorInjured = Color3.fromRGB(255, 150, 0),
        SurvivorKnocked = Color3.fromRGB(255, 50, 50),
        Generator = Color3.fromRGB(0, 200, 255),
        Hook = Color3.fromRGB(255, 150, 0),
        Pallet = Color3.fromRGB(180, 130, 70),
        Vault = Color3.fromRGB(180, 180, 180),
        BloodEffect = Color3.fromRGB(180, 0, 0),
        Gate = Color3.fromRGB(255, 255, 0),
        SCP = Color3.fromRGB(150, 0, 255),
        Tracer = Color3.fromRGB(255, 255, 255),
    },
    
    -- Farm
    AutoFarmSurvivor = false,
    AutoServerHopEscape = false,
    AutoFarmAFKTotal = false,
    AutoFarmKiller = false,
    AntiWiggle = false,
    AutoSkillCheck = false,
    InstantSkillCheck = false,
    SkillCheckMode = "Perfect",
    PerfectHitRate = 100,
    SkillCheckSpeedVal = 1,
    NoSkillChecks = false,
    FlowstatePerk = false,
    FlowstateCooldown = 15,
    HideFlowstateUI = false,
    
    -- Modifiers
    SpeedBoostEnabled = false,
    SpeedBoost = 1.3,
    CountSpeedPerks = true,
    VaultSpeed = 1,
    ModifierTeamFilter = "Both",
    InstantHeal = false,
    NoclipVaultsPallets = false,
    AutoFleeKiller = false,
    AutoMoonwalk = false,
    ReverseMoonwalk = false,
    MoonwalkDisableOnVault = true,
    MoonwalkSwaySpeed = 14,
    MoonwalkSwayAmplitude = 0.65,
    MoonwalkShaking = 0.05,
    MoonwalkMovementBased = false,
    RainbowCharacter = false,
    RainbowCharacterMode = "Highlight",
    RemoteDropPallet = false,
    RemoteDropPalletKey = "None",
    WalkWhileEmoting = true,
    CustomEmoteWheel = true,
    EmoteWheelKey = "F",
    EmoteWheelMode = "Hold",
    
    -- Combat
    AutoParry = false,
    ParryUseItem = false,
    ParryRange = 14,
    ParryPingCompensation = true,
    ParryRangeESP = false,
    ParryDelay = 0,
    ParryFacingCheck = true,
    HideParryUI = false,
    FrenzyParry = false,
    IgnoreAbysswalkerLunge = false,
    SimulateParryAnimation = false,
    NoStun = false,
    
    -- Revolver
    RevolverAutofarm = false,
    RevolverAimbot = { Enabled = false, Key = "MouseButton2", TargetPart = "UpperTorso", Priority = "Nearest", Smoothness = 0, Radius = 150, OffsetX = 12, OffsetY = 5, ShowFOV = false, ShowCrosshair = false, CrosshairStyle = "Classic", CrosshairColor = Color3.fromRGB(0, 255, 255), CrosshairSize = 10, PredictionEnabled = true, BulletVelocity = 800 },
    RevolverSilentAim = { Enabled = false, Priority = "Nearest", FOVRadius = 200, ShowFOV = true, FOVColor = "Cyan", Target = "Both Teams", TargetHighlightEnabled = true, TargetHighlightColor = "Cyan", TargetHighlightMode = "Always on Top", TargetHighlightFillTransparency = 0.5, TargetHighlightOutlineTransparency = 0 },
    BypassToFRestrictions = false,
    
    -- Veil
    SpearTrajectory = false,
    SpearTrajectoryNoclip = false,
    SpearTrajectoryColor = "Cyan",
    SpearAimbot = { Enabled = false, Key = "MouseButton2", TargetPart = "UpperTorso", Priority = "Nearest", Smoothness = 0.05, Radius = 150, Speed = 150, Gravity = 98 },
    SpearSilentAim = { Enabled = false, Priority = "Nearest", FOVRadius = 240, ShowFOV = true, FOVColor = "Yellow", TargetHighlightEnabled = true, TargetHighlightColor = "Red", TargetHighlightMode = "Always on Top", TargetHighlightFillTransparency = 0.5, TargetHighlightOutlineTransparency = 0 },
    
    -- Stalker
    Stalker = {
        NoCooldown = false,
        KillGrab = false,
        AutoDodge = false,
        AutoDodgeDistance = 15,
        StalkWhileMoving = false,
        InfiniteCorrupt = false,
    },
    
    -- Masked
    Masked = { CurrentBuff = "Normal" },
    
    -- Visuals
    RTXGraphics = false,
    CinematicDOF = false,
    GraphicsTint = "Default",
    VisualPreset = "Default",
    VisualSaturation = 0.25,
    VisualContrast = 0.12,
    CustomFogEnabled = false,
    CustomFogColor = Color3.fromRGB(120, 160, 200),
    CustomFogStart = 0,
    CustomFogEnd = 800,
    CustomLightingEnabled = false,
    CustomLightingColor = Color3.fromRGB(255, 255, 255),
    TimeOfDayPreset = "Default",
    CustomBloomEnabled = false,
    BloomIntensity = 0.8,
    BloomSize = 24,
    BloomThreshold = 0.85,
    SunRaysEnabled = false,
    SunRaysIntensity = 0.1,
    AtmosphereDensity = 0.3,
    InfiniteZoom = false,
    FOV = 70,
    StretchedResolutionMode = "Normal",
    ShowCrosshair = false,
    CrosshairStyle = "Classic",
    CrosshairColor = Color3.fromRGB(0, 255, 255),
    CrosshairSize = 10,
    NoFog = false,
    FullBright = false,
    NoFlashlightBlind = false,
    KillerThirdPerson = false,
    FlashlightEffect = "None",
    FlashlightColor = Color3.fromRGB(255, 255, 255),
    KillerStainColor = Color3.fromRGB(255, 0, 0),
    
    -- Network
    FakeLag = false,
    FakeLagMs = 200,
    Desync = false,
    EnableDesyncGhost = true,
    DesyncGhostAlwaysOnTop = true,
    DesyncGhostTransparency = 0.5,
    DesyncGhostColor = "Accent",
    
    -- UI
    ShowInfoBanner = false,
    InfoBannerShowMap = true,
    InfoBannerShowKiller = true,
    InfoBannerShowPerks = true,
    InfoBannerShowFPS = true,
    InfoBannerShowPing = true,
    DisableAllNotifications = false,
    ShowToggleNotifications = true,
    ShowActiveFeatures = false,
    ShowSpectatorList = false,
    ShowHotkeyOverlay = false,
    Theme = "Default",
    HideLivePlayersMode = "Normal",
    CustomOverlayUrl = "rbxassetid://71824917786372",
    CustomBackground = { Enabled = false, AssetId = "", LocalFile = "", Overlay = 40, ScaleType = "Crop" },
    
    -- Keybinds
    Keybinds = {
        ToggleUI = "K",
        ToggleSpeedBoost = "None",
        AutoMoonwalk = "None",
        FlowstatePerk = "None",
        AutoSkillCheck = "None",
        KillerTrack = "None",
        SurvivorTrack = "None",
        InstantEscape = "None",
        CancelGen = "None",
        NoclipVaultsPallets = "None",
        FakeVault = "None",
        AutoParry = "None",
        RevolverAimbot = "None",
        RevolverAutofarm = "None",
        InstantHeal = "None",
        InstantBandage = "None",
        DropAllPallets = "None",
        BlockVaultPalletInteraction = "None",
        NoFog = "None",
        FullBright = "None",
        NoFlashlightBlind = "None",
        StopEmote = "None",
        Masked_Richter = "None",
        Masked_Alex = "None",
        Masked_Brandon = "None",
        Masked_Rabbit = "None",
        Masked_Cobra = "None",
        Masked_Tony = "None",
        Masked_Normal = "None",
        InfiniteLunge = "None",
    },
};

-- ============================================
--  ВКЛАДКИ GUI
-- ============================================

-- Категория: ESP
Window:DrawCategory({ Name = "ESP" });

local EspTab = Window:DrawTab({
    Name = "ESP",
    Icon = "eye",
    EnableScrolling = true
});

-- Секция: Master Controls
local EspMaster = EspTab:DrawSection({ Name = "Мастер", Position = 'left' });

EspMaster:AddToggle({
    Name = "Мастер ESP",
    Flag = "MasterESP",
    Default = _G.Settings.MasterESP,
    Callback = function(v)
        _G.Settings.MasterESP = v
    end,
});

-- Секция: Игроки
local EspPlayers = EspTab:DrawSection({ Name = "Игроки", Position = 'right' });

EspPlayers:AddToggle({
    Name = "Отслеживание убийцы",
    Flag = "KillerESP",
    Default = _G.Settings.KillerESP.Enabled,
    Callback = function(v)
        _G.Settings.KillerESP.Enabled = v
    end,
});

local KillerOpt = EspPlayers:AddOption();
KillerOpt:AddToggle({
    Name = "Подсветка",
    Flag = "KillerESP_Aura",
    Default = _G.Settings.KillerESP.Aura,
    Callback = function(v)
        _G.Settings.KillerESP.Aura = v
    end,
});
KillerOpt:AddToggle({
    Name = "Дистанция",
    Flag = "KillerESP_Distance",
    Default = _G.Settings.KillerESP.Distance,
    Callback = function(v)
        _G.Settings.KillerESP.Distance = v
    end,
});
KillerOpt:AddToggle({
    Name = "Имя убийцы",
    Flag = "KillerESP_ShowName",
    Default = _G.Settings.KillerESP.ShowName,
    Callback = function(v)
        _G.Settings.KillerESP.ShowName = v
    end,
});

EspPlayers:AddToggle({
    Name = "Отслеживание выживших",
    Flag = "SurvivorESP",
    Default = _G.Settings.SurvivorESP.Enabled,
    Callback = function(v)
        _G.Settings.SurvivorESP.Enabled = v
    end,
});

local SurvivorOpt = EspPlayers:AddOption();
SurvivorOpt:AddToggle({
    Name = "Подсветка",
    Flag = "SurvivorESP_Aura",
    Default = _G.Settings.SurvivorESP.Aura,
    Callback = function(v)
        _G.Settings.SurvivorESP.Aura = v
    end,
});
SurvivorOpt:AddToggle({
    Name = "Здоровье",
    Flag = "SurvivorESP_Health",
    Default = _G.Settings.SurvivorESP.HealthState,
    Callback = function(v)
        _G.Settings.SurvivorESP.HealthState = v
    end,
});
SurvivorOpt:AddToggle({
    Name = "Счетчик крюков",
    Flag = "SurvivorESP_Hooks",
    Default = _G.Settings.SurvivorESP.ShowHookCount,
    Callback = function(v)
        _G.Settings.SurvivorESP.ShowHookCount = v
    end,
});
SurvivorOpt:AddToggle({
    Name = "Цензура имен",
    Flag = "SurvivorESP_Censor",
    Default = _G.Settings.SurvivorESP.CensorNames,
    Callback = function(v)
        _G.Settings.SurvivorESP.CensorNames = v
    end,
});

-- Секция: Объекты
local EspObjects = EspTab:DrawSection({ Name = "Объекты", Position = 'left' });

EspObjects:AddToggle({
    Name = "Генераторы",
    Flag = "GeneratorESP",
    Default = _G.Settings.GeneratorESP.Enabled,
    Callback = function(v)
        _G.Settings.GeneratorESP.Enabled = v
    end,
});

local GenOpt = EspObjects:AddOption();
GenOpt:AddToggle({
    Name = "Прогресс",
    Flag = "GeneratorESP_Progress",
    Default = _G.Settings.GeneratorESP.ShowProgress,
    Callback = function(v)
        _G.Settings.GeneratorESP.ShowProgress = v
    end,
});
GenOpt:AddToggle({
    Name = "Скорость ремонта",
    Flag = "GeneratorESP_Speed",
    Default = _G.Settings.GeneratorESP.ShowRepairSpeed,
    Callback = function(v)
        _G.Settings.GeneratorESP.ShowRepairSpeed = v
    end,
});
GenOpt:AddToggle({
    Name = "ETA",
    Flag = "GeneratorESP_ETA",
    Default = _G.Settings.GeneratorESP.ShowETA,
    Callback = function(v)
        _G.Settings.GeneratorESP.ShowETA = v
    end,
});

EspObjects:AddToggle({
    Name = "Крюки",
    Flag = "HookESP",
    Default = _G.Settings.HookESP.Enabled,
    Callback = function(v)
        _G.Settings.HookESP.Enabled = v
    end,
});

EspObjects:AddToggle({
    Name = "Паллеты",
    Flag = "PalletESP",
    Default = _G.Settings.PalletESP.Enabled,
    Callback = function(v)
        _G.Settings.PalletESP.Enabled = v
    end,
});

EspObjects:AddToggle({
    Name = "Окна",
    Flag = "VaultESP",
    Default = _G.Settings.VaultESP.Enabled,
    Callback = function(v)
        _G.Settings.VaultESP.Enabled = v
    end,
});

EspObjects:AddToggle({
    Name = "Ворота",
    Flag = "GateESP",
    Default = _G.Settings.GateESP.Enabled,
    Callback = function(v)
        _G.Settings.GateESP.Enabled = v
    end,
});

EspObjects:AddToggle({
    Name = "Кровь",
    Flag = "BloodESP",
    Default = _G.Settings.BloodESP.Enabled,
    Callback = function(v)
        _G.Settings.BloodESP.Enabled = v
    end,
});

EspObjects:AddToggle({
    Name = "Зомби/SCP",
    Flag = "SCPESP",
    Default = _G.Settings.SCPESP.Enabled,
    Callback = function(v)
        _G.Settings.SCPESP.Enabled = v
    end,
});

-- Секция: Настройки ESP
local EspSettings = EspTab:DrawSection({ Name = "Настройки", Position = 'right' });

EspSettings:AddDropdown({
    Name = "Стиль ESP",
    Values = {"Old", "Standard", "Compact", "Minimal", "Aura Only"},
    Default = _G.Settings.ESPStyle,
    Flag = "ESPStyle",
    Callback = function(v)
        _G.Settings.ESPStyle = v
    end,
});

EspSettings:AddSlider({
    Name = "Дальность ESP",
    Min = 100,
    Max = 2000,
    Default = _G.Settings.ESPRange,
    Round = 0,
    Flag = "ESPRange",
    Callback = function(v)
        _G.Settings.ESPRange = v
    end,
});

EspSettings:AddToggle({
    Name = "Прозрачность по дистанции",
    Flag = "ESPDistanceFade",
    Default = _G.Settings.ESPDistanceFade,
    Callback = function(v)
        _G.Settings.ESPDistanceFade = v
    end,
});

EspSettings:AddToggle({
    Name = "Трейсеры",
    Flag = "ESPTracers",
    Default = _G.Settings.ESPTracers,
    Callback = function(v)
        _G.Settings.ESPTracers = v
    end,
});

EspSettings:AddToggle({
    Name = "Мини-карта",
    Flag = "Minimap",
    Default = _G.Settings.Minimap.Enabled,
    Callback = function(v)
        _G.Settings.Minimap.Enabled = v
    end,
});

-- ============================================
-- Категория: Фарм
-- ============================================

Window:DrawCategory({ Name = "Фарм" });

local FarmTab = Window:DrawTab({
    Name = "Фарм",
    Icon = "farm",
    EnableScrolling = true
});

local FarmMain = FarmTab:DrawSection({ Name = "Автофарм", Position = 'left' });

FarmMain:AddToggle({
    Name = "Автофарм выжившего",
    Flag = "AutoSurvivorFarm",
    Default = _G.Settings.AutoFarmSurvivor,
    Callback = function(v)
        _G.Settings.AutoFarmSurvivor = v
    end,
});

FarmMain:AddToggle({
    Name = "Серверный хоп",
    Flag = "ServerHop",
    Default = _G.Settings.AutoServerHopEscape,
    Callback = function(v)
        _G.Settings.AutoServerHopEscape = v
    end,
});

FarmMain:AddToggle({
    Name = "Тотальный AFK фарм",
    Flag = "TotalAFK",
    Default = _G.Settings.AutoFarmAFKTotal,
    Callback = function(v)
        _G.Settings.AutoFarmAFKTotal = v
    end,
});

FarmMain:AddButton({
    Name = "Мгновенный побег",
    Callback = function()
        local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local finish = nil
        local dist = math.huge
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:lower():find("finishline") or v.Name:lower():find("fininshline")) then
                local d = (v.Position - root.Position).Magnitude
                if d < dist then
                    dist = d
                    finish = v
                end
            end
        end
        if finish then
            root.CFrame = finish.CFrame
        end
    end,
});

local FarmKiller = FarmTab:DrawSection({ Name = "Убийца", Position = 'right' });

FarmKiller:AddToggle({
    Name = "Автофарм убийцы",
    Flag = "AutoKillerFarm",
    Default = _G.Settings.AutoFarmKiller,
    Callback = function(v)
        _G.Settings.AutoFarmKiller = v
    end,
});

FarmKiller:AddToggle({
    Name = "Анти-вырывание",
    Flag = "AntiWiggle",
    Default = _G.Settings.AntiWiggle,
    Callback = function(v)
        _G.Settings.AntiWiggle = v
    end,
});

local FarmSkill = FarmTab:DrawSection({ Name = "Скиллчеки", Position = 'left' });

FarmSkill:AddToggle({
    Name = "Авто-скиллчек",
    Flag = "AutoSkillCheck",
    Default = _G.Settings.AutoSkillCheck,
    Callback = function(v)
        _G.Settings.AutoSkillCheck = v
    end,
});

FarmSkill:AddToggle({
    Name = "Мгновенный скиллчек",
    Flag = "InstantSkillCheck",
    Default = _G.Settings.InstantSkillCheck,
    Callback = function(v)
        _G.Settings.InstantSkillCheck = v
    end,
});

FarmSkill:AddDropdown({
    Name = "Режим",
    Values = {"Perfect", "Normal", "Hybrid"},
    Default = _G.Settings.SkillCheckMode,
    Flag = "SkillCheckMode",
    Callback = function(v)
        _G.Settings.SkillCheckMode = v
    end,
});

FarmSkill:AddSlider({
    Name = "Шанс идеального",
    Min = 0,
    Max = 100,
    Default = _G.Settings.PerfectHitRate,
    Round = 0,
    Flag = "PerfectHitRate",
    Callback = function(v)
        _G.Settings.PerfectHitRate = v
    end,
});

FarmSkill:AddSlider({
    Name = "Скорость скиллчека",
    Min = 0.1,
    Max = 3.0,
    Default = _G.Settings.SkillCheckSpeedVal,
    Round = 1,
    Flag = "SkillCheckSpeed",
    Callback = function(v)
        _G.Settings.SkillCheckSpeedVal = v
    end,
});

FarmSkill:AddToggle({
    Name = "No Skill Checks",
    Flag = "NoSkillChecks",
    Default = _G.Settings.NoSkillChecks,
    Callback = function(v)
        _G.Settings.NoSkillChecks = v
    end,
});

FarmSkill:AddButton({
    Name = "Бафф генератора",
    Callback = function()
        -- Логика баффа генератора
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local nearest = nil
        local dist = math.huge
        for _, gen in ipairs(workspace:GetDescendants()) do
            if gen.Name == "Generator" then
                local pos = gen:IsA("Model") and gen:GetPivot and gen:GetPivot().Position or gen.Position
                if pos then
                    local d = (pos - root.Position).Magnitude
                    if d < dist and d < 15 then
                        dist = d
                        nearest = gen
                    end
                end
            end
        end
        if nearest then
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            if remotes then
                local genRemote = remotes:FindFirstChild("Generator")
                if genRemote then
                    local repEvent = genRemote:FindFirstChild("RepairEvent")
                    if repEvent then
                        repEvent:FireServer(nearest, true)
                    end
                end
            end
        end
    end,
});

-- ============================================
-- Категория: Модификаторы
-- ============================================

Window:DrawCategory({ Name = "Модификаторы" });

local ModTab = Window:DrawTab({
    Name = "Моды",
    Icon = "tune",
    EnableScrolling = true
});

local ModSpeed = ModTab:DrawSection({ Name = "Скорость", Position = 'left' });

ModSpeed:AddToggle({
    Name = "Буст скорости",
    Flag = "SpeedBoost",
    Default = _G.Settings.SpeedBoostEnabled,
    Callback = function(v)
        _G.Settings.SpeedBoostEnabled = v
    end,
});

ModSpeed:AddSlider({
    Name = "Множитель скорости",
    Min = 1.0,
    Max = 3.0,
    Default = _G.Settings.SpeedBoost,
    Round = 1,
    Flag = "SpeedMultiplier",
    Callback = function(v)
        _G.Settings.SpeedBoost = v
    end,
});

ModSpeed:AddToggle({
    Name = "Учет перков скорости",
    Flag = "CountSpeedPerks",
    Default = _G.Settings.CountSpeedPerks,
    Callback = function(v)
        _G.Settings.CountSpeedPerks = v
    end,
});

ModSpeed:AddDropdown({
    Name = "Фильтр команды",
    Values = {"Both", "Survivors", "Killer"},
    Default = _G.Settings.ModifierTeamFilter,
    Flag = "TeamFilter",
    Callback = function(v)
        _G.Settings.ModifierTeamFilter = v
    end,
});

local ModMovement = ModTab:DrawSection({ Name = "Движение", Position = 'right' });

ModMovement:AddToggle({
    Name = "Авто-лунная походка",
    Flag = "AutoMoonwalk",
    Default = _G.Settings.AutoMoonwalk,
    Callback = function(v)
        _G.Settings.AutoMoonwalk = v
    end,
});

ModMovement:AddToggle({
    Name = "Обратная лунная походка",
    Flag = "ReverseMoonwalk",
    Default = _G.Settings.ReverseMoonwalk,
    Callback = function(v)
        _G.Settings.ReverseMoonwalk = v
    end,
});

ModMovement:AddSlider({
    Name = "Скорость sway",
    Min = 1,
    Max = 30,
    Default = _G.Settings.MoonwalkSwaySpeed,
    Round = 0,
    Flag = "SwaySpeed",
    Callback = function(v)
        _G.Settings.MoonwalkSwaySpeed = v
    end,
});

ModMovement:AddSlider({
    Name = "Амплитуда sway",
    Min = 0,
    Max = 150,
    Default = _G.Settings.MoonwalkSwayAmplitude * 100,
    Round = 0,
    Flag = "SwayAmplitude",
    Callback = function(v)
        _G.Settings.MoonwalkSwayAmplitude = v / 100
    end,
});

ModMovement:AddToggle({
    Name = "Ноклип окон/паллет",
    Flag = "NoclipVaultsPallets",
    Default = _G.Settings.NoclipVaultsPallets,
    Callback = function(v)
        _G.Settings.NoclipVaultsPallets = v
    end,
});

ModMovement:AddToggle({
    Name = "Авто-побег от убийцы",
    Flag = "AutoFleeKiller",
    Default = _G.Settings.AutoFleeKiller,
    Callback = function(v)
        _G.Settings.AutoFleeKiller = v
    end,
});

local ModHeal = ModTab:DrawSection({ Name = "Лечение", Position = 'left' });

ModHeal:AddToggle({
    Name = "Мгновенное лечение",
    Flag = "InstantHeal",
    Default = _G.Settings.InstantHeal,
    Callback = function(v)
        _G.Settings.InstantHeal = v
    end,
});

ModHeal:AddButton({
    Name = "Мгновенная перевязка",
    Callback = function()
        -- Логика мгновенной перевязки
        local char = game.Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end,
});

local ModEffects = ModTab:DrawSection({ Name = "Эффекты", Position = 'right' });

ModEffects:AddToggle({
    Name = "Радужный персонаж",
    Flag = "RainbowCharacter",
    Default = _G.Settings.RainbowCharacter,
    Callback = function(v)
        _G.Settings.RainbowCharacter = v
    end,
});

ModEffects:AddDropdown({
    Name = "Режим радуги",
    Values = {"Highlight", "Body Parts", "ForceField"},
    Default = _G.Settings.RainbowCharacterMode,
    Flag = "RainbowMode",
    Callback = function(v)
        _G.Settings.RainbowCharacterMode = v
    end,
});

local ModPerks = ModTab:DrawSection({ Name = "Перки", Position = 'left' });

ModPerks:AddToggle({
    Name = "Force Flowstate",
    Flag = "FlowstatePerk",
    Default = _G.Settings.FlowstatePerk,
    Callback = function(v)
        _G.Settings.FlowstatePerk = v
    end,
});

ModPerks:AddSlider({
    Name = "Кулдаун Flowstate",
    Min = 0,
    Max = 60,
    Default = _G.Settings.FlowstateCooldown,
    Round = 0,
    Flag = "FlowstateCooldown",
    Callback = function(v)
        _G.Settings.FlowstateCooldown = v
    end,
});

ModPerks:AddToggle({
    Name = "Скрыть UI Flowstate",
    Flag = "HideFlowstateUI",
    Default = _G.Settings.HideFlowstateUI,
    Callback = function(v)
        _G.Settings.HideFlowstateUI = v
    end,
});

-- ============================================
-- Категория: Бой
-- ============================================

Window:DrawCategory({ Name = "Бой" });

local CombatTab = Window:DrawTab({
    Name = "Бой",
    Icon = "sword",
    EnableScrolling = true
});

local CombatParry = CombatTab:DrawSection({ Name = "Автопарри", Position = 'left' });

CombatParry:AddToggle({
    Name = "Автопарри",
    Flag = "AutoParry",
    Default = _G.Settings.AutoParry,
    Callback = function(v)
        _G.Settings.AutoParry = v
    end,
});

CombatParry:AddToggle({
    Name = "Использовать предмет",
    Flag = "ParryUseItem",
    Default = _G.Settings.ParryUseItem,
    Callback = function(v)
        _G.Settings.ParryUseItem = v
    end,
});

CombatParry:AddSlider({
    Name = "Дальность парирования",
    Min = 6,
    Max = 25,
    Default = _G.Settings.ParryRange,
    Round = 0,
    Flag = "ParryRange",
    Callback = function(v)
        _G.Settings.ParryRange = v
    end,
});

CombatParry:AddDropdown({
    Name = "Задержка реакции",
    Values = {"0", "50", "100", "150", "200", "250", "300"},
    Default = tostring(_G.Settings.ParryDelay * 1000),
    Flag = "ParryDelay",
    Callback = function(v)
        _G.Settings.ParryDelay = tonumber(v) / 1000
    end,
});

CombatParry:AddToggle({
    Name = "Проверка направления",
    Flag = "ParryFacingCheck",
    Default = _G.Settings.ParryFacingCheck,
    Callback = function(v)
        _G.Settings.ParryFacingCheck = v
    end,
});

CombatParry:AddToggle({
    Name = "Компенсация пинга",
    Flag = "ParryPingCompensation",
    Default = _G.Settings.ParryPingCompensation,
    Callback = function(v)
        _G.Settings.ParryPingCompensation = v
    end,
});

CombatParry:AddToggle({
    Name = "Визуальный круг",
    Flag = "ParryRangeESP",
    Default = _G.Settings.ParryRangeESP,
    Callback = function(v)
        _G.Settings.ParryRangeESP = v
    end,
});

CombatParry:AddToggle({
    Name = "Игнорирование Frenzy",
    Flag = "FrenzyParry",
    Default = _G.Settings.FrenzyParry,
    Callback = function(v)
        _G.Settings.FrenzyParry = v
    end,
});

CombatParry:AddToggle({
    Name = "Игнорирование Abysswalker",
    Flag = "IgnoreAbysswalker",
    Default = _G.Settings.IgnoreAbysswalkerLunge,
    Callback = function(v)
        _G.Settings.IgnoreAbysswalkerLunge = v
    end,
});

CombatParry:AddToggle({
    Name = "Скрыть UI парирования",
    Flag = "HideParryUI",
    Default = _G.Settings.HideParryUI,
    Callback = function(v)
        _G.Settings.HideParryUI = v
    end,
});

local CombatAimbot = CombatTab:DrawSection({ Name = "Аимбот", Position = 'right' });

CombatAimbot:AddToggle({
    Name = "Аимбот (общий)",
    Flag = "GeneralAimbot",
    Default = _G.Settings.AimAssist.Enabled,
    Callback = function(v)
        _G.Settings.AimAssist.Enabled = v
    end,
});

CombatAimbot:AddDropdown({
    Name = "Часть тела",
    Values = {"Head", "UpperTorso", "HumanoidRootPart"},
    Default = _G.Settings.AimAssist.TargetPart,
    Flag = "AimbotPart",
    Callback = function(v)
        _G.Settings.AimAssist.TargetPart = v
    end,
});

CombatAimbot:AddDropdown({
    Name = "Приоритет",
    Values = {"Nearest", "Furthest", "Injured", "Healed"},
    Default = _G.Settings.AimAssist.Priority,
    Flag = "AimbotPriority",
    Callback = function(v)
        _G.Settings.AimAssist.Priority = v
    end,
});

CombatAimbot:AddSlider({
    Name = "FOV радиус",
    Min = 50,
    Max = 500,
    Default = _G.Settings.AimAssist.FOV,
    Round = 0,
    Flag = "AimbotFOV",
    Callback = function(v)
        _G.Settings.AimAssist.FOV = v
    end,
});

CombatAimbot:AddToggle({
    Name = "Показывать FOV",
    Flag = "ShowFOVCircle",
    Default = _G.Settings.AimAssist.ShowFOV,
    Callback = function(v)
        _G.Settings.AimAssist.ShowFOV = v
    end,
});

CombatAimbot:AddToggle({
    Name = "Предсказание движения",
    Flag = "PredictMovement",
    Default = _G.Settings.AimAssist.Prediction,
    Callback = function(v)
        _G.Settings.AimAssist.Prediction = v
    end,
});

-- ============================================
-- Категория: Револьвер / Вейл
-- ============================================

Window:DrawCategory({ Name = "Оружие" });

local WeaponTab = Window:DrawTab({
    Name = "Оружие",
    Icon = "sword",
    EnableScrolling = true
});

local RevSection = WeaponTab:DrawSection({ Name = "Револьвер", Position = 'left' });

RevSection:AddToggle({
    Name = "Автофарм револьвером",
    Flag = "RevolverAutofarm",
    Default = _G.Settings.RevolverAutofarm,
    Callback = function(v)
        _G.Settings.RevolverAutofarm = v
    end,
});

RevSection:AddToggle({
    Name = "Аимбот револьвера",
    Flag = "RevolverAimbot",
    Default = _G.Settings.RevolverAimbot.Enabled,
    Callback = function(v)
        _G.Settings.RevolverAimbot.Enabled = v
    end,
});

RevSection:AddToggle({
    Name = "Сайлент-аим револьвера",
    Flag = "RevolverSilentAim",
    Default = _G.Settings.RevolverSilentAim.Enabled,
    Callback = function(v)
        _G.Settings.RevolverSilentAim.Enabled = v
    end,
});

RevSection:AddSlider({
    Name = "FOV сайлента",
    Min = 50,
    Max = 400,
    Default = _G.Settings.RevolverSilentAim.FOVRadius,
    Round = 0,
    Flag = "RevolverSilentFOV",
    Callback = function(v)
        _G.Settings.RevolverSilentAim.FOVRadius = v
    end,
});

RevSection:AddToggle({
    Name = "Обход ограничений",
    Flag = "BypassToFRestrictions",
    Default = _G.Settings.BypassToFRestrictions,
    Callback = function(v)
        _G.Settings.BypassToFRestrictions = v
    end,
});

local VeilSection = WeaponTab:DrawSection({ Name = "Вейл", Position = 'right' });

VeilSection:AddToggle({
    Name = "Траектория копья",
    Flag = "SpearTrajectory",
    Default = _G.Settings.SpearTrajectory,
    Callback = function(v)
        _G.Settings.SpearTrajectory = v
    end,
});

VeilSection:AddToggle({
    Name = "Noclip траектории",
    Flag = "SpearTrajectoryNoclip",
    Default = _G.Settings.SpearTrajectoryNoclip,
    Callback = function(v)
        _G.Settings.SpearTrajectoryNoclip = v
    end,
});

VeilSection:AddToggle({
    Name = "Аимбот копья",
    Flag = "SpearAimbot",
    Default = _G.Settings.SpearAimbot.Enabled,
    Callback = function(v)
        _G.Settings.SpearAimbot.Enabled = v
    end,
});

VeilSection:AddToggle({
    Name = "Сайлент-аим копья",
    Flag = "SpearSilentAim",
    Default = _G.Settings.SpearSilentAim.Enabled,
    Callback = function(v)
        _G.Settings.SpearSilentAim.Enabled = v
    end,
});

-- ============================================
-- Категория: Убийцы
-- ============================================

Window:DrawCategory({ Name = "Убийцы" });

local KillerTab = Window:DrawTab({
    Name = "Убийцы",
    Icon = "skull",
    EnableScrolling = true
});

-- Masked
local MaskedSection = KillerTab:DrawSection({ Name = "MASKED", Position = 'left' });

local MaskedBuffs = {
    "Richter - Stealth",
    "Alex - Chainsaw",
    "Brandon - Walk Faster",
    "Rabbit - Fast Vaults",
    "Cobra - Extended Lunges",
    "Tony - Lethal Punches",
    "Normal - No Buffs"
};

MaskedSection:AddDropdown({
    Name = "Выбрать бафф",
    Values = MaskedBuffs,
    Default = "Normal - No Buffs",
    Flag = "MaskedBuff",
    Callback = function(v)
        _G.Settings.Masked.CurrentBuff = v
        -- Логика активации баффа
        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        if remotes then
            local killers = remotes:FindFirstChild("Killers")
            if killers then
                local masked = killers:FindFirstChild("Masked")
                if masked then
                    local deactivate = masked:FindFirstChild("Deactivatepower")
                    local activate = masked:FindFirstChild("Activatepower")
                    if deactivate then
                        deactivate:FireServer()
                        task.wait(0.5)
                    end
                    if activate and v ~= "Normal - No Buffs" then
                        local buffName = v:match("(.+)%-")
                        if buffName then
                            activate:FireServer(buffName:gsub("%s+", ""))
                        end
                    end
                end
            end
        end
    end,
});

-- Stalker
local StalkerSection = KillerTab:DrawSection({ Name = "STALKER", Position = 'right' });

StalkerSection:AddToggle({
    Name = "Нет перезарядки",
    Flag = "StalkerNoCooldown",
    Default = _G.Settings.Stalker.NoCooldown,
    Callback = function(v)
        _G.Settings.Stalker.NoCooldown = v
    end,
});

StalkerSection:AddToggle({
    Name = "Убийственный захват",
    Flag = "StalkerKillGrab",
    Default = _G.Settings.Stalker.KillGrab,
    Callback = function(v)
        _G.Settings.Stalker.KillGrab = v
    end,
});

StalkerSection:AddToggle({
    Name = "Сталк во время движения",
    Flag = "StalkerWhileMoving",
    Default = _G.Settings.Stalker.StalkWhileMoving,
    Callback = function(v)
        _G.Settings.Stalker.StalkWhileMoving = v
    end,
});

-- Abysswalker
local AbyssSection = KillerTab:DrawSection({ Name = "ABYSSWALKER", Position = 'left' });

AbyssSection:AddToggle({
    Name = "Бесконечная порча",
    Flag = "InfiniteCorrupt",
    Default = _G.Settings.Stalker.InfiniteCorrupt,
    Callback = function(v)
        _G.Settings.Stalker.InfiniteCorrupt = v
    end,
});

AbyssSection:AddToggle({
    Name = "Авто-приседание",
    Flag = "AutoDodge",
    Default = _G.Settings.Stalker.AutoDodge,
    Callback = function(v)
        _G.Settings.Stalker.AutoDodge = v
    end,
});

AbyssSection:AddSlider({
    Name = "Дистанция приседания",
    Min = 5,
    Max = 50,
    Default = _G.Settings.Stalker.AutoDodgeDistance,
    Round = 0,
    Flag = "AutoDodgeDistance",
    Callback = function(v)
        _G.Settings.Stalker.AutoDodgeDistance = v
    end,
});

AbyssSection:AddToggle({
    Name = "Нет стана",
    Flag = "NoStun",
    Default = _G.Settings.NoStun,
    Callback = function(v)
        _G.Settings.NoStun = v
    end,
});

-- ============================================
-- Категория: Визуалы
-- ============================================

Window:DrawCategory({ Name = "Визуалы" });

local VisualTab = Window:DrawTab({
    Name = "Визуал",
    Icon = "palette",
    EnableScrolling = true
});

local VisGraphics = VisualTab:DrawSection({ Name = "Графика", Position = 'left' });

VisGraphics:AddToggle({
    Name = "RTX Graphics",
    Flag = "RTXGraphics",
    Default = _G.Settings.RTXGraphics,
    Callback = function(v)
        _G.Settings.RTXGraphics = v
    end,
});

VisGraphics:AddToggle({
    Name = "Глубина резкости",
    Flag = "CinematicDOF",
    Default = _G.Settings.CinematicDOF,
    Callback = function(v)
        _G.Settings.CinematicDOF = v
    end,
});

VisGraphics:AddDropdown({
    Name = "Визуальный пресет",
    Values = {"Default", "Vibrant & Alive", "Clean Daylight", "Cyberpunk Neon", "Warm Sunset", "Moonlight", "Custom"},
    Default = _G.Settings.VisualPreset,
    Flag = "VisualPreset",
    Callback = function(v)
        _G.Settings.VisualPreset = v
    end,
});

VisGraphics:AddSlider({
    Name = "Насыщенность",
    Min = 0,
    Max = 100,
    Default = _G.Settings.VisualSaturation * 100,
    Round = 0,
    Flag = "Saturation",
    Callback = function(v)
        _G.Settings.VisualSaturation = v / 100
    end,
});

VisGraphics:AddSlider({
    Name = "Контраст",
    Min = 0,
    Max = 50,
    Default = _G.Settings.VisualContrast * 100,
    Round = 0,
    Flag = "Contrast",
    Callback = function(v)
        _G.Settings.VisualContrast = v / 100
    end,
});

local VisLighting = VisualTab:DrawSection({ Name = "Освещение", Position = 'right' });

VisLighting:AddDropdown({
    Name = "Время суток",
    Values = {"Default", "Day", "Sunset", "Sunrise", "Night"},
    Default = _G.Settings.TimeOfDayPreset,
    Flag = "TimeOfDay",
    Callback = function(v)
        _G.Settings.TimeOfDayPreset = v
        local lighting = game:GetService("Lighting")
        if v == "Day" then
            lighting.ClockTime = 14
        elseif v == "Sunset" then
            lighting.ClockTime = 18
        elseif v == "Sunrise" then
            lighting.ClockTime = 6.5
        elseif v == "Night" then
            lighting.ClockTime = 0
        end
    end,
});

VisLighting:AddToggle({
    Name = "Кастомное освещение",
    Flag = "CustomLighting",
    Default = _G.Settings.CustomLightingEnabled,
    Callback = function(v)
        _G.Settings.CustomLightingEnabled = v
        if v then
            local lighting = game:GetService("Lighting")
            lighting.Ambient = _G.Settings.CustomLightingColor
            lighting.OutdoorAmbient = _G.Settings.CustomLightingColor
        else
            local lighting = game:GetService("Lighting")
            lighting.Ambient = Color3.fromRGB(0, 0, 0)
            lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end,
});

VisLighting:AddToggle({
    Name = "Лучи Бога",
    Flag = "SunRays",
    Default = _G.Settings.SunRaysEnabled,
    Callback = function(v)
        _G.Settings.SunRaysEnabled = v
    end,
});

VisLighting:AddToggle({
    Name = "Туман",
    Flag = "CustomFog",
    Default = _G.Settings.CustomFogEnabled,
    Callback = function(v)
        _G.Settings.CustomFogEnabled = v
    end,
});

VisLighting:AddSlider({
    Name = "Старт тумана",
    Min = 0,
    Max = 500,
    Default = _G.Settings.CustomFogStart,
    Round = 0,
    Flag = "FogStart",
    Callback = function(v)
        _G.Settings.CustomFogStart = v
        if _G.Settings.CustomFogEnabled then
            game:GetService("Lighting").FogStart = v
        end
    end,
});

VisLighting:AddSlider({
    Name = "Конец тумана",
    Min = 100,
    Max = 3000,
    Default = _G.Settings.CustomFogEnd,
    Round = 0,
    Flag = "FogEnd",
    Callback = function(v)
        _G.Settings.CustomFogEnd = v
        if _G.Settings.CustomFogEnabled then
            game:GetService("Lighting").FogEnd = v
        end
    end,
});

local VisEffects = VisualTab:DrawSection({ Name = "Эффекты", Position = 'left' });

VisEffects:AddToggle({
    Name = "Блум",
    Flag = "Bloom",
    Default = _G.Settings.CustomBloomEnabled,
    Callback = function(v)
        _G.Settings.CustomBloomEnabled = v
    end,
});

VisEffects:AddSlider({
    Name = "Интенсивность блума",
    Min = 0,
    Max = 300,
    Default = _G.Settings.BloomIntensity * 100,
    Round = 0,
    Flag = "BloomIntensity",
    Callback = function(v)
        _G.Settings.BloomIntensity = v / 100
    end,
});

VisEffects:AddSlider({
    Name = "Размер блума",
    Min = 5,
    Max = 56,
    Default = _G.Settings.BloomSize,
    Round = 0,
    Flag = "BloomSize",
    Callback = function(v)
        _G.Settings.BloomSize = v
    end,
});

VisEffects:AddToggle({
    Name = "Full Bright",
    Flag = "FullBright",
    Default = _G.Settings.FullBright,
    Callback = function(v)
        _G.Settings.FullBright = v
        if v then
            local lighting = game:GetService("Lighting")
            lighting.Brightness = 2
            lighting.ClockTime = 14
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            lighting.GlobalShadows = false
        end
    end,
});

VisEffects:AddToggle({
    Name = "No Fog",
    Flag = "NoFog",
    Default = _G.Settings.NoFog,
    Callback = function(v)
        _G.Settings.NoFog = v
        if v then
            local lighting = game:GetService("Lighting")
            lighting.FogStart = 999999
            lighting.FogEnd = 999999
        end
    end,
});

local VisCrosshair = VisualTab:DrawSection({ Name = "Прицел", Position = 'right' });

VisCrosshair:AddToggle({
    Name = "Прицел",
    Flag = "Crosshair",
    Default = _G.Settings.ShowCrosshair,
    Callback = function(v)
        _G.Settings.ShowCrosshair = v
    end,
});

VisCrosshair:AddDropdown({
    Name = "Стиль",
    Values = {"Classic", "Dot", "Circle", "Dot & Circle", "Tactical"},
    Default = _G.Settings.CrosshairStyle,
    Flag = "CrosshairStyle",
    Callback = function(v)
        _G.Settings.CrosshairStyle = v
    end,
});

VisCrosshair:AddSlider({
    Name = "Размер",
    Min = 4,
    Max = 30,
    Default = _G.Settings.CrosshairSize,
    Round = 0,
    Flag = "CrosshairSize",
    Callback = function(v)
        _G.Settings.CrosshairSize = v
    end,
});

local VisCamera = VisualTab:DrawSection({ Name = "Камера", Position = 'left' });

VisCamera:AddToggle({
    Name = "Режим от третьего лица",
    Flag = "ThirdPersonKiller",
    Default = _G.Settings.KillerThirdPerson,
    Callback = function(v)
        _G.Settings.KillerThirdPerson = v
    end,
});

VisCamera:AddToggle({
    Name = "Бесконечный зум",
    Flag = "InfiniteZoom",
    Default = _G.Settings.InfiniteZoom,
    Callback = function(v)
        _G.Settings.InfiniteZoom = v
    end,
});

VisCamera:AddSlider({
    Name = "FOV",
    Min = 70,
    Max = 160,
    Default = _G.Settings.FOV,
    Round = 0,
    Flag = "FOV",
    Callback = function(v)
        _G.Settings.FOV = v
        local cam = workspace.CurrentCamera
        if cam then
            cam.FieldOfView = v
        end
    end,
});

local VisNetwork = VisualTab:DrawSection({ Name = "Сеть", Position = 'right' });

VisNetwork:AddToggle({
    Name = "Fake Lag",
    Flag = "FakeLag",
    Default = _G.Settings.FakeLag,
    Callback = function(v)
        _G.Settings.FakeLag = v
    end,
});

VisNetwork:AddSlider({
    Name = "Задержка Fake Lag",
    Min = 50,
    Max = 1000,
    Default = _G.Settings.FakeLagMs,
    Round = 0,
    Flag = "FakeLagMs",
    Callback = function(v)
        _G.Settings.FakeLagMs = v
    end,
});

VisNetwork:AddToggle({
    Name = "Desync",
    Flag = "Desync",
    Default = _G.Settings.Desync,
    Callback = function(v)
        _G.Settings.Desync = v
    end,
});

VisNetwork:AddToggle({
    Name = "Призрак",
    Flag = "Ghost",
    Default = _G.Settings.EnableDesyncGhost,
    Callback = function(v)
        _G.Settings.EnableDesyncGhost = v
    end,
});

local VisFlashlight = VisualTab:DrawSection({ Name = "Фонарик", Position = 'left' });

VisFlashlight:AddDropdown({
    Name = "Эффект",
    Values = {"None", "Rainbow", "Strobe", "Ultra Bright"},
    Default = _G.Settings.FlashlightEffect,
    Flag = "FlashlightEffect",
    Callback = function(v)
        _G.Settings.FlashlightEffect = v
    end,
});

-- ============================================
-- Категория: Конфиги
-- ============================================

Window:DrawCategory({ Name = "Конфиг" });

local ConfigTab = Window:DrawTab({
    Name = "Конфиг",
    Icon = "folder",
    Type = "Single",
    EnableScrolling = true
});

local ConfigSection = ConfigTab:DrawSection({ Name = "Управление конфигами", Position = 'left' });

ConfigSection:AddButton({
    Name = "Сохранить конфиг",
    Callback = function()
        local success, err = pcall(function()
            local json = game:GetService("HttpService"):JSONEncode(_G.Settings)
            if writefile then
                writefile("VD_6locc_Config.json", json)
                print("Config saved!")
            end
        end)
        if not success then
            print("Error saving config: " .. tostring(err))
        end
    end,
});

ConfigSection:AddButton({
    Name = "Загрузить конфиг",
    Callback = function()
        local success, err = pcall(function()
            if isfile and isfile("VD_6locc_Config.json") then
                local json = readfile("VD_6locc_Config.json")
                local data = game:GetService("HttpService"):JSONDecode(json)
                for k, v in pairs(data) do
                    _G.Settings[k] = v
                end
                print("Config loaded!")
            end
        end)
        if not success then
            print("Error loading config: " .. tostring(err))
        end
    end,
});

ConfigSection:AddButton({
    Name = "Сбросить настройки",
    Callback = function()
        _G.Settings = nil
        print("Settings reset! Reload script.")
    end,
});

ConfigSection:AddButton({
    Name = "Выгрузить скрипт",
    Callback = function()
        Window:Destroy()
        print("Script unloaded!")
    end,
});

-- ============================================
--  ЗАПУСК ЛОГИКИ (фоновые потоки)
-- ============================================

task.spawn(function()
    while true do
        task.wait(0.5)
        
        -- ESP Logic
        if _G.Settings.MasterESP then
            -- Killer ESP
            if _G.Settings.KillerESP.Enabled then
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        local team = player.Team
                        if team and team.Name == "Killer" then
                            local char = player.Character
                            if char then
                                local highlight = char:FindFirstChild("Highlight")
                                if not highlight then
                                    highlight = Instance.new("Highlight")
                                    highlight.Name = "Highlight"
                                    highlight.Parent = char
                                end
                                highlight.FillColor = _G.Settings.ESPColors.Killer
                                highlight.FillTransparency = 0.6
                                highlight.Enabled = true
                            end
                        end
                    end
                end
            end
            
            -- Survivor ESP
            if _G.Settings.SurvivorESP.Enabled then
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        local team = player.Team
                        if team and team.Name == "Survivors" then
                            local char = player.Character
                            if char then
                                local highlight = char:FindFirstChild("Highlight")
                                if not highlight then
                                    highlight = Instance.new("Highlight")
                                    highlight.Name = "Highlight"
                                    highlight.Parent = char
                                end
                                highlight.FillColor = _G.Settings.ESPColors.SurvivorHealthy
                                highlight.FillTransparency = 0.6
                                highlight.Enabled = true
                            end
                        end
                    end
                end
            end
        end
        
        -- Speed Boost Logic
        if _G.Settings.SpeedBoostEnabled then
            local char = game.Players.LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = 16 * _G.Settings.SpeedBoost
                end
            end
        end
        
        -- Auto Moonwalk Logic
        if _G.Settings.AutoMoonwalk then
            local char = game.Players.LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera
            if hum and root and cam then
                hum.AutoRotate = false
                local look = cam.CFrame.LookVector
                local angle = math.atan2(look.X, look.Z)
                local time = tick()
                local sway = math.sin(time * _G.Settings.MoonwalkSwaySpeed) * _G.Settings.MoonwalkSwayAmplitude
                local shake = (math.random() - 0.5) * _G.Settings.MoonwalkShaking
                local newAngle = angle + sway + shake
                root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, newAngle, 0)
            end
        end
        
        -- Rainbow Character Logic
        if _G.Settings.RainbowCharacter then
            local char = game.Players.LocalPlayer.Character
            if char then
                local hue = tick() % 4 / 4
                local color = Color3.fromHSV(hue, 1, 1)
                if _G.Settings.RainbowCharacterMode == "Highlight" then
                    local hl = char:FindFirstChild("RainbowHL")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "RainbowHL"
                        hl.Parent = char
                    end
                    hl.FillColor = color
                    hl.FillTransparency = 0.4
                    hl.Enabled = true
                else
                    for _, part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.Color = color
                            if _G.Settings.RainbowCharacterMode == "ForceField" then
                                part.Material = Enum.Material.ForceField
                            end
                        end
                    end
                end
            end
        end
        
        -- Noclip Logic
        if _G.Settings.NoclipVaultsPallets then
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
        
        -- No Fog Logic
        if _G.Settings.NoFog then
            local lighting = game:GetService("Lighting")
            lighting.FogStart = 999999
            lighting.FogEnd = 999999
        end
        
        -- Full Bright Logic
        if _G.Settings.FullBright then
            local lighting = game:GetService("Lighting")
            lighting.Brightness = 2
            lighting.ClockTime = 14
            lighting.Ambient = Color3.fromRGB(255, 255, 255)
            lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            lighting.GlobalShadows = false
        end
        
        -- Auto Farm Survivor Logic
        if _G.Settings.AutoFarmSurvivor then
            local char = game.Players.LocalPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local nearest = nil
                local dist = math.huge
                for _, gen in ipairs(workspace:GetDescendants()) do
                    if gen.Name == "Generator" then
                        local pos = gen:IsA("Model") and gen:GetPivot and gen:GetPivot().Position or gen.Position
                        if pos then
                            local d = (pos - root.Position).Magnitude
                            if d < dist and d < 50 then
                                dist = d
                                nearest = gen
                            end
                        end
                    end
                end
                if nearest then
                    root.CFrame = CFrame.new(nearest:GetPivot().Position + Vector3.new(0, 3, 0))
                    task.wait(0.1)
                    local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
                    if remotes then
                        local genRemote = remotes:FindFirstChild("Generator")
                        if genRemote then
                            local repEvent = genRemote:FindFirstChild("RepairEvent")
                            if repEvent then
                                repEvent:FireServer(nearest, true)
                            end
                        end
                    end
                end
            end
        end
        
        -- Instant Heal Logic
        if _G.Settings.InstantHeal then
            local char = game.Players.LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
            end
        end
    end
end)

-- ============================================
--  ОБРАБОТЧИК КЛАВИШ
-- ============================================

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    local key = input.KeyCode
    if not key then return end
    
    local binds = _G.Settings.Keybinds
    
    if key == Enum.KeyCode[binds.ToggleUI] then
        if Window.Visible then
            Window:Hide()
        else
            Window:Show()
        end
    end
    
    if key == Enum.KeyCode[binds.ToggleSpeedBoost] then
        _G.Settings.SpeedBoostEnabled = not _G.Settings.SpeedBoostEnabled
    end
    
    if key == Enum.KeyCode[binds.AutoMoonwalk] then
        _G.Settings.AutoMoonwalk = not _G.Settings.AutoMoonwalk
    end
    
    if key == Enum.KeyCode[binds.AutoSkillCheck] then
        _G.Settings.AutoSkillCheck = not _G.Settings.AutoSkillCheck
    end
    
    if key == Enum.KeyCode[binds.InstantHeal] then
        local char = game.Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end
end)

print("6locc VD Hub loaded! Press " .. _G.Settings.Keybinds.ToggleUI .. " to open menu.")
