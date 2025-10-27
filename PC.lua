    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    local Window = Fluent:CreateWindow({
        Title = "[⚔️AIZEN] Rogue Piece",
        SubTitle = "Made by BenJaMinZ",
        TabWidth = 200,
        Size = UDim2.fromOffset(580,460),
        Acrylic = false,
        Theme = "Dark",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")

    local function initCharacter(char)
        character = char
        humanoid = character:WaitForChild("Humanoid")
        hrp = character:WaitForChild("HumanoidRootPart")
    end

    local TabMain = Window:AddTab({ Title = "Main", Icon = "hammer" })
    local TabAutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "bot" })
    local TabStat = Window:AddTab({ Title = "Upgrade Stat", Icon = "circle-ellipsis" })
    local Setting = Window:AddTab({ Title = "Setting", Icon = "settings" })

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BenJaMinZ Hub",
    Text = "AntiAFK Active",
    Duration = 5
})


local Players = game:WaitForChild("Players")
local ReplicatedStorage = game:WaitForChild("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local AutoHakiEnabled = false

local function fireHaki()
    local Character = LocalPlayer.Character
    if not Character then return end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not Humanoid or Humanoid.Health <= 0 or not HumanoidRootPart then
        return
    end

    local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not Remotes then return end

    local remote = Remotes:FindFirstChild("Serverside")
    if not remote then return end

    local hakiValue = AutoHakiEnabled and 1 or 2

    local args = {
        [1] = "Server",
        [2] = "Misc",
        [3] = "Haki",
        [4] = hakiValue
    }

    pcall(function()
        remote:FireServer(unpack(args))
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    if AutoHakiEnabled then
        Character:WaitForChild("Humanoid")
        task.wait(0.01)
        fireHaki()
    end
end)

TabMain:AddToggle("AutoHaki", {
    Title = "Auto Haki",
    Default = false,
    Callback = function(state)
        AutoHakiEnabled = state
        fireHaki()
    end
})

local Players = game:WaitForChild("Players")
local ReplicatedStorage = game:WaitForChild("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local AutoObservationEnabled = false

local function fireObservation()
    local Character = LocalPlayer.Character
    if not Character then return end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

    if not Humanoid or Humanoid.Health <= 0 or not HumanoidRootPart then
        return
    end

    local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not Remotes then return end

    local remote = Remotes:FindFirstChild("Serverside")
    if not remote then return end

    local hakiValue = AutoObservationEnabled and 1 or 2

    local args = {
        [1] = "Server",
        [2] = "Misc",
        [3] = "Observation",
        [4] = hakiValue
    }

    pcall(function()
        remote:FireServer(unpack(args))
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    if AutoObservationEnabled then
        Character:WaitForChild("Humanoid")
        task.wait(0.01)
        fireObservation()
    end
end)

TabMain:AddToggle("AutoObservation", {
    Title = "Auto Observation",
    Default = false,
    Callback = function(state)
        AutoObservationEnabled = state
        fireObservation()
    end
})

    local defaultSpeed = 16
    local boostedSpeed = 250
    local speedActive = false

    TabMain:AddToggle("SpeedNoClipToggle", {
        Title = "Speed Hack",
        Default = false,
        Callback = function(state)
            speedActive = state
            initCharacter(player.Character or player.CharacterAdded:Wait())
            local humanoidRef = character:FindFirstChild("Humanoid")
            if humanoidRef then
                humanoidRef.WalkSpeed = state and boostedSpeed or defaultSpeed
            end
        end
    })

    RunService.RenderStepped:Connect(function()
        if speedActive then
            local char = player.Character
            if char then
                local humanoidRef = char:FindFirstChild("Humanoid")
                local hrpRef = char:FindFirstChild("HumanoidRootPart")
                if humanoidRef and hrpRef then
                    local moveDir = humanoidRef.MoveDirection
                    hrpRef.Velocity = Vector3.new(moveDir.X * boostedSpeed, hrpRef.Velocity.Y, moveDir.Z * boostedSpeed)
                end
            end
        end
    end)

    _G.InfiniteJumpMisc = false
    TabMain:AddToggle("InfinityJumpMisc", {
        Title = "Infinity Jump",
        Default = false,
        Callback = function(state) _G.InfiniteJumpMisc = state end
    })
    UserInputService.JumpRequest:Connect(function()
        if _G.InfiniteJumpMisc then
            local char = player.Character or player.CharacterAdded:Wait()
            local hum = char:FindFirstChild("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local espSize = 14
local ESPColor = Color3.fromRGB(0,255,0)

local espEnabled = false
local ESPs = {}

local function createESP(plr)
    if plr == LocalPlayer then return end
    if ESPs[plr] then return end
    local char = plr.Character
    if not char then return end
    local head = char:WaitForChild("Head", 5)
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not head or not hrp then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Name"
    billboard.Adornee = head
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, espSize*10, 0, espSize*4)
    billboard.StudsOffset = Vector3.new(0,3,0)
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextScaled = false
    label.TextSize = espSize
    label.TextColor3 = ESPColor
    label.TextStrokeTransparency = 0
    label.Text = plr.Name
    label.Parent = billboard

    local highlight = Instance.new("Highlight")
    highlight.Name = "BoxESP"
    highlight.Adornee = char
    highlight.FillTransparency = 1
    highlight.OutlineColor = ESPColor
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char

    ESPs[plr] = {billboard = billboard, label = label, highlight = highlight}
end

local function removeESP(plr)
    if ESPs[plr] then
        pcall(function()
            if ESPs[plr].billboard then ESPs[plr].billboard:Destroy() end
            if ESPs[plr].highlight then ESPs[plr].highlight:Destroy() end
        end)
        ESPs[plr] = nil
    end
end

RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    for plr,data in pairs(ESPs) do
        local char = plr.Character
        if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
            local hum = char.Humanoid
            local dist = (char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            local hpPercent = hum.Health / hum.MaxHealth
            if hpPercent > 0.6 then
                data.label.TextColor3 = Color3.fromRGB(0,255,0)
            elseif hpPercent > 0.3 then
                data.label.TextColor3 = Color3.fromRGB(255,165,0)
            else
                data.label.TextColor3 = Color3.fromRGB(255,0,0)
            end
            data.label.Text = string.format("%s | %.0f", plr.Name, dist)
        else
            removeESP(plr)
        end
    end
end)

local function scanPlayers()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            createESP(plr)
            plr.CharacterAdded:Connect(function()
                task.wait(1)
                if espEnabled then createESP(plr) end
            end)
        end
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function()
            task.wait(1)
            if espEnabled then createESP(plr) end
        end)
        if espEnabled then createESP(plr) end
    end
end)

TabMain:AddToggle("ESPPlayer", {
    Title = "ESP Player",
    Default = false,
    Callback = function(state)
        espEnabled = state
        if state then
            scanPlayers()
        else
            for plr,_ in pairs(ESPs) do
                removeESP(plr)
            end
        end
    end
})

local Section = TabMain:AddSection("Select Farm Haki")

local Players = game:WaitForChild("Players")
local ReplicatedStorage = game:WaitForChild("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local AutoHakiEnabled = false
local SelectedHakiType = "Haki"

local function fireHaki()
    local Character = LocalPlayer.Character
    if not Character then return end

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not Humanoid or Humanoid.Health <= 0 or not HumanoidRootPart then return end

    local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if not Remotes then return end

    local remote = Remotes:FindFirstChild("Serverside")
    if not remote then return end

    local args = {
        [1] = "Server",
        [2] = "Misc",
        [3] = SelectedHakiType,
        [4] = AutoHakiEnabled and 1 or 2
    }

    pcall(function()
        remote:FireServer(unpack(args))
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    Character:WaitForChild("Humanoid")
    task.wait(0.001)
    if AutoHakiEnabled then
        task.spawn(function()
            while AutoHakiEnabled do
                fireHaki()
                task.wait(0.001)
            end
        end)
    end
end)

local HakiDropdown = TabMain:AddDropdown("HakiTypeDropdown", {
    Title = "Select Haki",
    Values = {"Haki", "Observation"},
    Default = "Haki",
})

HakiDropdown:OnChanged(function(value)
    SelectedHakiType = value
end)

local AutoHakiToggle = TabMain:AddToggle("AutoHakiToggle", {
    Title = "Auto Farm Haki / Observation",
    Default = false,
})

AutoHakiToggle:OnChanged(function(state)
    AutoHakiEnabled = state

    if AutoHakiEnabled then
        task.spawn(function()
            while AutoHakiEnabled do
                fireHaki()
                task.wait(0.001)
            end
        end)
    end
end)


TabMain:AddButton({
    Title = "Buy Haki",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(37.30762481689453, 2.223743200302124, 222.4023895263672)
    end
})

TabMain:AddButton({
    Title = "Buy Observation",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-626.7130126953125, 8.763612747192383, -216.65618896484375)
    end
})

---------------------------------------------------------------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer


local SelectedWeapon = "Zangetsu"
local AttackValue = 1
local SelectedType = "Sword"
local WeaponTypes = {
    ["Zangetsu"] = "Sword",
    ["Dark Blade"] = "Sword",
    ["Dual Dagger"] = "Sword",
    ["Tanjiro's Nichirin"] = "Sword",
    ["Aizen"] = "Combat",
    ["Sukuna"] = "Combat",
    ["Akaza"] = "Combat",
    ["Sandevistan"] = "Combat"
}

local AutoKillEnabled = false
local SelectedMob = "Bandit"

local MobData = {
    ["Bandit"] = { ePos = Vector3.new(18,6,-344), KillLimit = 5 },
    ["Bandit Leader"] = { ePos = Vector3.new(-43,22,-341), KillLimit = 1 },
    ["Skeleton"] = { ePos = Vector3.new(-519.734,7.063,-155.569), KillLimit = 5 },
    ["Pirate Skeleton"] = { ePos = Vector3.new(-603,16,-107), KillLimit = 1 },
    ["Desert Thief"] = { ePos = Vector3.new(455,5,-28), KillLimit = 5 },
    ["Katana Master"] = { ePos = Vector3.new(488,5,-74), KillLimit = 1 },
    ["Slayer's Trainee"] = { ePos = Vector3.new(-496.665,11.044,514.502), KillLimit = 5 },
    ["Tanjiro"] = { ePos = Vector3.new(-530.481,10.964,532.068), KillLimit = 1 },
    ["Aizen"] = { ePos = Vector3.new(-413.449,3.967,-705.239), KillLimit = 1 },
    ["Mihawk"] = { ePos = Vector3.new(-31.634,2.224,152.067), KillLimit = 1 },
    ["Sung Jin Woo"] = { ePos = Vector3.new(-75.644,2.224,136.801), KillLimit = 1 }
}

local function attackMob(npc, HumanoidRootPart)
    local npcHumanoid = npc:FindFirstChild("Humanoid")
    if not npcHumanoid or npcHumanoid.Health <= 0 then return false end

    local function attack()
        ReplicatedStorage.Remotes.Serverside:FireServer("Server", SelectedType, "M1s", SelectedWeapon, AttackValue)
    end

    local function stayBehind()
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local backOffset = hrp.CFrame.LookVector * -3
        local newPos = hrp.Position + backOffset
        local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.08), {CFrame = CFrame.new(newPos, hrp.Position)})
        tween:Play()
        tween.Completed:Wait()
    end

    while AutoKillEnabled do

        local Character = LocalPlayer.Character
        local PlayerHumanoid = Character and Character:FindFirstChild("Humanoid")
        local PlayerHRP = Character and Character:FindFirstChild("HumanoidRootPart")
        if not PlayerHumanoid or PlayerHumanoid.Health <= 0 or not PlayerHRP then break end

        if not npcHumanoid or npcHumanoid.Health <= 0 then break end

        stayBehind()
        attack()
        task.wait(0.01)
    end

    return npcHumanoid.Health <= 0
