local PinkUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUIFixed.lua"))();
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/ComponentsFixed.lua"))();
local Themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Themes.lua"))();

if not PinkUI then
    warn("failed to load pinkui lib");
    return;
end;

if not Components then
    warn("failed to load components lib");
    return;
end;

if not Themes then
    warn("failed to load themes lib");
    return;
end;

print("libs loaded successfully!");

local window = PinkUI:CreateWindow({
    Title = "Pink UI Showcase",
    Subtitle = "all features demo",
    TitleGradient = true
});

local maintab = window:CreateTab({
    Name = "Main Features",
    Icon = "🏠"
});

local componentstab = window:CreateTab({
    Name = "All Components",
    Icon = "🧩"
});

local themestab = window:CreateTab({
    Name = "Themes",
    Icon = "🎨"
});

local advancedtab = window:CreateTab({
    Name = "Advanced",
    Icon = "⚙️"
});

local combatbox = maintab:CreateBox({
    Name = "Combat Features",
    Column = "left",
    Height = 320
});

local visualsbox = maintab:CreateBox({
    Name = "Visual Features",
    Column = "right",
    Height = 280
});

local movementbox = maintab:CreateBox({
    Name = "Movement",
    Column = "left",
    Height = 200
});

local utilsbox = maintab:CreateBox({
    Name = "Utilities",
    Column = "right",
    Height = 240
});

Components:AddToggle(combatbox, {
    Name = "Auto Attack",
    Description = "automatically attack nearby enemies",
    Default = false,
    Callback = function(value)
        print("auto attack:", value);
    end
});

Components:AddToggle(combatbox, {
    Name = "Auto Block",
    Description = "block incoming attacks automatically",
    Default = true,
    Separator = true,
    Callback = function(value)
        print("auto block:", value);
    end
});

Components:AddSlider(combatbox, {
    Name = "Attack Speed",
    Description = "delay between attacks",
    Min = 0.1,
    Max = 5.0,
    Default = 1.0,
    Increment = 0.1,
    Callback = function(value)
        print("attack speed:", value);
    end
});

Components:AddSlider(combatbox, {
    Name = "Attack Range",
    Description = "maximum attack distance",
    Min = 5,
    Max = 50,
    Default = 15,
    Increment = 1,
    Separator = true,
    Callback = function(value)
        print("attack range:", value);
    end
});

Components:AddButton(combatbox, {
    Name = "Reset Combat Stats",
    Description = "reset all combat related settings",
    Callback = function()
        print("combat stats reset");
    end
});

Components:AddToggle(visualsbox, {
    Name = "Player ESP",
    Description = "show player locations through walls",
    Default = false,
    Callback = function(value)
        print("player esp:", value);
    end
});

Components:AddToggle(visualsbox, {
    Name = "Item ESP",
    Description = "highlight valuable items",
    Default = false,
    Separator = true,
    Callback = function(value)
        print("item esp:", value);
    end
});

Components:AddSlider(visualsbox, {
    Name = "FOV",
    Description = "field of view setting",
    Min = 70,
    Max = 120,
    Default = 90,
    Increment = 5,
    Callback = function(value)
        print("fov:", value);
    end
});

Components:AddInput(visualsbox, {
    Name = "Target Player",
    Description = "username to target",
    Placeholder = "enter username...",
    Default = "",
    Separator = true,
    Callback = function(text)
        print("target player:", text);
    end
});

Components:AddToggle(movementbox, {
    Name = "Speed Hack",
    Description = "increase movement speed",
    Default = false,
    Callback = function(value)
        print("speed hack:", value);
    end
});

Components:AddSlider(movementbox, {
    Name = "Speed Multiplier",
    Description = "speed boost amount",
    Min = 1,
    Max = 10,
    Default = 2,
    Increment = 0.5,
    Callback = function(value)
        print("speed multiplier:", value);
    end
});

Components:AddToggle(movementbox, {
    Name = "No Clip",
    Description = "walk through walls",
    Default = false,
    Separator = true,
    Callback = function(value)
        print("no clip:", value);
    end
});

Components:AddToggle(utilsbox, {
    Name = "Auto Farm",
    Description = "automatically farm resources",
    Default = false,
    Callback = function(value)
        print("auto farm:", value);
    end
});

Components:AddToggle(utilsbox, {
    Name = "Anti AFK",
    Description = "prevent getting kicked for inactivity",
    Default = true,
    Separator = true,
    Callback = function(value)
        print("anti afk:", value);
    end
});

Components:AddInput(utilsbox, {
    Name = "Farm Item",
    Description = "item to farm",
    Placeholder = "item name...",
    Default = "coins",
    Callback = function(text)
        print("farm item:", text);
    end
});

Components:AddButton(utilsbox, {
    Name = "Teleport to Spawn",
    Description = "instantly teleport to spawn location",
    Separator = true,
    Callback = function()
        print("teleporting to spawn");
    end
});

