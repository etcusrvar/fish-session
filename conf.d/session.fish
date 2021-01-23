if set fish_private_mode 1 &>/dev/null
    set -g __session_fish_private_mode_settable 1
else if set -q fish_private_mode
    set -g __session_fish_private_mode 1
end