end

local function attackBossLoop(bossName, HumanoidRootPart)
    local ePos = MobData[bossName].ePos

    while AutoKillEnabled do
        local Character = LocalPlayer.Character
        local PlayerHumanoid = Character and Character:FindFirstChild("Humanoid")
        local PlayerHRP = Character and Character:FindFirstChild("HumanoidRootPart")
        if not PlayerHumanoid or PlayerHumanoid.Health <= 0 or not PlayerHRP then break end

        local boss = workspace:FindFirstChild("Main") 
                     and workspace.Main.Characters:FindFirstChild("Huecomundo") 
                     and workspace.Main.Characters.Huecomundo:FindFirstChild("Boss") 
                     and workspace.Main.Characters.Huecomundo.Boss:FindFirstChild(bossName)
        
        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
            attackMob(boss, PlayerHRP)
        else
            PlayerHRP.CFrame = CFrame.new(ePos)
            task.wait(0.0)
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.0)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
            task.wait(0.0)
        end
        task.wait(0.5)
    end
end

local function startAutoKill()
    task.spawn(function()
        while AutoKillEnabled do
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local PlayerHumanoid = Character:WaitForChild("Humanoid")
            local PlayerHRP = Character:WaitForChild("HumanoidRootPart")

            if SelectedMob == "Aizen" or SelectedMob == "Tanjiro" then
                attackBossLoop(SelectedMob, PlayerHRP)
            else
                local mobInfo = MobData[SelectedMob]
                if not mobInfo then break end

                PlayerHRP.CFrame = CFrame.new(mobInfo.ePos)
                task.wait(0.0)
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                task.wait(0.0)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                task.wait(0.0)

                local killedCount = 0
                local alreadyKilled = {}

                while AutoKillEnabled and killedCount < mobInfo.KillLimit do
                    for _, npc in ipairs(workspace:GetDescendants()) do
                        if not AutoKillEnabled then break end
                        if npc:IsA("Model") and npc.Name == SelectedMob and npc:FindFirstChild("Humanoid") and not alreadyKilled[npc] then
                            local success = attackMob(npc, PlayerHRP)
                            if success then
                                alreadyKilled[npc] = true
                                killedCount += 1
                                if killedCount >= mobInfo.KillLimit then break end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end
            task.wait(0.5)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    if AutoKillEnabled then
        task.wait(1)
        startAutoKill()
    end
end)

