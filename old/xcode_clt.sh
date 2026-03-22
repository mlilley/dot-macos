#!/usr/bin/env bash
set -euo pipefail

exec_xcode_clt() {
    # Extracted from Homebrew
    clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
    touch "${clt_placeholder}"

    clt_label="$(
        /usr/sbin/softwareupdate -l |
        grep -B 1 -E 'Command Line Tools' |
        awk -F'*' '/^ *\*/ {print $2}' |
        sed -e 's/^ *Label: //' -e 's/^ *//' |
        sort -V |
        tail -n1
    )"
    if [[ -n "${clt_label}" ]]; then
        sudo /usr/sbin/softwareupdate -i "${clt_label}"
        sudo /usr/bin/xcode-select --switch /Library/Developer/CommandLineTools
    fi
    rm -f "${clt_placeholder}"

    if [[ -z "${clt_label}" ]]; then
        /usr/bin/xcode-select --install
    fi
}