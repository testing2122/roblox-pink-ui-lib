-- // enhanced example usage of PinkUI library
-- // load the library files
local pnkui = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUI.lua"))();
local components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Components.lua"))();
local extensions = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Extensions.lua"))();

-- // create modern window
local window = pnkui:CreateWindow({
    Title = "INSANITY",
    Subtitle = "Premium Experience"
});

-- // create multiple tabs to showcase scrolling
local maintab = window:CreateTab({
    Name = "Main",
    Icon = "🏠"
});

local combattab = window:CreateTab({
    Name = "Combat",
    Icon = "⚔️"
});

local visualtab = window:CreateTab({
    Name = "Visuals", 
    Icon = "👁️"
});

local playertab = window:CreateTab({
    Name = "Player",
    Icon = "🏃"
});

local misctab = window:CreateTab({
    Name = "Misc",
    Icon = "🔧"
});

local settingstab = window:CreateTab({
    Name = "Settings",
    Icon = "⚙️"
});

local configtab = window:CreateTab({
    Name = "Config",
    Icon = "💾"
});

-- // MAIN TAB
maintab:AddSeparator("Core Features");

local autofarm = components:AddToggle(maintab.content, {
    Text = "Auto Farm",
    Default = false,
    Callback = function(state)
        print("Auto Farm:", state);
    end
});

components:AddSlider(maintab.content, {
    Text = "Farm Speed",
    Min = 1,
    Max = 20,
    Default = 10,
    Suffix = "x",
    Callback = function(value)
        print("Farm Speed:", value);
    end
});

components:AddToggle(maintab.content, {
    Text = "Auto Collect",
    Default = true,
    Callback = function(state)
        print("Auto Collect:", state);
    end
});

maintab:AddSeparator("Protection");

components:AddToggle(maintab.content, {
    Text = "Anti AFK",
    Default = true,
    Callback = function(state)
        print("Anti AFK:", state);
    end
});

components:AddToggle(maintab.content, {
    Text = "Safe Mode",
    Default = false,
    Callback = function(state)
        print("Safe Mode:", state);
    end
});

-- // COMBAT TAB
combattab:AddSeparator("Aimbot");

components:AddToggle(combattab.content, {
    Text = "Aimbot",
    Default = false,
    Callback = function(state)
        print("Aimbot:", state);
    end
});

components:AddSlider(combattab.content, {
    Text = "FOV Size",
    Min = 50,
    Max = 500,
    Default = 200,
    Suffix = "px",
    Callback = function(value)
        print("FOV:", value);
    end
});

components:AddSlider(combattab.content, {
    Text = "Smoothing",
    Min = 1,
    Max = 10,
    Default = 5,
    Suffix = "",
    Callback = function(value)
        print("Smoothing:", value);
    end
});

combattab:AddSeparator("Combat Assists");

components:AddToggle(combattab.content, {
    Text = "Silent Aim",
    Default = false,
    Callback = function(state)
        print("Silent Aim:", state);
    end
});

extensions:AddDropdown(combattab.content, {
    Text = "Target Part",
    Options = {"Head", "Torso", "Random"},
    Default = "Head",
    Callback = function(selected)
        print("Target Part:", selected);
    end
});

-- // VISUALS TAB
visualtab:AddSeparator("ESP");

components:AddToggle(visualtab.content, {
    Text = "Player ESP",
    Default = false,
    Callback = function(state)
        print("Player ESP:", state);
    end
});

components:AddToggle(visualtab.content, {
    Text = "Name Tags",
    Default = true,
    Callback = function(state)
        print("Name Tags:", state);
    end
});

components:AddToggle(visualtab.content, {
    Text = "Health Bars",
    Default = false,
    Callback = function(state)
        print("Health Bars:", state);
    end
});

visualtab:AddSeparator("Customization");

extensions:AddColorPicker(visualtab.content, {
    Text = "ESP Color",
    Default = Color3.fromRGB(255, 105, 180),
    Callback = function(color)
        print("ESP Color:", color);
    end
});

