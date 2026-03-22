#!/usr/bin/env bash
setup_macos_controlcenter() {
    # DO NOT USE

    # Always Show Sound in menubar
    defaults -currentHost write com.apple.controlcenter Sound -int 18 

    # Always Show Bluetooth in menubar
    defaults -currentHost write com.apple.controlcenter Bluetooth -int 18

    # Show Energy Mode in the menubar
    defaults -currentHost write com.apple.controlcenter "NSStatusItem Visible EnergyModeModule" -bool true
}