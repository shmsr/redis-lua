-- run:
-- redis-cli script load "$(cat hlenall.lua)"
-- redis-cli evalsha <eval-sha> 0

local hlenall = function()
    -- KEYS * (Return all hash key(s))
    local result = 0
    local bulk_hash_keys = redis.call('KEYS', '*')
    for _, v in pairs(bulk_hash_keys) do
        -- HLEN <hash-key> (Length per hash key)
        result = result + redis.call('HLEN', v)
    end
    return result
end

return hlenall()