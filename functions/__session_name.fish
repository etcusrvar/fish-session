function __session_name
    if set -q __session_fish_private_mode_settable
        echo $fish_history
    else if set -q __session_fish_private_mode
        and not set -q fish_private_mode
        echo $__session_fish_history
    else if set -q __session_fish_history
        echo $__session_fish_history
    else
        echo $fish_history
    end
end
