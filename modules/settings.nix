{ lib, pkgs }:

with lib;

lib.mkOption {
  type = types.submodule {
    freeformType = (pkgs.formats.json { }).type;

    options = {
      channelFilesToDownload = mkOption {
        type = types.ints.unsigned;
        default = 5;
        description = "Number of recent files to download per channel.";
      };

      channelAutoDownload = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to automatically download new videos from channels.";
      };

      channelDownloadFrequency = mkOption {
        type = types.str;
        default = "0 * * * *";
        description = "Cron expression for check frequency.";
      };

      preferredResolution = mkOption {
        type = types.str;
        default = "1080";
        description = "Preferred download resolution (e.g. 1080, 720).";
      };

      videoCodec = mkOption {
        type = types.str;
        default = "default";
        description = "Preferred video codec.";
      };

      defaultSubfolder = mkOption {
        type = types.str;
        default = "";
        description = "Default subfolder name for downloads.";
      };

      videoFilenamePrefix = mkOption {
        type = types.str;
        default = "%(uploader,channel,uploader_id).80B - %(title).76B";
        description = "yt-dlp output filename prefix template.";
      };

      plexIP = mkOption {
        type = types.str;
        default = "";
        description = "Plex server IP address.";
      };

      plexPort = mkOption {
        type = types.str;
        default = "32400";
        description = "Plex server port.";
      };

      plexViaHttps = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to connect to Plex via HTTPS.";
      };

      plexApiKey = mkOption {
        type = types.str;
        default = "";
        description = "Plex API token.";
      };

      plexPlaylistToken = mkOption {
        type = types.str;
        default = "";
        description = "Plex playlist token.";
      };

      plexYoutubeLibraryId = mkOption {
        type = types.str;
        default = "";
        description = "Plex YouTube library section ID.";
      };

      youtubeApiKey = mkOption {
        type = types.str;
        default = "";
        description = "YouTube Data API v3 key.";
      };

      plexSubfolderLibraryMappings = mkOption {
        type = types.listOf types.anything;
        default = [ ];
        description = "Mappings of download folders to Plex libraries.";
      };

      plexUrl = mkOption {
        type = types.str;
        default = "";
        description = "Plex connection URL.";
      };

      sponsorblockEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Enable SponsorBlock integration.";
      };

      sponsorblockAction = mkOption {
        type = types.enum [
          "remove"
          "mark"
        ];
        default = "remove";
        description = "Action to perform with SponsorBlock categories.";
      };

      sponsorblockCategories = mkOption {
        type = types.submodule {
          options = {
            sponsor = mkOption {
              type = types.bool;
              default = true;
              description = "Remove sponsor segments.";
            };
            intro = mkOption {
              type = types.bool;
              default = false;
              description = "Remove intro segments.";
            };
            outro = mkOption {
              type = types.bool;
              default = false;
              description = "Remove outro segments.";
            };
            selfpromo = mkOption {
              type = types.bool;
              default = true;
              description = "Remove selfpromo segments.";
            };
            preview = mkOption {
              type = types.bool;
              default = false;
              description = "Remove preview segments.";
            };
            filler = mkOption {
              type = types.bool;
              default = false;
              description = "Remove filler segments.";
            };
            interaction = mkOption {
              type = types.bool;
              default = false;
              description = "Remove interaction segments.";
            };
            music_offtopic = mkOption {
              type = types.bool;
              default = false;
              description = "Remove music/offtopic segments.";
            };
          };
        };
        default = { };
        description = "Enabled SponsorBlock categories.";
      };

      sponsorblockApiUrl = mkOption {
        type = types.str;
        default = "";
        description = "Custom SponsorBlock API mirror URL.";
      };

      downloadSocketTimeoutSeconds = mkOption {
        type = types.ints.unsigned;
        default = 30;
        description = "Socket timeout for downloads.";
      };

      downloadThrottledRate = mkOption {
        type = types.str;
        default = "100K";
        description = "Download rate limit when throttled.";
      };

      downloadRetryCount = mkOption {
        type = types.ints.unsigned;
        default = 2;
        description = "Number of retries for failed downloads.";
      };

      enableStallDetection = mkOption {
        type = types.bool;
        default = true;
        description = "Detect stalled downloads.";
      };

      stallDetectionWindowSeconds = mkOption {
        type = types.ints.unsigned;
        default = 30;
        description = "Stall detection timeframe.";
      };

      stallDetectionRateThreshold = mkOption {
        type = types.str;
        default = "100K";
        description = "Speed limit threshold for stall detection.";
      };

      sleepRequests = mkOption {
        type = types.ints.unsigned;
        default = 1;
        description = "Sleep request delay in seconds.";
      };

      proxy = mkOption {
        type = types.str;
        default = "";
        description = "HTTP/SOCKS proxy server.";
      };

      useTmpForDownloads = mkOption {
        type = types.bool;
        default = false;
        description = "Enable temporary downloading folder.";
      };

      tmpFilePath = mkOption {
        type = types.str;
        default = "/tmp/youtarr-downloads";
        description = "Temporary download folder path.";
      };

      cookiesEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Pass uploaded custom cookies to yt-dlp.";
      };

      customCookiesUploaded = mkOption {
        type = types.bool;
        default = false;
        description = "Flags whether cookies are uploaded.";
      };

      writeChannelPosters = mkOption {
        type = types.bool;
        default = true;
        description = "Download and save channel posters.";
      };

      writeVideoNfoFiles = mkOption {
        type = types.bool;
        default = true;
        description = "Generate NFO metadata files.";
      };

      notificationsEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Enable push notifications via Apprise.";
      };

      appriseUrls = mkOption {
        type = types.listOf types.anything;
        default = [ ];
        description = "Configured Apprise notification endpoints.";
      };

      autoRemovalEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Auto delete old files on low disk space.";
      };

      autoRemovalFreeSpaceThreshold = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Minimum disk space threshold before removal.";
      };

      autoRemovalVideoAgeThreshold = mkOption {
        type = types.nullOr types.ints.unsigned;
        default = null;
        description = "Max video age in days before removal.";
      };

      subtitlesEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Embed subtitles.";
      };

      subtitleLanguage = mkOption {
        type = types.str;
        default = "en";
        description = "Subtitles language.";
      };

      darkModeEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Default UI theme setting.";
      };

      channelVideosHotLoad = mkOption {
        type = types.bool;
        default = false;
        description = "Aggressive pre-loading of channel videos.";
      };

      uuid = mkOption {
        type = types.str;
        default = "";
        description = "Unique Youtarr instance identifier.";
      };

      apiKeyRateLimit = mkOption {
        type = types.ints.unsigned;
        default = 10;
        description = "Rate limits for external clients.";
      };

      autoUpdateYtdlp = mkOption {
        type = types.bool;
        default = false;
        description = "Enable auto update yt-dlp binary.";
      };

      ytdlpIpFamily = mkOption {
        type = types.enum [
          "ipv4"
          "ipv6"
          "any"
        ];
        default = "ipv4";
        description = "Preferred IP family for yt-dlp.";
      };

      ytdlpDownloadRateLimit = mkOption {
        type = types.str;
        default = "";
        description = "Global download speed throttle.";
      };

      ytdlpCustomArgs = mkOption {
        type = types.str;
        default = "";
        description = "Append extra arguments directly to yt-dlp.";
      };

      jellyfinEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Jellyfin integration.";
      };

      jellyfinUrl = mkOption {
        type = types.str;
        default = "";
        description = "Jellyfin server URL.";
      };

      jellyfinApiKey = mkOption {
        type = types.str;
        default = "";
        description = "Jellyfin API Token.";
      };

      jellyfinUserId = mkOption {
        type = types.str;
        default = "";
        description = "Jellyfin user section identifier.";
      };

      jellyfinVideoLibraryIds = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Jellyfin section directories identifiers.";
      };

      embyEnabled = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Emby integration.";
      };

      embyUrl = mkOption {
        type = types.str;
        default = "";
        description = "Emby server connection URL.";
      };

      embyApiKey = mkOption {
        type = types.str;
        default = "";
        description = "Emby API Token.";
      };

      embyUserId = mkOption {
        type = types.str;
        default = "";
        description = "Emby User identifier.";
      };

      embyVideoLibraryIds = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Emby directories IDs.";
      };
    };
  };
  default = { };
  description = ''
    Declarative configuration options for Youtarr's <filename>config.json</filename>.
  '';
}