TabAutoFarm:AddDropdown("WeaponSelect", {
    Title = "Select Weapon",
    Values = {"Zangetsu","Dark Blade","Dual Dagger","Tanjiro's Nichirin","Aizen","Sukuna","Akaza","Sandevistan"},
    Default = "Zangetsu",
    Callback = function(value)
        SelectedWeapon = value
        SelectedType = WeaponTypes[value] or "Sword"
    end
})

local EquipEnabled = false

local function holdWeapon()
    task.spawn(function()
        while EquipEnabled do
            local Character = LocalPlayer.Character
            local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChild("Humanoid")
            local Backpack = LocalPlayer:FindFirstChild("Backpack")
            if Character and Humanoid and HRP and Backpack then
                local weapon = Backpack:FindFirstChild(SelectedWeapon) or Character:FindFirstChild(SelectedWeapon)
                if weapon and weapon.Parent ~= Character then
                    weapon.Parent = Character
                end
            end
            task.wait(0.1)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    if EquipEnabled then
        task.wait(1)
        holdWeapon()
    end
end)

TabAutoFarm:AddToggle("EquipWeaponToggle", {
    Title = "Auto Equip Weapon",
    Default = false,
    Callback = function(state)
        EquipEnabled = state
        if state then
            holdWeapon()
        end
    end
})


