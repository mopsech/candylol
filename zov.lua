--[[
    Violence District Hub (6locc Logic)
    Портировано на Compkiller UI
    Открытие: Left Alt
]]

-- ПРОВЕРКА: загрузка библиотеки
local success, Compkiller = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/CompKiller/refs/heads/main/src/source.luau"))()
end)

if not success or not Compkiller then
    warn("Failed to load Compkiller library!")
    return
end

-- Конфиг менеджер
local ConfigManager = Compkiller:ConfigManager({
    Directory = "VD-6locc",
    Config = "Settings"
})

-- Загрузочный экран
Compkiller:Loader("rbxassetid://120245531583106", 1.5).yield()

-- Создание окна
local MenuKey = "LeftAlt"

local Window = Compkiller.new({
    Name = "6LOCC VD",
    Keybind = MenuKey,
    Logo = "rbxassetid://120245531583106",
    Scale = Compkiller.Scale.Window,
    TextSize = 15,
})

-- Настройки пользователя
local UserSettings = Window.UserSettings:Create()

UserSettings:AddColorPicker({
    Name = "Цвет меню",
    Default = Compkiller.Colors.Highlight,
    Callback = function(f)
        Compkiller.Colors.Highlight = f
        Compkiller:RefreshCurrentColor()
    end,
})

UserSettings:AddKeybind({
    Name = "Клавиша меню",
    Default = MenuKey,
    Callback = function(f)
        MenuKey = f
        Window:SetMenuKey(MenuKey)
    end,
})

UserSettings:AddDropdown({
    Name = "Тема",
    Values = {"Default", "Dark Green", "Dark Blue", "Purple Rose", "Skeet"},
    Default = "Default",
    Callback = function(f)
        Compkiller:SetTheme(f)
    end,
})

-- Водяной знак
local Watermark = Window:Watermark()

Watermark:AddText({
    Icon = "user",
    Text = "6LOCC VD",
})

Watermark:AddText({
    Icon = "clock",
    Text = Compkiller:GetDate(),
})

local Time = Watermark:AddText({
    Icon = "timer",
    Text = "TIME",
})

task.spawn(function()
    while true do
        task.wait()
        Time:SetText(Compkiller:GetTimeNow())
    end
end)

Watermark:AddText({
    Icon = "server",
    Text = Compkiller.Version,
})

-- ============================================
--  ГЛОБАЛЬНЫЕ НАСТРОЙКИ
-- ============================================

_G.Settings = _G.Settings or {}

