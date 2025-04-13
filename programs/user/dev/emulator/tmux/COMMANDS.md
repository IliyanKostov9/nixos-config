# Commands

Reload config: `tmux source ~/.tmux.conf`

## Session

- Create new session:

```bash
tmux new -s mysession
# or directly specify the file path: tmux new -d -c "$HOME/personal"
```

- Switch client

```bash
tmux switch-client -t "personal"
```

- Detach from the session (prefix + d)

```bash
tmux detatch
```

- Attach to an existing session:

```bash
tmux attach-session -t mysession # doesn't make the other clients connected to that session to detach
# -d = does that
# -A = attach to existing session if exists, else create one
# Or attach most recent session
tmux a
```

- Attach to an existing session, if it doesn't exist, then create one:

```bash
tmux new  -A mysession
# or detach existing clients
tmux new -D mysession
```

Rename a session: `prefix + $`

## Window

- Create new window: `prefix + c`

- or directly specify the file path: tmux new-window -d -c "$HOME/personal"

- Split window: `prefix + % / "`

- Jump to different windows: `prefix + 0/1/2`

- Jump to different windows with prompts: prefix + '

- Go to next/prev window: `pref + n/p`

- Kill a window: `prefix + &`

- Rename a winow: `prefix + ,`

- Move a window: `pefix + .`

- Swap a window (1 for example with 2): `:swap-window -s 1 -t 2`

## Panel

- Change to diffent active pane: `prefix + Up/Down...`

- Change to diffent active pane seletively: `prefix + q + 1/2/3`

- Change to next pane: `prefix + o`

- Print pane nums: `prefix + q`

- Kill a panel: `prefix + x`

- Mark a pane: `prefix + m`

- Swap pane: `prefix + { / }`

- Resize panels: `prefix + Alt + Up/Down...`

- Make pane full screen temporarly: `prefix + z`

- Randomly swap panels: `prefix + Space`

## Tree

- With sessions included: `prefix + s`

- With sessions and windows included: `prefix + w`

- Tag items: `t`

- Delete tagged items: `X`

## Helpers

- Copy: `prefix + [ + Space + vi mode + Enter to copy`

- List all keymaps: `prefix + ?`

- Show description of key: `prefix + /`

- List all shortcuts: `tmux lsk -N|more`

- List all sessions: `tmux ls`

- List all clients attached to session `prefix + D `

### Commands prefix + :

- Kill session `:kill-server`

- Create new winodw `:neww -n windowname nvim .`
