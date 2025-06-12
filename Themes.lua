local themes = {};

-- // Default Pink Theme
themes.Pink = {
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
    separator = Color3.fromRGB(35, 35, 40),
    disabled = Color3.fromRGB(60, 60, 65)
};

-- // Blue Theme
themes.Blue = {
    bg = Color3.fromRGB(6, 8, 12),
    secondary = Color3.fromRGB(12, 15, 20),
    accent = Color3.fromRGB(20, 25, 35),
    pink = Color3.fromRGB(100, 150, 255), -- Main accent (blue)
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(80, 120, 200), -- Dark blue
    lightpink = Color3.fromRGB(150, 180, 255), -- Light blue
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(120, 125, 130),
    darkgrey = Color3.fromRGB(80, 85, 90),
    separator = Color3.fromRGB(35, 40, 50),
    disabled = Color3.fromRGB(60, 65, 75)
};

-- // Green Theme
themes.Green = {
    bg = Color3.fromRGB(6, 10, 6),
    secondary = Color3.fromRGB(12, 18, 12),
    accent = Color3.fromRGB(20, 30, 20),
    pink = Color3.fromRGB(100, 255, 150), -- Main accent (green)
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(80, 200, 120), -- Dark green
    lightpink = Color3.fromRGB(150, 255, 180), -- Light green
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(120, 130, 120),
    darkgrey = Color3.fromRGB(80, 90, 80),
    separator = Color3.fromRGB(35, 45, 35),
    disabled = Color3.fromRGB(60, 70, 60)
};

-- // Purple Theme
themes.Purple = {
    bg = Color3.fromRGB(8, 6, 12),
    secondary = Color3.fromRGB(15, 12, 20),
    accent = Color3.fromRGB(25, 20, 35),
    pink = Color3.fromRGB(180, 100, 255), -- Main accent (purple)
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(140, 80, 200), -- Dark purple
    lightpink = Color3.fromRGB(200, 150, 255), -- Light purple
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(125, 120, 130),
    darkgrey = Color3.fromRGB(85, 80, 90),
    separator = Color3.fromRGB(40, 35, 50),
    disabled = Color3.fromRGB(65, 60, 75)
};

-- // Orange Theme
themes.Orange = {
    bg = Color3.fromRGB(10, 8, 6),
    secondary = Color3.fromRGB(18, 15, 12),
    accent = Color3.fromRGB(30, 25, 20),
    pink = Color3.fromRGB(255, 150, 80), -- Main accent (orange)
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(200, 120, 60), -- Dark orange
    lightpink = Color3.fromRGB(255, 180, 120), -- Light orange
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(130, 125, 120),
    darkgrey = Color3.fromRGB(90, 85, 80),
    separator = Color3.fromRGB(45, 40, 35),
    disabled = Color3.fromRGB(70, 65, 60)
};

-- // Red Theme
themes.Red = {
    bg = Color3.fromRGB(12, 6, 6),
    secondary = Color3.fromRGB(20, 12, 12),
    accent = Color3.fromRGB(35, 20, 20),
    pink = Color3.fromRGB(255, 80, 100), -- Main accent (red)
    red = Color3.fromRGB(255, 60, 60),
    darkpink = Color3.fromRGB(200, 60, 80), -- Dark red
    lightpink = Color3.fromRGB(255, 120, 140), -- Light red
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(130, 120, 120),
    darkgrey = Color3.fromRGB(90, 80, 80),
    separator = Color3.fromRGB(50, 35, 35),
    disabled = Color3.fromRGB(75, 60, 60)
};

-- // Cyan Theme
themes.Cyan = {
    bg = Color3.fromRGB(6, 10, 10),
    secondary = Color3.fromRGB(12, 18, 18),
    accent = Color3.fromRGB(20, 30, 30),
    pink = Color3.fromRGB(80, 255, 255), -- Main accent (cyan)
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(60, 200, 200), -- Dark cyan
    lightpink = Color3.fromRGB(120, 255, 255), -- Light cyan
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(120, 130, 130),
    darkgrey = Color3.fromRGB(80, 90, 90),
    separator = Color3.fromRGB(35, 45, 45),
    disabled = Color3.fromRGB(60, 70, 70)
};

-- // Dark Theme (Monochrome)
themes.Dark = {
    bg = Color3.fromRGB(8, 8, 8),
    secondary = Color3.fromRGB(15, 15, 15),
    accent = Color3.fromRGB(25, 25, 25),
    pink = Color3.fromRGB(200, 200, 200), -- Main accent (light grey)
    red = Color3.fromRGB(255, 80, 80),
    darkpink = Color3.fromRGB(160, 160, 160), -- Dark grey
    lightpink = Color3.fromRGB(220, 220, 220), -- Light grey
    white = Color3.fromRGB(255, 255, 255),
    grey = Color3.fromRGB(120, 120, 120),
    darkgrey = Color3.fromRGB(80, 80, 80),
    separator = Color3.fromRGB(40, 40, 40),
    disabled = Color3.fromRGB(60, 60, 60)
};

-- // Function to get theme
function themes:GetTheme(name)
    return self[name] or self.Pink;
end;

-- // Function to get all theme names
function themes:GetThemeNames()
    local names = {};
    for name, _ in pairs(self) do
        if type(self[name]) == "table" and name ~= "GetTheme" and name ~= "GetThemeNames" then
            table.insert(names, name);
        end;
    end;
    return names;
end;

return themes;