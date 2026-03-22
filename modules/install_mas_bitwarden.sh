#!/usr/bin/env bash
install_mas_bitwarden() {
    # Install Bitwarden from Mac App Store
    # NB: Bitwarden can be installed via .app download, homebrew cask, etc
    # but only the Mac App Store version supports biometric unlock.
    mas_install "1352778147" "Bitwarden"
}