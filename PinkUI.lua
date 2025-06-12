local pnkui = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");
local runserv = game:GetService("RunService");
local players = game:GetService("Players");
local coregui = game:GetService("CoreGui");

local plr = players.LocalPlayer;
local mouse = plr:GetMouse();

-- // color scheme
local clrs = {
    bg = Color3.fromRGB(6, 6, 8),
    secondary = Color3.fromRGB(12, 12, 15),
    accent = Color3.fromRGB(20, 20, 25),
    pink = Color3.fromRGB(255, 105, 180),
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
    drag = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    bounce = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
};

local function createtween(obj, info, props)
    return tweenserv:Create(obj, info, props);
end;

local function creategui()
    local screenGui = Instance.new("ScreenGui");
    screenGui.Name = "PinkUI";
    screenGui.ResetOnSpawn = false;
    screenGui.IgnoreGuiInset = true;
    screenGui.Parent = coregui;
    return screenGui;
end;

function pnkui:CreateWindow(cfg)
    local cfg = cfg or {};
    local title = cfg.Title or "Pink UI";
    local subtitle = cfg.Subtitle or "by testing2122";
    
    local gui = creategui();
    
    -- // main frame with transparency
    local main = Instance.new("Frame");
    main.Name = "Main";
    main.Size = UDim2.new(0, 850, 0, 600);
    main.Position = UDim2.new(0.5, -425, 0.5, -300);
    main.BackgroundColor3 = clrs.bg;
    main.BackgroundTransparency = 0.08;
    main.BorderSizePixel = 0;
    main.Parent = gui;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 16);
    corner.Parent = main;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.4;
    stroke.Parent = main;
    
    -- // full height left gradient
    local gradient = Instance.new("Frame");
    gradient.Name = "LeftGradient";
    gradient.Size = UDim2.new(0, 300, 1, 0);
    gradient.Position = UDim2.new(0, 0, 0, 0);
    gradient.BackgroundTransparency = 1;
    gradient.Parent = main;
    
    local gradientimg = Instance.new("Frame");
    gradientimg.Size = UDim2.new(1, 0, 1, 0);
    gradientimg.BackgroundColor3 = clrs.pink;
    gradientimg.BackgroundTransparency = 0.92;
    gradientimg.BorderSizePixel = 0;
    gradientimg.Parent = gradient;
    
    local gradcorner = Instance.new("UICorner");
    gradcorner.CornerRadius = UDim.new(0, 16);
    gradcorner.Parent = gradientimg;
    
    local gradmask = Instance.new("UIGradient");
    gradmask.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.6, 0.7),
        NumberSequenceKeypoint.new(1, 1)
    };
    gradmask.Rotation = 0;
    gradmask.Parent = gradientimg;
    
    -- // corner fix for gradient
    local gradfix = Instance.new("Frame");
    gradfix.Size = UDim2.new(0, 16, 1, 0);
    gradfix.Position = UDim2.new(1, -16, 0, 0);
    gradfix.BackgroundColor3 = clrs.pink;
    gradfix.BackgroundTransparency = 0.92;
    gradfix.BorderSizePixel = 0;
    gradfix.Parent = gradientimg;
    
    local gradfix2 = Instance.new("UIGradient");
    gradfix2.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.7),
        NumberSequenceKeypoint.new(1, 1)
    };
    gradfix2.Rotation = 0;
    gradfix2.Parent = gradfix;
    
    -- // title bar (transparent)
    local titlebar = Instance.new("Frame");
    titlebar.Name = "TitleBar";
    titlebar.Size = UDim2.new(1, 0, 0, 60);
    titlebar.Position = UDim2.new(0, 0, 0, 0);
    titlebar.BackgroundTransparency = 1;
    titlebar.BorderSizePixel = 0;
    titlebar.Parent = main;
    
    -- // title text with glow effect
    local titlelbl = Instance.new("TextLabel");
    titlelbl.Name = "Title";
    titlelbl.Size = UDim2.new(1, -120, 0, 30);
    titlelbl.Position = UDim2.new(0, 25, 0, 12);
    titlelbl.BackgroundTransparency = 1;
    titlelbl.Text = title;
    titlelbl.TextColor3 = clrs.white;
    titlelbl.TextSize = 22;
    titlelbl.Font = Enum.Font.GothamBold;
    titlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    titlelbl.Parent = titlebar;
    
    -- // subtitle
    local subtitlelbl = Instance.new("TextLabel");
    subtitlelbl.Name = "Subtitle";
    subtitlelbl.Size = UDim2.new(1, -120, 0, 18);
    subtitlelbl.Position = UDim2.new(0, 25, 0, 35);
    subtitlelbl.BackgroundTransparency = 1;
    subtitlelbl.Text = subtitle;
    subtitlelbl.TextColor3 = clrs.grey;
    subtitlelbl.TextSize = 13;
    subtitlelbl.Font = Enum.Font.Gotham;
    subtitlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    subtitlelbl.Parent = titlebar;
    
    -- // minimize button
    local minbtn = Instance.new("TextButton");
    minbtn.Name = "Minimize";
    minbtn.Size = UDim2.new(0, 35, 0, 35);
    minbtn.Position = UDim2.new(1, -85, 0, 12.5);
    minbtn.BackgroundColor3 = clrs.accent;
    minbtn.BackgroundTransparency = 0.7;
    minbtn.BorderSizePixel = 0;
    minbtn.Text = "−";
    minbtn.TextColor3 = clrs.grey;
    minbtn.TextSize = 18;
    minbtn.Font = Enum.Font.GothamBold;
    minbtn.Parent = titlebar;
    
    local mincorner = Instance.new("UICorner");
    mincorner.CornerRadius = UDim.new(0, 8);
    mincorner.Parent = minbtn;
    
    -- // close button
    local closebtn = Instance.new("TextButton");
    closebtn.Name = "Close";
    closebtn.Size = UDim2.new(0, 35, 0, 35);
    closebtn.Position = UDim2.new(1, -45, 0, 12.5);
    closebtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80);
    closebtn.BackgroundTransparency = 0.7;
    closebtn.BorderSizePixel = 0;
    closebtn.Text = "✕";
    closebtn.TextColor3 = clrs.white;
    closebtn.TextSize = 14;
    closebtn.Font = Enum.Font.GothamBold;
    closebtn.Parent = titlebar;
    
    local closecorner = Instance.new("UICorner");
    closecorner.CornerRadius = UDim.new(0, 8);
    closecorner.Parent = closebtn;
    
    -- // sidebar with scrolling
    local sidebar = Instance.new("Frame");
    sidebar.Name = "Sidebar";
    sidebar.Size = UDim2.new(0, 220, 1, -75);
    sidebar.Position = UDim2.new(0, 15, 0, 70);
    sidebar.BackgroundTransparency = 1;
    sidebar.BorderSizePixel = 0;
    sidebar.Parent = main;
    
    -- // tab container with scrolling
    local tabcont = Instance.new("ScrollingFrame");
    tabcont.Name = "TabContainer";
    tabcont.Size = UDim2.new(1, 0, 1, 0);
    tabcont.Position = UDim2.new(0, 0, 0, 0);
    tabcont.BackgroundTransparency = 1;
    tabcont.BorderSizePixel = 0;
    tabcont.ScrollBarThickness = 3;
    tabcont.ScrollBarImageColor3 = clrs.pink;
    tabcont.ScrollBarImageTransparency = 0.7;
    tabcont.CanvasSize = UDim2.new(0, 0, 0, 0);
    tabcont.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    tabcont.ScrollingDirection = Enum.ScrollingDirection.Y;
    tabcont.Parent = sidebar;
    
    local tablayout = Instance.new("UIListLayout");
    tablayout.SortOrder = Enum.SortOrder.LayoutOrder;
    tablayout.Padding = UDim.new(0, 8);
    tablayout.Parent = tabcont;
    
    local tabpad = Instance.new("UIPadding");
    tabpad.PaddingLeft = UDim.new(0, 8);
    tabpad.PaddingRight = UDim.new(0, 8);
    tabpad.PaddingTop = UDim.new(0, 8);
    tabpad.PaddingBottom = UDim.new(0, 8);
    tabpad.Parent = tabcont;
    
    -- // content area
    local content = Instance.new("Frame");
    content.Name = "Content";
    content.Size = UDim2.new(1, -255, 1, -85);
    content.Position = UDim2.new(0, 245, 0, 75);
    content.BackgroundTransparency = 1;
    content.BorderSizePixel = 0;
    content.Parent = main;
    
    -- // vertical separator
    local separator = Instance.new("Frame");
    separator.Name = "VerticalSeparator";
    separator.Size = UDim2.new(0, 1, 1, -75);
    separator.Position = UDim2.new(0, 235, 0, 70);
    separator.BackgroundColor3 = clrs.separator;
    separator.BorderSizePixel = 0;
    separator.BackgroundTransparency = 0.5;
    separator.Parent = main;
    
    local sepcorner = Instance.new("UICorner");
    sepcorner.CornerRadius = UDim.new(0, 1);
    sepcorner.Parent = separator;
    
    -- // drag functionality
    local dragging = false;
    local dragstart = nil;
    local startpos = nil;
    
    titlebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true;
            dragstart = input.Position;
            startpos = main.Position;
        end;
    end);
    
    userinput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragstart;
            local newpos = UDim2.new(startpos.X.Scale, startpos.X.Offset + delta.X, startpos.Y.Scale, startpos.Y.Offset + delta.Y);
            createtween(main, twinfo.drag, {Position = newpos}):Play();
        end;
    end);
    
    userinput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false;
        end;
    end);
    
    -- // button hover effects
    minbtn.MouseEnter:Connect(function()
        createtween(minbtn, twinfo.fast, {BackgroundTransparency = 0.3, TextColor3 = clrs.white}):Play();
    end);
    
    minbtn.MouseLeave:Connect(function()
        createtween(minbtn, twinfo.fast, {BackgroundTransparency = 0.7, TextColor3 = clrs.grey}):Play();
    end);
    
    closebtn.MouseEnter:Connect(function()
        createtween(closebtn, twinfo.fast, {BackgroundTransparency = 0.3}):Play();
    end);
    
    closebtn.MouseLeave:Connect(function()
        createtween(closebtn, twinfo.fast, {BackgroundTransparency = 0.7}):Play();
    end);
    
    closebtn.MouseButton1Click:Connect(function()
        createtween(main, twinfo.bounce, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play();
        wait(0.6);
        gui:Destroy();
    end);
    
    local window = {};
    window.tabs = {};
    window.activetab = nil;
    
    function window:CreateTab(cfg)
        local cfg = cfg or {};
        local name = cfg.Name or "Tab";
        local icon = cfg.Icon or "";
        
        -- // tab button (no background)
        local tabbtn = Instance.new("TextButton");
        tabbtn.Name = name;
        tabbtn.Size = UDim2.new(1, 0, 0, 45);
        tabbtn.BackgroundTransparency = 1;
        tabbtn.BorderSizePixel = 0;
        tabbtn.Text = "";
        tabbtn.Parent = tabcont;
        
        -- // tab icon (if provided)
        local iconlbl = nil;
        if icon ~= "" then
            iconlbl = Instance.new("TextLabel");
            iconlbl.Size = UDim2.new(0, 24, 0, 24);
            iconlbl.Position = UDim2.new(0, 12, 0.5, -12);
            iconlbl.BackgroundTransparency = 1;
            iconlbl.Text = icon;
            iconlbl.TextColor3 = clrs.darkgrey;
            iconlbl.TextSize = 16;
            iconlbl.Font = Enum.Font.Gotham;
            iconlbl.Parent = tabbtn;
        end;
        
        -- // tab label
        local tablbl = Instance.new("TextLabel");
        tablbl.Size = UDim2.new(1, iconlbl and -50 or -25, 1, 0);
        tablbl.Position = UDim2.new(0, iconlbl and 42 or 12, 0, 0);
        tablbl.BackgroundTransparency = 1;
        tablbl.Text = name;
        tablbl.TextColor3 = clrs.darkgrey;
        tablbl.TextSize = 15;
        tablbl.Font = Enum.Font.GothamMedium;
        tablbl.TextXAlignment = Enum.TextXAlignment.Left;
        tablbl.Parent = tabbtn;
        
        -- // get text bounds for underline width
        local textbounds = game:GetService("TextService"):GetTextSize(name, 15, Enum.Font.GothamMedium, Vector2.new(200, 50));
        
        -- // pink underline for selected tab (matches text width)
        local underline = Instance.new("Frame");
        underline.Name = "Underline";
        underline.Size = UDim2.new(0, 0, 0, 3);
        underline.Position = UDim2.new(0, iconlbl and 42 or 12, 1, -5);
        underline.BackgroundColor3 = clrs.pink;
        underline.BorderSizePixel = 0;
        underline.Parent = tabbtn;
        
        local undercorner = Instance.new("UICorner");
        undercorner.CornerRadius = UDim.new(0, 2);
        undercorner.Parent = underline;
        
        -- // hover underline (matches text width)
        local hoverline = Instance.new("Frame");
        hoverline.Name = "HoverLine";
        hoverline.Size = UDim2.new(0, 0, 0, 2);
        hoverline.Position = UDim2.new(0, iconlbl and 42 or 12, 1, -3);
        hoverline.BackgroundColor3 = clrs.grey;
        hoverline.BorderSizePixel = 0;
        hoverline.Parent = tabbtn;
        
        local hovercorner = Instance.new("UICorner");
        hovercorner.CornerRadius = UDim.new(0, 1);
        hovercorner.Parent = hoverline;
        
        -- // tab content with better styling
        local tabcontent = Instance.new("ScrollingFrame");
        tabcontent.Name = name .. "Content";
        tabcontent.Size = UDim2.new(1, 0, 1, 0);
        tabcontent.Position = UDim2.new(0, 0, 0, 0);
        tabcontent.BackgroundTransparency = 1;
        tabcontent.BorderSizePixel = 0;
        tabcontent.ScrollBarThickness = 4;
        tabcontent.ScrollBarImageColor3 = clrs.pink;
        tabcontent.ScrollBarImageTransparency = 0.6;
        tabcontent.CanvasSize = UDim2.new(0, 0, 0, 0);
        tabcontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        tabcontent.Visible = false;
        tabcontent.Parent = content;
        
        local contentlayout = Instance.new("UIListLayout");
        contentlayout.SortOrder = Enum.SortOrder.LayoutOrder;
        contentlayout.Padding = UDim.new(0, 12);
        contentlayout.Parent = tabcontent;
        
        local contentpad = Instance.new("UIPadding");
        contentpad.PaddingLeft = UDim.new(0, 20);
        contentpad.PaddingRight = UDim.new(0, 20);
        contentpad.PaddingTop = UDim.new(0, 20);
        contentpad.PaddingBottom = UDim.new(0, 20);
        contentpad.Parent = tabcontent;
        
        -- // tab functionality
        local function selecttab()
            -- // deselect all tabs
            for _, tab in pairs(window.tabs) do
                createtween(tab.label, twinfo.med, {TextColor3 = clrs.darkgrey}):Play();
                if tab.icon then
                    createtween(tab.icon, twinfo.med, {TextColor3 = clrs.darkgrey}):Play();
                end;
                createtween(tab.underline, twinfo.med, {Size = UDim2.new(0, 0, 0, 3)}):Play();
                tab.content.Visible = false;
            end;
            
            -- // select this tab
            createtween(tablbl, twinfo.med, {TextColor3 = clrs.white}):Play();
            if iconlbl then
                createtween(iconlbl, twinfo.med, {TextColor3 = clrs.lightpink}):Play();
            end;
            createtween(underline, twinfo.med, {Size = UDim2.new(0, textbounds.X, 0, 3)}):Play();
            
            tabcontent.Visible = true;
            window.activetab = name;
        end;
        
        -- // hover effects
        tabbtn.MouseEnter:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.lightpink}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(0, textbounds.X, 0, 2)}):Play();
            end;
        end);
        
        tabbtn.MouseLeave:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.darkgrey}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.darkgrey}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(0, 0, 0, 2)}):Play();
            end;
        end);
        
        tabbtn.MouseButton1Click:Connect(selecttab);
        
        local tab = {
            button = tabbtn,
            label = tablbl,
            icon = iconlbl,
            underline = underline,
            content = tabcontent,
            name = name
        };
        
        window.tabs[name] = tab;
        
        -- // select first tab
        if #window.tabs == 1 or window.activetab == nil then
            selecttab();
        end;
        
        -- // tab methods
        local tabmethods = {};
        
        function tabmethods:AddSeparator(text)
            local sep = Instance.new("Frame");
            sep.Name = "Separator";
            sep.Size = UDim2.new(1, 0, 0, 35);
            sep.BackgroundTransparency = 1;
            sep.Parent = tabcontent;
            
            if text then
                local seplbl = Instance.new("TextLabel");
                seplbl.Size = UDim2.new(1, 0, 0, 25);
                seplbl.Position = UDim2.new(0, 0, 0, 0);
                seplbl.BackgroundTransparency = 1;
                seplbl.Text = text;
                seplbl.TextColor3 = clrs.lightpink;
                seplbl.TextSize = 14;
                seplbl.Font = Enum.Font.GothamBold;
                seplbl.TextXAlignment = Enum.TextXAlignment.Left;
                seplbl.Parent = sep;
            end;
            
            local sepline = Instance.new("Frame");
            sepline.Size = UDim2.new(1, 0, 0, 2);
            sepline.Position = UDim2.new(0, 0, 1, -8);
            sepline.BackgroundTransparency = 1;
            sepline.BorderSizePixel = 0;
            sepline.Parent = sep;
            
            local sepgrad = Instance.new("UIGradient");
            sepgrad.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, clrs.pink),
                ColorSequenceKeypoint.new(0.5, clrs.separator),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
            };
            sepgrad.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.3),
                NumberSequenceKeypoint.new(0.7, 0.8),
                NumberSequenceKeypoint.new(1, 1)
            };
            sepgrad.Rotation = 0;
            sepgrad.Parent = sepline;
            
            sepline.BackgroundColor3 = clrs.pink;
            
            local sepcorner = Instance.new("UICorner");
            sepcorner.CornerRadius = UDim.new(0, 1);
            sepcorner.Parent = sepline;
        end;
        
        return tabmethods;
    end;
    
    return window;
end;

return pnkui;