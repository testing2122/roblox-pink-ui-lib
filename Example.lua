-- // Pink UI Library Example with Box System and Separators
-- // Load the libraries
local PinkUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUI.lua"))();
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Components.lua"))();

-- // Create the main window
local Window = PinkUI:CreateWindow({
    Title = "Pink UI Library",
    Subtitle = "Box System Example",
    TitleGradient = true -- Enable animated gradient on title
});

-- // Create tabs
local MainTab = Window:CreateTab({
    Name = "Main Features",
    Icon = "🏠"
});

local SettingsTab = Window:CreateTab({
    Name = "Settings", 
    Icon = "⚙️"
});

local ExtraTab = Window:CreateTab({
    Name = "Extra",
    Icon = "✨"
});

-- // MAIN TAB - Create boxes in left and right columns
-- // Left column boxes
local CombatBox = MainTab:CreateBox({
    Name = "Combat Features",
    Column = "left",
    Height = 300
});

local MovementBox = MainTab:CreateBox({
    Name = "Movement",
    Column = "left", 
    Height = 250
});

-- // Right column boxes
local VisualsBox = MainTab:CreateBox({
    Name = "Visuals",
    Column = "right",
    Height = 350
});

local MiscBox = MainTab:CreateBox({
    Name = "Miscellaneous",
    Column = "right",
    Height = 200
});

-- // Add components to Combat box WITH SEPARATORS
Components:AddToggle(CombatBox, {
    Name = "Auto Attack",
    Description = "Automatically attack nearby enemies",
    Default = false,
    Separator = true, -- Add separator after this component
    Callback = function(value)
        print("Auto Attack:", value);
    end
});

Components:AddSlider(CombatBox, {
    Name = "Attack Range",
    Description = "Set the range for auto attack",
    Min = 1,
    Max = 50,
    Default = 10,
    Increment = 1,
    Separator = true, -- Add separator after this component
    Callback = function(value)
        print("Attack Range:", value);
    end
});

Components:AddDropdown(CombatBox, {
    Name = "Weapon Type",
    Description = "Select your preferred weapon",
    Options = {"Sword", "Bow", "Staff", "Dagger"},
    Default = "Sword",
    Callback = function(value)
        print("Weapon Type:", value);
    end
});

-- // Add components to Movement box WITH CUSTOM SEPARATORS
Components:AddToggle(MovementBox, {
    Name = "Speed Boost",
    Description = "Increase movement speed",
    Default = false,
    Separator = {
        Height = 20,
        Color = Color3.fromRGB(255, 105, 180),
        Transparency = 0.3
    },
    Callback = function(value)
        print("Speed Boost:", value);
    end
});

Components:AddSlider(MovementBox, {
    Name = "Speed Multiplier",
    Min = 1,
    Max = 5,
    Default = 2,
    Increment = 0.1,
    Separator = true,
    Callback = function(value)
        print("Speed Multiplier:", value);
    end
});

Components:AddButton(MovementBox, {
    Name = "Teleport to Spawn",
    Description = "Instantly teleport to spawn point",
    Callback = function()
        print("Teleporting to spawn!");
    end
});

-- // Add components to Visuals box
Components:AddToggle(VisualsBox, {
    Name = "ESP Players",
    Description = "Show player outlines through walls",
    Default = false,
    Separator = true,
    Callback = function(value)
        print("ESP Players:", value);
    end
});

Components:AddToggle(VisualsBox, {
    Name = "ESP Items",
    Description = "Highlight items on the ground",
    Default = false,
    Separator = true,
    Callback = function(value)
        print("ESP Items:", value);
    end
});

Components:AddSlider(VisualsBox, {
    Name = "ESP Distance",
    Description = "Maximum distance for ESP",
    Min = 50,
    Max = 1000,
    Default = 500,
    Increment = 50,
    Separator = true,
    Callback = function(value)
        print("ESP Distance:", value);
    end
});

