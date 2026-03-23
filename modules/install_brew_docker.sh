#!/usr/bin/env bash
install_brew_docker() {
    brew_formula_install docker || return 1
    brew_formula_install docker-compose || return 1
    brew_formula_install docker-buildx

    # Update docker config to install compose and buildx plugins
    local docker_config="$HOME/.docker/config.json"
    if [[ ! -f "$docker_config" ]]; then
        log_warn "Unable to complete docker installation: $docker_config not found"
        return 0
    fi
    local tmp
    tmp=$(jq '.cliPluginsExtraDirs = ["/opt/homebrew/lib/docker/cli-plugins"]' "$docker_config") && echo "$tmp" > "$docker_config"
}
