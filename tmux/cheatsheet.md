# Tmux Cheatsheet

Prefix: `Ctrl+Space`

## Navigation

| Shortcut | Action |
|----------|--------|
| `Ctrl+h/j/k/l` | Move between panes (vim-aware, works inside nvim) |
| `Ctrl+Shift+H` | Previous window |
| `Ctrl+Shift+L` | Next window |
| `Alt+1-9` | Jump to window by number |
| `Ctrl+,` | Previous session |
| `Ctrl+.` | Next session |

## Windows & Panes

| Shortcut | Action |
|----------|--------|
| `prefix c` | New window (inherits current path) |
| `prefix \|` | Split pane horizontally (inherits path) |
| `prefix -` | Split pane vertically (inherits path) |
| `prefix x` | Kill pane |
| `prefix ,` | Rename window |
| `prefix $` | Rename session |
| `prefix z` | Toggle pane zoom (fullscreen / restore) |
| `prefix H/J/K/L` | Resize pane (repeatable) |

## Copy Mode (vi)

| Shortcut | Action |
|----------|--------|
| `prefix [` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl+v` | Toggle rectangle selection |
| `y` | Copy selection and exit |

## Sesh (in tmux)

| Shortcut | Action |
|----------|--------|
| `prefix T` | Fuzzy session picker (fzf + sesh) |
| `prefix S` | Toggle last session |
| `prefix N` | Create new session (prompts for name) |

### Sesh Picker Controls

| Key | Action |
|-----|--------|
| `Ctrl+a` | Show all (sessions + directories) |
| `Ctrl+t` | Filter to tmux sessions only |
| `Ctrl+x` | Filter to zoxide directories |
| `Ctrl+g` | Filter to sesh configs |
| `Ctrl+f` | Find directories |
| `Ctrl+d` | Kill selected session |

## Shell Aliases

```bash
tl                # List all sesh sessions
tla               # Fuzzy attach to a session (fzf picker)
tk                # Pick a session to kill (fzf picker)
tka               # Kill all sessions (kill tmux server)
```

## Session Templates (`tc`)

```bash
tc                # Pick a template to launch (fzf picker)
tc -n <name>      # Create an ad-hoc session in the current directory
```

### Available Templates

| Name | Description |
|------|-------------|
| `dotfiles` | Dotfiles: nvim (80%) + terminal (20%) |
| `exchangeflo` | ExchangeFlo: 4 windows (exchangeflo, wringer, nvim, system) |

## Misc

| Shortcut | Action |
|----------|--------|
| `prefix d` | Detach from session |
| `prefix r` | Reload tmux config |