TabAutoFarm:AddDropdown("AttackSelect", {
    Title = "Attack Mode",
    Values = {"1","2","3","4","5"},
    Default = "4",
    Callback = function(value)
        AttackValue = tonumber(value)
    end
})

TabAutoFarm:AddDropdown("MobSelect", {
    Title = "Select Mob",
    Values = {"Bandit","Bandit Leader","Skeleton","Pirate Skeleton","Desert Thief","Katana Master","Slayer's Trainee","Tanjiro","Aizen","Mihawk","Sung Jin Woo"},
    Default = "Bandit",
    Callback = function(value)
        SelectedMob = value
    end
})

TabAutoFarm:AddToggle("AutoKill", {
    Title = "Auto Kill",
    Default = false,
    Callback = function(state)
        AutoKillEnabled = state
        if state then
            startAutoKill()
        end
    end
})



---------------------------------------------------------------------------------------------------------------------------------------------------------
local Section = TabAutoFarm:AddSection("Select Boss Spawn")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local SelectedBoss = "Sukuna"

local BossDropdown = TabAutoFarm:AddDropdown("BossDropdown", {
    Title = "Select Boss",
    Values = {"Sukuna","Akaza","David"},
    Multi = false,
    Default = 1
})

BossDropdown:OnChanged(function(Value)
    SelectedBoss = Value
end)