local function ensureSettings()
    -- ESP
    _G.Settings.MasterESP = _G.Settings.MasterESP ~= nil and _G.Settings.MasterESP or true
    _G.Settings.KillerESP = _G.Settings.KillerESP or {}
    _G.Settings.KillerESP.Enabled = _G.Settings.KillerESP.Enabled ~= nil and _G.Settings.KillerESP.Enabled or false
    _G.Settings.KillerESP.Aura = _G.Settings.KillerESP.Aura ~= nil and _G.Settings.KillerESP.Aura or true
    _G.Settings.KillerESP.Distance = _G.Settings.KillerESP.Distance ~= nil and _G.Settings.KillerESP.Distance or true
    _G.Settings.KillerESP.SelectedKiller = _G.Settings.KillerESP.SelectedKiller ~= nil and _G.Settings.KillerESP.SelectedKiller or true
    _G.Settings.KillerESP.ShowName = _G.Settings.KillerESP.ShowName ~= nil and _G.Settings.KillerESP.ShowName or true
    
    _G.Settings.SurvivorESP = _G.Settings.SurvivorESP or {}
    _G.Settings.SurvivorESP.Enabled = _G.Settings.SurvivorESP.Enabled ~= nil and _G.Settings.SurvivorESP.Enabled or false
    _G.Settings.SurvivorESP.Aura = _G.Settings.SurvivorESP.Aura ~= nil and _G.Settings.SurvivorESP.Aura or true
    _G.Settings.SurvivorESP.Distance = _G.Settings.SurvivorESP.Distance ~= nil and _G.Settings.SurvivorESP.Distance or true
    _G.Settings.SurvivorESP.HealthState = _G.Settings.SurvivorESP.HealthState ~= nil and _G.Settings.SurvivorESP.HealthState or true
    _G.Settings.SurvivorESP.ShowHookCount = _G.Settings.SurvivorESP.ShowHookCount ~= nil and _G.Settings.SurvivorESP.ShowHookCount or true
    _G.Settings.SurvivorESP.ShowName = _G.Settings.SurvivorESP.ShowName ~= nil and _G.Settings.SurvivorESP.ShowName or true
    _G.Settings.SurvivorESP.CensorNames = _G.Settings.SurvivorESP.CensorNames ~= nil and _G.Settings.SurvivorESP.CensorNames or false
    
    _G.Settings.GeneratorESP = _G.Settings.GeneratorESP or {}
    _G.Settings.GeneratorESP.Enabled = _G.Settings.GeneratorESP.Enabled ~= nil and _G.Settings.GeneratorESP.Enabled or false
    _G.Settings.GeneratorESP.Aura = _G.Settings.GeneratorESP.Aura ~= nil and _G.Settings.GeneratorESP.Aura or true
    _G.Settings.GeneratorESP.ShowProgress = _G.Settings.GeneratorESP.ShowProgress ~= nil and _G.Settings.GeneratorESP.ShowProgress or true
    _G.Settings.GeneratorESP.ShowRepairSpeed = _G.Settings.GeneratorESP.ShowRepairSpeed ~= nil and _G.Settings.GeneratorESP.ShowRepairSpeed or true
    _G.Settings.GeneratorESP.ShowETA = _G.Settings.GeneratorESP.ShowETA ~= nil and _G.Settings.GeneratorESP.ShowETA or true
    _G.Settings.GeneratorESP.AlertThresholdEnabled = _G.Settings.GeneratorESP.AlertThresholdEnabled ~= nil and _G.Settings.GeneratorESP.AlertThresholdEnabled or true
    _G.Settings.GeneratorESP.AlertThreshold = _G.Settings.GeneratorESP.AlertThreshold or 90
    _G.Settings.GeneratorESP.ShowDistance = _G.Settings.GeneratorESP.ShowDistance ~= nil and _G.Settings.GeneratorESP.ShowDistance or true
    _G.Settings.GeneratorESP.ShowRepairingCount = _G.Settings.GeneratorESP.ShowRepairingCount ~= nil and _G.Settings.GeneratorESP.ShowRepairingCount or true
    _G.Settings.GeneratorESP.NoText = _G.Settings.GeneratorESP.NoText ~= nil and _G.Settings.GeneratorESP.NoText or false
    
    _G.Settings.HookESP = _G.Settings.HookESP or {}
    _G.Settings.HookESP.Enabled = _G.Settings.HookESP.Enabled ~= nil and _G.Settings.HookESP.Enabled or false
    _G.Settings.HookESP.Aura = _G.Settings.HookESP.Aura ~= nil and _G.Settings.HookESP.Aura or true
    _G.Settings.HookESP.ShowDistance = _G.Settings.HookESP.ShowDistance ~= nil and _G.Settings.HookESP.ShowDistance or true
    _G.Settings.HookESP.NoText = _G.Settings.HookESP.NoText ~= nil and _G.Settings.HookESP.NoText or false
    
    _G.Settings.PalletESP = _G.Settings.PalletESP or {}
    _G.Settings.PalletESP.Enabled = _G.Settings.PalletESP.Enabled ~= nil and _G.Settings.PalletESP.Enabled or false
    _G.Settings.PalletESP.Aura = _G.Settings.PalletESP.Aura ~= nil and _G.Settings.PalletESP.Aura or true
    _G.Settings.PalletESP.ShowDistance = _G.Settings.PalletESP.ShowDistance ~= nil and _G.Settings.PalletESP.ShowDistance or true
    _G.Settings.PalletESP.NoText = _G.Settings.PalletESP.NoText ~= nil and _G.Settings.PalletESP.NoText or false
    
    _G.Settings.VaultESP = _G.Settings.VaultESP or {}
    _G.Settings.VaultESP.Enabled = _G.Settings.VaultESP.Enabled ~= nil and _G.Settings.VaultESP.Enabled or false
    _G.Settings.VaultESP.Aura = _G.Settings.VaultESP.Aura ~= nil and _G.Settings.VaultESP.Aura or true
    _G.Settings.VaultESP.ShowDistance = _G.Settings.VaultESP.ShowDistance ~= nil and _G.Settings.VaultESP.ShowDistance or true
    _G.Settings.VaultESP.NoText = _G.Settings.VaultESP.NoText ~= nil and _G.Settings.VaultESP.NoText or false
    
    _G.Settings.GateESP = _G.Settings.GateESP or {}
    _G.Settings.GateESP.Enabled = _G.Settings.GateESP.Enabled ~= nil and _G.Settings.GateESP.Enabled or false
    _G.Settings.GateESP.Aura = _G.Settings.GateESP.Aura ~= nil and _G.Settings.GateESP.Aura or true
    _G.Settings.GateESP.ShowProgress = _G.Settings.GateESP.ShowProgress ~= nil and _G.Settings.GateESP.ShowProgress or true
    _G.Settings.GateESP.ShowDistance = _G.Settings.GateESP.ShowDistance ~= nil and _G.Settings.GateESP.ShowDistance or true
    _G.Settings.GateESP.NoText = _G.Settings.GateESP.NoText ~= nil and _G.Settings.GateESP.NoText or false
    
    _G.Settings.BloodESP = _G.Settings.BloodESP or {}
    _G.Settings.BloodESP.Enabled = _G.Settings.BloodESP.Enabled ~= nil and _G.Settings.BloodESP.Enabled or false
    _G.Settings.BloodESP.Aura = _G.Settings.BloodESP.Aura ~= nil and _G.Settings.BloodESP.Aura or true
    _G.Settings.BloodESP.ShowDistance = _G.Settings.BloodESP.ShowDistance ~= nil and _G.Settings.BloodESP.ShowDistance or true
    _G.Settings.BloodESP.NoText = _G.Settings.BloodESP.NoText ~= nil and _G.Settings.BloodESP.NoText or false
    
    _G.Settings.SCPESP = _G.Settings.SCPESP or {}
    _G.Settings.SCPESP.Enabled = _G.Settings.SCPESP.Enabled ~= nil and _G.Settings.SCPESP.Enabled or false
    _G.Settings.SCPESP.Aura = _G.Settings.SCPESP.Aura ~= nil and _G.Settings.SCPESP.Aura or true
    _G.Settings.SCPESP.ShowDistance = _G.Settings.SCPESP.ShowDistance ~= nil and _G.Settings.SCPESP.ShowDistance or true
    _G.Settings.SCPESP.NoText = _G.Settings.SCPESP.NoText ~= nil and _G.Settings.SCPESP.NoText or false
    
    _G.Settings.ESPStyle = _G.Settings.ESPStyle or "Standard"
    _G.Settings.ESPBackground = _G.Settings.ESPBackground ~= nil and _G.Settings.ESPBackground or false
    _G.Settings.ESPDistanceFade = _G.Settings.ESPDistanceFade ~= nil and _G.Settings.ESPDistanceFade or false
    _G.Settings.ESPDistanceFadePlayers = _G.Settings.ESPDistanceFadePlayers ~= nil and _G.Settings.ESPDistanceFadePlayers or true
    _G.Settings.ESPDistanceFadeMap = _G.Settings.ESPDistanceFadeMap ~= nil and _G.Settings.ESPDistanceFadeMap or true
    _G.Settings.ESPFadeStart = _G.Settings.ESPFadeStart or 50
    _G.Settings.ESPFadeMax = _G.Settings.ESPFadeMax or 200
    _G.Settings.ESPRange = _G.Settings.ESPRange or 999999
    _G.Settings.ESPTracers = _G.Settings.ESPTracers ~= nil and _G.Settings.ESPTracers or false
    _G.Settings.TracerTarget = _G.Settings.TracerTarget or "Both"
    _G.Settings.TracerStyle = _G.Settings.TracerStyle or "Line"
    _G.Settings.TracerOrigin = _G.Settings.TracerOrigin or "Bottom"
    _G.Settings.TracerColorMode = _G.Settings.TracerColorMode or "Role Color"
    _G.Settings.Minimap = _G.Settings.Minimap or {}
    _G.Settings.Minimap.Enabled = _G.Settings.Minimap.Enabled ~= nil and _G.Settings.Minimap.Enabled or false
    
    _G.Settings.ESPColors = _G.Settings.ESPColors or {}
    _G.Settings.ESPColors.Killer = _G.Settings.ESPColors.Killer or Color3.fromRGB(255, 50, 50)
    _G.Settings.ESPColors.SurvivorHealthy = _G.Settings.ESPColors.SurvivorHealthy or Color3.fromRGB(50, 255, 100)
    _G.Settings.ESPColors.SurvivorInjured = _G.Settings.ESPColors.SurvivorInjured or Color3.fromRGB(255, 150, 0)
    _G.Settings.ESPColors.SurvivorKnocked = _G.Settings.ESPColors.SurvivorKnocked or Color3.fromRGB(255, 50, 50)
    _G.Settings.ESPColors.Generator = _G.Settings.ESPColors.Generator or Color3.fromRGB(0, 200, 255)
    _G.Settings.ESPColors.Hook = _G.Settings.ESPColors.Hook or Color3.fromRGB(255, 150, 0)
    _G.Settings.ESPColors.Pallet = _G.Settings.ESPColors.Pallet or Color3.fromRGB(180, 130, 70)
    _G.Settings.ESPColors.Vault = _G.Settings.ESPColors.Vault or Color3.fromRGB(180, 180, 180)
    _G.Settings.ESPColors.BloodEffect = _G.Settings.ESPColors.BloodEffect or Color3.fromRGB(180, 0, 0)
    _G.Settings.ESPColors.Gate = _G.Settings.ESPColors.Gate or Color3.fromRGB(255, 255, 0)
    _G.Settings.ESPColors.SCP = _G.Settings.ESPColors.SCP or Color3.fromRGB(150, 0, 255)
    _G.Settings.ESPColors.Tracer = _G.Settings.ESPColors.Tracer or Color3.fromRGB(255, 255, 255)
    
    -- Farm
    _G.Settings.AutoFarmSurvivor = _G.Settings.AutoFarmSurvivor ~= nil and _G.Settings.AutoFarmSurvivor or false
    _G.Settings.AutoServerHopEscape = _G.Settings.AutoServerHopEscape ~= nil and _G.Settings.AutoServerHopEscape or false
    _G.Settings.AutoFarmAFKTotal = _G.Settings.AutoFarmAFKTotal ~= nil and _G.Settings.AutoFarmAFKTotal or false
    _G.Settings.AutoFarmKiller = _G.Settings.AutoFarmKiller ~= nil and _G.Settings.AutoFarmKiller or false
    _G.Settings.AntiWiggle = _G.Settings.AntiWiggle ~= nil and _G.Settings.AntiWiggle or false
    _G.Settings.AutoSkillCheck = _G.Settings.AutoSkillCheck ~= nil and _G.Settings.AutoSkillCheck or false
    _G.Settings.InstantSkillCheck = _G.Settings.InstantSkillCheck ~= nil and _G.Settings.InstantSkillCheck or false
    _G.Settings.SkillCheckMode = _G.Settings.SkillCheckMode or "Perfect"
    _G.Settings.PerfectHitRate = _G.Settings.PerfectHitRate or 100
    _G.Settings.SkillCheckSpeedVal = _G.Settings.SkillCheckSpeedVal or 1
    _G.Settings.NoSkillChecks = _G.Settings.NoSkillChecks ~= nil and _G.Settings.NoSkillChecks or false
    _G.Settings.FlowstatePerk = _G.Settings.FlowstatePerk ~= nil and _G.Settings.FlowstatePerk or false
    _G.Settings.FlowstateCooldown = _G.Settings.FlowstateCooldown or 15
    _G.Settings.HideFlowstateUI = _G.Settings.HideFlowstateUI ~= nil and _G.Settings.HideFlowstateUI or false
    
    -- Modifiers
    _G.Settings.SpeedBoostEnabled = _G.Settings.SpeedBoostEnabled ~= nil and _G.Settings.SpeedBoostEnabled or false
    _G.Settings.SpeedBoost = _G.Settings.SpeedBoost or 1.3
    _G.Settings.CountSpeedPerks = _G.Settings.CountSpeedPerks ~= nil and _G.Settings.CountSpeedPerks or true
    _G.Settings.VaultSpeed = _G.Settings.VaultSpeed or 1
    _G.Settings.ModifierTeamFilter = _G.Settings.ModifierTeamFilter or "Both"
    _G.Settings.InstantHeal = _G.Settings.InstantHeal ~= nil and _G.Settings.InstantHeal or false
    _G.Settings.NoclipVaultsPallets = _G.Settings.NoclipVaultsPallets ~= nil and _G.Settings.NoclipVaultsPallets or false
    _G.Settings.AutoFleeKiller = _G.Settings.AutoFleeKiller ~= nil and _G.Settings.AutoFleeKiller or false
    _G.Settings.AutoMoonwalk = _G.Settings.AutoMoonwalk ~= nil and _G.Settings.AutoMoonwalk or false
    _G.Settings.ReverseMoonwalk = _G.Settings.ReverseMoonwalk ~= nil and _G.Settings.ReverseMoonwalk or false
    _G.Settings.MoonwalkDisableOnVault = _G.Settings.MoonwalkDisableOnVault ~= nil and _G.Settings.MoonwalkDisableOnVault or true
    _G.Settings.MoonwalkSwaySpeed = _G.Settings.MoonwalkSwaySpeed or 14
    _G.Settings.MoonwalkSwayAmplitude = _G.Settings.MoonwalkSwayAmplitude or 0.65
    _G.Settings.MoonwalkShaking = _G.Settings.MoonwalkShaking or 0.05
    _G.Settings.MoonwalkMovementBased = _G.Settings.MoonwalkMovementBased ~= nil and _G.Settings.MoonwalkMovementBased or false
    _G.Settings.RainbowCharacter = _G.Settings.RainbowCharacter ~= nil and _G.Settings.RainbowCharacter or false
    _G.Settings.RainbowCharacterMode = _G.Settings.RainbowCharacterMode or "Highlight"
    _G.Settings.RemoteDropPallet = _G.Settings.RemoteDropPallet ~= nil and _G.Settings.RemoteDropPallet or false
    _G.Settings.RemoteDropPalletKey = _G.Settings.RemoteDropPalletKey or "None"
    _G.Settings.WalkWhileEmoting = _G.Settings.WalkWhileEmoting ~= nil and _G.Settings.WalkWhileEmoting or true
    _G.Settings.CustomEmoteWheel = _G.Settings.CustomEmoteWheel ~= nil and _G.Settings.CustomEmoteWheel or true
    _G.Settings.EmoteWheelKey = _G.Settings.EmoteWheelKey or "F"
    _G.Settings.EmoteWheelMode = _G.Settings.EmoteWheelMode or "Hold"
    
    -- Combat
    _G.Settings.AutoParry = _G.Settings.AutoParry ~= nil and _G.Settings.AutoParry or false
    _G.Settings.ParryUseItem = _G.Settings.ParryUseItem ~= nil and _G.Settings.ParryUseItem or false
    _G.Settings.ParryRange = _G.Settings.ParryRange or 14
    _G.Settings.ParryPingCompensation = _G.Settings.ParryPingCompensation ~= nil and _G.Settings.ParryPingCompensation or true
    _G.Settings.ParryRangeESP = _G.Settings.ParryRangeESP ~= nil and _G.Settings.ParryRangeESP or false
    _G.Settings.ParryDelay = _G.Settings.ParryDelay or 0
    _G.Settings.ParryFacingCheck = _G.Settings.ParryFacingCheck ~= nil and _G.Settings.ParryFacingCheck or true
    _G.Settings.HideParryUI = _G.Settings.HideParryUI ~= nil and _G.Settings.HideParryUI or false
    _G.Settings.FrenzyParry = _G.Settings.FrenzyParry ~= nil and _G.Settings.FrenzyParry or false
    _G.Settings.IgnoreAbysswalkerLunge = _G.Settings.IgnoreAbysswalkerLunge ~= nil and _G.Settings.IgnoreAbysswalkerLunge or false
    _G.Settings.SimulateParryAnimation = _G.Settings.SimulateParryAnimation ~= nil and _G.Settings.SimulateParryAnimation or false
    _G.Settings.NoStun = _G.Settings.NoStun ~= nil and _G.Settings.NoStun or false
    
    _G.Settings.AimAssist = _G.Settings.AimAssist or {}
    _G.Settings.AimAssist.Enabled = _G.Settings.AimAssist.Enabled ~= nil and _G.Settings.AimAssist.Enabled or false
    _G.Settings.AimAssist.TargetPart = _G.Settings.AimAssist.TargetPart or "UpperTorso"
    _G.Settings.AimAssist.Priority = _G.Settings.AimAssist.Priority or "Nearest"
    _G.Settings.AimAssist.FOV = _G.Settings.AimAssist.FOV or 150
    _G.Settings.AimAssist.ShowFOV = _G.Settings.AimAssist.ShowFOV ~= nil and _G.Settings.AimAssist.ShowFOV or false
    _G.Settings.AimAssist.Prediction = _G.Settings.AimAssist.Prediction ~= nil and _G.Settings.AimAssist.Prediction or true
    
    -- Revolver
    _G.Settings.RevolverAutofarm = _G.Settings.RevolverAutofarm ~= nil and _G.Settings.RevolverAutofarm or false
    _G.Settings.RevolverAimbot = _G.Settings.RevolverAimbot or {}
    _G.Settings.RevolverAimbot.Enabled = _G.Settings.RevolverAimbot.Enabled ~= nil and _G.Settings.RevolverAimbot.Enabled or false
    _G.Settings.RevolverAimbot.TargetPart = _G.Settings.RevolverAimbot.TargetPart or "UpperTorso"
    _G.Settings.RevolverAimbot.Priority = _G.Settings.RevolverAimbot.Priority or "Nearest"
    _G.Settings.RevolverAimbot.Radius = _G.Settings.RevolverAimbot.Radius or 150
    _G.Settings.RevolverAimbot.ShowFOV = _G.Settings.RevolverAimbot.ShowFOV ~= nil and _G.Settings.RevolverAimbot.ShowFOV or false
    _G.Settings.RevolverAimbot.PredictionEnabled = _G.Settings.RevolverAimbot.PredictionEnabled ~= nil and _G.Settings.RevolverAimbot.PredictionEnabled or true
    _G.Settings.RevolverAimbot.BulletVelocity = _G.Settings.RevolverAimbot.BulletVelocity or 800
    
    _G.Settings.RevolverSilentAim = _G.Settings.RevolverSilentAim or {}
    _G.Settings.RevolverSilentAim.Enabled = _G.Settings.RevolverSilentAim.Enabled ~= nil and _G.Settings.RevolverSilentAim.Enabled or false
    _G.Settings.RevolverSilentAim.Priority = _G.Settings.RevolverSilentAim.Priority or "Nearest"
    _G.Settings.RevolverSilentAim.FOVRadius = _G.Settings.RevolverSilentAim.FOVRadius or 200
    _G.Settings.RevolverSilentAim.ShowFOV = _G.Settings.RevolverSilentAim.ShowFOV ~= nil and _G.Settings.RevolverSilentAim.ShowFOV or true
    _G.Settings.RevolverSilentAim.FOVColor = _G.Settings.RevolverSilentAim.FOVColor or "Cyan"
    _G.Settings.RevolverSilentAim.Target = _G.Settings.RevolverSilentAim.Target or "Both Teams"
    _G.Settings.RevolverSilentAim.TargetHighlightEnabled = _G.Settings.RevolverSilentAim.TargetHighlightEnabled ~= nil and _G.Settings.RevolverSilentAim.TargetHighlightEnabled or true
    _G.Settings.RevolverSilentAim.TargetHighlightColor = _G.Settings.RevolverSilentAim.TargetHighlightColor or "Cyan"
    
    _G.Settings.BypassToFRestrictions = _G.Settings.BypassToFRestrictions ~= nil and _G.Settings.BypassToFRestrictions or false
    
    -- Veil
    _G.Settings.SpearTrajectory = _G.Settings.SpearTrajectory ~= nil and _G.Settings.SpearTrajectory or false
    _G.Settings.SpearTrajectoryNoclip = _G.Settings.SpearTrajectoryNoclip ~= nil and _G.Settings.SpearTrajectoryNoclip or false
    _G.Settings.SpearTrajectoryColor = _G.Settings.SpearTrajectoryColor or "Cyan"
    _G.Settings.SpearAimbot = _G.Settings.SpearAimbot or {}
    _G.Settings.SpearAimbot.Enabled = _G.Settings.SpearAimbot.Enabled ~= nil and _G.Settings.SpearAimbot.Enabled or false
    _G.Settings.SpearAimbot.TargetPart = _G.Settings.SpearAimbot.TargetPart or "UpperTorso"
    _G.Settings.SpearAimbot.Priority = _G.Settings.SpearAimbot.Priority or "Nearest"
    _G.Settings.SpearAimbot.Radius = _G.Settings.SpearAimbot.Radius or 150
    _G.Settings.SpearAimbot.Speed = _G.Settings.SpearAimbot.Speed or 150
    _G.Settings.SpearAimbot.Gravity = _G.Settings.SpearAimbot.Gravity or 98
    
    _G.Settings.SpearSilentAim = _G.Settings.SpearSilentAim or {}
    _G.Settings.SpearSilentAim.Enabled = _G.Settings.SpearSilentAim.Enabled ~= nil and _G.Settings.SpearSilentAim.Enabled or false
    _G.Settings.SpearSilentAim.Priority = _G.Settings.SpearSilentAim.Priority or "Nearest"
    _G.Settings.SpearSilentAim.FOVRadius = _G.Settings.SpearSilentAim.FOVRadius or 240
    _G.Settings.SpearSilentAim.ShowFOV = _G.Settings.SpearSilentAim.ShowFOV ~= nil and _G.Settings.SpearSilentAim.ShowFOV or true
    _G.Settings.SpearSilentAim.FOVColor = _G.Settings.SpearSilentAim.FOVColor or "Yellow"
    _G.Settings.SpearSilentAim.TargetHighlightEnabled = _G.Settings.SpearSilentAim.TargetHighlightEnabled ~= nil and _G.Settings.SpearSilentAim.TargetHighlightEnabled or true
    _G.Settings.SpearSilentAim.TargetHighlightColor = _G.Settings.SpearSilentAim.TargetHighlightColor or "Red"
    
    -- Stalker
    _G.Settings.Stalker = _G.Settings.Stalker or {}
    _G.Settings.Stalker.NoCooldown = _G.Settings.Stalker.NoCooldown ~= nil and _G.Settings.Stalker.NoCooldown or false
    _G.Settings.Stalker.KillGrab = _G.Settings.Stalker.KillGrab ~= nil and _G.Settings.Stalker.KillGrab or false
    _G.Settings.Stalker.AutoDodge = _G.Settings.Stalker.AutoDodge ~= nil and _G.Settings.Stalker.AutoDodge or false
    _G.Settings.Stalker.AutoDodgeDistance = _G.Settings.Stalker.AutoDodgeDistance or 15
    _G.Settings.Stalker.StalkWhileMoving = _G.Settings.Stalker.StalkWhileMoving ~= nil and _G.Settings.Stalker.StalkWhileMoving or false
    _G.Settings.Stalker.InfiniteCorrupt = _G.Settings.Stalker.InfiniteCorrupt ~= nil and _G.Settings.Stalker.InfiniteCorrupt or false
    
    -- Masked
    _G.Settings.Masked = _G.Settings.Masked or {}
    _G.Settings.Masked.CurrentBuff = _G.Settings.Masked.CurrentBuff or "Normal"
    
    -- Visuals
    _G.Settings.RTXGraphics = _G.Settings.RTXGraphics ~= nil and _G.Settings.RTXGraphics or false
    _G.Settings.CinematicDOF = _G.Settings.CinematicDOF ~= nil and _G.Settings.CinematicDOF or false
    _G.Settings.GraphicsTint = _G.Settings.GraphicsTint or "Default"
    _G.Settings.VisualPreset = _G.Settings.VisualPreset or "Default"
    _G.Settings.VisualSaturation = _G.Settings.VisualSaturation or 0.25
    _G.Settings.VisualContrast = _G.Settings.VisualContrast or 0.12
    _G.Settings.CustomFogEnabled = _G.Settings.CustomFogEnabled ~= nil and _G.Settings.CustomFogEnabled or false
    _G.Settings.CustomFogColor = _G.Settings.CustomFogColor or Color3.fromRGB(120, 160, 200)
    _G.Settings.CustomFogStart = _G.Settings.CustomFogStart or 0
    _G.Settings.CustomFogEnd = _G.Settings.CustomFogEnd or 800
    _G.Settings.CustomLightingEnabled = _G.Settings.CustomLightingEnabled ~= nil and _G.Settings.CustomLightingEnabled or false
    _G.Settings.CustomLightingColor = _G.Settings.CustomLightingColor or Color3.fromRGB(255, 255, 255)
    _G.Settings.TimeOfDayPreset = _G.Settings.TimeOfDayPreset or "Default"
    _G.Settings.CustomBloomEnabled = _G.Settings.CustomBloomEnabled ~= nil and _G.Settings.CustomBloomEnabled or false
    _G.Settings.BloomIntensity = _G.Settings.BloomIntensity or 0.8
    _G.Settings.BloomSize = _G.Settings.BloomSize or 24
    _G.Settings.BloomThreshold = _G.Settings.BloomThreshold or 0.85
    _G.Settings.SunRaysEnabled = _G.Settings.SunRaysEnabled ~= nil and _G.Settings.SunRaysEnabled or false
    _G.Settings.SunRaysIntensity = _G.Settings.SunRaysIntensity or 0.1
    _G.Settings.AtmosphereDensity = _G.Settings.AtmosphereDensity or 0.3
    _G.Settings.InfiniteZoom = _G.Settings.InfiniteZoom ~= nil and _G.Settings.InfiniteZoom or false
    _G.Settings.FOV = _G.Settings.FOV or 70
    _G.Settings.StretchedResolutionMode = _G.Settings.StretchedResolutionMode or "Normal"
    _G.Settings.ShowCrosshair = _G.Settings.ShowCrosshair ~= nil and _G.Settings.ShowCrosshair or false
    _G.Settings.CrosshairStyle = _G.Settings.CrosshairStyle or "Classic"
    _G.Settings.CrosshairColor = _G.Settings.CrosshairColor or Color3.fromRGB(0, 255, 255)
    _G.Settings.CrosshairSize = _G.Settings.CrosshairSize or 10
    _G.Settings.NoFog = _G.Settings.NoFog ~= nil and _G.Settings.NoFog or false
    _G.Settings.FullBright = _G.Settings.FullBright ~= nil and _G.Settings.FullBright or false
    _G.Settings.NoFlashlightBlind = _G.Settings.NoFlashlightBlind ~= nil and _G.Settings.NoFlashlightBlind or false
    _G.Settings.KillerThirdPerson = _G.Settings.KillerThirdPerson ~= nil and _G.Settings.KillerThirdPerson or false
    _G.Settings.FlashlightEffect = _G.Settings.FlashlightEffect or "None"
    _G.Settings.FlashlightColor = _G.Settings.FlashlightColor or Color3.fromRGB(255, 255, 255)
    _G.Settings.KillerStainColor = _G.Settings.KillerStainColor or Color3.fromRGB(255, 0, 0)
    
    -- Network
    _G.Settings.FakeLag = _G.Settings.FakeLag ~= nil and _G.Settings.FakeLag or false
    _G.Settings.FakeLagMs = _G.Settings.FakeLagMs or 200
    _G.Settings.Desync = _G.Settings.Desync ~= nil and _G.Settings.Desync or false
    _G.Settings.EnableDesyncGhost = _G.Settings.EnableDesyncGhost ~= nil and _G.Settings.EnableDesyncGhost or true
    _G.Settings.DesyncGhostAlwaysOnTop = _G.Settings.DesyncGhostAlwaysOnTop ~= nil and _G.Settings.DesyncGhostAlwaysOnTop or true
    _G.Settings.DesyncGhostTransparency = _G.Settings.DesyncGhostTransparency or 0.5
    _G.Settings.DesyncGhostColor = _G.Settings.DesyncGhostColor or "Accent"
    
    -- UI
    _G.Settings.ShowInfoBanner = _G.Settings.ShowInfoBanner ~= nil and _G.Settings.ShowInfoBanner or false
    _G.Settings.InfoBannerShowMap = _G.Settings.InfoBannerShowMap ~= nil and _G.Settings.InfoBannerShowMap or true
    _G.Settings.InfoBannerShowKiller = _G.Settings.InfoBannerShowKiller ~= nil and _G.Settings.InfoBannerShowKiller or true
    _G.Settings.InfoBannerShowPerks = _G.Settings.InfoBannerShowPerks ~= nil and _G.Settings.InfoBannerShowPerks or true
    _G.Settings.InfoBannerShowFPS = _G.Settings.InfoBannerShowFPS ~= nil and _G.Settings.InfoBannerShowFPS or true
    _G.Settings.InfoBannerShowPing = _G.Settings.InfoBannerShowPing ~= nil and _G.Settings.InfoBannerShowPing or true
    _G.Settings.DisableAllNotifications = _G.Settings.DisableAllNotifications ~= nil and _G.Settings.DisableAllNotifications or false
    _G.Settings.ShowToggleNotifications = _G.Settings.ShowToggleNotifications ~= nil and _G.Settings.ShowToggleNotifications or true
    _G.Settings.ShowActiveFeatures = _G.Settings.ShowActiveFeatures ~= nil and _G.Settings.ShowActiveFeatures or false
    _G.Settings.ShowSpectatorList = _G.Settings.ShowSpectatorList ~= nil and _G.Settings.ShowSpectatorList or false
    _G.Settings.ShowHotkeyOverlay = _G.Settings.ShowHotkeyOverlay ~= nil and _G.Settings.ShowHotkeyOverlay or false
    _G.Settings.Theme = _G.Settings.Theme or "Default"
    _G.Settings.HideLivePlayersMode = _G.Settings.HideLivePlayersMode or "Normal"
    _G.Settings.CustomOverlayUrl = _G.Settings.CustomOverlayUrl or "rbxassetid://71824917786372"
    _G.Settings.CustomBackground = _G.Settings.CustomBackground or {}
    _G.Settings.CustomBackground.Enabled = _G.Settings.CustomBackground.Enabled ~= nil and _G.Settings.CustomBackground.Enabled or false
    _G.Settings.CustomBackground.AssetId = _G.Settings.CustomBackground.AssetId or ""
    _G.Settings.CustomBackground.LocalFile = _G.Settings.CustomBackground.LocalFile or ""
    _G.Settings.CustomBackground.Overlay = _G.Settings.CustomBackground.Overlay or 40
    _G.Settings.CustomBackground.ScaleType = _G.Settings.CustomBackground.ScaleType or "Crop"
    
    -- Keybinds
    _G.Settings.Keybinds = _G.Settings.Keybinds or {}
    _G.Settings.Keybinds.ToggleUI = _G.Settings.Keybinds.ToggleUI or "K"
    _G.Settings.Keybinds.ToggleSpeedBoost = _G.Settings.Keybinds.ToggleSpeedBoost or "None"
    _G.Settings.Keybinds.AutoMoonwalk = _G.Settings.Keybinds.AutoMoonwalk or "None"
    _G.Settings.Keybinds.FlowstatePerk = _G.Settings.Keybinds.FlowstatePerk or "None"
    _G.Settings.Keybinds.AutoSkillCheck = _G.Settings.Keybinds.AutoSkillCheck or "None"
    _G.Settings.Keybinds.KillerTrack = _G.Settings.Keybinds.KillerTrack or "None"
    _G.Settings.Keybinds.SurvivorTrack = _G.Settings.Keybinds.SurvivorTrack or "None"
    _G.Settings.Keybinds.InstantEscape = _G.Settings.Keybinds.InstantEscape or "None"
    _G.Settings.Keybinds.CancelGen = _G.Settings.Keybinds.CancelGen or "None"
    _G.Settings.Keybinds.NoclipVaultsPallets = _G.Settings.Keybinds.NoclipVaultsPallets or "None"
    _G.Settings.Keybinds.FakeVault = _G.Settings.Keybinds.FakeVault or "None"
    _G.Settings.Keybinds.AutoParry = _G.Settings.Keybinds.AutoParry or "None"
    _G.Settings.Keybinds.RevolverAimbot = _G.Settings.Keybinds.RevolverAimbot or "None"
    _G.Settings.Keybinds.RevolverAutofarm = _G.Settings.Keybinds.RevolverAutofarm or "None"
    _G.Settings.Keybinds.InstantHeal = _G.Settings.Keybinds.InstantHeal or "None"
    _G.Settings.Keybinds.InstantBandage = _G.Settings.Keybinds.InstantBandage or "None"
    _G.Settings.Keybinds.DropAllPallets = _G.Settings.Keybinds.DropAllPallets or "None"
    _G.Settings.Keybinds.BlockVaultPalletInteraction = _G.Settings.Keybinds.BlockVaultPalletInteraction or "None"
    _G.Settings.Keybinds.NoFog = _G.Settings.Keybinds.NoFog or "None"
    _G.Settings.Keybinds.FullBright = _G.Settings.Keybinds.FullBright or "None"
    _G.Settings.Keybinds.NoFlashlightBlind = _G.Settings.Keybinds.NoFlashlightBlind or "None"
    _G.Settings.Keybinds.StopEmote = _G.Settings.Keybinds.StopEmote or "None"
    _G.Settings.Keybinds.Masked_Richter = _G.Settings.Keybinds.Masked_Richter or "None"
    _G.Settings.Keybinds.Masked_Alex = _G.Settings.Keybinds.Masked_Alex or "None"
    _G.Settings.Keybinds.Masked_Brandon = _G.Settings.Keybinds.Masked_Brandon or "None"
    _G.Settings.Keybinds.Masked_Rabbit = _G.Settings.Keybinds.Masked_Rabbit or "None"
    _G.Settings.Keybinds.Masked_Cobra = _G.Settings.Keybinds.Masked_Cobra or "None"
    _G.Settings.Keybinds.Masked_Tony = _G.Settings.Keybinds.Masked_Tony or "None"
    _G.Settings.Keybinds.Masked_Normal = _G.Settings.Keybinds.Masked_Normal or "None"
    _G.Settings.Keybinds.InfiniteLunge = _G.Settings.Keybinds.InfiniteLunge or "None"
