{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "sametaor";
  home.homeDirectory = "/home/sametaor";
  home.file.".config/nixos".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/github/sametaor_CLIconfig/linux/NixOS/home/sametaor/.config/nixos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. You should not change this, even if you update Home Manager.
  home.stateVersion = "26.05"; # Please check the release notes before changing

  # The home.packages option allows you to install packages to your user profile.
  home.packages = [
  ];
  fonts.fontconfig = {
    enable = true;
    subpixelRendering = "rgb";
    defaultFonts = {
      emoji = [ ];
      monospace = [
        "Iosevka SciFi Extended"
        "Symbols Nerd Font"
      ];
      sansSerif = [ ];
      serif = [ ];
    };
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.breeze-hacked-cursor-theme;
    name = "Breeze_Hacked";
    size = 24;
  };
  gtk = {
    enable = true;
    cursorTheme.name = "Breeze_Hacked";
    cursorTheme.size = 24;
    cursorTheme.package = pkgs.breeze-hacked-cursor-theme;
    font = {
      name = "Iosevka SciFi Extended";
      size = 11;
    };
  };
  home.preferXdgDirectories = true;
  home.shell = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    enableShellIntegration = true;
    enableZshIntegration = true;
  };
  home.sessionVariables = {
    XCURSOR_THEME = "Breeze_Hacked";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Breeze_Hacked";
    HYPRCURSOR_SIZE = "24";
  };
  manual.manpages.enable = true;
  manual.html.enable = true;
  manual.json.enable = true;
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "zen-beta.desktop";
        "x-scheme-handler/http" = "zen-beta.desktop";
        "x-scheme-handler/https" = "zen-beta.desktop";
        "x-scheme-handler/about" = "zen-beta.desktop";
        "x-scheme-handler/unknown" = "zen-beta.desktop";
      };
    };
  };
  qt.enable = true;
  qt.kvantum.enable = true;

  # Home Manager can also manage your environment variables and git configurations natively
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    configType = "lua";
    settings = {
      config = {
        general = {
          border_size = 2;
          gaps_in = 5;
          gaps_out = 5;
          layout = "dwindle";
        };
        decoration = {
          rounding = 12;
          active_opacity = 1.0;
          inactive_opacity = 0.8;
          shadow = {
            enabled = true;
            range = 30;
            render_power = 4;
            offset = "0 5";
            color = "rgba(00000070)";
          };
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
        };
        dwindle = {
          preserve_split = true;
        };
        master = {
          mfact = 0.5;
        };
        cursor = {
          no_hardware_cursors = 0;
        };
        input = {
          kb_layout = "";
          numlock_by_default = true;
          follow_mouse = 0;
          touchpad = {
            tap_to_click = true;
            natural_scroll = true;
          };
        };
      };
    };
    extraConfig = ''
      hl.env("QT_QPA_PLATFORM", "wayland;xcb")
      hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
      hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
      hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")
      hl.env("TERMINAL", "ghostty")
      hl.on("hyprland.start", function()
        hl.exec_cmd("dms run")
      end)

      hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "default" })
      hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default" })
      hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })
      hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "default" })
      hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
      hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })

      hl.window_rule({ match = { class = "^(org\\.wezfurlong\\.wezterm)$" }, tile = true })
      hl.window_rule({ match = { class = "^(org\\.gnome\\.)" }, rounding = 12 })
      hl.window_rule({ match = { class = "^(gnome-control-center)$" }, tile = true })
      hl.window_rule({ match = { class = "^(pavucontrol)$" }, tile = true })
      hl.window_rule({ match = { class = "^(nm-connection-editor)$" }, tile = true })
      hl.window_rule({ match = { class = "^(org\\.gnome\\.Calculator)$" }, float = true })
      hl.window_rule({ match = { class = "^(gnome-calculator)$" }, float = true })
      hl.window_rule({ match = { class = "^(galculator)$" }, float = true })
      hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
      hl.window_rule({ match = { class = "^(org\\.gnome\\.Nautilus)$" }, float = true })
      hl.window_rule({ match = { class = "^(xdg-desktop-portal)$" }, float = true })
      hl.window_rule({
      	match = { class = "^(steam)$", title = "^(notificationtoasts)" },
      	no_initial_focus = true,
      	pin = true,
      })
      hl.window_rule({
      	match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" },
      	float = true,
      })
      hl.window_rule({ match = { class = "^(zoom)$" }, float = true })
      hl.layer_rule({ match = { namespace = "^(quickshell)$" }, no_anim = true })
      hl.layer_rule({ match = { namespace = "^dms:.*" }, no_anim = true })

      pcall(require, "dms.colors")
      pcall(require, "dms.outputs")
      pcall(require, "dms.layout")
      pcall(require, "dms.cursor")
      pcall(require, "dms.binds")
      pcall(require, "dms.binds-user")
      pcall(require, "dms.windowrules")
    '';
    plugins = with pkgs.hyprlandPlugins; [ ];
    systemd.variables = [ "--all" ];
  };
  programs.hyprland-qt-support.enable = true;
  programs.zen-browser = {
    enable = true;
    package =
      let
        basePkg = inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".beta;
        smartWrap =
          pkg:
          (pkgs.nvidiaWrap pkg)
          // {
            version = pkg.version;
            override = pkgs.lib.setFunctionArgs (args: smartWrap (pkg.override args)) (
              pkgs.lib.functionArgs pkg.override
            );
          };
      in
      smartWrap basePkg;
    enablePrivateDesktopEntry = true;
    languagePacks = [
      "en-US"
      "hi-IN"
    ];
    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      aria2-integration
      auto-tab-discard
      bitwarden
      dearrow
      geo-spoof
      h264ify
      indie-wiki-buddy
      keepa
      multi-account-containers
      proton-vpn
      protondb-for-steam
      refined-github
      return-youtube-dislikes
      ruffle_rs
      sponsorblock
      stylus
      tampermonkey
      transparent-zen
      ublock-origin
      web-archives
      web-scrobbler
    ];
    profiles = {
      default = {
        name = "default";
        containersForce = true;
        containers = {
          personal = {
            id = 1;
            color = "blue";
            icon = "circle";
            name = "Personal";
          };
          work = {
            id = 2;
            color = "red";
            icon = "briefcase";
            name = "Work";
          };
          gaming = {
            id = 3;
            color = "orange";
            icon = "chill";
            name = "Gaming";
          };
          programming = {
            id = 4;
            color = "green";
            icon = "tree";
            name = "Programming";
          };
          shopping = {
            id = 5;
            color = "pink";
            icon = "cart";
            name = "Shopping";
          };
          banking = {
            id = 6;
            color = "yellow";
            icon = "dollar";
            name = "Banking";
          };
          facebook = {
            id = 7;
            color = "toolbar";
            icon = "fence";
            name = "Facebook";
          };
        };
        isDefault = true;
        extensions = { };
        handlers = { };
        keyboardShortcuts = [ ];
        mods = [ ];
        search = { };
        settings = {
          "zen.workspace.separate-essentials" = false;
          "xpinstall.signatures.required" = false;
        };
        presets = {
          betterfox.enable = true;
        };
        sine = {
          enable = true;
          mods = [ ];
        };
        spaceRouting = {
          defaultExternalRoute = "67eceb7e-d777-42c7-97b6-088c66c986fa";
          routes = {
          };
        };
        spaces = {
          home = {
            container = 1;
            id = "67eceb7e-d777-42c7-97b6-088c66c986fa";
            icon = "🏠";
            name = "Home";
            pins = {
              gmail = {
                container = 1;
                id = "0a5513fc-f091-4ca5-995c-b37745ba54cd";
                isEssential = true;
                title = "Gmail";
                url = "https://mail.google.com/";
              };
              outlook = {
                container = 1;
                id = "c65d1c63-dfce-48b9-a9d6-5581a06e8067";
                isEssential = true;
                title = "OutLook";
                url = "https://outlook.live.com/";
              };
              proton-mail = {
                container = 1;
                id = "";
                isEssential = true;
                title = "Proton Mail";
                url = "https://mail.proton.me/";
              };
              whatsapp = {
                container = 1;
                id = "893efab9-be30-438c-9a31-71a3d97e4e1f";
                isEssential = true;
                title = "Whatsapp Web";
                url = "https://web.whatsapp.com/";
              };
              ente-auth = {
                container = 1;
                id = "ff44d6f0-2e00-4712-aca8-5544fd79f3f3";
                isEssential = true;
                title = "Ente Auth";
                url = "https://auth.ente.com/auth";
              };
              fmhy = {
                container = 1;
                id = "309a8ccb-0519-43b9-8157-0e62e6f05af3";
                isEssential = true;
                title = "FMHY";
                url = "https://fmhy.net/";
              };
              sametaors-world = {
                container = 1;
                id = "38f8d4a6-ba30-4aad-bf16-b501c6e21633";
                isEssential = true;
                title = "Sametaor's World";
                url = "https://sametaor.vercel.app/";
              };
              youtube = {
                container = 1;
                id = "72d5ada6-b6c8-4f57-bc77-a2d37f10e45a";
                isEssential = true;
                title = "YouTube";
                url = "https://www.youtube.com";
              };
            };
            routes = { };
          };
          work = {
            container = 2;
            id = "dd5ac34b-bd3c-4189-ab06-0941bb5389bb";
            icon = "💼";
            name = "Work";
            liveFolders = { };
            pins = {
              fja = {
                container = 2;
                id = "3c9da7b9-b19c-40ab-bc43-eea0dba9d2e6";
                isEssential = true;
                title = "Free Job Alert";
                url = "https://www.freejobalert.com/latest-notifications/";
              };
              sathee-iitk = {
                container = 2;
                id = "2c3ad590-bfd1-40f1-b048-1b6c20e4ce23";
                isEssential = true;
                title = "Sathee by IITK";
                url = "https://sathee.iitk.ac.in/";
              };
              rankers-world = {
                container = 2;
                id = "8fe40005-d363-4c1d-b5ab-465d8a98fbf9";
                isEssential = true;
                title = "Ranker's World";
                url = "https://www.rankersworld.in/user";
              };
            };
            routes = { };
          };
          programming = {
            container = 4;
            id = "26958fb7-6d60-42da-b1d7-5468e73a168c";
            icon = "💻";
            name = "Programming";
            liveFolders = {
              pull-reqs = {
                github = {
                  authorMe = true;
                };
                kind = "github:pull-requests";
                id = "ghpr";
                title = "Github PRs";
              };
              issues = {
                github = {
                  authorMe = true;
                };
                kind = "github:issues";
                id = "ghis";
                title = "Github Issues";
              };
              awesome-up = {
                feedUrl = "https://www.trackawesomelist.com/rss.xml";
                id = "awesome-up";
                title = "Awesome List Updates";
              };
              shansel = {
                feedUrl = "http://feeds.hanselman.com/ScottHanselman";
                id = "shansel";
                title = "Scott Hanselman's Blog";
              };
              kali = {
                feedUrl = "https://www.kali.org/rss.xml";
                id = "kali";
                title = "Kali Linux";
              };
              alpine = {
                feedUrl = "https://alpinelinux.org/atom.xml";
                id = "alpine";
                title = "Alpine Linux News";
              };
              freebsd = {
                feedUrl = "https://www.freebsd.org/news/feed.xml";
                id = "freebsd";
                title = "FreeBSD News Flash";
              };
              fedora = {
                feedUrl = "https://fedoramagazine.org/feed/";
                id = "fedora";
                title = "Fedora Magazine";
              };
              cachy = {
                feedUrl = "https://cachyos.org/rss.xml";
                id = "cachy";
                title = "CachyOS's Blog";
              };
              hypr = {
                feedUrl = "https://hyprland.org/rss.xml";
                id = "hypr";
                title = "Hyprland News";
              };
              nixos = {
                feedUrl = "https://nixos.org/blog/announcements-rss.xml";
                id = "nixos";
                title = "Nixos Announcements";
              };
              arch = {
                feedUrl = "https://archlinux.org/feeds/news/";
                id = "arch";
                title = "Arch Linux: Recent news updates";
              };
              distrowatch = {
                feedUrl = "https://distrowatch.com/news/dw.xml";
                id = "distrowatch";
                title = "DistroWatch.com: News";
              };
            };
            pins = {
              haveibeenpwned = {
                container = 4;
                id = "1b2dfe1e-de94-4a92-a323-58a6b29160d7";
                isEssential = true;
                title = "HaveIBeenPwned";
                url = "https://haveibeenpwned.com/";
              };
              virustotal = {
                container = 4;
                id = "e1e03d6d-4253-481a-918a-3ad0fbccb3ec";
                isEssential = true;
                title = "VirusTotal";
                url = "https://www.virustotal.com/";
              };
              distrowatch = {
                container = 4;
                id = "af4fc956-5870-4f87-9bee-aecbc2d9006c";
                title = "DistroWatch";
                isEssential = true;
                url = "https://distrowatch.com/";
              };
              jnv-lists = {
                container = 4;
                id = "8d2949ca-7081-4849-aa7f-6de42bba1df5";
                isEssential = true;
                title = "Lists";
                url = "https://github.com/jnv/lists";
              };
              archwiki = {
                container = 4;
                id = "5dbe28cc-eaf4-48b3-8267-dff0a69974c8";
                isEssential = true;
                title = "Arch Linux Wiki";
                url = "https://wiki.archlinux.org";
              };
              nerdfonts-cheatsheet = {
                container = 4;
                id = "ffb89115-0f59-4521-907c-80b19c2d0af0";
                isEssential = true;
                title = "Nerd Fonts Cheatsheet";
                url = "https://www.nerdfonts.com/cheat-sheet";
              };
              symbl-cc = {
                container = 4;
                id = "46ef6329-d704-4b79-8730-39a841d07fc9";
                isEssential = true;
                title = "SYMBL";
                url = "https://symbl.cc/";
              };
              sourceforge = {
                container = 4;
                id = "6686ddd5-a549-4020-aabb-901171fb1f2d";
                isEssential = true;
                title = "SourceForge";
                url = "https://sourceforge.net/";
              };
              github = {
                container = 4;
                id = "bf20a494-0429-4c4e-944c-c4ef02e67570";
                isEssential = true;
                title = "GitHub";
                url = "https://www.github.com";
              };
              gitlab = {
                container = 4;
                id = "95d2f0e0-8d53-422d-b468-0ac7527df1a8";
                isEssential = true;
                title = "GitLab";
                url = "https://gitlab.com";
              };
              codeberg = {
                container = 4;
                id = "9419a631-1bb4-45a8-8868-4e180ee88980";
                isEssential = true;
                title = "Codeberg";
                url = "https://codeberg.org/";
              };
            };
            routes = {
              github.reference = "https://github.com/";
              codeberg.reference = "https://codeberg.org/";
              bitbucket.reference = "https://bitbucket.org/";
              gitea.reference = "https://gitea.com/";
              gitlab.reference = "https://gitlab.com/";
              mynixos.reference = "https://mynixos.com/";
            };
          };
          gaming = {
            container = 3;
            id = "28411276-373b-4643-9905-61ba86225c6b";
            icon = "🎮";
            name = "Gaming";
            liveFolders = {
              fgrepacks = {
                feedUrl = "https://fitgirl-repacks.site/feed/";
                id = "fgrepacks";
                title = "FitGirl Repacks";
              };
            };
            pins = {
              discord = {
                container = 3;
                id = "a3f6a231-122a-486e-9568-2b64f6a52dea";
                isEssential = true;
                title = "Discord";
                url = "https://discord.com/channels/@me";
              };
            };
            routes = { };
          };
          banking = {
            container = 6;
            id = "3fb6e9bc-dd97-4ba7-81d6-2a89e5d482b7";
            icon = "🏦";
            name = "Banking";
            liveFolders = { };
            pins = { };
            routes = { };
          };
          shopping = {
            container = 5;
            id = "1c2beafe-f4d0-45c0-93bc-c11f28b557cd";
            icon = "🛒";
            name = "Shopping";
            liveFolders = { };
            pins = {
              amazon = {
                container = 5;
                id = "ccf15a45-2602-40da-8fb4-9c19201cfa25";
                isEssential = true;
                title = "Amazon";
                url = "https://amazon.in";
              };
              flipkart = {
                container = 5;
                id = "b6fec396-02ad-4944-b1f9-52f484067916";
                isEssential = true;
                title = "Flipkart";
                url = "https://flipkart.com";
              };
            };
            routes = { };
          };
        };
      };
    };
    setAsDefaultBrowser = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings.user.name = "sametaor";
    settings.user.email = "71749831+sametaor@users.noreply.github.com";
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  programs.fzf = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
  programs.vscodium = {
    enable = true;
  };
  programs.rmpc = {
    enable = true;
  };
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    autocd = true;
    autosuggestion = {
      enable = true;
    };
    defaultKeymap = "vicmd";
    fastSyntaxHighlighting = {
      enable = true;
    };
    history = {
      append = true;
      expireDuplicatesFirst = true;
      extended = true;
      findNoDups = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 50000;
      saveNoDups = true;
      size = 50000;
    };
    historySubstringSearch = {
      enable = true;
    };
  };
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else (pkgs.nvidiaWrap pkgs.ghostty);
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    themes = {
      retrowave_theme = {
        background = "#20192b";
        foreground = "#efeeff";
        selection-background = "#42c6ff";
        selection-foreground = "#090819";
        cursor-color = "#42c6ff";
        cursor-text = "#283034";
        palette = [
          "0=#283034"
          "1=#F972AB"
          "2=#72f1b8"
          "3=#fcef52"
          "4=#6d77b3"
          "5=#ff2afc"
          "6=#f6037d"
          "7=#d9e0e9"
          "8=#435056"
          "9=#f88414"
          "10=#72f1b8"
          "11=#fff951"
          "12=#41DEF4"
          "13=#f93aa1"
          "14=#E32B9F"
          "15=#F4f6f9"
        ];
      };
    };
    settings = {
      title = "ghostty";
      maximize = true;
      working-directory = "home";
      wait-after-command = true;
      shell-integration-features = "cursor,sudo,no-title,ssh-env,ssh-terminfo";
      custom-shader = [
        "/home/sametaor/.config/ghostty/shaders/cursor_warp.glsl"
        "/home/sametaor/.config/ghostty/shaders/rectangle_boom_cursor.glsl"
        "/home/sametaor/.config/ghostty/shaders/cursor_blaze.glsl"
      ];
      custom-shader-animation = true;
      clipboard-read = "allow";
      clipboard-write = "allow";
      copy-on-select = "clipboard";
      window-subtitle = "working-directory";
      window-vsync = true;
      window-inherit-working-directory = true;
      window-inherit-font-size = true;
      window-save-state = "always";
      window-theme = "ghostty";
      window-padding-x = "0,0";
      window-padding-y = "0,0";
      window-padding-balance = true;
      background-opacity = "0.65";
      background-blur = true;
      unfocused-split-opacity = "0.65";
      split-divider-color = "#ff2afc";
      resize-overlay-position = "bottom-center";
      theme = "Synthwave Everything";
      bold-is-bright = true;
      cursor-opacity = "0.8";
      cursor-style-blink = true;
      font-size = "13.5";
      font-feature = "+ccmp + locl +mark +mkmk +calt +liga +dlig";
      font-family = "Iosevka SciFi Extended";
      font-style = "Regular";
      font-style-bold = "Semibold";
      font-style-italic = "Semibold Italic";
      adjust-cell-height = "1";
      adjust-box-thickness = "1";
      mouse-hide-while-typing = true;
      mouse-shift-capture = true;
      focus-follows-mouse = true;
      gtk-tabs-location = "bottom";
      gtk-titlebar-hide-when-maximized = true;
      link-previews = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.hyprshot.enable = true;
  programs.aerc.enable = true;
  programs.andcli.enable = true;
  programs.aria2.enable = true;
  programs.aria2.systemd.enable = true;
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  programs.bash.historyFileSize = 50000;
  programs.bat.enable = true;
  programs.bluetuith.enable = true;
  programs.btop.enable = true;
  programs.cargo.enable = true;
  programs.cava.enable = true;
  programs.chawan.enable = true;
  programs.command-not-found.enable = true;
  programs.eza.enable = true;
  programs.eza.colors = "always";
  programs.eza.git = true;
  programs.eza.icons = "always";
  programs.eza.enableBashIntegration = true;
  programs.eza.enableFishIntegration = true;
  programs.eza.enableNushellIntegration = true;
  programs.eza.enableZshIntegration = true;
  programs.fastfetch.enable = true;
  programs.fd.enable = true;
  programs.fd.hidden = true;
  programs.fish.enable = true;
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      sponsorblock
      webtorrent-mpv-hook
      mpris
      eisa01.simplebookmark
      mpv-gallery-view
      twitch-chat
      mpv-discord
      mpv-playlistmanager
      chapterskip
      skipsilence
      reload
      autosub
      autosubsync-mpv
      manga-reader
      youtube-chat
    ];
    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
    };
  };
  services.hyprpolkitagent.enable = true;

  services.udiskie = {
    enable = true;
    settings = {
      program_options = {
        file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
      };
    };
  };
  services.cliphist = {
    enable = true;
    systemdTargets = [ "config.wayland.systemd.target" ];
    extraOptions = [
      "-max-dedupe-search"
      "10"
      "-max-items"
      "500"
    ];
    allowImages = true;
  };
  services.hypridle.enable = true;
  services.mpd = {
    enable = true;
    musicDirectory = "/home/sametaor/Music";
    network.startWhenNeeded = true;
  };
  services.hyprlauncher.enable = true;
  services.mpris-proxy.enable = true;
  services.easyeffects.enable = true;
  services.easyeffects.extraPresets = {
    "Bass Enhancing + Perfect EQ - Low Latency" = {
      output = {
        blocklist = [ ];

        "convolver#0" = {
          autogain = false;
          bypass = false;
          dry = -100.0;
          input-gain = 0.0;
          ir-width = 100;
          kernel-name = "Razor Surround ((48k Z-Edition)) 2.Stereo +20 bass Low Latency";
          output-gain = 0.0;
          sofa = {
            azimuth = 0.0;
            elevation = 0.0;
            radius = 1.0;
          };
          wet = 0.0;
        };

        "equalizer#0" = {
          balance = 0.0;
          bypass = false;
          input-gain = 0.0;
          left = {
            band0 = {
              frequency = 32.0;
              gain = 4.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band1 = {
              frequency = 64.0;
              gain = 2.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372453;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band2 = {
              frequency = 125.0;
              gain = 1.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band3 = {
              frequency = 250.0;
              gain = 0.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band4 = {
              frequency = 500.0;
              gain = -1.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372453;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band5 = {
              frequency = 1000.0;
              gain = -2.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band6 = {
              frequency = 2000.0;
              gain = 0.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372449;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band7 = {
              frequency = 4000.0;
              gain = 2.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372449;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band8 = {
              frequency = 8000.0;
              gain = 3.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372453;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band9 = {
              frequency = 16000.0;
              gain = 3.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
          };
          mode = "IIR";
          num-bands = 10;
          output-gain = 0.0;
          pitch-left = 0.0;
          pitch-right = 0.0;
          right = {
            band0 = {
              frequency = 32.0;
              gain = 4.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band1 = {
              frequency = 64.0;
              gain = 2.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372453;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band2 = {
              frequency = 125.0;
              gain = 1.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band3 = {
              frequency = 250.0;
              gain = 0.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band4 = {
              frequency = 500.0;
              gain = -1.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372453;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band5 = {
              frequency = 1000.0;
              gain = -2.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band6 = {
              frequency = 2000.0;
              gain = 0.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372449;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band7 = {
              frequency = 4000.0;
              gain = 2.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372449;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band8 = {
              frequency = 8000.0;
              gain = 3.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.5047602375372453;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
            band9 = {
              frequency = 16000.0;
              gain = 3.0;
              mode = "RLC (BT)";
              mute = false;
              q = 1.504760237537245;
              slope = "x1";
              solo = false;
              type = "Bell";
              width = 4.0;
            };
          };
          split-channels = false;
        };

        "limiter#0" = {
          alr = false;
          alr-attack = 5.0;
          alr-knee = 0.0;
          alr-knee-smooth = -5.0;
          alr-release = 50.0;
          attack = 5.0;
          bypass = false;
          dithering = "None";
          gain-boost = true;
          input-gain = 0.0;
          input-to-link = 0.0;
          input-to-sidechain = 0.0;
          link-to-input = 0.0;
          link-to-sidechain = 0.0;
          lookahead = 5.0;
          mode = "Herm Thin";
          output-gain = 0.0;
          oversampling = "None";
          release = 5.0;
          sidechain-preamp = 0.0;
          sidechain-to-input = 0.0;
          sidechain-to-link = 0.0;
          sidechain-type = "Internal";
          stereo-link = 100.0;
          threshold = 0.0;
        };

        plugins_order = [
          "equalizer#0"
          "convolver#0"
          "limiter#0"
        ];
      };
    };
  };
  services.easyeffects.preset = "Bass Enhancing + Perfect EQ - Low Latency";
}
