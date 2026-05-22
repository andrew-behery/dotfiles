# dotfiles

Personal configuration for my [Omarchy](https://omarchy.org/) setup on Arch Linux + Hyprland.

## What's tracked

| Path | Purpose |
|------|---------|
| `.config/hypr/bindings.conf` | Custom keybindings (Discord, Telegram, Foliate) |
| `.config/omarchy/hooks/theme-set` | Auto-syncs Foliate theme when omarchy theme changes |
| `.config/com.github.johnfactotum.Foliate/themes/` | Foliate reader themes matched to every omarchy theme |
| `.config/gtk-4.0/gtk.css` | Square corners on all GTK4 apps |
| `.dotfiles-meta/packages.txt` | Explicitly installed packages |
| `.dotfiles-meta/dconf.ini` | dconf settings export |
| `.dotfiles-meta/bootstrap.sh` | New machine setup script |

## New machine setup

1. Install [Omarchy](https://omarchy.org/)
2. Run the bootstrap script:

```bash
bash <(curl -s https://raw.githubusercontent.com/andrew-behery/dotfiles/master/.dotfiles-meta/bootstrap.sh) git@github.com:andrew-behery/dotfiles.git
```

The script will:
- Clone this repo as a bare dotfiles repo at `~/.dotfiles`
- Check out all tracked config files
- Install all packages from `packages.txt`
- Install the Lasthorizon omarchy theme
- Restore dconf settings

## Day-to-day usage

The `dotfiles` alias works like `git` but scoped to this repo:

```bash
dotfiles status
dotfiles add ~/.config/hypr/bindings.conf
dotfiles commit -m "update keybindings"
dotfiles push
```

Keep `packages.txt` and `dconf.ini` fresh before pushing:

```bash
pacman -Qqe > ~/.dotfiles-meta/packages.txt
dconf dump / > ~/.dotfiles-meta/dconf.ini
dotfiles add ~/.dotfiles-meta/
dotfiles commit -m "refresh packages and dconf"
dotfiles push
```
