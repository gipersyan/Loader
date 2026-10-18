local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local p = Players.LocalPlayer
local c = workspace.CurrentCamera

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Position = UDim2.new(0.1, 0, 0.2, 0)
Main.Size = UDim2.new(0, 180, 0, 200)
Main.BorderSizePixel = 0

local Bar = Instance.new("Frame", Main)
Bar.Size = UDim2.new(1, 0, 0, 30)
Bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Bar.BorderSizePixel = 0

local dragStart, startPos
Bar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragStart = i.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragStart and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

Bar.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragStart = nil
    end
end)

local T = Instance.new("TextLabel", Bar)
T.Text = "TTyan | Menu"
T.Size = UDim2.new(0, 120, 0, 30)
T.BackgroundTransparency = 1
T.TextColor3 = Color3.fromRGB(255, 255, 255)
T.Font = Enum.Font.SourceSansBold

local M = Instance.new("TextButton", Bar)
M.Text = "-"
M.Size = UDim2.new(0, 30, 0, 30)
M.Position = UDim2.new(0, 120, 0, 0)
M.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
M.TextColor3 = Color3.fromRGB(255, 255, 255)

local X = Instance.new("TextButton", Bar)
X.Text = "X"
X.Size = UDim2.new(0, 30, 0, 30)
X.Position = UDim2.new(0, 150, 0, 0)
X.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
X.TextColor3 = Color3.fromRGB(255, 255, 255)

local sc = Instance.new("ScrollingFrame", Main)
sc.Size = UDim2.new(0, 180, 0, 170)
sc.Position = UDim2.new(0, 0, 0, 30)
sc.BackgroundTransparency = 1
sc.CanvasSize = UDim2.new(0, 0, 0, 480)
sc.ScrollBarThickness = 4

X.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
M.MouseButton1Click:Connect(function()
    sc.Visible = not sc.Visible
    Main.Size = sc.Visible and UDim2.new(0, 180, 0, 200) or UDim2.new(0, 180, 0, 30)
    M.Text = sc.Visible and "-" or "+"
end)

local function btn(txt, y, bg, cb)
    local b = Instance.new("TextButton", sc)
    b.Text = txt
    b.Size = UDim2.new(0, 150, 0, 35)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = bg
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.BorderSizePixel = 0
    b.MouseButton1Click:Connect(function() cb(b) end)
    return b
end

local sv, fly, clip, god, invis, esp, speed, cw, cf, hd = nil, false, false, false, false, false, 70, 16, 70, false

btn("Сохранить Поз", 15, Color3.fromRGB(50, 120, 50), function(b) 
    local h = p.Character:FindFirstChild("HumanoidRootPart") 
    if h then sv = h.CFrame b.Text = "Сохранено!" task.wait(0.5) b.Text = "Сохранить Поз" end 
end)

btn("Телепорт Туда", 65, Color3.fromRGB(120, 50, 50), function() 
    local h = p.Character:FindFirstChild("HumanoidRootPart") 
    if h and sv then h.CFrame = sv end 
end)

btn("Полет: ВЫКЛ", 115, Color3.fromRGB(50, 50, 50), function(b)
    fly = not fly b.Text = fly and "Полет: ВКЛ" or "Полет: ВЫКЛ" b.BackgroundColor3 = fly and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    if fly then task.spawn(function()
        local h = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if h and hum then
            local bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
            bv.MaxForce, bg.MaxTorque = Vector3.new(1e9,1e9,1e9), Vector3.new(1e9,1e9,1e9) hum.PlatformStand = true
            while fly and p.Character and h.Parent do bv.Velocity = hum.MoveDirection.Magnitude > 0 and c.CFrame.LookVector * cf or Vector3.new(0,0,0) bg.CFrame = c.CFrame task.wait(0.01) end
            bv:Destroy() bg:Destroy() hum.PlatformStand = false
        end
    end) end
end)

btn("Сквозь Стены: ВЫКЛ", 165, Color3.fromRGB(50, 50, 50), function(b) 
    clip = not clip b.Text = clip and "Сквозь Стены: ВКЛ" or "Сквозь Стены: ВЫКЛ" b.BackgroundColor3 = clip and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50) 
