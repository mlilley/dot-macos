#!/usr/bin/env bash
install_brew_docker() {
    brew_formula_install docker
    brew_formula_install docker-compose
    brew_formula_install docker-buildx

    # Update docker config to register compose and buildx plugins
    local docker_config="$HOME/.docker/config.json"
    if [[ ! -f "$docker_config" ]]; then
        mkdir -p "$(dirname "$docker_config")"
        echo '{}' > "$docker_config"
    fi
    local tmp
    tmp=$(jq '.cliPluginsExtraDirs = ((.cliPluginsExtraDirs // []) + ["/opt/homebrew/lib/docker/cli-plugins"] | unique)' "$docker_config") && echo "$tmp" > "$docker_config"
}
