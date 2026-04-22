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

## Tmux Sessions (`tm*`)

```bash
tml               # List sessions
tma               # Attach to session (fzf picker)
tmk               # Kill a session (fzf picker)
tmka              # Kill all sessions
tmc               # Create session from template (fzf picker)
```

### Available Templates

| Name | Description |
|------|-------------|
| `dev` | Generic dev: nvim (80%) + terminal (20%), uses current directory |
| `exchangeflo` | ExchangeFlo: 2 windows (apps 4x2 grid, nvim) |
| `monitor` | Monitor: k9s + btop (75% left), 4 terminal panes (25% right) |

## Worktree Branches (`tb*`)

```bash
tbc <branch>               # Create worktree + pick template + launch session
                           # Uses existing branch or creates new one from main
                           # Example: tbc jr/my-feature

tbc -f <base> <branch>     # Create worktree + new branch from a specific base
                           # Example: tbc -f jr/wr-consent jr/consent-gating

tbk                        # Kill worktree session + remove worktree (fzf picker)

tbl                        # List all worktrees
```

## Misc

| Shortcut | Action |
|----------|--------|
| `prefix d` | Detach from session |
| `prefix r` | Reload tmux config |
