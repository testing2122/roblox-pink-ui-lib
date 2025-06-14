local pnkui = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");
local runserv = game:GetService("RunService");
local players = game:GetService("Players");
local coregui = game:GetService("CoreGui");

local plr = players.LocalPlayer;
local mouse = plr:GetMouse();

-- Load GreetingSystem
local GreetingSystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/GreetingSystem.lua"))();

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

-- // store UI elements for theme updates
local uiElements = {
    boxTitles = {},
    underlines = {},
    hoverlines = {},
    tabButtons = {},
    tabIcons = {},
    tabLabels = {},
    strokes = {}, -- // add strokes array for box borders
    scrollbars = {}, -- // add scrollbars array for scrollbar colors
    gradientButton = nil,
    titleGradient = nil
};

-- // theme application function
function pnkui:ApplyTheme(newTheme)
    -- Update color table
    for key, value in pairs(newTheme) do
        clrs[key] = value;
    end;
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    
    -- Update box titles to use theme color
    for _, titleElement in pairs(uiElements.boxTitles) do
        local tween = tweenserv:Create(titleElement, tweenInfo, {TextColor3 = clrs.pink});
        tween:Play();
    end;
    
    -- Update underlines
    for _, underline in pairs(uiElements.underlines) do
        local tween = tweenserv:Create(underline, tweenInfo, {BackgroundColor3 = clrs.pink});
        tween:Play();
    end;
    
    -- Update hover lines
    for _, hoverline in pairs(uiElements.hoverlines) do
        local tween = tweenserv:Create(hoverline, tweenInfo, {BackgroundColor3 = clrs.pink});
        tween:Play();
    end;
    
    -- Update tab buttons
    for _, button in pairs(uiElements.tabButtons) do
        local tween = tweenserv:Create(button, tweenInfo, {BackgroundColor3 = clrs.secondary});
        tween:Play();
    end;
    
    -- Update tab icons
    for _, icon in pairs(uiElements.tabIcons) do
        local tween = tweenserv:Create(icon, tweenInfo, {TextColor3 = clrs.grey});
        tween:Play();
    end;
    
    -- Update tab labels
    for _, label in pairs(uiElements.tabLabels) do
        local tween = tweenserv:Create(label, tweenInfo, {TextColor3 = clrs.grey});
        tween:Play();
    end;
    
    -- Update strokes
    for _, stroke in pairs(uiElements.strokes) do
        local tween = tweenserv:Create(stroke, tweenInfo, {Color = clrs.pink});
        tween:Play();
    end;
    
    -- Update scrollbars
    for _, scrollbar in pairs(uiElements.scrollbars) do
        local tween = tweenserv:Create(scrollbar, tweenInfo, {BackgroundColor3 = clrs.pink});
        tween:Play();
    end;
    
    -- Update gradient button if it exists
    if uiElements.gradientButton then
        local tween = tweenserv:Create(uiElements.gradientButton, tweenInfo, {TextColor3 = clrs.pink});
        tween:Play();
    end;
    
    -- Update title gradient if it exists
    if uiElements.titleGradient then
        local tween = tweenserv:Create(uiElements.titleGradient.UIGradient, tweenInfo, {
            Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, clrs.pink),
                ColorSequenceKeypoint.new(1, clrs.darkpink)
            })
        });
        tween:Play();
    end;
end;

