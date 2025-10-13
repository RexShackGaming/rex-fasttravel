Config = {}

---------------------------
-- General Settings
---------------------------
-- Default keybind for fast travel interaction (must match RSG-Core keybinds)
Config.Keybind = 'J'

-- Enable dynamic pricing based on distance (true/false)
Config.DynamicPricing = true

-- Enable dynamic wait time based on distance (true/false)
Config.DynamicWaitTime = true

-- Pricing configuration (only used if DynamicPricing is true)
Config.Pricing = {
    baseCost = 5,           -- Base cost for any fast travel
    costPerUnit = 0.01,     -- Cost per unit of distance (adjust based on your map scale)
    minimumCost = 5,        -- Minimum cost for any travel
    maximumCost = 50,       -- Maximum cost for any travel
    
    -- Distance-based pricing tiers (optional - overrides costPerUnit if enabled)
    useTiers = true,
    tiers = {
        {maxDistance = 500,  cost = 5},   -- Short distance: $5
        {maxDistance = 1500, cost = 15},  -- Medium distance: $15
        {maxDistance = 3000, cost = 25},  -- Long distance: $25
        {maxDistance = 5000, cost = 35},  -- Very long distance: $35
        {maxDistance = 99999, cost = 50}  -- Extreme distance: $50
    }
}

-- Wait time configuration (only used if DynamicWaitTime is true)
Config.WaitTime = {
    baseWaitTime = 5000,        -- Base wait time in milliseconds (5 seconds)
    timePerUnit = 2,            -- Additional milliseconds per distance unit
    minimumWaitTime = 3000,     -- Minimum wait time (3 seconds)
    maximumWaitTime = 60000,    -- Maximum wait time (60 seconds)
    
    -- Distance-based wait time tiers (optional - overrides timePerUnit if enabled)
    useTiers = true,
    tiers = {
        {maxDistance = 500,  waitTime = 5000},   -- Short distance: 5 seconds
        {maxDistance = 1500, waitTime = 15000},  -- Medium distance: 15 seconds
        {maxDistance = 3000, waitTime = 25000},  -- Long distance: 25 seconds
        {maxDistance = 5000, waitTime = 40000},  -- Very long distance: 40 seconds
        {maxDistance = 99999, waitTime = 60000}  -- Extreme distance: 60 seconds
    }
}

---------------------------
-- Map Blip Configuration
---------------------------
Config.Blip = {
    blipName = 'Fast Travel', -- Config.Blip.blipName
    blipSprite = 'blip_ambient_warp', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

---------------------------
-- Fast Travel Destinations
-- Note: Coordinates should match FastTravelLocations for consistency
---------------------------
Config.FastTravel = {
    {
        title = 'Fast Travel Annesburg',
        destination = vector3(2931.614, 1283.1109, 44.65287),
        dest_label = 'Fast Travel to Annesburg'
    },
    {
        title = 'Fast Travel Armadillo',
        destination = vector3(-3729.09, -2603.55, -12.94),
        dest_label = 'Fast Travel to Armadillo'
    },
    {
        title = 'Fast Travel Blackwater',
        destination = vector3(-830.92, -1343.15, 43.67),
        dest_label = 'Fast Travel to Blackwater'
    },
    {
        title = 'Fast Travel Rhodes',
        destination = vector3(1231.26, -1299.74, 76.9),
        dest_label = 'Fast Travel to Rhodes'
    },
    {
        title = 'Fast Travel Strawberry',
        destination = vector3(-1827.5, -437.65, 159.78),
        dest_label = 'Fast Travel to Strawberry'
    },
    {
        title = 'Fast Travel Saint Denis',
        destination = vector3(2747.10, -1394.87, 46.18),
        dest_label = 'Fast Travel to Saint Denis'
    },
    {
        title = 'Fast Travel Tumbleweed',
        destination = vector3(-5501.2, -2954.32, -1.73),
        dest_label = 'Fast Travel to Tumbleweed'
    },
    {
        title = 'Fast Travel Valentine',
        destination = vector3(-174.39, 633.33, 114.09),
        dest_label = 'Fast Travel to Valentine'
    },
    {
        title = 'Fast Travel Van-Horn',
        destination = vector3(2893.37, 624.33, 57.72),
        dest_label = 'Fast Travel to Van-Horn'
    },
    {
        title = 'Fast Travel Sisika',
        destination = vector3(3266.8964, -715.8876, 41.03495),
        dest_label = 'Fast Travel to Sisika'
    },
}

---------------------------
-- Fast Travel Interaction Points
-- These are the locations where players can access the fast travel menu
---------------------------
Config.FastTravelLocations = {

    {name = 'Fast Travel', location = 'annesburg',  coords = vector3(2931.614, 1283.1109, 44.65287),  showblip = true}, --annesburg
    {name = 'Fast Travel', location = 'armadillo',  coords = vector3(-3729.09, -2603.55, -12.94),     showblip = true}, --armadillo
    {name = 'Fast Travel', location = 'blackwater', coords = vector3(-830.92, -1343.15, 43.67),       showblip = true}, --blackwater
    {name = 'Fast Travel', location = 'rhodes',     coords = vector3(1231.26, -1299.74, 76.9),        showblip = true}, --rhodes
    {name = 'Fast Travel', location = 'strawberry', coords = vector3(-1827.5, -437.65, 159.78),       showblip = true}, --strawberry
    {name = 'Fast Travel', location = 'st-denis',   coords = vector3(2747.10, -1394.87, 46.18),       showblip = true}, --st denis
    {name = 'Fast Travel', location = 'tumbleweed', coords = vector3(-5501.2, -2954.32, -1.73),       showblip = true}, --tumbleweed
    {name = 'Fast Travel', location = 'valentine',  coords = vector3(-174.39, 633.33, 114.09),        showblip = true}, --valentine
    {name = 'Fast Travel', location = 'van-horn',   coords = vector3(2893.37, 624.33, 57.72),         showblip = true}, --van horn trading post
    {name = 'Fast Travel', location = 'sisika',     coords = vector3(3266.8964, -715.8876, 42.03495), showblip = true}, --sisika prison

}
