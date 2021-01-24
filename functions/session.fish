function session -d "Work with fish sessions and private mode"

    set options (fish_opt -s h -l help)
    argparse $options -- $argv

    if set -q _flag_help
        echo "Usage: session COMMAND

Commands:
    is-private-mode      Exit status is 0 if private mode is enabled; 1 otherwise
    prune                Prunes orphaned private history files
    toggle-private-mode  Toggles private mode"

        return 0
    end

    switch $argv[1]
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


function __session_prune
    set -q __session_fish_private_mode_settable && return 0

    for f in $__fish_user_data_dir/private_*_history
        set pid (echo $f | sed 's/.*\/private_.*_\([0-9]*\)_history/\1/')
        if test -d /proc/$pid
            if ! test (basename (realpath /proc/$pid/exe)) = fish
                rm -v $f
            end
        else
            rm -v $f
        end
    end

end


function __session_toggle_private_mode

    if set -q __session_fish_private_mode_settable

        if set -q fish_private_mode
            set -e fish_private_mode
        else
            set -g fish_private_mode 1
        end

    else

        if set -q __session_fish_private_mode

            set -e __session_fish_private_mode
            set -g fish_history $fish_session

        else

            set -g __session_fish_private_mode 1
            set -g fish_history private_"$fish_session"_$fish_pid

            if test $fish_session = default
                set hfile $__fish_user_data_dir/fish_history
            else
                set hfile $__fish_user_data_dir/"$fish_session"_history
            end
            set private_hfile $__fish_user_data_dir/"$fish_history"_history

            if test -f $hfile -a ! -f $private_hfile
                cp $hfile $private_hfile
            end

            if not functions -q __session_fish_exit_rm_private_history
                function __session_fish_exit_rm_private_history -e fish_exit -V private_hfile
                    if test -f $private_hfile
                        rm $private_hfile
                    end
                end
            end

        end
    end

    commandline -f repaint

end
