local components = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");

-- // color scheme with toggle off state
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

-- // theme application function
function components:ApplyTheme(newTheme)
    for key, value in pairs(newTheme) do
        clrs[key] = value;
    end;
end;

-- // tween configs
local twinfo = {
    fast = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

-- // add separator function
function components:AddSeparator(parent, cfg)
    local cfg = cfg or {};
    local height = cfg.Height or 15;
    local color = cfg.Color or clrs.separator;
    local transparency = cfg.Transparency or 0;
    
    local sepframe = Instance.new("Frame");
    sepframe.Name = "Separator";
    sepframe.Size = UDim2.new(1, 0, 0, height);
    sepframe.BackgroundTransparency = 1;
    sepframe.BorderSizePixel = 0;
    sepframe.LayoutOrder = #parent:GetChildren();
    sepframe.Parent = parent;
    
    local sepline = Instance.new("Frame");
    sepline.Size = UDim2.new(1, -20, 0, 1);
    sepline.Position = UDim2.new(0, 10, 0.5, 0);
    sepline.BackgroundColor3 = color;
    sepline.BackgroundTransparency = transparency;
    sepline.BorderSizePixel = 0;
    sepline.Parent = sepframe;
    
    local sepcorner = Instance.new("UICorner");
    sepcorner.CornerRadius = UDim.new(0, 1);
    sepcorner.Parent = sepline;
    
    return sepframe;
end;

-- // add components to box content
function components:AddToggle(parent, cfg)
    local cfg = cfg or {};
    local name = cfg.Name or "Toggle";
    local desc = cfg.Description or "";
    local default = cfg.Default or false;
    local callback = cfg.Callback or function() end;
    local separator = cfg.Separator;
    
    local toggleframe = Instance.new("Frame");
    toggleframe.Name = name;
    toggleframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 65 or 45);
    toggleframe.BackgroundTransparency = 1;
    toggleframe.BorderSizePixel = 0;
    toggleframe.LayoutOrder = #parent:GetChildren();
    toggleframe.Parent = parent;
    
    -- // toggle label with conditional color
    local togglelbl = Instance.new("TextLabel");
    togglelbl.Size = UDim2.new(1, -60, 0, 20);
    togglelbl.Position = UDim2.new(0, 0, 0, 5);
    togglelbl.BackgroundTransparency = 1;
    togglelbl.Text = name;
    togglelbl.TextColor3 = default and clrs.white or clrs.toggleoff;
    togglelbl.TextSize = 14;
    togglelbl.Font = Enum.Font.GothamMedium;
    togglelbl.TextXAlignment = Enum.TextXAlignment.Left;
    togglelbl.Parent = toggleframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -60, 0, 15);
        desclbl.Position = UDim2.new(0, 0, 0, 25);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = toggleframe;
    end;
    
    -- // toggle switch
    local togglebtn = Instance.new("TextButton");
    togglebtn.Size = UDim2.new(0, 45, 0, 22);
    togglebtn.Position = UDim2.new(1, -45, 0, 5);
    togglebtn.BackgroundColor3 = default and clrs.pink or clrs.accent;
    togglebtn.BorderSizePixel = 0;
    togglebtn.Text = "";
    togglebtn.Parent = toggleframe;
    
    local togglecorner = Instance.new("UICorner");
    togglecorner.CornerRadius = UDim.new(0, 11);
    togglecorner.Parent = togglebtn;
    
    -- // toggle circle
    local togglecircle = Instance.new("Frame");
    togglecircle.Size = UDim2.new(0, 18, 0, 18);
    togglecircle.Position = default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9);
    togglecircle.BackgroundColor3 = clrs.white;
    togglecircle.BorderSizePixel = 0;
    togglecircle.Parent = togglebtn;
    
    local circlecorner = Instance.new("UICorner");
    circlecorner.CornerRadius = UDim.new(0, 9);
    circlecorner.Parent = togglecircle;
    
    local enabled = default;
    
    togglebtn.MouseButton1Click:Connect(function()
        enabled = not enabled;
        
        if enabled then
            createtween(togglebtn, twinfo.med, {BackgroundColor3 = clrs.pink}):Play();
            createtween(togglecircle, twinfo.med, {Position = UDim2.new(1, -20, 0.5, -9)}):Play();
            createtween(togglelbl, twinfo.med, {TextColor3 = clrs.white}):Play();
        else
            createtween(togglebtn, twinfo.med, {BackgroundColor3 = clrs.accent}):Play();
            createtween(togglecircle, twinfo.med, {Position = UDim2.new(0, 2, 0.5, -9)}):Play();
            createtween(togglelbl, twinfo.med, {TextColor3 = clrs.toggleoff}):Play();
        end;
        
        callback(enabled);
    end);
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetValue = function(value)
            enabled = value;
            if enabled then
                createtween(togglebtn, twinfo.med, {BackgroundColor3 = clrs.pink}):Play();
                createtween(togglecircle, twinfo.med, {Position = UDim2.new(1, -20, 0.5, -9)}):Play();
                createtween(togglelbl, twinfo.med, {TextColor3 = clrs.white}):Play();
            else
                createtween(togglebtn, twinfo.med, {BackgroundColor3 = clrs.accent}):Play();
                createtween(togglecircle, twinfo.med, {Position = UDim2.new(0, 2, 0.5, -9)}):Play();
                createtween(togglelbl, twinfo.med, {TextColor3 = clrs.toggleoff}):Play();
            end;
        end,
        GetValue = function()
            return enabled;
        end
    };
