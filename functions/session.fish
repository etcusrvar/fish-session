function session -d "Work with fish sessions and private mode"

    set options (fish_opt -s h -l help)
    argparse $options -- $argv

    if set -q _flag_help
        echo 'Usage: session [COMMAND]

If called without a COMMAND, prints the current session name.

Commands:
    is-private-mode      Exit status is 0 if private mode is enabled; 1 otherwise
    prune                Prunes orphaned private history files
    toggle-private-mode  Toggles private mode'

        return 0
    end

    switch $argv[1]
        case ""
            __session_name
        case is-private-mode
            if set -q __session_fish_private_mode_settable
                set -q fish_private_mode
            else
                set -q __session_fish_private_mode
            end
        case prune
            __session_prune
        case toggle-private-mode
            __session_toggle_private_mode
        case \*
            return 1

    end

end