end)

btn("Режим Бога: ВЫКЛ", 215, Color3.fromRGB(50, 50, 50), function(b) 
    god = not god b.Text = god and "Режим Бога: ВКЛ" or "Режим Бога: ВЫКЛ" b.BackgroundColor3 = god and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50) 
end)

btn("Невидимость ММ2", 265, Color3.fromRGB(50, 50, 50), function(b)
    invis = not invis b.Text = invis and "Призрак!👻" or "Невидимость ММ2" b.BackgroundColor3 = invis and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    pcall(function() 
        local ch = p.Character 
        if invis and ch then 
            task.spawn(function() 
                while invis and p.Character and ch:FindFirstChild("HumanoidRootPart") do 
                    ReplicatedStorage.TrapSystem.GhostPower:FireServer(true) 
                    for _,v in pairs(ch:GetChildren()) do 
                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 1 
                        elseif v:IsA("Accessory") then v.Handle.Transparency = 1 end 
                    end 
                    task.wait(0.2) 
                end 
            end) 
        elseif ch then 
            ReplicatedStorage.TrapSystem.GhostPower:FireServer(false) 
            for _,v in pairs(ch:GetDescendants()) do 
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 0 
                elseif v:IsA("Accessory") then v.Handle.Transparency = 0 end 
            end 
        end 
    end)
end)

btn("ESP Игроков: ВЫКЛ", 315, Color3.fromRGB(50, 50, 50), function(b)
    esp = not esp b.Text = esp and "ESP Игроков: ВКЛ" or "ESP Игроков: ВЫКЛ" b.BackgroundColor3 = esp and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    task.spawn(function() 
        while esp do 
            task.wait(1) 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then 
                    if not pl.Character.HumanoidRootPart:FindFirstChild("ESP") then 
                        local h = Instance.new("Highlight", pl.Character.HumanoidRootPart) 
                        h.Name = "ESP" h.FillColor, h.OutlineColor, h.FillTransparency = Color3.fromRGB(255, 255, 255), Color3.fromRGB(180, 50, 180), 0.5 
                    end 
                end 
            end 
        end 
        pcall(function() 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl.Character and pl.Character.HumanoidRootPart:FindFirstChild("ESP") then pl.Character.HumanoidRootPart.ESP:Destroy() end 
            end 
        end) 
    end)
end)

local Dk = Instance.new("TextButton", ScreenGui) 
Dk.Text, Dk.Size, Dk.Position, Dk.BackgroundColor3, Dk.TextColor3, Dk.BorderSizePixel, Dk.Font = "DROPKICK 💥", UDim2.new(0, 100, 0, 45), UDim2.new(0.4, 0, 0.8, 0), Color3.fromRGB(180, 50, 180), Color3.fromRGB(255, 255, 255), 0, Enum.Font.SourceSansBold
local kds, ksp

Dk.InputBegan:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then kds = i.Position ksp = Dk.Position end 
end)

UserInputService.InputChanged:Connect(function(i) 
    if kds and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
        local d = i.Position - kds Dk.Position = UDim2.new(ksp.X.Scale, ksp.X.Offset + d.X, ksp.Y.Scale, ksp.Y.Offset + d.Y) 
    end 
end)

Dk.InputEnded:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then kds = nil end 
end)

Dk.MouseButton1Click:Connect(function()
    pcall(function() 
        local ch = p.Character 
        if ch and ch:FindFirstChild("HumanoidRootPart") then 
            ch.HumanoidRootPart.CFrame = ch.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-45), 0, 0) 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then 
                    local d = (ch.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude 
                    if d < 12 then 
                        local v = Instance.new("BodyVelocity", pl.Character.HumanoidRootPart) 
                        v.MaxForce, v.Velocity = Vector3.new(1e7, 1e7, 1e7), (pl.Character.HumanoidRootPart.Position - ch.HumanoidRootPart.Position).Unit * 140 + Vector3.new(0, 50, 0) 
                        task.wait(0.1) v:Destroy() 
                    end 
                end 
            end 
            task.wait(0.2) ch.HumanoidRootPart.CFrame = ch.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(45), 0, 0) 
        end 
    end)