local togglesbox = componentstab:CreateBox({
    Name = "Toggle Components",
    Column = "left",
    Height = 350
});

local slidersbox = componentstab:CreateBox({
    Name = "Slider Components",
    Column = "right",
    Height = 300
});

local inputsbox = componentstab:CreateBox({
    Name = "Input & Button Components",
    Column = "left",
    Height = 280
});

local labelsbox = componentstab:CreateBox({
    Name = "Label & Dropdown Components",
    Column = "right",
    Height = 320
});

Components:AddToggle(togglesbox, {
    Name = "Basic Toggle",
    Description = "simple on/off toggle",
    Default = false,
    Callback = function(value)
        print("basic toggle:", value);
    end
});

Components:AddToggle(togglesbox, {
    Name = "Pre-enabled Toggle",
    Description = "starts enabled by default",
    Default = true,
    Callback = function(value)
        print("pre-enabled toggle:", value);
    end
});

Components:AddToggle(togglesbox, {
    Name = "Toggle with Separator",
    Description = "has separator below it",
    Default = false,
    Separator = true,
    Callback = function(value)
        print("toggle with separator:", value);
    end
});

Components:AddToggle(togglesbox, {
    Name = "Feature Toggle A",
    Default = false,
    Callback = function(value)
        print("feature a:", value);
    end
});

Components:AddToggle(togglesbox, {
    Name = "Feature Toggle B",
    Default = true,
    Callback = function(value)
        print("feature b:", value);
    end
});

Components:AddSlider(slidersbox, {
    Name = "Integer Slider",
    Description = "whole numbers only",
    Min = 1,
    Max = 100,
    Default = 50,
    Increment = 1,
    Callback = function(value)
        print("integer slider:", value);
    end
});

Components:AddSlider(slidersbox, {
    Name = "Decimal Slider",
    Description = "precise decimal values",
    Min = 0.0,
    Max = 1.0,
    Default = 0.5,
    Increment = 0.01,
    Separator = true,
    Callback = function(value)
        print("decimal slider:", value);
    end
});

Components:AddSlider(slidersbox, {
    Name = "Speed Setting",
    Min = 0.1,
    Max = 5.0,
    Default = 1.0,
    Increment = 0.1,
    Callback = function(value)
        print("speed setting:", value);
    end
});

Components:AddSlider(slidersbox, {
    Name = "Range Setting",
    Min = 10,
    Max = 500,
    Default = 100,
    Increment = 10,
    Callback = function(value)
        print("range setting:", value);
    end
});

Components:AddInput(inputsbox, {
    Name = "Text Input",
    Description = "enter any text",
    Placeholder = "type here...",
    Default = "",
    Callback = function(text)
        print("text input:", text);
    end
});

Components:AddInput(inputsbox, {
    Name = "Number Input",
    Description = "numeric values only",
    Placeholder = "123",
    Default = "50",
    Separator = true,
    Callback = function(text)
        print("number input:", text);
    end
});

Components:AddButton(inputsbox, {
    Name = "Execute Script",
    Description = "run custom lua code",
    Callback = function()
        print("executing script");
    end
});

Components:AddButton(inputsbox, {
    Name = "Save Settings",
    Description = "save current configuration",
    Separator = true,
    Callback = function()
        print("saving settings");
    end
});

Components:AddButton(inputsbox, {
    Name = "Load Settings",
    Description = "load saved configuration",
    Callback = function()
        print("loading settings");
    end
});

Components:AddLabel(labelsbox, {
    Text = "Information Labels",
    Size = 16,
    Color = Color3.fromRGB(255, 255, 255)
});

Components:AddLabel(labelsbox, {
    Text = "current status: active",
    Size = 14,
    Color = Color3.fromRGB(120, 120, 125)
});

Components:AddLabel(labelsbox, {
    Text = "features enabled: 5/10",
    Size = 14,
    Color = Color3.fromRGB(255, 105, 180)
});

Components:AddDropdown(labelsbox, {
    Name = "Game Mode",
    Options = {"survival", "creative", "adventure", "spectator"},
    Default = "survival",
    Separator = true,
    Callback = function(selected)
        print("game mode:", selected);
    end
});

Components:AddDropdown(labelsbox, {
    Name = "Difficulty",
    Options = {"easy", "normal", "hard", "expert"},
    Default = "normal",
    Callback = function(selected)
        print("difficulty:", selected);
    end
});

local themebox = themestab:CreateBox({
    Name = "Color Themes",
    Column = "left",
    Height = 450
});

local themepreviewbox = themestab:CreateBox({
    Name = "Theme Preview",
    Column = "right",
    Height = 400
});

local function applyTheme(themeName)
    print("applying", themeName, "theme");
    local selectedTheme = Themes:GetTheme(themeName);
    if selectedTheme then
        PinkUI:ApplyTheme(selectedTheme);
        Components:ApplyTheme(selectedTheme);
        print("applied", themeName, "theme successfully");
        return true;
    else
        warn("theme", themeName, "not found");
        return false;
    end;
