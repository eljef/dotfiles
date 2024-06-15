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
