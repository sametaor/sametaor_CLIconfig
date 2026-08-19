# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  nur = pkgs.nur.repos;
  kdenlive-nvenc = pkgs.symlinkJoin {
    name = "kdenlive-nvenc-fixed";
    paths = [ pkgs.kdePackages.kdenlive ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/kdenlive \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib" \
        --set QT_QPA_PLATFORMTHEME "xdgdesktopportal"

      wrapProgram $out/bin/kdenlive_render \
        --prefix LD_LIBRARY_PATH : "/run/opengl-driver/lib"
    '';
  };
in
{
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
    inputs.nur.overlays.default
    (final: prev: {
      # Make nvidiaWrap available globally
      nvidiaWrap =
        pkg:
        final.symlinkJoin {
          name = "nvidia-${pkg.name}";
          paths = [ pkg ];
          nativeBuildInputs = [ final.makeBinaryWrapper ];
          postBuild = ''
            if [ -d "$out/bin" ]; then
              rm -rf $out/bin
              mkdir -p $out/bin
              for binary_path in ${pkg}/bin/*; do
                if [ -f "$binary_path" ] || [ -L "$binary_path" ]; then
                  makeWrapper "$binary_path" "$out/bin/$(basename "$binary_path")" \
                    --set __NV_PRIME_RENDER_OFFLOAD 1 \
                    --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
                    --set __GLX_VENDOR_LIBRARY_NAME nvidia \
                    --set __VK_LAYER_NV_optimus NVIDIA_only
                fi
              done
            fi

            if [ -d "$out/share/applications" ]; then
              rm -rf $out/share/applications
              mkdir -p $out/share/applications

              cp -r ${pkg}/share/applications/* $out/share/applications/
              chmod -R +w $out/share/applications

              for desktop in $out/share/applications/*.desktop; do
                if [ -f "$desktop" ]; then
                  substituteInPlace "$desktop" --replace "Exec=" "Exec=nvidia-offload "
                  substituteInPlace "$desktop" --replace "%u" "%U"  --replace "X-MultipleArgs=false" ""
                fi
              done
            fi
          '';
        };

      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (pythonFinal: pythonPrev: {
          click-threading = pythonPrev.click-threading.overridePythonAttrs (oldAttrs: {
            doCheck = false;
          });
        })
      ];
    })
  ];
  imports = [
    ./hardware-configuration.nix
    ./alg-rgb.nix
    ./rclone.nix
    ./cachix.nix
    inputs.nixcord.nixosModules.nixcord
  ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "en_IN/UTF-8" ];
  };
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
    vmware.host.enable = true;
  };
  boot = {
    enableContainers = true;
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        edk2-uefi-shell.enable = true;
        memtest86.enable = true;
        netbootxyz.enable = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    extraModprobeConfig = ''
      		options kvm_intel nested=1
      		options kvm_intel emulate_invalid_guest_state=0
      		options kvm ignore_msrs=1
      	'';
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    initrd = {
      allowMissingModules = false;
      verbose = false;
    };
    plymouth = {
      enable = true;
      theme = "hexagon_dots_alt";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [
            "hexagon_dots_alt"
          ];
        })
      ];
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_level=3"
      "i915.force_probe=46a3"
    ];
    tmp.cleanOnBoot = true;
    zswap = {
      enable = true;
      compressor = "zstd";
    };
    supportedFilesystems = [
      "btrfs"
      "fuse"
      "nfs"
    ];
  };
  console = {
    colors = [
      "283034"
      "F972AB"
      "72f1b8"
      "fcef52"
      "6d77b3"
      "ff2afc"
      "f6037d"
      "d9e0e9"
      "435056"
      "f88414"
      "72f1b8"
      "fff951"
      "41DEF4"
      "f93aa1"
      "E32B9F"
      "F4f6f9"
    ];
    font = "cybercafe.fnt";
  };
  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/5debb1a3-de12-4bf7-8cfb-17b3aa78106e";
    fsType = "btrfs";
    options = [
      "subvol=data"
      "compress=zstd:1"
      "noatime"
      "nofail"
    ];
  };
  networking = {
    hostName = "nixsametaor";
    networkmanager = {
      enable = true;
      dns = "none";
    };
    useDHCP = false;
    dhcpcd.enable = false;
    defaultGateway = "192.168.1.1";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
  documentation = {
    enable = true;
    doc.enable = true;
    info.enable = true;
    dev.enable = true;
    man = {
      enable = true;
      cache.enable = false;
    };
    nixos.includeAllModules = false;
  };
  fonts = {
    packages = with pkgs; [
      noto-fonts-lgc-plus
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      nerd-fonts.symbols-only
      (iosevka.override {
        set = "SciFi";
        privateBuildPlan = ''
          [buildPlans.IosevkaSciFi]
          family = "Iosevka SciFi"
          spacing = "normal"
          serifs = "sans"
          noCvSs = false
          exportGlyphNames = true

            [buildPlans.IosevkaSciFi.variants]
            inherits = "ss08"

              [buildPlans.IosevkaSciFi.variants.design]
              one = "no-base"
              two = "straight-neck-serifless"
              three = "flat-top-serifless"
              four = "open-non-crossing-serifless"
              five = "upright-flat-hook-serifless"
              six = "straight-bar"
              seven = "straight-serifless-crossbar"
              eight = "crossing"
              nine = "straight-bar"
              zero = "diamond-long-dotted"
              capital-a = "straight-serifless"
              capital-b = "standard-interrupted-serifless"
              capital-c = "serifless"
              capital-g = "flat-bottom-inward-serifed-hookless"
              capital-h = "serifless"
              capital-i = "short-serifed"
              capital-j = "flat-hook-serifed"
              capital-k = "symmetric-connected-serifless"
              capital-m = "hanging-serifless"
              capital-n = "standard-serifless"
              capital-p = "open-serifless"
              capital-q = "crossing"
              capital-r = "straight-open-serifless"
              capital-u = "flat-bottom-serifless"
              capital-v = "straight-serifless"
              capital-w = "straight-vertical-sides-serifless"
              capital-x = "straight-serifless"
              capital-y = "straight-serifless"
              capital-z = "straight-serifless"
              a = "single-storey-flat-top-serifless"
              b = "flat-bottom-serifless"
              d = "flat-bottom-serifless"
              f = "flat-hook-serifless-crossbar-at-half-ascender-height"
              g = "single-storey-flat-top-serifless"
              i = "hooky-bottom"
              j = "flat-hook-serifless"
              k = "symmetric-connected-serifless"
              l = "hooky-bottom"
              m = "flat-top-short-leg-serifless"
              n = "flat-top-straight-serifless"
              p = "flat-top-serifless"
              q = "flat-top-straight-serifless"
              r = "flat-top-serifless"
              t = "hookless"
              u = "flat-bottom-serifless"
              v = "straight-serifless"
              w = "straight-vertical-sides-serifless"
              x = "straight-serifless"
              y = "straight-serifless"
              z = "straight-serifless"
              capital-eszet = "corner-serifless"
              long-s = "flat-hook-descending-middle-serifed-half-ascender"
              eszet = "longs-s-lig-serifless"
              capital-thorn = "serifless"
              lower-alpha = "crossing"
              capital-delta = "straight"
              lower-eta = "flat-top-serifless"
              lower-iota = "semi-tailed"
              lower-kappa = "symmetric-connected-serifless"
              capital-lambda = "straight-serifless"
              lower-lambda = "straight"
              lower-mu = "flat-bottom-serifless"
              lower-pi = "small-capital"
              lower-tau = "tailless"
              lower-upsilon = "casual-serifless"
              lower-phi = "straight"
              cyrl-a = "single-storey-flat-top-serifless"
              cyrl-capital-zhe = "straight"
              cyrl-zhe = "straight"
              cyrl-capital-ka = "symmetric-connected-serifless"
              cyrl-ka = "symmetric-connected-serifless"
              cyrl-em = "hanging-serifless"
              cyrl-capital-er = "open-serifless"
              cyrl-er = "flat-top-serifless"
              cyrl-capital-u = "straight-serifless"
              cyrl-u = "straight-serifless"
              cyrl-ef = "split-serifless"
              cyrl-capital-ya = "straight-serifless"
              cyrl-ya = "straight-open-serifless"
              tittle = "square"
              diacritic-dot = "square"
              punctuation-dot = "square"
              braille-dot = "square"
              ellipsis-density = "normal"
              tilde = "low"
              asterisk = "turn-hex-mid"
              underscore = "high"
              caret = "high"
              ascii-grave = "straight"
              ascii-single-quote = "straight"
              paren = "flat-arc"
              guillemet = "straight"
              number-sign = "slanted-open-tall"
              at = "fourfold-solid-inner"
              dollar = "through"
              cent = "through"
              percent = "rings-segmented-slash"
              question = "corner-flat-hooked"
              pilcrow = "low"
              micro-sign = "flat-bottom-serifless"
              decorative-angle-brackets = "tall"
              lig-neq = "slightly-slanted"
              lig-equal-chain = "without-notch"
              lig-hyphen-chain = "without-notch"
              lig-plus-chain = "without-notch"
              lig-double-arrow-bar = "without-notch"
              lig-single-arrow-bar = "without-notch"

            [buildPlans.IosevkaSciFi.ligations]
            inherits = "dlig"

          [buildPlans.IosevkaSciFi.weights.Regular]
          shape = 400
          menu = 400
          css = 400

          [buildPlans.IosevkaSciFi.weights.Bold]
          shape = 700
          menu = 700
          css = 700

          # --- RESTORED BLOCKS FOR WIDE VARIANT & ITALICS ---

          [buildPlans.IosevkaSciFi.slopes.Upright]
          angle = 0
          shape = "upright"
          menu = "upright"
          css = "normal"

          [buildPlans.IosevkaSciFi.slopes.Italic]
          angle = 9.4
          shape = "italic"
          menu = "italic"
          css = "italic"

          [buildPlans.IosevkaSciFi.widths.Extended]
          shape = 600
          menu = 7
          css = "expanded"
        '';
      })
    ];
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
  };
  xdg.portal = {
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = "gtk";
      hyprland.preferred = [
        "hyprland"
        "gtk"
      ];
    };
  };
  hardware = {
    alsa.enablePersistence = true;
    acpilight.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General.Experimental = true;
      };
    };
    enableAllFirmware = true;
    enableAllHardware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vpl-gpu-rt
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
    nvidia-container-toolkit.enable = true;
    nvidia-container-toolkit.suppressNvidiaDriverAssertion = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        finegrained = true;
      };
      nvidiaSettings = true;
    };
    sensor.iio.enable = true;
  };
  nix = {
    nixPath = [
      "nixos-config=/home/sametaor/Projects/github/sametaor_CLIconfig/linux/NixOS/home/sametaor/.config/nixos/configuration.nix"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      max-jobs = 8;
      max-substitution-jobs = 100;
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://cache.flox.dev"
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
  };

  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };
  services = {
    kmscon = {
      enable = true;
      config = {
        font-name = "Iosevka SciFi Extended, Symbols Nerd Font";
        font-size = 20;
        font-engine = "pango";
        hwaccel = true;
        term = "xterm-256color";
        drm = true;
        fbdev = true;
        listen = true;
      };
    };
    gnome.gnome-keyring.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
    udisks2.enable = true;
    thermald.enable = true;
    logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      HandleLidSwitchDocked = "ignore";
    };
    mpd = {
      settings = {
        audio_output = [
          {
            type = "pipewire";
            name = "My PipeWire Output";
          }
        ];
      };
      user = "sametaor";
    };
    xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    ipp-usb.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      wayland.compositor = "kwin";
      setupScript = ''
        			${pkgs.xrdb}/bin/xrdb -merge - <<EOF
        			Xcursor.theme: Breeze_Hacked
        			Xcursor.size: 24
        			EOF
        		'';
      settings.Theme = {
        CursorTheme = "Breeze_Hacked";
        CursorSize = 24;
      };
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    libinput.enable = true;
    openssh.enable = true;
    fstrim.enable = true;
    clipmenu.enable = true;
    colord.enable = true;
    flatpak.enable = true;
    power-profiles-daemon.enable = true;
    weechat.enable = true;
    playerctld.enable = true;
  };

  users = {
    users.sametaor = {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
        "aria2"
        "scanner"
        "lpadmin"
        "lp"
        "gamemode"
        "libvirtd"
        "kvm"
        "dialout"
        "uucp"
        "podman"
      ];
      packages = with pkgs; [
        tree
      ];
    };
  };

  programs = {
    nixcord = {
      enable = true;
      user = "sametaor";
      discord = {
        equicord.enable = true;
        branches = [ "canary" ];
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
          "--ignore-gpu-blocklist"
          "--enable-gpu-rasterization"
          "--enable-zero-copy"
        ];
        krisp.enable = true;
      };
      config = {
        autoUpdate = true;
        enableReactDevtools = true;
        transparent = true;
        useQuickCss = true;
        enabledThemeLinks = [
          "https://mixter213.github.io/Discord/Code/MixPack.css"
        ];
        frameless = true;
        plugins = {
          characterCounter.enable = true;
          dearrow.enable = true;
          fixImagesQuality.enable = true;
          roleColorEverywhere = {
            enable = true;
            colorChatMessages = true;
          };
          shikiCodeblocks = {
            enable = true;
            theme = "https://cdn.jsdelivr.net/gh/shikijs/textmate-grammars-themes@bc5436518111d87ea58eb56d97b3f9bec30e6b83/packages/tm-themes/themes/synthwave-84.json";
            useDevIcon = "COLOR";
          };
          showConnections.enable = true;
          tenorGifSearch.enable = true;
          webKeybinds.enable = true;
          webContextMenus.enable = true;
          webRichPresence.enable = true;
          youtubeAdblock.enable = true;
          bannersEverywhere = {
            enable = true;
            animate = true;
          };
          betterAudioPlayer = {
            enable = true;
            oscilloscope = true;
          };
          blurNsfw.enable = true;
          channelTabs = {
            enable = true;
            onStartup = "remember";
            showTabNumbers = true;
            switchToExistingTab = true;
            tabBarPosition = "bottom";
          };
          collapsibleUi = {
            enable = true;
            channelListCollapsed = true;
            chatButtonsCollapsed = true;
            guildBarCollapsed = true;
            headerBarCollapsed = true;
            membersListCollapsed = true;
            titleBarCollapsed = true;
            userAreaCollapsed = true;
          };
          customSounds = {
            enable = true;
          };
          fakeNitro.enable = true;
          favouriteAnything.enable = true;
          fixFileExtensions.enable = true;
          fixYoutubeEmbeds.enable = true;
          globalBadges.enable = true;
          imageFilename.enable = true;
          musicControls = {
            enable = true;
            hoverControls = true;
            lyricsConversion = "Romanized";
          };
          noOnboardingDelay.enable = true;
          platformIndicators.enable = true;
          splitLargeMessages.enable = true;
          typingIndicator.enable = true;
          typingTweaks.enable = true;
          whoReacted = {
            enable = true;
            avatarClick = true;
          };
          zipPreview.enable = true;
        };
      };
    };
    dconf.enable = true;
    nix-ld.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    niri = {
      enable = true;
      package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
    uwsm.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;
    dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
    };
    git.enable = true;
    bash = {
      completion.enable = true;
      enable = true;
    };
    bat.enable = true;
    command-not-found.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
    ente-auth.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        			set fish_greeting
        		'';
    };
    fzf.fuzzyCompletion = true;
    fuse.userAllowOther = true;
    gamescope.enable = true;
    gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
    };
    kdeconnect.enable = true;
    lazygit.enable = true;
    less.enable = true;
    localsend.enable = true;
    nano.enable = false;
    neovim.defaultEditor = true;
    nvf = {
      enable = true;
      settings = {
        vim = {
          assistant = {
            copilot = {
              enable = true;
              cmp.enable = false;
            };
          };
          autocomplete = {
            blink-cmp = {
              enable = true;
              friendly-snippets.enable = true;
              setupOpts = {
                fuzzy.implementation = "prefer_rust";
                sources = {
                  default = [
                    "lsp"
                    "path"
                    "snippets"
                    "buffer"
                    "copilot"
                  ];
                  providers = {
                    copilot = {
                      name = "copilot";
                      module = "blink-cmp-copilot";
                      score_offset = 100;
                      async = true;
                    };
                  };
                };
              };
            };
          };
          autopairs.nvim-autopairs.enable = true;
          bell = "visual";
          binds = {
            cheatsheet.enable = true;
            whichKey = {
              enable = true;
              setupOpts = {
                win.border = "single";
                preset = "helix";
              };
            };
          };
          clipboard = {
            enable = true;
            providers = {
              wl-copy.enable = true;
            };
            registers = "unnamedplus";
          };
          extraPlugins = {
            "fluoromachine.nvim" = {
              package = pkgs.vimUtils.buildVimPlugin {
                name = "fluoromachine.nvim";
                src = pkgs.fetchFromGitHub {
                  owner = "maxmx03";
                  repo = "fluoromachine.nvim";
                  rev = "main";
                  sha256 = "sha256-alZBQYmo9jrsKYTL7dnObaP2op4SMQQRiEZBdhxUZiI=";
                };
              };
            };
            "blink-cmp-copilot" = {
              package = pkgs.vimUtils.buildVimPlugin {
                name = "blink-cmp-copilot";
                src = pkgs.fetchFromGitHub {
                  owner = "giuxtaposition";
                  repo = "blink-cmp-copilot";
                  rev = "main";
                  sha256 = "sha256-xEGAXv41UX9GUybCSzDODkhgdEd4cclBXl0k4UBmFbs=";
                };
                doCheck = false;
              };
            };
            "dropbar.nvim" = {
              package = pkgs.vimPlugins.dropbar-nvim;
            };
            "dashboard-nvim" = {
              package = pkgs.vimPlugins.dashboard-nvim;
            };
          };
          filetree.neo-tree = {
            enable = true;
            setupOpts = {
              auto_clean_after_session_restore = true;
              enable_cursor_hijack = true;
              git_status_async = true;
            };
          };
          formatter.conform-nvim = {
            enable = true;
            presets = {
              clang-format.enable = true;
              dockerfmt.enable = true;
              fish-indent.enable = true;
              indent.enable = true;
              jsonfmt.enable = true;
              latexindent.enable = true;
              mdformat.enable = true;
              nixfmt-rs.enable = true;
              prettier.enable = true;
              qmlformat.enable = true;
              rustfmt.enable = true;
              shfmt.enable = true;
              styler.enable = true;
              stylua.enable = true;
            };
          };
          fzf-lua = {
            enable = true;
            setupOpts.winopts.border = "single";
          };
          gestures.gesture-nvim.enable = true;
          git = {
            enable = true;
            gitsigns.enable = true;
            neogit.enable = true;
          };
          keymaps = [
            {
              key = "<leader>e";
              mode = "n";
              action = "<cmd>Neotree toggle<CR>";
              silent = true;
              desc = "Toggle Neo-tree File Explorer";
            }
          ];
          languages = {
            bash.enable = true;
            clang.enable = true;
            cmake.enable = true;
            csharp.enable = true;
            css.enable = true;
            docker.enable = true;
            env.enable = true;
            fish.enable = true;
            glsl.enable = true;
            go.enable = true;
            html.enable = true;
            java.enable = true;
            json.enable = true;
            lua.enable = true;
            make.enable = true;
            markdown.enable = true;
            nix = {
              enable = true;
              lsp.servers = [ "nixd" ];
            };
            nu.enable = true;
            python.enable = true;
            qml.enable = true;
            rust.enable = true;
            toml.enable = true;
            xml.enable = true;
            yaml.enable = true;
          };
          lsp = {
            enable = true;
            formatOnSave = true;
            inlayHints.enable = true;
            lspkind = {
              enable = true;
              setupOpts = "symbol_text";
            };
            presets = {
              bash-language-server.enable = true;
              clangd.enable = true;
              csharp_ls.enable = true;
              docker-language-server.enable = true;
              fish-lsp.enable = true;
              glsl_analyzer.enable = true;
              harper.enable = true;
              lua-language-server.enable = true;
              markdown-oxide.enable = true;
              nixd.enable = true;
              nushell.enable = true;
              python-lsp-server.enable = true;
              qmlls.enable = true;
              rust-analyzer.enable = true;
              vscode-css-language-server.enable = true;
              vscode-json-language-server.enable = true;
              yaml-language-server.enable = true;
            };
            trouble.enable = true;
          };
          luaConfigRC = {
            fluoromachine = inputs.nvf.lib.nvim.dag.entryAnywhere ''
              require("fluoromachine").setup({
                      glow = true,
                      theme = "fluoromachine",
                      transparent = true,
                      brightness = 0.1,
              })
              vim.cmd.colorscheme("fluoromachine")
            '';
            dropbar = inputs.nvf.lib.nvim.dag.entryAnywhere ''
              require("dropbar").setup({})
            '';
            dashboard = inputs.nvf.lib.nvim.dag.entryAnywhere ''
              local dashboard = require("dashboard")
              dashboard.setup({
                      theme = 'hyper',
                      disable_move = true,
                      shortcut_type = "number",
                      buffer_name = "SaVim",
                      shuffle_letter = false,
                      change_to_vcs_root = false,
                      config = {
                              shortcut = {
                                      { desc = "󰊳 Health", group = "@property", action = "checkhealth", key = "u" },
                                      { desc = " New", group = "Label", action = "ene | startinsert", key = "n" },
                                      {
                                              desc = "  Config",
                                              group = "Constant",
                                              action = "FzfLua files cwd=/etc/nixos",
                                              key = "c",
                                      },
                                      {
                                              desc = "󰁯 Resume",
                                              group = "@comment.info",
                                              action = 'lua require("persistence").load()',
                                              key = "s",
                                      },
                                      { desc = "󰒲  Search", group = "@character.special", action = "FzfLua builtin", key = "l" },
                                      { desc = "  LSP Info", group = "@comment.warning", action = "LspInfo", key = "m" },
                                      { desc = "󰿅 Quit", group = "@comment.error", action = "qa", key = "q" },
                              },
                              ehader = {},
                              week_header = { enable = false },
                              packages = { enable = true },
                              project = { enable = true, limit = 5, icon = " ", label = "Projects", action = "FzfLua files cwd=" },
                              mru = { limit = 10, icon = " ", label = "Recently Opened", cwd_only = false },
                              footer = {
                                      [[]],
                                      [[Powered by  NeoVim]],
                                      [[]],
                                      [[╰╼━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 󰫆 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╾╯]],
                              },
                      },
                      hide = {
                              statusline = false,
                              tabline = true,
                              winbar = true,
                      },
                      preview = {
                              command = "${./ascii.sh} -c",
                              file_path = "${./ascii.sh}",
                              file_height = 16,
                              file_width = 90,
                      },
              })
            '';
          };
          mini = {
            move.enable = true;
            map.enable = true;
          };
          navigation = {
            harpoon = {
              enable = true;
              setupOpts.defaults = {
                save_on_toggle = true;
                sync_on_ui_close = true;
              };
            };
          };
          notes.neorg = {
            enable = true;
            setupOpts.load."core.defaults".enable = true;
            treesitter.enable = true;
          };
          notify.nvim-notify = {
            enable = true;
            setupOpts = {
              position = "bottom_right";
              render = "default";
            };
          };
          opts.wrap = false;
          presence.neocord = {
            enable = true;
            setupOpts = {
              enable_line_number = true;
              logo_tooltip = "I use NeoVim, btw";
            };
          };
          runner.run-nvim = {
            enable = true;
          };
          searchCase = "smart";
          session.persisted.enable = true;
          statusline.lualine = {
            enable = true;

          };
          syntaxHighlighting = true;
          tabline.nvimBufferline = {
            enable = true;
            setupOpts.options = {
              separator_style = "padded_slant";
              enforce_regular_tabs = true;
              indicator.style = "icon";
              numbers = "none";
            };
          };
          terminal.toggleterm = {
            enable = true;
            lazygit.enable = true;
            setupOpts = {
              direction = "float";
              enable_winbar = true;
            };
          };
          treesitter = {
            enable = true;
            addDefaultGrammars = true;
            autotagHtml = true;
            context.enable = true;
            fold = true;
            textobjects.enable = true;
          };
          ui = {
            borders = {
              enable = true;
              globalStyle = "single";
              plugins = {
                nvim-cmp = {
                  enable = true;
                  style = "single";
                };
                which-key = {
                  enable = true;
                  style = "single";
                };
              };
            };
            colorful-menu-nvim.enable = true;
            illuminate.enable = true;
            modes-nvim.enable = true;
            noice = {
              enable = true;
              setupOpts.lsp.signature.enabled = true;
            };
          };
          undoFile.enable = true;
          utility = {
            ccc = {
              enable = true;
              setupOpts = {
                alpha_show = "auto";
              };
            };
            direnv.enable = true;
            grug-far-nvim.enable = true;
            icon-picker.enable = true;
            images = {
              image-nvim = {
                enable = true;
                setupOpts.backend = "kitty";
              };
              img-clip.enable = true;
            };
            mkdir.enable = true;
            motion.precognition.enable = true;
            multicursors.enable = true;
            nix-develop.enable = true;
            nvim-biscuits.enable = true;
            oil-nvim = {
              enable = true;
              gitStatus.enable = true;
            };
            preview.glow.enable = true;
            smart-splits.enable = true;
            surround.enable = true;
            undotree.enable = true;
            vim-wakatime.enable = true;
            yanky-nvim = {
              enable = true;
              setupOpts.ring.storage = "sqlite";
            };
            yazi-nvim.enable = true;
          };
          visuals = {
            indent-blankline = {
              enable = true;
              setupOpts = {
                scope = {
                  show_start = true;
                  show_end = true;
                };
              };
            };
            nvim-cursorline = {
              enable = true;
              setupOpts = {
                cursorline.enable = true;
                cursorword.enable = true;
              };
            };
            nvim-web-devicons.enable = true;
            rainbow-delimiters.enable = true;
          };
          withNodeJs = true;
          withPython3 = true;
          withRuby = true;
        };
      };
    };
    nm-applet.enable = true;
    npm.enable = true;
    gamemode = {
      enable = true;
      settings.general.inhibit_screensaver = 0;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = (
        pkgs.millennium-steam.override {
          extraProfile = ''
            				export __NV_PRIME_RENDER_OFFLOAD=1
            				export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
            				export __GLX_VENDOR_LIBRARY_NAME=nvidia
            				export __VK_LAYER_NV_optimus=NVIDIA_only
            			'';
        }
      );
    };
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      package = (pkgs.obs-studio.override { cudaSupport = true; });
    };
    television = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
    tmux = {
      enable = true;
      clock24 = true;
      historyLimit = 50000;
      keyMode = "vi";
      newSession = true;
    };
    virt-manager.enable = true;
    whois.enable = true;
    xwayland.enable = true;
    yazi = {
      enable = true;
      plugins = with pkgs.yaziPlugins; {
        git = git;
        sudo = sudo;
        lsar = lsar;
        glow = glow;
        ouch = ouch;
        yafg = yafg;
        gvfs = gvfs;
        drag = drag;
        zoom = zoom;
        mount = mount;
        chmod = chmod;
        sshfs = sshfs;
        duckdb = duckdb;
        office = office;
        lazygit = lazygit;
        yatline = yatline;
        restore = restore;
        convert = convert;
        starship = starship;
        compress = compress;
        mediainfo = mediainfo;
        clipboard = clipboard;
        allmytoes = allmytoes;
        split-tabs = split-tabs;
        omni-trash = omni-trash;
        recycle-bin = recycle-bin;
        full-border = full-border;
        smart-filter = smart-filter;
        wl-clipboard = wl-clipboard;
        kdeconnect-send = kdeconnect-send;
        relative-motions = relative-motions;
        #nav-parent-portal = nav-parent-portal;
        yatline-created-time = yatline-created-time;
      };
      settings = {
        theme = { };
        yazi = { };
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      flags = [ "--cmd cd" ];
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      enableBashCompletion = true;
      setOptions = [
        "INC_APPEND_HISTORY_TIME"
        "HIST_LEX_WORDS"
        "HIST_REDUCE_BLANKS"
        "AUTO_CD"
        "AUTO_PUSHD"
        "PUSHD_IGNORE_DUPS"
        "INTERACTIVE_COMMENTS"
        "PROMPT_SUBST"
        "EXTENDED_GLOB"
        "NO_ERR_RETURN"
      ];
    };
  };

  appstream.enable = true;
  qt.enable = true;
  qt.platformTheme = "qt5ct";
  qt.style = "kvantum";
  systemd = {
    services = {
      NetworkManager-wait-online.enable = true;
      plymouth-wait-animation = {
        description = "Wait for Plymouth animation to complete";
        wantedBy = [ "multi-user.target" ];
        before = [ "plymouth-quit.service" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.coreutils}/bin/sleep 8";
          RemainAfterExit = true;
        };
      };
      mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.sametaor.uid}";
      };
    };
  };
  security = {
    polkit.enable = true;
    sudo = {
      enable = false;
      execWheelOnly = true;
    };
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "sametaor" ];
          keepEnv = true;
          persist = true;
        }
      ];
      wheelNeedsPassword = false;
    };
    pam = {
      loginLimits = [
        {
          domain = "sametaor";
          type = "hard";
          item = "nofile";
          value = "524288";
        }
      ];
    };
    rtkit.enable = true;
  };
  environment = {
    enableAllTerminfo = true;
    sessionVariables = rec {
      LIBVA_DRIVER_NAME = "nvidia";
      NVD_BACKEND = "direct";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      EDITOR = "nvim";
      VISUAL = "$EDITOR";
      PAGER = "less";
      LESS = "-RFiX";
      LANG = "en_US.UTF-8";
      MANPAGER = "bat -plman";
      FZF_DEFAULT_OPTS = "--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#20192b --color=hl:#6d77b3,hl+:#4adef5,info:#72f0b8,marker:#fede5d --color=prompt:#ff757f,spinner:#fede5d,pointer:#f1527e,header:#6d77b3 --color=border:#43c5fc,label:#ed70df,query:#efedfe --border='bold' --border-label='FZF' --border-label-pos='0' --preview-window='border-sharp' --padding='1' --margin='1' --prompt=' ' --marker=' ' --pointer='󰛡' --separator='─' --scrollbar='┃' --layout='reverse' --info='right' --tmux left,80% --height=80%";
    };
    shells = with pkgs; [
      pkgs.zsh
    ];
    shellAliases = {
      rebuild = "doas nixos-rebuild switch --flake ~/Projects/github/sametaor_CLIconfig/linux/NixOS/home/sametaor/.config/nixos#nixsametaor";
      sudo = "doas";
      btop = "doas nvidia-offload btop";
      dco = "docker compose";
      dcb = "docker compose build";
      dce = "docker compose exec";
      dcps = "docker compose ps";
      dcrestart = "docker compose restart";
      dcrm = "docker compose rm";
      dcr = "docker compose run";
      dcstop = "docker compose stop";
      dcup = "docker compose up";
      dcupb = "docker compose up --build";
      dcupd = "docker compose up -d";
      dcupdb = "docker compose up -d --build";
      dcdn = "docker compose down";
      dcl = "docker compose logs";
      dclf = "docker compose logs -f";
      dclF = "docker compose logs -f --tail 0";
      dcpull = "docker compose pull";
      dcstart = "docker compose start";
      dck = "docker compose kill";
      c = "clear";
      rm = "rm -ir";
      rmf = "rm -irf";
      cp = "cp -irv";
      mkd = "mkdir -ip";
      mkz = "mkdir $1 && cd $1";
      zshrc = "nvim ~/.zshrc";
      dud = "du -d 1 -h";
      duh = "du -sh";
      t = "tail -f";
      path = "echo -e \"\${PATH//:/\\\\n}\"";
      fdir = "find . -type d -name";
      ff = "find . -type f -name";
      grep = "grep --color";
      sgrep = "grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS}";
      fd = "fd | fzf";
      fzf = "fzf --preview 'bat --color=always {}' --preview-window '~3'";
      h = "history";
      hl = "history | less";
      hs = "history | grep";
      hsi = "history | grep -i";
      hgrep = "fc -El 0 | grep";
      help = "man";
      p = "ps -f";
      sortnr = "sort -n -r";
      unexport = "unset";
      H = "| head";
      T = "| tail";
      G = "| grep";
      L = "| less";
      M = "| most";
      LL = "2>&1 | less";
      CA = "2>&1 | cat -A";
      NE = "2 > /dev/null";
      NUL = "> /dev/null 2>&1";
      P = "2>&1| pygmentize -l pytb";
      ping = "prettyping";
      what = "navi --query";
      nano = "nano --modernbindings";
      ":q" = "exit";
      neo = "tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10";
      matrix = "tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10";
      lolcat = "lolcat -t";
      cat = "bat";
      zipnew = "zip -r";
      zipadd = "zip -ur";
      zipls = "unzip -l";
      zipfix = "zip -F";
      zipdel = "zip -d";
      unzipt = "unzip -t";
      zipenc = "zip -er";
      tarc = "tar -czvf";
      tart = "tar -tvf";
      astro = "astroterm -cC -s 100 -f 60 -u -m -i Delhi";
      cna = "conda activate";
      cnab = "conda activate base";
      cncf = "conda env create -f";
      cncn = "conda create -y -n";
      cnconf = "conda config";
      cncp = "conda create -y -p";
      cncr = "conda create -n";
      cncss = "conda config --show-source";
      cnde = "conda deactivate";
      cnel = "conda env list";
      cni = "conda install";
      cniy = "conda install -y";
      cnl = "conda list";
      cnle = "conda list --export";
      cnles = "conda list --explicit > spec-file.txt";
      cnr = "conda remove";
      cnrn = "conda remove -y --all -n";
      cnrp = "conda remove -y --all -p";
      cnry = "conda remove -y";
      cnsr = "conda search";
      cnu = "conda update";
      cnua = "conda update --all";
      cnuc = "conda update conda";
      l = "eza -lhF";
      la = "eza -lAhF";
      lr = "eza -RhF -L 2";
      lt = "eza -l -h -t created -F";
      ll = "eza -l";
      ldot = "eza -ld .*";
      lS = "eza -1Ss Extension -hF";
      lart = "eza -1artF";
      lrt = "eza -1rtF";
      lsr = "eza -lARhF -L 2";
      lsn = "eza -1";
      ls = "eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o";
      lsm = "eza -lbhHigUmua@ --time-style=long-iso --git --icons=always --colour=always";
      lst = "ls -T -L 2 --no-user";
      gpglk = "gpg --list-secret-key --keyid-format LONG";
      gpgep = "gpg --armor --export";
      bs = "brew search";
      bsd = "brew search --desc";
      binf = "brew info";
      bins = "brew install";
      buns = "brew uninstall";
      bcat = "brew cat";
      btap = "brew tap";
      btapinf = "brew tap-info";
      ci = "brew info --cask";
      cis = "brew install --cask";
      brewup = "brew -v update && brew -v upgrade && brew upgrade --cask && brew -v cleanup --prune=5 && brew doctor";
      bdr = "brew doctor";
      bls = "brew list";
      cus = "brew uninstall --cask";
      cuz = "brew zap --cask";
      blv = "brew leaves";
      pc = "sudo port clean --all installed";
      pi = "sudo port install";
      pli = "port livecheck installed";
      plm = "port-livecheck-maintainer";
      psu = "sudo port selfupdate";
      puni = "sudo port uninstall inactive";
      puo = "sudo port upgrade outdated";
      pup = "sudo port selfupdate && sudo port upgrade outdated";
      npmg = "npm i -g";
      npmS = "npm i -S";
      npmD = "npm i -D";
      npmF = "npm i -f";
      npmE = "PATH=\"$(npm bin):$PATH\"";
      npmO = "npm outdated";
      npmU = "npm update";
      npmV = "npm -v";
      npmL = "npm list";
      npmL0 = "npm ls --depth=0";
      npmst = "npm start";
      npmt = "npm test";
      npmR = "npm run";
      npmP = "npm publish";
      npmI = "npm init";
      npmi = "npm info";
      npmSe = "npm search";
      npmrd = "npm run dev";
      npmrb = "npm run build";
      pbl = "podman build";
      pcin = "podman container inspect";
      pcls = "podman container ls";
      pclsa = "podman container ls --all";
      pib = "podman image build";
      pii = "podman image inspect";
      pils = "podman image ls";
      pipu = "podman image push";
      pirm = "podman image rm";
      pit = "podman image tag";
      plo = "podman container logs";
      pnc = "podman network create";
      pncn = "podman network connect";
      pndcn = "podman network disconnect";
      pni = "podman network inspect";
      pnls = "podman network ls";
      pnrm = "podman network rm";
      ppo = "podman container port";
      ppu = "podman pull";
      pr = "podman container run";
      prit = "podman container run --interactive --tty";
      prm = "podman container rm";
      "prm!" = "podman container rm --force";
      pst = "podman container start";
      prs = "podman container restart";
      psta = "podman stop $(podman ps --quiet)";
      pstp = "podman container stop";
      ptop = "podman top";
      pvi = "podman volume inspect";
      pvls = "podman volume ls";
      pvprune = "podman volume prune";
      pxc = "podman container exec";
      pxcit = "podman container exec --interactive --tty";
      rsync-copy = "rsync -avz --progress -h";
      rsync-move = "rsync -avz --progress -h --remove-source-files";
      rsync-update = "rsync -avzu --progress -h";
      rsync-synchronize = "rsync -avzu --delete --progress -h";
      sgem = "sudo gem";
      rfind = "find . -name \"*.rb\" | xargs grep -n";
      rb = "ruby";
      gein = "gem install";
      geun = "gem uninstall";
      geli = "gem list";
      gei = "gem info";
      geiall = "gem info --all";
      geca = "gem cert --add";
      gecr = "gem cert --remove";
      gecb = "gem cert --build";
      geclup = "gem cleanup -n";
      gegi = "gem generate_index";
      geh = "gem help";
      gel = "gem lock";
      geo = "gem open";
      geoe = "gem open -e";
      rrun = "ruby -e";
      sv = "snap version";
      sf = "snap find";
      si = "snap install";
      sin = "snap info";
      sr = "snap remove";
      sref = "snap refresh";
      srev = "snap revert";
      sl = "snap list";
      sd = "snap disable";
      se = "snap enable";
      "sc-lsu" = "sudo systemctl list-units";
      "sc-iact" = "sudo systemctl is-active";
      "sc-status" = "sudo systemctl status";
      "sc-show" = "sudo systemctl show";
      "sc-help" = "sudo systemctl help";
      "sc-lsuf" = "sudo systemctl list-unit-files";
      "sc-ien" = "sudo systemctl is-enabled";
      "sc-lsj" = "sudo systemctl list-jobs";
      "sc-showenv" = "sudo systemctl show-environment";
      "sc-cat" = "sudo systemctl cat";
      "sc-lst" = "sudo systemctl list-timers";
      "sc-start" = "sudo systemctl start";
      "sc-stop" = "sudo systemctl stop";
      "sc-reload" = "sudo systemctl reload";
      "sc-restart" = "sudo systemctl restart";
      "sc-trystart" = "sudo systemctl try-restart";
      "sc-iso" = "sudo systemctl isolate";
      "sc-kill" = "sudo systemctl kill";
      "sc-repass" = "sudo systemctl reset-failed";
      "sc-en" = "sudo systemctl enable";
      "sc-dis" = "sudo systemctl disable";
      "sc-reen" = "sudo systemctl reenable";
      "sc-pre" = "sudo systemctl preset";
      "sc-mask" = "sudo systemctl mask";
      "sc-unmask" = "sudo systemctl unmask";
      "sc-link" = "sudo systemctl link";
      "sc-load" = "sudo systemctl load";
      "sc-cancel" = "sudo systemctl cancel";
      "sc-setenv" = "sudo systemctl set-environment";
      "sc-unsetenv" = "sudo systemctl unset-environment";
      "sc-edit" = "sudo systemctl edit";
      "sc-ennow" = "sudo systemctl enable --now";
      "sc-disnow" = "sudo systemctl disable --now";
      "sc-masknow" = "sudo systemctl mask --now";
      txs = "tmuxinator start";
      txo = "tmuxinator open";
      txn = "tmuxinator new";
      txl = "tmuxinator list";
      vscy = "codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland";
      vsc = "codium";
      vsca = "vsc --add";
      vscd = "vsc --diff";
      vscg = "vsc --goto";
      vscn = "vsc --new-window";
      vscr = "vsc --reuse-window";
      vscw = "vsc --wait";
      vscu = "vsc --user-data-dir";
      vscp = "vsc --profile";
      vsced = "vsc --extensions-dir";
      vscie = "vsc --install-extension";
      vscue = "vsc --uninstall-extension";
      vscv = "vsc --verbose";
      vscl = "vsc --log";
      vscde = "vsc --disable-extensions";
      ytnpl = "yt-dlp --no-playlist --restrict-filenames";
      ytp = "ytnpl --write-subs --write-auto-subs --format 244+299";
      ytpp = "ytnpl --write-subs --write-auto-subs --format 247+299";
      yts = "ytnpl --write-subs --write-auto-subs --format worstaudio --extract-audio";
      ytm = "ytnpl --format bestaudio --extract-audio";
    };
    systemPackages =
      with pkgs;
      [
        _2048-in-terminal
        _7zip-zstd-rar
        _7zz-rar
        adb-sync
        adbfs-rootless
        adbtuifm
        adi1090x-plymouth-themes
        aerc
        andcli
        android-tools
        ani-cli
        archisteamfarm
        aria2
        ascii-image-converter
        aseprite
        assetripper
        astroterm
        bagels
        basalt
        bash-language-server
        bash-preexec
        bat-extras.batgrep
        bat-extras.batman
        bat-extras.batpipe
        bat-extras.core
        bat-extras.prettybat
        inputs.blender-bin.packages.x86_64-linux.default
        bluetui
        bluez
        bluez-headers
        bluez-tools
        browsh
        breeze-hacked-cursor-theme
        (btop-cuda.override {
          cudaSupport = true;
        })
        btrfs-assistant
        btrfs-list
        btrfs-progs
        buku
        bzip2
        bzip3
        cachix
        calibre-no-speech
        candy-icons
        cargo
        cargo-binstall
        cava
        cbonsai
        chawan
        chess-tui
        clang
        cmake
        cmatrix
        compsize
        corefonts
        coreutils-full
        cowsay
        cpu-x
        cpufetch
        crates-tui
        crowdin-cli
        cudatoolkit
        cups-pdf-to-pdf
        curlFull
        dateutils
        direnv
        dnsmasq
        docker
        docker-compose
        kdePackages.qtsvg
        kdePackages.kio
        kdePackages.kio-fuse
        kdePackages.kio-extras
        kdePackages.dolphin
        kdePackages.ark
        kdePackages.qt6ct
        dosfstools
        dotnet-runtime
        doxx
        duckdb
        dust
        efibooteditor
        efibootmgr
        eget
        electron
        ente-auth
        ente-cli
        exiftool
        eza
        fastfetch
        fclones
        ((pkgs.ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: {
          doCheck = false;
        }))
        figlet
        figma-linux
        fish-lsp
        fontforge-gtk
        fontforge-fonttools
        font-manager
        fuse3
        fuzzel
        fzf
        gcc
        gh
        gh-eco
        ghgrab
        gimp-with-plugins
        glava
        glaze
        glibc
        go
        goldberg-emu
        google-play
        gpg-tui
        gpgmepp
        (gpufetch.override {
          cudaSupport = true;
        })
        grub2
        guestfs-tools
        gzip
        harfbuzzFull
        (heroic.override {
          extraPkgs =
            pkgs': with pkgs'; [
              gamescope
              gamemode
            ];
        })
        hexyl
        hollywood
        hunspell
        hunspellDicts.en-us-large
        hwinfo
        hydroxide
        hyphenDicts.en_GB
        hyphenDicts.en_IN
        hypridle
        hyprland-workspaces-tui
        hyprlauncher
        hyprlock
        hyprshade
        hyprsunset
        inkscape-with-extensions
        jackett
        jamesdsp
        jq
        jre
        karere
        kdenlive-nvenc
        lazydocker
        libisoburn
        libreoffice-qt-fresh
        lmms-full
        lmstudio
        lolcat
        lua
        luarocks-nix
        lucida-downloader
        ludusavi
        lutris
        matcha
        mediainfo
        megacmd
        megasync
        microsoft-edge
        mpd-discord-rpc
        mpvpaper
        mtools
        navi
        nbfc-linux
        nchat
        nethack
        ninja
        nix-bash-completions
        nix-top
        nix-zsh-completions
        nixfmt
        nixos-artwork.wallpapers.binary-blue
        nvitop
        nvtopPackages.full
        obsidian
        oh-my-posh
        onedrivegui
        ookla-speedtest
        ouch
        OVMF
        p7zip
        pandoc
        pear-desktop
        perl
        playerctl
        poppler
        poppler-utils
        poppler_data
        prettyping
        (prismlauncher.override {
          jdks = with pkgs; [
            jdk25
            jdk17
            jdk21
            jdk8
            jdk
          ];
          gamemodeSupport = true;
        })
        protonup-qt
        proton-vpn
        proton-vpn-cli
        pwvucontrol
        python3
        python3Packages.aiowinreg
        qalculate-qt
        qbittorrent
        qdirstat
        qemu_kvm
        quickshell
        ramfetch
        rclone
        readest
        ripgrep
        ripgrep-all
        rsync
        ruby
        searchix
        searxng
        shellcheck
        smartmontools
        speedtest-rs
        sshfs
        steam-art-manager
        steamtinkerlaunch
        stremio-linux-shell
        systemctl-tui
        tailscale
        tealdeer
        telegram-desktop
        tenacity
        tenki
        tg
        toilet
        trash-cli
        tre
        tuios
        tuisky
        tuxpaint
        (ueberzugpp.override {
          cudaSupport = true;
        })
        up
        uv
        ventoy-full
        virt-viewer
        virtiofsd
        vista-fonts
        vitetris
        vlc
        vt-cli
        wakatime-cli
        wiki-tui
        wikiman
        winboat
        winetricks
        wineWow64Packages.waylandFull
        wget
        wl-clipboard
        wtfutil
        x264
        x265
        xwayland-satellite
        yt-dlp
        zoom-us
        inputs.ani2hyprtui.packages."${pkgs.stdenv.hostPlatform.system}".default
      ]
      ++ (map (pkgs.nvidiaWrap) [
        mesa-demos
      ])
      ++ [
        nur.mic92.hello-nur
      ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "electron-40.10.5"
      "ventoy-1.1.12"
    ];
  };

  system = {
    stateVersion = "26.05";
    userActivationScripts.zshrc = "touch .zshrc";
    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "--commit-lock-file"
        "-L"
      ];
      runGarbageCollection = true;
      operation = "switch";
    };
  };
}