end)

local SF = Instance.new("Frame", sc) SF.Size, SF.Position, SF.BackgroundTransparency = UDim2.new(0, 150, 0, 15), UDim2.new(0, 10, 0, 370), 1
local Line = Instance.new("Frame", SF) Line.Size, Line.Position, Line.BackgroundColor3 = UDim2.new(1, 0, 0, 2), UDim2.new(0, 0, 0.5, -1), Color3.fromRGB(100, 100, 100)
local SB = Instance.new("TextButton", SF) SB.Size, SB.Position, SB.BackgroundColor3, SB.Text, SB.BorderSizePixel = UDim2.new(0, 12, 0, 12), UDim2.new(0.2, -6, 0.5, -6), Color3.fromRGB(0, 120, 255), "", 0
local sv, fly, clip, god, invis, esp, speed, cw, cf, hd = nil, false, false, false, false, false, 70, 16, 70, false

btn("Сохранить Поз", 15, Color3.fromRGB(50, 120, 50), function(b) 
    local h = p.Character:FindFirstChild("HumanoidRootPart") 
    if h then sv = h.CFrame b.Text = "Сохранено!" task.wait(0.5) b.Text = "Сохранить Поз" end 
end)

btn("Телепорт Туда", 65, Color3.fromRGB(120, 50, 50), function() 
    local h = p.Character:FindFirstChild("HumanoidRootPart") 
    if h and sv then h.CFrame = sv end 
end)

btn("Полет: ВЫКЛ", 115, Color3.fromRGB(50, 50, 50), function(b)
    fly = not fly b.Text = fly and "Полет: ВКЛ" or "Полет: ВЫКЛ" b.BackgroundColor3 = fly and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    if fly then task.spawn(function()
        local h = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if h and hum then
            local bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
            bv.MaxForce, bg.MaxTorque = Vector3.new(1e9,1e9,1e9), Vector3.new(1e9,1e9,1e9) hum.PlatformStand = true
            while fly and p.Character and h.Parent do bv.Velocity = hum.MoveDirection.Magnitude > 0 and c.CFrame.LookVector * cf or Vector3.new(0,0,0) bg.CFrame = c.CFrame task.wait(0.01) end
            bv:Destroy() bg:Destroy() hum.PlatformStand = false
        end
    end) end
end)

btn("Сквозь Стены: ВЫКЛ", 165, Color3.fromRGB(50, 50, 50), function(b) 
    clip = not clip b.Text = clip and "Сквозь Стены: ВКЛ" or "Сквозь Стены: ВЫКЛ" b.BackgroundColor3 = clip and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50) 
end)

btn("Режим Бога: ВЫКЛ", 215, Color3.fromRGB(50, 50, 50), function(b) 
    god = not god b.Text = god and "Режим Бога: ВКЛ" or "Режим Бога: ВЫКЛ" b.BackgroundColor3 = god and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50) 
end)

btn("Невидимость ММ2", 265, Color3.fromRGB(50, 50, 50), function(b)
    invis = not invis b.Text = invis and "Призрак!👻" or "Невидимость ММ2" b.BackgroundColor3 = invis and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    pcall(function() 
        local ch = p.Character 
        if invis and ch then 
            task.spawn(function() 
                while invis and p.Character and ch:FindFirstChild("HumanoidRootPart") do 
                    ReplicatedStorage.TrapSystem.GhostPower:FireServer(true) 
                    for _,v in pairs(ch:GetChildren()) do 
                        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 1 
                        elseif v:IsA("Accessory") then v.Handle.Transparency = 1 end 
                    end 
                    task.wait(0.2) 
                end 
            end) 
        elseif ch then 
            ReplicatedStorage.TrapSystem.GhostPower:FireServer(false) 
            for _,v in pairs(ch:GetDescendants()) do 
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = 0 
                elseif v:IsA("Accessory") then v.Handle.Transparency = 0 end 
            end 
        end 
    end)
end)

