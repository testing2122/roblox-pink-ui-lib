-- // Pink UI Library Example with New Features
-- // Load the libraries
local PinkUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUIFixed.lua"))();
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/ComponentsFixes.lua"))();
local KeybindComponent = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/KeybindComponent.lua"))();
local Themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Themes.lua"))();

-- // Create window
local window = PinkUI:CreateWindow({
    Title = "Pink UI v2.0",
    Subtitle = "Updated with new features",
    TitleGradient = true
});

-- // Create tabs
local maintab = window:CreateTab({
    Name = "Main Features",
    Icon = "🏠"
});

local settingstab = window:CreateTab({
    Name = "Settings",
    Icon = "⚙️"
});

local keybindstab = window:CreateTab({
    Name = "Keybinds",
    Icon = "⌨️"
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

local miscbox = maintab:CreateBox({
    Name = "Miscellaneous",
    Column = "right",
    Height = 200
});

-- // Combat Features (with grey text when disabled)
Components:AddToggle(combatbox, {
    Name = "Auto Attack",
    Description = "Automatically attack nearby enemies",
    Default = false,
    Callback = function(value)
        print("Auto Attack:", value);
    end,
    Separator = true
});

Components:AddSlider(combatbox, {
    Name = "Attack Range",
    Description = "Set the range for auto attack",
    Min = 1,
    Max = 50,
    Default = 10,
    Increment = 1,
    Callback = function(value)
        print("Attack Range:", value);
    end,
    Separator = true
});

Components:AddDropdown(combatbox, {
    Name = "Weapon Type",
    Description = "Select your preferred weapon",
    Options = {"Sword", "Bow", "Staff", "Dagger", "Hammer"},
    Default = "Sword",
    Callback = function(value)
        print("Weapon Type:", value);
    end
});

-- // Visuals
Components:AddToggle(visualsbox, {
    Name = "ESP Items",
    Description = "Highlight items on the ground",
    Default = true,
    Callback = function(value)
        print("ESP Items:", value);
    end,
    Separator = true
});

Components:AddSlider(visualsbox, {
    Name = "ESP Distance",
    Description = "Maximum distance for ESP",
    Min = 50,
    Max = 1000,
    Default = 450,
    Increment = 25,
    Callback = function(value)
        print("ESP Distance:", value);
    end,
    Separator = true
});

Components:AddDropdown(visualsbox, {
    Name = "ESP Color",
    Description = "Choose ESP color scheme",
    Options = {"Red", "Green", "Blue", "Pink", "Yellow", "Cyan"},
    Default = "Red",
    Callback = function(value)
        print("ESP Color:", value);
    end
});

-- // Miscellaneous
Components:AddInput(miscbox, {
    Name = "Custom Message",
    Description = "Enter a custom message",
    Placeholder = "Type here...",
    Default = "hi",
    Callback = function(value)
        print("Custom Message:", value);
    end,
    Separator = true
});

Components:AddButton(miscbox, {
    Name = "Send Message",
    Description = "Send the custom message",
    Callback = function()
        print("Message sent!");
    end
});

-- // Settings Tab
local movementbox = settingstab:CreateBox({
    Name = "Movement",
    Column = "left",
    Height = 200
});

local themeBox = settingstab:CreateBox({
    Name = "Theme Settings",
    Column = "right",
    Height = 300
});

-- // Movement Settings
Components:AddSlider(movementbox, {
    Name = "Speed Multiplier",
    Description = "Adjust movement speed",
    Min = 1,
    Max = 10,
    Default = 5,
    Increment = 0.5,
    Callback = function(value)
        print("Speed Multiplier:", value);
    end,
    Separator = true
});

Components:AddToggle(movementbox, {
    Name = "Instantly teleport to spawn point",
    Default = false,
    Callback = function(value)
        print("Teleport to Spawn:", value);
    end
});

Components:AddButton(movementbox, {
    Name = "Teleport to Spawn",
    Callback = function()
        print("Teleporting to spawn...");
    end
});

-- // Theme Settings
local currentTheme = "Pink";
Components:AddDropdown(themeBox, {
    Name = "UI Theme",
    Description = "Choose your preferred color theme",
    Options = Themes:GetThemeNames(),
    Default = currentTheme,
    Callback = function(value)
        currentTheme = value;
        print("Theme changed to:", value);
        -- Note: Theme changing would require reloading the UI
    end,
    Separator = true
});

Components:AddLabel(themeBox, {
    Text = "Available Themes:",
    Size = 14,
    Separator = true
});

for _, themeName in ipairs(Themes:GetThemeNames()) do
    Components:AddLabel(themeBox, {
        Text = "• " .. themeName,
        Size = 12
    });
end;

-- // Keybinds Tab
local keybindsbox = keybindstab:CreateBox({
    Name = "Configure your keybinds:",
    Column = "left",
    Height = 400
});

local speedbox = keybindstab:CreateBox({
    Name = "Speed Toggle",
    Column = "right",
    Height = 150
});

-- // Keybind Examples
KeybindComponent:AddKeybind(keybindsbox, {
    Name = "Toggle Menu",
    Description = "Show/hide the UI",
    Default = Enum.KeyCode.Insert,
    Callback = function(key)
        print("Toggle Menu key set to:", key.Name);
    end,
    Separator = true
});

KeybindComponent:AddKeybind(keybindsbox, {
    Name = "Speed Toggle",
    Description = "Toggle speed hack",
    Default = Enum.KeyCode.LeftShift,
    Callback = function(key)
        print("Speed Toggle key set to:", key.Name);
    end,
    Separator = true
});

KeybindComponent:AddKeybind(keybindsbox, {
    Name = "Auto Attack",
    Description = "Toggle auto attack",
    Default = Enum.KeyCode.F,
    Callback = function(key)
        print("Auto Attack key set to:", key.Name);
    end,
    Separator = true
});

KeybindComponent:AddKeybind(keybindsbox, {
    Name = "ESP Toggle",
    Description = "Toggle ESP visibility",
    Default = Enum.KeyCode.V,
    Callback = function(key)
        print("ESP Toggle key set to:", key.Name);
    end
});

-- // Speed Settings
Components:AddToggle(speedbox, {
    Name = "Speed Enabled",
    Description = "Enable speed modifications",
    Default = false,
    Callback = function(value)
        print("Speed Enabled:", value);
    end,
    Separator = true
});

Components:AddSlider(speedbox, {
    Name = "Speed Value",
    Description = "Speed multiplier",
    Min = 1,
    Max = 20,
    Default = 5,
    Increment = 1,
    Callback = function(value)
        print("Speed Value:", value);
    end
});

print("Pink UI v2.0 loaded successfully!");
print("Features:");
print("• Keybind system with 'Press Key...' functionality");
print("• Toggle text turns grey when disabled");
print("• Fixed dropdown expansion in content areas");
print("• Fixed scrolling GUI cutoff issues");
print("• 8 different color themes available");
print("• Improved box system with better organization");