Config = {}

---------------------------
-- settings
---------------------------
Config.Keybind = 'J'

---------------------------
-- blip settings
---------------------------
Config.Blip = {
    blipName = 'Fast Travel', -- Config.Blip.blipName
    blipSprite = 'blip_ambient_warp', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

---------------------------
-- fast travel config
---------------------------
Config.FastTravel = {
    {
        title = 'Fast Travel Annesburg',
        destination = vector3(2945.21, 1272.35, 44.0 -1),
        dest_label = 'Fast Travel to Annesburg',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Armadillo',
        destination = vector3(-3729.09, -2603.55, -12.94 -1),
        dest_label = 'Fast Travel to Armadillo',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Blackwater',
        destination = vector3(-830.92, -1343.15, 43.67 -1),
        dest_label = 'Fast Travel to Blackwater',
        cost = 20,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Rhodes',
        destination = vector3(1218.83, -1298.03, 76.0 -1),
        dest_label = 'Fast Travel to Rhodes',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Strawberry',
        destination = vector3(-1827.5, -437.65, 159.78 -1),
        dest_label = 'Fast Travel to Strawberry',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Saint Denis',
        destination = vector3(2688.77, -1459.11, 46.0 -1),
        dest_label = 'Fast Travel to Saint Denis',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Tumbleweed',
        destination = vector3(-5501.2, -2954.32, -1.73 -1),
        dest_label = 'Fast Travel to Tumbleweed',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Valentine',
        destination = vector3(-170.64, 628.58, 113.00 -1),
        dest_label = 'Fast Travel to Valentine',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Van-Horn',
        destination = vector3(2891.5263, 619.09191, 57.721347 -1),
        dest_label = 'Fast Travel to Van-Horn',
        cost = 10,
        traveltime = 30000
    },
    {
        title = 'Fast Travel Sisika',
        destination = vector3(3266.8964, -715.8876, 42.03495 -1),
        dest_label = 'Fast Travel to Sisika',
        cost = 10,
        traveltime = 30000
    },
}

---------------------------
-- fast travel prompt locations
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