btn("ESP Игроков: ВЫКЛ", 315, Color3.fromRGB(50, 50, 50), function(b)
    esp = not esp b.Text = esp and "ESP Игроков: ВКЛ" or "ESP Игроков: ВЫКЛ" b.BackgroundColor3 = esp and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    task.spawn(function() 
        while esp do 
            task.wait(1) 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then 
                    if not pl.Character.HumanoidRootPart:FindFirstChild("ESP") then 
                        local h = Instance.new("Highlight", pl.Character.HumanoidRootPart) 
                        h.Name = "ESP" h.FillColor, h.OutlineColor, h.FillTransparency = Color3.fromRGB(255, 255, 255), Color3.fromRGB(180, 50, 180), 0.5 
                    end 
                end 
            end 
        end 
        pcall(function() 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl.Character and pl.Character.HumanoidRootPart:FindFirstChild("ESP") then pl.Character.HumanoidRootPart.ESP:Destroy() end 
            end 
        end) 
    end)
end)

local Dk = Instance.new("TextButton", ScreenGui) 
Dk.Text, Dk.Size, Dk.Position, Dk.BackgroundColor3, Dk.TextColor3, Dk.BorderSizePixel, Dk.Font = "DROPKICK 💥", UDim2.new(0, 100, 0, 45), UDim2.new(0.4, 0, 0.8, 0), Color3.fromRGB(180, 50, 180), Color3.fromRGB(255, 255, 255), 0, Enum.Font.SourceSansBold
local kds, ksp

Dk.InputBegan:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then kds = i.Position ksp = Dk.Position end 
end)

UserInputService.InputChanged:Connect(function(i) 
    if kds and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
        local d = i.Position - kds Dk.Position = UDim2.new(ksp.X.Scale, ksp.X.Offset + d.X, ksp.Y.Scale, ksp.Y.Offset + d.Y) 
    end 
end)

Dk.InputEnded:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then kds = nil end 
end)

Dk.MouseButton1Click:Connect(function()
    pcall(function() 
        local ch = p.Character 
        if ch and ch:FindFirstChild("HumanoidRootPart") then 
            ch.HumanoidRootPart.CFrame = ch.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-45), 0, 0) 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then 
                    local d = (ch.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude 
                    if d < 12 then 
                        local v = Instance.new("BodyVelocity", pl.Character.HumanoidRootPart) 
                        v.MaxForce, v.Velocity = Vector3.new(1e7, 1e7, 1e7), (pl.Character.HumanoidRootPart.Position - ch.HumanoidRootPart.Position).Unit * 140 + Vector3.new(0, 50, 0) 
                        task.wait(0.1) v:Destroy() 
                    end 
                end 
            end 
            task.wait(0.2) ch.HumanoidRootPart.CFrame = ch.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(45), 0, 0) 
        end 
    end)
end)

local SF = Instance.new("Frame", sc) SF.Size, SF.Position, SF.BackgroundTransparency = UDim2.new(0, 150, 0, 15), UDim2.new(0, 10, 0, 370), 1
local Line = Instance.new("Frame", SF) Line.Size, Line.Position, Line.BackgroundColor3 = UDim2.new(1, 0, 0, 2), UDim2.new(0, 0, 0.5, -1), Color3.fromRGB(100, 100, 100)
local SB = Instance.new("TextButton", SF) SB.Size, SB.Position, SB.BackgroundColor3, SB.Text, SB.BorderSizePixel = UDim2.new(0, 12, 0, 12), UDim2.new(0.2, -6, 0.5, -6), Color3.fromRGB(0, 120, 255), "", 0
local SL = Instance.new("TextLabel", sc) SL.Size, SL.Position, SL.Text, SL.TextColor3, SL.TextSize, SL.BackgroundTransparency = UDim2.new(0, 150, 0, 20), UDim2.new(0, 10, 0, 385), "Выбрано: 70", Color3.fromRGB(255, 255, 255), 11, 1

