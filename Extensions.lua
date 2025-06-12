-- // advanced extensions for PinkUI
local extensions = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");

local clrs = {
    bg = Color3.fromRGB(15, 15, 15),
    secondary = Color3.fromRGB(35, 35, 35),
    accent = Color3.fromRGB(60, 60, 60),
    pink = Color3.fromRGB(255, 105, 180),
    darkpink = Color3.fromRGB(200, 80, 140),
    white = Color3.fromRGB(255, 255, 255),
    separator = Color3.fromRGB(80, 80, 80)
};

local twinfo = {
    fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

function extensions:AddDropdown(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Dropdown";
    local options = cfg.Options or {"Option 1", "Option 2", "Option 3"};
    local default = cfg.Default or options[1];
    local callback = cfg.Callback or function() end;
    
    local dropdown = Instance.new("Frame");
    dropdown.Name = "Dropdown";
    dropdown.Size = UDim2.new(1, 0, 0, 35);
    dropdown.BackgroundColor3 = clrs.accent;
    dropdown.BorderSizePixel = 0;
    dropdown.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = dropdown;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = dropdown;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -100, 1, 0);
    lbl.Position = UDim2.new(0, 10, 0, 0);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.Parent = dropdown;
    
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(0, 80, 0, 25);
    btn.Position = UDim2.new(1, -90, 0.5, -12.5);
    btn.BackgroundColor3 = clrs.secondary;
    btn.BorderSizePixel = 0;
    btn.Text = default;
    btn.TextColor3 = clrs.pink;
    btn.TextSize = 11;
    btn.Font = Enum.Font.Gotham;
    btn.Parent = dropdown;
    
    local btncorner = Instance.new("UICorner");
    btncorner.CornerRadius = UDim.new(0, 4);
    btncorner.Parent = btn;
    
    local arrow = Instance.new("TextLabel");
    arrow.Size = UDim2.new(0, 15, 1, 0);
    arrow.Position = UDim2.new(1, -15, 0, 0);
    arrow.BackgroundTransparency = 1;
    arrow.Text = "▼";
    arrow.TextColor3 = clrs.white;
    arrow.TextSize = 8;
    arrow.Font = Enum.Font.Gotham;
    arrow.Parent = btn;
    
    -- // dropdown menu
    local menu = Instance.new("Frame");
    menu.Size = UDim2.new(0, 80, 0, 0);
    menu.Position = UDim2.new(1, -90, 1, 5);
    menu.BackgroundColor3 = clrs.secondary;
    menu.BorderSizePixel = 0;
    menu.Visible = false;
    menu.Parent = dropdown;
    
    local menucorner = Instance.new("UICorner");
    menucorner.CornerRadius = UDim.new(0, 4);
    menucorner.Parent = menu;
    
    local menustroke = Instance.new("UIStroke");
    menustroke.Color = clrs.pink;
    menustroke.Thickness = 1;
    menustroke.Parent = menu;
    
    local menulayout = Instance.new("UIListLayout");
    menulayout.SortOrder = Enum.SortOrder.LayoutOrder;
    menulayout.Parent = menu;
    
    local opened = false;
    local selected = default;
    
    local function toggle()
        opened = not opened;
        if opened then
            menu.Visible = true;
            createtween(menu, twinfo.med, {Size = UDim2.new(0, 80, 0, #options * 25)}):Play();
            createtween(arrow, twinfo.med, {Rotation = 180}):Play();
            createtween(dropdown, twinfo.med, {Size = UDim2.new(1, 0, 0, 35 + (#options * 25) + 10)}):Play();
        else
            createtween(menu, twinfo.med, {Size = UDim2.new(0, 80, 0, 0)}):Play();
            createtween(arrow, twinfo.med, {Rotation = 0}):Play();
            createtween(dropdown, twinfo.med, {Size = UDim2.new(1, 0, 0, 35)}):Play();
            wait(0.25);
            menu.Visible = false;
        end;
    end;
    
    -- // create option buttons
    for i, option in pairs(options) do
        local optbtn = Instance.new("TextButton");
        optbtn.Size = UDim2.new(1, 0, 0, 25);
        optbtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
        optbtn.BorderSizePixel = 0;
        optbtn.Text = option;
        optbtn.TextColor3 = clrs.white;
        optbtn.TextSize = 11;
        optbtn.Font = Enum.Font.Gotham;
        optbtn.Parent = menu;
        
        optbtn.MouseEnter:Connect(function()
            createtween(optbtn, twinfo.fast, {BackgroundColor3 = clrs.pink}):Play();
        end);
        
        optbtn.MouseLeave:Connect(function()
            createtween(optbtn, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play();
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
    dropdown.MouseEnter:Connect(function()
        if not opened then
            createtween(dropdown, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
            createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
            createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
        end;
    end);
    
    dropdown.MouseLeave:Connect(function()
        if not opened then
            createtween(dropdown, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
            createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
        end;
    end);
    
    return {
        Element = dropdown,
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
    local default = cfg.Default or clrs.pink;
    local callback = cfg.Callback or function() end;
    
    local picker = Instance.new("Frame");
    picker.Name = "ColorPicker";
    picker.Size = UDim2.new(1, 0, 0, 35);
    picker.BackgroundColor3 = clrs.accent;
    picker.BorderSizePixel = 0;
    picker.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = picker;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = picker;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -60, 1, 0);
    lbl.Position = UDim2.new(0, 10, 0, 0);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.Parent = picker;
    
    local preview = Instance.new("TextButton");
    preview.Size = UDim2.new(0, 40, 0, 25);
    preview.Position = UDim2.new(1, -50, 0.5, -12.5);
    preview.BackgroundColor3 = default;
    preview.BorderSizePixel = 0;
    preview.Text = "";
    preview.Parent = picker;
    
    local prevcorner = Instance.new("UICorner");
    prevcorner.CornerRadius = UDim.new(0, 4);
    prevcorner.Parent = preview;
    
    local prevstroke = Instance.new("UIStroke");
    prevstroke.Color = clrs.white;
    prevstroke.Thickness = 1;
    prevstroke.Parent = preview;
    
    local currentcolor = default;
    
    -- // simple color options
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
    colormenu.Size = UDim2.new(0, 120, 0, 0);
    colormenu.Position = UDim2.new(1, -130, 1, 5);
    colormenu.BackgroundColor3 = clrs.secondary;
    colormenu.BorderSizePixel = 0;
    colormenu.Visible = false;
    colormenu.Parent = picker;
    
    local colorcorner = Instance.new("UICorner");
    colorcorner.CornerRadius = UDim.new(0, 4);
    colorcorner.Parent = colormenu;
    
    local colorstroke = Instance.new("UIStroke");
    colorstroke.Color = clrs.pink;
    colorstroke.Thickness = 1;
    colorstroke.Parent = colormenu;
    
    local colorgrid = Instance.new("UIGridLayout");
    colorgrid.CellSize = UDim2.new(0, 20, 0, 20);
    colorgrid.CellPadding = UDim2.new(0, 5, 0, 5);
    colorgrid.Parent = colormenu;
    
    local colorpad = Instance.new("UIPadding");
    colorpad.PaddingAll = UDim.new(0, 5);
    colorpad.Parent = colormenu;
    
    local opened = false;
    
    local function toggle()
        opened = not opened;
        if opened then
            colormenu.Visible = true;
            createtween(colormenu, twinfo.med, {Size = UDim2.new(0, 120, 0, 60)}):Play();
            createtween(picker, twinfo.med, {Size = UDim2.new(1, 0, 0, 35 + 70)}):Play();
        else
            createtween(colormenu, twinfo.med, {Size = UDim2.new(0, 120, 0, 0)}):Play();
            createtween(picker, twinfo.med, {Size = UDim2.new(1, 0, 0, 35)}):Play();
            wait(0.25);
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
        cbcorner.CornerRadius = UDim.new(0, 3);
        cbcorner.Parent = colorbtn;
        
        local cbstroke = Instance.new("UIStroke");
        cbstroke.Color = clrs.white;
        cbstroke.Thickness = 0;
        cbstroke.Parent = colorbtn;
        
        colorbtn.MouseEnter:Connect(function()
            createtween(cbstroke, twinfo.fast, {Thickness = 2}):Play();
        end);
        
        colorbtn.MouseLeave:Connect(function()
            createtween(cbstroke, twinfo.fast, {Thickness = 0}):Play();
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
    picker.MouseEnter:Connect(function()
        if not opened then
            createtween(picker, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
            createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
            createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
        end;
    end);
    
    picker.MouseLeave:Connect(function()
        if not opened then
            createtween(picker, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
            createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
        end;
    end);
    
    return {
        Element = picker,
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
    local default = cfg.Default or Enum.KeyCode.F;
    local callback = cfg.Callback or function() end;
    
    local keybind = Instance.new("Frame");
    keybind.Name = "KeyBind";
    keybind.Size = UDim2.new(1, 0, 0, 35);
    keybind.BackgroundColor3 = clrs.accent;
    keybind.BorderSizePixel = 0;
    keybind.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = keybind;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = keybind;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -80, 1, 0);
    lbl.Position = UDim2.new(0, 10, 0, 0);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.Parent = keybind;
    
    local keybtn = Instance.new("TextButton");
    keybtn.Size = UDim2.new(0, 60, 0, 25);
    keybtn.Position = UDim2.new(1, -70, 0.5, -12.5);
    keybtn.BackgroundColor3 = clrs.secondary;
    keybtn.BorderSizePixel = 0;
    keybtn.Text = string.sub(tostring(default), 14);
    keybtn.TextColor3 = clrs.pink;
    keybtn.TextSize = 11;
    keybtn.Font = Enum.Font.Gotham;
    keybtn.Parent = keybind;
    
    local keycorner = Instance.new("UICorner");
    keycorner.CornerRadius = UDim.new(0, 4);
    keycorner.Parent = keybtn;
    
    local currentkey = default;
    local listening = false;
    
    local function startlistening()
        listening = true;
        keybtn.Text = "...";
        createtween(keybtn, twinfo.fast, {BackgroundColor3 = clrs.pink}):Play();
    end;
    
    local function stoplistening(key)
        listening = false;
        currentkey = key or currentkey;
        keybtn.Text = string.sub(tostring(currentkey), 14);
        createtween(keybtn, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
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
    keybind.MouseEnter:Connect(function()
        if not listening then
            createtween(keybind, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
            createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
            createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
        end;
    end);
    
    keybind.MouseLeave:Connect(function()
        if not listening then
            createtween(keybind, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
            createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
            createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
        end;
    end);
    
    return {
        Element = keybind,
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