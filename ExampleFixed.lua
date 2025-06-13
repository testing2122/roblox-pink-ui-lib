-- // Pink UI Library Example with All Features Working
-- // Load the correct libraries
local PinkUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUIFixed.lua"))();
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/ComponentsFixed.lua"))(); -- Fixed version
local KeybindComponent = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/KeybindComponent.lua"))();
local Themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Themes.lua"))();

-- // Create window
local window = PinkUI:CreateWindow({
    Title = "Pink UI v2.0 Fixed",
    Subtitle = "All features working",
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

Components:AddDropdown(visualsbox, {
    Name = "UI Theme",
    Description = "Choose your preferred color theme",
    Options = {"Pink", "Blue", "Purple", "Green", "Orange", "Red", "Dark", "Cyan"},
    Default = "Pink",
    Separator = true,
    Callback = function(selected)
        print("Theme changed to:", selected);
        -- Apply the selected theme
        if Themes[selected] then
            Components:ApplyTheme(Themes[selected]);
            print("Applied", selected, "theme successfully!");
        end;
    end
});

Components:AddSlider(visualsbox, {
    Name = "FOV",
    Description = "Field of view setting",
    Min = 70,
    Max = 120,
    Default = 90,
    Increment = 5,
    Callback = function(value)
        print("FOV:", value);
    end
});

-- // Miscellaneous
Components:AddInput(miscbox, {
    Name = "Player Name",
    Description = "Enter target player name",
    Placeholder = "Username...",
    Default = "",
    Callback = function(text)
        print("Target player:", text);
    end
});

Components:AddLabel(miscbox, {
    Text = "Status: Ready",
    Size = 14,
    Color = Color3.fromRGB(100, 255, 100),
    Separator = true
});

-- // Settings Tab
local uibox = settingstab:CreateBox({
    Name = "UI Settings",
    Column = "left",
    Height = 250
});

local gameplaybox = settingstab:CreateBox({
    Name = "Gameplay",
    Column = "right",
    Height = 200
});

-- // UI Settings
Components:AddToggle(uibox, {
    Name = "Show Notifications",
    Description = "Display system notifications",
    Default = true,
    Callback = function(value)
        print("Notifications:", value);
    end
});

Components:AddSlider(uibox, {
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

Components:AddDropdown(uibox, {
    Name = "Language",
    Description = "Interface language",
    Options = {"English", "Spanish", "French", "German", "Japanese"},
    Default = "English",
    Callback = function(selected)
        print("Language:", selected);
    end
});

-- // Gameplay Settings
Components:AddToggle(gameplaybox, {
    Name = "Auto Save",
    Description = "Automatically save progress",
    Default = true,
    Callback = function(value)
        print("Auto Save:", value);
    end
});

Components:AddInput(gameplaybox, {
    Name = "Save Interval",
    Description = "Minutes between auto saves",
    Placeholder = "5",
    Default = "5",
    Separator = true,
    Callback = function(text)
        print("Save interval:", text, "minutes");
    end
});

-- // Keybinds Tab
local keybindbox = keybindstab:CreateBox({
    Name = "Key Bindings",
    Column = "left",
    Height = 400
});

local macrobox = keybindstab:CreateBox({
    Name = "Macros",
    Column = "right",
    Height = 300
});

-- // Key Bindings using KeybindComponent
KeybindComponent:AddKeybind(keybindbox, {
    Name = "Toggle ESP",
    Description = "Show/hide enemy ESP",
    DefaultKey = "E",
    Callback = function(key)
        print("ESP keybind set to:", key);
    end
});

KeybindComponent:AddKeybind(keybindbox, {
    Name = "Auto Attack",
    Description = "Toggle automatic attacking",
    DefaultKey = "F",
    Separator = true,
    Callback = function(key)
        print("Auto Attack keybind set to:", key);
    end
});

KeybindComponent:AddKeybind(keybindbox, {
    Name = "Speed Boost",
    Description = "Activate speed boost",
    DefaultKey = "LeftShift",
    Callback = function(key)
        print("Speed Boost keybind set to:", key);
    end
});

-- // Macros
Components:AddButton(macrobox, {
    Name = "Record Macro",
    Description = "Start recording a new macro",
    Callback = function()
        print("Started recording macro");
    end
});

Components:AddDropdown(macrobox, {
    Name = "Saved Macros",
    Description = "Select a saved macro to execute",
    Options = {"Combat Combo", "Farm Route", "Quick Heal"},
    Default = "Combat Combo",
    Separator = true,
    Callback = function(selected)
        print("Selected macro:", selected);
    end
});

Components:AddButton(macrobox, {
    Name = "Execute Macro",
    Description = "Run the selected macro",
    Callback = function()
        print("Executing macro");
    end
});

-- // Add some separators for organization
Components:AddSeparator(keybindbox, {
    Height = 25,
    Color = Color3.fromRGB(255, 105, 180),
    Transparency = 0.3
});

Components:AddLabel(keybindbox, {
    Text = "Advanced Keybinds",
    Size = 16,
    Color = Color3.fromRGB(255, 150, 200)
});

KeybindComponent:AddKeybind(keybindbox, {
    Name = "Emergency Stop",
    Description = "Stop all automated functions",
    DefaultKey = "X",
    Callback = function(key)
        print("Emergency Stop keybind set to:", key);
    end
});

print("Pink UI Library loaded successfully!");
print("- Dropdown positioning fixed");
print("- Theme switching enabled");
print("- All components working");
print("- Keybind system active");