#!/usr/bin/env bash
setup_macos_dock() {

    # launch bounce - enable
    defaults write com.apple.dock launchanim -bool true

    # recent apps - disable
    defaults write com.apple.dock show-recents -bool false

    # autohide - enable
    defaults write com.apple.dock autohide -bool true

    # slide in/out animation - disable
    defaults write com.apple.dock autohide-delay -float 0
    
    # show/hide delay - disable
    defaults write com.apple.dock autohide-time-modifier -int 0

    # Add applications stack next to bin
    defaults write com.apple.dock persistent-others -array-add '<dict>
    <key>tile-data</key>
    <dict>
        <key>showas</key>
        <integer>3</integer>
        <key>file-type</key>
        <integer>2</integer>
        <key>displayas</key>
        <integer>1</integer>
        <key>file-label</key>
        <string>Applications</string>
        <key>arrangement</key>
        <integer>1</integer>
        <key>file-data</key>
        <dict>
        <key>_CFURLStringType</key>
        <integer>15</integer>
        <key>_CFURLString</key>
        <string>file:///Applications/</string>
        </dict>
        <key>list-type</key>
        <integer>1</integer>
    </dict>
    <key>tile-type</key>
    <string>directory-tile</string>
    </dict>'

    # Add Downloads stack next to bin
    `defaults write com.apple.dock persistent-others -array-add '
    <dict>
    <key>tile-data</key>
    <dict>
        <key>showas</key>
        <integer>3</integer>
        <key>file-type</key>
        <integer>2</integer>
        <key>displayas</key>
        <integer>1</integer>
        <key>file-label</key>
        <string>Downloads</string>
        <key>arrangement</key>
        <integer>2</integer>
        <key>file-data</key>
        <dict>
        <key>_CFURLStringType</key>
        <integer>15</integer>
        <key>_CFURLString</key>
        <string>file://'$HOME'/Downloads/</string>
        </dict>
        <key>list-type</key>
        <integer>1</integer>
    </dict>
    <key>tile-type</key>
    <string>directory-tile</string>
    </dict>'`

    # apply changes
    killall Dock
}