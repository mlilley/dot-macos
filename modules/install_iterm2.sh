#!/usr/bin/env bash
install_iterm2() {

    # --- install ---
    log_info "Installing Iterm2"
    install_app_zip_download \
       "iTerm.app" \
       "https://iterm2.com/downloads/stable/latest"

    # --- install Nerd Font ---


    # --- setup ---
    log_info "Configuring Iterm2"

    local default_profile_guid="BDE63016-AEF8-418D-BE5D-BB61D141FC73"
    defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "${default_profile_guid}"
    defaults write com.googlecode.iterm2 "SuppressRestartAnnouncement" -bool true

    # General > Closing > Confirm Quit iTerm2 (cmd-Q) = false
    defaults write com.googlecode.iterm2 "PromptOnQuit" -bool false
    
    # General > Closing > Confirm closing multiple sessions = false
    defaults write com.googlecode.iterm2 "OnlyWhenMoreTabs" -bool false 

    # General > Closing > Disable all confirmations ... = true
    defaults write com.googlecode.iterm2 "NeverBlockSystemShutdown" -bool true  

    # Appearance > General > Theme = Minimal
    defaults write com.googlecode.iterm2 "TabStyleWithAutomaticOption" -int 5
    
    # Appearance > Dimming > Dimming Amount = 15
    defaults write com.googlecode.iterm2 "SplitPaneDimmingAmount" -float 0.15

    # General > Software Update > Check for updates automatically = true
    defaults write com.googlecode.iterm2 "SUEnableAutomaticChecks" -bool true

    # Never warn about short lived sessions
    defaults write com.googlecode.iterm2 "NeverWarnAboutShortLivedSessions_${default_profile_guid}" -bool true
    defaults write com.googlecode.iterm2 "NeverWarnAboutShortLivedSessions_${default_profile_guid}_selection" -int 0
    
    # Profiles > Default > Colors > Cursor > Background (all modes) = Red
    # Profiles > Default > Colors > Cursor > Foreground (all modes) = White
    # Profiles > Default > Text > Cursor > Blink = true
    # Profiles > Default > Text > Font = MesloLGMDZ Nerd Font Mono (12)
    # Profiles > Default > Window > Transparency = 20.0
    # Profiles > Default > Window > Transparency > Keep background colors opaque = true
    # Profiles > Default > Window > Blur > Blur content behind the window = true
    # Profiles > Default > Window > Blur > Radius = 10
    # Profiles > Default > Window > New Windows > Columns = 100
    # Profiles > Default > Window > New Windows > Rows = 30
    # Profiles > Default > Terminal > Scrollback Lines = 100,000
    # Profiles > Default > Terminal > Mouse Reporting > Enable mouse reporting = true
    # Profiles > Default > Terminal > Emulation features > A session may cause the window to resize = false
    # Profiles > Default > Session > After a session ends = Close
    local xml
    xml=$(cat <<EOF
<dict>
    <key>Guid</key>
    <string>${default_profile_guid}</string>
    <key>Name</key>
    <string>Default</string>
    <key>Cursor Color</key>
    <dict>
        <key>Alpha Component</key><real>1</real>
        <key>Blue Component</key><real>0.0</real>
        <key>Color Space</key><string>sRGB</string>
        <key>Green Component</key><real>0.0</real>
        <key>Red Component</key><real>1</real>
    </dict>
    <key>Cursor Color (Light)</key>
    <dict>
        <key>Alpha Component</key><real>1</real>
        <key>Blue Component</key><real>0.0</real>
        <key>Color Space</key><string>sRGB</string>
        <key>Green Component</key><real>0.0</real>
        <key>Red Component</key><real>1</real>
    </dict>
    <key>Cursor Color (Dark)</key>
    <dict>
        <key>Alpha Component</key><real>1</real>
        <key>Blue Component</key><real>0.0</real>
        <key>Color Space</key><string>sRGB</string>
        <key>Green Component</key><real>0.0</real>
        <key>Red Component</key><real>1</real>
    </dict>
    <key>Cursor Text Color</key>
    <dict>
        <key>Alpha Component</key><real>1</real>
        <key>Blue Component</key><real>1</real>
        <key>Color Space</key><string>sRGB</string>
        <key>Green Component</key><real>1</real>
        <key>Red Component</key><real>1</real>
    </dict>
    <key>Cursor Text Color (Light)</key>
    <dict>
        <key>Alpha Component</key><real>1</real>
        <key>Blue Component</key><real>1</real>
        <key>Color Space</key><string>sRGB</string>
        <key>Green Component</key><real>1</real>
        <key>Red Component</key><real>1</real>
    </dict>
    <key>Cursor Text Color (Dark)</key>
    <dict>
        <key>Alpha Component</key><real>1</real>
        <key>Blue Component</key><real>1</real>
        <key>Color Space</key><string>sRGB</string>
        <key>Green Component</key><real>1</real>
        <key>Red Component</key><real>1</real>
    </dict>
    <key>Blinking Cursor</key><true/>
    <key>Normal Font</key><string>MesloLGMDZNFM-Regular 12</string>
    <key>Show Mark Indicators</key><false/>
    <key>Transparency</key><real>0.20</real>
    <key>Only The Default BG Color Uses Transparency</key><true/>
    <key>Blur</key><true/>
    <key>Blur Radius</key><real>10.0</real>
    <key>Columns</key><integer>100</integer>
    <key>Rows</key><integer>30</integer>
    <key>Scrollback Lines</key><integer>100000</integer>
    <key>Mouse Reporting</key><true/>
    <key>Disable Window Resizing</key><true/>
    <key>Close Sessions On End</key><integer>1</integer>
</dict>
EOF
    )
    defaults write com.googlecode.iterm2 "New Bookmarks" -array "$xml"
    log_info "Done"
}
