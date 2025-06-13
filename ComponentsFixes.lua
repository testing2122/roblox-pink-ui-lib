-- // Component Fixes for Pink UI
-- // This file contains the fixes for toggle text colors, dropdown expansion, and keybind integration

local componentsFixes = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");

-- // Updated color scheme with toggle off state
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
    toggleoff = Color3.fromRGB(80, 80, 85) -- Grey for disabled toggles
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

-- // Fixed toggle component with grey text when disabled
function componentsFixes:AddToggle(parent, cfg)
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
    togglelbl.TextColor3 = default and clrs.white or clrs.toggleoff; -- Grey when disabled
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
            createtween(togglelbl, twinfo.med, {TextColor3 = clrs.white}):Play(); -- White when enabled
        else
            createtween(togglebtn, twinfo.med, {BackgroundColor3 = clrs.accent}):Play();
            createtween(togglecircle, twinfo.med, {Position = UDim2.new(0, 2, 0.5, -9)}):Play();
            createtween(togglelbl, twinfo.med, {TextColor3 = clrs.toggleoff}):Play(); -- Grey when disabled
        end;
        
        callback(enabled);
    end);
    
    -- // add separator if requested
    if separator then
        componentsFixes:AddSeparator(parent, separator == true and {} or separator);
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

-- // Fixed dropdown with proper expansion
function componentsFixes:AddDropdown(parent, cfg)
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
    
    -- // dropdown list
    local droplist = Instance.new("Frame");
    droplist.Size = UDim2.new(1, 0, 0, math.min(#options * 30, 150));
    droplist.Position = UDim2.new(0, 0, 1, 5);
    droplist.BackgroundColor3 = clrs.secondary;
    droplist.BorderSizePixel = 0;
    droplist.Visible = false;
    droplist.ZIndex = 10;
    droplist.Parent = dropbtn;
    
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
    scrollframe.AutomaticCanvasSize = Enum.AutomaticSize.Y; -- Auto expand
    scrollframe.Parent = droplist;
    
    local scrollcorner = Instance.new("UICorner");
    scrollcorner.CornerRadius = UDim.new(0, 6);
    scrollcorner.Parent = scrollframe;
    
    local optionlayout = Instance.new("UIListLayout");
    optionlayout.SortOrder = Enum.SortOrder.LayoutOrder;
    optionlayout.Parent = scrollframe;
    
    local selected = default;
    local isopen = false;
    
    -- // Function to expand parent container when dropdown opens
    local function expandParent(expand)
        local parentBox = dropframe.Parent;
        if parentBox and parentBox:IsA("ScrollingFrame") then
            local currentSize = dropframe.Size;
            local expandHeight = expand and math.min(#options * 30, 150) or 0;
            
            createtween(dropframe, twinfo.fast, {
                Size = UDim2.new(currentSize.X.Scale, currentSize.X.Offset, 
                                currentSize.Y.Scale, currentSize.Y.Offset + expandHeight)
            }):Play();
        end;
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
            expandParent(false);
            createtween(droplist, twinfo.fast, {Size = UDim2.new(1, 0, 0, 0)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
            wait(0.25);
            droplist.Visible = false;
            
            callback(option);
        end);
    end;
    
    dropbtn.MouseButton1Click:Connect(function()
        isopen = not isopen;
        
        if isopen then
            droplist.Visible = true;
            expandParent(true);
            createtween(droplist, twinfo.fast, {Size = UDim2.new(1, 0, 0, math.min(#options * 30, 150))}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 180}):Play();
        else
            expandParent(false);
            createtween(droplist, twinfo.fast, {Size = UDim2.new(1, 0, 0, 0)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
            wait(0.25);
            droplist.Visible = false;
        end;
    end);
    
    -- // add separator if requested
    if separator then
        componentsFixes:AddSeparator(parent, separator == true and {} or separator);
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
        end
    };
end;

-- // Add separator function
function componentsFixes:AddSeparator(parent, cfg)
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

return componentsFixes;