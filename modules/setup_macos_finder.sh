#!/usr/bin/env bash
setup_macos_finder() {

    # --- General ---

    # Show on desktop: Hard Disks - disable
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

    # Show on desktop: External Disks - disable
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

    # Show on desktop: CDs, DVDs, and iPods - disable
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

    # Show on desktop: Connected servers - disable
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

    # New finder windows show: - home folder
    # Choices: PfHm (home folder), PfDe (Desktop), PfDo (Documents), PfCm (Computer)
    defaults write com.apple.finder NewWindowTarget -string "PfHm"
    defaults write com.apple.finder NewWindowTargetPath -string "file://$HOME/"

    # Sync desktop and documents folders - disable
    # (not configurable with defaults)

    # Open folders in tabs instead of new windows - enable
    defaults write com.apple.finder FinderSpawnTab -bool true

    # --- Tags ---

    # ?

    # --- Sidebar ---

    # (not configurable with defaults; see sfltool and/or mysides project)

    # --- Advanced ---

    # Show all filename extensions - enable
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    # Show warning before changing an extension - disable
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

    # Show warning before removing from icloud drive - disable
    defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

    # Show warning before emptying the Bin - disable
    defaults write com.apple.finder WarnOnEmptyTrash -bool false

    # Remove items from the Bin after 30 days - enable
    defaults write com.apple.finder FXRemoveOldTrashItems -bool true

    # Keep folders on top, in windows when sorting by name - enable
    defaults write com.apple.finder _FXSortFoldersFirst -bool true

    # Keep folders on top, on Desktop - enable
    defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

    # When performing search - search this mac
    # Options: SCev (Search this Mac), SCcf (Search current folder), SCsp (Previous scope)
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # --- View Options ---

    # Always open in List View
    # Options: Nlsv (List view), icnv (Icon view), clmv (Column view), glyv (Gallery view).
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

    # --- Others ---

    # show hidden files
    defaults write com.apple.finder AppleShowAllFiles -bool true

    # show status bar
    defaults write com.apple.finder ShowStatusBar -bool true

    # show path bar
    defaults write com.apple.finder ShowPathbar -bool true

    # show POSIX path in title
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    # avoid writing .DS_Store files on network volumes
    #defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    # avoid writing .DS_Store on USB volumes
    #defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # default view style (column view)
    #defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

    # apply changes
    killall Finder
}