end

ensureSettings()

-- ============================================
--  ВКЛАДКИ GUI
-- ============================================

-- Категория: ESP
Window:DrawCategory({ Name = "ESP" })

local EspTab = Window:DrawTab({
    Name = "ESP",
    Icon = "eye",
    EnableScrolling = true
})

-- Секция: Master Controls
local EspMaster = EspTab:DrawSection({ Name = "Мастер", Position = 'left' })

EspMaster:AddToggle({
    Name = "Мастер ESP",
    Flag = "MasterESP",
    Default = _G.Settings.MasterESP,
    Callback = function(v)
        _G.Settings.MasterESP = v
    end,
})

-- Секция: Игроки
local EspPlayers = EspTab:DrawSection({ Name = "Игроки", Position = 'right' })

EspPlayers:AddToggle({
    Name = "Отслеживание убийцы",
    Flag = "KillerESP",
    Default = _G.Settings.KillerESP.Enabled,
    Callback = function(v)
        _G.Settings.KillerESP.Enabled = v
    end,
})

local KillerOpt = EspPlayers:AddOption()
KillerOpt:AddToggle({
    Name = "Подсветка",
    Flag = "KillerESP_Aura",
    Default = _G.Settings.KillerESP.Aura,
    Callback = function(v)
        _G.Settings.KillerESP.Aura = v
    end,
})
KillerOpt:AddToggle({
    Name = "Дистанция",
    Flag = "KillerESP_Distance",
    Default = _G.Settings.KillerESP.Distance,
    Callback = function(v)
        _G.Settings.KillerESP.Distance = v
    end,
})
KillerOpt:AddToggle({
    Name = "Имя убийцы",
    Flag = "KillerESP_ShowName",
    Default = _G.Settings.KillerESP.ShowName,
    Callback = function(v)
        _G.Settings.KillerESP.ShowName = v
    end,
})

