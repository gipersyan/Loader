local p, c = game.Players.LocalPlayer, workspace.CurrentCamera
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
Bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragStart = i.Position startPos = Main.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if dragStart and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local d = i.Position - dragStart Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y) end end)
Bar.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragStart = nil end end)

local T = Instance.new("TextLabel", Bar) T.Text = "TTyan" T.Size = UDim2.new(0, 120, 0, 30) T.BackgroundTransparency = 1 T.TextColor3 = Color3.fromRGB(255, 255, 255) T.Font = Enum.Font.SourceSansBold
local M = Instance.new("TextButton", Bar) M.Text = "-" M.Size = UDim2.new(0, 30, 0, 30) M.Position = UDim2.new(0, 120, 0, 0) M.BackgroundColor3 = Color3.fromRGB(60, 60, 60) M.TextColor3 = Color3.fromRGB(255, 255, 255) M.BorderSizePixel = 0
local X = Instance.new("TextButton", Bar) X.Text = "X" X.Size = UDim2.new(0, 30, 0, 30) X.Position = UDim2.new(0, 150, 0, 0) X.BackgroundColor3 = Color3.fromRGB(150, 50, 50) X.TextColor3 = Color3.fromRGB(255, 255, 255) X.BorderSizePixel = 0

local Scroll = Instance.new("ScrollingFrame", Main) Scroll.Size = UDim2.new(0, 180, 0, 170) Scroll.Position = UDim2.new(0, 0, 0, 30) Scroll.BackgroundTransparency = 1 Scroll.CanvasSize = UDim2.new(0, 0, 0, 430) Scroll.ScrollBarThickness = 4 Scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

X.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
M.MouseButton1Click:Connect(function() Scroll.Visible = not Scroll.Visible Main.Size = Scroll.Visible and UDim2.new(0, 180, 0, 200) or UDim2.new(0, 180, 0, 30) M.Text = Scroll.Visible and "-" or "+" end)

local function btn(txt, y, bg, cb)
    local b = Instance.new("TextButton", Scroll) b.Text = txt b.Size = UDim2.new(0, 150, 0, 35) b.Position = UDim2.new(0, 10, 0, y) b.BackgroundColor3 = bg b.TextColor3 = Color3.fromRGB(255, 255, 255) b.BorderSizePixel = 0
    b.MouseButton1Click:Connect(function() cb(b) end) return b
end

local saved, fly, clip, god, invis, speed, curWalk, curFly, hold = nil, false, false, false, false, 70, 16, 70, false
btn("Сохранить Поз", 15, Color3.fromRGB(50, 120, 50), function(b) local h = p.Character:FindFirstChild("HumanoidRootPart") if h then saved = h.CFrame b.Text = "Сохранено!" task.wait(0.5) b.Text = "Сохранить Поз" end end)
btn("Телепорт Туда", 65, Color3.fromRGB(120, 50, 50), function() local h = p.Character:FindFirstChild("HumanoidRootPart") if h and saved then h.CFrame = saved end end)

btn("Полет: ВЫКЛ", 115, Color3.fromRGB(50, 50, 50), function(b)
    fly = not fly b.Text = fly and "Полет: ВКЛ" or "Полет: ВЫКЛ" b.BackgroundColor3 = fly and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    if fly then task.spawn(function()
        local h = p.Character:FindFirstChild("HumanoidRootPart") local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if h and hum then
            local bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
            bv.MaxForce, bg.MaxTorque = Vector3.new(1e9,1e9,1e9), Vector3.new(1e9,1e9,1e9) hum.PlatformStand = true
            while fly and p.Character and h.Parent do bv.Velocity = hum.MoveDirection.Magnitude > 0 and c.CFrame.LookVector * curFly or Vector3.new(0,0,0) bg.CFrame = c.CFrame task.wait(0.01) end
            bv:Destroy() bg:Destroy() hum.PlatformStand = false
        end
    end) end
end)

btn("Сквозь Стены: ВЫКЛ", 165, Color3.fromRGB(50, 50, 50), function(b) clip = not clip b.Text = clip and "Сквозь Стены: ВКЛ" or "Сквозь Стены: ВЫКЛ" b.BackgroundColor3 = clip and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50) end)
btn("Режим Бога: ВЫКЛ", 215, Color3.fromRGB(50, 50, 50), function(b) god = not god b.Text = god and "Режим Бога: ВКЛ" or "Режим Бога: ВЫКЛ" b.BackgroundColor3 = god and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50) end)