end;

function components:AddButton(parent, cfg)
    local cfg = cfg or {};
    local name = cfg.Name or "Button";
    local desc = cfg.Description or "";
    local callback = cfg.Callback or function() end;
    local separator = cfg.Separator;
    
    local btnframe = Instance.new("Frame");
    btnframe.Name = name;
    btnframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 65 or 45);
    btnframe.BackgroundTransparency = 1;
    btnframe.BorderSizePixel = 0;
    btnframe.LayoutOrder = #parent:GetChildren();
    btnframe.Parent = parent;
    
    -- // button
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(1, 0, 0, 35);
    btn.Position = UDim2.new(0, 0, 0, desc ~= "" and 25 or 5);
    btn.BackgroundColor3 = clrs.accent;
    btn.BorderSizePixel = 0;
    btn.Text = name;
    btn.TextColor3 = clrs.white;
    btn.TextSize = 14;
    btn.Font = Enum.Font.GothamMedium;
    btn.Parent = btnframe;
    
    local btncorner = Instance.new("UICorner");
    btncorner.CornerRadius = UDim.new(0, 8);
    btncorner.Parent = btn;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, 0, 0, 15);
        desclbl.Position = UDim2.new(0, 0, 0, 5);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = btnframe;
    end;
    
    -- // button states
    local ishovered = false;
    local ispressed = false;
    
    btn.MouseEnter:Connect(function()
        ishovered = true;
        if not ispressed then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.pink, TextColor3 = clrs.white}):Play();
        end;
    end);
    
    btn.MouseLeave:Connect(function()
        ishovered = false;
        if not ispressed then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.accent, TextColor3 = clrs.white}):Play();
        end;
    end);
    
    btn.MouseButton1Down:Connect(function()
        ispressed = true;
        createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.darkpink}):Play();
    end);
    
    btn.MouseButton1Up:Connect(function()
        ispressed = false;
        if ishovered then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.pink}):Play();
        else
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
        end;
    end);
    
    btn.MouseButton1Click:Connect(function()
        callback();
    end);
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return btn;
end;

