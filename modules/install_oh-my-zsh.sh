#!/usr/bin/env bash
install_oh-my-zsh() {
    log_info "Installing Oh My Zsh"

    # install
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # configure

    # enable autoupdating
    sed -i '/^# zstyle ':omz:update' mode auto/s/^# //' "$HOME/.zshrc"
    sed -i '/^# zstyle ':omz:update' frequency/s/^# //' "$HOME/.zshrc"

    # brew integration
    echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> "$HOME/.zshrc"
}