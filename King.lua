-- [[ 👑 VOIDWARE: OVERSEER EDITION (FIXED & FULL) 👑 ]] --
local P = game:GetService("Players")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local L = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local CG = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or P.LocalPlayer:WaitForChild("PlayerGui")
local LP = P.LocalPlayer
local Cam = WS.CurrentCamera

-- Анти-АФК
LP.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), Cam.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), Cam.CFrame)
end)

-- База состояний
local S = {UWS=false, WS=16, UJP=false, JP=50, Fly=false, FlyS=50, Nc=false, InfJ=false, BH=false, Aim=false, FOV=500, Smth=0.5, HB=false, HBS=15, Rch=false, KA=false, MF=false, Tgt=nil, Flg=false, Att=false, ESP=false, Chm=false, CFly=false}

if CG:FindFirstChild("VW_APEX") then CG.VW_APEX:Destroy() end
local Gui = Instance.new("ScreenGui", CG)
Gui.Name = "VW_APEX"
Gui.ResetOnSpawn = false

local TglBtn = Instance.new("TextButton", Gui)
TglBtn.Size = UDim2.new(0, 60, 0, 60)
TglBtn.Position = UDim2.new(0, 15, 0.5, -30)
TglBtn.BackgroundColor3 = Color3.fromRGB(15, 0, 10)
TglBtn.Text = "👑"
TglBtn.TextSize = 30
TglBtn.Draggable = true
Instance.new("UICorner", TglBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", TglBtn).Color = Color3.fromRGB(255, 0, 50)
Instance.new("UIStroke", TglBtn).Thickness = 2

local MF = Instance.new("Frame", Gui)
MF.Size = UDim2.new(0, 700, 0, 500)
MF.Position = UDim2.new(0.5, -350, 0.5, -250)
MF.BackgroundColor3 = Color3.fromRGB(12, 4, 8)
MF.Visible = false
MF.Active = true
MF.Draggable = true
Instance.new("UICorner", MF).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MF).Color = Color3.fromRGB(255, 0, 50)
Instance.new("UIStroke", MF).Thickness = 2

local TB = Instance.new("Frame", MF)
TB.Size = UDim2.new(1, 0, 0, 35)
TB.BackgroundColor3 = Color3.fromRGB(20, 5, 15)
Instance.new("UICorner", TB)

local TT = Instance.new("TextLabel", TB)
TT.Size = UDim2.new(1, -15, 1, 0)
TT.Position = UDim2.new(0, 15, 0, 0)
TT.BackgroundTransparency = 1
TT.Text = "VOIDWARE OVERSEER (FIXED EDITION)"
TT.TextColor3 = Color3.fromRGB(255, 0, 50)
TT.Font = Enum.Font.GothamBold
TT.TextSize = 16
TT.TextXAlignment = 0

local TabC = Instance.new("ScrollingFrame", MF)
TabC.Size = UDim2.new(0, 160, 1, -45)
TabC.Position = UDim2.new(0, 10, 0, 40)
TabC.BackgroundTransparency = 1
TabC.ScrollBarThickness = 0
local TabL = Instance.new("UIListLayout", TabC)
TabL.Padding = UDim.new(0, 4)

local PageC = Instance.new("Frame", MF)
PageC.Size = UDim2.new(1, -180, 1, -45)
PageC.Position = UDim2.new(0, 175, 0, 40)
PageC.BackgroundTransparency = 1

TglBtn.MouseButton1Click:Connect(function() MF.Visible = not MF.Visible end)