EspPlayers:AddToggle({
    Name = "Отслеживание выживших",
    Flag = "SurvivorESP",
    Default = _G.Settings.SurvivorESP.Enabled,
    Callback = function(v)
        _G.Settings.SurvivorESP.Enabled = v
    end,
})

local SurvivorOpt = EspPlayers:AddOption()
SurvivorOpt:AddToggle({
    Name = "Подсветка",
    Flag = "SurvivorESP_Aura",
    Default = _G.Settings.SurvivorESP.Aura,
    Callback = function(v)
        _G.Settings.SurvivorESP.Aura = v
    end,
})
SurvivorOpt:AddToggle({
    Name = "Здоровье",
    Flag = "SurvivorESP_Health",
    Default = _G.Settings.SurvivorESP.HealthState,
    Callback = function(v)
        _G.Settings.SurvivorESP.HealthState = v
    end,
})
SurvivorOpt:AddToggle({
    Name = "Счетчик крюков",
    Flag = "SurvivorESP_Hooks",
    Default = _G.Settings.SurvivorESP.ShowHookCount,
    Callback = function(v)
        _G.Settings.SurvivorESP.ShowHookCount = v
    end,
})
SurvivorOpt:AddToggle({
    Name = "Цензура имен",
    Flag = "SurvivorESP_Censor",
    Default = _G.Settings.SurvivorESP.CensorNames,
    Callback = function(v)
        _G.Settings.SurvivorESP.CensorNames = v
    end,
})