SB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hd = true end end)
UserInputService.InputChanged:Connect(function(i) 
    if hd and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
        local pct = math.clamp((i.Position.X - SF.AbsolutePosition.X) / SF.AbsoluteSize.X, 0, 1) 
        SB.Position = UDim2.new(pct, -6, 0.5, -6) speed = math.floor(16 + (pct * 284)) SL.Text = "Выбрано: " .. speed 
    end 
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hd = nil end end)

local B1 = Instance.new("TextButton", sc) B1.Text, B1.Size, B1.Position, B1.BackgroundColor3, B1.TextColor3, B1.TextSize = "Спд Бега", UDim2.new(0, 48, 0, 22), UDim2.new(0, 10, 0, 410), Color3.fromRGB(0, 120, 255), Color3.fromRGB(255, 255, 255), 9
local B2 = Instance.new("TextButton", sc) B2.Text, B2.Size, B2.Position, B2.BackgroundColor3, B2.TextColor3, B2.TextSize = "Спд Флай", UDim2.new(0, 48, 0, 22), UDim2.new(0, 61, 0, 410), Color3.fromRGB(0, 120, 255), Color3.fromRGB(255, 255, 255), 9
local B3 = Instance.new("TextButton", sc) B3.Text, B3.Size, B3.Position, B3.BackgroundColor3, B3.TextColor3, B3.TextSize = "Сброс", UDim2.new(0, 48, 0, 22), UDim2.new(0, 112, 0, 410), Color3.fromRGB(80, 80, 80), Color3.fromRGB(255, 255, 255), 9

B1.MouseButton1Click:Connect(function() cw = speed SL.Text = "Бег: " .. speed local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = cw end end)
B2.MouseButton1Click:Connect(function() cf = speed SL.Text = "Флай: " .. speed end)
B3.MouseButton1Click:Connect(function() speed, cw, cf = 70, 16, 70 SB.Position = UDim2.new(0.2, -6, 0.5, -6) SL.Text = "Сброшено" local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = 16 end end)

pcall(function() p.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), c.CFrame) task.wait(1) game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), c.CFrame) end) end)

RunService.Stepped:Connect(function() 
    if clip and p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end 
    if god and p.Character then pcall(function() for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanTouch = false end end end) 
    else pcall(function() if p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and not invis then v.CanTouch = true end end end end) end 

        local SF = Instance.new("Frame", sc) SF.Size, SF.Position, SF.BackgroundTransparency = UDim2.new(0, 150, 0, 15), UDim2.new(0, 10, 0, 370), 1
local Line = Instance.new("Frame", SF) Line.Size, Line.Position, Line.BackgroundColor3 = UDim2.new(1, 0, 0, 2), UDim2.new(0, 0, 0.5, -1), Color3.fromRGB(100, 100, 100)
local SB = Instance.new("TextButton", SF) SB.Size, SB.Position, SB.BackgroundColor3, SB.Text, SB.BorderSizePixel = UDim2.new(0, 12, 0, 12), UDim2.new(0.2, -6, 0.5, -6), Color3.fromRGB(0, 120, 255), "", 0
local SL = Instance.new("TextLabel", sc) SL.Size, SL.Position, SL.Text, SL.TextColor3, SL.TextSize, SL.BackgroundTransparency = UDim2.new(0, 150, 0, 20), UDim2.new(0, 10, 0, 385), "Выбрано: 70", Color3.fromRGB(255, 255, 255), 11, 1

SB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hd = true end end)
UserInputService.InputChanged:Connect(function(i) 
    if hd and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
        local pct = math.clamp((i.Position.X - SF.AbsolutePosition.X) / SF.AbsoluteSize.X, 0, 1) 
        SB.Position = UDim2.new(pct, -6, 0.5, -6) speed = math.floor(16 + (pct * 284)) SL.Text = "Выбрано: " .. speed 
    end 
end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hd = nil end end)
        local B1 = Instance.new("TextButton", sc) B1.Text, B1.Size, B1.Position, B1.BackgroundColor3, B1.TextColor3, B1.TextSize = "Спд Бега", UDim2.new(0, 48, 0, 22), UDim2.new(0, 10, 0, 410), Color3.fromRGB(0, 120, 255), Color3.fromRGB(255, 255, 255), 9
