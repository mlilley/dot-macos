#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/mlilley/dot-macos.git"
INSTALL_DIR="$HOME/.dot-macos"

# --- install Xcode CLT ---
# When piped via curl, BASH_SOURCE[0] is empty — install Xcode CLT (which
# provides git), clone the repo, then re-exec from disk.
if [[ -z "${BASH_SOURCE[0]:-}" || "${BASH_SOURCE[0]}" == "/dev/stdin" ]]; then
    if ! xcode-select -p &>/dev/null; then
        echo "Installing Xcode Command Line Tools"
        clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
        touch "$clt_placeholder"
        clt_label=""
        clt_label="$(
            /usr/sbin/softwareupdate -l |
            grep -B 1 -E 'Command Line Tools' |
            awk -F'*' '/^ *\*/ {print $2}' |
            sed -e 's/^ *Label: //' -e 's/^ *//' |
            sort -V |
            tail -n1
        )"
        if [[ -n "$clt_label" ]]; then
            sudo /usr/sbin/softwareupdate -i "$clt_label"
            sudo /usr/bin/xcode-select --switch /Library/Developer/CommandLineTools
        else
            /usr/bin/xcode-select --install
            echo "Waiting for Xcode CLT installation to complete..."
            until xcode-select -p &>/dev/null; do sleep 5; done
        fi
        rm -f "$clt_placeholder"
    else
        echo "Xcode Command Line Tools already installed ... skipping."
    fi

    echo "Cloning dot-macos..."
    if [[ -d "$INSTALL_DIR" ]]; then
        git -C "$INSTALL_DIR" pull --ff-only
    else
        git clone "$REPO" "$INSTALL_DIR"
    fi

    exec bash "$INSTALL_DIR/install.sh"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"

# shellcheck source=lib/utils.sh
source "$SCRIPT_DIR/lib/utils.sh"

# Source all modules, making their exec_<name> functions available
for module in "$MODULES_DIR"/*.sh; do
    [[ -f "$module" ]] || continue
    # shellcheck source=/dev/null
    source "$module"
done

# --- install modules ---
setup_macos_dock
setup_macos_finder
setup_macos_keyboard
setup_macos_trackpad
setup_dev
setup_ssh

install_homebrew
install_firefox
install_vscode
install_rectangle
install_mas_bitwarden
install_brew_docker
install_brew_colima
install_brew_devpod

setup_firefox
# setup_vscode