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
    local enableGradient = cfg.TitleGradient ~= false;
    
    local gui = creategui();
    
    -- // main frame with transparency
    local main = Instance.new("Frame");
    main.Name = "Main";
    main.Size = UDim2.new(0, 900, 0, 650);
    main.Position = UDim2.new(0.5, -450, 0.5, -325);
    main.BackgroundColor3 = clrs.bg;
    main.BackgroundTransparency = 0.05;
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
    
    -- // title bar
    local titlebar = Instance.new("Frame");
    titlebar.Name = "TitleBar";
    titlebar.Size = UDim2.new(1, 0, 0, 70);
    titlebar.Position = UDim2.new(0, 0, 0, 0);
    titlebar.BackgroundTransparency = 1;
    titlebar.BorderSizePixel = 0;
    titlebar.Parent = main;
    
    -- // title text with gradient
    local titlelbl = Instance.new("TextLabel");
    titlelbl.Name = "Title";
    titlelbl.Size = UDim2.new(1, -150, 0, 30);
    titlelbl.Position = UDim2.new(0, 25, 0, 15);
    titlelbl.BackgroundTransparency = 1;
    titlelbl.Text = title;
    titlelbl.TextColor3 = clrs.white;
    titlelbl.TextSize = 22;
    titlelbl.Font = Enum.Font.GothamBold;
    titlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    titlelbl.Parent = titlebar;
    
    -- // animated gradient for title
    local titlegrad = nil;
    local gradientEnabled = enableGradient;
    if enableGradient then
        titlegrad = Instance.new("UIGradient");
        titlegrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, clrs.pink),
            ColorSequenceKeypoint.new(1, clrs.lightpink)
        };
        titlegrad.Parent = titlelbl;
        
        -- // animate gradient rotation
        spawn(function()
            while titlelbl.Parent and gradientEnabled do
                createtween(titlegrad, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Rotation = 360
                }):Play();
                wait(3);
                if titlegrad.Parent then
                    titlegrad.Rotation = 0;
                end;
            end;
        end);
    end;
    
    -- // gradient toggle button
    local gradToggle = Instance.new("TextButton");
    gradToggle.Size = UDim2.new(0, 25, 0, 25);
    gradToggle.Position = UDim2.new(1, -155, 0, 22.5);
    gradToggle.BackgroundColor3 = clrs.accent;
    gradToggle.BorderSizePixel = 0;
    gradToggle.Text = "G";
    gradToggle.TextColor3 = gradientEnabled and clrs.pink or clrs.grey;
    gradToggle.TextSize = 12;
    gradToggle.Font = Enum.Font.GothamBold;
    gradToggle.Parent = titlebar;
    
    local gradCorner = Instance.new("UICorner");
    gradCorner.CornerRadius = UDim.new(0, 6);
    gradCorner.Parent = gradToggle;
    
    gradToggle.MouseButton1Click:Connect(function()
        gradientEnabled = not gradientEnabled;
        if gradientEnabled then
            if not titlegrad then
                titlegrad = Instance.new("UIGradient");
                titlegrad.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, clrs.pink),
                    ColorSequenceKeypoint.new(1, clrs.lightpink)
                };
            end;
            titlegrad.Parent = titlelbl;
            gradToggle.TextColor3 = clrs.pink;
        else
            if titlegrad then
                titlegrad.Parent = nil;
            end;
            titlelbl.TextColor3 = clrs.white;
            gradToggle.TextColor3 = clrs.grey;
        end;
    end);
    
    -- // subtitle
    local subtitlelbl = Instance.new("TextLabel");
    subtitlelbl.Name = "Subtitle";
    subtitlelbl.Size = UDim2.new(1, -150, 0, 18);
    subtitlelbl.Position = UDim2.new(0, 25, 0, 38);
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
    minbtn.Position = UDim2.new(1, -85, 0, 17.5);
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
    closebtn.Position = UDim2.new(1, -45, 0, 17.5);
    closebtn.BackgroundColor3 = clrs.red;
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
    
    -- // top separator line
    local topsep = Instance.new("Frame");
    topsep.Name = "TopSeparator";
    topsep.Size = UDim2.new(1, -50, 0, 1);
    topsep.Position = UDim2.new(0, 25, 0, 68);
    topsep.BackgroundColor3 = clrs.separator;
    topsep.BorderSizePixel = 0;
    topsep.Parent = main;
    
    local topsepcorner = Instance.new("UICorner");
    topsepcorner.CornerRadius = UDim.new(0, 1);
    topsepcorner.Parent = topsep;
    
    -- // sidebar with scrolling
    local sidebar = Instance.new("Frame");
    sidebar.Name = "Sidebar";
    sidebar.Size = UDim2.new(0, 220, 1, -85);
    sidebar.Position = UDim2.new(0, 15, 0, 80);
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
    content.Size = UDim2.new(1, -265, 1, -95);
    content.Position = UDim2.new(0, 255, 0, 85);
    content.BackgroundTransparency = 1;
    content.BorderSizePixel = 0;
    content.Parent = main;
    
    -- // vertical separator
    local separator = Instance.new("Frame");
    separator.Name = "VerticalSeparator";
    separator.Size = UDim2.new(0, 1, 1, -85);
    separator.Position = UDim2.new(0, 245, 0, 80);
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
        
        -- // tab button
        local tabbtn = Instance.new("TextButton");
        tabbtn.Name = name;
        tabbtn.Size = UDim2.new(1, 0, 0, 45);
        tabbtn.BackgroundTransparency = 1;
        tabbtn.BorderSizePixel = 0;
        tabbtn.Text = "";
        tabbtn.Parent = tabcont;
        
        -- // tab icon
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
        
        -- // pink underline for selected tab
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
        
        -- // hover underline (grey not white)
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
        
        -- // tab content - single scrolling frame
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
        
        -- // list layout for components
        local listlayout = Instance.new("UIListLayout");
        listlayout.SortOrder = Enum.SortOrder.LayoutOrder;
        listlayout.Padding = UDim.new(0, 12);
        listlayout.Parent = tabcontent;
        
        local contentpad = Instance.new("UIPadding");
        contentpad.PaddingLeft = UDim.new(0, 15);
        contentpad.PaddingRight = UDim.new(0, 15);
        contentpad.PaddingTop = UDim.new(0, 15);
        contentpad.PaddingBottom = UDim.new(0, 15);
        contentpad.Parent = tabcontent;
        
        -- // tab functionality
        local function selecttab()
            -- // deselect all tabs first
            for _, tab in pairs(window.tabs) do
                createtween(tab.label, twinfo.med, {TextColor3 = clrs.darkgrey}):Play();
                if tab.icon then
                    createtween(tab.icon, twinfo.med, {TextColor3 = clrs.darkgrey}):Play();
                end;
                createtween(tab.underline, twinfo.med, {Size = UDim2.new(0, 0, 0, 3)}):Play();
                createtween(tab.hoverline, twinfo.fast, {Size = UDim2.new(0, 0, 0, 2)}):Play();
                tab.content.Visible = false;
            end;
            
            -- // select this tab
            createtween(tablbl, twinfo.med, {TextColor3 = clrs.pink}):Play();
            if iconlbl then
                createtween(iconlbl, twinfo.med, {TextColor3 = clrs.pink}):Play();
            end;
            createtween(underline, twinfo.med, {Size = UDim2.new(0, textbounds.X, 0, 3)}):Play();
            
            tabcontent.Visible = true;
            window.activetab = name;
        end;
        
        -- // hover effects (fixed to prevent white underline on selected tabs)
        tabbtn.MouseEnter:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.lightpink}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.lightpink}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(0, textbounds.X * 0.8, 0, 2)}):Play();
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
            hoverline = hoverline,
            content = tabcontent,
            name = name
        };
        
        window.tabs[name] = tab;
        
        -- // select first tab
        if window.activetab == nil then
            selecttab();
        end;
        
        -- // tab methods
        local tabmethods = {};
        tabmethods.content = tabcontent;
        
        function tabmethods:CreateSection(sectionname)
            local section = Instance.new("Frame");
            section.Name = sectionname;
            section.Size = UDim2.new(1, 0, 0, 280);
            section.BackgroundColor3 = clrs.secondary;
            section.BackgroundTransparency = 0.1;
            section.BorderSizePixel = 0;
            section.LayoutOrder = #tabcontent:GetChildren();
            section.Parent = tabcontent;
            
            local sectioncorner = Instance.new("UICorner");
            sectioncorner.CornerRadius = UDim.new(0, 12);
            sectioncorner.Parent = section;
            
            local sectionstroke = Instance.new("UIStroke");
            sectionstroke.Color = clrs.pink;
            sectionstroke.Thickness = 1;
            sectionstroke.Transparency = 0.6;
            sectionstroke.Parent = section;
            
            -- // section title
            local sectiontitle = Instance.new("TextLabel");
            sectiontitle.Size = UDim2.new(1, -20, 0, 30);
            sectiontitle.Position = UDim2.new(0, 10, 0, 10);
            sectiontitle.BackgroundTransparency = 1;
            sectiontitle.Text = sectionname;
            sectiontitle.TextColor3 = clrs.lightpink;
            sectiontitle.TextSize = 16;
            sectiontitle.Font = Enum.Font.GothamBold;
            sectiontitle.TextXAlignment = Enum.TextXAlignment.Left;
            sectiontitle.Parent = section;
            
            -- // section content
            local sectioncontent = Instance.new("ScrollingFrame");
            sectioncontent.Size = UDim2.new(1, -20, 1, -50);
            sectioncontent.Position = UDim2.new(0, 10, 0, 40);
            sectioncontent.BackgroundTransparency = 1;
            sectioncontent.BorderSizePixel = 0;
            sectioncontent.ScrollBarThickness = 2;
            sectioncontent.ScrollBarImageColor3 = clrs.pink;
            sectioncontent.ScrollBarImageTransparency = 0.8;
            sectioncontent.CanvasSize = UDim2.new(0, 0, 0, 0);
            sectioncontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            sectioncontent.Parent = section;
            
            local sectionlayout = Instance.new("UIListLayout");
            sectionlayout.SortOrder = Enum.SortOrder.LayoutOrder;
            sectionlayout.Padding = UDim.new(0, 8);
            sectionlayout.Parent = sectioncontent;
            
            local sectionpad = Instance.new("UIPadding");
            sectionpad.PaddingLeft = UDim.new(0, 8);
            sectionpad.PaddingRight = UDim.new(0, 8);
            sectionpad.PaddingTop = UDim.new(0, 8);
            sectionpad.PaddingBottom = UDim.new(0, 8);
            sectionpad.Parent = sectioncontent;
            
            return sectioncontent;
        end;
        
        function tabmethods:AddSeparator()
            local sepframe = Instance.new("Frame");
            sepframe.Size = UDim2.new(1, 0, 0, 15);
            sepframe.BackgroundTransparency = 1;
            sepframe.LayoutOrder = #tabcontent:GetChildren();
            sepframe.Parent = tabcontent;
            
            local sep = Instance.new("Frame");
            sep.Size = UDim2.new(1, -20, 0, 1);
            sep.Position = UDim2.new(0, 10, 0.5, -1);
            sep.BackgroundColor3 = clrs.separator;
            sep.BorderSizePixel = 0;
            sep.Parent = sepframe;
            
            local sepcorner = Instance.new("UICorner");
            sepcorner.CornerRadius = UDim.new(0, 1);
            sepcorner.Parent = sep;
            
            return sepframe;
        end;
        
        return tabmethods;
    end;
    
    return window;
end;

return pnkui;