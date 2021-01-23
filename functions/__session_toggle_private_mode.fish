function __session_toggle_private_mode

    if set -q __session_fish_private_mode_settable

        if set -q fish_private_mode
            set -e fish_private_mode
        else
            set -g fish_private_mode 1
        end

    else if set -q __session_fish_private_mode

        set -e __session_fish_private_mode

        if set -q __session_fish_history
            set -g fish_history $__session_fish_history
        else if not set -q fish_private_mode
            set -e fish_history
        end

        set -e __session_fish_history

    else

        set -g __session_fish_private_mode 1

        if set -q fish_history
            set -g __session_fish_history $fish_history
            switch $fish_history
                case ""
                    # don't set token
                case default fish
                    set token fish
                case \*
                    set token $fish_history
            end
        else
            set token fish
        end

        if set -q token

            set -g fish_history private_"$token"_$fish_pid

            set hfile $__fish_user_data_dir/"$token"_history
            set private_hfile $__fish_user_data_dir/"$fish_history"_history

            if test -f "$hfile" -a ! -f "$private_hfile"
                cp $hfile $private_hfile
            end

            if not functions -q __session_fish_exit_rm_private_history
                function __session_fish_exit_rm_private_history -e fish_exit -V private_hfile
                    if test -f "$private_hfile"
                        rm $private_hfile
                    end
                end
            end

        end

    end

    commandline -f repaint

end