function pnkui:CreateWindow(config)
    config = config or {};
    local window = {};
    
    -- Create main frame
    local mainFrame = Instance.new("Frame");
    mainFrame.Size = UDim2.new(0, 700, 0, 450);
    mainFrame.Position = UDim2.new(0.5, -350, 0.5, -225);
    mainFrame.BackgroundColor3 = clrs.bg;
    mainFrame.Parent = coregui;
    
    -- Make draggable
    local dragging = false;
    local dragStart = nil;
    local startPos = nil;
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true;
            dragStart = input.Position;
            startPos = mainFrame.Position;
        end;
    end);
    
    userinput.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart;
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            );
        end;
    end);
    
    userinput.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false;
        end;
    end);
    
    -- Create corner
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 5);
    corner.Parent = mainFrame;
    
    -- Create title
    local titleFrame = Instance.new("Frame");
    titleFrame.Size = UDim2.new(1, 0, 0, 30);
    titleFrame.BackgroundTransparency = 1;
    titleFrame.Parent = mainFrame;
    
    local titleText = Instance.new("TextLabel");
    titleText.Size = UDim2.new(1, -100, 1, 0);
    titleText.Position = UDim2.new(0, 10, 0, 0);
    titleText.BackgroundTransparency = 1;
    titleText.TextXAlignment = Enum.TextXAlignment.Left;
    titleText.TextColor3 = clrs.white;
    titleText.TextSize = 14;
    titleText.Font = Enum.Font.GothamBold;
    titleText.Text = config.Title or "Pink UI";
    titleText.Parent = titleFrame;
    
    if config.TitleGradient then
        local gradient = Instance.new("UIGradient");
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, clrs.pink),
            ColorSequenceKeypoint.new(1, clrs.darkpink)
        });
        gradient.Parent = titleText;
        
        -- Store gradient for theme updates
        uiElements.titleGradient = titleText;
        
        -- Animate gradient
        local offset = 0;
        runserv.Heartbeat:Connect(function()
            offset = (offset + 0.001) % 1;
            gradient.Offset = Vector2.new(offset, 0);
        end);
    end;
    
    -- Create subtitle
    if config.Subtitle then
        local subtitleText = Instance.new("TextLabel");
        subtitleText.Size = UDim2.new(0, 200, 1, 0);
        subtitleText.Position = UDim2.new(0, 120, 0, 0);
        subtitleText.BackgroundTransparency = 1;
        subtitleText.TextColor3 = clrs.grey;
        subtitleText.TextSize = 14;
        subtitleText.Font = Enum.Font.Gotham;
        subtitleText.Text = config.Subtitle;
        subtitleText.Parent = titleFrame;
    end;
    
    -- Create gradient toggle button
    local gradientButton = Instance.new("TextButton");
    gradientButton.Size = UDim2.new(0, 20, 0, 20);
    gradientButton.Position = UDim2.new(1, -90, 0, 5);
    gradientButton.BackgroundTransparency = 1;
    gradientButton.TextColor3 = clrs.pink;
    gradientButton.TextSize = 14;
    gradientButton.Font = Enum.Font.GothamBold;
    gradientButton.Text = "G";
    gradientButton.Parent = titleFrame;
    
    -- Store gradient button for theme updates
    uiElements.gradientButton = gradientButton;
    
    gradientButton.MouseButton1Click:Connect(function()
        if uiElements.titleGradient then
            uiElements.titleGradient:Destroy();
            uiElements.titleGradient = nil;
        else
            local gradient = Instance.new("UIGradient");
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, clrs.pink),
                ColorSequenceKeypoint.new(1, clrs.darkpink)
            });
            gradient.Parent = titleText;
            
            uiElements.titleGradient = titleText;
            
            local offset = 0;
            runserv.Heartbeat:Connect(function()
                offset = (offset + 0.001) % 1;
                gradient.Offset = Vector2.new(offset, 0);
            end);
        end;
    end);
    
    -- Create minimize button
    local minimizeButton = Instance.new("TextButton");
    minimizeButton.Size = UDim2.new(0, 20, 0, 20);
    minimizeButton.Position = UDim2.new(1, -60, 0, 5);
    minimizeButton.BackgroundTransparency = 1;
    minimizeButton.TextColor3 = clrs.white;
    minimizeButton.TextSize = 20;
    minimizeButton.Font = Enum.Font.GothamBold;
    minimizeButton.Text = "-";
    minimizeButton.Parent = titleFrame;
    
    local minimized = false;
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized;
        local targetSize = minimized and UDim2.new(0, 700, 0, 30) or UDim2.new(0, 700, 0, 450);
        local tween = tweenserv:Create(mainFrame, TweenInfo.new(0.3), {Size = targetSize});
        tween:Play();
    end);
    
    -- Create close button
    local closeButton = Instance.new("TextButton");
    closeButton.Size = UDim2.new(0, 20, 0, 20);
    closeButton.Position = UDim2.new(1, -30, 0, 5);
    closeButton.BackgroundTransparency = 1;
    closeButton.TextColor3 = clrs.red;
    closeButton.TextSize = 14;
    closeButton.Font = Enum.Font.GothamBold;
    closeButton.Text = "X";
    closeButton.Parent = titleFrame;
    
    closeButton.MouseButton1Click:Connect(function()
        mainFrame:Destroy();
    end);
    
    -- Create separator
    local separator = Instance.new("Frame");
    separator.Size = UDim2.new(1, -20, 0, 1);
    separator.Position = UDim2.new(0, 10, 0, 35);
    separator.BackgroundColor3 = clrs.separator;
    separator.BorderSizePixel = 0;
    separator.Parent = mainFrame;
    
    -- Create tab container
    local tabContainer = Instance.new("ScrollingFrame");
    tabContainer.Size = UDim2.new(0, 120, 1, -90); -- Adjusted for greeting height
    tabContainer.Position = UDim2.new(0, 10, 0, 45);
    tabContainer.BackgroundColor3 = clrs.secondary;
    tabContainer.BorderSizePixel = 0;
    tabContainer.ScrollBarThickness = 2;
    tabContainer.ScrollBarImageColor3 = clrs.pink;
    tabContainer.Parent = mainFrame;
    
    -- Add tab container scrollbar to theme updates
    table.insert(uiElements.scrollbars, tabContainer);
    
    -- Create tab container corner
    local tabCorner = Instance.new("UICorner");
    tabCorner.CornerRadius = UDim.new(0, 5);
    tabCorner.Parent = tabContainer;
    
    -- Create tab content frame
    local contentFrame = Instance.new("Frame");
    contentFrame.Size = UDim2.new(1, -150, 1, -90); -- Adjusted for greeting height
    contentFrame.Position = UDim2.new(0, 140, 0, 45);
    contentFrame.BackgroundTransparency = 1;
    contentFrame.Parent = mainFrame;
    
    -- Create tab list layout
    local tabLayout = Instance.new("UIListLayout");
    tabLayout.Padding = UDim.new(0, 5);
    tabLayout.Parent = tabContainer;
    
    -- Create tab padding
    local tabPadding = Instance.new("UIPadding");
    tabPadding.PaddingTop = UDim.new(0, 5);
    tabPadding.Parent = tabContainer;
    
    -- Create columns
    local leftColumn = Instance.new("ScrollingFrame");
    leftColumn.Size = UDim2.new(0.48, 0, 1, 0);
    leftColumn.BackgroundTransparency = 1;
    leftColumn.BorderSizePixel = 0;
    leftColumn.ScrollBarThickness = 2;
    leftColumn.ScrollBarImageColor3 = clrs.pink;
    leftColumn.Parent = contentFrame;
    
    local rightColumn = Instance.new("ScrollingFrame");
    rightColumn.Size = UDim2.new(0.48, 0, 1, 0);
    rightColumn.Position = UDim2.new(0.52, 0, 0, 0);
    rightColumn.BackgroundTransparency = 1;
    rightColumn.BorderSizePixel = 0;
    rightColumn.ScrollBarThickness = 2;
    rightColumn.ScrollBarImageColor3 = clrs.pink;
    rightColumn.Parent = contentFrame;
    
    -- Add column scrollbars to theme updates
    table.insert(uiElements.scrollbars, leftColumn);
    table.insert(uiElements.scrollbars, rightColumn);
    
    -- Create column layouts
    local leftLayout = Instance.new("UIListLayout");
    leftLayout.Padding = UDim.new(0, 10);
    leftLayout.Parent = leftColumn;
    
    local rightLayout = Instance.new("UIListLayout");
    rightLayout.Padding = UDim.new(0, 10);
    rightLayout.Parent = rightColumn;
    
    -- Create greeting system
    GreetingSystem:CreateGreeting(mainFrame);
    
    -- Tab system
    local tabs = {};
    local selectedTab = nil;
    
    function window:CreateTab(config)
        local tab = {};
        config = config or {};
        
        -- Create tab button
        local tabButton = Instance.new("TextButton");
        tabButton.Size = UDim2.new(1, -10, 0, 30);
        tabButton.BackgroundColor3 = clrs.secondary;
        tabButton.BorderSizePixel = 0;
        tabButton.TextTransparency = 1;
        tabButton.Parent = tabContainer;
        
        -- Store tab button for theme updates
        table.insert(uiElements.tabButtons, tabButton);
        
        -- Create tab button corner
        local buttonCorner = Instance.new("UICorner");
        buttonCorner.CornerRadius = UDim.new(0, 5);
        buttonCorner.Parent = tabButton;
        
        -- Create tab icon
        local tabIcon = Instance.new("TextLabel");
        tabIcon.Size = UDim2.new(0, 20, 1, 0);
        tabIcon.Position = UDim2.new(0, 8, 0, 0);
        tabIcon.BackgroundTransparency = 1;
        tabIcon.TextColor3 = clrs.grey;
        tabIcon.TextSize = 16;
        tabIcon.Font = Enum.Font.Gotham;
        tabIcon.Text = config.Icon or "📄";
        tabIcon.Parent = tabButton;
        
        -- Store tab icon for theme updates
        table.insert(uiElements.tabIcons, tabIcon);
        
        -- Create tab name
        local tabName = Instance.new("TextLabel");
        tabName.Size = UDim2.new(1, -35, 1, 0);
        tabName.Position = UDim2.new(0, 35, 0, 0);
        tabName.BackgroundTransparency = 1;
        tabName.TextColor3 = clrs.grey;
        tabName.TextSize = 14;
        tabName.Font = Enum.Font.Gotham;
        tabName.Text = config.Name or "Tab";
        tabName.TextXAlignment = Enum.TextXAlignment.Left;
        tabName.Parent = tabButton;
        
        -- Store tab name for theme updates
        table.insert(uiElements.tabLabels, tabName);
        
        -- Create tab content
        local tabContent = Instance.new("Frame");
        tabContent.Size = UDim2.new(1, 0, 1, 0);
        tabContent.BackgroundTransparency = 1;
        tabContent.Visible = false;
        tabContent.Parent = contentFrame;
        
        -- Tab selection
        tabButton.MouseButton1Click:Connect(function()
            if selectedTab then
                -- Reset old tab
                local oldIcon = selectedTab.Button:FindFirstChildOfClass("TextLabel");
                local oldName = selectedTab.Button:FindFirstChild("TextLabel", 1);
                
                tweenserv:Create(oldIcon, TweenInfo.new(0.2), {TextColor3 = clrs.grey}):Play();
                tweenserv:Create(oldName, TweenInfo.new(0.2), {TextColor3 = clrs.grey}):Play();
                selectedTab.Content.Visible = false;
            end;
            
            -- Set new tab
            tweenserv:Create(tabIcon, TweenInfo.new(0.2), {TextColor3 = clrs.pink}):Play();
            tweenserv:Create(tabName, TweenInfo.new(0.2), {TextColor3 = clrs.white}):Play();
            tabContent.Visible = true;
            
            selectedTab = tab;
        end);
        
        -- Create box function
        function tab:CreateBox(config)
            config = config or {};
            
            -- Create box frame
            local boxFrame = Instance.new("Frame");
            boxFrame.Size = UDim2.new(1, 0, 0, config.Height or 200);
            boxFrame.BackgroundColor3 = clrs.secondary;
            boxFrame.Parent = config.Column == "right" and rightColumn or leftColumn;
            
            -- Create box corner
            local boxCorner = Instance.new("UICorner");
            boxCorner.CornerRadius = UDim.new(0, 5);
            boxCorner.Parent = boxFrame;
            
            -- Create box stroke
            local boxStroke = Instance.new("UIStroke");
            boxStroke.Color = clrs.pink;
            boxStroke.Parent = boxFrame;
            
            -- Store stroke for theme updates
            table.insert(uiElements.strokes, boxStroke);
            
            -- Create box title
            local boxTitle = Instance.new("TextLabel");
            boxTitle.Size = UDim2.new(1, -20, 0, 30);
            boxTitle.Position = UDim2.new(0, 10, 0, 0);
            boxTitle.BackgroundTransparency = 1;
            boxTitle.TextColor3 = clrs.pink;
            boxTitle.TextSize = 14;
            boxTitle.Font = Enum.Font.GothamBold;
            boxTitle.Text = config.Name or "Box";
            boxTitle.TextXAlignment = Enum.TextXAlignment.Left;
            boxTitle.Parent = boxFrame;
            
            -- Store box title for theme updates
            table.insert(uiElements.boxTitles, boxTitle);
            
            -- Create box content
            local boxContent = Instance.new("ScrollingFrame");
            boxContent.Size = UDim2.new(1, -20, 1, -40);
            boxContent.Position = UDim2.new(0, 10, 0, 35);
            boxContent.BackgroundTransparency = 1;
            boxContent.BorderSizePixel = 0;
            boxContent.ScrollBarThickness = 2;
            boxContent.ScrollBarImageColor3 = clrs.pink;
            boxContent.Parent = boxFrame;
            
            -- Add box scrollbar to theme updates
            table.insert(uiElements.scrollbars, boxContent);
            
            -- Create content layout
            local contentLayout = Instance.new("UIListLayout");
            contentLayout.Padding = UDim.new(0, 5);
            contentLayout.Parent = boxContent;
            
            -- Create content padding
            local contentPadding = Instance.new("UIPadding");
            contentPadding.PaddingTop = UDim.new(0, 5);
            contentPadding.Parent = boxContent;
            
            -- Auto-size content
            contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                boxContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10);
            end);
            
            return boxContent;
        end;
        
        -- Store tab data
        tab.Button = tabButton;
        tab.Content = tabContent;
        table.insert(tabs, tab);
        
        -- Auto-select first tab
        if #tabs == 1 then
            tabButton.MouseButton1Click:Fire();
        end;
        
        -- Auto-size tab container
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 10);
        end);
        
        return tab;
    end;
    
    return window;
end;

return pnkui;