-- Секция: Объекты
local EspObjects = EspTab:DrawSection({ Name = "Объекты", Position = 'left' })

EspObjects:AddToggle({
    Name = "Генераторы",
    Flag = "GeneratorESP",
    Default = _G.Settings.GeneratorESP.Enabled,
    Callback = function(v)
        _G.Settings.GeneratorESP.Enabled = v
    end,
})

local GenOpt = EspObjects:AddOption()
GenOpt:AddToggle({
    Name = "Прогресс",
    Flag = "GeneratorESP_Progress",
    Default = _G.Settings.GeneratorESP.ShowProgress,
    Callback = function(v)
        _G.Settings.GeneratorESP.ShowProgress = v
    end,
})
GenOpt:AddToggle({
    Name = "Скорость ремонта",
    Flag = "GeneratorESP_Speed",
    Default = _G.Settings.GeneratorESP.ShowRepairSpeed,
    Callback = function(v)
        _G.Settings.GeneratorESP.ShowRepairSpeed = v
    end,
})
GenOpt:AddToggle({
    Name = "ETA",
    Flag = "GeneratorESP_ETA",
    Default = _G.Settings.GeneratorESP.ShowETA,
    Callback = function(v)
        _G.Settings.GeneratorESP.ShowETA = v
    end,
})

EspObjects:AddToggle({
    Name = "Крюки",
    Flag = "HookESP",
    Default = _G.Settings.HookESP.Enabled,
    Callback = function(v)
        _G.Settings.HookESP.Enabled = v
    end,
})

EspObjects:AddToggle({
    Name = "Паллеты",
    Flag = "PalletESP",
    Default = _G.Settings.PalletESP.Enabled,
    Callback = function(v)
        _G.Settings.PalletESP.Enabled = v
    end,
})

EspObjects:AddToggle({
    Name = "Окна",
    Flag = "VaultESP",
    Default = _G.Settings.VaultESP.Enabled,
    Callback = function(v)
        _G.Settings.VaultESP.Enabled = v
    end,
})

EspObjects:AddToggle({
    Name = "Ворота",
    Flag = "GateESP",
    Default = _G.Settings.GateESP.Enabled,
    Callback = function(v)
        _G.Settings.GateESP.Enabled = v
    end,
})

EspObjects:AddToggle({
    Name = "Кровь",
    Flag = "BloodESP",
    Default = _G.Settings.BloodESP.Enabled,
    Callback = function(v)
        _G.Settings.BloodESP.Enabled = v
    end,
})

EspObjects:AddToggle({
    Name = "Зомби/SCP",
    Flag = "SCPESP",
    Default = _G.Settings.SCPESP.Enabled,
    Callback = function(v)
        _G.Settings.SCPESP.Enabled = v
    end,
})

