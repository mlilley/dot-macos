#!/usr/bin/env bash
setup_macos_keyboard() {

    # disable press-and-hold ligatures to restore normal key-repeat (requires reboot)
    defaults write -g ApplePressAndHoldEnabled -bool false

    # speed up key repeat
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15

    # Keyboard backlighting ( no longer works on Tahoe/M5? )
    #defaults write com.apple.BezelServices kDim -bool true
    #defaults write com.apple.BezelServices kDimTime -int 10

    # apply changes
    killall cfprefsd   
}