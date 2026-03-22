#!/usr/bin/env bash
setup_macos_sharing() {
    # DO NOT USE

    # --- Content & Media ---

    # File Sharing
    #sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
    #sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist

    # Media Sharing
    # ?

    # Screen Sharing
    #sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
    #sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

    # Content Caching
    #defaults write com.apple.AssetCache MaxCacheSizeInBytes -int 107374182400 # bytes (100 GB)
    #sudo AssetCacheManagerUtil activate
    #sudo AssetCacheManagerUtil deactivate

    # --- Accessories & Internet ---

    # Bluetooth Sharing
    # ?

    # Printer Sharing
    #cupsctl --share-printers
    #cupsctl --no-share-printers

    # Internet Sharing
    # ?

    # --- Advanced ---

    # Remote Management
    # ?

    # Remote Login
    sudo systemsetup -setremotelogin on

    # Remote Application Scripting
    #sudo systemsetup -setremoteappleevents on
    #sudo systemsetup -setremoteappleevents off
}