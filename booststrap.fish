#!/usr/bin/env fish

set dotfiles_dir (dirname (status --current-filename))
cd $dotfiles_dir

set hostname (hostname -s)
set host_dir "host-$hostname"

echo "[*] Hostname detected: $hostname"

if not type -q xstow
    echo "[!] xstow is not installed. Please install it first."
    exit 1
end

if test -d shared
    echo "[*] Stowing shared dotfiles..."
    make
end

# Stow host-specific dotfiles if exists
if test -d $host_dir
    echo "[*] Stowing host-specific dotfiles from $host_dir..."
    cd $host_dir && make && cd ..
else
    echo "[!] No host-specific dotfiles found for: $host_dir"
end

echo "[✓] Dotfiles setup complete."
