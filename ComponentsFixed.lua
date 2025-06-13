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

-- // store all UI elements for theme updates
local uiElements = {
    backgrounds = {},
    accents = {},
    pinks = {},
    secondaries = {},
    separators = {},
    texts = {},
    strokes = {},
    scrollbars = {}
};

-- // ENHANCED theme application function
function components:ApplyTheme(newTheme)
    -- Update color table
    for key, value in pairs(newTheme) do
        clrs[key] = value;
    end;
    
    -- Update all existing UI elements with smooth transitions
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    
    -- Update backgrounds
    for _, element in pairs(uiElements.backgrounds) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {BackgroundColor3 = clrs.bg}):Play();
        end;
    end;
    
    -- Update accents
    for _, element in pairs(uiElements.accents) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {BackgroundColor3 = clrs.accent}):Play();
        end;
    end;
    
    -- Update pink elements
    for _, element in pairs(uiElements.pinks) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {BackgroundColor3 = clrs.pink}):Play();
        end;
    end;
    
    -- Update secondary elements
    for _, element in pairs(uiElements.secondaries) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {BackgroundColor3 = clrs.secondary}):Play();
        end;
    end;
    
    -- Update separators
    for _, element in pairs(uiElements.separators) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {BackgroundColor3 = clrs.separator}):Play();
        end;
    end;
    
    -- Update text colors
    for _, data in pairs(uiElements.texts) do
        if data.element and data.element.Parent then
            local newColor = clrs[data.colorType] or clrs.white;
            tweenserv:Create(data.element, tweenInfo, {TextColor3 = newColor}):Play();
        end;
    end;
    
    -- Update strokes
    for _, element in pairs(uiElements.strokes) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {Color = clrs.separator}):Play();
        end;
    end;
    
    -- Update scrollbars
    for _, element in pairs(uiElements.scrollbars) do
        if element and element.Parent then
            tweenserv:Create(element, tweenInfo, {ScrollBarImageColor3 = clrs.pink}):Play();
        end;
    end;
    
    -- Try to update main UI if it exists
    local screenGui = game:GetService("CoreGui"):FindFirstChild("PinkUI");
    if screenGui then
        local main = screenGui:FindFirstChild("Main");
        if main then
            -- Update main window colors
            tweenserv:Create(main, tweenInfo, {BackgroundColor3 = clrs.bg}):Play();
            
            -- Update title gradient if it exists
            local titlebar = main:FindFirstChild("TitleBar");
            if titlebar then
                local title = titlebar:FindFirstChild("Title");
                if title and title:FindFirstChild("UIGradient") then
                    local gradient = title:FindFirstChild("UIGradient");
                    gradient.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, clrs.pink),
                        ColorSequenceKeypoint.new(0.5, clrs.lightpink),
                        ColorSequenceKeypoint.new(1, clrs.pink)
                    };
                end;
            end;
            
            -- Update all separators in main UI
            for _, child in pairs(main:GetDescendants()) do
                if child.Name:find("Separator") and child:IsA("Frame") then
                    tweenserv:Create(child, tweenInfo, {BackgroundColor3 = clrs.separator}):Play();
                end;
                if child:IsA("UIStroke") then
                    tweenserv:Create(child, tweenInfo, {Color = clrs.separator}):Play();
                end;
                if child:IsA("ScrollingFrame") then
                    tweenserv:Create(child, tweenInfo, {ScrollBarImageColor3 = clrs.pink}):Play();
                end;
            end;
        end;
    end;
    
    print("Theme applied successfully!");
end;

-- // helper function to register UI elements
local function registerElement(element, category, colorType)
    if category == "texts" then
        table.insert(uiElements[category], {element = element, colorType = colorType or "white"});
    else
        table.insert(uiElements[category], element);
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
    
    registerElement(sepline, "separators");
    
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
    
    registerElement(togglelbl, "texts", default and "white" or "toggleoff");
    
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
        
        registerElement(desclbl, "texts", "grey");
    end;
    
    -- // toggle switch
    local togglebtn = Instance.new("TextButton");
    togglebtn.Size = UDim2.new(0, 45, 0, 22);
    togglebtn.Position = UDim2.new(1, -45, 0, 5);
    togglebtn.BackgroundColor3 = default and clrs.pink or clrs.accent;
    togglebtn.BorderSizePixel = 0;
    togglebtn.Text = "";
    togglebtn.Parent = toggleframe;
    
    registerElement(togglebtn, default and "pinks" or "accents");
    
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