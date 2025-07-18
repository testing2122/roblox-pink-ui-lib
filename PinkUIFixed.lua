local pnkui = {};
local tweenserv = game:GetService("TweenService");
local userinput = game:GetService("UserInputService");
local runserv = game:GetService("RunService");
local players = game:GetService("Players");
local coregui = game:GetService("CoreGui");

local plr = players.LocalPlayer;
local mouse = plr:GetMouse();

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

local uiElements = {
    boxTitles = {},
    underlines = {},
    hoverlines = {},
    tabButtons = {},
    tabIcons = {},
    tabLabels = {},
    strokes = {},
    scrollbars = {},
    gradientButton = nil,
    titleGradientObj = nil
};

function pnkui:ApplyTheme(newTheme)
    for key, value in pairs(newTheme) do
        clrs[key] = value;
    end;
    
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    
    for _, titleElement in pairs(uiElements.boxTitles) do
        local tween = tweenserv:Create(titleElement, tweenInfo, {TextColor3 = clrs.pink});
        tween:Play();
    end;
    
    for _, underline in pairs(uiElements.underlines) do
        local tween = tweenserv:Create(underline, tweenInfo, {BackgroundColor3 = clrs.pink});
        tween:Play();
    end;
    
    for _, hoverline in pairs(uiElements.hoverlines) do
        local tween = tweenserv:Create(hoverline, tweenInfo, {BackgroundColor3 = clrs.pink});
        tween:Play();
    end;
    
    for _, button in pairs(uiElements.tabButtons) do
        local tween = tweenserv:Create(button, tweenInfo, {BackgroundColor3 = clrs.secondary});
        tween:Play();
    end;
    
    for _, icon in pairs(uiElements.tabIcons) do
        local tween = tweenserv:Create(icon, tweenInfo, {TextColor3 = clrs.grey});
        tween:Play();
    end;
    
    for _, label in pairs(uiElements.tabLabels) do
        local tween = tweenserv:Create(label, tweenInfo, {TextColor3 = clrs.grey});
        tween:Play();
    end;
    
    for _, stroke in pairs(uiElements.strokes) do
        local tween = tweenserv:Create(stroke, tweenInfo, {Color = clrs.pink});
        tween:Play();
    end;
    
    for _, scrollbar in pairs(uiElements.scrollbars) do
        local tween = tweenserv:Create(scrollbar, tweenInfo, {ScrollBarImageColor3 = clrs.pink});
        tween:Play();
    end;
    
    if uiElements.gradientButton then
        local tween = tweenserv:Create(uiElements.gradientButton, tweenInfo, {TextColor3 = clrs.pink});
        tween:Play();
    end;
    
    if uiElements.titleGradientObj then
        uiElements.titleGradientObj.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, clrs.pink),
            ColorSequenceKeypoint.new(1, clrs.darkpink)
        });
    end;
end;

