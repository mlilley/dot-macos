#!/usr/bin/env bash
install_homebrew() {
    if is_command_available "brew"; then
        log_info "Homebrew already installed, skipping"
        return 0
    fi

    log_info "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Homebrew post-install shell configuration
    local shellcfg='eval "$(/opt/homebrew/bin/brew shellenv)"'
    case "$(basename "$SHELL")" in
        zsh)
            local zdotdir="${ZDOTDIR:-$HOME}"
            if [ -f "$zdotdir/.zshrc" ]; then
                echo "$shellcfg" >> "$zdotdir/.zshrc"
            else
                echo "$shellcfg" >> "$zdotdir/.zprofile"
            fi
            ;;
        bash)
            if [ -f "$HOME/.bashrc" ]; then
                echo "$shellcfg" >> "$HOME/.bashrc"
            elif [ -f "$HOME/.bash_profile" ]; then
                echo "$shellcfg" >> "$HOME/.bash_profile"
            else
                echo "$shellcfg" >> "$HOME/.profile"
            fi
            ;;
        *)
            log_error "Unable to add homebrew shell config to shell: please add `$shellcfg` to your shell config and try again."
            return 1
            ;;
    esac
}
