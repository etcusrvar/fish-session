if set -q fish_private_mode
    if set fish_private_mode $fish_private_mode &>/dev/null
        set -g __session_fish_private_mode_settable 1
    else
        set -g __session_fish_private_mode 1
    end
else if set -l fish_private_mode 1 &>/dev/null
    set -g __session_fish_private_mode_settable 1
    set -e fish_private_mode
end
