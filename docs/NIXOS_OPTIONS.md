# NixOS Module Options

This document details the configuration options available for the Youtarr NixOS module.

## services.youtarr.enable



Whether to enable Youtarr YouTube DVR service.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.package



The Youtarr package to use.



*Type:*
package



*Default:*

```nix
pkgs.callPackage ../pkgs/youtarr.nix { }
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.apprisePackage

The apprise package to use.



*Type:*
package



*Default:*

```nix
pkgs.apprise
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.atomicparsleyPackage



The atomicparsley package to use.



*Type:*
package



*Default:*

```nix
pkgs.atomicparsley
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.auth.enable



Enable built-in authentication.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.auth.presetPasswordFile



Path to a file containing the preset admin password.
The file must contain a line like:
AUTH_PRESET_PASSWORD=your_admin_password



*Type:*
null or absolute path



*Default:*

```nix
null
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.auth.presetUsername



Pre-configured admin username for automated deployments.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.dataDir



Storage directory for configurations and cache.



*Type:*
string



*Default:*

```nix
"/var/lib/youtarr"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.database.host



Database host name or IP address.



*Type:*
string



*Default:*

```nix
"127.0.0.1"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.database.name



Database name.



*Type:*
string



*Default:*

```nix
"youtarr"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.database.passwordFile



Path to a file containing the database password.
The file must contain a line like:
\<programlisting>DB_PASSWORD=your_password_here\</programlisting>



*Type:*
null or absolute path



*Default:*

```nix
null
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.database.port



Database port.



*Type:*
16 bit unsigned integer; between 0 and 65535 (both inclusive)



*Default:*

```nix
3306
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.database.user



Database username.



*Type:*
string



*Default:*

```nix
"youtarr"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.environmentFile



Path to an environment file containing additional custom environment variables.



*Type:*
null or absolute path



*Default:*

```nix
null
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.ffmpegPackage



The ffmpeg package to use.



*Type:*
package



*Default:*

```nix
pkgs.ffmpeg
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.host



Host IP address the backend server binds to.



*Type:*
string



*Default:*

```nix
"127.0.0.1"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.port



Port the Express backend server listens on.



*Type:*
16 bit unsigned integer; between 0 and 65535 (both inclusive)



*Default:*

```nix
3011
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.secretSettings



Map of config.json setting keys to environment variable names. After the
store-rendered config seed is written, each key is patched in from its env
var (sourced from environmentFile / database.passwordFile) when that var is
non-empty — keeping secrets out of the world-readable Nix store.



*Type:*
attribute set of string



*Default:*

```nix
{ }
```



*Example:*

```nix
{ jellyfinApiKey = "JELLYFIN_API_KEY"; }
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings



Declarative configuration options for Youtarr’s \<filename>config.json\</filename>.



*Type:*
open submodule of (JSON value)



*Default:*

```nix
{ }
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.enableStallDetection



Detect stalled downloads.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.apiKeyRateLimit



Rate limits for external clients.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
10
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.appriseUrls



Configured Apprise notification endpoints.



*Type:*
list of anything



*Default:*

```nix
[ ]
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.autoRemovalEnabled



Auto delete old files on low disk space.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.autoRemovalFreeSpaceThreshold



Minimum disk space threshold before removal.



*Type:*
null or string



*Default:*

```nix
null
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.autoRemovalVideoAgeThreshold



Max video age in days before removal.



*Type:*
null or (unsigned integer, meaning >=0)



*Default:*

```nix
null
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.autoUpdateYtdlp



Enable auto update yt-dlp binary.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.channelAutoDownload



Whether to automatically download new videos from channels.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.channelDownloadFrequency



Cron expression for check frequency.



*Type:*
string



*Default:*

```nix
"0 * * * *"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.channelFilesToDownload



Number of recent files to download per channel.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
5
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.channelVideosHotLoad



Aggressive pre-loading of channel videos.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.cookiesEnabled



Pass uploaded custom cookies to yt-dlp.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.customCookiesUploaded



Flags whether cookies are uploaded.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.darkModeEnabled



Default UI theme setting.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.defaultSubfolder



Default subfolder name for downloads.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.downloadRetryCount



Number of retries for failed downloads.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
2
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.downloadSocketTimeoutSeconds



Socket timeout for downloads.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
30
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.downloadThrottledRate



