return function(cooldown)
    local lastClock = 0

    return function()
        if os.clock() - lastClock > cooldown then
            lastClock = os.clock()
            return true
        end

        return false
    end
end
