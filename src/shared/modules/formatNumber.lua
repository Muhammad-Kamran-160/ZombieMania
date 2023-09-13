--[[
    Format Number
    Author: Kamran / portodemesso
--]]

return function(_number)
    local number = tostring(_number)
    local new, _ = number:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")

    return new
end