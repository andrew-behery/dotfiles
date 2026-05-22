#!/bin/bash
# Bootstrap script — run this on a fresh omarchy install to restore your setup.
# Prerequisites: omarchy installed, git available.
#
# Usage: bash bootstrap.sh <dotfiles-repo-url>
set -e

DOTFILES_REPO="${1:?Usage: bootstrap.sh <repo-url>}"

echo "==> Cloning dotfiles..."
git clone --bare "$DOTFILES_REPO" "$HOME/.dotfiles"
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

echo "==> Adding dotfiles alias to ~/.bashrc..."
if ! grep -q "alias dotfiles=" ~/.bashrc; then
  echo "alias dotfiles='git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME'" >> ~/.bashrc
fi

echo "==> Installing packages..."
sudo pacman -S --needed - < "$HOME/.dotfiles-meta/packages.txt"

echo "==> Restoring dconf settings..."
dconf load / < "$HOME/.dotfiles-meta/dconf.ini"

echo "==> Making hooks executable..."
chmod +x "$HOME/.config/omarchy/hooks/"* 2>/dev/null || true

echo "Done. Reload your shell and run: omarchy theme set \"\$(cat ~/.config/omarchy/current/theme.name)\""
