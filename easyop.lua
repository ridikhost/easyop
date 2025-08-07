--// EasyOP - Stylish Asset Loader
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI Initialization
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EasyOP_LoadingUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 220)
frame.Position = UDim2.new(0.5, -225, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Shadow
local shadow = Instance.new("ImageLabel", frame)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 4, 0.5, 4)
shadow.Size = UDim2.new(1, 12, 1, 12)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.4
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.ZIndex = 0

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "EasyOP"
title.Font = Enum.Font.GothamBlack
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(0, 170, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)

-- Subtext
local subtitle = Instance.new("TextLabel", frame)
subtitle.Text = "Loading assets... this could take up to a minute."
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 14
subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.new(1, -40, 0, 20)
subtitle.Position = UDim2.new(0, 20, 0, 50)
subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Fake asset load label
local assetText = Instance.new("TextLabel", frame)
assetText.Text = "Loading asset 0 of 0"
assetText.Font = Enum.Font.Code
assetText.TextSize = 16
assetText.TextColor3 = Color3.fromRGB(255, 255, 255)
assetText.BackgroundTransparency = 1
assetText.Size = UDim2.new(1, -40, 0, 24)
assetText.Position = UDim2.new(0, 20, 0, 80)
assetText.TextXAlignment = Enum.TextXAlignment.Left

-- Progress bar BG
local progressBG = Instance.new("Frame", frame)
progressBG.Size = UDim2.new(1, -40, 0, 20)
progressBG.Position = UDim2.new(0, 20, 0, 120)
progressBG.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
progressBG.BorderSizePixel = 0

Instance.new("UICorner", progressBG).CornerRadius = UDim.new(0, 10)

-- Progress bar Fill
local progress = Instance.new("Frame", progressBG)
progress.Size = UDim2.new(0, 0, 1, 0)
progress.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progress.BorderSizePixel = 0

Instance.new("UICorner", progress).CornerRadius = UDim.new(0, 10)

-- Percentage
local percentText = Instance.new("TextLabel", frame)
percentText.Text = "0%"
percentText.Font = Enum.Font.GothamSemibold
percentText.TextSize = 14
percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
percentText.BackgroundTransparency = 1
percentText.Size = UDim2.new(1, -40, 0, 20)
percentText.Position = UDim2.new(0, 20, 0, 150)
percentText.TextXAlignment = Enum.TextXAlignment.Left

-- Fake asset range
local totalAssets = math.random(420, 600)
local loadedAssets = 0

-- Timing
local totalTime = 60 -- seconds
local updateInterval = 0.1
local steps = totalTime / updateInterval

task.spawn(function()
	for i = 1, steps do
		task.wait(updateInterval)

		-- Update fake assets
		loadedAssets = math.min(totalAssets, math.floor((i / steps) * totalAssets))
		assetText.Text = "Loading asset " .. loadedAssets .. " of " .. totalAssets

		-- Update progress bar
		local percent = i / steps
		percentText.Text = string.format("%.0f%%", percent * 100)

		local tween = TweenService:Create(progress, TweenInfo.new(0.08), {
			Size = UDim2.new(percent, 0, 1, 0)
		})
		tween:Play()
	end

	-- Final updates
	percentText.Text = "100%"
	assetText.Text = "Assets loaded."

	task.wait(0.5)
	screenGui:Destroy()
	StartGame()
end)

--// Your custom function goes here
function StartGame()
	print("✅ EasyOP assets loaded. Starting game!")
	loadstring(game:HttpGet('https://raw.githubusercontent.com/ridikhost/easyoprayfield/refs/heads/main/main.lua'))()
end