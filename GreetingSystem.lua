local GreetingSystem = {};
local plrs = game:GetService("Players");
local ts = game:GetService("TweenService");
local rs = game:GetService("RunService");

local config = {
    freemode = true,
    premiummode = false
};

local function getTimeOfDay()
    local hr = os.date("*t").hour;
    if hr >= 5 and hr < 12 then
        return "Good morning";
    elseif hr >= 12 and hr < 18 then
        return "Good afternoon";
    else
        return "Good evening";
    end;
end;

local rainbowColors = {
    Color3.fromRGB(255, 0, 0),    -- Red
    Color3.fromRGB(255, 127, 0),  -- Orange
    Color3.fromRGB(255, 255, 0),  -- Yellow
    Color3.fromRGB(0, 255, 0),    -- Green
    Color3.fromRGB(0, 0, 255),    -- Blue
    Color3.fromRGB(75, 0, 130),   -- Indigo
    Color3.fromRGB(148, 0, 211)   -- Violet
};

local function createRainbowEffect(textLabel)
    local i = 1;
    local conn;
    
    conn = rs.Heartbeat:Connect(function()
        if not textLabel or not textLabel.Parent then
            conn:Disconnect();
            return;
        end;
        
        local goal = {TextColor3 = rainbowColors[i]};
        local tween = ts:Create(textLabel, TweenInfo.new(0.5), goal);
        tween:Play();
        
        i = i + 1;
        if i > #rainbowColors then i = 1 end;
    end);
end;

function GreetingSystem:CreateGreeting(frame)
    local greetingFrame = Instance.new("Frame");
    greetingFrame.Size = UDim2.new(1, 0, 0, 50);
    greetingFrame.Position = UDim2.new(0, 0, 1, -50);
    greetingFrame.BackgroundTransparency = 1;
    greetingFrame.Parent = frame;
    
    local avatarFrame = Instance.new("ImageLabel");
    avatarFrame.Size = UDim2.new(0, 40, 0, 40);
    avatarFrame.Position = UDim2.new(0, 5, 0, 5);
    avatarFrame.BackgroundTransparency = 1;
    avatarFrame.Parent = greetingFrame;
    
    local greetingText = Instance.new("TextLabel");
    greetingText.Size = UDim2.new(1, -55, 1, 0);
    greetingText.Position = UDim2.new(0, 50, 0, 0);
    greetingText.BackgroundTransparency = 1;
    greetingText.TextXAlignment = Enum.TextXAlignment.Left;
    greetingText.TextSize = 14;
    greetingText.Font = Enum.Font.GothamBold;
    greetingText.Parent = greetingFrame;
    
    local function updateGreeting()
        local plr = plrs.LocalPlayer;
        if not plr then return end;
        
        -- Update avatar
        local userId = plr.UserId;
        local thumbType = Enum.ThumbnailType.HeadShot;
        local thumbSize = Enum.ThumbnailSize.Size48x48;
        local content = plrs:GetUserThumbnailAsync(userId, thumbType, thumbSize);
        avatarFrame.Image = content;
        
        -- Update greeting text
        local greeting = getTimeOfDay();
        local userType = config.premiummode and "[Premium]" or "[Free]";
        greetingText.Text = string.format("%s, %s %s", greeting, plr.Name, userType);
        
        -- Apply color effects
        if config.premiummode then
            createRainbowEffect(greetingText);
        else
            greetingText.TextColor3 = Color3.fromRGB(0, 255, 0);
        end;
    end;
    
    updateGreeting();
    plrs.PlayerAdded:Connect(updateGreeting);
end;

function GreetingSystem:SetPremium(isPremium)
    config.premiummode = isPremium;
    config.freemode = not isPremium;
end;

function GreetingSystem:IsPremium()
    return config.premiummode;
end;

return GreetingSystem;