-- Секция: Настройки ESP
local EspSettings = EspTab:DrawSection({ Name = "Настройки", Position = 'right' })

EspSettings:AddDropdown({
    Name = "Стиль ESP",
    Values = {"Old", "Standard", "Compact", "Minimal", "Aura Only"},
    Default = _G.Settings.ESPStyle,
    Flag = "ESPStyle",
    Callback = function(v)
        _G.Settings.ESPStyle = v
    end,
})

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
})

EspSettings:AddToggle({
    Name = "Прозрачность по дистанции",
    Flag = "ESPDistanceFade",
    Default = _G.Settings.ESPDistanceFade,
    Callback = function(v)
        _G.Settings.ESPDistanceFade = v
    end,
})

EspSettings:AddToggle({
    Name = "Трейсеры",
    Flag = "ESPTracers",
    Default = _G.Settings.ESPTracers,
    Callback = function(v)
        _G.Settings.ESPTracers = v
    end,
})

EspSettings:AddToggle({
    Name = "Мини-карта",
    Flag = "Minimap",
    Default = _G.Settings.Minimap.Enabled,
    Callback = function(v)
        _G.Settings.Minimap.Enabled = v
    end,
})

-- ============================================
-- Категория: Фарм
-- ============================================

Window:DrawCategory({ Name = "Фарм" })

local FarmTab = Window:DrawTab({
    Name = "Фарм",
    Icon = "farm",
    EnableScrolling = true
})

local FarmMain = FarmTab:DrawSection({ Name = "Автофарм", Position = 'left' })

FarmMain:AddToggle({
    Name = "Автофарм выжившего",
    Flag = "AutoSurvivorFarm",
    Default = _G.Settings.AutoFarmSurvivor,
    Callback = function(v)
        _G.Settings.AutoFarmSurvivor = v
    end,
})

FarmMain:AddToggle({
    Name = "Серверный хоп",
    Flag = "ServerHop",
    Default = _G.Settings.AutoServerHopEscape,
    Callback = function(v)
        _G.Settings.AutoServerHopEscape = v
    end,
})

FarmMain:AddToggle({
    Name = "Тотальный AFK фарм",
    Flag = "TotalAFK",
    Default = _G.Settings.AutoFarmAFKTotal,
    Callback = function(v)
        _G.Settings.AutoFarmAFKTotal = v
    end,
})

FarmMain:AddButton({
    Name = "Мгновенный побег",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local finish = nil
        local dist = math.huge
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (string.find(string.lower(v.Name), "finishline") or string.find(string.lower(v.Name), "fininshline")) then
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
})

local FarmKiller = FarmTab:DrawSection({ Name = "Убийца", Position = 'right' })

FarmKiller:AddToggle({
    Name = "Автофарм убийцы",
    Flag = "AutoKillerFarm",
    Default = _G.Settings.AutoFarmKiller,
    Callback = function(v)
        _G.Settings.AutoFarmKiller = v
    end,
})

FarmKiller:AddToggle({
    Name = "Анти-вырывание",
    Flag = "AntiWiggle",
    Default = _G.Settings.AntiWiggle,
    Callback = function(v)
        _G.Settings.AntiWiggle = v
    end,
})

local FarmSkill = FarmTab:DrawSection({ Name = "Скиллчеки", Position = 'left' })

FarmSkill:AddToggle({
    Name = "Авто-скиллчек",
    Flag = "AutoSkillCheck",
    Default = _G.Settings.AutoSkillCheck,
    Callback = function(v)
        _G.Settings.AutoSkillCheck = v
    end,
})

FarmSkill:AddToggle({
    Name = "Мгновенный скиллчек",
    Flag = "InstantSkillCheck",
    Default = _G.Settings.InstantSkillCheck,
    Callback = function(v)
        _G.Settings.InstantSkillCheck = v
    end,
})

FarmSkill:AddDropdown({
    Name = "Режим",
    Values = {"Perfect", "Normal", "Hybrid"},
    Default = _G.Settings.SkillCheckMode,
    Flag = "SkillCheckMode",
    Callback = function(v)
        _G.Settings.SkillCheckMode = v
    end,
})

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
})

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
})

FarmSkill:AddToggle({
    Name = "No Skill Checks",
    Flag = "NoSkillChecks",
    Default = _G.Settings.NoSkillChecks,
    Callback = function(v)
        _G.Settings.NoSkillChecks = v
    end,
})

FarmSkill:AddButton({
    Name = "Бафф генератора",
    Callback = function()
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
})

-- ============================================
-- Категория: Модификаторы
-- ============================================

Window:DrawCategory({ Name = "Модификаторы" })

local ModTab = Window:DrawTab({
    Name = "Моды",
    Icon = "tune",
    EnableScrolling = true
})

local ModSpeed = ModTab:DrawSection({ Name = "Скорость", Position = 'left' })

ModSpeed:AddToggle({
    Name = "Буст скорости",
    Flag = "SpeedBoost",
    Default = _G.Settings.SpeedBoostEnabled,
    Callback = function(v)
        _G.Settings.SpeedBoostEnabled = v
    end,
})

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
})

ModSpeed:AddToggle({
    Name = "Учет перков скорости",
    Flag = "CountSpeedPerks",
    Default = _G.Settings.CountSpeedPerks,
    Callback = function(v)
        _G.Settings.CountSpeedPerks = v
    end,
})

ModSpeed:AddDropdown({
    Name = "Фильтр команды",
    Values = {"Both", "Survivors", "Killer"},
    Default = _G.Settings.ModifierTeamFilter,
    Flag = "TeamFilter",
    Callback = function(v)
        _G.Settings.ModifierTeamFilter = v
    end,
})

local ModMovement = ModTab:DrawSection({ Name = "Движение", Position = 'right' })

ModMovement:AddToggle({
    Name = "Авто-лунная походка",
    Flag = "AutoMoonwalk",
    Default = _G.Settings.AutoMoonwalk,
    Callback = function(v)
        _G.Settings.AutoMoonwalk = v
    end,
})

ModMovement:AddToggle({
    Name = "Обратная лунная походка",
    Flag = "ReverseMoonwalk",
    Default = _G.Settings.ReverseMoonwalk,
    Callback = function(v)
        _G.Settings.ReverseMoonwalk = v
    end,
})

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
})

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
})

ModMovement:AddToggle({
    Name = "Ноклип окон/паллет",
    Flag = "NoclipVaultsPallets",
    Default = _G.Settings.NoclipVaultsPallets,
    Callback = function(v)
        _G.Settings.NoclipVaultsPallets = v
    end,
})

ModMovement:AddToggle({
    Name = "Авто-побег от убийцы",
    Flag = "AutoFleeKiller",
    Default = _G.Settings.AutoFleeKiller,
    Callback = function(v)
        _G.Settings.AutoFleeKiller = v
    end,
})

local ModHeal = ModTab:DrawSection({ Name = "Лечение", Position = 'left' })

ModHeal:AddToggle({
    Name = "Мгновенное лечение",
    Flag = "InstantHeal",
    Default = _G.Settings.InstantHeal,
    Callback = function(v)
        _G.Settings.InstantHeal = v
    end,
})

ModHeal:AddButton({
    Name = "Мгновенная перевязка",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end,
})

local ModEffects = ModTab:DrawSection({ Name = "Эффекты", Position = 'right' })

ModEffects:AddToggle({
    Name = "Радужный персонаж",
    Flag = "RainbowCharacter",
    Default = _G.Settings.RainbowCharacter,
    Callback = function(v)
        _G.Settings.RainbowCharacter = v
    end,
})

ModEffects:AddDropdown({
    Name = "Режим радуги",
    Values = {"Highlight", "Body Parts", "ForceField"},
    Default = _G.Settings.RainbowCharacterMode,
    Flag = "RainbowMode",
    Callback = function(v)
        _G.Settings.RainbowCharacterMode = v
    end,
})

local ModPerks = ModTab:DrawSection({ Name = "Перки", Position = 'left' })

ModPerks:AddToggle({
    Name = "Force Flowstate",
    Flag = "FlowstatePerk",
    Default = _G.Settings.FlowstatePerk,
    Callback = function(v)
        _G.Settings.FlowstatePerk = v
    end,
})

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
})

ModPerks:AddToggle({
    Name = "Скрыть UI Flowstate",
    Flag = "HideFlowstateUI",
    Default = _G.Settings.HideFlowstateUI,
    Callback = function(v)
        _G.Settings.HideFlowstateUI = v
    end,
})

-- ============================================
-- Категория: Бой
-- ============================================

Window:DrawCategory({ Name = "Бой" })

local CombatTab = Window:DrawTab({
    Name = "Бой",
    Icon = "sword",
    EnableScrolling = true
})

local CombatParry = CombatTab:DrawSection({ Name = "Автопарри", Position = 'left' })

CombatParry:AddToggle({
    Name = "Автопарри",
    Flag = "AutoParry",
    Default = _G.Settings.AutoParry,
    Callback = function(v)
        _G.Settings.AutoParry = v
    end,
})

