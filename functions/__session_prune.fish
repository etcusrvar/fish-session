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
