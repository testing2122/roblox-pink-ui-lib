# 🌸 Pink UI Library

A sleek, modern UI library for Roblox with a black, grey, and pink theme. Features smooth animations, reactive components, and an intuitive tabbed interface.

## ✨ Features

- **Modern Design**: Clean black, grey, and pink color scheme
- **Reactive Components**: Smooth hover effects and animations
- **Tab System**: Left-side navigation with animated transitions
- **Draggable Windows**: Smooth tween-based dragging
- **Rich Components**: Buttons, toggles, sliders, inputs, dropdowns, color pickers, and more
- **Optimized Performance**: Efficient code with minimal overhead
- **Easy Integration**: Simple API for quick implementation

## 🚀 Quick Start

```lua
-- Load the library
local pnkui = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/PinkUI.lua"))();
local components = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Components.lua"))();

-- Create a window
local window = pnkui:CreateWindow({
    Title = "My Script",
    Subtitle = "v1.0.0"
});

-- Create a tab
local tab = window:CreateTab({
    Name = "Main",
    Icon = "🏠"
});

-- Add components
components:AddButton(tab.content, {
    Text = "Click Me!",
    Callback = function()
        print("Button clicked!");
    end
});
```

## 📦 Components

### Basic Components
- **Button**: Interactive buttons with hover effects
- **Toggle**: On/off switches with smooth animations
- **Slider**: Value sliders with customizable ranges
- **Input**: Text input fields with focus effects
- **Label**: Static text displays with customizable styling

### Advanced Components (Extensions.lua)
- **Dropdown**: Expandable selection menus
- **Color Picker**: Interactive color selection
- **Key Bind**: Keyboard input binding
- **Separator**: Visual dividers with optional text

## 🎨 Color Scheme

```lua
local colors = {
    bg = Color3.fromRGB(15, 15, 15),        -- Main background
    secondary = Color3.fromRGB(35, 35, 35),  -- Secondary elements
    accent = Color3.fromRGB(60, 60, 60),     -- Accent elements
    pink = Color3.fromRGB(255, 105, 180),    -- Primary pink
    darkpink = Color3.fromRGB(200, 80, 140), -- Darker pink
    white = Color3.fromRGB(255, 255, 255),   -- Text color
    separator = Color3.fromRGB(80, 80, 80)   -- Divider lines
};
```

## 📖 API Reference

### Window Creation
```lua
local window = pnkui:CreateWindow({
    Title = "Window Title",     -- Optional: Window title
    Subtitle = "Subtitle text"  -- Optional: Subtitle text
});
```

### Tab Creation
```lua
local tab = window:CreateTab({
    Name = "Tab Name",  -- Tab display name
    Icon = "🏠"        -- Optional: Tab icon (emoji)
});
```

### Adding Components

#### Button
```lua
components:AddButton(parent, {
    Text = "Button Text",
    Callback = function()
        -- Button click logic
    end
});
```

#### Toggle
```lua
local toggle = components:AddToggle(parent, {
    Text = "Toggle Text",
    Default = false,
    Callback = function(state)
        print("Toggle:", state);
    end
});
```

#### Slider
```lua
local slider = components:AddSlider(parent, {
    Text = "Slider Text",
    Min = 0,
    Max = 100,
    Default = 50,
    Suffix = "%",
    Callback = function(value)
        print("Value:", value);
    end
});
```

#### Input
```lua
local input = components:AddInput(parent, {
    Text = "Input Label",
    Placeholder = "Enter text...",
    Callback = function(text)
        print("Input:", text);
    end
});
```

#### Dropdown (Extensions)
```lua
local extensions = loadstring(game:HttpGet("https://raw.githubusercontent.com/testing2122/roblox-pink-ui-lib/main/Extensions.lua"))();

local dropdown = extensions:AddDropdown(parent, {
    Text = "Select Option",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(selected)
        print("Selected:", selected);
    end
});
```

#### Color Picker (Extensions)
```lua
local colorpicker = extensions:AddColorPicker(parent, {
    Text = "Choose Color",
    Default = Color3.fromRGB(255, 105, 180),
    Callback = function(color)
        print("Color:", color);
    end
});
```

#### Key Bind (Extensions)
```lua
local keybind = extensions:AddKeyBind(parent, {
    Text = "Toggle Key",
    Default = Enum.KeyCode.F,
    Callback = function()
        print("Key pressed!");
    end
});
```

## 🎯 Component Methods

Most components return a table with utility methods:

```lua
-- Set component value
component:SetValue(newValue);

-- Get current value
local value = component:GetValue();

-- For labels specifically
label:SetText("New text");
label:SetColor(Color3.fromRGB(255, 0, 0));
```

## 🔧 Advanced Usage

### Adding Separators
```lua
tab:AddSeparator("Section Name");  -- With text
tab:AddSeparator();                -- Line only
```

### Window Management
```lua
-- The window automatically handles:
-- - Dragging via title bar
-- - Close button functionality
-- - Tab switching animations
-- - Responsive sizing
```

## 🎨 Customization

The library uses consistent color schemes and animation timings that can be modified in the source files:

- **Colors**: Modify the `clrs` table in each file
- **Animations**: Adjust the `twinfo` table for different timing
- **Sizing**: Most components use relative sizing for responsiveness

## 📱 Compatibility

- **Roblox Executors**: Compatible with most modern executors
- **Screen Sizes**: Responsive design works across different resolutions
- **Performance**: Optimized for smooth 60+ FPS operation

## 🤝 Contributing

Feel free to contribute improvements, bug fixes, or new components!

## 📄 License

This project is open source and available under the MIT License.

---

**Created by testing2122** • [GitHub Repository](https://github.com/testing2122/roblox-pink-ui-lib)