Download rate limit when throttled.



*Type:*
string



*Default:*

```nix
"100K"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.embyApiKey



Emby API Token.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.embyEnabled



Enable Emby integration.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.embyUrl



Emby server connection URL.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.embyUserId



Emby User identifier.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.embyVideoLibraryIds



Emby directories IDs.



*Type:*
list of string



*Default:*

```nix
[ ]
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.jellyfinApiKey



Jellyfin API Token.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.jellyfinEnabled



Enable Jellyfin integration.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.jellyfinUrl



Jellyfin server URL.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.jellyfinUserId



Jellyfin user section identifier.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.jellyfinVideoLibraryIds



Jellyfin section directories identifiers.



*Type:*
list of string



*Default:*

```nix
[ ]
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.notificationsEnabled



Enable push notifications via Apprise.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexApiKey



Plex API token.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexIP



Plex server IP address.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexPlaylistToken



Plex playlist token.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexPort



Plex server port.



*Type:*
string



*Default:*

```nix
"32400"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexSubfolderLibraryMappings



Mappings of download folders to Plex libraries.



*Type:*
list of anything



*Default:*

```nix
[ ]
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexUrl



Plex connection URL.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexViaHttps



Whether to connect to Plex via HTTPS.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.plexYoutubeLibraryId



Plex YouTube library section ID.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.preferredResolution



Preferred download resolution (e.g. 1080, 720).



*Type:*
string



*Default:*

```nix
"1080"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.proxy



HTTP/SOCKS proxy server.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sleepRequests



Sleep request delay in seconds.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
1
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockAction



Action to perform with SponsorBlock categories.



*Type:*
one of “remove”, “mark”



*Default:*

```nix
"remove"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockApiUrl



Custom SponsorBlock API mirror URL.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories



Enabled SponsorBlock categories.



*Type:*
submodule



*Default:*

```nix
{ }
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.filler



Remove filler segments.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.interaction



Remove interaction segments.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.intro



Remove intro segments.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.music_offtopic



Remove music/offtopic segments.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.outro



Remove outro segments.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.preview



Remove preview segments.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.selfpromo



Remove selfpromo segments.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockCategories.sponsor



Remove sponsor segments.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.sponsorblockEnabled



Enable SponsorBlock integration.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.stallDetectionRateThreshold



Speed limit threshold for stall detection.



*Type:*
string



*Default:*

```nix
"100K"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.stallDetectionWindowSeconds



Stall detection timeframe.



*Type:*
unsigned integer, meaning >=0



*Default:*

```nix
30
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.subtitleLanguage



Subtitles language.



*Type:*
string



*Default:*

```nix
"en"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.subtitlesEnabled



Embed subtitles.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.tmpFilePath



Temporary download folder path.



*Type:*
string



*Default:*

```nix
"/tmp/youtarr-downloads"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.useTmpForDownloads



Enable temporary downloading folder.



*Type:*
boolean



*Default:*

```nix
false
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.uuid



Unique Youtarr instance identifier.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.videoCodec



Preferred video codec.



*Type:*
string



*Default:*

```nix
"default"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.videoFilenamePrefix



yt-dlp output filename prefix template.



*Type:*
string



*Default:*

```nix
"%(uploader,channel,uploader_id).80B - %(title).76B"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.writeChannelPosters



Download and save channel posters.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.writeVideoNfoFiles



Generate NFO metadata files.



*Type:*
boolean



*Default:*

```nix
true
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.youtubeApiKey



YouTube Data API v3 key.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.ytdlpCustomArgs



Append extra arguments directly to yt-dlp.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.ytdlpDownloadRateLimit



Global download speed throttle.



*Type:*
string



*Default:*

```nix
""
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.settings.ytdlpIpFamily



Preferred IP family for yt-dlp.



*Type:*
one of “ipv4”, “ipv6”, “any”



*Default:*

```nix
"ipv4"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.youtubeOutputDir



Directory where downloaded videos are saved.



*Type:*
absolute path



*Default:*

```nix
"/var/lib/youtarr/downloads"
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)



## services.youtarr.ytdlpPackage



The yt-dlp package to use.



*Type:*
package



*Default:*

```nix
pkgs.yt-dlp
```

*Declared by:*
 - [../modules/nixos.nix](../modules/nixos.nix)