CombatParry:AddToggle({
    Name = "Использовать предмет",
    Flag = "ParryUseItem",
    Default = _G.Settings.ParryUseItem,
    Callback = function(v)
        _G.Settings.ParryUseItem = v
    end,
})

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
})

CombatParry:AddDropdown({
    Name = "Задержка реакции",
    Values = {"0", "50", "100", "150", "200", "250", "300"},
    Default = tostring(_G.Settings.ParryDelay * 1000),
    Flag = "ParryDelay",
    Callback = function(v)
        _G.Settings.ParryDelay = tonumber(v) / 1000
    end,
})

CombatParry:AddToggle({
    Name = "Проверка направления",
    Flag = "ParryFacingCheck",
    Default = _G.Settings.ParryFacingCheck,
    Callback = function(v)
        _G.Settings.ParryFacingCheck = v
    end,
})

CombatParry:AddToggle({
    Name = "Компенсация пинга",
    Flag = "ParryPingCompensation",
    Default = _G.Settings.ParryPingCompensation,
    Callback = function(v)
        _G.Settings.ParryPingCompensation = v
    end,
})

CombatParry:AddToggle({
    Name = "Визуальный круг",
    Flag = "ParryRangeESP",
    Default = _G.Settings.ParryRangeESP,
    Callback = function(v)
        _G.Settings.ParryRangeESP = v
    end,
})

CombatParry:AddToggle({
    Name = "Игнорирование Frenzy",
    Flag = "FrenzyParry",
    Default = _G.Settings.FrenzyParry,
    Callback = function(v)
        _G.Settings.FrenzyParry = v
    end,
})

CombatParry:AddToggle({
    Name = "Игнорирование Abysswalker",
    Flag = "IgnoreAbysswalker",
    Default = _G.Settings.IgnoreAbysswalkerLunge,
    Callback = function(v)
        _G.Settings.IgnoreAbysswalkerLunge = v
    end,
})

CombatParry:AddToggle({
    Name = "Скрыть UI парирования",
    Flag = "HideParryUI",
    Default = _G.Settings.HideParryUI,
    Callback = function(v)
        _G.Settings.HideParryUI = v
    end,
})

local CombatAimbot = CombatTab:DrawSection({ Name = "Аимбот", Position = 'right' })

CombatAimbot:AddToggle({
    Name = "Аимбот (общий)",
    Flag = "GeneralAimbot",
    Default = _G.Settings.AimAssist.Enabled,
    Callback = function(v)
        _G.Settings.AimAssist.Enabled = v
    end,
})

CombatAimbot:AddDropdown({
    Name = "Часть тела",
    Values = {"Head", "UpperTorso", "HumanoidRootPart"},
    Default = _G.Settings.AimAssist.TargetPart,
    Flag = "AimbotPart",
    Callback = function(v)
        _G.Settings.AimAssist.TargetPart = v
    end,
})

CombatAimbot:AddDropdown({
    Name = "Приоритет",
    Values = {"Nearest", "Furthest", "Injured", "Healed"},
    Default = _G.Settings.AimAssist.Priority,
    Flag = "AimbotPriority",
    Callback = function(v)
        _G.Settings.AimAssist.Priority = v
    end,
})

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
})

CombatAimbot:AddToggle({
    Name = "Показывать FOV",
    Flag = "ShowFOVCircle",
    Default = _G.Settings.AimAssist.ShowFOV,
    Callback = function(v)
        _G.Settings.AimAssist.ShowFOV = v
    end,
})

CombatAimbot:AddToggle({
    Name = "Предсказание движения",
    Flag = "PredictMovement",
    Default = _G.Settings.AimAssist.Prediction,
    Callback = function(v)
        _G.Settings.AimAssist.Prediction = v
    end,
})

-- ============================================
-- Категория: Оружие
-- ============================================

Window:DrawCategory({ Name = "Оружие" })

local WeaponTab = Window:DrawTab({
    Name = "Оружие",
    Icon = "sword",
    EnableScrolling = true
})

local RevSection = WeaponTab:DrawSection({ Name = "Револьвер", Position = 'left' })

RevSection:AddToggle({
    Name = "Автофарм револьвером",
    Flag = "RevolverAutofarm",
    Default = _G.Settings.RevolverAutofarm,
    Callback = function(v)
        _G.Settings.RevolverAutofarm = v
    end,
})

RevSection:AddToggle({
    Name = "Аимбот револьвера",
    Flag = "RevolverAimbot",
    Default = _G.Settings.RevolverAimbot.Enabled,
    Callback = function(v)
        _G.Settings.RevolverAimbot.Enabled = v
    end,
})

RevSection:AddToggle({
    Name = "Сайлент-аим револьвера",
    Flag = "RevolverSilentAim",
    Default = _G.Settings.RevolverSilentAim.Enabled,
    Callback = function(v)
        _G.Settings.RevolverSilentAim.Enabled = v
    end,
})

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
})

RevSection:AddToggle({
    Name = "Обход ограничений",
    Flag = "BypassToFRestrictions",
    Default = _G.Settings.BypassToFRestrictions,
    Callback = function(v)
        _G.Settings.BypassToFRestrictions = v
    end,
})

local VeilSection = WeaponTab:DrawSection({ Name = "Вейл", Position = 'right' })

VeilSection:AddToggle({
    Name = "Траектория копья",
    Flag = "SpearTrajectory",
    Default = _G.Settings.SpearTrajectory,
    Callback = function(v)
        _G.Settings.SpearTrajectory = v
    end,
})

VeilSection:AddToggle({
    Name = "Noclip траектории",
    Flag = "SpearTrajectoryNoclip",
    Default = _G.Settings.SpearTrajectoryNoclip,
    Callback = function(v)
        _G.Settings.SpearTrajectoryNoclip = v
    end,
})

VeilSection:AddToggle({
    Name = "Аимбот копья",
    Flag = "SpearAimbot",
    Default = _G.Settings.SpearAimbot.Enabled,
    Callback = function(v)
        _G.Settings.SpearAimbot.Enabled = v
    end,
})

VeilSection:AddToggle({
    Name = "Сайлент-аим копья",
    Flag = "SpearSilentAim",
    Default = _G.Settings.SpearSilentAim.Enabled,
    Callback = function(v)
        _G.Settings.SpearSilentAim.Enabled = v
    end,
})

-- ============================================
-- Категория: Убийцы
-- ============================================

Window:DrawCategory({ Name = "Убийцы" })

local KillerTab = Window:DrawTab({
    Name = "Убийцы",
    Icon = "skull",
    EnableScrolling = true
})

-- Masked
local MaskedSection = KillerTab:DrawSection({ Name = "MASKED", Position = 'left' })

local MaskedBuffs = {
    "Richter - Stealth",
    "Alex - Chainsaw",
    "Brandon - Walk Faster",
    "Rabbit - Fast Vaults",
    "Cobra - Extended Lunges",
    "Tony - Lethal Punches",
    "Normal - No Buffs"
}

MaskedSection:AddDropdown({
    Name = "Выбрать бафф",
    Values = MaskedBuffs,
    Default = "Normal - No Buffs",
    Flag = "MaskedBuff",
    Callback = function(v)
        _G.Settings.Masked.CurrentBuff = v
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
})

-- Stalker
local StalkerSection = KillerTab:DrawSection({ Name = "STALKER", Position = 'right' })

StalkerSection:AddToggle({
    Name = "Нет перезарядки",
    Flag = "StalkerNoCooldown",
    Default = _G.Settings.Stalker.NoCooldown,
    Callback = function(v)
        _G.Settings.Stalker.NoCooldown = v
    end,
})

StalkerSection:AddToggle({
    Name = "Убийственный захват",
    Flag = "StalkerKillGrab",
    Default = _G.Settings.Stalker.KillGrab,
    Callback = function(v)
        _G.Settings.Stalker.KillGrab = v
    end,
})

StalkerSection:AddToggle({
    Name = "Сталк во время движения",
    Flag = "StalkerWhileMoving",
    Default = _G.Settings.Stalker.StalkWhileMoving,
    Callback = function(v)
        _G.Settings.Stalker.StalkWhileMoving = v
    end,
})

-- Abysswalker
local AbyssSection = KillerTab:DrawSection({ Name = "ABYSSWALKER", Position = 'left' })

AbyssSection:AddToggle({
    Name = "Бесконечная порча",
    Flag = "InfiniteCorrupt",
    Default = _G.Settings.Stalker.InfiniteCorrupt,
    Callback = function(v)
        _G.Settings.Stalker.InfiniteCorrupt = v
    end,
})

AbyssSection:AddToggle({
    Name = "Авто-приседание",
    Flag = "AutoDodge",
    Default = _G.Settings.Stalker.AutoDodge,
    Callback = function(v)
        _G.Settings.Stalker.AutoDodge = v
    end,
})

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
})

AbyssSection:AddToggle({
    Name = "Нет стана",
    Flag = "NoStun",
    Default = _G.Settings.NoStun,
    Callback = function(v)
        _G.Settings.NoStun = v
    end,
})

-- ============================================
-- Категория: Визуалы
-- ============================================

Window:DrawCategory({ Name = "Визуалы" })

