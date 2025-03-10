local utils = require('eccis.libs.utils')


function EventManagerBuilder()

    local subscribers = {}

    local subscribe = function(eventType, listener, callback)
        if not subscribers[eventType] then
            subscribers[eventType] = {}
        end
        table.insert(subscribers[eventType], {
            listener = listener,
            callback = callback
        })
    end

    local unsubscribe = function(eventType, listener)
        if subscribers[eventType] then
            subscribers[eventType] = utils.filter(subscribers[eventType], function(sub)
                return sub.listener ~= listener
            end)
        end
    end

    local fire = function(eventType, data, publisher)
        if subscribers[eventType] then
            for _, sub in ipairs(subscribers[eventType]) do
                sub.callback(data, publisher)
            end
        end
    end

    return {
        subscribe = subscribe,
        unsubscribe = unsubscribe,
        fire = fire
    }

end


return EventManagerBuilder
