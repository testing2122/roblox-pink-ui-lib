local components = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");
local runserv = game:GetService("RunService");

-- // color scheme (matching main UI)
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
    separator = Color3.fromRGB(35, 35, 40)
};

-- // tween configs
local twinfo = {
    fast = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    bounce = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

-- // TOGGLE with box
function components:AddToggle(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Toggle";
    local desc = cfg.Description or "";
    local default = cfg.Default or false;
    local callback = cfg.Callback or function() end;
    
    local toggleframe = Instance.new("Frame");
    toggleframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    toggleframe.BackgroundColor3 = clrs.secondary;
    toggleframe.BackgroundTransparency = 0.1;
    toggleframe.BorderSizePixel = 0;
    toggleframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = toggleframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = toggleframe;
    
    -- // toggle bg (grey rectangle)
    local togglebg = Instance.new("Frame");
    togglebg.Size = UDim2.new(0, 45, 0, 22);
    togglebg.Position = UDim2.new(1, -55, 0, desc ~= "" and 25 or 15);
    togglebg.BackgroundColor3 = clrs.darkgrey;
    togglebg.BorderSizePixel = 0;
    togglebg.Parent = toggleframe;
    
    local togglecorner = Instance.new("UICorner");
    togglecorner.CornerRadius = UDim.new(0, 11);
    togglecorner.Parent = togglebg;
    
    -- // toggle indicator (pink square)
    local indicator = Instance.new("Frame");
    indicator.Size = UDim2.new(0, 18, 0, 18);
    indicator.Position = UDim2.new(0, 2, 0, 2);
    indicator.BackgroundColor3 = clrs.pink;
    indicator.BorderSizePixel = 0;
    indicator.Parent = togglebg;
    
    local indcorner = Instance.new("UICorner");
    indcorner.CornerRadius = UDim.new(0, 9);
    indcorner.Parent = indicator;
    
    -- // toggle button
    local togglebtn = Instance.new("TextButton");
    togglebtn.Size = UDim2.new(0, 45, 0, 22);
    togglebtn.Position = UDim2.new(1, -55, 0, desc ~= "" and 25 or 15);
    togglebtn.BackgroundTransparency = 1;
    togglebtn.Text = "";
    togglebtn.Parent = toggleframe;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -70, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = toggleframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -70, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = toggleframe;
    end;
    
    local isenabled = default;
    
    local function updatetoggle()
        if isenabled then
            createtween(indicator, twinfo.fast, {Position = UDim2.new(0, 25, 0, 2)}):Play();
            createtween(togglebg, twinfo.fast, {BackgroundColor3 = clrs.darkpink}):Play();
        else
            createtween(indicator, twinfo.fast, {Position = UDim2.new(0, 2, 0, 2)}):Play();
            createtween(togglebg, twinfo.fast, {BackgroundColor3 = clrs.darkgrey}):Play();
        end;
        callback(isenabled);
    end;
    
    togglebtn.MouseButton1Click:Connect(function()
        isenabled = not isenabled;
        updatetoggle();
    end);
    
    -- // hover effect
    togglebtn.MouseEnter:Connect(function()
        createtween(togglebg, twinfo.fast, {Size = UDim2.new(0, 47, 0, 24)}):Play();
        createtween(togglebtn, twinfo.fast, {Size = UDim2.new(0, 47, 0, 24)}):Play();
    end);
    
    togglebtn.MouseLeave:Connect(function()
        createtween(togglebg, twinfo.fast, {Size = UDim2.new(0, 45, 0, 22)}):Play();
        createtween(togglebtn, twinfo.fast, {Size = UDim2.new(0, 45, 0, 22)}):Play();
    end);
    
    -- // initialize
    updatetoggle();
    
    return {
        SetValue = function(value)
            isenabled = value;
            updatetoggle();
        end,
        GetValue = function()
            return isenabled;
        end
    };
end;

-- // BUTTON with box
function components:AddButton(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Button";
    local desc = cfg.Description or "";
    local callback = cfg.Callback or function() end;
    
    local btnframe = Instance.new("Frame");
    btnframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    btnframe.BackgroundColor3 = clrs.secondary;
    btnframe.BackgroundTransparency = 0.1;
    btnframe.BorderSizePixel = 0;
    btnframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = btnframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = btnframe;
    
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(1, -20, 0, 30);
    btn.Position = UDim2.new(0, 10, 1, desc ~= "" and -40 or -35);
    btn.BackgroundColor3 = clrs.accent;
    btn.BorderSizePixel = 0;
    btn.Text = text;
    btn.TextColor3 = clrs.white;
    btn.TextSize = 14;
    btn.Font = Enum.Font.GothamMedium;
    btn.Parent = btnframe;
    
    local btncorner = Instance.new("UICorner");
    btncorner.CornerRadius = UDim.new(0, 6);
    btncorner.Parent = btn;
    
    local btnstroke = Instance.new("UIStroke");
    btnstroke.Color = clrs.pink;
    btnstroke.Thickness = 1;
    btnstroke.Transparency = 0.8;
    btnstroke.Parent = btn;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -20, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = btnframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -20, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = btnframe;
    end;
    
    local ishovered = false;
    local ispressed = false;
    
    -- // fixed hover effects to prevent stuck states
    btn.MouseEnter:Connect(function()
        ishovered = true;
        if not ispressed then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
            createtween(btnstroke, twinfo.fast, {Transparency = 0.4}):Play();
        end;
    end);
    
    btn.MouseLeave:Connect(function()
        ishovered = false;
        if not ispressed then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(btnstroke, twinfo.fast, {Transparency = 0.8}):Play();
        end;
    end);
    
    btn.MouseButton1Down:Connect(function()
        ispressed = true;
        createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.pink}):Play();
        createtween(btnstroke, twinfo.fast, {Transparency = 0.2}):Play();
    end);
    
    btn.MouseButton1Up:Connect(function()
        ispressed = false;
        callback();
        
        -- // proper state restoration
        if ishovered then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
            createtween(btnstroke, twinfo.fast, {Transparency = 0.4}):Play();
        else
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(btnstroke, twinfo.fast, {Transparency = 0.8}):Play();
        end;
    end);
    
    return {
        SetText = function(newtext)
            btn.Text = newtext;
            mainlbl.Text = newtext;
        end
    };
end;

-- // SLIDER with box
function components:AddSlider(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Slider";
    local desc = cfg.Description or "";
    local min = cfg.Min or 0;
    local max = cfg.Max or 100;
    local default = cfg.Default or min;
    local increment = cfg.Increment or 1;
    local callback = cfg.Callback or function() end;
    
    local sliderframe = Instance.new("Frame");
    sliderframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 85 or 65);
    sliderframe.BackgroundColor3 = clrs.secondary;
    sliderframe.BackgroundTransparency = 0.1;
    sliderframe.BorderSizePixel = 0;
    sliderframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = sliderframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = sliderframe;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -60, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = sliderframe;
    
    -- // value label
    local vallbl = Instance.new("TextLabel");
    vallbl.Size = UDim2.new(0, 50, 0, 20);
    vallbl.Position = UDim2.new(1, -60, 0, desc ~= "" and 18 or 12);
    vallbl.BackgroundTransparency = 1;
    vallbl.Text = tostring(default);
    vallbl.TextColor3 = clrs.pink;
    vallbl.TextSize = 14;
    vallbl.Font = Enum.Font.GothamBold;
    vallbl.TextXAlignment = Enum.TextXAlignment.Right;
    vallbl.Parent = sliderframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -60, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = sliderframe;
    end;
    
    -- // slider track
    local track = Instance.new("Frame");
    track.Size = UDim2.new(1, -20, 0, 6);
    track.Position = UDim2.new(0, 10, 1, desc ~= "" and -25 or -20);
    track.BackgroundColor3 = clrs.darkgrey;
    track.BorderSizePixel = 0;
    track.Parent = sliderframe;
    
    local trackcorner = Instance.new("UICorner");
    trackcorner.CornerRadius = UDim.new(0, 3);
    trackcorner.Parent = track;
    
    -- // slider fill
    local fill = Instance.new("Frame");
    fill.Size = UDim2.new(0, 0, 1, 0);
    fill.Position = UDim2.new(0, 0, 0, 0);
    fill.BackgroundColor3 = clrs.pink;
    fill.BorderSizePixel = 0;
    fill.Parent = track;
    
    local fillcorner = Instance.new("UICorner");
    fillcorner.CornerRadius = UDim.new(0, 3);
    fillcorner.Parent = fill;
    
    -- // slider handle
    local handle = Instance.new("Frame");
    handle.Size = UDim2.new(0, 16, 0, 16);
    handle.Position = UDim2.new(0, -8, 0.5, -8);
    handle.BackgroundColor3 = clrs.white;
    handle.BorderSizePixel = 0;
    handle.Parent = track;
    
    local handlecorner = Instance.new("UICorner");
    handlecorner.CornerRadius = UDim.new(0, 8);
    handlecorner.Parent = handle;
    
    local handlestroke = Instance.new("UIStroke");
    handlestroke.Color = clrs.pink;
    handlestroke.Thickness = 2;
    handlestroke.Parent = handle;
    
    -- // slider button
    local sliderbtn = Instance.new("TextButton");
    sliderbtn.Size = UDim2.new(1, -20, 0, 20);
    sliderbtn.Position = UDim2.new(0, 10, 1, desc ~= "" and -30 or -25);
    sliderbtn.BackgroundTransparency = 1;
    sliderbtn.Text = "";
    sliderbtn.Parent = sliderframe;
    
    local currentval = default;
    local isdragging = false;
    
    local function updateslider(value)
        local percentage = (value - min) / (max - min);
        createtween(fill, twinfo.fast, {Size = UDim2.new(percentage, 0, 1, 0)}):Play();
        createtween(handle, twinfo.fast, {Position = UDim2.new(percentage, -8, 0.5, -8)}):Play();
        vallbl.Text = tostring(value);
        callback(value);
    end;
    
    local function handleinput(input)
        local percentage = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1);
        local rawvalue = min + percentage * (max - min);
        currentval = math.floor(rawvalue / increment + 0.5) * increment;
        currentval = math.clamp(currentval, min, max);
        updateslider(currentval);
    end;
    
    sliderbtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isdragging = true;
            handleinput(input);
        end;
    end);
    
    userinput.InputChanged:Connect(function(input)
        if isdragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            handleinput(input);
        end;
    end);
    
    userinput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isdragging = false;
        end;
    end);
    
    -- // hover effect
    sliderbtn.MouseEnter:Connect(function()
        createtween(handle, twinfo.fast, {Size = UDim2.new(0, 18, 0, 18)}):Play();
    end);
    
    sliderbtn.MouseLeave:Connect(function()
        if not isdragging then
            createtween(handle, twinfo.fast, {Size = UDim2.new(0, 16, 0, 16)}):Play();
        end;
    end);
    
    -- // initialize
    updateslider(currentval);
    
    return {
        SetValue = function(value)
            currentval = math.clamp(value, min, max);
            updateslider(currentval);
        end,
        GetValue = function()
            return currentval;
        end
    };