Components:AddDropdown(VisualsBox, {
    Name = "ESP Color",
    Options = {"Red", "Green", "Blue", "Yellow", "Purple"},
    Default = "Red",
    Callback = function(value)
        print("ESP Color:", value);
    end
});

-- // Add components to Misc box
Components:AddInput(MiscBox, {
    Name = "Custom Message",
    Placeholder = "Enter message...",
    Separator = true,
    Callback = function(value)
        print("Custom Message:", value);
    end
});

Components:AddButton(MiscBox, {
    Name = "Send Message",
    Callback = function()
        print("Message sent!");
    end
});

-- // SETTINGS TAB - More boxes
local UIBox = SettingsTab:CreateBox({
    Name = "UI Settings",
    Column = "left",
    Height = 250
});

local KeybindsBox = SettingsTab:CreateBox({
    Name = "Keybinds",
    Column = "right", 
    Height = 300
});

-- // UI Settings with separators
Components:AddToggle(UIBox, {
    Name = "Show Notifications",
    Default = true,
    Separator = true,
    Callback = function(value)
        print("Show Notifications:", value);
    end
});

Components:AddSlider(UIBox, {
    Name = "UI Scale",
    Min = 0.5,
    Max = 2,
    Default = 1,
    Increment = 0.1,
    Callback = function(value)
        print("UI Scale:", value);
    end
});

-- // Keybinds with separators
Components:AddLabel(KeybindsBox, {
    Text = "Configure your keybinds:",
    Size = 14,
    Separator = true
});

Components:AddInput(KeybindsBox, {
    Name = "Toggle Menu",
    Default = "Insert",
    Separator = true,
    Callback = function(value)
        print("Toggle Menu Key:", value);
    end
});

Components:AddInput(KeybindsBox, {
    Name = "Speed Toggle",
    Default = "LeftShift",
    Callback = function(value)
        print("Speed Toggle Key:", value);
    end
});

-- // EXTRA TAB - Single large box with manual separators
local InfoBox = ExtraTab:CreateBox({
    Name = "Information",
    Column = "left",
    Height = 450
});

Components:AddLabel(InfoBox, {
    Text = "Pink UI Library v2.0",
    Size = 18,
    Color = Color3.fromRGB(255, 105, 180),
    Separator = {
        Height = 25,
        Color = Color3.fromRGB(255, 105, 180),
        Transparency = 0.5
    }
});

Components:AddLabel(InfoBox, {
    Text = "Features:",
    Size = 14,
    Separator = true
});

Components:AddLabel(InfoBox, {
    Text = "• Scrollable boxes in left/right columns",
    Size = 12
});

Components:AddLabel(InfoBox, {
    Text = "• Customizable box heights",
    Size = 12
});

Components:AddLabel(InfoBox, {
    Text = "• Optional separators between components",
    Size = 12
});

Components:AddLabel(InfoBox, {
    Text = "• Animated gradient title (toggle with G)",
    Size = 12
});

Components:AddLabel(InfoBox, {
    Text = "• Modern pink/black theme",
    Size = 12,
    Separator = {
        Height = 20,
        Color = Color3.fromRGB(255, 105, 180),
        Transparency = 0.7
    }
});

-- // Manual separator
Components:AddSeparator(InfoBox, {
    Height = 25,
    Color = Color3.fromRGB(255, 150, 200),
    Transparency = 0.3
});

Components:AddButton(InfoBox, {
    Name = "GitHub Repository",
    Description = "Open the GitHub page",
    Callback = function()
        setclipboard("https://github.com/testing2122/roblox-pink-ui-lib");
        print("GitHub URL copied to clipboard!");
    end
});

print("Pink UI Library loaded successfully!");
print("Features:");
print("• Use :CreateBox() to create scrollable containers");
print("• Add Separator = true to components for default separators");
print("• Add Separator = {Height = 20, Color = Color3.new(), Transparency = 0.5} for custom separators");
print("• Use Components:AddSeparator() for manual separators");