end;

local availableThemes = {"Pink", "Blue", "Purple", "Green", "Orange", "Red", "Dark", "Cyan"};

for i, themeName in ipairs(availableThemes) do
    Components:AddButton(themebox, {
        Name = themeName .. " Theme",
        Description = "apply " .. themeName:lower() .. " color scheme",
        Separator = i < #availableThemes,
        Callback = function()
            applyTheme(themeName);
        end
    });
end;

Components:AddLabel(themepreviewbox, {
    Text = "Theme Preview Elements",
    Size = 16,
    Color = Color3.fromRGB(255, 255, 255)
});

Components:AddToggle(themepreviewbox, {
    Name = "Preview Toggle",
    Description = "shows theme colors",
    Default = true,
    Callback = function(value)
        print("preview toggle:", value);
    end
});

Components:AddSlider(themepreviewbox, {
    Name = "Preview Slider",
    Description = "demonstrates slider colors",
    Min = 0,
    Max = 100,
    Default = 75,
    Increment = 1,
    Separator = true,
    Callback = function(value)
        print("preview slider:", value);
    end
});

Components:AddInput(themepreviewbox, {
    Name = "Preview Input",
    Description = "shows input field styling",
    Placeholder = "theme test...",
    Default = "",
    Callback = function(text)
        print("preview input:", text);
    end
});

Components:AddButton(themepreviewbox, {
    Name = "Preview Button",
    Description = "demonstrates button styling",
    Separator = true,
    Callback = function()
        print("preview button clicked");
    end
});

local configbox = advancedtab:CreateBox({
    Name = "Configuration",
    Column = "left",
    Height = 350
});

local debugbox = advancedtab:CreateBox({
    Name = "Debug Tools",
    Column = "right",
    Height = 300
});

local scriptsbox = advancedtab:CreateBox({
    Name = "Script Management",
    Column = "left",
    Height = 250
});

Components:AddToggle(configbox, {
    Name = "Auto Save Config",
    Description = "automatically save settings",
    Default = true,
    Callback = function(value)
        print("auto save config:", value);
    end
});

Components:AddSlider(configbox, {
    Name = "Save Interval",
    Description = "minutes between auto saves",
    Min = 1,
    Max = 30,
    Default = 5,
    Increment = 1,
    Separator = true,
    Callback = function(value)
        print("save interval:", value, "minutes");
    end
});

Components:AddInput(configbox, {
    Name = "Config Name",
    Description = "name for saved configuration",
    Placeholder = "my config...",
    Default = "default",
    Callback = function(text)
        print("config name:", text);
    end
});

Components:AddButton(configbox, {
    Name = "Export Config",
    Description = "export settings to clipboard",
    Separator = true,
    Callback = function()
        print("exporting config");
    end
});

Components:AddButton(configbox, {
    Name = "Import Config",
    Description = "import settings from clipboard",
    Callback = function()
        print("importing config");
    end
});

Components:AddToggle(debugbox, {
    Name = "Debug Mode",
    Description = "enable debug logging",
    Default = false,
    Callback = function(value)
        print("debug mode:", value);
    end
});

Components:AddToggle(debugbox, {
    Name = "Performance Monitor",
    Description = "show fps and memory usage",
    Default = false,
    Separator = true,
    Callback = function(value)
        print("performance monitor:", value);
    end
});

Components:AddButton(debugbox, {
    Name = "Clear Console",
    Description = "clear debug console output",
    Callback = function()
        print("console cleared");
    end
});

Components:AddButton(debugbox, {
    Name = "Generate Report",
    Description = "create debug report",
    Separator = true,
    Callback = function()
        print("generating debug report");
    end
});

Components:AddDropdown(scriptsbox, {
    Name = "Active Scripts",
    Options = {"main script", "auto farm", "esp system", "anti cheat bypass"},
    Default = "main script",
    Callback = function(selected)
        print("selected script:", selected);
    end
});

Components:AddButton(scriptsbox, {
    Name = "Reload Scripts",
    Description = "restart all active scripts",
    Separator = true,
    Callback = function()
        print("reloading scripts");
    end
});

Components:AddButton(scriptsbox, {
    Name = "Emergency Stop",
    Description = "stop all scripts immediately",
    Callback = function()
        print("emergency stop activated");
    end
});

print("pink ui showcase loaded");
print("features demonstrated:");
print("- toggles, sliders, buttons, inputs, dropdowns, labels");
print("- theme system with 8 color schemes");
print("- box layout system with left/right columns");
print("- component descriptions and separators");
print("- advanced configuration options");
print("click any theme button to see live color changes");

spawn(function()
    wait(3);
    print("auto demo: applying blue theme");
    applyTheme("Blue");
    wait(2);
    print("theme applied - notice all elements changed color");
end);