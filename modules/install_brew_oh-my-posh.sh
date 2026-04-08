#!/usr/bin/env bash
install_oh-my-posh() {
    log_info "Installing Oh My Posh"

    # install
    brew_formula_install oh-my-posh

    # install theme
    mkdir -p "$HOME/.config"
    git clone "https://github.com/mlilley/omp-sanfran.git" "~/.config/omp-sanfran"

    # load into shells
    echo 'eval "$(oh-my-posh init zsh --config ~/.config/omp-sanfran/omp-sanfran-camp.toml)"' >> "$HOME/.zshrc"
}