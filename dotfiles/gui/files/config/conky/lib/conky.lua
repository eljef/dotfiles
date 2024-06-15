--[[Copyright (c) 2020-2024, Jef Oliver

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

SPDX-License-Identifier: 0BSD

Authors:
Jef Oliver <jef@eljef.me>
]]

function expand_path(path_s)
    local home_p = os.getenv("HOME")

    if string.sub(path_s, 0, 1) == "~" then
        return path_s:gsub("~", home_p)
    end

    if string.sub(path_s, 0, 5) == "$HOME" then
        return path_s:gsub("$HOME", home_p)
    end

    return path_s
end

function conky_weather_icon(w_icon, w_icons, size, pos)
    local icon_n = expand_path(w_icon)
    local icon_p = expand_path(w_icons)
    local file = io.open(icon_n);
    if file then
        local c = file:read("*a");
        return "${image "..icon_p.."/"..c..".png -s "..size.." -p "..pos.."}";
    end
    return "";
end
