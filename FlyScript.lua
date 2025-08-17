-- FlyScript.lua
-- سكربت طيران بسيط للاختبار داخل لعبتك أو مع Delta

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local flying = false
local flySpeed = 50 -- سرعة الطيران

-- تبديل حالة الطيران بالضغط على زر F
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        if flying then
            print("🛫 الطيران مفعل")
        else
            print("🛬 الطيران معطل")
        end
    end
end)

-- تحديث موقع اللاعب أثناء الطيران
RS.RenderStepped:Connect(function()
    if flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = player.Character.HumanoidRootPart
        local moveDir = Vector3.new(0, 0, 0)

        -- حركة أمام/خلف
        if UIS:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector
        end

        -- صعود/هبوط
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + Vector3.new(0, 1, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end

        HRP.CFrame = HRP.CFrame + moveDir * flySpeed * RS.RenderStepped:Wait()
    end
end)