local B2 = Instance.new("TextButton", sc) B2.Text, B2.Size, B2.Position, B2.BackgroundColor3, B2.TextColor3, B2.TextSize = "Спд Флай", UDim2.new(0, 48, 0, 22), UDim2.new(0, 61, 0, 410), Color3.fromRGB(0, 120, 255), Color3.fromRGB(255, 255, 255), 9
local B3 = Instance.new("TextButton", sc) B3.Text, B3.Size, B3.Position, B3.BackgroundColor3, B3.TextColor3, B3.TextSize = "Сброс", UDim2.new(0, 48, 0, 22), UDim2.new(0, 112, 0, 410), Color3.fromRGB(80, 80, 80), Color3.fromRGB(255, 255, 255), 9

B1.MouseButton1Click:Connect(function() cw = speed SL.Text = "Бег: " .. speed local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = cw end end)
B2.MouseButton1Click:Connect(function() cf = speed SL.Text = "Флай: " .. speed end)
B3.MouseButton1Click:Connect(function() speed, cw, cf = 70, 16, 70 SB.Position = UDim2.new(0.2, -6, 0.5, -6) SL.Text = "Сброшено" local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = 16 end end)

local Dk = Instance.new("TextButton", sg) Dk.Text, Dk.Size, Dk.Position, Dk.BackgroundColor3, Dk.TextColor3, Dk.BorderSizePixel, Dk.Font = "DROPKICK 💥", UDim2.new(0, 100, 0, 45), UDim2.new(0.4, 0, 0.8, 0), Color3.fromRGB(180, 50, 180), Color3.fromRGB(255, 255, 255), 0, Enum.Font.SourceSansBold
local kds, ksp

Dk.InputBegan:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then kds = i.Position ksp = Dk.Position end 
end)

UserInputService.InputChanged:Connect(function(i) 
    if kds and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
        local d = i.Position - kds Dk.Position = UDim2.new(ksp.X.Scale, ksp.X.Offset + d.X, ksp.Y.Scale, ksp.Y.Offset + d.Y) 
    end 
end)

Dk.InputEnded:Connect(function(i) 
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then kds = nil end 
end)

Dk.MouseButton1Click:Connect(function()
    pcall(function() 
        local ch = p.Character 
        if ch and ch:FindFirstChild("HumanoidRootPart") then 
            ch.HumanoidRootPart.CFrame = ch.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-45), 0, 0) 
            for _,pl in pairs(Players:GetPlayers()) do 
                if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then 
                    local d = (ch.HumanoidRootPart.Position - pl.Character.HumanoidRootPart.Position).Magnitude 
                    if d < 12 then 
                        local v = Instance.new("BodyVelocity", pl.Character.HumanoidRootPart) 
                        v.MaxForce, v.Velocity = Vector3.new(1e7, 1e7, 1e7), (pl.Character.HumanoidRootPart.Position - ch.HumanoidRootPart.Position).Unit * 140 + Vector3.new(0, 50, 0) 
                        task.wait(0.1) v:Destroy() 
                    end 
                end 
            end 
            task.wait(0.2) ch.HumanoidRootPart.CFrame = ch.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(45), 0, 0) 
        end 
    end)
end)

pcall(function() p.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), c.CFrame) task.wait(1) game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), c.CFrame) end) end)

RunService.Stepped:Connect(function() 
    if clip and p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end 
    if god and p.Character then pcall(function() for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanTouch = false end end end) 
    else pcall(function() if p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and not invis then v.CanTouch = true end end end end) end 
    pcall(function() if p.Character and p.Character.Humanoid.SeatPart then local seat = p.Character.Humanoid.SeatPart.Parent:FindFirstChildOfClass("VehicleSeat") or p.Character.Humanoid.SeatPart.Parent.DriveSeat if seat then seat.MaxSpeed = speed if seat.CFrame.UpVector.Y < 0.2 then seat.CFrame = CFrame.new(seat.Position) * CFrame.Angles(0, math.rad(seat.Orientation.Y), 0) end end end end) 
end)