function pnkui:CreateWindow(config)
    config = config or {};
    local window = {};
    
    local screenGui = Instance.new("ScreenGui");
    screenGui.Name = "PinkUI";
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    screenGui.Parent = coregui;
    
    local mainFrame = Instance.new("Frame");
    mainFrame.Size = UDim2.new(0, 750, 0, 500);
    mainFrame.Position = UDim2.new(0.5, -375, 0.5, -250);
    mainFrame.BackgroundColor3 = clrs.bg;
    mainFrame.BorderSizePixel = 0;
    mainFrame.Parent = screenGui;
    
    local mainStroke = Instance.new("UIStroke");
    mainStroke.Color = clrs.pink;
    mainStroke.Thickness = 2;
    mainStroke.Parent = mainFrame;
    
    table.insert(uiElements.strokes, mainStroke);
    
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
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 8);
    corner.Parent = mainFrame;
    
    local titleFrame = Instance.new("Frame");
    titleFrame.Size = UDim2.new(1, 0, 0, 40);
    titleFrame.BackgroundTransparency = 1;
    titleFrame.Parent = mainFrame;
    
    local titleText = Instance.new("TextLabel");
    titleText.Size = UDim2.new(1, -120, 1, 0);
    titleText.Position = UDim2.new(0, 15, 0, 0);
    titleText.BackgroundTransparency = 1;
    titleText.TextXAlignment = Enum.TextXAlignment.Left;
    titleText.TextColor3 = clrs.white;
    titleText.TextSize = 16;
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
        
        uiElements.titleGradientObj = gradient;
        
        local offset = 0;
        runserv.Heartbeat:Connect(function()
            offset = (offset + 0.001) % 1;
            gradient.Offset = Vector2.new(offset, 0);
        end);
    end;
    
    if config.Subtitle then
        local subtitleText = Instance.new("TextLabel");
        subtitleText.Size = UDim2.new(0, 200, 1, 0);
        subtitleText.Position = UDim2.new(0, 150, 0, 0);
        subtitleText.BackgroundTransparency = 1;
        subtitleText.TextColor3 = clrs.grey;
        subtitleText.TextSize = 14;
        subtitleText.Font = Enum.Font.Gotham;
        subtitleText.Text = config.Subtitle;
        subtitleText.Parent = titleFrame;
    end;
    
    local gradientButton = Instance.new("TextButton");
    gradientButton.Size = UDim2.new(0, 25, 0, 25);
    gradientButton.Position = UDim2.new(1, -100, 0, 7.5);
    gradientButton.BackgroundTransparency = 1;
    gradientButton.TextColor3 = clrs.pink;
    gradientButton.TextSize = 16;
    gradientButton.Font = Enum.Font.GothamBold;
    gradientButton.Text = "G";
    gradientButton.Parent = titleFrame;
    
    uiElements.gradientButton = gradientButton;
    
    gradientButton.MouseButton1Click:Connect(function()
        if uiElements.titleGradientObj then
            uiElements.titleGradientObj:Destroy();
            uiElements.titleGradientObj = nil;
        else
            local gradient = Instance.new("UIGradient");
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, clrs.pink),
                ColorSequenceKeypoint.new(1, clrs.darkpink)
            });
            gradient.Parent = titleText;
            
            uiElements.titleGradientObj = gradient;
            
            local offset = 0;
            runserv.Heartbeat:Connect(function()
                offset = (offset + 0.001) % 1;
                gradient.Offset = Vector2.new(offset, 0);
            end);
        end;
    end);
    
    local minimizeButton = Instance.new("TextButton");
    minimizeButton.Size = UDim2.new(0, 25, 0, 25);
    minimizeButton.Position = UDim2.new(1, -70, 0, 7.5);
    minimizeButton.BackgroundTransparency = 1;
    minimizeButton.TextColor3 = clrs.white;
    minimizeButton.TextSize = 18;
    minimizeButton.Font = Enum.Font.GothamBold;
    minimizeButton.Text = "-";
    minimizeButton.Parent = titleFrame;
    
    local minimized = false;
    minimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized;
        local targetSize = minimized and UDim2.new(0, 750, 0, 40) or UDim2.new(0, 750, 0, 500);
        local tween = tweenserv:Create(mainFrame, TweenInfo.new(0.3), {Size = targetSize});
        tween:Play();
    end);
    
    local closeButton = Instance.new("TextButton");
    closeButton.Size = UDim2.new(0, 25, 0, 25);
    closeButton.Position = UDim2.new(1, -35, 0, 7.5);
    closeButton.BackgroundTransparency = 1;
    closeButton.TextColor3 = clrs.red;
    closeButton.TextSize = 16;
    closeButton.Font = Enum.Font.GothamBold;
    closeButton.Text = "X";
    closeButton.Parent = titleFrame;
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy();
    end);
    
    local separator = Instance.new("Frame");
    separator.Size = UDim2.new(1, -30, 0, 2);
    separator.Position = UDim2.new(0, 15, 0, 45);
    separator.BackgroundColor3 = clrs.pink;
    separator.BorderSizePixel = 0;
    separator.Parent = mainFrame;
    
    table.insert(uiElements.underlines, separator);
    
    local sepCorner = Instance.new("UICorner");
    sepCorner.CornerRadius = UDim.new(0, 1);
    sepCorner.Parent = separator;
    
    local tabContainer = Instance.new("ScrollingFrame");
    tabContainer.Size = UDim2.new(0, 140, 1, -65);
    tabContainer.Position = UDim2.new(0, 15, 0, 55);
    tabContainer.BackgroundColor3 = clrs.secondary;
    tabContainer.BorderSizePixel = 0;
    tabContainer.ScrollBarThickness = 3;
    tabContainer.ScrollBarImageColor3 = clrs.pink;
    tabContainer.Parent = mainFrame;
    
    table.insert(uiElements.scrollbars, tabContainer);
    
    local tabStroke = Instance.new("UIStroke");
    tabStroke.Color = clrs.pink;
    tabStroke.Thickness = 1;
    tabStroke.Parent = tabContainer;
    
    table.insert(uiElements.strokes, tabStroke);
    
    local tabCorner = Instance.new("UICorner");
    tabCorner.CornerRadius = UDim.new(0, 6);
    tabCorner.Parent = tabContainer;
    
    local contentFrame = Instance.new("Frame");
    contentFrame.Size = UDim2.new(1, -175, 1, -65);
    contentFrame.Position = UDim2.new(0, 165, 0, 55);
    contentFrame.BackgroundTransparency = 1;
    contentFrame.Parent = mainFrame;
    
    local tabLayout = Instance.new("UIListLayout");
    tabLayout.Padding = UDim.new(0, 8);
    tabLayout.Parent = tabContainer;
    
    local tabPadding = Instance.new("UIPadding");
    tabPadding.PaddingTop = UDim.new(0, 8);
    tabPadding.PaddingLeft = UDim.new(0, 8);
    tabPadding.PaddingRight = UDim.new(0, 8);
    tabPadding.Parent = tabContainer;
    
    local leftColumn = Instance.new("ScrollingFrame");
    leftColumn.Size = UDim2.new(0.48, 0, 1, 0);
    leftColumn.BackgroundTransparency = 1;
    leftColumn.BorderSizePixel = 0;
    leftColumn.ScrollBarThickness = 3;
    leftColumn.ScrollBarImageColor3 = clrs.pink;
    leftColumn.Parent = contentFrame;
    
    local rightColumn = Instance.new("ScrollingFrame");
    rightColumn.Size = UDim2.new(0.48, 0, 1, 0);
    rightColumn.Position = UDim2.new(0.52, 0, 0, 0);
    rightColumn.BackgroundTransparency = 1;
    rightColumn.BorderSizePixel = 0;
    rightColumn.ScrollBarThickness = 3;
    rightColumn.ScrollBarImageColor3 = clrs.pink;
    rightColumn.Parent = contentFrame;
    
    table.insert(uiElements.scrollbars, leftColumn);
    table.insert(uiElements.scrollbars, rightColumn);
    
    local leftLayout = Instance.new("UIListLayout");
    leftLayout.Padding = UDim.new(0, 12);
    leftLayout.Parent = leftColumn;
    
    local rightLayout = Instance.new("UIListLayout");
    rightLayout.Padding = UDim.new(0, 12);
    rightLayout.Parent = rightColumn;
    
    local leftPadding = Instance.new("UIPadding");
    leftPadding.PaddingTop = UDim.new(0, 5);
    leftPadding.Parent = leftColumn;
    
    local rightPadding = Instance.new("UIPadding");
    rightPadding.PaddingTop = UDim.new(0, 5);
    rightPadding.Parent = rightColumn;
    
    local greetingLabel = Instance.new("TextLabel");
    greetingLabel.Size = UDim2.new(1, -175, 0, 20);
    greetingLabel.Position = UDim2.new(0, 15, 1, -25);
    greetingLabel.BackgroundTransparency = 1;
    greetingLabel.TextColor3 = clrs.grey;
    greetingLabel.TextSize = 12;
    greetingLabel.Font = Enum.Font.Gotham;
    greetingLabel.Text = "welcome back, " .. plr.Name;
    greetingLabel.TextXAlignment = Enum.TextXAlignment.Left;
    greetingLabel.Parent = mainFrame;
    
    local tabs = {};
    local selectedTab = nil;
    
    function window:CreateTab(config)
        local tab = {};
        config = config or {};
        
        local tabButton = Instance.new("TextButton");
        tabButton.Size = UDim2.new(1, -16, 0, 35);
        tabButton.BackgroundColor3 = clrs.accent;
        tabButton.BorderSizePixel = 0;
        tabButton.TextTransparency = 1;
        tabButton.Parent = tabContainer;
        
        table.insert(uiElements.tabButtons, tabButton);
        
        local buttonCorner = Instance.new("UICorner");
        buttonCorner.CornerRadius = UDim.new(0, 6);
        buttonCorner.Parent = tabButton;
        
        local tabHover = Instance.new("Frame");
        tabHover.Size = UDim2.new(0, 3, 1, -10);
        tabHover.Position = UDim2.new(0, 5, 0, 5);
        tabHover.BackgroundColor3 = clrs.pink;
        tabHover.BorderSizePixel = 0;
        tabHover.BackgroundTransparency = 1;
        tabHover.Parent = tabButton;
        
        table.insert(uiElements.hoverlines, tabHover);
        
        local hoverCorner = Instance.new("UICorner");
        hoverCorner.CornerRadius = UDim.new(0, 2);
        hoverCorner.Parent = tabHover;
        
        local tabIcon = Instance.new("TextLabel");
        tabIcon.Size = UDim2.new(0, 25, 1, 0);
        tabIcon.Position = UDim2.new(0, 15, 0, 0);
        tabIcon.BackgroundTransparency = 1;
        tabIcon.TextColor3 = clrs.grey;
        tabIcon.TextSize = 16;
        tabIcon.Font = Enum.Font.Gotham;
        tabIcon.Text = config.Icon or "📄";
        tabIcon.Parent = tabButton;
        
        table.insert(uiElements.tabIcons, tabIcon);
        
        local tabName = Instance.new("TextLabel");
        tabName.Size = UDim2.new(1, -45, 1, 0);
        tabName.Position = UDim2.new(0, 45, 0, 0);
        tabName.BackgroundTransparency = 1;
        tabName.TextColor3 = clrs.grey;
        tabName.TextSize = 14;
        tabName.Font = Enum.Font.GothamMedium;
        tabName.Text = config.Name or "Tab";
        tabName.TextXAlignment = Enum.TextXAlignment.Left;
        tabName.Parent = tabButton;
        
        table.insert(uiElements.tabLabels, tabName);
        
        local tabContent = Instance.new("Frame");
        tabContent.Size = UDim2.new(1, 0, 1, 0);
        tabContent.BackgroundTransparency = 1;
        tabContent.Visible = false;
        tabContent.Parent = contentFrame;
        
        local function selectTab()
            if selectedTab then
                local oldIcon = selectedTab.Button:FindFirstChildOfClass("TextLabel");
                local oldName = selectedTab.Button:FindFirstChild("TextLabel", 1);
                local oldHover = selectedTab.Button:FindFirstChild("Frame");
                
                tweenserv:Create(oldIcon, TweenInfo.new(0.2), {TextColor3 = clrs.grey}):Play();
                tweenserv:Create(oldName, TweenInfo.new(0.2), {TextColor3 = clrs.grey}):Play();
                tweenserv:Create(oldHover, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play();
                selectedTab.Content.Visible = false;
            end;
            
            tweenserv:Create(tabIcon, TweenInfo.new(0.2), {TextColor3 = clrs.pink}):Play();
            tweenserv:Create(tabName, TweenInfo.new(0.2), {TextColor3 = clrs.white}):Play();
            tweenserv:Create(tabHover, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play();
            tabContent.Visible = true;
            
            selectedTab = tab;
        end;
        
        tabButton.MouseButton1Click:Connect(selectTab);
        
        function tab:CreateBox(config)
            config = config or {};
            
            local boxFrame = Instance.new("Frame");
            boxFrame.Size = UDim2.new(1, 0, 0, config.Height or 200);
            boxFrame.BackgroundColor3 = clrs.secondary;
            boxFrame.BorderSizePixel = 0;
            boxFrame.Parent = config.Column == "right" and rightColumn or leftColumn;
            
            local boxCorner = Instance.new("UICorner");
            boxCorner.CornerRadius = UDim.new(0, 8);
            boxCorner.Parent = boxFrame;
            
            local boxStroke = Instance.new("UIStroke");
            boxStroke.Color = clrs.pink;
            boxStroke.Thickness = 1;
            boxStroke.Parent = boxFrame;
            
            table.insert(uiElements.strokes, boxStroke);
            
            local boxTitle = Instance.new("TextLabel");
            boxTitle.Size = UDim2.new(1, -20, 0, 35);
            boxTitle.Position = UDim2.new(0, 15, 0, 5);
            boxTitle.BackgroundTransparency = 1;
            boxTitle.TextColor3 = clrs.pink;
            boxTitle.TextSize = 16;
            boxTitle.Font = Enum.Font.GothamBold;
            boxTitle.Text = config.Name or "Box";
            boxTitle.TextXAlignment = Enum.TextXAlignment.Left;
            boxTitle.Parent = boxFrame;
            
            table.insert(uiElements.boxTitles, boxTitle);
            
            local boxContent = Instance.new("ScrollingFrame");
            boxContent.Size = UDim2.new(1, -20, 1, -50);
            boxContent.Position = UDim2.new(0, 10, 0, 45);
            boxContent.BackgroundTransparency = 1;
            boxContent.BorderSizePixel = 0;
            boxContent.ScrollBarThickness = 3;
            boxContent.ScrollBarImageColor3 = clrs.pink;
            boxContent.Parent = boxFrame;
            
            table.insert(uiElements.scrollbars, boxContent);
            
            local contentLayout = Instance.new("UIListLayout");
            contentLayout.Padding = UDim.new(0, 8);
            contentLayout.Parent = boxContent;
            
            local contentPadding = Instance.new("UIPadding");
            contentPadding.PaddingTop = UDim.new(0, 5);
            contentPadding.Parent = boxContent;
            
            contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                boxContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 15);
            end);
            
            return boxContent;
        end;
        
        tab.Button = tabButton;
        tab.Content = tabContent;
        table.insert(tabs, tab);
        
        if #tabs == 1 then
            selectTab();
        end;
        
        tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContainer.CanvasSize = UDim2.new(0, 0, 0, tabLayout.AbsoluteContentSize.Y + 20);
        end);
        
        return tab;
    end;
    
    return window;
end;

return pnkui;