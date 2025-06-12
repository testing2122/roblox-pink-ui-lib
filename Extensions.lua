-- // advanced extensions for PinkUI
local extensions = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");

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

local twinfo = {
    fast = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

function extensions:AddDropdown(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Dropdown";
    local desc = cfg.Description or "";
    local options = cfg.Options or {"Option 1", "Option 2", "Option 3"};
    local default = cfg.Default or options[1];
    local callback = cfg.Callback or function() end;
    
    local dropdownframe = Instance.new("Frame");
    dropdownframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    dropdownframe.BackgroundColor3 = clrs.secondary;
    dropdownframe.BackgroundTransparency = 0.1;
    dropdownframe.BorderSizePixel = 0;
    dropdownframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = dropdownframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = dropdownframe;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -120, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = dropdownframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -120, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = dropdownframe;
    end;
    
    -- // dropdown button
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(0, 100, 0, 30);
    btn.Position = UDim2.new(1, -110, 0, desc ~= "" and 22 or 12);
    btn.BackgroundColor3 = clrs.accent;
    btn.BorderSizePixel = 0;
    btn.Text = default;
    btn.TextColor3 = clrs.pink;
    btn.TextSize = 13;
    btn.Font = Enum.Font.Gotham;
    btn.Parent = dropdownframe;
    
    local btncorner = Instance.new("UICorner");
    btncorner.CornerRadius = UDim.new(0, 6);
    btncorner.Parent = btn;
    
    local btnstroke = Instance.new("UIStroke");
    btnstroke.Color = clrs.separator;
    btnstroke.Thickness = 1;
    btnstroke.Transparency = 0.6;
    btnstroke.Parent = btn;
    
    local arrow = Instance.new("TextLabel");
    arrow.Size = UDim2.new(0, 20, 1, 0);
    arrow.Position = UDim2.new(1, -20, 0, 0);
    arrow.BackgroundTransparency = 1;
    arrow.Text = "▼";
    arrow.TextColor3 = clrs.grey;
    arrow.TextSize = 10;
    arrow.Font = Enum.Font.Gotham;
    arrow.Parent = btn;
    
    -- // dropdown menu
    local menu = Instance.new("Frame");
    menu.Size = UDim2.new(0, 100, 0, 0);
    menu.Position = UDim2.new(1, -110, 0, desc ~= "" and 54 or 44);
    menu.BackgroundColor3 = clrs.accent;
    menu.BorderSizePixel = 0;
    menu.Visible = false;
    menu.ClipsDescendants = true;
    menu.Parent = dropdownframe;
    
    local menucorner = Instance.new("UICorner");
    menucorner.CornerRadius = UDim.new(0, 6);
    menucorner.Parent = menu;
    
    local menustroke = Instance.new("UIStroke");
    menustroke.Color = clrs.pink;
    menustroke.Thickness = 1;
    menustroke.Transparency = 0.4;
    menustroke.Parent = menu;
    
    local menulayout = Instance.new("UIListLayout");
    menulayout.SortOrder = Enum.SortOrder.LayoutOrder;
    menulayout.Padding = UDim.new(0, 2);
    menulayout.Parent = menu;
    
    local menupad = Instance.new("UIPadding");
    menupad.PaddingLeft = UDim.new(0, 4);
    menupad.PaddingRight = UDim.new(0, 4);
    menupad.PaddingTop = UDim.new(0, 4);
    menupad.PaddingBottom = UDim.new(0, 4);
    menupad.Parent = menu;
    
    local opened = false;
    local selected = default;
    
    local function toggle()
        opened = not opened;
        if opened then
            menu.Visible = true;
            local menuHeight = (#options * 28) + 8;
            createtween(menu, twinfo.med, {Size = UDim2.new(0, 100, 0, menuHeight)}):Play();
            createtween(arrow, twinfo.med, {Rotation = 180}):Play();
            createtween(dropdownframe, twinfo.med, {Size = UDim2.new(1, 0, 0, (desc ~= "" and 75 or 55) + menuHeight + 5)}):Play();
        else
            createtween(menu, twinfo.med, {Size = UDim2.new(0, 100, 0, 0)}):Play();
            createtween(arrow, twinfo.med, {Rotation = 0}):Play();
            createtween(dropdownframe, twinfo.med, {Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55)}):Play();
            wait(0.35);
            menu.Visible = false;
        end;
    end;
    
    -- // create option buttons
    for i, option in pairs(options) do
        local optbtn = Instance.new("TextButton");
        optbtn.Size = UDim2.new(1, 0, 0, 24);
        optbtn.BackgroundColor3 = clrs.secondary;
        optbtn.BorderSizePixel = 0;
        optbtn.Text = option;
        optbtn.TextColor3 = clrs.white;
        optbtn.TextSize = 12;
        optbtn.Font = Enum.Font.Gotham;
        optbtn.Parent = menu;
        
        local optcorner = Instance.new("UICorner");
        optcorner.CornerRadius = UDim.new(0, 4);
        optcorner.Parent = optbtn;
        
        optbtn.MouseEnter:Connect(function()
            createtween(optbtn, twinfo.fast, {BackgroundColor3 = clrs.pink, TextColor3 = clrs.white}):Play();
        end);
        
        optbtn.MouseLeave:Connect(function()
            createtween(optbtn, twinfo.fast, {BackgroundColor3 = clrs.secondary, TextColor3 = clrs.white}):Play();
        end);
        
        optbtn.MouseButton1Click:Connect(function()
            selected = option;
            btn.Text = option;
            toggle();
            callback(option);
        end);
    end;
    
    btn.MouseButton1Click:Connect(toggle);
    
    -- // hover effects
    btn.MouseEnter:Connect(function()
        if not opened then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
            createtween(btnstroke, twinfo.fast, {Transparency = 0.3}):Play();
        end;
    end);
    
    btn.MouseLeave:Connect(function()
        if not opened then
            createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(btnstroke, twinfo.fast, {Transparency = 0.6}):Play();
        end;
    end);
    
    return {
        SetValue = function(val)
            if table.find(options, val) then
                selected = val;
                btn.Text = val;
                callback(val);
            end;
        end,
        GetValue = function()
            return selected;
        end
    };
end;

function extensions:AddColorPicker(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Color Picker";
    local desc = cfg.Description or "";
    local default = cfg.Default or clrs.pink;
    local callback = cfg.Callback or function() end;
    
    local pickerframe = Instance.new("Frame");
    pickerframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    pickerframe.BackgroundColor3 = clrs.secondary;
    pickerframe.BackgroundTransparency = 0.1;
    pickerframe.BorderSizePixel = 0;
    pickerframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = pickerframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = pickerframe;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -80, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = pickerframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -80, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = pickerframe;
    end;
    
    local preview = Instance.new("TextButton");
    preview.Size = UDim2.new(0, 50, 0, 30);
    preview.Position = UDim2.new(1, -60, 0, desc ~= "" and 22 or 12);
    preview.BackgroundColor3 = default;
    preview.BorderSizePixel = 0;
    preview.Text = "";
    preview.Parent = pickerframe;
    
    local prevcorner = Instance.new("UICorner");
    prevcorner.CornerRadius = UDim.new(0, 6);
    prevcorner.Parent = preview;
    
    local prevstroke = Instance.new("UIStroke");
    prevstroke.Color = clrs.white;
    prevstroke.Thickness = 2;
    prevstroke.Parent = preview;
    
    local currentcolor = default;
    
    -- // color options
    local colors = {
        Color3.fromRGB(255, 105, 180), -- pink
        Color3.fromRGB(255, 100, 100), -- red
        Color3.fromRGB(100, 255, 100), -- green
        Color3.fromRGB(100, 100, 255), -- blue
        Color3.fromRGB(255, 255, 100), -- yellow
        Color3.fromRGB(255, 150, 100), -- orange
        Color3.fromRGB(150, 100, 255), -- purple
        Color3.fromRGB(100, 255, 255), -- cyan
        Color3.fromRGB(255, 255, 255), -- white
        Color3.fromRGB(128, 128, 128)  -- gray
    };
    
    local colormenu = Instance.new("Frame");
    colormenu.Size = UDim2.new(0, 140, 0, 0);
    colormenu.Position = UDim2.new(1, -150, 0, desc ~= "" and 54 or 44);
    colormenu.BackgroundColor3 = clrs.accent;
    colormenu.BorderSizePixel = 0;
    colormenu.Visible = false;
    colormenu.ClipsDescendants = true;
    colormenu.Parent = pickerframe;
    
    local colorcorner = Instance.new("UICorner");
    colorcorner.CornerRadius = UDim.new(0, 6);
    colorcorner.Parent = colormenu;
    
    local colorstroke = Instance.new("UIStroke");
    colorstroke.Color = clrs.pink;
    colorstroke.Thickness = 1;
    colorstroke.Transparency = 0.4;
    colorstroke.Parent = colormenu;
    
    local colorgrid = Instance.new("UIGridLayout");
    colorgrid.CellSize = UDim2.new(0, 22, 0, 22);
    colorgrid.CellPadding = UDim2.new(0, 4, 0, 4);
    colorgrid.Parent = colormenu;
    
    local colorpad = Instance.new("UIPadding");
    colorpad.PaddingLeft = UDim.new(0, 8);
    colorpad.PaddingRight = UDim.new(0, 8);
    colorpad.PaddingTop = UDim.new(0, 8);
    colorpad.PaddingBottom = UDim.new(0, 8);
    colorpad.Parent = colormenu;
    
    local opened = false;
    
    local function toggle()
        opened = not opened;
        if opened then
            colormenu.Visible = true;
            createtween(colormenu, twinfo.med, {Size = UDim2.new(0, 140, 0, 70)}):Play();
            createtween(pickerframe, twinfo.med, {Size = UDim2.new(1, 0, 0, (desc ~= "" and 75 or 55) + 75)}):Play();
        else
            createtween(colormenu, twinfo.med, {Size = UDim2.new(0, 140, 0, 0)}):Play();
            createtween(pickerframe, twinfo.med, {Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55)}):Play();
            wait(0.35);
            colormenu.Visible = false;
        end;
    end;
    
    -- // create color buttons
    for i, color in pairs(colors) do
        local colorbtn = Instance.new("TextButton");
        colorbtn.BackgroundColor3 = color;
        colorbtn.BorderSizePixel = 0;
        colorbtn.Text = "";
        colorbtn.Parent = colormenu;
        
        local cbcorner = Instance.new("UICorner");
        cbcorner.CornerRadius = UDim.new(0, 4);
        cbcorner.Parent = colorbtn;
        
        local cbstroke = Instance.new("UIStroke");
        cbstroke.Color = clrs.white;
        cbstroke.Thickness = 0;
        cbstroke.Parent = colorbtn;
        
        colorbtn.MouseEnter:Connect(function()
            createtween(cbstroke, twinfo.fast, {Thickness = 2}):Play();
            createtween(colorbtn, twinfo.fast, {Size = UDim2.new(0, 24, 0, 24)}):Play();
        end);
        
        colorbtn.MouseLeave:Connect(function()
            createtween(cbstroke, twinfo.fast, {Thickness = 0}):Play();
            createtween(colorbtn, twinfo.fast, {Size = UDim2.new(0, 22, 0, 22)}):Play();
        end);
        
        colorbtn.MouseButton1Click:Connect(function()
            currentcolor = color;
            preview.BackgroundColor3 = color;
            toggle();
            callback(color);
        end);
    end;
    
    preview.MouseButton1Click:Connect(toggle);
    
    -- // hover effects
    preview.MouseEnter:Connect(function()
        if not opened then
            createtween(prevstroke, twinfo.fast, {Color = clrs.pink}):Play();
        end;
    end);
    
    preview.MouseLeave:Connect(function()
        if not opened then
            createtween(prevstroke, twinfo.fast, {Color = clrs.white}):Play();
        end;
    end);
    
    return {
        SetValue = function(color)
            currentcolor = color;
            preview.BackgroundColor3 = color;
            callback(color);
        end,
        GetValue = function()
            return currentcolor;
        end
    };
end;

function extensions:AddKeyBind(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Key Bind";
    local desc = cfg.Description or "";
    local default = cfg.Default or Enum.KeyCode.F;
    local callback = cfg.Callback or function() end;
    
    local keybindframe = Instance.new("Frame");
    keybindframe.Size = UDim2.new(1, 0, 0, desc ~= "" and 75 or 55);
    keybindframe.BackgroundColor3 = clrs.secondary;
    keybindframe.BackgroundTransparency = 0.1;
    keybindframe.BorderSizePixel = 0;
    keybindframe.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = keybindframe;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.pink;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = keybindframe;
    
    -- // main label
    local mainlbl = Instance.new("TextLabel");
    mainlbl.Size = UDim2.new(1, -80, 0, 20);
    mainlbl.Position = UDim2.new(0, 10, 0, desc ~= "" and 18 or 12);
    mainlbl.BackgroundTransparency = 1;
    mainlbl.Text = text;
    mainlbl.TextColor3 = clrs.white;
    mainlbl.TextSize = 14;
    mainlbl.Font = Enum.Font.GothamMedium;
    mainlbl.TextXAlignment = Enum.TextXAlignment.Left;
    mainlbl.Parent = keybindframe;
    
    -- // description
    if desc ~= "" then
        local desclbl = Instance.new("TextLabel");
        desclbl.Size = UDim2.new(1, -80, 0, 16);
        desclbl.Position = UDim2.new(0, 10, 0, 38);
        desclbl.BackgroundTransparency = 1;
        desclbl.Text = desc;
        desclbl.TextColor3 = clrs.grey;
        desclbl.TextSize = 12;
        desclbl.Font = Enum.Font.Gotham;
        desclbl.TextXAlignment = Enum.TextXAlignment.Left;
        desclbl.Parent = keybindframe;
    end;
    
    local keybtn = Instance.new("TextButton");
    keybtn.Size = UDim2.new(0, 60, 0, 30);
    keybtn.Position = UDim2.new(1, -70, 0, desc ~= "" and 22 or 12);
    keybtn.BackgroundColor3 = clrs.accent;
    keybtn.BorderSizePixel = 0;
    keybtn.Text = string.sub(tostring(default), 14);
    keybtn.TextColor3 = clrs.pink;
    keybtn.TextSize = 12;
    keybtn.Font = Enum.Font.GothamBold;
    keybtn.Parent = keybindframe;
    
    local keycorner = Instance.new("UICorner");
    keycorner.CornerRadius = UDim.new(0, 6);
    keycorner.Parent = keybtn;
    
    local keystroke = Instance.new("UIStroke");
    keystroke.Color = clrs.separator;
    keystroke.Thickness = 1;
    keystroke.Transparency = 0.6;
    keystroke.Parent = keybtn;
    
    local currentkey = default;
    local listening = false;
    
    local function startlistening()
        listening = true;
        keybtn.Text = "...";
        createtween(keybtn, twinfo.fast, {BackgroundColor3 = clrs.pink, TextColor3 = clrs.white}):Play();
        createtween(keystroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.3}):Play();
    end;
    
    local function stoplistening(key)
        listening = false;
        currentkey = key or currentkey;
        keybtn.Text = string.sub(tostring(currentkey), 14);
        createtween(keybtn, twinfo.fast, {BackgroundColor3 = clrs.accent, TextColor3 = clrs.pink}):Play();
        createtween(keystroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.6}):Play();
    end;
    
    keybtn.MouseButton1Click:Connect(startlistening);
    
    userinput.InputBegan:Connect(function(input, processed)
        if not processed then
            if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                stoplistening(input.KeyCode);
            elseif input.KeyCode == currentkey then
                callback();
            end;
        end;
    end);
    
    -- // hover effects
    keybtn.MouseEnter:Connect(function()
        if not listening then
            createtween(keybtn, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
            createtween(keystroke, twinfo.fast, {Transparency = 0.3}):Play();
        end;
    end);
    
    keybtn.MouseLeave:Connect(function()
        if not listening then
            createtween(keybtn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(keystroke, twinfo.fast, {Transparency = 0.6}):Play();
        end;
    end);
    
    return {
        SetValue = function(key)
            currentkey = key;
            keybtn.Text = string.sub(tostring(key), 14);
        end,
        GetValue = function()
            return currentkey;
        end
    };
end;

return extensions;