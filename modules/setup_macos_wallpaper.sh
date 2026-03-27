#!/usr/bin/env bash
setup_macos_wallpaper() {

    # Macintosh dynamic wallpaper, Dark Grey, show on all spaces, show as screen saver
    #
    # To inspect: plutil -extract 'AllSpacesAndDisplays.Desktop.Content.Choices.0.Configuration' raw -o - \
    #               ~/Library/Application\ Support/com.apple.wallpaper/Store/Index.plist \
    #               | plutil -convert xml1 -o - -

    local plist="$HOME/Library/Application Support/com.apple.wallpaper/Store/Index.plist"
    local now
    now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    local config_data="YnBsaXN0MDDSAQIDBFtjb2xvclNjaGVtZV5hcHBlYXJhbmNlTW9kZVhkYXJrR3JheVlhdXRvbWF0aWMIDRkoMQAAAAAAAAEBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADs="

    plutil -convert binary1 -o "$plist" - <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>AllSpacesAndDisplays</key>
    <dict>
        <key>Desktop</key>
        <dict>
            <key>Content</key>
            <dict>
                <key>Choices</key>
                <array>
                    <dict>
                        <key>Configuration</key>
                        <data>${config_data}</data>
                        <key>Files</key>
                        <array/>
                        <key>Provider</key>
                        <string>com.apple.wallpaper.choice.macintosh</string>
                    </dict>
                </array>
                <key>Shuffle</key>
                <string>\$null</string>
            </dict>
            <key>LastSet</key>
            <date>${now}</date>
            <key>LastUse</key>
            <date>${now}</date>
        </dict>
        <key>Idle</key>
        <dict>
            <key>Content</key>
            <dict>
                <key>Choices</key>
                <array>
                    <dict>
                        <key>Configuration</key>
                        <data>${config_data}</data>
                        <key>Files</key>
                        <array/>
                        <key>Provider</key>
                        <string>com.apple.wallpaper.choice.macintosh</string>
                    </dict>
                </array>
                <key>Shuffle</key>
                <string>\$null</string>
            </dict>
            <key>LastSet</key>
            <date>${now}</date>
            <key>LastUse</key>
            <date>${now}</date>
        </dict>
        <key>Type</key>
        <string>individual</string>
    </dict>
    <key>Displays</key>
    <dict/>
    <key>Spaces</key>
    <dict/>
    <key>SystemDefault</key>
    <dict>
        <key>Desktop</key>
        <dict>
            <key>Content</key>
            <dict>
                <key>Choices</key>
                <array>
                    <dict>
                        <key>Configuration</key>
                        <data>${config_data}</data>
                        <key>Files</key>
                        <array/>
                        <key>Provider</key>
                        <string>com.apple.wallpaper.choice.macintosh</string>
                    </dict>
                </array>
                <key>Shuffle</key>
                <string>\$null</string>
            </dict>
            <key>LastSet</key>
            <date>${now}</date>
            <key>LastUse</key>
            <date>${now}</date>
        </dict>
        <key>Idle</key>
        <dict>
            <key>Content</key>
            <dict>
                <key>Choices</key>
                <array>
                    <dict>
                        <key>Configuration</key>
                        <data>${config_data}</data>
                        <key>Files</key>
                        <array/>
                        <key>Provider</key>
                        <string>com.apple.wallpaper.choice.macintosh</string>
                    </dict>
                </array>
                <key>Shuffle</key>
                <string>\$null</string>
            </dict>
            <key>LastSet</key>
            <date>${now}</date>
            <key>LastUse</key>
            <date>${now}</date>
        </dict>
        <key>Type</key>
        <string>individual</string>
    </dict>
</dict>
</plist>
EOF

    killall WallpaperAgent 2>/dev/null || true
}
setup_macos_wallpaper
