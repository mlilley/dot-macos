#!/usr/bin/env bash
setup_vscode() {
    # DO NOT USE

    local code="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"

    echo "Installing extensions..."
    "$code" --install-extension eamodio.gitlens

    echo "Applying settings..."
    local settings_path="$HOME/Library/Application Support/Code/User/settings.json"
    mkdir -p "$(dirname "$settings_path")"
    cat > "$settings_path" <<'EOF'
{
    "editor.minimap.enabled": false
}
EOF

}