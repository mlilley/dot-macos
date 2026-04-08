#!/usr/bin/env bash
setup_vscode() {
    # DO NOT USE

    local code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

    # Install 'code' command
    sudo mkdir -p "/usr/local/bin"
    sudo ln -s "$code" code

    # Install extensions
    "$code" --install-extension eamodio.gitlens  # gitlense

    # Configure
    local settings_path="$HOME/Library/Application Support/Code/User/settings.json"
    mkdir -p "$(dirname "$settings_path")"
    cat > "$settings_path" <<'EOF'
{
    "editor.minimap.enabled": false,
    "explorer.confirmDragAndDrop": false,
    "terminal.integrated.showLinkHover": false,
    "terminal.integrated.fontFamily": "'MesloLGMDZ Nerd Font Mono'"
}
EOF

}
