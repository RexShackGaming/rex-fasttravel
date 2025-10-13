-----------------------------------------------------------------
-- Utility Functions for Rex Fast Travel
-----------------------------------------------------------------

Utils = {}

-----------------------------------------------------------------
-- Calculate 3D distance between two vector3 points
-----------------------------------------------------------------
Utils.GetDistance = function(pos1, pos2)
    if not pos1 or not pos2 then
        return 0
    end
    
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    local dz = pos1.z - pos2.z
    
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

-----------------------------------------------------------------
-- Calculate travel cost based on distance
-----------------------------------------------------------------
Utils.CalculateTravelCost = function(playerPos, destination)
    if not Config.DynamicPricing then
        -- Return default cost from config if dynamic pricing is disabled
        for _, travel in ipairs(Config.FastTravel) do
            if travel.destination.x == destination.x and 
               travel.destination.y == destination.y and 
               travel.destination.z == destination.z then
                return travel.cost
            end
        end
        return 10 -- Fallback default cost
    end
    
    local distance = Utils.GetDistance(playerPos, destination)
    local cost = 0
    
    if Config.Pricing.useTiers then
        -- Use tier-based pricing
        cost = Config.Pricing.maximumCost -- Default to max cost
        
        for _, tier in ipairs(Config.Pricing.tiers) do
            if distance <= tier.maxDistance then
                cost = tier.cost
                break
            end
        end
    else
        -- Use distance-based formula
        cost = Config.Pricing.baseCost + (distance * Config.Pricing.costPerUnit)
        
        -- Apply min/max limits
        cost = math.max(Config.Pricing.minimumCost, cost)
        cost = math.min(Config.Pricing.maximumCost, cost)
    end
    
    return math.floor(cost) -- Round down to nearest dollar
end

-----------------------------------------------------------------
-- Calculate travel wait time based on distance
-----------------------------------------------------------------
Utils.CalculateTravelWaitTime = function(playerPos, destination)
    if not Config.DynamicWaitTime then
        -- Return default wait time from config if dynamic wait time is disabled
        for _, travel in ipairs(Config.FastTravel) do
            if travel.destination.x == destination.x and 
               travel.destination.y == destination.y and 
               travel.destination.z == destination.z then
                return travel.traveltime
            end
        end
        return 30000 -- Fallback default wait time (30 seconds)
    end
    
    local distance = Utils.GetDistance(playerPos, destination)
    local waitTime = 0
    
    if Config.WaitTime.useTiers then
        -- Use tier-based wait times
        waitTime = Config.WaitTime.maximumWaitTime -- Default to max wait time
        
        for _, tier in ipairs(Config.WaitTime.tiers) do
            if distance <= tier.maxDistance then
                waitTime = tier.waitTime
                break
            end
        end
    else
        -- Use distance-based formula
        waitTime = Config.WaitTime.baseWaitTime + (distance * Config.WaitTime.timePerUnit)
        
        -- Apply min/max limits
        waitTime = math.max(Config.WaitTime.minimumWaitTime, waitTime)
        waitTime = math.min(Config.WaitTime.maximumWaitTime, waitTime)
    end
    
    return math.floor(waitTime) -- Round down to nearest millisecond
end

-----------------------------------------------------------------
-- Format wait time for display (convert ms to readable format)
-----------------------------------------------------------------
Utils.FormatWaitTime = function(waitTimeMs)
    local seconds = math.floor(waitTimeMs / 1000)
    
    if seconds < 60 then
        return string.format("%ds", seconds)
    else
        local minutes = math.floor(seconds / 60)
        local remainingSeconds = seconds % 60
        if remainingSeconds > 0 then
            return string.format("%dm %ds", minutes, remainingSeconds)
        else
            return string.format("%dm", minutes)
        end
    end
end

-----------------------------------------------------------------
-- Get distance category for display purposes
-----------------------------------------------------------------
Utils.GetDistanceCategory = function(distance)
    if distance <= 500 then
        return "Short"
    elseif distance <= 1500 then
        return "Medium" 
    elseif distance <= 3000 then
        return "Long"
    elseif distance <= 5000 then
        return "Very Long"
    else
        return "Extreme"
    end
end

-----------------------------------------------------------------
-- Validate destination exists in config
-----------------------------------------------------------------
Utils.IsValidDestination = function(destination)
    if not destination or type(destination) ~= 'vector3' then
        return false
    end
    
    for _, travel in ipairs(Config.FastTravel) do
        if travel.destination.x == destination.x and 
           travel.destination.y == destination.y and 
           travel.destination.z == destination.z then
            return true
        end
    end
    
    return false
end

-- Export Utils globally for FiveM
_G.Utils = Utils

-- Debug print to verify loading
print('[rex-fasttravel] Utils module loaded successfully')
