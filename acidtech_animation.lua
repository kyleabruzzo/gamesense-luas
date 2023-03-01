-- @credits to noodlehvh and https://gamesense.pub/forums/viewtopic.php?id=40876
local screen = {client.screen_size()}
local x_offset, y_offset = screen[1], screen[2]
local x, y =  x_offset/2,y_offset/2 

local rgba_to_hex = function(b, c, d, e)
    return string.format('%02x%02x%02x%02x', b, c, d, e)
end
function lerp(a, b, t)
    return a + (b - a) * t
end
function clamp(x, minval, maxval)
    if x < minval then
        return minval
    elseif x > maxval then
        return maxval
    else
        return x
    end
end
local function text_fade_animation(x, y, speed, color1, color2, text)
    local final_text = ''
    local curtime = globals.curtime()
    for i = 0, #text do
        local x = i * 10  
        local wave = math.cos(2 * speed * curtime / 4 + x / 30)
        local color = rgba_to_hex(
            lerp(color1.r, color2.r, clamp(wave, 0, 1)),
            lerp(color1.g, color2.g, clamp(wave, 0, 1)),
            lerp(color1.b, color2.b, clamp(wave, 0, 1)),
            color1.a
        ) 
        final_text = final_text .. '\a' .. color .. text:sub(i, i) 
    end
    
    renderer.text(x, y, color1.r, color1.g, color1.b, color1.a, "c", nil, final_text .. "°")
end


client.set_event_callback("paint", function() 
    text_fade_animation(x + 2, y + 15, 1, {r=110, g=185, b=255, a=255}, {r=255, g=255, b=255, a=255}, "acidtech")
    --[[  how to use? -> :
        text_fade_animation(x , y , animation speed,  {1st color}, {2nd color}, "text")
    --]]
end)
