# fish-session

A function to help with using multiple fish [history sessions](https://fishshell.com/docs/current/cmds/history.html#customizing-the-name-of-the-history-file) and [private mode](https://fishshell.com/docs/current/index.html#private-mode).

It works by manipulating (copying, deleting) history files when private mode is toggled.

This works with fish 3.1.2 and the current master branch at [fish-shell](https://github.com/fish-shell/fish-shell). (3.1.2 <= fish <= \<future release\>) (And possibly older versions.)

This may not be too useful once `fish_private_mode` is settable-- when [fish-shell/#7589](https://github.com/fish-shell/fish-shell/issues/7589) and [fish-shell/#7590](https://github.com/fish-shell/fish-shell/issues/7590) land in fish 3.2.0 or later.

## Install
`> fisher install etcusrvar/fish-session`

## Usage
```fish
> session --help 
Usage: session [COMMAND]

If called without a COMMAND, prints the current session name.

Commands:
    is-private-mode      Exit status is 0 if private mode is enabled; 1 otherwise
    prune                Prunes orphaned private history files
    toggle-private-mode  Toggles private mode
```

## Examples

- Bind key to toggle history
```
> bind \ch "session toggle-private-mode"
```

- Toggle private mode during an active fish session. Retains current history. Multiple shells and fish sessions can individually toggle private mode and have different histories.

```fish
> session toggle-private-mode
> set -g
...
__session_fish_private_mode 1
fish_history private_fish_91848
fish_pid 91848
...
```

- Launch fish with a different session name (fish_history) and private mode at startup, loading that session's history, but not saving it at exit.
```
> fish_history=foo fish --private
> session
foo
> set -g
...
__session_fish_private_mode 1
fish_history foo
fish_private_mode 1
...
```

- If a shell or terminal quits or is killed abnormally without the fish_exit event being called, orphaned private history files can linger. They can be cleaned up with
```
> session prune
```