local ToggleEnabled = false
TabAutoFarm:AddToggle("AutoWarpSpawn", {
    Title = "Auto Spawn Boss",
    Default = false,
    Callback = function(state)
        ToggleEnabled = state
        if ToggleEnabled then
            task.spawn(function()
                while ToggleEnabled do

                    local bossFolder = Workspace:FindFirstChild("Main")
                    and Workspace.Main:FindFirstChild("Characters")
                    and Workspace.Main.Characters:FindFirstChild("Throne Isle")
                    and Workspace.Main.Characters["Throne Isle"]:FindFirstChild("Boss")
                    
                    if bossFolder then
                        local bossExists = bossFolder:FindFirstChild(SelectedBoss)
                        if bossExists then
                            task.wait(2)
                            continue
                        end
                    end

                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local hrp = character:WaitForChild("HumanoidRootPart")
                    local targetPos = Vector3.new(534.2262573242188, 2.6505398750305176, -539.0162963867188)
                    hrp.CFrame = CFrame.new(targetPos)
                    task.wait(0.1)

                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    task.wait(0.7)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)

                    local clickX, clickY
                    if SelectedBoss == "Sukuna" then
                        clickX, clickY = 942, 450
                    elseif SelectedBoss == "Akaza" then
                        clickX, clickY = 942, 500
                    elseif SelectedBoss == "David" then
                        clickX, clickY = 942, 610
                    end

                    if clickX and clickY then
                        VirtualInputManager:SendMouseButtonEvent(clickX, clickY, 0, true, game, 0)
                        task.wait(0.05)
                        VirtualInputManager:SendMouseButtonEvent(clickX, clickY, 0, false, game, 0)
                    end

                    local spawnX, spawnY = 951, 685
                    VirtualInputManager:SendMouseButtonEvent(spawnX, spawnY, 0, true, game, 0)
                    task.wait(0.05)
                    VirtualInputManager:SendMouseButtonEvent(spawnX, spawnY, 0, false, game, 0)

                    task.wait(1)
                end
            end)
        end
    end
})


local KillBossesEnabled = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

local function attackBoss(npc, HumanoidRootPart)
    local humanoid = npc:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end

    local function attack()
        local args = {
            [1] = "Server",
            [2] = SelectedType,
            [3] = "M1s",
            [4] = SelectedWeapon,
            [5] = AttackValue
        }
        ReplicatedStorage.Remotes.Serverside:FireServer(unpack(args))
    end

    local function stayBehind(npc)
        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local backOffset = hrp.CFrame.LookVector * -3
        local newPos = hrp.Position + backOffset
        local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.08), {
            CFrame = CFrame.new(newPos, hrp.Position)
        })
        tween:Play()
        tween.Completed:Wait()
    end

    while KillBossesEnabled 
        and humanoid.Health > 0 
        and HumanoidRootPart.Parent:FindFirstChild("Humanoid") 
        and HumanoidRootPart.Parent.Humanoid.Health > 0 
    do
        stayBehind(npc)
        attack()
        task.wait(0.01)
    end

    return humanoid.Health <= 0
end

local function attackBossesLoop(HumanoidRootPart)
    while KillBossesEnabled do
        local bosses = {"Sukuna", "Akaza", "David"}
        local Main = workspace:FindFirstChild("Main")
        if Main and Main:FindFirstChild("Characters") 
            and Main.Characters:FindFirstChild("Throne Isle") 
            and Main.Characters["Throne Isle"]:FindFirstChild("Boss") 
        then
            local BossFolder = Main.Characters["Throne Isle"].Boss
            for _, bossName in ipairs(bosses) do
                local npc = BossFolder:FindFirstChild(bossName)
                if npc and npc:FindFirstChild("Humanoid") and npc.Humanoid.Health > 0 then
                    attackBoss(npc, HumanoidRootPart)
                end
            end
        end
        task.wait(0.5)
    end
end