components:AddSlider(visualtab.content, {
    Text = "ESP Transparency",
    Min = 0,
    Max = 100,
    Default = 50,
    Suffix = "%",
    Callback = function(value)
        print("ESP Transparency:", value);
    end
});

-- // PLAYER TAB
playertab:AddSeparator("Movement");

components:AddSlider(playertab.content, {
    Text = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Suffix = "",
    Callback = function(value)
        print("Walk Speed:", value);
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value;
        end;
    end
});

components:AddSlider(playertab.content, {
    Text = "Jump Power",
    Min = 50,
    Max = 300,
    Default = 50,
    Suffix = "",
    Callback = function(value)
        print("Jump Power:", value);
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value;
        end;
    end
});

playertab:AddSeparator("Abilities");

components:AddToggle(playertab.content, {
    Text = "Infinite Jump",
    Default = false,
    Callback = function(state)
        print("Infinite Jump:", state);
    end
});

components:AddToggle(playertab.content, {
    Text = "Noclip",
    Default = false,
    Callback = function(state)
        print("Noclip:", state);
    end
});

extensions:AddKeyBind(playertab.content, {
    Text = "Fly Toggle",
    Default = Enum.KeyCode.F,
    Callback = function()
        print("Fly toggled!");
    end
});

-- // MISC TAB
misctab:AddSeparator("Utilities");

components:AddButton(misctab.content, {
    Text = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer);
    end
});

components:AddButton(misctab.content, {
    Text = "Copy Game Link",
    Callback = function()
        setclipboard("https://www.roblox.com/games/" .. game.PlaceId);
        print("Game link copied!");
    end
});

misctab:AddSeparator("Information");

components:AddLabel(misctab.content, {
    Text = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Size = 13,
    Color = Color3.fromRGB(120, 120, 125)
});

components:AddLabel(misctab.content, {
    Text = "Players: " .. #game.Players:GetPlayers() .. "/12",
    Size = 13,
    Color = Color3.fromRGB(120, 120, 125)
});

-- // SETTINGS TAB
settingstab:AddSeparator("Interface");

components:AddSlider(settingstab.content, {
    Text = "UI Scale",
    Min = 0.8,
    Max = 1.5,
    Default = 1.0,
    Suffix = "x",
    Callback = function(value)
        print("UI Scale:", value);
    end
});

components:AddToggle(settingstab.content, {
    Text = "Notifications",
    Default = true,
    Callback = function(state)
        print("Notifications:", state);
    end
});

settingstab:AddSeparator("Performance");

extensions:AddDropdown(settingstab.content, {
    Text = "Render Quality",
    Options = {"Low", "Medium", "High", "Ultra"},
    Default = "High",
    Callback = function(selected)
        print("Render Quality:", selected);
    end
});

components:AddSlider(settingstab.content, {
    Text = "Max FPS",
    Min = 30,
    Max = 240,
    Default = 60,
    Suffix = " fps",
    Callback = function(value)
        print("Max FPS:", value);
    end
});

-- // CONFIG TAB
configtab:AddSeparator("Configuration");

components:AddInput(configtab.content, {
    Text = "Config Name",
    Placeholder = "Enter config name...",
    Callback = function(text)
        print("Config Name:", text);
    end
});

components:AddButton(configtab.content, {
    Text = "Save Configuration",
    Callback = function()
        print("Configuration saved!");
    end
});

components:AddButton(configtab.content, {
    Text = "Load Configuration", 
    Callback = function()
        print("Configuration loaded!");
    end
});

configtab:AddSeparator("Reset");

components:AddButton(configtab.content, {
    Text = "Reset to Defaults",
    Callback = function()
        print("Settings reset to defaults!");
        autofarm:SetValue(false);
    end
});

-- // startup message
components:AddLabel(maintab.content, {
    Text = "Welcome to INSANITY! Premium scripting experience.",
    Size = 12,
    Color = Color3.fromRGB(255, 150, 200)
});

print("🌸 Pink UI Demo loaded successfully!");
print("📁 Repository: https://github.com/testing2122/roblox-pink-ui-lib");
print("✨ Features: Scrollable tabs, modern design, and premium aesthetics");