end;

-- // INPUT with box
function components:AddInput(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Input";
    local desc = cfg.Description or "";
    local placeholder = cfg.Placeholder or "Enter text...";
    local callback = cfg.Callback or function() end;
    
    local inputframe = Instance.new("Frame");
    inputframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 85 or 65);
    inputframe.BackgroundColor3 = clrs.secondary;
    inputframe.BackgroundTransparency = 0.1;
    inputframe.BorderSizePixel = 0;
    inputframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = inputframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = inputframe;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -20, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = inputframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -20, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = inputframe;
    end;
    
    -- // input box
    local inputbox = Instance.new("TextBox");
    inputbox.Size = UDim2.new(1, -20, 0, 30);
    inputbox.Position = UDim2.new(0, 10, 1, desc ~= "" and -40 or -35);
    inputbox.BackgroundColor3 = clrs.accent;
    inputbox.BorderSizePixel = 0;
    inputbox.Text = "";
    inputbox.PlaceholderText = placeholder;
    inputbox.PlaceholderColor3 = clrs.darkgrey;
    inputbox.TextColor3 = clrs.white;
    inputbox.TextSize = 13;
    inputbox.Font = Enum.Font.Gotham;
    inputbox.TextXAlignment = Enum.TextXAlignment.Left;
    inputbox.ClearTextOnFocus = false;
    inputbox.Parent = inputframe;
    
    local inputcorner = Instance.new("UICorner");
    inputcorner.CornerRadius = UDim.new(0, 6);
    inputcorner.Parent = inputbox;
    
    local inputstroke = Instance.new("UIStroke");
    inputstroke.Color = clrs.separator;
    inputstroke.Thickness = 1;
    inputstroke.Transparency = 0.6;
    inputstroke.Parent = inputbox;
    
    local inputpad = Instance.new("UIPadding");
    inputpad.PaddingLeft = UDim.new(0, 10);
    inputpad.PaddingRight = UDim.new(0, 10);
    inputpad.Parent = inputbox;
    
    -- // focus effects
    inputbox.Focused:Connect(function()
        createtween(inputstroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.3}):Play();
    end);
    
    inputbox.FocusLost:Connect(function()
        createtween(inputstroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.6}):Play();
        callback(inputbox.Text);
    end);
    
    return {
        SetValue = function(value)
            inputbox.Text = value;
        end,
        GetValue = function()
            return inputbox.Text;
        end
    };
