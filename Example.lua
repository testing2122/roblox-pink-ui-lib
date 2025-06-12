-- // example usage of PinkUI library
-- // load the library files first
local pnkui = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUI.lua"))();
local components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Components.lua"))();

-- // create window
local window = pnkui:CreateWindow({
    Title = "Pink UI Demo",
    Subtitle = "by testing2122"
});

-- // create tabs
local maintab = window:CreateTab({
    Name = "Main",
    Icon = "🏠"
});

local settingstab = window:CreateTab({
    Name = "Settings",
    Icon = "⚙️"
});

local misctab = window:CreateTab({
    Name = "Misc",
    Icon = "🎯"
});

-- // add components to main tab
maintab:AddSeparator("Basic Components");

components:AddButton(maintab.content, {
    Text = "Click Me!",
    Callback = function()
        print("button clicked!");
    end
});

local toggle = components:AddToggle(maintab.content, {
    Text = "Enable Feature",
    Default = false,
    Callback = function(state)
        print("toggle state:", state);
    end
});

local slider = components:AddSlider(maintab.content, {
    Text = "Speed Multiplier",
    Min = 1,
    Max = 10,
    Default = 5,
    Suffix = "x",
    Callback = function(value)
        print("slider value:", value);
    end
});

maintab:AddSeparator("Input Components");

local input = components:AddInput(maintab.content, {
    Text = "Player Name",
    Placeholder = "Enter player name...",
    Callback = function(text)
        print("input text:", text);
    end
});

components:AddLabel(maintab.content, {
    Text = "This is a label component that can display information.",
    Size = 12
});

-- // add components to settings tab
settingstab:AddSeparator("Visual Settings");

components:AddToggle(settingstab.content, {
    Text = "Enable Animations",
    Default = true,
    Callback = function(state)
        print("animations:", state);
    end
});

components:AddSlider(settingstab.content, {
    Text = "UI Scale",
    Min = 0.5,
    Max = 2,
    Default = 1,
    Suffix = "x",
    Callback = function(value)
        print("ui scale:", value);
    end
});

components:AddToggle(settingstab.content, {
    Text = "Show Notifications",
    Default = true,
    Callback = function(state)
        print("notifications:", state);
    end
});

settingstab:AddSeparator("Performance");

components:AddSlider(settingstab.content, {
    Text = "Max FPS",
    Min = 30,
    Max = 144,
    Default = 60,
    Suffix = " fps",
    Callback = function(value)
        print("max fps:", value);
    end
});

-- // add components to misc tab
misctab:AddSeparator("Utility Functions");

components:AddButton(misctab.content, {
    Text = "Reset All Settings",
    Callback = function()
        print("resetting all settings...");
        toggle:SetValue(false);
        slider:SetValue(5);
        input:SetValue("");
    end
});

components:AddButton(misctab.content, {
    Text = "Copy Debug Info",
    Callback = function()
        local info = {
            "Pink UI Debug Info:",
            "Toggle State: " .. tostring(toggle:GetValue()),
            "Slider Value: " .. tostring(slider:GetValue()),
            "Input Text: " .. input:GetValue(),
            "Timestamp: " .. os.date()
        };
        setclipboard(table.concat(info, "\n"));
        print("debug info copied to clipboard");
    end
});

misctab:AddSeparator("Advanced Features");

components:AddInput(misctab.content, {
    Text = "Execute Lua Code",
    Placeholder = "print('hello world')",
    Callback = function(code)
        if code ~= "" then
            local success, result = pcall(loadstring(code));
            if success then
                print("executed successfully:", result);
            else
                warn("execution failed:", result);
            end;
        end;
    end
});

components:AddLabel(misctab.content, {
    Text = "Warning: Only execute trusted code!",
    Color = Color3.fromRGB(255, 200, 100)
});

print("Pink UI Demo loaded successfully!");
print("Repository: https://github.com/testing2122/roblox-pink-ui-lib");