local VisualTab = Window:DrawTab({
    Name = "Визуал",
    Icon = "palette",
    EnableScrolling = true
})

local VisGraphics = VisualTab:DrawSection({ Name = "Графика", Position = 'left' })

VisGraphics:AddToggle({
    Name = "RTX Graphics",
    Flag = "RTXGraphics",
    Default = _G.Settings.RTXGraphics,
    Callback = function(v)
        _G.Settings.RTXGraphics = v
    end,
})

VisGraphics:AddToggle({
    Name = "Глубина резкости",
    Flag = "CinematicDOF",
    Default = _G.Settings.CinematicDOF,
    Callback = function(v)
        _G.Settings.CinematicDOF = v
    end,
})

VisGraphics:AddDropdown({
    Name = "Визуальный пресет",
    Values = {"Default", "Vibrant & Alive", "Clean Daylight", "Cyberpunk Neon", "Warm Sunset", "Moonlight", "Custom"},
    Default = _G.Settings.VisualPreset,
    Flag = "VisualPreset",
    Callback = function(v)
        _G.Settings.VisualPreset = v
    end,
})

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
})

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
})

local VisLighting = VisualTab:DrawSection({ Name = "Освещение", Position = 'right' })

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
})

VisLighting:AddToggle({
    Name = "Кастомное освещение",
    Flag = "CustomLighting",
    Default = _G.Settings.CustomLightingEnabled,
    Callback = function(v)
        _G.Settings.CustomLightingEnabled = v
        local lighting = game:GetService("Lighting")
        if v then
            lighting.Ambient = _G.Settings.CustomLightingColor
            lighting.OutdoorAmbient = _G.Settings.CustomLightingColor
        else
            lighting.Ambient = Color3.fromRGB(0, 0, 0)
            lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end,
})

VisLighting:AddToggle({
    Name = "Лучи Бога",
    Flag = "SunRays",
    Default = _G.Settings.SunRaysEnabled,
    Callback = function(v)
        _G.Settings.SunRaysEnabled = v
    end,
})

VisLighting:AddToggle({
    Name = "Туман",
    Flag = "CustomFog",
    Default = _G.Settings.CustomFogEnabled,
    Callback = function(v)
        _G.Settings.CustomFogEnabled = v
    end,
})

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
})

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
})

local VisEffects = VisualTab:DrawSection({ Name = "Эффекты", Position = 'left' })

VisEffects:AddToggle({
    Name = "Блум",
    Flag = "Bloom",
    Default = _G.Settings.CustomBloomEnabled,
    Callback = function(v)
        _G.Settings.CustomBloomEnabled = v
    end,
})

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
})

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
})

VisEffects:AddToggle({
    Name = "Full Bright",
    Flag = "FullBright",
    Default = _G.Settings.FullBright,
    Callback = function(v)
        _G.Settings.FullBright = v
    end,
})

VisEffects:AddToggle({
    Name = "No Fog",
    Flag = "NoFog",
    Default = _G.Settings.NoFog,
    Callback = function(v)
        _G.Settings.NoFog = v
    end,
})

local VisCrosshair = VisualTab:DrawSection({ Name = "Прицел", Position = 'right' })

VisCrosshair:AddToggle({
    Name = "Прицел",
    Flag = "Crosshair",
    Default = _G.Settings.ShowCrosshair,
    Callback = function(v)
        _G.Settings.ShowCrosshair = v
    end,
})

VisCrosshair:AddDropdown({
    Name = "Стиль",
    Values = {"Classic", "Dot", "Circle", "Dot & Circle", "Tactical"},
    Default = _G.Settings.CrosshairStyle,
    Flag = "CrosshairStyle",
    Callback = function(v)
        _G.Settings.CrosshairStyle = v
    end,
})

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
})

local VisCamera = VisualTab:DrawSection({ Name = "Камера", Position = 'left' })

VisCamera:AddToggle({
    Name = "Режим от третьего лица",
    Flag = "ThirdPersonKiller",
    Default = _G.Settings.KillerThirdPerson,
    Callback = function(v)
        _G.Settings.KillerThirdPerson = v
    end,
})

VisCamera:AddToggle({
    Name = "Бесконечный зум",
    Flag = "InfiniteZoom",
    Default = _G.Settings.InfiniteZoom,
    Callback = function(v)
        _G.Settings.InfiniteZoom = v
    end,
})

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
})

local VisNetwork = VisualTab:DrawSection({ Name = "Сеть", Position = 'right' })

VisNetwork:AddToggle({
    Name = "Fake Lag",
    Flag = "FakeLag",
    Default = _G.Settings.FakeLag,
    Callback = function(v)
        _G.Settings.FakeLag = v
    end,
})

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
})

VisNetwork:AddToggle({
    Name = "Desync",
    Flag = "Desync",
    Default = _G.Settings.Desync,
    Callback = function(v)
        _G.Settings.Desync = v
    end,
})

VisNetwork:AddToggle({
    Name = "Призрак",
    Flag = "Ghost",
    Default = _G.Settings.EnableDesyncGhost,
    Callback = function(v)
        _G.Settings.EnableDesyncGhost = v
    end,
})

local VisFlashlight = VisualTab:DrawSection({ Name = "Фонарик", Position = 'left' })

VisFlashlight:AddDropdown({
    Name = "Эффект",
    Values = {"None", "Rainbow", "Strobe", "Ultra Bright"},
    Default = _G.Settings.FlashlightEffect,
    Flag = "FlashlightEffect",
    Callback = function(v)
        _G.Settings.FlashlightEffect = v
    end,
})

-- ============================================
-- Категория: Конфиги
-- ============================================

Window:DrawCategory({ Name = "Конфиг" })

local ConfigTab = Window:DrawTab({
    Name = "Конфиг",
    Icon = "folder",
    Type = "Single",
    EnableScrolling = true
})

local ConfigSection = ConfigTab:DrawSection({ Name = "Управление конфигами", Position = 'left' })

ConfigSection:AddButton({
    Name = "Сохранить конфиг",
    Callback = function()
        local success, err = pcall(function()
            if writefile then
                local json = game:GetService("HttpService"):JSONEncode(_G.Settings)
                writefile("VD_6locc_Config.json", json)
                print("Config saved!")
            end
        end)
        if not success then
            print("Error saving config: " .. tostring(err))
        end
    end,
})

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
})

ConfigSection:AddButton({
    Name = "Сбросить настройки",
    Callback = function()
        _G.Settings = nil
        ensureSettings()
        print("Settings reset!")
    end,
})

ConfigSection:AddButton({
    Name = "Выгрузить скрипт",
    Callback = function()
        Window:Destroy()
        print("Script unloaded!")
    end,
})

-- ============================================
--  ЗАПУСК ЛОГИКИ (фоновые потоки)
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

task.spawn(function()
    while true do
        task.wait(0.5)
        
        local lp = Players.LocalPlayer
        local char = lp and lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        -- ESP Logic
        if _G.Settings.MasterESP then
            if _G.Settings.KillerESP.Enabled then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= lp then
                        local team = player.Team
                        if team and team.Name == "Killer" then
                            local pChar = player.Character
                            if pChar then
                                local highlight = pChar:FindFirstChild("Highlight")
                                if not highlight then
                                    highlight = Instance.new("Highlight")
                                    highlight.Name = "Highlight"
                                    highlight.Parent = pChar
                                end
                                highlight.FillColor = _G.Settings.ESPColors.Killer
                                highlight.FillTransparency = 0.6
                                highlight.Enabled = true
                            end
                        end
                    end
                end
            end
            
            if _G.Settings.SurvivorESP.Enabled then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= lp then
                        local team = player.Team
                        if team and team.Name == "Survivors" then
                            local pChar = player.Character
                            if pChar then
                                local highlight = pChar:FindFirstChild("Highlight")
                                if not highlight then
                                    highlight = Instance.new("Highlight")
                                    highlight.Name = "Highlight"
                                    highlight.Parent = pChar
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
        if _G.Settings.SpeedBoostEnabled and hum then
            hum.WalkSpeed = 16 * _G.Settings.SpeedBoost
        end
        
        -- Auto Moonwalk Logic
        if _G.Settings.AutoMoonwalk and root and hum then
            local cam = workspace.CurrentCamera
            if cam then
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
        if _G.Settings.RainbowCharacter and char then
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
        
        -- Noclip Logic
        if _G.Settings.NoclipVaultsPallets and char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        -- No Fog Logic
        if _G.Settings.NoFog then
            Lighting.FogStart = 999999
            Lighting.FogEnd = 999999
        end
        
        -- Full Bright Logic
        if _G.Settings.FullBright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.GlobalShadows = false
        end
        
        -- Auto Farm Survivor Logic
        if _G.Settings.AutoFarmSurvivor and root then
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
                local remotes = ReplicatedStorage:FindFirstChild("Remotes")
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
        
        -- Instant Heal Logic
        if _G.Settings.InstantHeal and hum then
            if hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end
    end
end)

-- ============================================
--  ОБРАБОТЧИК КЛАВИШ
-- ============================================

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
