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
    bg = Color3.fromRGB(8, 8, 8),
    secondary = Color3.fromRGB(15, 15, 15),
    accent = Color3.fromRGB(25, 25, 25),
    pink = Color3.fromRGB(255, 105, 180),
    darkpink = Color3.fromRGB(200, 80, 140),
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(120, 120, 120),
    separator = Color3.fromRGB(40, 40, 40)
};

-- // tween configs
local twinfo = {
    fast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    med = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    slow = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
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
    
    -- // main frame with transparency
    local main = Instance.new("Frame");
    main.Name = "Main";
    main.Size = UDim2.new(0, 800, 0, 550);
    main.Position = UDim2.new(0.5, -400, 0.5, -275);
    main.BackgroundColor3 = clrs.bg;
    main.BackgroundTransparency = 0.15;
    main.BorderSizePixel = 0;
    main.Parent = gui;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 12);
    corner.Parent = main;
    
    local stroke = Instance.new("UIStroke");
    stroke.Color = clrs.separator;
    stroke.Thickness = 1;
    stroke.Transparency = 0.5;
    stroke.Parent = main;
    
    -- // gradient accent at top left
    local gradient = Instance.new("Frame");
    gradient.Name = "Gradient";
    gradient.Size = UDim2.new(0, 200, 0, 200);
    gradient.Position = UDim2.new(0, 0, 0, 0);
    gradient.BackgroundTransparency = 1;
    gradient.Parent = main;
    
    local gradientimg = Instance.new("ImageLabel");
    gradientimg.Size = UDim2.new(1, 0, 1, 0);
    gradientimg.BackgroundTransparency = 1;
    gradientimg.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png";
    gradientimg.ImageColor3 = clrs.pink;
    gradientimg.ImageTransparency = 0.85;
    gradientimg.Parent = gradient;
    
    local gradcorner = Instance.new("UICorner");
    gradcorner.CornerRadius = UDim.new(0, 12);
    gradcorner.Parent = gradientimg;
    
    local gradmask = Instance.new("UIGradient");
    gradmask.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.8),
        NumberSequenceKeypoint.new(1, 1)
    };
    gradmask.Rotation = 135;
    gradmask.Parent = gradientimg;
    
    -- // title bar (transparent)
    local titlebar = Instance.new("Frame");
    titlebar.Name = "TitleBar";
    titlebar.Size = UDim2.new(1, 0, 0, 50);
    titlebar.Position = UDim2.new(0, 0, 0, 0);
    titlebar.BackgroundTransparency = 1;
    titlebar.BorderSizePixel = 0;
    titlebar.Parent = main;
    
    -- // title text
    local titlelbl = Instance.new("TextLabel");
    titlelbl.Name = "Title";
    titlelbl.Size = UDim2.new(1, -100, 0, 25);
    titlelbl.Position = UDim2.new(0, 20, 0, 8);
    titlelbl.BackgroundTransparency = 1;
    titlelbl.Text = title;
    titlelbl.TextColor3 = clrs.white;
    titlelbl.TextSize = 18;
    titlelbl.Font = Enum.Font.GothamBold;
    titlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    titlelbl.Parent = titlebar;
    
    -- // subtitle
    local subtitlelbl = Instance.new("TextLabel");
    subtitlelbl.Name = "Subtitle";
    subtitlelbl.Size = UDim2.new(1, -100, 0, 15);
    subtitlelbl.Position = UDim2.new(0, 20, 0, 28);
    subtitlelbl.BackgroundTransparency = 1;
    subtitlelbl.Text = subtitle;
    subtitlelbl.TextColor3 = clrs.grey;
    subtitlelbl.TextSize = 12;
    subtitlelbl.Font = Enum.Font.Gotham;
    subtitlelbl.TextXAlignment = Enum.TextXAlignment.Left;
    subtitlelbl.Parent = titlebar;
    
    -- // close button
    local closebtn = Instance.new("TextButton");
    closebtn.Name = "Close";
    closebtn.Size = UDim2.new(0, 35, 0, 35);
    closebtn.Position = UDim2.new(1, -45, 0, 7.5);
    closebtn.BackgroundTransparency = 1;
    closebtn.BorderSizePixel = 0;
    closebtn.Text = "✕";
    closebtn.TextColor3 = clrs.grey;
    closebtn.TextSize = 16;
    closebtn.Font = Enum.Font.GothamBold;
    closebtn.Parent = titlebar;
    
    -- // sidebar (transparent)
    local sidebar = Instance.new("Frame");
    sidebar.Name = "Sidebar";
    sidebar.Size = UDim2.new(0, 200, 1, -60);
    sidebar.Position = UDim2.new(0, 10, 0, 60);
    sidebar.BackgroundTransparency = 1;
    sidebar.BorderSizePixel = 0;
    sidebar.Parent = main;
    
    -- // tab container
    local tabcont = Instance.new("ScrollingFrame");
    tabcont.Name = "TabContainer";
    tabcont.Size = UDim2.new(1, 0, 1, 0);
    tabcont.Position = UDim2.new(0, 0, 0, 0);
    tabcont.BackgroundTransparency = 1;
    tabcont.BorderSizePixel = 0;
    tabcont.ScrollBarThickness = 0;
    tabcont.CanvasSize = UDim2.new(0, 0, 0, 0);
    tabcont.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    tabcont.Parent = sidebar;
    
    local tablayout = Instance.new("UIListLayout");
    tablayout.SortOrder = Enum.SortOrder.LayoutOrder;
    tablayout.Padding = UDim.new(0, 5);
    tablayout.Parent = tabcont;
    
    local tabpad = Instance.new("UIPadding");
    tabpad.PaddingLeft = UDim.new(0, 5);
    tabpad.PaddingRight = UDim.new(0, 5);
    tabpad.PaddingTop = UDim.new(0, 5);
    tabpad.PaddingBottom = UDim.new(0, 5);
    tabpad.Parent = tabcont;
    
    -- // content area
    local content = Instance.new("Frame");
    content.Name = "Content";
    content.Size = UDim2.new(1, -230, 1, -70);
    content.Position = UDim2.new(0, 220, 0, 60);
    content.BackgroundTransparency = 1;
    content.BorderSizePixel = 0;
    content.Parent = main;
    
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
        createtween(closebtn, twinfo.fast, {TextColor3 = clrs.pink}):Play();
    end);
    
    closebtn.MouseLeave:Connect(function()
        createtween(closebtn, twinfo.fast, {TextColor3 = clrs.grey}):Play();
    end);
    
    closebtn.MouseButton1Click:Connect(function()
        createtween(main, twinfo.med, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play();
        wait(0.3);
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
        tabbtn.Size = UDim2.new(1, 0, 0, 40);
        tabbtn.BackgroundTransparency = 1;
        tabbtn.BorderSizePixel = 0;
        tabbtn.Text = "";
        tabbtn.Parent = tabcont;
        
        -- // tab icon (if provided)
        local iconlbl = nil;
        if icon ~= "" then
            iconlbl = Instance.new("TextLabel");
            iconlbl.Size = UDim2.new(0, 20, 0, 20);
            iconlbl.Position = UDim2.new(0, 10, 0.5, -10);
            iconlbl.BackgroundTransparency = 1;
            iconlbl.Text = icon;
            iconlbl.TextColor3 = clrs.grey;
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
        tablbl.TextColor3 = clrs.grey;
        tablbl.TextSize = 14;
        tablbl.Font = Enum.Font.Gotham;
        tablbl.TextXAlignment = Enum.TextXAlignment.Left;
        tablbl.Parent = tabbtn;
        
        -- // pink underline for selected tab
        local underline = Instance.new("Frame");
        underline.Name = "Underline";
        underline.Size = UDim2.new(0, 0, 0, 2);
        underline.Position = UDim2.new(0, 10, 1, -2);
        underline.BackgroundColor3 = clrs.pink;
        underline.BorderSizePixel = 0;
        underline.Parent = tabbtn;
        
        local undercorner = Instance.new("UICorner");
        undercorner.CornerRadius = UDim.new(0, 1);
        undercorner.Parent = underline;
        
        -- // hover underline
        local hoverline = Instance.new("Frame");
        hoverline.Name = "HoverLine";
        hoverline.Size = UDim2.new(0, 0, 0, 1);
        hoverline.Position = UDim2.new(0, 10, 1, -1);
        hoverline.BackgroundColor3 = clrs.grey;
        hoverline.BorderSizePixel = 0;
        hoverline.Parent = tabbtn;
        
        local hovercorner = Instance.new("UICorner");
        hovercorner.CornerRadius = UDim.new(0, 1);
        hovercorner.Parent = hoverline;
        
        -- // tab content
        local tabcontent = Instance.new("ScrollingFrame");
        tabcontent.Name = name .. "Content";
        tabcontent.Size = UDim2.new(1, 0, 1, 0);
        tabcontent.Position = UDim2.new(0, 0, 0, 0);
        tabcontent.BackgroundTransparency = 1;
        tabcontent.BorderSizePixel = 0;
        tabcontent.ScrollBarThickness = 2;
        tabcontent.ScrollBarImageColor3 = clrs.pink;
        tabcontent.CanvasSize = UDim2.new(0, 0, 0, 0);
        tabcontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        tabcontent.Visible = false;
        tabcontent.Parent = content;
        
        local contentlayout = Instance.new("UIListLayout");
        contentlayout.SortOrder = Enum.SortOrder.LayoutOrder;
        contentlayout.Padding = UDim.new(0, 10);
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
                createtween(tab.label, twinfo.med, {TextColor3 = clrs.grey}):Play();
                if tab.icon then
                    createtween(tab.icon, twinfo.med, {TextColor3 = clrs.grey}):Play();
                end;
                createtween(tab.underline, twinfo.med, {Size = UDim2.new(0, 0, 0, 2)}):Play();
                tab.content.Visible = false;
            end;
            
            -- // select this tab
            createtween(tablbl, twinfo.med, {TextColor3 = clrs.white}):Play();
            if iconlbl then
                createtween(iconlbl, twinfo.med, {TextColor3 = clrs.pink}):Play();
            end;
            createtween(underline, twinfo.med, {Size = UDim2.new(1, -20, 0, 2)}):Play();
            
            tabcontent.Visible = true;
            window.activetab = name;
        end;
        
        -- // hover effects
        tabbtn.MouseEnter:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.white}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.pink}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(1, -20, 0, 1)}):Play();
            end;
        end);
        
        tabbtn.MouseLeave:Connect(function()
            if window.activetab ~= name then
                createtween(tablbl, twinfo.fast, {TextColor3 = clrs.grey}):Play();
                if iconlbl then
                    createtween(iconlbl, twinfo.fast, {TextColor3 = clrs.grey}):Play();
                end;
                createtween(hoverline, twinfo.fast, {Size = UDim2.new(0, 0, 0, 1)}):Play();
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
            sep.Size = UDim2.new(1, 0, 0, 25);
            sep.BackgroundTransparency = 1;
            sep.Parent = tabcontent;
            
            if text then
                local seplbl = Instance.new("TextLabel");
                seplbl.Size = UDim2.new(1, 0, 0, 20);
                seplbl.Position = UDim2.new(0, 0, 0, 0);
                seplbl.BackgroundTransparency = 1;
                seplbl.Text = text;
                seplbl.TextColor3 = clrs.grey;
                seplbl.TextSize = 13;
                seplbl.Font = Enum.Font.GothamBold;
                seplbl.TextXAlignment = Enum.TextXAlignment.Left;
                seplbl.Parent = sep;
            end;
            
            local sepline = Instance.new("Frame");
            sepline.Size = UDim2.new(1, 0, 0, 1);
            sepline.Position = UDim2.new(0, 0, 1, -3);
            sepline.BackgroundColor3 = clrs.separator;
            sepline.BorderSizePixel = 0;
            sepline.BackgroundTransparency = 0.7;
            sepline.Parent = sep;
            
            local sepcorner = Instance.new("UICorner");
            sepcorner.CornerRadius = UDim.new(0, 1);
            sepcorner.Parent = sepline;
        end;
        
        return tabmethods;
    end;
    
    return window;
end;

return pnkui;