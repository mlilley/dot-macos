#!/usr/bin/env bash
setup_macos_trackpad() {

    # disable 'natural' scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

    # enable tap-to-click (for built-in trackpads, Magic trackpads, and at the login screen)
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    kill cfprefsd

    # enable Secondary Click: click or tap with two fingers 
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

    # # enable three-finger drag
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

    # # enable trackpad gestures
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2

}