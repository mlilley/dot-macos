#!/usr/bin/env bash
# lib/utils.sh — shared utility functions for install modules

# --- output ---

_BOLD='\033[1m'
_RED='\033[0;31m'
_GREEN='\033[0;32m'
_YELLOW='\033[1;33m'
_CYAN='\033[0;36m'
_RESET='\033[0m'

log_info()    { echo -e "${_CYAN}  ==> ${_RESET}${*}"; }
log_success() { echo -e "${_GREEN}  ✓   ${_RESET}${*}"; }
log_warn()    { echo -e "${_YELLOW}  !   ${_RESET}${*}" >&2; }
log_error()   { echo -e "${_RED}  ✗   ${_RESET}${*}" >&2; }

step() {
    echo ""
    echo -e "${_BOLD}${_CYAN}▶ ${*}${_RESET}"
}

# --- checks ---

is_command_available() {
    command -v "$1" &>/dev/null
}

is_app_installed() {
    [[ -d "/Applications/$1" ]]
}

is_brew_formula_installed() {
    brew list --formula 2>/dev/null | grep -q "^${1}$"
}

is_brew_cask_installed() {
    brew list --cask 2>/dev/null | grep -q "^${1}$"
}

is_mas_app_installed() {
    local appId="$1"
    mas list "$appId" 2>/dev/null | grep -q "^\s*$appId\s"
}

verify_app_not_installed() {
    local app="$1"
    if is_app_installed "$app"; then
        log_info "App $app already installed, skipping"
        return 1
    fi
}

verify_brew_formula_not_installed() {
    local formula="$1"
    if is_brew_formula_installed "$formula"; then
        log_info "Brew formula $formula already installed, skipping"
        return 1
    fi
}

verify_brew_cask_not_installed() {
    local cask="$1"
    if is_brew_cask_installed "$cask"; then
        log_info "Brew cask $cask already installed, skipping"
        return 1
    fi
}

brew_formula_install() {
    local formula="$1"
    if ! is_command_available "brew"; then
        log_error "Error: homebrew is not installed"
        return 1
    fi
    if is_brew_formula_installed "$1"; then
        log_info "Brew formula $1 already installed, skipping"
        return 0
    fi
    log_info "Installing brew formula $1"
    if ! brew install "$1"; then
        log_error "Error: failed to install brew formula $1"
        return 1
    fi
}

brew_cask_install() {
    if ! is_command_available "brew"; then
        log_error "Error: homebrew is not installed"
        return 1
    fi
    if is_brew_cask_installed "$1"; then
        log_info "Brew cask $1 already installed, skipping"
        return 0
    fi
    log_info "Installing brew cask $1"
    if ! brew install --cask "$1"; then
        log_error "Error: failed to install brew cask $1"
        return 1
    fi
}

mas_install() {
    local appId="$1"
    local appName="$2"
    if ! is_command_available "mas"; then
        log_error "Error: mas is not installed"
        return 1
    fi
    if is_mas_app_installed "$1"; then
        log_info "Mac App Store app $appName already installed, skipping"
        return 0
    fi
    log_info "Installing Mac App Store app $appName"
    if ! mas install "$appId"; then
        log_error "Error: failed to install Mac App Store app $appName"
        return 1
    fi
}

install_app_dmg_download() {
    local force=0
    if [[ "$1" == "--force" || "$1" == "-f" ]]; then
        force=1
        shift
    fi
    local app="$1" # ex: "MyApp.app"
    local url="$2"

    if [[ "$force" -eq 0 ]] && is_app_installed "${app}"; then
        log_info "App $app already installed; skipping"
        return 0
    fi

    local tmp
    tmp="$(mktemp -d -t dotmacos)"
    trap "rm -rf '$tmp'" EXIT

    log_info "Downloading $url"
    if ! curl -sS --fail -L "$url" -o "$tmp/download.dmg"; then
        log_error "Error: download failed"
        return 1
    fi

    log_info "Mounting $tmp/download.dmg"
    if ! hdiutil attach "$tmp/download.dmg" -nobrowse -noautoopen -readonly -quiet -mountpoint "$tmp/mount"; then
        log_error "Error: unable to mount $tmp/download.dmg"
        return 1
    fi

    trap "hdiutil detach '$tmp/mount' -quiet 2>/dev/null; rm -rf '$tmp'" EXIT
    if [[ ! -d "$tmp/mount/$app" ]]; then        
        log_error "Error: $app not found in dmg"
        return 1
    fi

    log_info "Installing $app"
    if ! rm -rf "/Applications/$app"; then
        log_error "Error: failed to remove existing app /Applications/$app"
        return 1
    fi
    if ! cp -R "$tmp/mount/$app" "/Applications"; then 
        log_error "Error: failed to install app to /Applications/$app"
        return 1
    fi
}

install_app_zip_download() {
    local force=0
    if [[ "$1" == "--force" || "$1" == "-f" ]]; then
        force=1
        shift
    fi
    local app="$1" # ex: "MyApp.app"
    local url="$2"

    if [[ "$force" -eq 0 ]] && is_app_installed "${app}"; then
        log_info "App $app already installed; skipping"
        return 0
    fi

    local tmp
    tmp="$(mktemp -d -t dotmacos)"
    trap "rm -rf '$tmp'" EXIT

    log_info "Downloading $url"
    if ! curl -sS --fail -L "$url" -o "$tmp/download.zip"; then
        log_error "Error: download failed"
        return 1
    fi

    log_info "Unzipping $tmp/download.zip"
    mkdir -p "$tmp/extracted"
    if ! unzip -q "$tmp/download.zip" -d "$tmp/extracted/"; then
        log_error "Error: failed to unzip"
        return 1
    fi
    if [[ ! -d "$tmp/extracted/$app" ]]; then
        log_error "Error: cannot find $app in zip contents"
        return 1
    fi
    
    log_info "Installing $app"
    if ! rm -rf "/Applications/$app"; then
        log_error "Error: failed to remove existing app /Applications/$app"
        return 1
    fi
    if ! cp -R "$tmp/extracted/$app" "/Applications"; then 
        log_error "Error: failed to install app to /Applications/$app"
        return 1
    fi
}