local TabsList = {}
local function MkTab(name)
    local btn = Instance.new("TextButton", TabC)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 10, 20)
    btn.Text = name
    btn.TextColor3 = Color3.new(0.6, 0.6, 0.6)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn)
    
    local page = Instance.new("ScrollingFrame", PageC)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 50)
    page.Visible = false
    local pL = Instance.new("UIListLayout", page)
    pL.Padding = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(PageC:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
        for _, v in pairs(TabC:GetChildren()) do
            if v:IsA("TextButton") then
                v.TextColor3 = Color3.new(0.6, 0.6, 0.6)
                v.BackgroundColor3 = Color3.fromRGB(25, 10, 20)
            end
        end
        page.Visible = true
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
    end)
    
    table.insert(TabsList, {b = btn, p = page})
    
    local E = {}
    function E:T(txt, cb)
        local t = Instance.new("TextButton", page)
        t.Size = UDim2.new(1, -10, 0, 35)
        t.BackgroundColor3 = Color3.fromRGB(20, 5, 15)
        t.Text = "  [OFF] " .. txt
        t.TextColor3 = Color3.new(0.6, 0.6, 0.6)
        t.Font = Enum.Font.GothamBold
        t.TextSize = 14
        t.TextXAlignment = 0
        Instance.new("UICorner", t)
        local s = false
        t.MouseButton1Click:Connect(function()
            s = not s
            if s then
                t.Text = "  [ON] " .. txt
                t.TextColor3 = Color3.new(0, 1, 0)
            else
                t.Text = "  [OFF] " .. txt
                t.TextColor3 = Color3.new(0.6, 0.6, 0.6)
            end
            pcall(function() cb(s) end)
        end)
        page.CanvasSize = UDim2.new(0, 0, 0, pL.AbsoluteContentSize.Y + 10)
    end
    
    function E:B(txt, cb)
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, -10, 0, 35)
        b.BackgroundColor3 = Color3.fromRGB(35, 10, 25)
        b.Text = txt
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 14
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() pcall(cb) end)
        page.CanvasSize = UDim2.new(0, 0, 0, pL.AbsoluteContentSize.Y + 10)
    end
    
    function E:Box(txt, ph, cb)
        local f = Instance.new("Frame", page)
        f.Size = UDim2.new(1, -10, 0, 35)
        f.BackgroundColor3 = Color3.fromRGB(20, 5, 15)
        Instance.new("UICorner", f)
        local l = Instance.new("TextLabel", f)
        l.Size = UDim2.new(0.6, 0, 1, 0)
        l.BackgroundTransparency = 1
        l.Text = "  " .. txt
        l.TextColor3 = Color3.new(1, 1, 1)
        l.Font = Enum.Font.GothamBold
        l.TextSize = 14
        l.TextXAlignment = 0
        local tb = Instance.new("TextBox", f)
        tb.Size = UDim2.new(0.35, 0, 0.8, 0)
        tb.Position = UDim2.new(0.6, 0, 0.1, 0)
        tb.BackgroundColor3 = Color3.fromRGB(10, 0, 5)
        tb.TextColor3 = Color3.new(1, 1, 1)
        tb.PlaceholderText = ph
        tb.Font = Enum.Font.GothamBold
        tb.TextSize = 14
        Instance.new("UICorner", tb)
        tb.FocusLost:Connect(function() pcall(function() cb(tb.Text) end) end)
        page.CanvasSize = UDim2.new(0, 0, 0, pL.AbsoluteContentSize.Y + 10)
    end
    
    return E, page
end