end;

-- // LABEL with box
function components:AddLabel(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Label";
    local desc = cfg.Description or "";
    
    local labelframe = Instance.new("Frame");
    labelframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 55 or 35);
    labelframe.BackgroundColor3 = clrs.secondary;
    labelframe.BackgroundTransparency = 0.1;
    labelframe.BorderSizePixel = 0;
    labelframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = labelframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = labelframe;
    
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -20, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 8 or 7);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = labelframe;
    
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -20, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 28);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = labelframe;
    end;
    
    return {
        SetText = function(newtext)
            mainlbl.Text = newtext;
        end,
        SetColor = function(color)
            mainlbl.TextColor3 = color;
        end
    };
end;

-- // SEPARATOR
function components:AddSeparator(parent)
    local sepframe = Instance.new("Frame");
    sepframe.Size = UDim2.new(1, 0, 0, 20);
    sepframe.BackgroundTransparency = 1;
    sepframe.Parent = parent;
    
    local sep = Instance.new("Frame");
    sep.Size = UDim2.new(1, -20, 0, 2);
    sep.Position = UDim2.new(0, 10, 0.5, -1);
    sep.BackgroundColor3 = clrs.separator;
    sep.BorderSizePixel = 0;
    sep.Parent = sepframe;
    
    local sepcorner = Instance.new("UICorner");
    sepcorner.CornerRadius = UDim.new(0, 1);
    sepcorner.Parent = sep;
    
    local sepgrad = Instance.new("UIGradient");
    sepgrad.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 1)
    };
    sepgrad.Parent = sep;
    
    return sepframe;
end;

return components;