-- ESP.lua
-- سكربت ESP بسيط: يحدد اللاعبين بألوان على الشاشة

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- وظيفة إنشاء إطار لكل لاعب
local function createESP(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local box = Instance.new("BillboardGui")
        box.Size = UDim2.new(0, 100, 0, 50)
        box.Adornee = player.Character.HumanoidRootPart
        box.AlwaysOnTop = true
        box.Name = "ESPBox"

        local label = Instance.new("TextLabel", box)
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(1, 0, 0) -- اللون أحمر
        label.TextStrokeTransparency = 0
        label.Text = player.Name

        box.Parent = player:WaitForChild("PlayerGui")
    end
end

-- تفعيل ESP لكل اللاعبين الحاليين والجدد
for _, player in pairs(Players:GetPlayers()) do
    if player ~= Players.LocalPlayer then
        createESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createESP(player)
    end)
end)