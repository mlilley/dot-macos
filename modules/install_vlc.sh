#!/usr/bin/env bash
install_vlc() {
    log_info "Installing VLC"

    # find download link for latest version
    local url="$(curl -s https://update.videolan.org/vlc/sparkle/vlc-arm64.xml \
        | grep -o 'url="[^"]*arm64\.dmg"' \
        | tail -n1 \
        | cut -d'"' -f2)"

    # install
    install_app_dmg_download "VLC.app" "$url"
}