btn("Невидимость: ВЫКЛ", 265, Color3.fromRGB(50, 50, 50), function(b)
    invis = not invis b.Text = invis and "Невидимость: ВКЛ" or "Невидимость: ВЫКЛ" b.BackgroundColor3 = invis and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(50, 50, 50)
    pcall(function() if p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then v.Transparency = invis and 1 or 0 elseif v:IsA("Decal") then v.Transparency = invis and 1 or 0 end end end end)
end)

local SF = Instance.new("Frame", Scroll) SF.Size = UDim2.new(0, 150, 0, 15) SF.Position = UDim2.new(0, 10, 0, 320) SF.BackgroundTransparency = 1
local Line = Instance.new("Frame", SF) Line.Size = UDim2.new(1, 0, 0, 2) Line.Position = UDim2.new(0, 0, 0.5, -1) Line.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
local SB = Instance.new("TextButton", SF) SB.Size = UDim2.new(0, 12, 0, 12) SB.Position = UDim2.new(0.2, -6, 0.5, -6) SB.BackgroundColor3 = Color3.fromRGB(0, 120, 255) SB.Text = "" SB.BorderSizePixel = 0
local SL = Instance.new("TextLabel", Scroll) SL.Size = UDim2.new(0, 150, 0, 20) SL.Position = UDim2.new(0, 10, 0, 335) SL.Text = "Выбрано: 70" SL.TextColor3 = Color3.fromRGB(255, 255, 255) SL.TextSize = 11 SL.BackgroundTransparency = 1

SB.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hold = true end end)
game:GetService("UserInputService").InputChanged:Connect(function(i)
    if hold and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local pct = math.clamp((i.Position.X - SF.AbsolutePosition.X) / SF.AbsoluteSize.X, 0, 1)
        SB.Position = UDim2.new(pct, -6, 0.5, -6) speed = math.floor(16 + (pct * 284)) SL.Text = "Выбрано: " .. speed
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hold = nil end end)

local B1 = Instance.new("TextButton", Scroll) B1.Text = "Спд Бега" B1.Size = UDim2.new(0, 48, 0, 22) B1.Position = UDim2.new(0, 10, 0, 360) B1.BackgroundColor3 = Color3.fromRGB(0, 120, 255) B1.TextColor3 = Color3.fromRGB(255,255,255) B1.TextSize = 9 B1.BorderSizePixel = 0
local B2 = Instance.new("TextButton", Scroll) B2.Text = "Спд Флай" B2.Size = UDim2.new(0, 48, 0, 22) B2.Position = UDim2.new(0, 61, 0, 360) B2.BackgroundColor3 = Color3.fromRGB(0, 120, 255) B2.TextColor3 = Color3.fromRGB(255,255,255) B2.TextSize = 9 B2.BorderSizePixel = 0
local B3 = Instance.new("TextButton", Scroll) B3.Text = "Сброс" B3.Size = UDim2.new(0, 48, 0, 22) B3.Position = UDim2.new(0, 112, 0, 360) B3.BackgroundColor3 = Color3.fromRGB(80, 80, 80) B3.TextColor3 = Color3.fromRGB(255,255,255) B3.TextSize = 9 B3.BorderSizePixel = 0

B1.MouseButton1Click:Connect(function() curWalk = speed SL.Text = "Бег: " .. speed local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = curWalk end end)
B2.MouseButton1Click:Connect(function() curFly = speed SL.Text = "Флай: " .. speed end)
B3.MouseButton1Click:Connect(function() speed, curWalk, curFly = 70, 16, 70 SB.Position = UDim2.new(0.2, -6, 0.5, -6) SL.Text = "Сброс" local hum = p.Character:FindFirstChildOfClass("Humanoid") if hum then hum.WalkSpeed = 16 end end)

pcall(function() p.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), c.CFrame) task.wait(1) game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), c.CFrame) end) end)

game:GetService("RunService").Stepped:Connect(function()
    if clip and p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
    if god and p.Character then pcall(function() for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanTouch = false end end end)
    else pcall(function() if p.Character then for _, v in pairs(p.Character:GetDescendants()) do if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and not invis then v.CanTouch = true end end end end) end
    pcall(function() if p.Character and p.Character.Humanoid.SeatPart then local seat = p.Character.Humanoid.SeatPart.Parent:FindFirstChildOfClass("VehicleSeat") or p.Character.Humanoid.SeatPart.Parent.DriveSeat if seat then seat.MaxSpeed = speed if seat.CFrame.UpVector.Y < 0.2 then seat.CFrame = CFrame.new(seat.Position) * CFrame.Angles(0, math.rad(seat.Orientation.Y), 0) end end end end)
end)
