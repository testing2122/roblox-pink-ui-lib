-- // comprehensive example showcasing all pink ui features
local pnkui = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUI.lua"))();
local components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Components.lua"))();
local extensions = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Extensions.lua"))();

-- // create main window
local win = pnkui:CreateWindow({
    Title = "INSANITY",
    Subtitle = "Premium Experience"
});

-- // variables for features
local autoclick = false;
local walkspeed = 16;
local jumppower = 50;
local espplayers = false;
local wallhack = false;
local infinitehealth = false;
local currentconfig = "default";

-- // main tab
local maintab = win:CreateTab({
    Name = "Main",
    Icon = "🏠"
});

-- // core features section
local coresect = maintab:CreateSection("Core Features");

components:AddToggle(coresect, {
    Text = "Auto Clicker",
    Description = "Automatically clicks for you",
    Default = false,
    Callback = function(value)
        autoclick = value;
        print("auto clicker:", value);
    end
});

components:AddToggle(coresect, {
    Text = "Speed Hack",
    Description = "Increases movement speed",
    Default = false,
    Callback = function(value)
        if value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed;
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16;
        end;
    end
});

components:AddSlider(coresect, {
    Text = "Walk Speed",
    Description = "Adjust your movement speed",
    Min = 16,
    Max = 500,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        walkspeed = value;
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value;
        end;
    end
});

components:AddButton(coresect, {
    Text = "Teleport to Spawn",
    Description = "Returns you to the spawn location",
    Callback = function()
        local plr = game.Players.LocalPlayer;
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0);
        end;
    end
});

-- // automation section  
local autosect = maintab:CreateSection("Automation");

components:AddToggle(autosect, {
    Text = "Auto Farm",
    Description = "Automatically farms resources",
    Default = false,
    Callback = function(value)
        print("auto farm:", value);
    end
});

components:AddToggle(autosect, {
    Text = "Auto Collect",
    Description = "Collects items automatically",
    Default = false,
    Callback = function(value)
        print("auto collect:", value);
    end
});

components:AddSeparator(autosect);

components:AddInput(autosect, {
    Text = "Target Username",
    Description = "Enter username to target",
    Placeholder = "Enter username...",
    Callback = function(text)
        print("target username:", text);
    end
});

-- // combat tab
local combattab = win:CreateTab({
    Name = "Combat",
    Icon = "⚔️"
});

-- // combat features
local combatsect = combattab:CreateSection("Combat Features");

components:AddToggle(combatsect, {
    Text = "Aimbot",
    Description = "Automatically aims at enemies",
    Default = false,
    Callback = function(value)
        print("aimbot:", value);
    end
});

components:AddToggle(combatsect, {
    Text = "Kill Aura",
    Description = "Attacks nearby enemies",
    Default = false,
    Callback = function(value)
        print("kill aura:", value);
    end
});

components:AddSlider(combatsect, {
    Text = "Attack Range",
    Description = "Set attack distance",
    Min = 5,
    Max = 50,
    Default = 15,
    Increment = 1,
    Callback = function(value)
        print("attack range:", value);
    end
});

-- // weapon settings
local weaponsect = combattab:CreateSection("Weapon Settings");

extensions:AddDropdown(weaponsect, {
    Text = "Weapon Type",
    Description = "Select your weapon",
    Options = {"Sword", "Bow", "Staff", "Dagger"},
    Default = "Sword",
    Callback = function(option)
        print("weapon type:", option);
    end
});

components:AddSlider(weaponsect, {
    Text = "Damage Multiplier",
    Description = "Increase damage output",
    Min = 1,
    Max = 10,
    Default = 1,
    Increment = 0.1,
    Callback = function(value)
        print("damage multiplier:", value);
    end
});

-- // visuals tab
local visualstab = win:CreateTab({
    Name = "Visuals",
    Icon = "👁️"
});

-- // esp section
local espsect = visualstab:CreateSection("ESP Features");

components:AddToggle(espsect, {
    Text = "Player ESP",
    Description = "See players through walls",
    Default = false,
    Callback = function(value)
        espplayers = value;
        print("player esp:", value);
    end
});

components:AddToggle(espsect, {
    Text = "Item ESP",
    Description = "Highlight valuable items",
    Default = false,
    Callback = function(value)
        print("item esp:", value);
    end
});

extensions:AddColorPicker(espsect, {
    Text = "ESP Color",
    Description = "Choose ESP highlight color",
    Default = Color3.fromRGB(255, 105, 180),
    Callback = function(color)
        print("esp color:", color);
    end
});

-- // visual effects
local vfxsect = visualstab:CreateSection("Visual Effects");

components:AddToggle(vfxsect, {
    Text = "Wallhack",
    Description = "See through walls",
    Default = false,
    Callback = function(value)
        wallhack = value;
        print("wallhack:", value);
    end
});

components:AddToggle(vfxsect, {
    Text = "Full Bright",
    Description = "Remove darkness",
    Default = false,
    Callback = function(value)
        if value then
            game.Lighting.Brightness = 3;
            game.Lighting.Ambient = Color3.fromRGB(255, 255, 255);
        else
            game.Lighting.Brightness = 1;
            game.Lighting.Ambient = Color3.fromRGB(70, 70, 70);
        end;
    end
});

components:AddSlider(vfxsect, {
    Text = "FOV",
    Description = "Adjust field of view",
    Min = 70,
    Max = 120,
    Default = 70,
    Increment = 1,
    Callback = function(value)
        game.Workspace.CurrentCamera.FieldOfView = value;
    end
});

-- // player tab
local playertab = win:CreateTab({
    Name = "Player",
    Icon = "👤"
});

-- // movement section
local movesect = playertab:CreateSection("Movement");

