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
    bg = Color3.fromRGB(15, 15, 15),
    secondary = Color3.fromRGB(35, 35, 35),
    accent = Color3.fromRGB(60, 60, 60),
    pink = Color3.fromRGB(255, 105, 180),
    darkpink = Color3.fromRGB(200, 80, 140),
    white = Color3.fromRGB(255, 255, 255),
    separator = Color3.fromRGB(80, 80, 80)
};

-- // tween configs
local twinfo = {
    fast = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    drag = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
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
    
    -- // main frame
    local main = Instance.new("Frame");
    main.Name = "Main";
    main.Size = UDim2.new(0, 750, 0, 500);
    main.Position = UDim2.new(0.5, -375, 0.5, -250);
    main.BackgroundColor3 = clrs.bg;
    main.BorderSizePixel = 0;
    main.Parent = gui;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = main;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.accent;
    stroke.Thickness = 1;
    stroke.Parent = main;
    
    -- // title bar
    local titlebar = Instance.new("Frame");
    titlebar.Name = "TitleBar";
    titlebar.Size = UDim2.new(1, 0, 0, 45);
    titlebar.Position = UDim2.new(0, 0, 0, 0);
    titlebar.BackgroundColor3 = clrs.secondary;
    titlebar.BorderSizePixel = 0;
    titlebar.Parent = main;
    
    local titlecorner = Instance.new("UICorner");
    titlecorner.CornerRadius = UDim.new(0, 8);
    titlecorner.Parent = titlebar;
    
    -- // fix corner overlap
    local cornerfix = Instance.new("Frame");
    cornerfix.Size = UDim2.new(1, 0, 0, 8);
    cornerfix.Position = UDim2.new(0, 0, 1, -8);
    cornerfix.BackgroundColor3 = clrs.secondary;
    cornerfix.BorderSizePixel = 0;
    cornerfix.Parent = titlebar;
    
    -- // title text
    local titlelbl = Instance.new("TextLabel");
    titlelbl.Name = "Title";
    titlelbl.Size = UDim2.new(1, -100, 1, 0);
    titlelbl.Position = UDim2.new(0, 15, 0, 0);
    titlelbl.BackgroundTransparency = 1;
    titlelbl.Text = title;
    titlelbl.TextColor3 = clrs.white;
    titlelbl.TextSize = 16;
    titlelbl.Font = Enum.Font.GothamBold;
    titlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    titlelbl.Parent = titlebar;
    
    -- // subtitle
    local subtitlelbl = Instance.new("TextLabel");
    subtitlelbl.Name = "Subtitle";
    subtitlelbl.Size = UDim2.new(1, -100, 0, 12);
    subtitlelbl.Position = UDim2.new(0, 15, 0, 20);
    subtitlelbl.BackgroundTransparency = 1;
    subtitlelbl.Text = subtitle;
    subtitlelbl.TextColor3 = Color3.fromRGB(150, 150, 150);
    subtitlelbl.TextSize = 11;
    subtitlelbl.Font = Enum.Font.Gotham;
    subtitlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    subtitlelbl.Parent = titlebar;
    
    -- // close button
    local closebtn = Instance.new("TextButton");
    closebtn.Name = "Close";
    closebtn.Size = UDim2.new(0, 30, 0, 30);
    closebtn.Position = UDim2.new(1, -40, 0, 7.5);
    closebtn.BackgroundColor3 = Color3.fromRGB(255, 95, 95);
    closebtn.BorderSizePixel = 0;
    closebtn.Text = "×";
    closebtn.TextColor3 = clrs.white;
    closebtn.TextSize = 18;
    closebtn.Font = Enum.Font.GothamBold;
    closebtn.Parent = titlebar;
    
    local closecorner = Instance.new("UICorner");
    closecorner.CornerRadius = UDim.new(0, 4);
    closecorner.Parent = closebtn;
    
    -- // sidebar
    local sidebar = Instance.new("Frame");
    sidebar.Name = "Sidebar";
    sidebar.Size = UDim2.new(0, 180, 1, -45);
    sidebar.Position = UDim2.new(0, 0, 0, 45);
    sidebar.BackgroundColor3 = clrs.secondary;
    sidebar.BorderSizePixel = 0;
    sidebar.Parent = main;
    
    local sidecorner = Instance.new("UICorner");
    sidecorner.CornerRadius = UDim.new(0, 8);
    sidecorner.Parent = sidebar;
    
    -- // fix sidebar corner
    local sidefix = Instance.new("Frame");
    sidefix.Size = UDim2.new(0, 8, 1, 0);
    sidefix.Position = UDim2.new(1, -8, 0, 0);
    sidefix.BackgroundColor3 = clrs.secondary;
    sidefix.BorderSizePixel = 0;
    sidefix.Parent = sidebar;
    
    local sidefix2 = Instance.new("Frame");
    sidefix2.Size = UDim2.new(1, 0, 0, 8);
    sidefix2.Position = UDim2.new(0, 0, 0, 0);
    sidefix2.BackgroundColor3 = clrs.secondary;
    sidefix2.BorderSizePixel = 0;
    sidefix2.Parent = sidebar;
    
    -- // tab container
    local tabcont = Instance.new("ScrollingFrame");
    tabcont.Name = "TabContainer";
    tabcont.Size = UDim2.new(1, 0, 1, -10);
    tabcont.Position = UDim2.new(0, 0, 0, 5);
    tabcont.BackgroundTransparency = 1;
    tabcont.BorderSizePixel = 0;
    tabcont.ScrollBarThickness = 0;
    tabcont.CanvasSize = UDim2.new(0, 0, 0, 0);
    tabcont.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    tabcont.Parent = sidebar;
    
    local tablayout = Instance.new("UIListLayout");
    tablayout.SortOrder = Enum.SortOrder.LayoutOrder;
    tablayout.Padding = UDim.new(0, 2);
    tablayout.Parent = tabcont;
    
    local tabpad = Instance.new("UIPadding");
    tabpad.PaddingLeft = UDim.new(0, 8);
    tabpad.PaddingRight = UDim.new(0, 8);
    tabpad.PaddingTop = UDim.new(0, 5);
    tabpad.PaddingBottom = UDim.new(0, 5);
    tabpad.Parent = tabcont;
    
    -- // content area
    local content = Instance.new("Frame");
    content.Name = "Content";
    content.Size = UDim2.new(1, -185, 1, -50);
    content.Position = UDim2.new(0, 185, 0, 50);
    content.BackgroundColor3 = clrs.bg;
    content.BorderSizePixel = 0;
    content.Parent = main;
    
    -- // separator line
    local separator = Instance.new("Frame");
    separator.Name = "Separator";
    separator.Size = UDim2.new(0, 1, 1, -45);
    separator.Position = UDim2.new(0, 180, 0, 45);
    separator.BackgroundColor3 = clrs.separator;
    separator.BorderSizePixel = 0;
    separator.Parent = main;
    
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
    
    -- // close button functionality
    closebtn.MouseEnter:Connect(function()
        createtween(closebtn, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(255, 120, 120)}):Play();
    end);
    
    closebtn.MouseLeave:Connect(function()
        createtween(closebtn, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(255, 95, 95)}):Play();
    end);
    
    closebtn.MouseButton1Click:Connect(function()
        createtween(main, twinfo.med, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play();
        wait(0.25);
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
        tabbtn.Size = UDim2.new(1, 0, 0, 35);
        tabbtn.BackgroundColor3 = clrs.accent;
        tabbtn.BorderSizePixel = 0;
        tabbtn.Text = "";
        tabbtn.Parent = tabcont;
        
        local tabcorner = Instance.new("UICorner");
        tabcorner.CornerRadius = UDim.new(0, 6);
        tabcorner.Parent = tabbtn;
        
        -- // tab icon (if provided)
        local iconlbl = nil;
        if icon ~= "" then
            iconlbl = Instance.new("TextLabel");
            iconlbl.Size = UDim2.new(0, 20, 0, 20);
            iconlbl.Position = UDim2.new(0, 10, 0.5, -10);
            iconlbl.BackgroundTransparency = 1;
            iconlbl.Text = icon;
            iconlbl.TextColor3 = clrs.white;
            iconlbl.TextSize = 14;
            iconlbl.Font = Enum.Font.Gotham;
            iconlbl.Parent = tabbtn;
        end;
        
        -- // tab label
        local tablbl = Instance.new("TextLabel");
        tablbl.Size = UDim2.new(1, iconlbl and -40 or -20, 1, 0);
        tablbl.Position = UDim2.new(0, iconlbl and 35 or 10, 0, 0);
        tablbl.BackgroundTransparency = 1;
        tablbl.Text = name;
        tablbl.TextColor3 = clrs.white;
        tablbl.TextSize = 13;
        tablbl.Font = Enum.Font.Gotham;
        tablbl.TextXAlignment = Enum.TextXAlignment.Left;
        tablbl.Parent = tabbtn;
        
        -- // tab content
        local tabcontent = Instance.new("ScrollingFrame");
        tabcontent.Name = name .. "Content";
        tabcontent.Size = UDim2.new(1, 0, 1, 0);
        tabcontent.Position = UDim2.new(0, 0, 0, 0);
        tabcontent.BackgroundTransparency = 1;
        tabcontent.BorderSizePixel = 0;
        tabcontent.ScrollBarThickness = 3;
        tabcontent.ScrollBarImageColor3 = clrs.pink;
        tabcontent.CanvasSize = UDim2.new(0, 0, 0, 0);
        tabcontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        tabcontent.Visible = false;
        tabcontent.Parent = content;
        
        local contentlayout = Instance.new("UIListLayout");
        contentlayout.SortOrder = Enum.SortOrder.LayoutOrder;
        contentlayout.Padding = UDim.new(0, 8);
        contentlayout.Parent = tabcontent;
        
        local contentpad = Instance.new("UIPadding");
        contentpad.PaddingLeft = UDim.new(0, 15);
        contentpad.PaddingRight = UDim.new(0, 15);
        contentpad.PaddingTop = UDim.new(0, 15);
        contentpad.PaddingBottom = UDim.new(0, 15);
        contentpad.Parent = tabcontent;
        
        -- // tab functionality
        local function selecttab()
            -- // deselect all tabs
            for _, tab in pairs(window.tabs) do
                createtween(tab.button, twinfo.med, {BackgroundColor3 = clrs.accent}):Play();
                createtween(tab.label, twinfo.med, {TextColor3 = clrs.white}):Play();
                if tab.icon then
                    createtween(tab.icon, twinfo.med, {TextColor3 = clrs.white}):Play();
                end;
                tab.content.Visible = false;
            end;
            
            -- // select this tab
            createtween(tabbtn, twinfo.med, {BackgroundColor3 = clrs.pink}):Play();
            createtween(tablbl, twinfo.med, {TextColor3 = clrs.white}):Play();
            if iconlbl then
                createtween(iconlbl, twinfo.med, {TextColor3 = clrs.white}):Play();
            end;
            
            tabcontent.Visible = true;
            window.activetab = name;
        end;
        
        -- // hover effects
        tabbtn.MouseEnter:Connect(function()
            if window.activetab ~= name then
                createtween(tabbtn, twinfo.fast, {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play();
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
                end;
            end;
        end);
        
        tabbtn.MouseLeave:Connect(function()
            if window.activetab ~= name then
                createtween(tabbtn, twinfo.fast, {BackgroundColor3 = clrs.accent}):Play();
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
                end;
            end;
        end);
        
        tabbtn.MouseButton1Click:Connect(selecttab);
        
        local tab = {
            button = tabbtn,
            label = tablbl,
            icon = iconlbl,
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
            sep.Size = UDim2.new(1, 0, 0, 20);
            sep.BackgroundTransparency = 1;
            sep.Parent = tabcontent;
            
            if text then
                local seplbl = Instance.new("TextLabel");
                seplbl.Size = UDim2.new(1, 0, 1, 0);
                seplbl.BackgroundTransparency = 1;
                seplbl.Text = text;
                seplbl.TextColor3 = clrs.separator;
                seplbl.TextSize = 12;
                seplbl.Font = Enum.Font.GothamBold;
                seplbl.TextXAlignment = Enum.TextXAlignment.Left;
                seplbl.Parent = sep;
            end;
            
            local sepline = Instance.new("Frame");
            sepline.Size = UDim2.new(1, 0, 0, 1);
            sepline.Position = UDim2.new(0, 0, 1, -1);
            sepline.BackgroundColor3 = clrs.separator;
            sepline.BorderSizePixel = 0;
            sepline.Parent = sep;
        end;
        
        return tabmethods;
    end;
    
    return window;
end;

return pnkui;