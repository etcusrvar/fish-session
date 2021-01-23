complete -c session -s h -l help -d "Show this help message and exit"

complete -c session -xn "__fish_use_subcommand" -a is-private-mode -d "Exit status is 0 if private mode is enabled; 1 otherwise"
complete -c session -xn "__fish_use_subcommand" -a prune -d "Prunes orphaned private history files"
complete -c session -xn "__fish_use_subcommand" -a toggle-private-mode -d "Toggles private mode"
