#!/usr/bin/env bash
install_obsidian() {
    log_info "Installing Obsidian"

    local url="$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | jq -r '.assets[] | select(.name | endswith(".dmg")) | .browser_download_url')"
    install_app_dmg_download "Obsidian.app" "$url"
}
