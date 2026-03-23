Iterm stores settings in a binary plist at `~/Library/Preferences/com.googlecode.iterm2.plist`. Settings can be dumped to XML using `plutil -convert xml1 -o - ~/Library/Preferences/com.googlecode.iterm2.plist`. Note no settings file exists until Iterm is run for the first time.

Iterm's settings include runtime state that should not be copied between installs. However, a minimal configuration file can be created containing only the (non-default) settings you want applied. Placing this file in the Iterm settings location will cause Iterm to merge your settings with its defaults when it starts next.

To capture your minimal configuration:
1. close Iterm if running.
2. remove any existing `~/Library/Preferences/com.googlecode.iterm2.plist` file.
3. open and then immediately close Iterm, to create an initial default configuration.
4. dump this to an XML file.
5. open Iterm again, configure it as desired, then close it to persist the settings.
4. dump the updated settings to another XML file.
5. diff the xml files.

To create a settings file containing your minimal configuration:
1. close Iterm if running. 
2. remove any existing `~/Library/Preferences/com.googlecode.iterm2.plist` file.
3. for each setting in your minimal configuration, use `defaults write com.googlecode.iterm2.plist "<key>" -<type> <value>` to write it to file.

Note: only top-level keys can be written to in this way. For nested settings, you must write everything from the top-level down.
