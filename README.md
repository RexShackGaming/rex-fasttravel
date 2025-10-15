<img width="2948" height="497" alt="rex_scripts" src="https://github.com/user-attachments/assets/bccc94d2-0702-48aa-9868-08b05cc2a8bd" />

# Rex Fast Travel 🚀

**Advanced distance-based fast travel system for RedM/RSG Framework with dynamic pricing and travel times.**

---

## ✨ Features

### 🎯 Core Features
- **Interactive Prompts**: Use configurable keybinds at designated fast travel locations
- **Map Blips**: Customizable blips showing all fast travel points
- **Immersive Travel**: Loading screens with destination labels during travel
- **10 Preset Locations**: All major RedM towns and locations included
- **ox_lib Integration**: Modern context menus with clean UI
- **Multi-language Support**: Locale system for easy translation

### 💰 Dynamic Pricing System
- **Distance-Based Costs**: Prices calculated by actual distance to destination
- **Tier-Based Pricing**: Configure fixed prices for distance ranges
- **Formula-Based Pricing**: Base cost + distance multiplier system
- **Cost Limits**: Configurable minimum and maximum prices
- **Visual Indicators**: Distance categories (Short/Medium/Long/Very Long/Extreme)
- **Server-Side Validation**: Prevents client-side cost manipulation

### ⏱️ Dynamic Travel Times
- **Realistic Wait Times**: Travel time based on actual distance
- **Tier-Based Timing**: Fixed durations for different distance ranges
- **Formula-Based Timing**: Base time + distance calculation
- **Time Formatting**: User-friendly display ("1m 30s", "45s")
- **Flexible Configuration**: From 3 seconds to 5+ minutes per server preference
- **Anti-Manipulation**: Server-side time recalculation

### 🛡️ Security & Anti-Cheat
- **Server-Side Validation**: All costs and times recalculated server-side
- **Position Tolerance**: Allows small movement during menu interaction
- **Manipulation Detection**: Automatic detection and correction of tampered values
- **Destination Validation**: Only configured destinations can be accessed
- **Comprehensive Logging**: Detailed logs for monitoring and debugging

### 🎮 User Experience
- **Rich Menu Information**: Distance, category, cost, and travel time all displayed
- **Real-Time Calculations**: Prices and times update based on current position

---

## 🏘️ Included Locations

| Location | Coordinates | Description |
|----------|-------------|-------------|
| **Annesburg** | `2931.61, 1283.11, 44.65` | Mining town in Roanoke Ridge |
| **Armadillo** | `-3729.09, -2603.55, -12.94` | Desert town in Cholla Springs |
| **Blackwater** | `-830.92, -1343.15, 43.67` | Major city in Great Plains |
| **Rhodes** | `1231.26, -1299.74, 76.9` | Town center in Scarlett Meadows |
| **Strawberry** | `-1827.5, -437.65, 159.78` | Mountain town in Big Valley |
| **Saint Denis** | `2747.10, -1394.87, 46.18` | Major city in Bayou Nwa |
| **Tumbleweed** | `-5501.2, -2954.32, -1.73` | Desert town in Gaptooth Ridge |
| **Valentine** | `-174.39, 633.33, 114.09` | Livestock town in Heartlands |
| **Van Horn** | `2893.37, 624.33, 57.72` | Trading post in Roanoke Ridge |
| **Sisika Prison** | `3266.90, -715.89, 42.03` | Prison island in Lannahechee River |

---

## 📋 Requirements