local function startKillBosses()
    task.spawn(function()
        while KillBossesEnabled do
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local Humanoid = Character:WaitForChild("Humanoid")
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

            repeat task.wait(0.1) until Humanoid and Humanoid.Health > 0

            attackBossesLoop(HumanoidRootPart)

            task.wait(0.5)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(Character)
    if KillBossesEnabled then
        task.wait(1)
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        attackBossesLoop(HumanoidRootPart)
    end
end)

TabAutoFarm:AddToggle("KillBoss", {
    Title = "Auto Kill Boss",
    Description = "Sukuna Akaza David Only"
    Default = false,
    Callback = function(state)
        KillBossesEnabled = state
        if state then
            startKillBosses()
        end
    end
})



---------------------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------------------

local selectedStat = "Strength"
local amountToUpgrade = 1
local autoUpgradeEnabled = false

local StatDropdown = TabStat:AddDropdown("StatDropdown", {
    Title = "Select Stat",
    Values = {"Strength", "Defense", "Sword", "Power"},
    Multi = false,
    Default = 1,
})

StatDropdown:OnChanged(function(value)
    selectedStat = value
end)

local AmountInput = TabStat:AddInput("AmountInput", {
    Title = "Amount to Upgrade",
    Default = "1",
    Placeholder = "Enter amount",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        local num = tonumber(Value)
        if num and num > 0 then
            amountToUpgrade = num
        else
            amountToUpgrade = 1
        end
    end,
})

local AutoUpgradeToggle = TabStat:AddToggle("AutoUpgradeToggle", {
    Title = "Auto Upgrade Stat",
    Default = false,
})

AutoUpgradeToggle:OnChanged(function(value)
    autoUpgradeEnabled = value

    if autoUpgradeEnabled then
        task.spawn(function()
            local player = game.Players.LocalPlayer
            local StatEvent = player.PlayerGui.Button.Stats_Frame["{}"].Event

            while autoUpgradeEnabled do
                StatEvent:FireServer(selectedStat, amountToUpgrade)
                task.wait(1)
            end
        end)
    end
end)
----------------------------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local allNPCs = {
    workspace.Main.NPCs.Quests["1"],
    workspace.Main.NPCs.Quests["2"],
    workspace.Main.NPCs.Quests["3"],
    workspace.Main.NPCs.Quests["4"],
    workspace.Main.NPCs.Quests["5"],
    workspace.Main.NPCs.Quests["6"],
    workspace.Main.NPCs.Quests["7"],
    workspace.Main.NPCs.Quests["8"],
    workspace.Main.NPCs["Boss Spawn1"],
    workspace.Main.NPCs["Boss Spawn2"],
    workspace.Main.NPCs["Boss Spawn3"],
    workspace.Main.NPCs.Exchange,
    workspace.Main.NPCs["Fishing Rod"],
    workspace.Main.NPCs["Fruit Reroll Gem"],
    workspace.Main.NPCs["Fruit Reroll Money"],
    workspace.Main.NPCs["Group Reward"],
    workspace.Main.NPCs.Guarantee,
    workspace.Main.NPCs["Haki Trainer"],
    workspace.Main.NPCs.Mission,
    workspace.Main.NPCs["Observation Trainer"],
    workspace.Main.NPCs["Rank Up"],
    workspace.Main.NPCs.Shop,
    workspace.Main.NPCs["Stats Reroll"],
    workspace.Main.NPCs.Title,
    workspace.Main.NPCs["Set Spawn"]["1"],
    workspace.Main.NPCs["Set Spawn"]["2"],
    workspace.Main.NPCs["Set Spawn"]["3"],
    workspace.Main.NPCs["Set Spawn"]["4"],
    workspace.Main.NPCs["Set Spawn"]["5"],
    workspace.Main.NPCs["Set Spawn"]["6"],
    workspace.Main.NPCs["Set Spawn"]["7"],
    workspace.Main.NPCs["Set Spawn"]["8"],
    workspace.Main.NPCs["Trait Reroll"]
}

local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

RunService.Heartbeat:Connect(function()
    for _, npcFolder in pairs(allNPCs) do
        if npcFolder then
            for _, descendant in pairs(npcFolder:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    descendant.HoldDuration = 0
                end
            end
        end
    end
end)



SaveManager:LoadAutoloadConfig()
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Setting)
SaveManager:BuildConfigSection(Setting)
Window:SelectTab(1)
