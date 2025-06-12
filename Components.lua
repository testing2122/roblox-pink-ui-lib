-- // components extension for PinkUI
local components = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");

-- // color scheme (matching main lib)
local clrs = {
    bg = Color3.fromRGB(15, 15, 15),
    secondary = Color3.fromRGB(35, 35, 35),
    accent = Color3.fromRGB(60, 60, 60),
    pink = Color3.fromRGB(255, 105, 180),
    darkpink = Color3.fromRGB(200, 80, 140),
    white = Color3.fromRGB(255, 255, 255),
    separator = Color3.fromRGB(80, 80, 80),
    success = Color3.fromRGB(100, 255, 100),
    warning = Color3.fromRGB(255, 200, 100)
};

-- // tween configs
local twinfo = {
    fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

function components:AddButton(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Button";
    local callback = cfg.Callback or function() end;
    
    local btn = Instance.new("TextButton");
    btn.Name = "Button";
    btn.Size = UDim2.new(1, 0, 0, 35);
    btn.BackgroundColor3 = clrs.accent;
    btn.BorderSizePixel = 0;
    btn.Text = "";
    btn.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = btn;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = btn;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -20, 1, 0);
    lbl.Position = UDim2.new(0, 10, 0, 0);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.Parent = btn;
    
    -- // hover effects
    btn.MouseEnter:Connect(function()
        createtween(btn, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
    end);
    
    btn.MouseLeave:Connect(function()
        createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
    end);
    
    btn.MouseButton1Down:Connect(function()
        createtween(btn, twinfo.fast, {BackgroundColor3 = clrs.darkpink}):Play();
    end);
    
    btn.MouseButton1Up:Connect(function()
        createtween(btn, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
    end);
    
    btn.MouseButton1Click:Connect(callback);
    
    return btn;
end;

function components:AddToggle(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Toggle";
    local default = cfg.Default or false;
    local callback = cfg.Callback or function() end;
    
    local toggle = Instance.new("Frame");
    toggle.Name = "Toggle";
    toggle.Size = UDim2.new(1, 0, 0, 35);
    toggle.BackgroundColor3 = clrs.accent;
    toggle.BorderSizePixel = 0;
    toggle.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = toggle;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = toggle;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -60, 1, 0);
    lbl.Position = UDim2.new(0, 10, 0, 0);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.Parent = toggle;
    
    -- // toggle switch
    local switch = Instance.new("TextButton");
    switch.Size = UDim2.new(0, 40, 0, 20);
    switch.Position = UDim2.new(1, -50, 0.5, -10);
    switch.BackgroundColor3 = clrs.secondary;
    switch.BorderSizePixel = 0;
    switch.Text = "";
    switch.Parent = toggle;
    
    local switchcorner = Instance.new("UICorner");
    switchcorner.CornerRadius = UDim.new(0, 10);
    switchcorner.Parent = switch;
    
    local knob = Instance.new("Frame");
    knob.Size = UDim2.new(0, 16, 0, 16);
    knob.Position = UDim2.new(0, 2, 0.5, -8);
    knob.BackgroundColor3 = clrs.white;
    knob.BorderSizePixel = 0;
    knob.Parent = switch;
    
    local knobcorner = Instance.new("UICorner");
    knobcorner.CornerRadius = UDim.new(0, 8);
    knobcorner.Parent = knob;
    
    local enabled = default;
    
    local function updatetoggle()
        if enabled then
            createtween(switch, twinfo.med, {BackgroundColor3 = clrs.pink}):Play();
            createtween(knob, twinfo.med, {Position = UDim2.new(1, -18, 0.5, -8)}):Play();
        else
            createtween(switch, twinfo.med, {BackgroundColor3 = clrs.secondary}):Play();
            createtween(knob, twinfo.med, {Position = UDim2.new(0, 2, 0.5, -8)}):Play();
        end;
        callback(enabled);
    end;
    
    -- // hover effects
    toggle.MouseEnter:Connect(function()
        createtween(toggle, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
    end);
    
    toggle.MouseLeave:Connect(function()
        createtween(toggle, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
    end);
    
    switch.MouseButton1Click:Connect(function()
        enabled = not enabled;
        updatetoggle();
    end);
    
    updatetoggle();
    
    return {
        Element = toggle,
        SetValue = function(val)
            enabled = val;
            updatetoggle();
        end,
        GetValue = function()
            return enabled;
        end
    };
end;

function components:AddSlider(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Slider";
    local min = cfg.Min or 0;
    local max = cfg.Max or 100;
    local default = cfg.Default or min;
    local callback = cfg.Callback or function() end;
    local suffix = cfg.Suffix or "";
    
    local slider = Instance.new("Frame");
    slider.Name = "Slider";
    slider.Size = UDim2.new(1, 0, 0, 50);
    slider.BackgroundColor3 = clrs.accent;
    slider.BorderSizePixel = 0;
    slider.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = slider;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = slider;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -80, 0, 20);
    lbl.Position = UDim2.new(0, 10, 0, 5);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.Parent = slider;
    
    local vallbl = Instance.new("TextLabel");
    vallbl.Size = UDim2.new(0, 70, 0, 20);
    vallbl.Position = UDim2.new(1, -80, 0, 5);
    vallbl.BackgroundTransparency = 1;
    vallbl.Text = tostring(default) .. suffix;
    vallbl.TextColor3 = clrs.pink;
    vallbl.TextSize = 12;
    vallbl.Font = Enum.Font.GothamBold;
    vallbl.TextXAlignment = Enum.TextXAlignment.Right;
    vallbl.Parent = slider;
    
    -- // slider track
    local track = Instance.new("Frame");
    track.Size = UDim2.new(1, -20, 0, 4);
    track.Position = UDim2.new(0, 10, 1, -15);
    track.BackgroundColor3 = clrs.secondary;
    track.BorderSizePixel = 0;
    track.Parent = slider;
    
    local trackcorner = Instance.new("UICorner");
    trackcorner.CornerRadius = UDim.new(0, 2);
    trackcorner.Parent = track;
    
    -- // slider fill
    local fill = Instance.new("Frame");
    fill.Size = UDim2.new(0, 0, 1, 0);
    fill.Position = UDim2.new(0, 0, 0, 0);
    fill.BackgroundColor3 = clrs.pink;
    fill.BorderSizePixel = 0;
    fill.Parent = track;
    
    local fillcorner = Instance.new("UICorner");
    fillcorner.CornerRadius = UDim.new(0, 2);
    fillcorner.Parent = fill;
    
    -- // slider knob
    local knob = Instance.new("TextButton");
    knob.Size = UDim2.new(0, 12, 0, 12);
    knob.Position = UDim2.new(0, -6, 0.5, -6);
    knob.BackgroundColor3 = clrs.white;
    knob.BorderSizePixel = 0;
    knob.Text = "";
    knob.Parent = fill;
    
    local knobcorner = Instance.new("UICorner");
    knobcorner.CornerRadius = UDim.new(0, 6);
    knobcorner.Parent = knob;
    
    local value = default;
    local dragging = false;
    
    local function updateslider()
        local percent = (value - min) / (max - min);
        createtween(fill, twinfo.fast, {Size = UDim2.new(percent, 0, 1, 0)}):Play();
        vallbl.Text = tostring(math.floor(value + 0.5)) .. suffix;
        callback(value);
    end;
    
    local function getvaluefrommouse()
        local trackpos = track.AbsolutePosition.X;
        local tracksize = track.AbsoluteSize.X;
        local mousepos = userinput:GetMouseLocation().X;
        local percent = math.clamp((mousepos - trackpos) / tracksize, 0, 1);
        return min + (max - min) * percent;
    end;
    
    -- // drag functionality
    knob.MouseButton1Down:Connect(function()
        dragging = true;
    end);
    
    userinput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            value = getvaluefrommouse();
            updateslider();
        end;
    end);
    
    userinput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false;
        end;
    end);
    
    track.MouseButton1Down:Connect(function()
        value = getvaluefrommouse();
        updateslider();
    end);
    
    -- // hover effects
    slider.MouseEnter:Connect(function()
        createtween(slider, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
        createtween(knob, twinfo.fast, {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(1, -8, 0.5, -8)}):Play();
    end);
    
    slider.MouseLeave:Connect(function()
        createtween(slider, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
        createtween(knob, twinfo.fast, {Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(1, -6, 0.5, -6)}):Play();
    end);
    
    updateslider();
    
    return {
        Element = slider,
        SetValue = function(val)
            value = math.clamp(val, min, max);
            updateslider();
        end,
        GetValue = function()
            return value;
        end
    };
end;

function components:AddInput(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Input";
    local placeholder = cfg.Placeholder or "Enter text...";
    local callback = cfg.Callback or function() end;
    
    local input = Instance.new("Frame");
    input.Name = "Input";
    input.Size = UDim2.new(1, 0, 0, 50);
    input.BackgroundColor3 = clrs.accent;
    input.BorderSizePixel = 0;
    input.Parent = parent;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 6);
    corner.Parent = input;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.8;
    stroke.Parent = input;
    
    local lbl = Instance.new("TextLabel");
    lbl.Size = UDim2.new(1, -20, 0, 20);
    lbl.Position = UDim2.new(0, 10, 0, 5);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = clrs.white;
    lbl.TextSize = 13;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.Parent = input;
    
    local textbox = Instance.new("TextBox");
    textbox.Size = UDim2.new(1, -20, 0, 20);
    textbox.Position = UDim2.new(0, 10, 1, -25);
    textbox.BackgroundColor3 = clrs.secondary;
    textbox.BorderSizePixel = 0;
    textbox.Text = "";
    textbox.PlaceholderText = placeholder;
    textbox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120);
    textbox.TextColor3 = clrs.white;
    textbox.TextSize = 12;
    textbox.Font = Enum.Font.Gotham;
    textbox.TextXAlignment = Enum.TextXAlignment.Left;
    textbox.Parent = input;
    
    local boxcorner = Instance.new("UICorner");
    boxcorner.CornerRadius = UDim.new(0, 4);
    boxcorner.Parent = textbox;
    
    local boxpad = Instance.new("UIPadding");
    boxpad.PaddingLeft = UDim.new(0, 8);
    boxpad.PaddingRight = UDim.new(0, 8);
    boxpad.Parent = textbox;
    
    -- // focus effects
    textbox.Focused:Connect(function()
        createtween(input, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.pink, Transparency = 0.5}):Play();
        createtween(textbox, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play();
    end);
    
    textbox.FocusLost:Connect(function()
        createtween(input, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
        createtween(lbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
        createtween(stroke, twinfo.fast, {Color = clrs.separator, Transparency = 0.8}):Play();
        createtween(textbox, twinfo.fast, {BackgroundColor3 = clrs.secondary}):Play();
        callback(textbox.Text);
    end);
    
    return {
        Element = input,
        SetValue = function(val)
            textbox.Text = val;
        end,
        GetValue = function()
            return textbox.Text;
        end
    };
end;

function components:AddLabel(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Label";
    local size = cfg.Size or 13;
    local color = cfg.Color or clrs.white;
    
    local lbl = Instance.new("TextLabel");
    lbl.Name = "Label";
    lbl.Size = UDim2.new(1, 0, 0, 25);
    lbl.BackgroundTransparency = 1;
    lbl.Text = text;
    lbl.TextColor3 = color;
    lbl.TextSize = size;
    lbl.Font = Enum.Font.Gotham;
    lbl.TextXAlignment = Enum.TextXAlignment.Left;
    lbl.TextWrapped = true;
    lbl.Parent = parent;
    
    return {
        Element = lbl,
        SetText = function(newtext)
            lbl.Text = newtext;
        end,
        SetColor = function(newcolor)
            lbl.TextColor3 = newcolor;
        end
    };
end;

return components;