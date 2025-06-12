# Pink UI Library v2.0 🌸

A modern, sleek UI library for Roblox with a beautiful pink/black theme and smooth animations.

## ✨ Features

- **Box System**: Create scrollable boxes in left/right columns
- **Animated Gradient Title**: Toggle with the "G" button
- **Modern Design**: Pink/black theme with smooth transitions
- **Responsive Layout**: Scrollable columns and containers
- **Rich Components**: Toggles, sliders, buttons, inputs, dropdowns, labels
- **Easy to Use**: Simple API with customizable options

## 🚀 Quick Start

```lua
-- Load the libraries
local PinkUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUI.lua"))();
local Components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Components.lua"))();

-- Create window
local Window = PinkUI:CreateWindow({
    Title = "My Script",
    Subtitle = "v1.0",
    TitleGradient = true
});

-- Create tab
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "🏠"
});

-- Create boxes in columns
local LeftBox = MainTab:CreateBox({
    Name = "Features",
    Column = "left",
    Height = 300
});

local RightBox = MainTab:CreateBox({
    Name = "Settings", 
    Column = "right",
    Height = 250
});

-- Add components to boxes
Components:AddToggle(LeftBox, {
    Name = "Auto Farm",
    Description = "Automatically farm resources",
    Default = false,
    Callback = function(value)
        print("Auto Farm:", value);
    end
});

Components:AddSlider(RightBox, {
    Name = "Speed",
    Min = 1,
    Max = 100,
    Default = 16,
    Callback = function(value)
        print("Speed:", value);
    end
});
```

## 📦 Box System

The new box system allows you to create organized, scrollable containers:

### Creating Boxes
```lua
local MyBox = tab:CreateBox({
    Name = "Box Title",        -- Box header text
    Column = "left",           -- "left" or "right" column
    Height = 300               -- Box height in pixels
});
```

### Box Features
- **Left/Right Columns**: Position boxes in either column
- **Custom Heights**: Set any height for each box
- **Scrollable Content**: Boxes scroll when content overflows
- **Multiple Boxes**: Stack multiple boxes in the same column
- **Pink Styling**: Consistent theme with pink outlines

## 🎛️ Components

All components are added directly to boxes:

### Toggle
```lua
Components:AddToggle(box, {
    Name = "Feature Name",
    Description = "Optional description",
    Default = false,
    Callback = function(value) end
});
```

### Slider
```lua
Components:AddSlider(box, {
    Name = "Slider Name",
    Description = "Optional description", 
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 1,
    Callback = function(value) end
});
```

### Button
```lua
Components:AddButton(box, {
    Name = "Button Text",
    Description = "Optional description",
    Callback = function() end
});
```

### Input
```lua
Components:AddInput(box, {
    Name = "Input Name",
    Description = "Optional description",
    Placeholder = "Enter text...",
    Default = "",
    Callback = function(text) end
});
```

### Dropdown
```lua
Components:AddDropdown(box, {
    Name = "Dropdown Name",
    Description = "Optional description",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(selected) end
});
```

### Label
```lua
Components:AddLabel(box, {
    Text = "Label text",
    Size = 14,
    Color = Color3.fromRGB(255, 255, 255)
});
```

## 🎨 Customization

### Window Options
```lua
local Window = PinkUI:CreateWindow({
    Title = "Window Title",           -- Main title
    Subtitle = "Subtitle text",       -- Subtitle below title
    TitleGradient = true             -- Enable animated gradient (default: true)
});
```

### Tab Options
```lua
local Tab = Window:CreateTab({
    Name = "Tab Name",               -- Tab display name
    Icon = "🏠"                     -- Optional emoji icon
});
```

## 🔧 Advanced Usage

### Component Methods
Most components return objects with methods:

```lua
local toggle = Components:AddToggle(box, {...});
toggle.SetValue(true);              -- Set value
local value = toggle.GetValue();    -- Get current value

local slider = Components:AddSlider(box, {...});
slider.SetValue(75);
local value = slider.GetValue();

local dropdown = Components:AddDropdown(box, {...});
dropdown.SetValue("Option 2");
dropdown.SetOptions({"New", "Options"});
```

### Gradient Control
- Click the **"G" button** next to minimize/close to toggle title gradient
- Gradient smoothly animates left-to-right with pink colors
- Can be disabled in window creation or toggled at runtime

## 📱 Layout System

The library uses a **two-column layout**:
- **Left Column**: 48% width, positioned at left
- **Right Column**: 48% width, positioned at right  
- **Scrollable**: Both columns scroll independently
- **Responsive**: Boxes stack vertically within columns
- **Spacing**: Automatic spacing between boxes

## 🎯 Migration from v1.x

If upgrading from older versions:

**Old (v1.x):**
```lua
local section = tab:CreateSection("Section Name");
Components:AddToggle(section, {...});
```

**New (v2.0):**
```lua
local box = tab:CreateBox({
    Name = "Section Name",
    Column = "left",
    Height = 300
});
Components:AddToggle(box, {...});
```

## 📋 Example

See [Example.lua](Example.lua) for a complete working example with multiple tabs, boxes, and all component types.

## 🐛 Troubleshooting

**Error: "attempt to call missing method 'CreateSection'"**
- You're using old v1.x syntax
- Replace `CreateSection()` with `CreateBox()`
- Update your component calls to use boxes instead of sections

**Components not showing:**
- Make sure you're adding components to the box, not the tab
- Verify the box was created successfully
- Check that Components library is loaded

**Gradient not working:**
- Ensure `TitleGradient = true` in window creation
- Try toggling with the "G" button
- Check console for any errors

## 📄 License

MIT License - Feel free to use in your projects!

---

**Created by testing2122** | [GitHub Repository](https://github.com/testing2122/roblox-pink-ui-lib)