### Dependencies
- **[rsg-core](https://github.com/Rexshack-RedM/rsg-core)** - Core framework
- **[ox_lib](https://github.com/overextended/ox_lib)** - UI library and utilities

### Server Requirements
- **RedM Server** with RSG-Core framework
- **FiveM/RedM build** 2545 or higher (for Lua 5.4 support)
- **RAM**: 10-20MB additional usage
- **Storage**: ~50KB resource size

---

## 🔧 Installation

### Step 1: Download & Extract
1. Download the latest release from GitHub or Tebex
2. Extract the `rex-fasttravel` folder to your server's `resources` directory
```
resources/
├── [other resources]
└── rex-fasttravel/
    ├── client/
    ├── server/
    ├── shared/
    ├── locales/
    ├── fxmanifest.lua
    └── README.md
```

### Step 2: Verify Dependencies
Ensure these are installed and started BEFORE rex-fasttravel:
```bash
# In your server.cfg, make sure these come first:
ensure rsg-core
ensure ox_lib
```

### Step 3: Add to Server Config
Add to your `server.cfg`:
```bash
ensure rex-fasttravel
```

### Step 4: Restart Server
```bash
# Option 1: Full server restart (recommended for first install)
restart

# Option 2: Resource only (for updates)
refresh
ensure rex-fasttravel
```

### Step 5: Verify Installation
Check server console for:
```
[rex-fasttravel] Utils module loaded successfully
[rex-fasttravel] Client initialization started
[rex-fasttravel] Creating prompts for 10 locations
[rex-fasttravel] Total prompts created: 10
[rex-fasttravel] Client initialization completed
```

---

## ⚙️ Configuration

### Basic Settings
```lua
-- shared/config.lua
Config.Keybind = 'J'                    -- Interaction key
Config.DynamicPricing = true            -- Enable distance-based pricing
Config.DynamicWaitTime = true           -- Enable distance-based travel times
```

### Pricing Configuration
```lua
Config.Pricing = {
    baseCost = 5,           -- Base cost for any travel
    costPerUnit = 0.01,     -- Cost per distance unit
    minimumCost = 5,        -- Minimum travel cost
    maximumCost = 50,       -- Maximum travel cost
    
    -- Tier-based pricing (recommended)
    useTiers = true,
    tiers = {
        {maxDistance = 500,  cost = 5},     -- Short: $5
        {maxDistance = 1500, cost = 15},    -- Medium: $15  
        {maxDistance = 3000, cost = 25},    -- Long: $25
        {maxDistance = 5000, cost = 35},    -- Very Long: $35
        {maxDistance = 99999, cost = 50}    -- Extreme: $50
    }
}
```

### Travel Time Configuration
```lua
Config.WaitTime = {
    baseWaitTime = 5000,        -- Base wait time (5 seconds)
    timePerUnit = 2,            -- Milliseconds per distance unit
    minimumWaitTime = 3000,     -- Minimum wait time (3 seconds)
    maximumWaitTime = 60000,    -- Maximum wait time (60 seconds)
    
    -- Tier-based timing (recommended)
    useTiers = true,
    tiers = {
        {maxDistance = 500,  waitTime = 5000},    -- Short: 5s
        {maxDistance = 1500, waitTime = 15000},   -- Medium: 15s
        {maxDistance = 3000, waitTime = 25000},   -- Long: 25s
        {maxDistance = 5000, waitTime = 40000},   -- Very Long: 40s
        {maxDistance = 99999, waitTime = 60000}   -- Extreme: 60s
    }
}
```

### Map Blips
```lua
Config.Blip = {
    blipName = 'Fast Travel',
    blipSprite = 'blip_ambient_warp',
    blipScale = 0.2
}
```

---

## 🎮 Usage

### For Players
1. **Find a fast travel location** (look for blips on the map)
2. **Approach the location** until you see the prompt
3. **Press the keybind** (default: J) to open the menu
4. **Select destination** from the list
5. **Confirm purchase** (if you have enough money)
6. **Wait for travel** to complete

### Menu Information Display
```
🏘️ Valentine - $15
📍 Distance: 1200 units (Medium) • ⏱️ Travel Time: 15s

🏘️ Saint Denis - $25  
📍 Distance: 2800 units (Long) • ⏱️ Travel Time: 25s
```

# Check resource status
resource rex-fasttravel

# Restart resource
restart rex-fasttravel

## 🛠️ Customization

### Adding New Locations
1. **Add to destinations** in `Config.FastTravel`:
```lua
{
    title = 'Fast Travel MyTown',
    destination = vector3(100.0, 200.0, 30.0),
    dest_label = 'Fast Travel to MyTown'
},
```

2. **Add interaction point** in `Config.FastTravelLocations`:
```lua
{
    name = 'Fast Travel', 
    location = 'mytown',
    coords = vector3(100.0, 200.0, 30.0), 
    showblip = true
},
```

### Adjusting for Different Server Types

**Economy-Focused Server:**
```lua
Config.Pricing = {
    useTiers = false,
    baseCost = 10,
    costPerUnit = 0.02,     -- Higher cost per unit
    maximumCost = 100       -- Higher maximum
}
```

**Roleplay-Heavy Server:**
```lua
Config.WaitTime = {
    useTiers = false,
    baseWaitTime = 30000,    -- 30 second base
    timePerUnit = 10,        -- Longer per unit
    maximumWaitTime = 600000 -- 10 minute maximum
}
```

**Fast-Paced Server:**
```lua
Config.WaitTime.tiers = {
    {maxDistance = 1000, waitTime = 2000},   -- 2 seconds max
    {maxDistance = 99999, waitTime = 5000}   -- 5 seconds max
}
```

---

## 🐛 Troubleshooting

### Menu Not Showing
1. **Check console** for error messages
2. **Verify dependencies** are running
3. **Check keybind** in RSG-Core config

### Common Issues

**"Utils not available" error:**
```bash
# Solution: Restart the resource
restart rex-fasttravel
```

**Prompts not appearing:**
```bash
# Check RSG-Core is running and keybinds configured
resource rsg-core
```

**Distance calculation errors:**
```bash
# Check for Config.FastTravel formatting issues
# Ensure all destinations have vector3 coordinates
```

---

## 🤝 Support & Community

- **Discord**: [Join our community](https://discord.gg/YUV7ebzkqs)
- **YouTube**: [Video tutorials](https://www.youtube.com/@rexshack/videos)
- **Tebex Store**: [Premium resources](https://rexshackgaming.tebex.io/)

---

## 📄 License

This resource is provided by RexShackGaming. Please respect the license terms and support the developer.

---

*Made with ❤️ by RexShackGaming for the RedM community*
