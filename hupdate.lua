-- run:
-- redis-cli script load "$(cat hupdate.lua)"
-- redis-cli evalsha <eval-sha> 2 <KEYS[1]> <KEYS[2]>

local hupdate = function()
    local result = 1
    local exists = redis.call('HEXISTS', KEYS[1], KEYS[2])
    if (exists == 1) then
        local old = redis.call('HGET', KEYS[1], KEYS[2])
        result = result + old
    end
    return redis.call('HSET', KEYS[1], KEYS[2], result)
end

return hupdate()