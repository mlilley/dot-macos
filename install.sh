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

    exec bash "$INSTALL_DIR/install.sh" "$@"
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"

# --- parse arguments ---
MANIFEST=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --manifest)
            MANIFEST="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1" >&2
            exit 1
            ;;
    esac
done

if [[ -z "$MANIFEST" ]]; then
    echo "Usage: install.sh --manifest <manifest-file>" >&2
    exit 1
fi

if [[ ! -f "$MANIFEST" ]]; then
    echo "Manifest file not found: $MANIFEST" >&2
    exit 1
fi

# shellcheck source=lib/utils.sh
source "$SCRIPT_DIR/lib/utils.sh"

# Source all modules, making their functions available
for module in "$MODULES_DIR"/*.sh; do
    [[ -f "$module" ]] || continue
    # shellcheck source=/dev/null
    source "$module"
done

# --- run manifest ---
while IFS= read -r line || [[ -n "$line" ]]; do
    # strip comments and blank lines
    line="${line%%#*}"
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [[ -z "$line" ]] && continue

    if declare -f "$line" > /dev/null 2>&1; then
        "$line"
    else
        echo "Warning: '$line' is not a known function, skipping." >&2
    fi
done < "$MANIFEST"