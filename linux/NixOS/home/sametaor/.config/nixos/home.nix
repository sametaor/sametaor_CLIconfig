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
  home = {
    username = "sametaor";
    homeDirectory = "/home/sametaor";
    file.".config/nixos".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Projects/github/sametaor_CLIconfig/linux/NixOS/home/sametaor/.config/nixos";
    # This value determines the Home Manager release that your configuration is
    # compatible with. You should not change this, even if you update Home Manager.
    stateVersion = "26.05"; # Please check the release notes before changing
    # The home.packages option allows you to install packages to your user profilee
    packages = [ ];
    pointerCursor = {
      enable = true;
      gtk = {
        enable = true;
        size = 24;
      };
      hyprcursor = {
        enable = true;
        size = 24;
      };
      package = pkgs.breeze-hacked-cursor-theme;
      name = "Breeze_Hacked";
      size = 24;
    };
    preferXdgDirectories = true;
    shell = {
      enableShellIntegration = true;
    };
    shellAliases = { };
    sessionPath = [ ];
    sessionSearchVariables = { };
    sessionVariables = {
      XCURSOR_THEME = "Breeze_Hacked";
      XCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "Breeze_Hacked";
    };
  };

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
  nix = {
    assumeXdg = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    nixPath = [
      "nixos-config=/home/sametaor/Projects/github/sametaor_CLIconfig/linux/NixOS/home/sametaor/.config/nixos/configuration.nix"
    ];
  };
  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme.name = "Breeze_Hacked";
    cursorTheme.size = 24;
    cursorTheme.package = pkgs.breeze-hacked-cursor-theme;
    font = {
      name = "Iosevka SciFi Extended";
      size = 11;
    };
    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-GTK";
    };
    gtk3 = {
      bookmarks = [
        "file:///home/sametaor"
        "file:///data"
        "file:///home/sametaor/Downloads"
        "file:///home/sametaor/Documents"
        "file:///home/sametaor/Pictures"
        "file:///home/sametaor/Videos"
        "file:///home/sametaor/Music"
        "file:///home/sametaor/.config"
        "file:///home/sametaor/Projects/github"
      ];
    };
  };
  manual = {
    manpages.enable = true;
    html.enable = true;
    json.enable = true;
  };
  xdg = {
    enable = true;
    autostart = {
      enable = true;
      readOnly = true;
    };
    configFile = {
      "rmpc/themes/theme.ron" = {
        text = ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              default_album_art_path: None,
              lyrics: (
                timestamp: true,
              ),
              show_song_table_header: true,
              draw_borders: true,
              browser_column_widths: [20, 38, 42],
              background_color: None,
              text_color: None,
              header_background_color: None,
              modal_background_color: None,
              modal_backdrop: true,
              level_styles: (
                info: (fg: "blue", bg: "#000000"),
                warn: (fg: "yellow", bg: "#000000"),
                error: (fg: "red", bg: "#000000"),
                debug: (fg: "light_green", bg: "#000000"),
                trace: (fg: "magenta", bg: "#000000"),
              ),
              tab_bar: (
                  enabled: true,
                  active_style: (fg: "black", bg: "blue", modifiers: "Bold"),
                  inactive_style: (),
              ),
              highlighted_item_style: (fg: "blue", modifiers: "Bold"),
              current_item_style: (fg: "black", bg: "blue", modifiers: "Bold"),
              borders_style: (fg: "#0fffcf"),
              highlight_border_style: (fg: "blue"),
              format_tag_separator: "; ",
              symbols: (song: "󰝚 ", dir: "󱍙 ", marker: " ", ellipsis: "..."),
              progress_bar: (
                  symbols: ["◾", "⟧", "╾", "─", "┤"],
                  track_style: (fg: "blue", modifiers: "Bold"),
                  elapsed_style: (fg: "blue"),
                  thumb_style: (fg: "blue"),
              ),
              scrollbar: (
                  symbols: ["│", "█", "┌", "└"],
                  track_style: (modifiers: "Bold"),
                  ends_style: (),
                  thumb_style: (fg: "blue", modifiers: "CrossedOut"),
              ),
              song_table_format: [
                  (
                      prop:(kind: Property(Title), style: (modifiers: "Bold"),
                          default: (kind: Text("Unknown"))
                      ),
                      width: "35%",
                      label: Some("󰽰 Title")
                  ),
                  (
                      prop: (kind: Property(Artist),style: (modifiers: "Italic"),
                          default: (kind: Text("Unknown"))
                      ),
                      width: "20%",
                      label: Some("󰳩 Artist")
                  ),
                  (
                      prop: (kind: Property(Album), style: (fg: "white", modifiers: "Dim"),
                          default: (kind: Text("Unknown Album"), style: (fg: "white"))
                      ),
                      width: "30%",
                      label: Some("󰀥 Album")
                  ),
                  (
                      prop: (kind: Property(Duration),style: (modifiers: "Italic"),
                          default: (kind: Text("-"))
                      ),
                      width: "15%",
                      alignment: Right,
                      label: Some("󰔚 Duration")
                  ),
              ],
              layout: Split(
                  direction: Vertical,
                  panes: [
                    (
                      size: "1",
                      pane: Pane(Tabs),
                    ),
                    (
                      size: "100%",
                      borders: "ALL",
                      border_style: (fg: "#F809C9"),
                      pane: Split(
                        direction: Horizontal,
                        panes: [
                          (
                            size: "30%",
                            pane: Split(
                              direction: Vertical,
                              panes: [
                                (
                                  size: "7%",
                                  borders: "ALL",
                                  border_style: (fg: "#FEF709"),
                                  pane: Pane(Property(content: [
                                    (kind: Text("󰍰 Lyrics"), style: (fg: "blue", modifiers: "Bold")),
                                  ], align: Center,))
                                ),
                                (
                                  size: "93%",
                                  pane: Split(
                                    direction: Vertical,
                                      panes: [
                                        (
                                          size: "70%",
                                          borders: "ALL",
                                          border_style: (fg: "#FEF709"),
                                          pane: Pane(Lyrics),
                                        ),
                                        (
                                          size: "30%",
                                          borders: "ALL",
                                          border_style: (fg: "#72F1B8"),
                                          pane: Pane(Cava),
                                        )
                                      ]
                                  ),
                                ),
                              ]
                            ),
                          ),
                          (
                            size: "70%",
                            borders: "ALL",
                            border_style: (fg: "#F88414"),
                            pane: Pane(TabContent),
                          )
                        ]
                      )
                    ),
                    (
                      pane: Split(
                        direction: Horizontal,
                        size: "100%",
                        panes: [
                          (
                            size: "10",
                            pane: Pane(AlbumArt),
                            borders: "RIGHT",
                          ),
                          (
                            size: "100%",
                            pane: Split(
                              direction: Vertical,
                              panes:[
                                (
                                  size: "100%",
                                  pane: Pane(Header)
                                ),
                                (
                                  size: "2",
                                  pane: Pane(ProgressBar),
                                  borders: "TOP",
                                )
                              ]
                            ),
                          )
                        ]
                      ),
                      size: "6",
                      borders: "ALL",
                      border_style: (fg: "#41DEF4"),
                    ),
                  ],
              ),
              header: (
                  rows: [
                      (
                          left: [
                              (kind: Text("⟬"), style: (fg: "#fdef50", modifiers: "Bold")),
                              (kind: Property(Status(StateV2(playing_label: " Playing", paused_label: "󰏨 Paused", stopped_label: "󰙧 Stopped"))), style: (fg: "#fdef50", modifiers: "Bold")),
                              (kind: Text("⟭"), style: (fg: "#fdef50", modifiers: "Bold"))
                          ],
                          center: [
                                (kind: Text(" "), style: (fg: "#5df7f5", modifiers: "Bold")),
                                (kind: Property(Song(Title)), style: (fg: "#5df7f5",modifiers: "Bold"),
                                    default: (kind: Property(Song(Filename)), style: (fg: "#5df7f5", modifiers: "Bold"))
                                ),
                          ],
                          right: [
                              (kind: Text(" ")),
                              (kind: Property(Widget(Volume)), style: (fg: "blue"))
                          ]
                      ),
                      (
                          left: [
                              (kind: Text("󰔚 ")),
                              (kind: Property(Status(Elapsed))),
                              (kind: Text(" / ")),
                              (kind: Property(Status(Duration))),
                              (kind: Text(" (")),
                              (kind: Property(Status(Bitrate))),
                              (kind: Text(" kbps)"))
                          ],
                          center: [
                              (kind: Text("󰳩 "), style: (fg: "blue", modifiers: "Bold")),
                              (kind: Property(Song(Artist)), style: (fg: "blue", modifiers: "Bold"),
                                  default: (kind: Text("Unknown"), style: (fg: "blue", modifiers: "Bold"))
                              ),
                              (kind: Text(" - ")),
                              (kind: Text("󰀥 ")),
                              (kind: Property(Song(Album)),
                                  default: (kind: Text("Unknown Album"))
                              )
                          ],
                          right: [
                              (kind: Text("⟬ "),style: (fg: "blue")),

                              (kind: Property(Status(RepeatV2(

                                              on_label: " ", off_label: "󰑗 ",

                                              on_style: (fg: "white", modifiers: "Bold"), off_style: (fg: "#969696", modifiers: "Bold"))))),

                              (kind: Text(" ┃ "),style: (fg: "blue")),

                              (kind: Property(Status(RandomV2(

                                              on_label: " ", off_label: "󰒞 ",

                                              on_style: (fg: "white", modifiers: "Bold"), off_style: (fg: "#969696", modifiers: "Bold"))))),

                              (kind: Text(" ┃ "),style: (fg: "blue")),

                              (kind: Property(Status(ConsumeV2(

                                              on_label: "󰮯", off_label: "󰮯", oneshot_label: "󰮯󰇊",

                                              on_style: (fg: "white", modifiers: "Bold"), off_style: (fg: "#969696", modifiers: "Bold"))))),

                              (kind: Text(" ┃ "),style: (fg: "blue")),

                              (kind: Property(Status(SingleV2(

                                              on_label: "󰎤", off_label: "󰎦", oneshot_label: "󰇊", off_oneshot_label: "󱅊",

                                              on_style: (fg: "white", modifiers: "Bold"), off_style: (fg: "#969696", modifiers: "Bold"))))),

                              (kind: Text(" ⟭"),style: (fg: "blue")),
                          ]
                      ),
                  ],
              ),
              cava: (
                  bar_symbols: ['░', '▒', '▓', '█'],
                  bar_width: 1, bar_spacing: 1,
                  bar_color: Gradient({
                          0:   "#ed71df",
                          100: "#a166e4"
                      })
              ),
              browser_song_format: [
                  (
                      kind: Group([
                          (kind: Property(Track)),
                          (kind: Text(" ")),
                      ])
                  ),
                  (
                      kind: Group([
                          (kind: Property(Artist)),
                          (kind: Text(" - ")),
                          (kind: Property(Title)),
                      ]),
                      default: (kind: Property(Filename))
                  ),
              ],
          )
        '';
      };
      "rmpc/lyrics.sh" = {
        text = ''
          #!/bin/env sh
          LRCLIB_INSTANCE="https://lrclib.net"
          if [ "$HAS_LRC" = "false" ]; then
              mkdir -p "$(dirname "$LRC_FILE")"
              LYRICS="$(curl -X GET -sG \
                  -H "Lrclib-Client: rmpc-$VERSION" \
                  --data-urlencode "artist_name=$ARTIST" \
                  --data-urlencode "track_name=$TITLE" \
                  --data-urlencode "album_name=$ALBUM" \
                  "$LRCLIB_INSTANCE/api/get" | jq -r '.syncedLyrics')"
              if [ -z "$LYRICS" ]; then
                  rmpc remote --pid "$PID" status "Failed to download lyrics for $ARTIST - $TITLE" --level error
                  exit
              fi
              if [ "$LYRICS" = "null" ]; then
                  rmpc remote --pid "$PID" status "Lyrics for $ARTIST - $TITLE not found" --level warn
                  exit
              fi
              echo "[ar:$ARTIST]" >"$LRC_FILE"
              {
                  echo "[al:$ALBUM]"
                  echo "[ti:$TITLE]"
              } >>"$LRC_FILE"
              echo "$LYRICS" | sed -E '/^\[(ar|al|ti):/d' >>"$LRC_FILE"
              rmpc remote --pid "$PID" indexlrc --path "$LRC_FILE"
              rmpc remote --pid "$PID" status "Downloaded lyrics for $ARTIST - $TITLE" --level info
          fi
        '';
        executable = true;
      };
    };
    localBinInPath = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
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
  qt = {
    enable = true;
    style = {
      name = "kvantum";
    };
    kvantum = {
      enable = true;
      settings = {
      };
      themes = [ ];
    };
  };

  # Home Manager can also manage your environment variables and git configurations natively
  wayland.windowManager = {
    niri = {
      enable = true;
    };
    hyprland = {
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
  };
  programs = {
    television = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      channels = {};
      settings = {};
      themes = {};
    };
    tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 50000;
      keyMode = "vi";
      mouse = true;
      newSession = true;
      plugins = [];
      secureSocket = false;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "screen-256color";
      tmuxp = {
        enable = true;
      };
    };
    topgrade = {
      enable = true;
      settings = {
        misc = {
          pre_sudo = true;
          sudo_command = "doas";
          disable = [];
          first = [];
          last = [];
          ignore_failures = [];
        };
      };
    };
    man = {
      enable = true;
    };
    mcp = {
      enable = true;
    };
    less = {
      enable = true;
      options = [];
    };
    lutris = {
      enable = true;
      protonPackages = [];
    };
    aria2 = {
      enable = true;
      settings = {
        dir = "${config.home.homeDirectory}/Downloads";
        max-concurrent-downloads = 100;
        check-integrity = true;
        continue = true;
        remote-time = true;
        show-fles = true;
        bt-force-encryption = true;
        bt-load-saved-metadata = true;
        bt-min-crypto-level = "arc4";
        bt-require-crypto = true;
        optimize-concurrent-downloads = true;
      };
      systemd.enable = true;
    };
    hyprland-qt-support = {
      enable = true;
      settings = {
        roundess = 0;
        border_width = 1;
        reduce_motion = false;
      };
    };
    zen-browser = {
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
    git = {
      enable = true;
      lfs = {
        enable = true;
        skipSmudge = true;
      };
      settings.user = {
        name = "sametaor";
        email = "71749831+sametaor@users.noreply.github.com";
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
      hosts = {
        "github.com" = {
          user = "sametaor";
        };
      };
      settings = {
        aliases = { 
          a = "auth";
          li = "auth login";
          lih = "auth login --hostname";
          liw = "auth login --web";
          lo = "auth logout";
          loh = "auth logout --hostname";
          ast = "auth status";
          asth = "auth status --hostname";
          astt = "auth status --show-token";
          atk = "auth token";
          atkh = "auth token --hostname";
          b = "browse";
          bc = "browse --commit";
          bn = "browse --no-browser";
          bp = "browse --projects";
          bs = "browse --settings";
          bw = "browse --wiki";
          cf = "config";
          cfg = "gh config get";
          cfl = "gh config list";
          cfs = "gh config set";
          ex = "extension";
          h = "gh help";
          st = "gh status";
          ste = "gh status --exclude";
          sto = "gh status --org";
          w = "gh workflow";
          wd = "gh workflow disable";
          we = "gh workflow enable";
          wl = "gh workflow list";
          wla = "gh workflow list --all";
          wlL = "gh workflow list --limit";
          wr = "gh workflow run";
          wrj = "gh workflow run --json";
          wv = "gh workflow view";
          wvw = "gh workflow view --web";
          wvy = "gh workflow view --yaml";
          g = "gh gist";
          gcl = "gh gist clone";
          gcr = "gh gist create";
          gcrp = "gh gist create --public";
          gcrw = "gh gist create --web";
          gd = "gh gist delete";
          ge = "gh gist edit";
          gl = "gh gist list";
          gll = "gh gist list --limit";
          glp = "gh gist list --public";
          gls = "gh gist list --secret";
          gv = "gh gist view";
          gvf = "gh gist view --files";
          gvr = "gh gist view --raw";
          gvw = "gh gist view --web";
          i = "gh issue";
          icl = "gh issue close";
          icm = "gh issue comment";
          icme = "gh issue comment --editor";
          icml = "gh issue comment --edit-last";
          icmw = "gh issue comment --web";
          icr = "gh issue create";
          icra = "gh issue create --assignee";
          icrl = "gh issue create --label";
          icrm = "gh issue create --milestone";
          icrp = "gh issue create --project";
          icrw = "gh issue create --web";
          id = "gh issue delete";
          idc = "gh issue delete --confirm";
          ie = "gh issue edit";
          il = "gh issue list";
          ila = "gh issue list --assignee";
          ilA = "gh issue list --author";
          ilj = "gh issue list --json";
          ill = "gh issue list --label";
          ilL = "gh issue list --limit";
          ilM = "gh issue list --mention";
          ilm = "gh issue list --milestone";
          ilS = "gh issue list --search";
          ils = "gh issue list --state";
          ilw = "gh issue list --web";
          ip = "gh issue pin";
          ir = "gh issue reopen";
          is = "gh issue status";
          isj = "gh issue status --json";
          it = "gh issue transfer";
          iu = "gh issue unpin";
          iv = "gh issue view";
          ivc = "gh issue view --comments";
          ivw = "gh issue view --web";
          p = "gh pr";
          pco = "gh pr checkout";
          pcod = "gh pr checkout --detach";
          pcof = "gh pr checkout --force";
          pcor = "gh pr checkout --recurse-submodules";
          pcs = "gh pr checks";
          pcsr = "gh pr checks --required";
          pcsW = "gh pr checks --watch";
          pcsw = "gh pr checks --web";
          pcl = "gh pr close";
          pcld = "gh pr close --delete-branch";
          pcm = "gh pr comment";
          pcme = "gh pr comment --editor";
          pcml = "gh pr comment --edit-last";
          pcmw = "gh pr comment --web";
          pcr = "gh pr create";
          pcra = "gh pr create --assignee";
          pcrd = "gh pr create --draft";
          pcrf = "gh pr create --fill";
          pcrl = "gh pr create --label";
          pcrm = "gh pr create --milestone";
          pcrn = "gh pr create --no-maintainer-edit";
          pcrp = "gh pr create --project";
          pcrw = "gh pr create --web";
          pd = "gh pr diff";
          pdn = "gh pr diff --name-only";
          pdp = "gh pr diff --patch";
          pdw = "gh pr diff --web";
          pe = "gh pr edit";
          pl = "gh pr list";
          pla = "gh pr list --assignee";
          plA = "gh pr list --author";
          plb = "gh pr list --base";
          pld = "gh pr list --draft";
          plh = "gh pr list --head";
          plj = "gh pr list --json";
          pll = "gh pr list --label";
          plL = "gh pr list --limit";
          plS = "gh pr list --search";
          pls = "gh pr list --state";
          plw = "gh pr list --web";
          pm = "gh pr merge";
          pma = "gh pr merge --admin";
          pmau = "gh pr merge --auto";
          pmd = "gh pr merge --delete-branch";
          pmda = "gh pr merge --disable-auto";
          pmm = "gh pr merge --merge";
          pmr = "gh pr merge --rebase";
          pms = "gh pr merge --squash";
          prd = "gh pr ready";
          prdu = "gh pr ready --undo";
          pro = "gh pr reopen";
          prv = "gh pr review";
          prva = "gh pr review --approve";
          prvc = "gh pr review --comment";
          prvr = "gh pr review --request-changes";
          ps = "gh pr status";
          psc = "gh pr status --conflict-status";
          psj = "gh pr status --json";
          pv = "gh pr view";
          pvc = "gh pr view --comments";
          pvj = "gh pr view --json";
          pvw = "gh pr view --web";
          rl = "gh release";
          rlc = "gh release create";
          rlcd = "gh release create --draft";
          rlcg = "gh release create --generate-notes";
          rlcl = "gh release create --latest";
          rlcp = "gh release create --prerelease";
          rld = "gh release delete";
          rldc = "gh release delete --cleanup-tag";
          rldy = "gh release delete --yes";
          rlda = "gh release delete-asset";
          rlday = "gh release delete-asset --yes";
          rldo = "gh release download";
          rldoc = "gh release download --clobber";
          rldos = "gh release download --skip-existing";
          rle = "gh release edit";
          rled = "gh release edit --draft";
          rlel = "gh release edit --latest";
          rlep = "gh release edit --prerelease";
          rll = "gh release list";
          rlle = "gh release list --exclude-drafts";
          rlu = "gh release upload";
          rluc = "gh release upload --clobber";
          rlv = "gh release view";
          rlvw = "gh release view --web";
          rp = "gh repo";
          rpa = "gh repo archive";
          rpay = "gh repo archive --confirm";
          rpcl = "gh repo clone";
          rpc = "gh repo create";
          rpca = "gh repo create --add-readme";
          rpcc = "gh repo create --clone";
          rpcdi = "gh repo create --disable-issues";
          rpcdw = "gh repo create --disable-wiki";
          rpcia = "gh repo create --include-all-branches";
          rpci = "gh repo create --internal";
          rpcpv = "gh repo create --private";
          rpcpb = "gh repo create --public";
          rpcps = "gh repo create --push";
          rpd = "gh repo delete";
          rpdc = "gh repo delete --confirm";
          rpdk = "gh repo deploy-key";
          rpdka = "gh repo deploy-key add";
          rpdkaw = "gh repo deploy-key add --allow-write";
          rpdkd = "gh repo deploy-key delete";
          rpdkl = "gh repo deploy-key list";
          rpe = "gh repo edit";
          rpeat = "gh repo edit --add-topic";
          rpeaf = "gh repo edit --allow-forking";
          rpeau = "gh repo edit --allow-update-branch";
          rpedb = "gh repo edit --default-branch";
          rpedm = "gh repo edit --delete-branch-on-merge";
          rpeds = "gh repo edit --description";
          rpeam = "gh repo edit --enable-auto-merge";
          rped = "gh repo edit --enable-discussions";
          rpei = "gh repo edit --enable-issues";
          rpemc = "gh repo edit --enable-merge-commit";
          rpep = "gh repo edit --enable-projects";
          rperm = "gh repo edit --enable-rebase-merge";
          rpesm = "gh repo edit --enable-squash-merge";
          rpew = "gh repo edit --enable-wiki";
          rpeh = "gh repo edit --homepage";
          rpert = "gh repo edit --remove-topic";
          rpet = "gh repo edit --template";
          rpev = "gh repo edit --visibility";
          rpf = "gh repo fork";
          rpfc = "gh repo fork --clone";
          rpfr = "gh repo fork --remote";
          rpl = "gh repo list";
          rpla = "gh repo list --archived";
          rplf = "gh repo list --fork";
          rpln = "gh repo list --no-archived";
          rpls = "gh repo list --source";
          rpr = "gh repo rename";
          rprc = "gh repo rename --confirm";
          rps = "gh repo sync";
          rpsf = "gh repo sync --force";
          rpv = "gh repo view";
          rpvw = "gh repo view --web";
        };
        editor = "";
      };
      extensions = with pkgs; [
        gh-eco
        gh-s
        gh-f
        gh-i
        gh-cal
        gh-enhance
        gh-screensaver
        github-copilot-cli
      ];
    };
    gpg = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      changeDirWidget = {
        command = "fd --type d";
      };
      colors = { };
      defaultCommand = "fd";
      defaultOptions = [ ];
      fileWidget = {
        command = "fd --type f";
      };
      historyWidget = {
        command = "fc -rl 1";
      };
      tmux = {
        enableShellIntegration = true;
        shellIntegrationOptions = [ ];
      };
    };
    vscodium = {
      enable = true;
      profiles = {
        default = {
          enableExtensionUpdateCheck = true;
          enableMcpIntegration = true;
          enableUpdateCheck = true;
          extensions = [];
          keybindings = [];
          userMcp = {};
          userSettings = {};
        };
      };
    };
    wlr-which-key = {
      enable = true;
      extraMenus = {};
      settings = {};
    };
    rmpc = {
      enable = true;
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
          lyrics_dir: "~/Music/lyrics",
          max_fps: 144,
          select_current_song_on_change: true,
          center_current_song_on_change: true,
          on_song_change: ["~/.config/rmpc/lyrics.sh"],
          artists: (
            album_display_mode: NameOnly,
            album_sort_by: Name,
          ),
          browser_song_sort: [Disc, Track, Title, Artist],
          theme: "theme",
          search: (
            case_sensitive: false,
            mode: Contains,
            tags: [
                (value: "any",         label: "Any Tag"),
                (value: "artist",      label: "Artist"),
                (value: "album",       label: "Album"),
                (value: "title",       label: "Title"),
                (value: "filename",    label: "Filename"),
                (value: "genre",       label: "Genre"),
            ],
          ),
          album_art: (
            method: Auto,
            max_size_px: (width: 1200, height: 1200),
            disabled_protocols: [],
            vertical_align: Center,
            horizontal_align: Center,
          ),
          keybinds : (
            global: {
              "1": SwitchToTab("󰦚 Now Playing"),
              "2": SwitchToTab("󱍚 Directories"),
              "3": SwitchToTab("󰳩 Artists"),
              "4": SwitchToTab("󰀥 Albums"),
              "5": SwitchToTab("󰲸 Playlists"),
              "6": SwitchToTab(" Search"),
            },
          ),
          tabs: [
            (
                name: "󰦚 Now Playing",
                pane: Pane(Queue)
            ),
            (
                name: "󱍚 Directories",
                pane: Pane(Directories),
            ),
            (
                name: "󰳩 Artists",
                pane: Pane(Artists),
            ),
            (
                name: "󰀥 Albums",
                pane: Pane(Albums),
            ),
            (
                name: "󰲸 Playlists",
                pane: Pane(Playlists),
            ),
            (
                name: " Search",
                pane: Pane(Search),
            ),
          ],
          cava: (
            framerate: 144,
            input: (
              method: Fifo,
              source: "/tmp/mpd.fifo",
              sample_rate: 48000,
              channels: 2,
              sample_bits: 16,
            ),
            smoothing: (
              noise_reduction: 35,
            ),
          ),
        )
      '';
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      extraPackages = [];
      flavors = {};
      keymap = {};
      plugins = {};
      settings = {};
      theme = {};
    };
    yt-dlp = {
      enable = true;
      settings = {};
    };
    starship = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableInteractive = true;
      enableTransience = true;
      presets = [];
      settings = {};
    };
    tealdeer = {
      enable = true;
      settings = {
        updates = {
          auto_update = true;
          auto_update_interval_hours = 24;
        };
      };
    };
    timidity = {
      enable = true;
      extraConfig = "";
    };
    zellij = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      attachExistingSession = true;
      exitShellOnExit = false;
      layouts = {};
      plugins = [];
      settings = {};
      themes = {};
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    zsh = {
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
    go = {};
    ghostty = {
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
    home-manager.enable = true;
    hyprshot = {
      enable = true;
      saveLocation = "${config.home.homeDirectory}/Pictures/Screenshots";
    };
    bash = {
      enable = true;
      enableCompletion = true;
      historyFileSize = 50000;
      historySize = 50000;
      historyControl = [
        "erasedups"
        "ignoreboth"
      ];
      historyFile = "${config.home.homeDirectory}/.bash_history";
      historyIgnore = [ ];
      shellOptions = [
        "nullglob"
        "globstar"
        "autocd"
        "extglob"
        "failglob"
        "promptvars"
        "histappend"
      ];
    };
    lazydocker = {
      enable = true;
      settings = {
        gui = {
          scrollHeight = 2;
          border = "single";
          theme = {
            activeBorderColor = [
              "red"
              "bold"
            ];
            inactiveBorderColor = [
              "white"
            ];
          };
          showBottomLine = true;
        };
        logs = {
          timestamps = true;
        };
      };
    };
    lazygit = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      settings = {
        gui = {
          fileTreeSortOrder = "filesFirst";
          showNumstatInFilesView = true;
          nerdFontsVersion = "3";
          border = "single";
          spinner = {
            frames = [
              "󰋙"
              "󰫃"
              "󰫄"
              "󰫅"
              "󰫆"
              "󰫇"
              "󰫈"
            ];
            rate = "200";
          };
        };
      };
    };
    bat.enable = true;
    bluetuith.enable = true;
    clock-rs = {
      enable = true;
      settings = {
        general = {
          color = "#41def4";
          blink = true;
          bold = true;
        };
        date = {
          fmt = "%A, %d.%B.%Y";
        };
      };
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "samwave";
        theme_background = false;
        truecolor = true;
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
        vim_keys = true;
        rounded_corners = false;
        terminal_sync = true;
        graph_symbol = "braille";
        graph_symbol_cpu = "braille";
        graph_symbol_gpu = "braille";
        graph_symbol_mem = "braille";
        graph_symbol_net = "block";
        graph_symbol_proc = "braille";
        shown_boxes = "cpu mem net proc gpu0";
        update_ms = 2000;
        proc_sorting = "cpu lazy";
        proc_reversed = false;
        proc_tree = true;
        proc_colors = true;
        proc_gradient = true;
        proc_per_core = false;
        proc_mem_bytes = true;
        proc_cpu_graphs = true;
        proc_info_smaps = false;
        proc_left = false;
        proc_filter_kernel = true;
        proc_follow_detailed = true;
        proc_aggregate = true;
        proc_tree_auto_collapse = 0;
        keep_dead_proc_usage = false;
        cpu_graph_upper = "idle";
        cpu_graph_lower = "total";
        cpu_invert_lower = true;
        cpu_single_graph = false;
        cpu_bottom = false;
        show_gpu_info = "On";
        show_uptime = true;
        show_cpu_watts = true;
        check_temp = true;
        cpu_sensor = "Auto";
        show_coretemp = true;
        cpu_core_map = "";
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;
        freq_mode = "range";
        clock_format = "/host | %H:%M ";
        background_update = false;
        custom_cpu_name = "";
        gpu_mirror_graph = true;
        disks_filter = "";
        mem_graphs = true;
        mem_below_net = false;
        zfs_arc_cached = true;
        show_swap = true;
        show_disks = true;
        only_physical = false;
        use_fstab = true;
        zfs_hide_datasets = false;
        disk_free_priv = false;
        show_io_stat = true;
        io_mode = false;
        io_graph_combined = false;
        io_graph_speeds = "";
        net_auto = true;
        net_sync = true;
        net_iface = "";
        base_10_bitrate = true;
        show_battery = true;
        selected_battery = "Auto";
        show_battery_watts = true;
        log_level = "WARNING";
      };
      themes = {
        samwave = ''
          theme[main_bg]="#20192b"
          theme[main_fg]="#efeeff"
          theme[title]="#f6037d"
          theme[hi_fg]="#ff2afc"
          theme[selected_bg]="#42c6ff"
          theme[inactive_fg]="#6D77B3"
          theme[graph_text]="#fcef52"
          theme[meter_bg]="#20192b"
          theme[proc_misc]="#72f1b8"
          theme[cpu_box]="#f6037d"
          theme[mem_box]="#41def4"
          theme[net_box]="#f93aa1"
          theme[proc_box]="#8f00ff"
          theme[div_line]="#8f00ff"
          theme[temp_start]="#41def4"
          theme[temp_mid]="#f93aa1"
          theme[temp_end]="#ff0040"
          theme[cpu_start]="#8b00ff"
          theme[cpu_mid]="#f93aa1"
          theme[cpu_end]="#41def4"
          theme[free_start]="#9400d3"
          theme[free_mid]="#f93aa1"
          theme[free_end]="#72f1b8"
          theme[cached_start]="#0080ff"
          theme[cached_mid]="#41def4"
          theme[cached_end]="#00ffff"
          theme[available_start]="#f93aa1"
          theme[available_mid]="#ff0080"
          theme[available_end]="#9400d3"
          theme[used_start]="#41def4"
          theme[used_mid]="#72f1b8"
          theme[used_end]="#fcef52"
          theme[download_start]="#f93aa1"
          theme[download_mid]="#ff0080"
          theme[download_end]="#9400d3"
          theme[upload_start]="#41def4"
          theme[upload_mid]="#00bfff"
          theme[upload_end]="#0080ff"
          theme[process_start]="#8b00ff"
          theme[process_mid]="#f93aa1"
          theme[process_end]="#41def4"
        '';
      };
    };
    cargo = {
      enable = true;
      settings = {
        alias = {
          b = "build";
          i = "install";
        };
        build = {
          jobs = 8;
        };
        doc.browser = "zen-beta";
        cache.auto-clean-frequency = "always";
        net.git-fetch-with-cli = true;
        term.quiet = true;
      };
    };
    cava = {
      enable = true;
      settings = {
        general = {
          framerate = 144;
        };
        input = {
          method = "pipewire";
          source = "auto";
        };
        output = {
          method = "noncurses";
          orientation = "horizontal";
          channels = "stereo";
          show_idle_bar_heads = 0;
        };
        color = {
          blend_direction = "up";
          horizontal_gradient_color_1 = "#FEF709";
          horizontal_gradient_color_2 = "#F807CB";
          horizontal_gradient_color_3 = "#4F0C71";
        };
        smoothing = {
          monstercat = 1;
        };
      };
    };
    chawan.enable = true;
    command-not-found.enable = true;
    devenv = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    emacs = {
      enable = true;

    };
    eza = {
      enable = true;
      colors = "always";
      git = true;
      icons = "always";
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      extraOptions = [
        "-a"
        "-l"
        "--hyperlink"
        "-F always"
        "--color-scale-mode=gradient"
        "--git"
        "--git-repos -o"
      ];
      theme = {};
    };
    fastfetch = {
      enable = true;
      settings = { };
    };
    fd = {
      enable = true;
      extraOptions = [
        "--ansi"
        "--style=full"
        "--color=dark"
        "--track"
        "--cycle"
      ];
      hidden = true;
    };
    fish = {
      enable = true;
    };
    mpv = {
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
    mpvpaper = {
      enable = true;
      pauseList = ''
        zen-beta
      '';
    };
    navi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      settings = {
      	cheats = {
	        paths = {};
        };
        style = {
          tag.color = {};
          comment.color = {};
          snippet.color = {};
        };
        shell = {
          command = "zsh";
          finder_command = "zsh";
        };
        finder = {
          command = "fzf";
        };
      };
    };
    nix-search-tv = {
      enable = true;
      settings = {
        indexes = [
          "nixpkgs"
          "nixos"
          "home-manager"
          "nur"
          "noogle"
        ];
        enable_waiting_message = true;
      };
    };
    nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    obs-studio = {};
    password-store = {};
    pidgin = {
      enable = true;
      plugins = [];
    };
    prismlauncher = {
      enable = true;
      extraPackages = [];
      settings = {};
      themes = {};
    };
    obsidian = {
      enable = true;
      cli.enable = true;
      defaultSettings = {
        corePlugins = {
          backlink = {
            enable = true;
          };
          bases = {};
          bookmarks = {};
          canvas = {};
          command-palette = {};
          daily-notes = {};
          file-explorer = {};
          file-recovery = {};
          graph = {};
          note-composer = {};
          outgoing-link = {};
          outline = {};
          page-preview = {};
          properties = {};
          switcher = {};
          global-search = {};
          tag-pane = {};
          templates = {};
          word-count = {};
        };
        themes  = {};
      };
      vaults = {};
    };
    qalculate = {
      enable = true;
      settings = {};
    };
    radio-cli = {
      enable = true;
      settings = {};
    };
    rclone = {
      enable = true;
      remotes = {};
    };
    retroarch = {
      enable = true;
      cores = {
        mgba = {
          enable = true;
        };
      };
      settings = {};
    };
    ripgrep = {
      enable = true;
      arguments = [];
    };
    ripgrep-all = {
      enable = true;
    };
  };
  services = {
    hyprpolkitagent.enable = true;
    udiskie = {
      enable = true;
      settings = {
        program_options = {
          file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
        };
      };
    };
    cliphist = {
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
    hypridle.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "/home/sametaor/Music";
      network.startWhenNeeded = true;
      extraConfig = ''
        bind_to_address "/tmp/mpd_socket"
        audio_output {
            type "pipewire"
            name "My PipeWire Output"
        }
        audio_output {
            type "fifo"
            name "mpd_fifo"
            path "/tmp/mpd.fifo"
            format "48100:16:2"
        }
      '';
    };
    mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };
    mpd-discord-rpc = {
      enable = true;
      settings = {
        format = {
          details = "$title";
          state = "$album";
          timestamp = "both";
          large_text = "$artist";
          small_text = "I use rmpc + mpd btw";
          display_type = "state";
          button1_text = "";
          button1_link = "";
          button2_text = "";
          button2_link = "";
        };
      };
    };
    hyprlauncher.enable = true;
    mpris-proxy.enable = true;
    easyeffects = {
      enable = true;
      extraPresets = {
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
      preset = "Bass Enhancing + Perfect EQ - Low Latency";
    };
  };
}
