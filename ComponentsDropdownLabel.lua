-- // Additional components for the Pink UI Library
-- // This file contains AddDropdown and AddLabel functions with theme registration

function components:AddDropdown(parent, cfg)
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
    
    registerElement(droplbl, "texts", "white");
    
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
        
        registerElement(desclbl, "texts", "grey");
    end;
    
    -- // dropdown button
    local dropbtn = Instance.new("TextButton");
    dropbtn.Size = UDim2.new(1, 0, 0, 30);
    dropbtn.Position = UDim2.new(0, 0, 1, desc ~= "" and -35 or -30);
    dropbtn.BackgroundColor3 = clrs.accent;
    dropbtn.BorderSizePixel = 0;
    dropbtn.Text = "";
    dropbtn.Parent = dropframe;
    
    registerElement(dropbtn, "accents");
    
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
    
    registerElement(selectedlbl, "texts", "white");
    
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
    
    registerElement(arrow, "texts", "grey");
    
    -- // Find the ScreenGui for proper dropdown positioning
    local function findScreenGui()
        local current = parent;
        while current and current.Parent do
            if current:IsA("ScreenGui") then
                return current;
            end;
            current = current.Parent;
        end;
        return game:GetService("CoreGui"):FindFirstChild("PinkUI") or game:GetService("CoreGui");
    end;
    
    local screenGui = findScreenGui();
    
    -- // FIXED dropdown list - properly positioned and parented
    local droplist = Instance.new("Frame");
    droplist.Size = UDim2.new(0, 0, 0, 0);
    droplist.Position = UDim2.new(0, 0, 0, 0);
    droplist.BackgroundColor3 = clrs.secondary;
    droplist.BorderSizePixel = 0;
    droplist.Visible = false;
    droplist.ZIndex = 1000;
    droplist.ClipsDescendants = false;
    droplist.Parent = screenGui;
    
    registerElement(droplist, "secondaries");
    
    local listcorner = Instance.new("UICorner");
    listcorner.CornerRadius = UDim.new(0, 6);
    listcorner.Parent = droplist;
    
    local liststroke = Instance.new("UIStroke");
    liststroke.Color = clrs.separator;
    liststroke.Thickness = 1;
    liststroke.Parent = droplist;
    
    registerElement(liststroke, "strokes");
    
    -- // FIXED scrolling frame for options
    local scrollframe = Instance.new("ScrollingFrame");
    scrollframe.Size = UDim2.new(1, 0, 1, 0);
    scrollframe.Position = UDim2.new(0, 0, 0, 0);
    scrollframe.BackgroundTransparency = 1;
    scrollframe.BorderSizePixel = 0;
    scrollframe.ScrollBarThickness = 2;
    scrollframe.ScrollBarImageColor3 = clrs.pink;
    scrollframe.CanvasSize = UDim2.new(0, 0, 0, #options * 30);
    scrollframe.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    scrollframe.ClipsDescendants = true;
    scrollframe.Parent = droplist;
    
    registerElement(scrollframe, "scrollbars");
    
    local optionlayout = Instance.new("UIListLayout");
    optionlayout.SortOrder = Enum.SortOrder.LayoutOrder;
    optionlayout.Parent = scrollframe;
    
    local selected = default;
    local isopen = false;
    local maxHeight = math.min(#options * 30, 150);
    
    -- // FIXED position dropdown relative to button
    local function positionDropdown()
        local btnPos = dropbtn.AbsolutePosition;
        local btnSize = dropbtn.AbsoluteSize;
        local screenSize = workspace.CurrentCamera.ViewportSize;
        
        -- Calculate position in screen coordinates
        local xPos = btnPos.X;
        local yPos = btnPos.Y + btnSize.Y + 5;
        
        -- Check if dropdown would go off screen vertically
        if yPos + maxHeight > screenSize.Y then
            yPos = btnPos.Y - maxHeight - 5; -- Position above
        end;
        
        -- Check if dropdown would go off screen horizontally
        if xPos + btnSize.X > screenSize.X then
            xPos = screenSize.X - btnSize.X;
        end;
        
        -- Ensure dropdown doesn't go off left edge
        if xPos < 0 then
            xPos = 0;
        end;
        
        -- Set position and initial size
        droplist.Position = UDim2.new(0, xPos, 0, yPos);
        droplist.Size = UDim2.new(0, btnSize.X, 0, 0); -- Start with 0 height for animation
    end;
    
    -- // FIXED create option buttons with proper visibility
    local function createOptions()
        -- Clear existing options
        for _, child in ipairs(scrollframe:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy();
            end;
        end;
        
        for i, option in ipairs(options) do
            local optionbtn = Instance.new("TextButton");
            optionbtn.Size = UDim2.new(1, 0, 0, 30);
            optionbtn.BackgroundColor3 = clrs.accent;
            optionbtn.BackgroundTransparency = option == selected and 0.3 or 0.8;
            optionbtn.BorderSizePixel = 0;
            optionbtn.Text = option;
            optionbtn.TextColor3 = option == selected and clrs.pink or clrs.white;
            optionbtn.TextSize = 13;
            optionbtn.Font = Enum.Font.Gotham;
            optionbtn.LayoutOrder = i;
            optionbtn.ZIndex = 1001;
            optionbtn.Parent = scrollframe;
            
            registerElement(optionbtn, "accents");
            registerElement(optionbtn, "texts", option == selected and "pink" or "white");
            
            optionbtn.MouseEnter:Connect(function()
                if option ~= selected then
                    createtween(optionbtn, twinfo.fast, {BackgroundTransparency = 0.5, TextColor3 = clrs.lightpink}):Play();
                end;
            end);
            
            optionbtn.MouseLeave:Connect(function()
                if option ~= selected then
                    createtween(optionbtn, twinfo.fast, {BackgroundTransparency = 0.8, TextColor3 = clrs.white}):Play();
                end;
            end);
            
            optionbtn.MouseButton1Click:Connect(function()
                -- Update selection
                for _, btn in ipairs(scrollframe:GetChildren()) do
                    if btn:IsA("TextButton") then
                        if btn.Text == option then
                            createtween(btn, twinfo.fast, {BackgroundTransparency = 0.3, TextColor3 = clrs.pink}):Play();
                        else
                            createtween(btn, twinfo.fast, {BackgroundTransparency = 0.8, TextColor3 = clrs.white}):Play();
                        end;
                    end;
                end;
                
                selected = option;
                selectedlbl.Text = option;
                
                -- Close dropdown
                isopen = false;
                createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
                createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
                
                spawn(function()
                    wait(0.25);
                    droplist.Visible = false;
                end);
                
                callback(option);
            end);
        end;
    end;
    
    -- Initialize options
    createOptions();
    
    dropbtn.MouseButton1Click:Connect(function()
        isopen = not isopen;
        
        if isopen then
            positionDropdown();
            droplist.Visible = true;
            createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, maxHeight)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 180}):Play();
        else
            createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
            createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
            
            spawn(function()
                wait(0.25);
                droplist.Visible = false;
            end);
        end;
    end);
    
    -- // Close dropdown when clicking outside
    userinput.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and isopen then
            local mousePos = input.Position;
            local btnPos = dropbtn.AbsolutePosition;
            local btnSize = dropbtn.AbsoluteSize;
            local listPos = droplist.AbsolutePosition;
            local listSize = droplist.AbsoluteSize;
            
            local outsideBtn = mousePos.X < btnPos.X or mousePos.X > btnPos.X + btnSize.X or 
                              mousePos.Y < btnPos.Y or mousePos.Y > btnPos.Y + btnSize.Y;
            local outsideList = mousePos.X < listPos.X or mousePos.X > listPos.X + listSize.X or 
                               mousePos.Y < listPos.Y or mousePos.Y > listPos.Y + listSize.Y;
            
            if outsideBtn and outsideList then
                isopen = false;
                createtween(droplist, twinfo.fast, {Size = UDim2.new(0, droplist.Size.X.Offset, 0, 0)}):Play();
                createtween(arrow, twinfo.fast, {Rotation = 0}):Play();
                
                spawn(function()
                    wait(0.25);
                    droplist.Visible = false;
                end);
            end;
        end;
    end);
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetValue = function(option)
            if table.find(options, option) then
                selected = option;
                selectedlbl.Text = option;
                
                for _, btn in ipairs(scrollframe:GetChildren()) do
                    if btn:IsA("TextButton") then
                        if btn.Text == option then
                            createtween(btn, twinfo.fast, {BackgroundTransparency = 0.3, TextColor3 = clrs.pink}):Play();
                        else
                            createtween(btn, twinfo.fast, {BackgroundTransparency = 0.8, TextColor3 = clrs.white}):Play();
                        end;
                    end;
                end;
            end;
        end,
        GetValue = function()
            return selected;
        end,
        SetOptions = function(newoptions)
            options = newoptions;
            maxHeight = math.min(#options * 30, 150);
            createOptions();
            scrollframe.CanvasSize = UDim2.new(0, 0, 0, #options * 30);
        end
    };
end;

function components:AddLabel(parent, cfg)
    local cfg = cfg or {};
    local text = cfg.Text or "Label";
    local size = cfg.Size or 14;
    local color = cfg.Color or clrs.white;
    local separator = cfg.Separator;
    
    local labelframe = Instance.new("Frame");
    labelframe.Size = UDim2.new(1, 0, 0, size + 10);
    labelframe.BackgroundTransparency = 1;
    labelframe.BorderSizePixel = 0;
    labelframe.LayoutOrder = #parent:GetChildren();
    labelframe.Parent = parent;
    
    local label = Instance.new("TextLabel");
    label.Size = UDim2.new(1, 0, 1, 0);
    label.Position = UDim2.new(0, 0, 0, 0);
    label.BackgroundTransparency = 1;
    label.Text = text;
    label.TextColor3 = color;
    label.TextSize = size;
    label.Font = Enum.Font.Gotham;
    label.TextXAlignment = Enum.TextXAlignment.Left;
    label.TextWrapped = true;
    label.Parent = labelframe;
    
    registerElement(label, "texts", "white");
    
    -- // add separator if requested
    if separator then
        self:AddSeparator(parent, separator == true and {} or separator);
    end;
    
    return {
        SetText = function(newtext)
            label.Text = newtext;
        end,
        SetColor = function(newcolor)
            label.TextColor3 = newcolor;
        end
    };
end;

return components;