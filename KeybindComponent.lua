-- // Keybind Component for Pink UI
local keybindComponent = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");

-- // color scheme
local clrs = {
    bg = Color3.fromRGB(6, 6, 8),
    secondary = Color3.fromRGB(12, 12, 15),
    accent = Color3.fromRGB(20, 20, 25),
    pink = Color3.fromRGB(255, 105, 180),
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(200, 80, 140),
    lightpink = Color3.fromRGB(255, 150, 200),
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(120, 120, 125),
    darkgrey = Color3.fromRGB(80, 80, 85),
    separator = Color3.fromRGB(35, 35, 40),
    toggleoff = Color3.fromRGB(80, 80, 85)
};

-- // tween configs
local twinfo = {
    fast = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

-- // key name mapping
local keyNames = {
    [Enum.KeyCode.LeftShift] = "LeftShift",
    [Enum.KeyCode.RightShift] = "RightShift",
    [Enum.KeyCode.LeftControl] = "LeftCtrl",
    [Enum.KeyCode.RightControl] = "RightCtrl",
    [Enum.KeyCode.LeftAlt] = "LeftAlt",
    [Enum.KeyCode.RightAlt] = "RightAlt",
    [Enum.KeyCode.Space] = "Space",
    [Enum.KeyCode.Return] = "Enter",
    [Enum.KeyCode.Backspace] = "Backspace",
    [Enum.KeyCode.Delete] = "Delete",
    [Enum.KeyCode.Tab] = "Tab",
    [Enum.KeyCode.CapsLock] = "CapsLock",
    [Enum.KeyCode.Insert] = "Insert",
    [Enum.KeyCode.Home] = "Home",
    [Enum.KeyCode.End] = "End",
    [Enum.KeyCode.PageUp] = "PageUp",
    [Enum.KeyCode.PageDown] = "PageDown",
    [Enum.KeyCode.Up] = "Up",
    [Enum.KeyCode.Down] = "Down",
    [Enum.KeyCode.Left] = "Left",
    [Enum.KeyCode.Right] = "Right",
    [Enum.KeyCode.F1] = "F1",
    [Enum.KeyCode.F2] = "F2",
    [Enum.KeyCode.F3] = "F3",
    [Enum.KeyCode.F4] = "F4",
    [Enum.KeyCode.F5] = "F5",
    [Enum.KeyCode.F6] = "F6",
    [Enum.KeyCode.F7] = "F7",
    [Enum.KeyCode.F8] = "F8",
    [Enum.KeyCode.F9] = "F9",
    [Enum.KeyCode.F10] = "F10",
    [Enum.KeyCode.F11] = "F11",
    [Enum.KeyCode.F12] = "F12"
};

function keybindComponent:AddKeybind(parent, cfg)
    local cfg = cfg or {};
    local name = cfg.Name or "Keybind";
    local desc = cfg.Description or "";
    local default = cfg.Default or Enum.KeyCode.F;
    local callback = cfg.Callback or function() end;
    local separator = cfg.Separator;
    
    local keybindframe = Instance.new("Frame");
    keybindframe.Name = name;
    keybindframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 65 or 45);
    keybindframe.BackgroundTransparency = 1;
    keybindframe.BorderSizePixel = 0;
    keybindframe.LayoutOrder = #parent:GetChildren();
    keybindframe.Parent = parent;
    
    -- // keybind label
    local keybindlbl = Instance.new("TextLabel");
    keybindlbl.Size = UDim2.new(1, -80, 0, 20);
    keybindlbl.Position = UDim2.new(0, 0, 0, 5);
    keybindlbl.BackgroundTransparency = 1;
    keybindlbl.Text = name;
    keybindlbl.TextColor3 = clrs.white;
    keybindlbl.TextSize = 14;
    keybindlbl.Font = Enum.Font.GothamMedium;
    keybindlbl.TextXAlignment = Enum.TextXAlignment.Left;
    keybindlbl.Parent = keybindframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -80, 0, 15);
        desclbl.Position = UDim2.new(0, 0, 0, 25);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = keybindframe;
    end;
    
    -- // keybind button
    local keybindbtn = Instance.new("TextButton");
    keybindbtn.Size = UDim2.new(0, 70, 0, 25);
    keybindbtn.Position = UDim2.new(1, -70, 0, 5);
    keybindbtn.BackgroundColor3 = clrs.accent;
    keybindbtn.BorderSizePixel = 0;
    keybindbtn.Text = keyNames[default] or default.Name;
    keybindbtn.TextColor3 = clrs.white;
    keybindbtn.TextSize = 12;
    keybindbtn.Font = Enum.Font.GothamMedium;
    keybindbtn.Parent = keybindframe;
    
    local keybindcorner = Instance.new("UICorner");
    keybindcorner.CornerRadius = UDim.new(0, 6);
    keybindcorner.Parent = keybindbtn;
    
    local currentkey = default;
    local listening = false;
    local connection;
    
    -- // keybind functionality
    keybindbtn.MouseButton1Click:Connect(function()
        if listening then return end;
        
        listening = true;
        keybindbtn.Text = "Press Key...";
        createtween(keybindbtn, twinfo.fast, {BackgroundColor3 = clrs.pink}):Play();
        
        connection = userinput.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end;
            
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentkey = input.KeyCode;
                keybindbtn.Text = keyNames[currentkey] or currentkey.Name;
                createtween(keybindbtn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
                
                listening = false;
                connection:Disconnect();
                
                callback(currentkey);
            end;
        end);
    end);
    
    -- // listen for the actual keybind press
    userinput.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or listening then return end;
        
        if input.KeyCode == currentkey then
            callback(currentkey);
        end;
    end);
    
    -- // add separator if requested
    if separator then
        local sepframe = Instance.new("Frame");
        sepframe.Name = "Separator";
        sepframe.Size = UDim2.new(1, 0, 0, 15);
        sepframe.BackgroundTransparency = 1;
        sepframe.BorderSizePixel = 0;
        sepframe.LayoutOrder = #parent:GetChildren();
        sepframe.Parent = parent;
        
        local sepline = Instance.new("Frame");
        sepline.Size = UDim2.new(1, -20, 0, 1);
        sepline.Position = UDim2.new(0, 10, 0.5, 0);
        sepline.BackgroundColor3 = clrs.separator;
        sepline.BackgroundTransparency = 0;
        sepline.BorderSizePixel = 0;
        sepline.Parent = sepframe;
        
        local sepcorner = Instance.new("UICorner");
        sepcorner.CornerRadius = UDim.new(0, 1);
        sepcorner.Parent = sepline;
    end;
    
    return {
        SetKey = function(newkey)
            currentkey = newkey;
            keybindbtn.Text = keyNames[newkey] or newkey.Name;
        end,
        GetKey = function()
            return currentkey;
        end
    };
end;

return keybindComponent;