function components:AddSlider(parent, cfg)
    local cfg = cfg or {};
    local name = cfg.Name or "Slider";
    local desc = cfg.Description or "";
    local min = cfg.Min or 0;
    local max = cfg.Max or 100;
    local default = cfg.Default or min;
    local increment = cfg.Increment or 1;
    local callback = cfg.Callback or function() end;
    local separator = cfg.Separator;
    
    local sliderframe = Instance.new("Frame");
    sliderframe.Name = name;
    sliderframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    sliderframe.BackgroundTransparency = 1;
    sliderframe.BorderSizePixel = 0;
    sliderframe.LayoutOrder = #parent:GetChildren();
    sliderframe.Parent = parent;
    
    -- // slider label
    local sliderlbl = Instance.new("TextLabel");
    sliderlbl.Size = UDim2.new(1, -60, 0, 20);
    sliderlbl.Position = UDim2.new(0, 0, 0, 5);
    sliderlbl.BackgroundTransparency = 1;
    sliderlbl.Text = name;
    sliderlbl.TextColor3 = clrs.white;
    sliderlbl.TextSize = 14;
    sliderlbl.Font = Enum.Font.GothamMedium;
    sliderlbl.TextXAlignment = Enum.TextXAlignment.Left;
    sliderlbl.Parent = sliderframe;
    
    -- // value label
    local valuelbl = Instance.new("TextLabel");
    valuelbl.Size = UDim2.new(0, 60, 0, 20);
    valuelbl.Position = UDim2.new(1, -60, 0, 5);
    valuelbl.BackgroundTransparency = 1;
    valuelbl.Text = tostring(default);
    valuelbl.TextColor3 = clrs.pink;
    valuelbl.TextSize = 14;
    valuelbl.Font = Enum.Font.GothamBold;
    valuelbl.TextXAlignment = Enum.TextXAlignment.Right;
    valuelbl.Parent = sliderframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, 0, 0, 15);
        desclbl.Position = UDim2.new(0, 0, 0, 25);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = sliderframe;
    end;
    
    -- // slider track
    local slidertrack = Instance.new("Frame");
    slidertrack.Size = UDim2.new(1, 0, 0, 6);
    slidertrack.Position = UDim2.new(0, 0, 1, desc ~= "" and -15 or -10);
    slidertrack.BackgroundColor3 = clrs.accent;
    slidertrack.BorderSizePixel = 0;
    slidertrack.Parent = sliderframe;
    
    local trackcorner = Instance.new("UICorner");
    trackcorner.CornerRadius = UDim.new(0, 3);
    trackcorner.Parent = slidertrack;
    
    -- // slider fill
    local sliderfill = Instance.new("Frame");
    sliderfill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0);
    sliderfill.Position = UDim2.new(0, 0, 0, 0);
    sliderfill.BackgroundColor3 = clrs.pink;
    sliderfill.BorderSizePixel = 0;
    sliderfill.Parent = slidertrack;
    
    local fillcorner = Instance.new("UICorner");
    fillcorner.CornerRadius = UDim.new(0, 3);
    fillcorner.Parent = sliderfill;
    
    -- // slider handle
    local sliderhandle = Instance.new("Frame");
    sliderhandle.Size = UDim2.new(0, 16, 0, 16);
    sliderhandle.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8);
    sliderhandle.BackgroundColor3 = clrs.white;
    sliderhandle.BorderSizePixel = 0;
    sliderhandle.Parent = slidertrack;
    
    local handlecorner = Instance.new("UICorner");
    handlecorner.CornerRadius = UDim.new(0, 8);
    handlecorner.Parent = sliderhandle;
    
    local value = default;
    local dragging = false;
    
    local function updateslider(input)
        local pos = math.clamp((input.Position.X - slidertrack.AbsolutePosition.X) / slidertrack.AbsoluteSize.X, 0, 1);
        value = math.floor((min + (max - min) * pos) / increment + 0.5) * increment;
        value = math.clamp(value, min, max);
        
        local fillsize = (value - min) / (max - min);
        createtween(sliderfill, twinfo.fast, {Size = UDim2.new(fillsize, 0, 1, 0)}):Play();
        createtween(sliderhandle, twinfo.fast, {Position = UDim2.new(fillsize, -8, 0.5, -8)}):Play();
        
        valuelbl.Text = tostring(value);
        callback(value);
    end;
    
    slidertrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true;
            updateslider(input);
        end;
    end);
    
    userinput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateslider(input);
        end;
    end);
    
    userinput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false;
        end;
    end);
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetValue = function(newvalue)
            value = math.clamp(newvalue, min, max);
            local fillsize = (value - min) / (max - min);
            createtween(sliderfill, twinfo.fast, {Size = UDim2.new(fillsize, 0, 1, 0)}):Play();
            createtween(sliderhandle, twinfo.fast, {Position = UDim2.new(fillsize, -8, 0.5, -8)}):Play();
            valuelbl.Text = tostring(value);
        end,
        GetValue = function()
            return value;
        end
    };
