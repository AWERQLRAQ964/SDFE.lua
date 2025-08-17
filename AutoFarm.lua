-- AutoFarm.lua
-- سكربت Auto Farm بسيط: يحرك اللاعب تلقائيًا ويجمع عناصر/يقاتل أعداء
-- ⚠️ فقط للاختبار على لعبتك الخاصة أو حساب تجريبي

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local player = Players.LocalPlayer

-- سرعة الحركة أثناء AutoFarm
local farmSpeed = 20

-- حالة تشغيل السكربت
local autoFarmEnabled = false

-- وظيفة تبديل التشغيل
local function toggleAutoFarm()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        print("🟢 AutoFarm مفعل")
    else
        print("🔴 AutoFarm معطل")
    end
end

-- مثال بسيط: يتحرك اللاعب تلقائيًا نحو موقع محدد (تستبدله بموقع العنصر أو العدو)
local targetPosition = Vector3.new(0, 0, 0) -- غيرها حسب الهدف

RS.RenderStepped:Connect(function(delta)
    if autoFarmEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = player.Character.HumanoidRootPart
        local direction = (targetPosition - HRP.Position).Unit
        HRP.CFrame = HRP.CFrame + direction * farmSpeed * delta
    end
end)

-- ربط تشغيل AutoFarm بزر (F)
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        toggleAutoFarm()
    end
end)