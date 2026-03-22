#!/usr/bin/env bash
setup_firefox() {
    # Refer: notes/firefox.md

    if ! is_app_installed "Firefox.app"; then
        log_error "Error: Firefox.app not installed"
        return 1
    fi

    # Load settings
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local settings_path="$script_dir/../module_data/setup_firefox.txt"
    if [[ ! -f "$settings_path" ]]; then
        log_error "Error: input settings not found at $settings_path"
        return 1
    fi

    # Perform Firefox initial launch, to create profiles.
    log_info "Launching Firefox.app to create initial profiles"
    if ! open -a Firefox --args --headless; then
        log_error "Error: failed to launch Firefox.app"
        return 1
    fi
    log_info "Waiting for firefox to start..."
    while ! pgrep -x Firefox &>/dev/null; do
        sleep 0.5
    done
    sleep 10
    while pgrep -x Firefox &>/dev/null; do
        read -p "Please close Firefox.app, then press Enter to continue"
    done
    # if ! pkill -x Firefox; then
    #     log_error "Error: failed to kill Firefox.app"
    #     return 1
    # fi

    # Find prefs.js of the primary profile
    local profile_ini="$HOME/Library/Application Support/Firefox/profiles.ini"
    local profile_dir
    local prefs_path
    if [[ ! -f "$profile_ini" ]]; then
        log_error "Error: failed to find Firefox profiles.ini at: $profile_ini"
        return 1
    fi
    profile_dir="$(grep -A1 '^\[Install' "$profile_ini" | grep '^Default=' | cut -d= -f2)"
    if [[ -z "$profile_dir" ]]; then
        log_error "Error: failed to determine Firefox profile directory from: $profile_ini"
        return 1
    fi
    prefs_path="$HOME/Library/Application Support/Firefox/$profile_dir/prefs.js"
    if [[ ! -f "$prefs_path" ]]; then
        log_error "Error: failed to find prefs.js at: $prefs_path"
        return 1
    fi

    # Backup prefs.js
    log_info "Backing up Firefox prefs to: $prefs_path.prev"
    cp "$prefs_path" "$prefs_path.prev"
    
    
    # Merge merge settings into prefs.js
    local settings
    settings="$(cat "$settings_path")"
    local key prefix
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        [[ "$line" != user_pref\(* ]] && continue
        key=$(printf '%s' "$line" | sed 's/user_pref("\([^"]*\)".*/\1/')
        prefix="user_pref(\"$key\""
        if grep -qF "$prefix" "$prefs_path"; then
            awk -v prefix="$prefix" -v newline="$line" '
                index($0, prefix) == 1 { print newline; next }
                { print }
            ' "$prefs_path" > "$prefs_path.tmp" && mv "$prefs_path.tmp" "$prefs_path" || rm -f "$prefs_path.tmp"
        else
            printf '%s\n' "$line" >> "$prefs_path"
        fi
    done <<< "$settings"

    log_success "Firefox settings applied"
}