end;

function components:AddInput(parent, cfg)
    local cfg = cfg or {};
    local name = cfg.Name or "Input";
    local desc = cfg.Description or "";
    local placeholder = cfg.Placeholder or "Enter text...";
    local default = cfg.Default or "";
    local callback = cfg.Callback or function() end;
    local separator = cfg.Separator;
    
    local inputframe = Instance.new("Frame");
    inputframe.Name = name;
    inputframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    inputframe.BackgroundTransparency = 1;
    inputframe.BorderSizePixel = 0;
    inputframe.LayoutOrder = #parent:GetChildren();
    inputframe.Parent = parent;
    
    -- // input label
    local inputlbl = Instance.new("TextLabel");
    inputlbl.Size = UDim2.new(1, 0, 0, 20);
    inputlbl.Position = UDim2.new(0, 0, 0, 5);
    inputlbl.BackgroundTransparency = 1;
    inputlbl.Text = name;
    inputlbl.TextColor3 = clrs.white;
    inputlbl.TextSize = 14;
    inputlbl.Font = Enum.Font.GothamMedium;
    inputlbl.TextXAlignment = Enum.TextXAlignment.Left;
    inputlbl.Parent = inputframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, 0, 0, 15);
        desclbl.Position = UDim2.new(0, 0, 0, 25);
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
    inputbox.Size = UDim2.new(1, 0, 0, 30);
    inputbox.Position = UDim2.new(0, 0, 1, desc ~= "" and -35 or -30);
    inputbox.BackgroundColor3 = clrs.accent;
    inputbox.BorderSizePixel = 0;
    inputbox.Text = default;
    inputbox.PlaceholderText = placeholder;
    inputbox.TextColor3 = clrs.white;
    inputbox.PlaceholderColor3 = clrs.grey;
    inputbox.TextSize = 13;
    inputbox.Font = Enum.Font.Gotham;
    inputbox.TextXAlignment = Enum.TextXAlignment.Left;
    inputbox.ClearTextOnFocus = false;
    inputbox.Parent = inputframe;
    
    local inputcorner = Instance.new("UICorner");
    inputcorner.CornerRadius = UDim.new(0, 6);
    inputcorner.Parent = inputbox;
    
    local inputpad = Instance.new("UIPadding");
    inputpad.PaddingLeft = UDim.new(0, 12);
    inputpad.PaddingRight = UDim.new(0, 12);
    inputpad.Parent = inputbox;
    
    inputbox.Focused:Connect(function()
        createtween(inputbox, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
    end);
    
    inputbox.FocusLost:Connect(function()
        createtween(inputbox, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
        callback(inputbox.Text);
    end);
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetValue = function(text)
            inputbox.Text = text;
        end,
        GetValue = function()
            return inputbox.Text;
        end
    };
end;

function components:AddDropdown(parent, cfg)
    local cfg = cfg or {};
    local name = cfg.Name or "Dropdown";
    local desc = cfg.Description or "";
    local options = cfg.Options or {"Option 1", "Option 2"};
    local default = cfg.Default or options[1];
    local callback = cfg.Callback or function() end;
    local separator = cfg.Separator;
    
    local dropframe = Instance.new("Frame");
    dropframe.Name = name;
    dropframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    dropframe.BackgroundTransparency = 1;
    dropframe.BorderSizePixel = 0;
    dropframe.LayoutOrder = #parent:GetChildren();
    dropframe.Parent = parent;
    
    -- // dropdown label
    local droplbl = Instance.new("TextLabel");
    droplbl.Size = UDim2.new(1, 0, 0, 20);
    droplbl.Position = UDim2.new(0, 0, 0, 5);
    droplbl.BackgroundTransparency = 1;
    droplbl.Text = name;
    droplbl.TextColor3 = clrs.white;
    droplbl.TextSize = 14;
    droplbl.Font = Enum.Font.GothamMedium;
    droplbl.TextXAlignment = Enum.TextXAlignment.Left;
    droplbl.Parent = dropframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, 0, 0, 15);
        desclbl.Position = UDim2.new(0, 0, 0, 25);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = dropframe;
    end;
    
    -- // dropdown button
    local dropbtn = Instance.new("TextButton");
    dropbtn.Size = UDim2.new(1, 0, 0, 30);
    dropbtn.Position = UDim2.new(0, 0, 1, desc ~= "" and -35 or -30);
    dropbtn.BackgroundColor3 = clrs.accent;
    dropbtn.BorderSizePixel = 0;
    dropbtn.Text = "";
    dropbtn.Parent = dropframe;
    
    local dropcorner = Instance.new("UICorner");
    dropcorner.CornerRadius = UDim.new(0, 6);
    dropcorner.Parent = dropbtn;
    
    -- // selected text
    local selectedlbl = Instance.new("TextLabel");
    selectedlbl.Size = UDim2.new(1, -35, 1, 0);
    selectedlbl.Position = UDim2.new(0, 12, 0, 0);
    selectedlbl.BackgroundTransparency = 1;
    selectedlbl.Text = default;
    selectedlbl.TextColor3 = clrs.white;
    selectedlbl.TextSize = 13;
    selectedlbl.Font = Enum.Font.Gotham;
    selectedlbl.TextXAlignment = Enum.TextXAlignment.Left;
    selectedlbl.Parent = dropbtn;
    
    -- // arrow
    local arrow = Instance.new("TextLabel");
    arrow.Size = UDim2.new(0, 20, 1, 0);
    arrow.Position = UDim2.new(1, -25, 0, 0);
    arrow.BackgroundTransparency = 1;
    arrow.Text = "▼";
    arrow.TextColor3 = clrs.grey;
    arrow.TextSize = 10;
    arrow.Font = Enum.Font.Gotham;
    arrow.Parent = dropbtn;
    
    -- // Find the main UI container for proper positioning
    local function findMainContainer()
        local current = parent;
        while current and current.Parent do
            if current.Name == "PinkUI" or current:FindFirstChild("Main") then
                return current;
            end;
            current = current.Parent;
        end;
        return game:GetService("CoreGui");
    end;
    
    local mainContainer = findMainContainer();
    
    -- // FIXED: Create dropdown list as screen overlay
    local droplist = Instance.new("Frame");
    droplist.Size = UDim2.new(0, 0, 0, 0); -- Start with 0 size
    droplist.Position = UDim2.new(0, 0, 0, 0); -- Will be calculated dynamically
    droplist.BackgroundColor3 = clrs.secondary;
    droplist.BorderSizePixel = 0;
    droplist.Visible = false;
    droplist.ZIndex = 1000; -- Very high ZIndex
    droplist.ClipsDescendants = true;
    droplist.Parent = mainContainer;
    
    local listcorner = Instance.new("UICorner");
    listcorner.CornerRadius = UDim.new(0, 6);
    listcorner.Parent = droplist;
    
    local liststroke = Instance.new("UIStroke");
    liststroke.Color = clrs.separator;
    liststroke.Thickness = 1;
    liststroke.Parent = droplist;
    
    -- // scrolling frame for options
    local scrollframe = Instance.new("ScrollingFrame");
    scrollframe.Size = UDim2.new(1, 0, 1, 0);
    scrollframe.Position = UDim2.new(0, 0, 0, 0);
    scrollframe.BackgroundTransparency = 1;
    scrollframe.BorderSizePixel = 0;
    scrollframe.ScrollBarThickness = 2;
    scrollframe.ScrollBarImageColor3 = clrs.pink;
    scrollframe.CanvasSize = UDim2.new(0, 0, 0, #options * 30);
    scrollframe.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    scrollframe.Parent = droplist;
    
    local scrollcorner = Instance.new("UICorner");
    scrollcorner.CornerRadius = UDim.new(0, 6);
    scrollcorner.Parent = scrollframe;
    
    local optionlayout = Instance.new("UIListLayout");
    optionlayout.SortOrder = Enum.SortOrder.LayoutOrder;
    optionlayout.Parent = scrollframe;
    
    local selected = default;
    local isopen = false;
    local maxHeight = math.min(#options * 30, 150);
    
    -- // Function to position dropdown list
    local function positionDropdown()
        local btnPos = dropbtn.AbsolutePosition;
        local btnSize = dropbtn.AbsoluteSize;
        local screenSize = workspace.CurrentCamera.ViewportSize;
        
        -- Calculate position relative to screen
        local xPos = btnPos.X;
        local yPos = btnPos.Y + btnSize.Y + 5;
        
        -- Check if dropdown would go off screen bottom
        if yPos + maxHeight > screenSize.Y then
            -- Position above the button instead
            yPos = btnPos.Y - maxHeight - 5;
        end;
        
        -- Check if dropdown would go off screen right
        if xPos + btnSize.X > screenSize.X then
            xPos = screenSize.X - btnSize.X;
        end;
        
        droplist.Position = UDim2.new(0, xPos, 0, yPos);
        droplist.Size = UDim2.new(0, btnSize.X, 0, 0); -- Start with 0 height for animation
    end;
    
    -- // create option buttons
    for i, option in ipairs(options) do
        local optionbtn = Instance.new("TextButton");
        optionbtn.Size = UDim2.new(1, 0, 0, 30);
        optionbtn.BackgroundColor3 = option == selected and clrs.pink or Color3.new(0, 0, 0);
        optionbtn.BackgroundTransparency = option == selected and 0.7 or 1;
        optionbtn.BorderSizePixel = 0;
        optionbtn.Text = option;
        optionbtn.TextColor3 = option == selected and clrs.pink or clrs.white;
        optionbtn.TextSize = 13;
        optionbtn.Font = Enum.Font.Gotham;
        optionbtn.LayoutOrder = i;
        optionbtn.Parent = scrollframe;
        
        optionbtn.MouseEnter:Connect(function()
            if option ~= selected then
                createtween(optionbtn, twinfo.fast, {BackgroundTransparency = 0.9, TextColor3 = clrs.lightpink}):Play();
            end;
        end);
        
        optionbtn.MouseLeave:Connect(function()
            if option ~= selected then
                createtween(optionbtn, twinfo.fast, {BackgroundTransparency = 1, TextColor3 = clrs.white}):Play();
            end;
        end);
        
        optionbtn.MouseButton1Click:Connect(function()
            -- // update selection
            for _, btn in ipairs(scrollframe:GetChildren()) do
                if btn:IsA("TextButton") then
                    if btn.Text == option then
                        createtween(btn, twinfo.fast, {BackgroundTransparency = 0.7, TextColor3 = clrs.pink}):Play();
                    else
                        createtween(btn, twinfo.fast, {BackgroundTransparency = 1, TextColor3 = clrs.white}):Play();
                    end;
                end;
            end;
            
            selected = option;
            selectedlbl.Text = option;
            
            -- // close dropdown
            isopen = false;
            createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
            wait(0.25);
            droplist.Visible = false;
            
            callback(option);
        end);
    end;
    
    dropbtn.MouseButton1Click:Connect(function()
        isopen = not isopen;
        
        if isopen then
            positionDropdown();
            droplist.Visible = true;
            createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, maxHeight)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 180}):Play();
        else
            createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
            wait(0.25);
            droplist.Visible = false;
        end;
    end);
    
    -- // Close dropdown when clicking outside
    userinput.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isopen then
            local mousePos = input.Position;
            local btnPos = dropbtn.AbsolutePosition;
            local btnSize = dropbtn.AbsoluteSize;
            local listPos = droplist.AbsolutePosition;
            local listSize = droplist.AbsoluteSize;
            
            -- Check if click is outside both button and dropdown
            local outsideBtn = mousePos.X < btnPos.X or mousePos.X > btnPos.X + btnSize.X or 
                              mousePos.Y < btnPos.Y or mousePos.Y > btnPos.Y + btnSize.Y;
            local outsideList = mousePos.X < listPos.X or mousePos.X > listPos.X + listSize.X or 
                               mousePos.Y < listPos.Y or mousePos.Y > listPos.Y + listSize.Y;
            
            if outsideBtn and outsideList then
                isopen = false;
                createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
                createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
                wait(0.25);
                droplist.Visible = false;
            end;
        end;
    end);
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetValue = function(option)
            if table.find(options, option) then
                selected = option;
                selectedlbl.Text = option;
                
                -- // update visual selection
                for _, btn in ipairs(scrollframe:GetChildren()) do
                    if btn:IsA("TextButton") then
                        if btn.Text == option then
                            createtween(btn, twinfo.fast, {BackgroundTransparency = 0.7, TextColor3 = clrs.pink}):Play();
                        else
                            createtween(btn, twinfo.fast, {BackgroundTransparency = 1, TextColor3 = clrs.white}):Play();
                        end;
                    end;
                end;
            end;
        end,
        GetValue = function()
            return selected;
        end,
        SetOptions = function(newoptions)
            options = newoptions;
            maxHeight = math.min(#options * 30, 150);
            
            -- // clear existing options
            for _, child in ipairs(scrollframe:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy();
                end;
            end;
            
            -- // create new options
            for i, option in ipairs(options) do
                local optionbtn = Instance.new("TextButton");
                optionbtn.Size = UDim2.new(1, 0, 0, 30);
                optionbtn.BackgroundColor3 = option == selected and clrs.pink or Color3.new(0, 0, 0);
                optionbtn.BackgroundTransparency = option == selected and 0.7 or 1;
                optionbtn.BorderSizePixel = 0;
                optionbtn.Text = option;
                optionbtn.TextColor3 = option == selected and clrs.pink or clrs.white;
                optionbtn.TextSize = 13;
                optionbtn.Font = Enum.Font.Gotham;
                optionbtn.LayoutOrder = i;
                optionbtn.Parent = scrollframe;
                
                optionbtn.MouseEnter:Connect(function()
                    if option ~= selected then
                        createtween(optionbtn, twinfo.fast, {BackgroundTransparency = 0.9, TextColor3 = clrs.lightpink}):Play();
                    end;
                end);
                
                optionbtn.MouseLeave:Connect(function()
                    if option ~= selected then
                        createtween(optionbtn, twinfo.fast, {BackgroundTransparency = 1, TextColor3 = clrs.white}):Play();
                    end;
                end);
                
                optionbtn.MouseButton1Click:Connect(function()
                    -- // update selection
                    for _, btn in ipairs(scrollframe:GetChildren()) do
                        if btn:IsA("TextButton") then
                            if btn.Text == option then
                                createtween(btn, twinfo.fast, {BackgroundTransparency = 0.7, TextColor3 = clrs.pink}):Play();
                            else
                                createtween(btn, twinfo.fast, {BackgroundTransparency = 1, TextColor3 = clrs.white}):Play();
                            end;
                        end;
                    end;
                    
                    selected = option;
                    selectedlbl.Text = option;
                    
                    -- // close dropdown
                    isopen = false;
                    createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
                    createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
                    wait(0.25);
                    droplist.Visible = false;
                    
                    callback(option);
                end);
            end;
            
            scrollframe.CanvasSize = UDim2.new(0, 0, 0, #options * 30);
        end
    };
end;

function components:AddLabel(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Label";
    local size = cfg.Size or 14;
    local color = cfg.Color or clrs.white;
    local separator = cfg.Separator;
    
    local labelframe = Instance.new("Frame");
    labelframe.Size = UDim2.new(1, 0, 0, size + 10);
    labelframe.BackgroundTransparency = 1;
    labelframe.BorderSizePixel = 0;
    labelframe.LayoutOrder = #parent:GetChildren();
    labelframe.Parent = parent;
    
    local label = Instance.new("TextLabel");
    label.Size = UDim2.new(1, 0, 1, 0);
    label.Position = UDim2.new(0, 0, 0, 0);
    label.BackgroundTransparency = 1;
    label.Text = text;
    label.TextColor3 = color;
    label.TextSize = size;
    label.Font = Enum.Font.Gotham;
    label.TextXAlignment = Enum.TextXAlignment.Left;
    label.TextWrapped = true;
    label.Parent = labelframe;
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetText = function(newtext)
            label.Text = newtext;
        end,
        SetColor = function(newcolor)
            label.TextColor3 = newcolor;
        end
    };
end;

return components;