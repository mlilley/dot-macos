Firefox stores settings in profiles. 

Typically there is one primary profile per OS user, but more profiles can be created.

Profile storage is only created when Firefox is launched for the first time. 

A profile's settings are stored in `$HOME/Library/Application Support/Firefox/$profiledir/prefs.js`. The profile's directory is randomized, but can be determined from the `Default` key under `[InstallXXX]` in `$HOME/Library/Application Support/Firefox/profiles.ini`.

Settings can be applied in various ways:

1. a `policies.json` file in the app bundle.
   - settings therein take precedence over the settings of all profiles (but are not written to them).
   - being in the app bundle, `policies.json` is wiped every time the Firefox app is updated.
2. a `user.js` file in the profile directory.
   - settings therein are merged with and written to `prefs.js` of that profile when Firefox starts.
   - settings changes made by the user only persist until the next Firefox launch where they are reset by `user.js`.
3. writing settings to `prefs.js` directly.
   - the same as if the settings were changed via Firefox UI.
   - settings remain fully mutable via UI.
   - firefox cannot be running at the time of the write, or changes will be lost on shutdown.

Settings can be captured by taking a copy of the `prefs.js` of a real install (after it is configured and shutdown), and removing the non-"settings" (runtime state) cruft.

As of Firefox 148.0.2 (aarch64) settings, with my preferences applied, include:

```
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
user_pref("browser.ai.control.pdfjsAltText", "blocked");
user_pref("browser.ai.control.sidebarChatbot", "blocked");
user_pref("browser.ai.control.smartTabGroups", "blocked");
user_pref("browser.ai.control.translations", "blocked");
user_pref("browser.bookmarks.restore_default_bookmarks", false);
user_pref("browser.contentblocking.category", "strict");
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.page", false);
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.showWeather", false);
user_pref("browser.profiles.enabled", true);
user_pref("browser.search.serpEventTelemetryCategorization.regionEnabled", false);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.tabs.groups.smart.userEnabled", false);
user_pref("browser.tabs.hoverPreview.showThumbnails", false);
user_pref("browser.translations.enable", false);
user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"vertical-spacer\",\"urlbar-container\",\"downloads-button\",\"fxa-toolbar-menu-button\",\"unified-extensions-button\"],\"TabsToolbar\":[\"firefox-view-button\",\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"screenshot-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"PersonalToolbar\",\"TabsToolbar\"],\"currentVersion\":23,\"newElementCount\":3}");
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.usage.uploadEnabled", false);
user_pref("extensions.activeThemeID", "default-theme@mozilla.org");
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("intl.accept_languages", "en-au");
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);
user_pref("network.http.referer.disallowCrossSiteRelaxingDefault.top_navigation", true);
user_pref("network.trr.mode", 5);
user_pref("nimbus.rollouts.enabled", false);
user_pref("pdfjs.enableAltText", false);
user_pref("permissions.default.camera", 2);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("permissions.default.microphone", 2);
user_pref("permissions.default.xr", 2);
user_pref("privacy.annotate_channels.strict_list.enabled", true);
user_pref("privacy.bounceTrackingProtection.mode", 1);
user_pref("privacy.clearOnShutdown_v2.formdata", true);
user_pref("privacy.fingerprintingProtection", true);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.query_stripping.enabled", true);
user_pref("privacy.query_stripping.enabled.pbmode", true);
user_pref("privacy.trackingprotection.consentmanager.skip.pbmode.enabled", true);
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("sidebar.notification.badge.aichat", false);
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("signon.management.page.breach-alerts.enabled", false);
user_pref("signon.rememberSignons", false);
user_pref("trailhead.firstrun.didSeeAboutWelcome", true);
```

Non-settings entries in prefs.js (that should be excluded) include:

```
app.normandy.first_run
app.normandy.migrationsApplied
app.normandy.user_id
app.update.background.previous.reasons
app.update.lastUpdateTime.addon-background-update-timer
app.update.lastUpdateTime.background-update-timer
app.update.lastUpdateTime.browser-cleanup-thumbnails
app.update.lastUpdateTime.glean-addons-daily
app.update.lastUpdateTime.recipe-client-addon-run
app.update.lastUpdateTime.region-update-timer
app.update.lastUpdateTime.rs-experiment-loader-timer
app.update.lastUpdateTime.services-settings-poll-changes
app.update.lastUpdateTime.xpi-signature-verification
browser.bookmarks.addedImportButton
browser.contextual-services.contextId
browser.contextual-services.contextId.timestamp-in-seconds
browser.download.viewableInternally.typeWasRegistered.avif
browser.download.viewableInternally.typeWasRegistered.webp
browser.ipProtection.locationListCache
browser.laterrun.bookkeeping.profileCreationTime
browser.laterrun.bookkeeping.sessionCount
browser.migration.version
browser.newtabpage.activity-stream.impressionId
browser.pageActions.persistedActions
browser.pagethumbnails.storage_version
browser.proton.toolbar.version
browser.region.update.updated
browser.safebrowsing.provider.google5.lastupdatetime
browser.safebrowsing.provider.google5.nextupdatetime
browser.safebrowsing.provider.mozilla.lastupdatetime
browser.safebrowsing.provider.mozilla.nextupdatetime
browser.sessionstore.upgradeBackup.latestBuildID
browser.shell.defaultBrowserCheckCount
browser.shell.didSkipDefaultBrowserCheckOnFirstRun
browser.shell.mostRecentDefaultPromptSeen
browser.startup.couldRestoreSession.count
browser.startup.homepage_override.buildID
browser.startup.homepage_override.mstone
browser.startup.lastColdStartupCheck
browser.urlbar.placeholderName
browser.urlbar.quicksuggest.migrationVersion
captchadetection.lastSubmission
datareporting.dau.cachedUsageProfileGroupID
datareporting.dau.cachedUsageProfileID
distribution.iniFile.exists.appversion
distribution.iniFile.exists.value
doh-rollout.disable-heuristics
doh-rollout.doneFirstRun
doh-rollout.home-region
dom.forms.autocomplete.formautofill
dom.push.userAgentID
extensions.blocklist.pingCountVersion
extensions.colorway-builtin-themes-cleanup
extensions.databaseSchema
extensions.getAddons.cache.lastUpdate
extensions.getAddons.databaseSchema
extensions.lastAppBuildId
extensions.lastAppVersion
extensions.lastPlatformVersion
extensions.ml.enabled
extensions.pendingOperations
extensions.pictureinpicture.enable_picture_in_picture_overrides
extensions.quarantinedDomains.list
extensions.signatureCheckpoint
extensions.ui.dictionary.hidden
extensions.ui.lastCategory
extensions.ui.locale.hidden
extensions.ui.mlmodel.hidden
extensions.ui.sitepermission.hidden
extensions.webcompat.enable_interventions
extensions.webcompat.enable_shims
extensions.webextensions.uuids
gecko.handlerService.defaultHandlersVersion
layout.css.prefers-color-scheme.content-override
media.gmp-gmpopenh264.abi
media.gmp-gmpopenh264.hashValue
media.gmp-gmpopenh264.lastDownload
media.gmp-gmpopenh264.lastInstallStart
media.gmp-gmpopenh264.lastUpdate
media.gmp-gmpopenh264.version
media.gmp-manager.buildID
media.gmp-manager.lastCheck
media.gmp-widevinecdm.abi
media.gmp-widevinecdm.hashValue
media.gmp-widevinecdm.lastDownload
media.gmp-widevinecdm.lastInstallStart
media.gmp-widevinecdm.lastUpdate
media.gmp-widevinecdm.version
media.gmp.storage.version.observed
network.cookie.CHIPS.lastMigrateDatabase
nimbus.migrations.after-remote-settings-update
nimbus.migrations.after-store-initialized
nimbus.migrations.init-started
nimbus.profileId
pdfjs.migrationVersion
pdfjs.enabledCache.state
pref.browser.language.disable_button.remove
privacy.bounceTrackingProtection.hasMigratedUserActivationData
privacy.globalprivacycontrol.was_ever_enabled
privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3
privacy.sanitize.pending
privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs
privacy.trackingprotection.allow_list.hasUserInteractedWithETPSettings
services.settings.blocklists.addons-bloomfilters.last_check
services.settings.blocklists.gfx.last_check
services.settings.clock_skew_seconds
services.settings.last_etag
services.settings.last_update_seconds
services.settings.main.addons-data-leak-blocker-domains.last_check
services.settings.main.addons-manager-settings.last_check
services.settings.main.anti-tracking-url-decoration.last_check
services.settings.main.cfr.last_check
services.settings.main.cookie-banner-rules-list.last_check
services.settings.main.devtools-compatibility-browsers.last_check
services.settings.main.devtools-devices.last_check
services.settings.main.doh-config.last_check
services.settings.main.doh-providers.last_check
services.settings.main.fingerprinting-protection-overrides.last_check
services.settings.main.fxmonitor-breaches.last_check
services.settings.main.hijack-blocklists.last_check
services.settings.main.language-dictionaries.last_check
services.settings.main.message-groups.last_check
services.settings.main.moz-essential-domain-fallbacks.last_check
services.settings.main.newtab-frecency-boosted-sponsors.last_check
services.settings.main.newtab-wallpapers-v2.last_check
services.settings.main.nimbus-desktop-experiments.last_check
services.settings.main.nimbus-secure-experiments.last_check
services.settings.main.normandy-recipes-capabilities.last_check
services.settings.main.partitioning-exempt-urls.last_check
services.settings.main.password-recipes.last_check
services.settings.main.password-rules.last_check
services.settings.main.query-stripping.last_check
services.settings.main.remote-permissions.last_check
services.settings.main.search-categorization.last_check
services.settings.main.search-config-icons.last_check
services.settings.main.search-config-overrides-v2.last_check
services.settings.main.search-config-v2.last_check
services.settings.main.search-default-override-allowlist.last_check
services.settings.main.search-telemetry-v2.last_check
services.settings.main.sites-classification.last_check
services.settings.main.third-party-cookie-blocking-exempt-urls.last_check
services.settings.main.top-sites.last_check
services.settings.main.tracking-protection-lists.last_check
services.settings.main.translations-models.last_check
services.settings.main.translations-wasm.last_check
services.settings.main.url-classifier-exceptions.last_check
services.settings.main.url-classifier-skip-urls.last_check
services.settings.main.url-parser-default-unknown-schemes-interventions.last_check
services.settings.main.urlbar-persisted-search-terms.last_check
services.settings.main.vpn-serverlist.last_check
services.settings.main.webcompat-interventions.last_check
services.settings.main.websites-with-shared-credential-backends.last_check
services.settings.security-state.cert-revocations.last_check
services.settings.security-state.intermediates.last_check
services.settings.security-state.onecrl.last_check
services.sync.clients.lastSync
services.sync.declinedEngines
services.sync.globalScore
services.sync.nextSync
sidebar.backupState
toolkit.profiles.storeID
toolkit.startup.last_success
toolkit.telemetry.cachedClientID
toolkit.telemetry.cachedProfileGroupID
toolkit.telemetry.previousBuildID
toolkit.telemetry.reportingpolicy.firstRun
browser.search.region
browser.laterrun.enabled
browser.ml.chat.nimbus
browser.newtabpage.storageVersion
browser.termsofuse.prefMigrationCheck
termsofuse.acceptedDate
termsofuse.acceptedVersion
```