-- ================= ВКЛАДКИ (С ИСПРАВЛЕНИЯМИ ОТКЛЮЧЕНИЯ) =================
local T1 = MkTab("👤 Игрок & Статы")
T1:Box("Своя Скорость:", "Напр: 100", function(t) S.WS = tonumber(t) or 16 end)
T1:T("⚡ ПРИМЕНИТЬ СКОРОСТЬ", function(v) 
    S.UWS = v 
    if not v and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character.Humanoid.WalkSpeed = 16 end 
end)
T1:Box("Свой Прыжок:", "Напр: 100", function(t) S.JP = tonumber(t) or 50 end)
T1:T("🚀 ПРИМЕНИТЬ ПРЫЖОК", function(v) 
    S.UJP = v 
    if not v and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then LP.Character.Humanoid.JumpPower = 50 end 
end)
T1:Box("Скорость Полета:", "Напр: 100", function(t) S.FlyS = tonumber(t) or 50 end)
T1:T("✈️ Включить Полет (Fly)", function(v) S.Fly = v end)
T1:T("👻 Noclip", function(v) 
    S.Nc = v 
    if not v and LP.Character then 
        for _, p in pairs(LP.Character:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = true end end 
    end 
end)
T1:T("🐇 Бесконечный прыжок", function(v) S.InfJ = v end) 

-- Бесконечный прыжок (работает всегда корректно)
UIS.JumpRequest:Connect(function()
    if S.InfJ and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local T2 = MkTab("⚔️ Аимбот & Бой")
T2:T("🎯 Aimbot", function(v) S.Aim = v end) 
T2:Box("Радиус Аима (FOV):", "Стандарт: 500", function(t) S.FOV = tonumber(t) or 500 end)
T2:T("🔲 Хитбоксы", function(v) S.HB = v end) 
T2:Box("Размер Хитбокса:", "Напр: 15", function(t) S.HBS = tonumber(t) or 15 end)
T2:T("🗡️ Огромный Меч (Reach)", function(v) 
    S.Rch = v 
    if not v and LP.Character then 
        local t = LP.Character:FindFirstChildOfClass("Tool")
        if t and t:FindFirstChild("Handle") then t.Handle.Size = Vector3.new(1, 0.8, 4) t.Handle.Massless = false end
    end
end) 
T2:T("🌪️ Kill Aura", function(v) 
    S.KA = v 
    if not v and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.RotVelocity = Vector3.zero end 
end) 

local T3 = MkTab("🌍 Сервер & Хаос")
T3:T("☠️ MASS FLING", function(v) 
    S.MF = v 
    if not v and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.RotVelocity = Vector3.zero end 
end) 
T3:B("🔨 Выдать BTools", function() for _, v in pairs({"Hammer", "Clone", "Grab"}) do Instance.new("HopperBin", LP.Backpack).BinType = Enum.BinType[v] end end) 

local T4, p4 = MkTab("🎯 Админ Панель")
local TargetBtn = Instance.new("TextButton", p4)
TargetBtn.Size = UDim2.new(1, -10, 0, 35)
TargetBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 40)
TargetBtn.Text = "👥 Кликни, чтобы выбрать жертву"
TargetBtn.TextColor3 = Color3.new(1, 1, 1)
TargetBtn.Font = Enum.Font.GothamBold
TargetBtn.TextSize = 14
Instance.new("UICorner", TargetBtn)

local PList = Instance.new("Frame", p4)
PList.Size = UDim2.new(1, -10, 0, 150)
PList.BackgroundColor3 = Color3.fromRGB(15, 5, 20)
PList.Visible = false
Instance.new("UICorner", PList)
local PLScroll = Instance.new("ScrollingFrame", PList)
PLScroll.Size = UDim2.new(1, -10, 1, -10)
PLScroll.Position = UDim2.new(0, 5, 0, 5)
PLScroll.BackgroundTransparency = 1
PLScroll.ScrollBarThickness = 4
local PLLay = Instance.new("UIListLayout", PLScroll)
PLLay.Padding = UDim.new(0, 2)

local function UpdPlrs()
    for _, v in pairs(PLScroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(P:GetPlayers()) do
        if p ~= LP then
            local pB = Instance.new("TextButton", PLScroll)
            pB.Size = UDim2.new(1, -5, 0, 25)
            pB.BackgroundColor3 = Color3.fromRGB(25, 5, 30)
            pB.Text = p.Name
            pB.TextColor3 = Color3.new(0.9, 0.9, 0.9)
            pB.Font = Enum.Font.Gotham
            pB.TextSize = 12
            Instance.new("UICorner", pB)
            pB.MouseButton1Click:Connect(function()
                S.Tgt = p
                TargetBtn.Text = "🎯 Выбрана жертва: " .. p.Name
                PList.Visible = false
            end)
        end
    end
    PLScroll.CanvasSize = UDim2.new(0, 0, 0, PLLay.AbsoluteContentSize.Y + 5)
end
TargetBtn.MouseButton1Click:Connect(function() PList.Visible = not PList.Visible if PList.Visible then UpdPlrs() end end)

T4:B("📍 ТП к Жертве", function() if S.Tgt and S.Tgt.Character then LP.Character.HumanoidRootPart.CFrame = S.Tgt.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end end)
T4:T("☠️ Сбивать жертву (Fling)", function(v) 
    S.Flg = v 
    if not v and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.RotVelocity = Vector3.zero end 
end) 
T4:T("⛓️ Присосаться (Attach)", function(v) S.Att = v end) 

local T5 = MkTab("👁️ ESP & ВХ")
T5:T("🏷️ ESP Имена", function(v) S.ESP = v end)
T5:T("🌟 Chams", function(v) S.Chm = v end)

local T6 = MkTab("🚗 Транспорт")
T6:T("🚗 Car Fly", function(v) S.CFly = v end)

if #TabsList > 0 then
    TabsList[1].p.Visible = true
    TabsList[1].b.TextColor3 = Color3.new(1, 1, 1)
    TabsList[1].b.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
end

-- ================= ЛОГИКА =================
RS.Heartbeat:Connect(function()
    pcall(function()
        local c = LP.Character if not c then return end 
        local r = c:FindFirstChild("HumanoidRootPart") 
        local h = c:FindFirstChildOfClass("Humanoid") if not r or not h then return end
        
        if S.Nc or S.MF or S.Flg then for _, p in pairs(c:GetChildren()) do if p:IsA("BasePart") then p.CanCollide = false end end end
        if S.UWS then h.WalkSpeed = S.WS end
        if S.UJP then h.JumpPower = S.JP end
        if S.Fly then r.Velocity = Vector3.new(0, 50, 0) r.CFrame = r.CFrame + Cam.CFrame.LookVector * (S.FlyS / 50) end
        
        -- ИСПРАВЛЕННЫЙ REACH (ОГРОМНЫЙ МЕЧ)
        if S.Rch then
            local tool = c:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then
                tool.Handle.Size = Vector3.new(25, 25, 25)
                tool.Handle.Transparency = 0.5
                tool.Handle.Massless = true
            end
        end

        if S.KA then 
            r.RotVelocity = Vector3.new(0, 45000, 0) 
            for _, p in pairs(P:GetPlayers()) do 
                if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and (p.Character.HumanoidRootPart.Position - r.Position).Magnitude <= 25 then 
                    r.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,0.5)
                end 
            end 
        end
        
        if S.MF then 
            r.RotVelocity = Vector3.new(0, 50000, 0) 
            local ps = P:GetPlayers() 
            local rt = ps[math.random(1, #ps)] 
            if rt ~= LP and rt.Character and rt.Character:FindFirstChild("HumanoidRootPart") then r.CFrame = rt.Character.HumanoidRootPart.CFrame end 
        end
        
        if S.Tgt and S.Tgt.Character and S.Tgt.Character:FindFirstChild("HumanoidRootPart") then 
            local tr = S.Tgt.Character.HumanoidRootPart 
            if S.Att then r.CFrame = tr.CFrame * CFrame.new(0, 3, 0) end 
            if S.Flg then 
                r.RotVelocity = Vector3.new(50000, 50000, 50000) 
                r.Velocity = Vector3.new(0, 45000, 0)
                r.CFrame = tr.CFrame + Vector3.new(math.random(-1,1)/10, 0, math.random(-1,1)/10)
            end 
        end
        
        if S.Aim then 
            local d, tg = S.FOV, nil 
            for _, p in pairs(P:GetPlayers()) do 
                if p ~= LP and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then 
                    local pos, oS = Cam:WorldToViewportPoint(p.Character.Head.Position) 
                    if oS then 
                        local mag = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude 
                        if mag < d then d = mag tg = p end 
                    end 
                end 
            end 
            if tg then Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, tg.Character.Head.Position), S.Smth) end 
        end
    end)
end)

RS.RenderStepped:Connect(function()
    pcall(function()
        for _, pl in pairs(P:GetPlayers()) do
            if pl ~= LP and pl.Character and pl.Character:FindFirstChild("Head") then
                local head = pl.Character.Head
                if S.HB then 
                    head.Size = Vector3.new(S.HBS, S.HBS, S.HBS) 
                    head.Transparency = 0.6 
                    head.CanCollide = false 
                    head.Massless = true 
                else
                    if head.Size.X > 2 then
                        head.Size = Vector3.new(1.2, 1, 1) 
                        head.Transparency = 0
                        head.CanCollide = true
                        head.Massless = false
                    end
                end
                
                if S.ESP then 
                    if not head:FindFirstChild("VE") then 
                        local bg = Instance.new("BillboardGui", head) bg.Name = "VE" bg.Size = UDim2.new(0, 100, 0, 30) bg.AlwaysOnTop = true 
                        local tx = Instance.new("TextLabel", bg) tx.Size = UDim2.new(1, 0, 1, 0) tx.BackgroundTransparency = 1 tx.TextColor3 = Color3.fromRGB(255, 0, 50) tx.Font = Enum.Font.GothamBold tx.TextSize = 14 
                    end 
                    head.VE.TextLabel.Text = pl.Name 
                else 
                    if head:FindFirstChild("VE") then head.VE:Destroy() end 
                end
                
                if S.Chm then 
                    if not pl.Character:FindFirstChild("VC") then local hl = Instance.new("Highlight", pl.Character) hl.Name = "VC" hl.FillTransparency = 0.5 end 
                    pl.Character.VC.FillColor = Color3.fromRGB(0, 150, 255)
                else 
                    if pl.Character:FindFirstChild("VC") then pl.Character.VC:Destroy() end 
                end
            end
        end
    end)
end)
