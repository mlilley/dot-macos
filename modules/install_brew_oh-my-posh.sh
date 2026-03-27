#!/usr/bin/env bash
install_oh-my-posh() {
    log_info "Installing Oh My Posh"

    # install
    brew_formula_install oh-my-posh

    # install theme
    mkdir -p "$HOME/.config/oh-my-posh"
    curl -fsSL "https://raw.githubusercontent.com/mlilley/omp-sanfran/refs/heads/master/oh-my-posh.toml" -o "$HOME/.config/oh-my-posh/oh-my-posh.toml"

    # load into shells
    echo 'eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/omp-sanfran.toml)"' >> "$HOME/.zshrc"
}