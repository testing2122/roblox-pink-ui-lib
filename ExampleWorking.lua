-- // Pink UI Library Working Example with Theme System
-- // This example works with the current ComponentsFixed.lua file

local PinkUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUIFixed.lua"))();
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/ComponentsFixed.lua"))();
local Themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Themes.lua"))();

-- // Check if Components loaded correctly
if not Components then
    warn("Failed to load Components library!");
    return;
end;

if not Components.ApplyTheme then
    warn("ApplyTheme function not found in Components!");
    return;
end;

print("Components loaded successfully!");
print("Available functions:", table.concat({"AddToggle", "AddButton", "AddSlider", "AddInput", "AddSeparator", "ApplyTheme"}, ", "));

-- // Create window
local window = PinkUI:CreateWindow({
    Title = "Pink UI v2.0 Working",
    Subtitle = "Theme system functional",
    TitleGradient = true
});

-- // Create tabs
local maintab = window:CreateTab({
    Name = "Main Features",
    Icon = "🏠"
});

local themestab = window:CreateTab({
    Name = "Theme Settings",
    Icon = "🎨"
});

-- // Main Features Tab
local combatbox = maintab:CreateBox({
    Name = "Combat Features",
    Column = "left",
    Height = 300
});

local visualsbox = maintab:CreateBox({
    Name = "Visuals",
    Column = "right",
    Height = 250
});

-- // Combat Features
Components:AddToggle(combatbox, {
    Name = "Auto Attack",
    Description = "Automatically attack enemies",
    Default = false,
    Callback = function(value)
        print("Auto Attack:", value);
    end
});

Components:AddToggle(combatbox, {
    Name = "Auto Block",
    Description = "Automatically block incoming attacks",
    Default = true,
    Separator = true,
    Callback = function(value)
        print("Auto Block:", value);
    end
});

Components:AddSlider(combatbox, {
    Name = "Attack Speed",
    Description = "Speed of automatic attacks",
    Min = 1,
    Max = 10,
    Default = 5,
    Increment = 1,
    Callback = function(value)
        print("Attack Speed:", value);
    end
});

Components:AddButton(combatbox, {
    Name = "Reset Combat",
    Description = "Reset all combat settings",
    Separator = {Height = 20, Color = Color3.fromRGB(255, 105, 180)},
    Callback = function()
        print("Combat settings reset!");
    end
});

-- // Visuals
Components:AddToggle(visualsbox, {
    Name = "ESP",
    Description = "Show enemy positions",
    Default = false,
    Callback = function(value)
        print("ESP:", value);
    end
});

Components:AddSlider(visualsbox, {
    Name = "FOV",
    Description = "Field of view setting",
    Min = 70,
    Max = 120,
    Default = 90,
    Increment = 5,
    Separator = true,
    Callback = function(value)
        print("FOV:", value);
    end
});

Components:AddInput(visualsbox, {
    Name = "Player Name",
    Description = "Enter target player name",
    Placeholder = "Username...",
    Default = "",
    Callback = function(text)
        print("Target player:", text);
    end
});

-- // Theme Settings Tab
local themebox = themestab:CreateBox({
    Name = "Color Themes",
    Column = "left",
    Height = 400
});

local settingsbox = themestab:CreateBox({
    Name = "UI Settings",
    Column = "right",
    Height = 300
});

-- // Theme Buttons (since dropdown isn't available yet)
local availableThemes = {"Pink", "Blue", "Purple", "Green", "Orange", "Red", "Dark", "Cyan"};

for i, themeName in ipairs(availableThemes) do
    Components:AddButton(themebox, {
        Name = "Apply " .. themeName .. " Theme",
        Description = "Switch to " .. themeName:lower() .. " color scheme",
        Separator = i < #availableThemes,
        Callback = function()
            print("Applying", themeName, "theme...");
            local selectedTheme = Themes:GetTheme(themeName);
            if selectedTheme then
                Components:ApplyTheme(selectedTheme);
                print("✅ Applied", themeName, "theme successfully!");
                
                -- Update window title to show current theme
                local screenGui = game:GetService("CoreGui"):FindFirstChild("PinkUI");
                if screenGui and screenGui:FindFirstChild("Main") then
                    local titlebar = screenGui.Main:FindFirstChild("TitleBar");
                    if titlebar and titlebar:FindFirstChild("Subtitle") then
                        titlebar.Subtitle.Text = "Current theme: " .. themeName;
                    end;
                end;
            else
                warn("❌ Theme", themeName, "not found!");
            end;
        end
    });
end;

-- // UI Settings
Components:AddToggle(settingsbox, {
    Name = "Show Notifications",
    Description = "Display system notifications",
    Default = true,
    Callback = function(value)
        print("Notifications:", value);
    end
});

Components:AddSlider(settingsbox, {
    Name = "UI Scale",
    Description = "Scale of the user interface",
    Min = 50,
    Max = 150,
    Default = 100,
    Increment = 10,
    Separator = true,
    Callback = function(value)
        print("UI Scale:", value, "%");
    end
});

Components:AddToggle(settingsbox, {
    Name = "Auto Save",
    Description = "Automatically save progress",
    Default = true,
    Separator = true,
    Callback = function(value)
        print("Auto Save:", value);
    end
});

Components:AddInput(settingsbox, {
    Name = "Save Interval",
    Description = "Minutes between auto saves",
    Placeholder = "5",
    Default = "5",
    Callback = function(text)
        print("Save interval:", text, "minutes");
    end
});

-- // Add some visual feedback
Components:AddSeparator(themebox, {
    Height = 30,
    Color = Color3.fromRGB(255, 105, 180),
    Transparency = 0.3
});

print("🎨 Pink UI Library loaded successfully!");
print("✨ Theme system is working!");
print("🔄 Click any theme button to see smooth color transitions!");
print("📱 Available themes:", table.concat(availableThemes, ", "));

-- // Auto-apply a random theme after 3 seconds for demo
spawn(function()
    wait(3);
    local randomTheme = availableThemes[math.random(1, #availableThemes)];
    if randomTheme ~= "Pink" then -- Don't change if already pink
        print("🎲 Auto-applying", randomTheme, "theme for demo...");
        local theme = Themes:GetTheme(randomTheme);
        if theme then
            Components:ApplyTheme(theme);
            print("🌈 Demo theme applied! Try the other theme buttons!");
        end;
    end;
end);