components:AddSlider(movesect, {
    Text = "Jump Power",
    Description = "How high you can jump",
    Min = 50,
    Max = 300,
    Default = 50,
    Increment = 5,
    Callback = function(value)
        jumppower = value;
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value;
        end;
    end
});

components:AddToggle(movesect, {
    Text = "Infinite Jump",
    Description = "Jump unlimited times",
    Default = false,
    Callback = function(value)
        print("infinite jump:", value);
    end
});

components:AddToggle(movesect, {
    Text = "No Clip",
    Description = "Walk through walls",
    Default = false,
    Callback = function(value)
        print("no clip:", value);
    end
});

-- // character section
local charsect = playertab:CreateSection("Character");

components:AddToggle(charsect, {
    Text = "Infinite Health",
    Description = "Never take damage",
    Default = false,
    Callback = function(value)
        infinitehealth = value;
        print("infinite health:", value);
    end
});

components:AddButton(charsect, {
    Text = "Reset Character",
    Description = "Respawn your character",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0;
    end
});

components:AddButton(charsect, {
    Text = "Invisible",
    Description = "Make yourself invisible",
    Callback = function()
        local plr = game.Players.LocalPlayer;
        if plr.Character then
            for _, part in pairs(plr.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1;
                end;
            end;
        end;
    end
});

-- // misc tab
local misctab = win:CreateTab({
    Name = "Misc",
    Icon = "🔧"
});

-- // utility section
local utilsect = misctab:CreateSection("Utilities");

extensions:AddKeybind(utilsect, {
    Text = "Toggle UI",
    Description = "Show/hide the interface",
    Default = Enum.KeyCode.RightShift,
    Callback = function(key)
        print("toggle ui key:", key);
    end
});

components:AddLabel(utilsect, {
    Text = "Server Stats",
    Description = "Current server information"
});

components:AddButton(utilsect, {
    Text = "Copy Invite Link",
    Description = "Copy server join link",
    Callback = function()
        setclipboard("https://www.roblox.com/games/" .. game.PlaceId);
        print("copied invite link");
    end
});

-- // anti-detection
local antisect = misctab:CreateSection("Anti-Detection");

components:AddToggle(antisect, {
    Text = "Anti-Ban",
    Description = "Reduce detection risk",
    Default = true,
    Callback = function(value)
        print("anti-ban:", value);
    end
});

components:AddToggle(antisect, {
    Text = "Stealth Mode",
    Description = "Hide exploit activities",
    Default = false,
    Callback = function(value)
        print("stealth mode:", value);
    end
});

-- // settings tab
local settingstab = win:CreateTab({
    Name = "Settings",
    Icon = "⚙️"
});

-- // ui settings
local uisect = settingstab:CreateSection("UI Settings");

extensions:AddDropdown(uisect, {
    Text = "Theme",
    Description = "Choose UI theme",
    Options = {"Pink Dark", "Pink Light", "Classic", "Neon"},
    Default = "Pink Dark",
    Callback = function(option)
        print("theme:", option);
    end
});

components:AddSlider(uisect, {
    Text = "UI Scale",
    Description = "Adjust interface size",
    Min = 0.8,
    Max = 1.5,
    Default = 1.0,
    Increment = 0.1,
    Callback = function(value)
        print("ui scale:", value);
    end
});

components:AddToggle(uisect, {
    Text = "Animations",
    Description = "Enable smooth animations",
    Default = true,
    Callback = function(value)
        print("animations:", value);
    end
});

-- // performance settings
local perfsect = settingstab:CreateSection("Performance");

components:AddSlider(perfsect, {
    Text = "FPS Limit",
    Description = "Cap frame rate",
    Min = 30,
    Max = 240,
    Default = 60,
    Increment = 10,
    Callback = function(value)
        setfpscap(value);
    end
});

components:AddToggle(perfsect, {
    Text = "Low Graphics",
    Description = "Reduce visual quality",
    Default = false,
    Callback = function(value)
        if value then
            settings().Rendering.QualityLevel = 1;
        else
            settings().Rendering.QualityLevel = 21;
        end;
    end
});

-- // config tab
local configtab = win:CreateTab({
    Name = "Config",
    Icon = "📁"
});

-- // config management
local configsect = configtab:CreateSection("Configuration");

components:AddInput(configsect, {
    Text = "Config Name",
    Description = "Name for your configuration",
    Placeholder = "Enter config name...",
    Callback = function(text)
        currentconfig = text;
    end
});

components:AddButton(configsect, {
    Text = "Save Config",
    Description = "Save current settings",
    Callback = function()
        print("saving config:", currentconfig);
        -- // save logic here
    end
});

components:AddButton(configsect, {
    Text = "Load Config",
    Description = "Load saved settings",
    Callback = function()
        print("loading config:", currentconfig);
        -- // load logic here  
    end
});

components:AddSeparator(configsect);

extensions:AddDropdown(configsect, {
    Text = "Saved Configs",
    Description = "Select a saved configuration",
    Options = {"default", "combat", "farming", "stealth"},
    Default = "default",
    Callback = function(option)
        currentconfig = option;
        print("selected config:", option);
    end
});

-- // info section
local infosect = configtab:CreateSection("Information");

components:AddLabel(infosect, {
    Text = "Version: 2.1.0",
    Description = "Current script version"
});

components:AddLabel(infosect, {
    Text = "Developer: testing2122",
    Description = "Created by testing2122"
});

components:AddButton(infosect, {
    Text = "Join Discord",
    Description = "Get support and updates",
    Callback = function()
        setclipboard("https://discord.gg/testing2122");
        print("discord link copied");
    end
});

print("pink ui loaded successfully");
print("press right shift to toggle ui");