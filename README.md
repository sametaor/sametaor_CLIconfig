# sametaor_CLIconfig
(The content below has been written by perplexity's assistant, future rectification and further commits will follow. Stay tuned!)
This repository serves as a unified, version-controlled collection of **dotfiles and environment configuration scripts** for a variety of operating systems and platforms. Its primary goal is to **streamline the process of setting up a personalized, consistent, and productivity-focused user shell/CLI experience** across:
- **Linux**
- **Windows**
- (*Future support*) **macOS**
- (*Planned*) **Android**

## Purpose
- **Centralized management:** Keep all sorts of CLI and environment configs in one place for backup, syncing, and migration.
- **Cross-platform productivity:** Port finely-tuned environment, aliases, functions, and tool preferences to any supported OS.
- **Rapid onboarding:** New or freshly-installed systems can be brought up to speed fast, reducing setup friction and human error.

## Repository Structure
```
sametaor_CLIconfig/
├── .gitignore
├── LICENSE
├── README.md
├── linux
│   ├── .bashrc
│   └── .config
│       ├── btop
│       ├── doom
│       ├── fastfetch
│       ├── ghostty
│       ├── hypr
│       ├── jamesdsp
│       ├── kitty
│       ├── kwinrc
│       ├── nvim
│       ├── rmpc
│       ├── systemd
│       ├── tmux
│       ├── yazi
│       └── zsh
├── misc
│   ├── Deus_Ex_Mankind_Divided_Background_Titan_Wave.jpg
│   ├── HyprBibataModernClassicSVG.tar.gz
│   ├── Scripts
│   │   ├── DynWalls
│   │   └── Utils
│   ├── Windows_3D_Emoji_14+15.ttf
│   ├── ascii-neovim-logos.txt
│   ├── cava.sh
│   ├── sametaor.omp.json
│   ├── spicetify_lucid_theme_settings.json
│   ├── titan_aug.mp4
│   └── zen-themes-export.json
└── windows
    ├── HyperV_on_HomeEdition.bat
    ├── Microsoft.PowerShell_profile.ps1
    ├── Virt_machines
    │   └── VMWare
    ├── Windhawk mod configs
    │   ├── Slick_Window_Arrangement.yaml
    │   ├── Taskbar_Button_Scroll.yaml
    │   ├── Taskbar_Clock_Customization.yaml
    │   ├── Taskbar_Volume_Control.yaml
    │   ├── Taskbar_Wheel_Cycle.yaml
    │   ├── Taskbar_tray_icon_spacing_and_grid.yaml
    │   ├── Translucent_Windows.yaml
    │   ├── Win11_File_Explorer_Styler.yaml
    │   ├── Windows_11_Notification_Center_Styler.yaml
    │   ├── Windows_11_Start_Menu_Styler.yaml
    │   └── Windows_11_Taskbar_Styler.yaml
    ├── Windows_7x11.png
    ├── Windows_7x11ALT.png
    ├── Windows_7x11ALT_lockscr.png
    ├── autounattend.xml
    ├── post_install_steps.ps1
    ├── regconfig.reg
    ├── startlayout.json
    ├── unattend.iso
    ├── wingetinstall.json
    └── winutilconfig.json
```

<details>
<summary><strong>👀 Wanna view the whole structure?</strong></summary>

```
sametaor_CLIconfig/
├── .gitignore                                                         ├── LICENSE
├── README.md                                                          ├── linux
│   ├── .bashrc
│   └── .config
│       ├── btop
│       │   └── btop.conf
│       ├── doom
│       │   ├── config.el
│       │   ├── init.el
│       │   └── packages.el
│       ├── fastfetch
│       │   ├── config.jsonc
│       │   ├── logos
│       │   │   ├── Fastfetcharch.png
│       │   │   ├── ascii
│       │   │   │   ├── README.md
│       │   │   │   ├── deus_ex
│       │   │   │   │   ├── progress-0.png.txt
│       │   │   │   │   ├── progress-1.png.txt
│       │   │   │   │   ├── progress-10.png.txt
│       │   │   │   │   ├── progress-100.png.txt
│       │   │   │   │   ├── progress-101.png.txt
│       │   │   │   │   ├── progress-102.png.txt                       │       │   │   │   │   ├── progress-103.png.txt
│       │   │   │   │   ├── progress-104.png.txt
│       │   │   │   │   ├── progress-105.png.txt
│       │   │   │   │   ├── progress-106.png.txt
│       │   │   │   │   ├── progress-107.png.txt
│       │   │   │   │   ├── progress-108.png.txt
│       │   │   │   │   ├── progress-109.png.txt
│       │   │   │   │   ├── progress-11.png.txt
│       │   │   │   │   ├── progress-110.png.txt
│       │   │   │   │   ├── progress-111.png.txt
│       │   │   │   │   ├── progress-112.png.txt
│       │   │   │   │   ├── progress-113.png.txt
│       │   │   │   │   ├── progress-114.png.txt
│       │   │   │   │   ├── progress-115.png.txt
│       │   │   │   │   ├── progress-116.png.txt                       │       │   │   │   │   ├── progress-117.png.txt
│       │   │   │   │   ├── progress-118.png.txt
│       │   │   │   │   ├── progress-119.png.txt
│       │   │   │   │   ├── progress-12.png.txt
│       │   │   │   │   ├── progress-120.png.txt
│       │   │   │   │   ├── progress-121.png.txt
│       │   │   │   │   ├── progress-122.png.txt
│       │   │   │   │   ├── progress-123.png.txt
│       │   │   │   │   ├── progress-124.png.txt
│       │   │   │   │   ├── progress-125.png.txt
│       │   │   │   │   ├── progress-126.png.txt
│       │   │   │   │   ├── progress-127.png.txt
│       │   │   │   │   ├── progress-128.png.txt
│       │   │   │   │   ├── progress-129.png.txt
│       │   │   │   │   ├── progress-13.png.txt
│       │   │   │   │   ├── progress-130.png.txt
│       │   │   │   │   ├── progress-131.png.txt
│       │   │   │   │   ├── progress-132.png.txt
│       │   │   │   │   ├── progress-133.png.txt
│       │   │   │   │   ├── progress-134.png.txt
│       │   │   │   │   ├── progress-135.png.txt
│       │   │   │   │   ├── progress-136.png.txt
│       │   │   │   │   ├── progress-137.png.txt
│       │   │   │   │   ├── progress-138.png.txt
│       │   │   │   │   ├── progress-139.png.txt                       │       │   │   │   │   ├── progress-14.png.txt
│       │   │   │   │   ├── progress-140.png.txt
│       │   │   │   │   ├── progress-141.png.txt
│       │   │   │   │   ├── progress-142.png.txt
│       │   │   │   │   ├── progress-143.png.txt
│       │   │   │   │   ├── progress-144.png.txt
│       │   │   │   │   ├── progress-145.png.txt
│       │   │   │   │   ├── progress-146.png.txt
│       │   │   │   │   ├── progress-147.png.txt
│       │   │   │   │   ├── progress-148.png.txt
│       │   │   │   │   ├── progress-149.png.txt
│       │   │   │   │   ├── progress-15.png.txt
│       │   │   │   │   ├── progress-150.png.txt
│       │   │   │   │   ├── progress-151.png.txt
│       │   │   │   │   ├── progress-152.png.txt
│       │   │   │   │   ├── progress-153.png.txt
│       │   │   │   │   ├── progress-154.png.txt
│       │   │   │   │   ├── progress-155.png.txt
│       │   │   │   │   ├── progress-156.png.txt
│       │   │   │   │   ├── progress-157.png.txt
│       │   │   │   │   ├── progress-158.png.txt
│       │   │   │   │   ├── progress-159.png.txt
│       │   │   │   │   ├── progress-16.png.txt
│       │   │   │   │   ├── progress-160.png.txt
│       │   │   │   │   ├── progress-161.png.txt
│       │   │   │   │   ├── progress-162.png.txt
│       │   │   │   │   ├── progress-163.png.txt
│       │   │   │   │   ├── progress-164.png.txt
│       │   │   │   │   ├── progress-165.png.txt
│       │   │   │   │   ├── progress-166.png.txt
│       │   │   │   │   ├── progress-167.png.txt
│       │   │   │   │   ├── progress-168.png.txt
│       │   │   │   │   ├── progress-169.png.txt
│       │   │   │   │   ├── progress-17.png.txt
│       │   │   │   │   ├── progress-170.png.txt
│       │   │   │   │   ├── progress-171.png.txt
│       │   │   │   │   ├── progress-172.png.txt
│       │   │   │   │   ├── progress-173.png.txt
│       │   │   │   │   ├── progress-174.png.txt
│       │   │   │   │   ├── progress-175.png.txt
│       │   │   │   │   ├── progress-176.png.txt
│       │   │   │   │   ├── progress-177.png.txt
│       │   │   │   │   ├── progress-178.png.txt
│       │   │   │   │   ├── progress-179.png.txt
│       │   │   │   │   ├── progress-18.png.txt
│       │   │   │   │   ├── progress-180.png.txt
│       │   │   │   │   ├── progress-181.png.txt
│       │   │   │   │   ├── progress-182.png.txt
│       │   │   │   │   ├── progress-183.png.txt
│       │   │   │   │   ├── progress-184.png.txt
│       │   │   │   │   ├── progress-185.png.txt
│       │   │   │   │   ├── progress-186.png.txt
│       │   │   │   │   ├── progress-187.png.txt
│       │   │   │   │   ├── progress-188.png.txt
│       │   │   │   │   ├── progress-189.png.txt
│       │   │   │   │   ├── progress-19.png.txt
│       │   │   │   │   ├── progress-190.png.txt
│       │   │   │   │   ├── progress-191.png.txt
│       │   │   │   │   ├── progress-192.png.txt
│       │   │   │   │   ├── progress-193.png.txt                       │       │   │   │   │   ├── progress-194.png.txt
│       │   │   │   │   ├── progress-195.png.txt
│       │   │   │   │   ├── progress-196.png.txt
│       │   │   │   │   ├── progress-197.png.txt                       │       │   │   │   │   ├── progress-198.png.txt
│       │   │   │   │   ├── progress-199.png.txt
│       │   │   │   │   ├── progress-2.png.txt                         │       │   │   │   │   ├── progress-20.png.txt
│       │   │   │   │   ├── progress-200.png.txt                       │       │   │   │   │   ├── progress-201.png.txt
│       │   │   │   │   ├── progress-202.png.txt
│       │   │   │   │   ├── progress-203.png.txt                       │       │   │   │   │   ├── progress-204.png.txt
│       │   │   │   │   ├── progress-205.png.txt                       │       │   │   │   │   ├── progress-206.png.txt
│       │   │   │   │   ├── progress-207.png.txt                       │       │   │   │   │   ├── progress-208.png.txt
│       │   │   │   │   ├── progress-209.png.txt                       │       │   │   │   │   ├── progress-21.png.txt
│       │   │   │   │   ├── progress-210.png.txt                       │       │   │   │   │   ├── progress-211.png.txt
│       │   │   │   │   ├── progress-212.png.txt                       │       │   │   │   │   ├── progress-213.png.txt
│       │   │   │   │   ├── progress-214.png.txt                       │       │   │   │   │   ├── progress-215.png.txt
│       │   │   │   │   ├── progress-216.png.txt                       │       │   │   │   │   ├── progress-217.png.txt
│       │   │   │   │   ├── progress-218.png.txt                       │       │   │   │   │   ├── progress-219.png.txt
│       │   │   │   │   ├── progress-22.png.txt
│       │   │   │   │   ├── progress-220.png.txt
│       │   │   │   │   ├── progress-221.png.txt                       │       │   │   │   │   ├── progress-222.png.txt
│       │   │   │   │   ├── progress-223.png.txt                       │       │   │   │   │   ├── progress-224.png.txt
│       │   │   │   │   ├── progress-225.png.txt                       │       │   │   │   │   ├── progress-226.png.txt
│       │   │   │   │   ├── progress-227.png.txt                       │       │   │   │   │   ├── progress-228.png.txt
│       │   │   │   │   ├── progress-229.png.txt                       │       │   │   │   │   ├── progress-23.png.txt
│       │   │   │   │   ├── progress-230.png.txt                       │       │   │   │   │   ├── progress-231.png.txt
│       │   │   │   │   ├── progress-232.png.txt                       │       │   │   │   │   ├── progress-233.png.txt
│       │   │   │   │   ├── progress-234.png.txt                       │       │   │   │   │   ├── progress-235.png.txt
│       │   │   │   │   ├── progress-236.png.txt                       │       │   │   │   │   ├── progress-237.png.txt
│       │   │   │   │   ├── progress-238.png.txt                       │       │   │   │   │   ├── progress-239.png.txt
│       │   │   │   │   ├── progress-24.png.txt                        │       │   │   │   │   ├── progress-240.png.txt
│       │   │   │   │   ├── progress-241.png.txt                       │       │   │   │   │   ├── progress-242.png.txt
│       │   │   │   │   ├── progress-243.png.txt                       │       │   │   │   │   ├── progress-244.png.txt
│       │   │   │   │   ├── progress-245.png.txt                       │       │   │   │   │   ├── progress-246.png.txt
│       │   │   │   │   ├── progress-247.png.txt                       │       │   │   │   │   ├── progress-248.png.txt
│       │   │   │   │   ├── progress-249.png.txt                       │       │   │   │   │   ├── progress-25.png.txt
│       │   │   │   │   ├── progress-250.png.txt                       │       │   │   │   │   ├── progress-251.png.txt
│       │   │   │   │   ├── progress-252.png.txt                       │       │   │   │   │   ├── progress-253.png.txt
│       │   │   │   │   ├── progress-254.png.txt                       │       │   │   │   │   ├── progress-255.png.txt
│       │   │   │   │   ├── progress-256.png.txt                       │       │   │   │   │   ├── progress-257.png.txt
│       │   │   │   │   ├── progress-258.png.txt                       │       │   │   │   │   ├── progress-259.png.txt
│       │   │   │   │   ├── progress-26.png.txt
│       │   │   │   │   ├── progress-260.png.txt
│       │   │   │   │   ├── progress-261.png.txt
│       │   │   │   │   ├── progress-262.png.txt                       │       │   │   │   │   ├── progress-263.png.txt
│       │   │   │   │   ├── progress-264.png.txt                       │       │   │   │   │   ├── progress-265.png.txt
│       │   │   │   │   ├── progress-266.png.txt
│       │   │   │   │   ├── progress-267.png.txt                       │       │   │   │   │   ├── progress-268.png.txt
│       │   │   │   │   ├── progress-269.png.txt                       │       │   │   │   │   ├── progress-27.png.txt
│       │   │   │   │   ├── progress-270.png.txt                       │       │   │   │   │   ├── progress-271.png.txt
│       │   │   │   │   ├── progress-272.png.txt
│       │   │   │   │   ├── progress-273.png.txt
│       │   │   │   │   ├── progress-274.png.txt                       │       │   │   │   │   ├── progress-275.png.txt
│       │   │   │   │   ├── progress-276.png.txt
│       │   │   │   │   ├── progress-277.png.txt                       │       │   │   │   │   ├── progress-278.png.txt
│       │   │   │   │   ├── progress-279.png.txt                       │       │   │   │   │   ├── progress-28.png.txt
│       │   │   │   │   ├── progress-280.png.txt
│       │   │   │   │   ├── progress-281.png.txt                       │       │   │   │   │   ├── progress-282.png.txt
│       │   │   │   │   ├── progress-283.png.txt                       │       │   │   │   │   ├── progress-284.png.txt
│       │   │   │   │   ├── progress-285.png.txt
│       │   │   │   │   ├── progress-286.png.txt
│       │   │   │   │   ├── progress-287.png.txt
│       │   │   │   │   ├── progress-288.png.txt
│       │   │   │   │   ├── progress-289.png.txt                       │       │   │   │   │   ├── progress-29.png.txt
│       │   │   │   │   ├── progress-290.png.txt
│       │   │   │   │   ├── progress-291.png.txt
│       │   │   │   │   ├── progress-292.png.txt                       │       │   │   │   │   ├── progress-293.png.txt
│       │   │   │   │   ├── progress-294.png.txt                       │       │   │   │   │   ├── progress-295.png.txt
│       │   │   │   │   ├── progress-296.png.txt                       │       │   │   │   │   ├── progress-297.png.txt
│       │   │   │   │   ├── progress-298.png.txt
│       │   │   │   │   ├── progress-299.png.txt
│       │   │   │   │   ├── progress-3.png.txt                         │       │   │   │   │   ├── progress-30.png.txt
│       │   │   │   │   ├── progress-300.png.txt                       │       │   │   │   │   ├── progress-301.png.txt
│       │   │   │   │   ├── progress-302.png.txt
│       │   │   │   │   ├── progress-303.png.txt                       │       │   │   │   │   ├── progress-304.png.txt
│       │   │   │   │   ├── progress-305.png.txt
│       │   │   │   │   ├── progress-306.png.txt
│       │   │   │   │   ├── progress-307.png.txt                       │       │   │   │   │   ├── progress-308.png.txt
│       │   │   │   │   ├── progress-309.png.txt                       │       │   │   │   │   ├── progress-31.png.txt
│       │   │   │   │   ├── progress-310.png.txt                       │       │   │   │   │   ├── progress-311.png.txt
│       │   │   │   │   ├── progress-312.png.txt                       │       │   │   │   │   ├── progress-313.png.txt
│       │   │   │   │   ├── progress-314.png.txt                       │       │   │   │   │   ├── progress-315.png.txt
│       │   │   │   │   ├── progress-316.png.txt
│       │   │   │   │   ├── progress-317.png.txt
│       │   │   │   │   ├── progress-318.png.txt
│       │   │   │   │   ├── progress-319.png.txt
│       │   │   │   │   ├── progress-32.png.txt                        │       │   │   │   │   ├── progress-320.png.txt
│       │   │   │   │   ├── progress-321.png.txt
│       │   │   │   │   ├── progress-322.png.txt
│       │   │   │   │   ├── progress-323.png.txt
│       │   │   │   │   ├── progress-324.png.txt
│       │   │   │   │   ├── progress-325.png.txt
│       │   │   │   │   ├── progress-326.png.txt                       │       │   │   │   │   ├── progress-327.png.txt
│       │   │   │   │   ├── progress-328.png.txt
│       │   │   │   │   ├── progress-329.png.txt                       │       │   │   │   │   ├── progress-33.png.txt
│       │   │   │   │   ├── progress-330.png.txt                       │       │   │   │   │   ├── progress-331.png.txt
│       │   │   │   │   ├── progress-332.png.txt
│       │   │   │   │   ├── progress-333.png.txt
│       │   │   │   │   ├── progress-334.png.txt                       │       │   │   │   │   ├── progress-335.png.txt
│       │   │   │   │   ├── progress-336.png.txt
│       │   │   │   │   ├── progress-337.png.txt
│       │   │   │   │   ├── progress-338.png.txt
│       │   │   │   │   ├── progress-339.png.txt
│       │   │   │   │   ├── progress-34.png.txt
│       │   │   │   │   ├── progress-340.png.txt
│       │   │   │   │   ├── progress-341.png.txt
│       │   │   │   │   ├── progress-342.png.txt
│       │   │   │   │   ├── progress-343.png.txt
│       │   │   │   │   ├── progress-344.png.txt
│       │   │   │   │   ├── progress-345.png.txt                       │       │   │   │   │   ├── progress-346.png.txt
│       │   │   │   │   ├── progress-347.png.txt
│       │   │   │   │   ├── progress-348.png.txt
│       │   │   │   │   ├── progress-349.png.txt
│       │   │   │   │   ├── progress-35.png.txt
│       │   │   │   │   ├── progress-350.png.txt
│       │   │   │   │   ├── progress-351.png.txt
│       │   │   │   │   ├── progress-352.png.txt
│       │   │   │   │   ├── progress-353.png.txt
│       │   │   │   │   ├── progress-354.png.txt
│       │   │   │   │   ├── progress-355.png.txt
│       │   │   │   │   ├── progress-356.png.txt
│       │   │   │   │   ├── progress-357.png.txt
│       │   │   │   │   ├── progress-358.png.txt
│       │   │   │   │   ├── progress-359.png.txt
│       │   │   │   │   ├── progress-36.png.txt
│       │   │   │   │   ├── progress-360.png.txt
│       │   │   │   │   ├── progress-361.png.txt
│       │   │   │   │   ├── progress-362.png.txt
│       │   │   │   │   ├── progress-363.png.txt
│       │   │   │   │   ├── progress-364.png.txt
│       │   │   │   │   ├── progress-365.png.txt
│       │   │   │   │   ├── progress-366.png.txt
│       │   │   │   │   ├── progress-367.png.txt
│       │   │   │   │   ├── progress-368.png.txt
│       │   │   │   │   ├── progress-369.png.txt
│       │   │   │   │   ├── progress-37.png.txt
│       │   │   │   │   ├── progress-370.png.txt
│       │   │   │   │   ├── progress-371.png.txt
│       │   │   │   │   ├── progress-372.png.txt
│       │   │   │   │   ├── progress-373.png.txt
│       │   │   │   │   ├── progress-374.png.txt
│       │   │   │   │   ├── progress-38.png.txt
│       │   │   │   │   ├── progress-39.png.txt
│       │   │   │   │   ├── progress-4.png.txt
│       │   │   │   │   ├── progress-40.png.txt
│       │   │   │   │   ├── progress-41.png.txt
│       │   │   │   │   ├── progress-42.png.txt
│       │   │   │   │   ├── progress-43.png.txt
│       │   │   │   │   ├── progress-44.png.txt
│       │   │   │   │   ├── progress-45.png.txt
│       │   │   │   │   ├── progress-46.png.txt
│       │   │   │   │   ├── progress-47.png.txt
│       │   │   │   │   ├── progress-48.png.txt
│       │   │   │   │   ├── progress-49.png.txt
│       │   │   │   │   ├── progress-5.png.txt
│       │   │   │   │   ├── progress-50.png.txt
│       │   │   │   │   ├── progress-51.png.txt
│       │   │   │   │   ├── progress-52.png.txt
│       │   │   │   │   ├── progress-53.png.txt
│       │   │   │   │   ├── progress-54.png.txt
│       │   │   │   │   ├── progress-55.png.txt
│       │   │   │   │   ├── progress-56.png.txt
│       │   │   │   │   ├── progress-57.png.txt
│       │   │   │   │   ├── progress-58.png.txt
│       │   │   │   │   ├── progress-59.png.txt
│       │   │   │   │   ├── progress-6.png.txt
│       │   │   │   │   ├── progress-60.png.txt                        │       │   │   │   │   ├── progress-61.png.txt
│       │   │   │   │   ├── progress-62.png.txt                        │       │   │   │   │   ├── progress-63.png.txt
│       │   │   │   │   ├── progress-64.png.txt                        │       │   │   │   │   ├── progress-65.png.txt
│       │   │   │   │   ├── progress-66.png.txt                        │       │   │   │   │   ├── progress-67.png.txt
│       │   │   │   │   ├── progress-68.png.txt                        │       │   │   │   │   ├── progress-69.png.txt
│       │   │   │   │   ├── progress-7.png.txt                         │       │   │   │   │   ├── progress-70.png.txt
│       │   │   │   │   ├── progress-71.png.txt                        │       │   │   │   │   ├── progress-72.png.txt
│       │   │   │   │   ├── progress-73.png.txt                        │       │   │   │   │   ├── progress-74.png.txt
│       │   │   │   │   ├── progress-75.png.txt
│       │   │   │   │   ├── progress-76.png.txt
│       │   │   │   │   ├── progress-77.png.txt
│       │   │   │   │   ├── progress-78.png.txt
│       │   │   │   │   ├── progress-79.png.txt
│       │   │   │   │   ├── progress-8.png.txt                         │       │   │   │   │   ├── progress-80.png.txt
│       │   │   │   │   ├── progress-81.png.txt
│       │   │   │   │   ├── progress-82.png.txt
│       │   │   │   │   ├── progress-83.png.txt
│       │   │   │   │   ├── progress-84.png.txt                        │       │   │   │   │   ├── progress-85.png.txt
│       │   │   │   │   ├── progress-86.png.txt                        │       │   │   │   │   ├── progress-87.png.txt
│       │   │   │   │   ├── progress-88.png.txt
│       │   │   │   │   ├── progress-89.png.txt
│       │   │   │   │   ├── progress-9.png.txt
│       │   │   │   │   ├── progress-90.png.txt                        │       │   │   │   │   ├── progress-91.png.txt
│       │   │   │   │   ├── progress-92.png.txt                        │       │   │   │   │   ├── progress-93.png.txt
│       │   │   │   │   ├── progress-94.png.txt
│       │   │   │   │   ├── progress-95.png.txt                        │       │   │   │   │   ├── progress-96.png.txt
│       │   │   │   │   ├── progress-97.png.txt
│       │   │   │   │   ├── progress-98.png.txt                        │       │   │   │   │   └── progress-99.png.txt
│       │   │   │   └── deus_ex_yellow                                 │       │   │   │       ├── progress-0.png.txt
│       │   │   │       ├── progress-1.png.txt                         │       │   │   │       ├── progress-10.png.txt
│       │   │   │       ├── progress-100.png.txt
│       │   │   │       ├── progress-101.png.txt
│       │   │   │       ├── progress-102.png.txt
│       │   │   │       ├── progress-103.png.txt
│       │   │   │       ├── progress-104.png.txt
│       │   │   │       ├── progress-105.png.txt
│       │   │   │       ├── progress-106.png.txt
│       │   │   │       ├── progress-107.png.txt
│       │   │   │       ├── progress-108.png.txt
│       │   │   │       ├── progress-109.png.txt                       │       │   │   │       ├── progress-11.png.txt
│       │   │   │       ├── progress-110.png.txt                       │       │   │   │       ├── progress-111.png.txt
│       │   │   │       ├── progress-112.png.txt                       │       │   │   │       ├── progress-113.png.txt
│       │   │   │       ├── progress-114.png.txt                       │       │   │   │       ├── progress-115.png.txt
│       │   │   │       ├── progress-116.png.txt                       │       │   │   │       ├── progress-117.png.txt
│       │   │   │       ├── progress-118.png.txt                       │       │   │   │       ├── progress-119.png.txt
│       │   │   │       ├── progress-12.png.txt
│       │   │   │       ├── progress-120.png.txt                       │       │   │   │       ├── progress-121.png.txt
│       │   │   │       ├── progress-122.png.txt
│       │   │   │       ├── progress-123.png.txt
│       │   │   │       ├── progress-124.png.txt
│       │   │   │       ├── progress-125.png.txt
│       │   │   │       ├── progress-126.png.txt
│       │   │   │       ├── progress-127.png.txt
│       │   │   │       ├── progress-128.png.txt                       │       │   │   │       ├── progress-129.png.txt
│       │   │   │       ├── progress-13.png.txt                        │       │   │   │       ├── progress-130.png.txt
│       │   │   │       ├── progress-131.png.txt                       │       │   │   │       ├── progress-132.png.txt
│       │   │   │       ├── progress-133.png.txt
│       │   │   │       ├── progress-134.png.txt
│       │   │   │       ├── progress-135.png.txt                       │       │   │   │       ├── progress-136.png.txt
│       │   │   │       ├── progress-137.png.txt                       │       │   │   │       ├── progress-138.png.txt
│       │   │   │       ├── progress-139.png.txt                       │       │   │   │       ├── progress-14.png.txt
│       │   │   │       ├── progress-140.png.txt
│       │   │   │       ├── progress-141.png.txt
│       │   │   │       ├── progress-142.png.txt                       │       │   │   │       ├── progress-143.png.txt
│       │   │   │       ├── progress-144.png.txt                       │       │   │   │       ├── progress-145.png.txt
│       │   │   │       ├── progress-146.png.txt                       │       │   │   │       ├── progress-147.png.txt
│       │   │   │       ├── progress-148.png.txt                       │       │   │   │       ├── progress-149.png.txt
│       │   │   │       ├── progress-15.png.txt
│       │   │   │       ├── progress-150.png.txt
│       │   │   │       ├── progress-151.png.txt
│       │   │   │       ├── progress-152.png.txt
│       │   │   │       ├── progress-153.png.txt                       │       │   │   │       ├── progress-154.png.txt
│       │   │   │       ├── progress-155.png.txt
│       │   │   │       ├── progress-156.png.txt
│       │   │   │       ├── progress-157.png.txt
│       │   │   │       ├── progress-158.png.txt                       │       │   │   │       ├── progress-159.png.txt
│       │   │   │       ├── progress-16.png.txt                        │       │   │   │       ├── progress-160.png.txt
│       │   │   │       ├── progress-161.png.txt
│       │   │   │       ├── progress-162.png.txt
│       │   │   │       ├── progress-163.png.txt
│       │   │   │       ├── progress-164.png.txt                       │       │   │   │       ├── progress-165.png.txt
│       │   │   │       ├── progress-166.png.txt
│       │   │   │       ├── progress-167.png.txt
│       │   │   │       ├── progress-168.png.txt
│       │   │   │       ├── progress-169.png.txt
│       │   │   │       ├── progress-17.png.txt
│       │   │   │       ├── progress-170.png.txt
│       │   │   │       ├── progress-171.png.txt
│       │   │   │       ├── progress-172.png.txt
│       │   │   │       ├── progress-173.png.txt
│       │   │   │       ├── progress-174.png.txt
│       │   │   │       ├── progress-175.png.txt
│       │   │   │       ├── progress-176.png.txt
│       │   │   │       ├── progress-177.png.txt
│       │   │   │       ├── progress-178.png.txt
│       │   │   │       ├── progress-179.png.txt
│       │   │   │       ├── progress-18.png.txt
│       │   │   │       ├── progress-180.png.txt
│       │   │   │       ├── progress-181.png.txt
│       │   │   │       ├── progress-182.png.txt
│       │   │   │       ├── progress-183.png.txt
│       │   │   │       ├── progress-184.png.txt
│       │   │   │       ├── progress-185.png.txt
│       │   │   │       ├── progress-186.png.txt
│       │   │   │       ├── progress-187.png.txt
│       │   │   │       ├── progress-188.png.txt
│       │   │   │       ├── progress-189.png.txt
│       │   │   │       ├── progress-19.png.txt
│       │   │   │       ├── progress-190.png.txt
│       │   │   │       ├── progress-191.png.txt
│       │   │   │       ├── progress-192.png.txt
│       │   │   │       ├── progress-193.png.txt
│       │   │   │       ├── progress-194.png.txt
│       │   │   │       ├── progress-195.png.txt
│       │   │   │       ├── progress-196.png.txt
│       │   │   │       ├── progress-197.png.txt
│       │   │   │       ├── progress-198.png.txt
│       │   │   │       ├── progress-199.png.txt
│       │   │   │       ├── progress-2.png.txt
│       │   │   │       ├── progress-20.png.txt
│       │   │   │       ├── progress-200.png.txt
│       │   │   │       ├── progress-201.png.txt
│       │   │   │       ├── progress-202.png.txt
│       │   │   │       ├── progress-203.png.txt
│       │   │   │       ├── progress-204.png.txt
│       │   │   │       ├── progress-205.png.txt
│       │   │   │       ├── progress-206.png.txt
│       │   │   │       ├── progress-207.png.txt
│       │   │   │       ├── progress-208.png.txt
│       │   │   │       ├── progress-209.png.txt
│       │   │   │       ├── progress-21.png.txt
│       │   │   │       ├── progress-210.png.txt
│       │   │   │       ├── progress-211.png.txt
│       │   │   │       ├── progress-212.png.txt
│       │   │   │       ├── progress-213.png.txt
│       │   │   │       ├── progress-214.png.txt
│       │   │   │       ├── progress-215.png.txt
│       │   │   │       ├── progress-216.png.txt
│       │   │   │       ├── progress-217.png.txt
│       │   │   │       ├── progress-218.png.txt
│       │   │   │       ├── progress-219.png.txt
│       │   │   │       ├── progress-22.png.txt
│       │   │   │       ├── progress-220.png.txt
│       │   │   │       ├── progress-221.png.txt
│       │   │   │       ├── progress-222.png.txt
│       │   │   │       ├── progress-223.png.txt
│       │   │   │       ├── progress-224.png.txt
│       │   │   │       ├── progress-225.png.txt
│       │   │   │       ├── progress-226.png.txt
│       │   │   │       ├── progress-227.png.txt
│       │   │   │       ├── progress-228.png.txt
│       │   │   │       ├── progress-229.png.txt
│       │   │   │       ├── progress-23.png.txt
│       │   │   │       ├── progress-230.png.txt
│       │   │   │       ├── progress-231.png.txt
│       │   │   │       ├── progress-232.png.txt
│       │   │   │       ├── progress-233.png.txt
│       │   │   │       ├── progress-234.png.txt
│       │   │   │       ├── progress-235.png.txt
│       │   │   │       ├── progress-236.png.txt
│       │   │   │       ├── progress-237.png.txt
│       │   │   │       ├── progress-238.png.txt
│       │   │   │       ├── progress-239.png.txt
│       │   │   │       ├── progress-24.png.txt
│       │   │   │       ├── progress-240.png.txt
│       │   │   │       ├── progress-241.png.txt
│       │   │   │       ├── progress-242.png.txt
│       │   │   │       ├── progress-243.png.txt
│       │   │   │       ├── progress-244.png.txt
│       │   │   │       ├── progress-245.png.txt
│       │   │   │       ├── progress-246.png.txt
│       │   │   │       ├── progress-247.png.txt
│       │   │   │       ├── progress-248.png.txt
│       │   │   │       ├── progress-249.png.txt
│       │   │   │       ├── progress-25.png.txt
│       │   │   │       ├── progress-250.png.txt
│       │   │   │       ├── progress-251.png.txt
│       │   │   │       ├── progress-252.png.txt
│       │   │   │       ├── progress-253.png.txt
│       │   │   │       ├── progress-254.png.txt
│       │   │   │       ├── progress-255.png.txt
│       │   │   │       ├── progress-256.png.txt
│       │   │   │       ├── progress-257.png.txt
│       │   │   │       ├── progress-258.png.txt
│       │   │   │       ├── progress-259.png.txt
│       │   │   │       ├── progress-26.png.txt
│       │   │   │       ├── progress-260.png.txt
│       │   │   │       ├── progress-261.png.txt
│       │   │   │       ├── progress-262.png.txt
│       │   │   │       ├── progress-263.png.txt
│       │   │   │       ├── progress-264.png.txt
│       │   │   │       ├── progress-265.png.txt
│       │   │   │       ├── progress-266.png.txt
│       │   │   │       ├── progress-267.png.txt
│       │   │   │       ├── progress-268.png.txt
│       │   │   │       ├── progress-269.png.txt
│       │   │   │       ├── progress-27.png.txt
│       │   │   │       ├── progress-270.png.txt
│       │   │   │       ├── progress-271.png.txt
│       │   │   │       ├── progress-272.png.txt
│       │   │   │       ├── progress-273.png.txt
│       │   │   │       ├── progress-274.png.txt
│       │   │   │       ├── progress-275.png.txt
│       │   │   │       ├── progress-276.png.txt
│       │   │   │       ├── progress-277.png.txt
│       │   │   │       ├── progress-278.png.txt
│       │   │   │       ├── progress-279.png.txt
│       │   │   │       ├── progress-28.png.txt
│       │   │   │       ├── progress-280.png.txt
│       │   │   │       ├── progress-281.png.txt
│       │   │   │       ├── progress-282.png.txt
│       │   │   │       ├── progress-283.png.txt
│       │   │   │       ├── progress-284.png.txt
│       │   │   │       ├── progress-285.png.txt
│       │   │   │       ├── progress-286.png.txt
│       │   │   │       ├── progress-287.png.txt
│       │   │   │       ├── progress-288.png.txt
│       │   │   │       ├── progress-289.png.txt
│       │   │   │       ├── progress-29.png.txt
│       │   │   │       ├── progress-290.png.txt
│       │   │   │       ├── progress-291.png.txt
│       │   │   │       ├── progress-292.png.txt
│       │   │   │       ├── progress-293.png.txt
│       │   │   │       ├── progress-294.png.txt
│       │   │   │       ├── progress-295.png.txt
│       │   │   │       ├── progress-296.png.txt
│       │   │   │       ├── progress-297.png.txt
│       │   │   │       ├── progress-298.png.txt
│       │   │   │       ├── progress-299.png.txt
│       │   │   │       ├── progress-3.png.txt
│       │   │   │       ├── progress-30.png.txt
│       │   │   │       ├── progress-300.png.txt
│       │   │   │       ├── progress-301.png.txt
│       │   │   │       ├── progress-302.png.txt
│       │   │   │       ├── progress-303.png.txt
│       │   │   │       ├── progress-304.png.txt
│       │   │   │       ├── progress-305.png.txt
│       │   │   │       ├── progress-306.png.txt
│       │   │   │       ├── progress-307.png.txt
│       │   │   │       ├── progress-308.png.txt
│       │   │   │       ├── progress-309.png.txt
│       │   │   │       ├── progress-31.png.txt
│       │   │   │       ├── progress-310.png.txt
│       │   │   │       ├── progress-311.png.txt
│       │   │   │       ├── progress-312.png.txt
│       │   │   │       ├── progress-313.png.txt
│       │   │   │       ├── progress-314.png.txt
│       │   │   │       ├── progress-315.png.txt
│       │   │   │       ├── progress-316.png.txt
│       │   │   │       ├── progress-317.png.txt
│       │   │   │       ├── progress-318.png.txt
│       │   │   │       ├── progress-319.png.txt
│       │   │   │       ├── progress-32.png.txt
│       │   │   │       ├── progress-320.png.txt
│       │   │   │       ├── progress-321.png.txt
│       │   │   │       ├── progress-322.png.txt
│       │   │   │       ├── progress-323.png.txt
│       │   │   │       ├── progress-324.png.txt
│       │   │   │       ├── progress-325.png.txt
│       │   │   │       ├── progress-326.png.txt
│       │   │   │       ├── progress-327.png.txt
│       │   │   │       ├── progress-328.png.txt
│       │   │   │       ├── progress-329.png.txt
│       │   │   │       ├── progress-33.png.txt
│       │   │   │       ├── progress-330.png.txt
│       │   │   │       ├── progress-331.png.txt
│       │   │   │       ├── progress-332.png.txt
│       │   │   │       ├── progress-333.png.txt
│       │   │   │       ├── progress-334.png.txt
│       │   │   │       ├── progress-335.png.txt
│       │   │   │       ├── progress-336.png.txt
│       │   │   │       ├── progress-337.png.txt
│       │   │   │       ├── progress-338.png.txt
│       │   │   │       ├── progress-339.png.txt                       │       │   │   │       ├── progress-34.png.txt
│       │   │   │       ├── progress-340.png.txt                       │       │   │   │       ├── progress-341.png.txt
│       │   │   │       ├── progress-342.png.txt
│       │   │   │       ├── progress-343.png.txt                       │       │   │   │       ├── progress-344.png.txt
│       │   │   │       ├── progress-345.png.txt                       │       │   │   │       ├── progress-346.png.txt
│       │   │   │       ├── progress-347.png.txt                       │       │   │   │       ├── progress-348.png.txt
│       │   │   │       ├── progress-349.png.txt                       │       │   │   │       ├── progress-35.png.txt
│       │   │   │       ├── progress-350.png.txt                       │       │   │   │       ├── progress-351.png.txt
│       │   │   │       ├── progress-352.png.txt
│       │   │   │       ├── progress-353.png.txt
│       │   │   │       ├── progress-354.png.txt
│       │   │   │       ├── progress-355.png.txt
│       │   │   │       ├── progress-356.png.txt
│       │   │   │       ├── progress-357.png.txt
│       │   │   │       ├── progress-358.png.txt
│       │   │   │       ├── progress-359.png.txt
│       │   │   │       ├── progress-36.png.txt
│       │   │   │       ├── progress-360.png.txt
│       │   │   │       ├── progress-361.png.txt
│       │   │   │       ├── progress-362.png.txt                       │       │   │   │       ├── progress-363.png.txt
│       │   │   │       ├── progress-364.png.txt
│       │   │   │       ├── progress-365.png.txt
│       │   │   │       ├── progress-366.png.txt
│       │   │   │       ├── progress-367.png.txt
│       │   │   │       ├── progress-368.png.txt
│       │   │   │       ├── progress-369.png.txt
│       │   │   │       ├── progress-37.png.txt
│       │   │   │       ├── progress-370.png.txt                       │       │   │   │       ├── progress-371.png.txt
│       │   │   │       ├── progress-372.png.txt
│       │   │   │       ├── progress-373.png.txt
│       │   │   │       ├── progress-374.png.txt
│       │   │   │       ├── progress-38.png.txt
│       │   │   │       ├── progress-39.png.txt
│       │   │   │       ├── progress-4.png.txt
│       │   │   │       ├── progress-40.png.txt
│       │   │   │       ├── progress-41.png.txt
│       │   │   │       ├── progress-42.png.txt
│       │   │   │       ├── progress-43.png.txt
│       │   │   │       ├── progress-44.png.txt
│       │   │   │       ├── progress-45.png.txt
│       │   │   │       ├── progress-46.png.txt
│       │   │   │       ├── progress-47.png.txt                        │       │   │   │       ├── progress-48.png.txt
│       │   │   │       ├── progress-49.png.txt
│       │   │   │       ├── progress-5.png.txt
│       │   │   │       ├── progress-50.png.txt
│       │   │   │       ├── progress-51.png.txt
│       │   │   │       ├── progress-52.png.txt
│       │   │   │       ├── progress-53.png.txt
│       │   │   │       ├── progress-54.png.txt
│       │   │   │       ├── progress-55.png.txt
│       │   │   │       ├── progress-56.png.txt
│       │   │   │       ├── progress-57.png.txt
│       │   │   │       ├── progress-58.png.txt
│       │   │   │       ├── progress-59.png.txt
│       │   │   │       ├── progress-6.png.txt
│       │   │   │       ├── progress-60.png.txt
│       │   │   │       ├── progress-61.png.txt
│       │   │   │       ├── progress-62.png.txt
│       │   │   │       ├── progress-63.png.txt
│       │   │   │       ├── progress-64.png.txt
│       │   │   │       ├── progress-65.png.txt
│       │   │   │       ├── progress-66.png.txt
│       │   │   │       ├── progress-67.png.txt
│       │   │   │       ├── progress-68.png.txt
│       │   │   │       ├── progress-69.png.txt
│       │   │   │       ├── progress-7.png.txt                         │       │   │   │       ├── progress-70.png.txt
│       │   │   │       ├── progress-71.png.txt
│       │   │   │       ├── progress-72.png.txt
│       │   │   │       ├── progress-73.png.txt
│       │   │   │       ├── progress-74.png.txt
│       │   │   │       ├── progress-75.png.txt
│       │   │   │       ├── progress-76.png.txt
│       │   │   │       ├── progress-77.png.txt
│       │   │   │       ├── progress-78.png.txt
│       │   │   │       ├── progress-79.png.txt
│       │   │   │       ├── progress-8.png.txt
│       │   │   │       ├── progress-80.png.txt
│       │   │   │       ├── progress-81.png.txt
│       │   │   │       ├── progress-82.png.txt
│       │   │   │       ├── progress-83.png.txt
│       │   │   │       ├── progress-84.png.txt
│       │   │   │       ├── progress-85.png.txt
│       │   │   │       ├── progress-86.png.txt
│       │   │   │       ├── progress-87.png.txt
│       │   │   │       ├── progress-88.png.txt
│       │   │   │       ├── progress-89.png.txt
│       │   │   │       ├── progress-9.png.txt
│       │   │   │       ├── progress-90.png.txt
│       │   │   │       ├── progress-91.png.txt
│       │   │   │       ├── progress-92.png.txt
│       │   │   │       ├── progress-93.png.txt
│       │   │   │       ├── progress-94.png.txt
│       │   │   │       ├── progress-95.png.txt
│       │   │   │       ├── progress-96.png.txt
│       │   │   │       ├── progress-97.png.txt
│       │   │   │       ├── progress-98.png.txt
│       │   │   │       └── progress-99.png.txt
│       │   │   ├── black_hud.gif
│       │   │   ├── circle_hud.gif
│       │   │   ├── deus_ex.gif
│       │   │   ├── glitch.gif
│       │   │   ├── image
│       │   │   │   ├── README.md
│       │   │   │   ├── deus_ex
│       │   │   │   │   ├── progress-0.png
│       │   │   │   │   ├── progress-1.png
│       │   │   │   │   ├── progress-10.png
│       │   │   │   │   ├── progress-100.png
│       │   │   │   │   ├── progress-101.png
│       │   │   │   │   ├── progress-102.png
│       │   │   │   │   ├── progress-103.png
│       │   │   │   │   ├── progress-104.png
│       │   │   │   │   ├── progress-105.png
│       │   │   │   │   ├── progress-106.png
│       │   │   │   │   ├── progress-107.png
│       │   │   │   │   ├── progress-108.png
│       │   │   │   │   ├── progress-109.png
│       │   │   │   │   ├── progress-11.png
│       │   │   │   │   ├── progress-110.png
│       │   │   │   │   ├── progress-111.png
│       │   │   │   │   ├── progress-112.png
│       │   │   │   │   ├── progress-113.png
│       │   │   │   │   ├── progress-114.png
│       │   │   │   │   ├── progress-115.png
│       │   │   │   │   ├── progress-116.png
│       │   │   │   │   ├── progress-117.png
│       │   │   │   │   ├── progress-118.png
│       │   │   │   │   ├── progress-119.png
│       │   │   │   │   ├── progress-12.png
│       │   │   │   │   ├── progress-120.png
│       │   │   │   │   ├── progress-121.png
│       │   │   │   │   ├── progress-122.png
│       │   │   │   │   ├── progress-123.png
│       │   │   │   │   ├── progress-124.png
│       │   │   │   │   ├── progress-125.png
│       │   │   │   │   ├── progress-126.png
│       │   │   │   │   ├── progress-127.png
│       │   │   │   │   ├── progress-128.png
│       │   │   │   │   ├── progress-129.png
│       │   │   │   │   ├── progress-13.png
│       │   │   │   │   ├── progress-130.png
│       │   │   │   │   ├── progress-131.png
│       │   │   │   │   ├── progress-132.png
│       │   │   │   │   ├── progress-133.png
│       │   │   │   │   ├── progress-134.png
│       │   │   │   │   ├── progress-135.png
│       │   │   │   │   ├── progress-136.png
│       │   │   │   │   ├── progress-137.png
│       │   │   │   │   ├── progress-138.png
│       │   │   │   │   ├── progress-139.png
│       │   │   │   │   ├── progress-14.png
│       │   │   │   │   ├── progress-140.png
│       │   │   │   │   ├── progress-141.png
│       │   │   │   │   ├── progress-142.png
│       │   │   │   │   ├── progress-143.png
│       │   │   │   │   ├── progress-144.png
│       │   │   │   │   ├── progress-145.png
│       │   │   │   │   ├── progress-146.png
│       │   │   │   │   ├── progress-147.png
│       │   │   │   │   ├── progress-148.png
│       │   │   │   │   ├── progress-149.png
│       │   │   │   │   ├── progress-15.png
│       │   │   │   │   ├── progress-150.png
│       │   │   │   │   ├── progress-151.png
│       │   │   │   │   ├── progress-152.png
│       │   │   │   │   ├── progress-153.png
│       │   │   │   │   ├── progress-154.png
│       │   │   │   │   ├── progress-155.png
│       │   │   │   │   ├── progress-156.png
│       │   │   │   │   ├── progress-157.png
│       │   │   │   │   ├── progress-158.png
│       │   │   │   │   ├── progress-159.png
│       │   │   │   │   ├── progress-16.png
│       │   │   │   │   ├── progress-160.png
│       │   │   │   │   ├── progress-161.png
│       │   │   │   │   ├── progress-162.png
│       │   │   │   │   ├── progress-163.png
│       │   │   │   │   ├── progress-164.png
│       │   │   │   │   ├── progress-165.png
│       │   │   │   │   ├── progress-166.png
│       │   │   │   │   ├── progress-167.png
│       │   │   │   │   ├── progress-168.png
│       │   │   │   │   ├── progress-169.png
│       │   │   │   │   ├── progress-17.png
│       │   │   │   │   ├── progress-170.png
│       │   │   │   │   ├── progress-171.png
│       │   │   │   │   ├── progress-172.png
│       │   │   │   │   ├── progress-173.png
│       │   │   │   │   ├── progress-174.png
│       │   │   │   │   ├── progress-175.png
│       │   │   │   │   ├── progress-176.png
│       │   │   │   │   ├── progress-177.png
│       │   │   │   │   ├── progress-178.png
│       │   │   │   │   ├── progress-179.png
│       │   │   │   │   ├── progress-18.png
│       │   │   │   │   ├── progress-180.png
│       │   │   │   │   ├── progress-181.png
│       │   │   │   │   ├── progress-182.png
│       │   │   │   │   ├── progress-183.png
│       │   │   │   │   ├── progress-184.png
│       │   │   │   │   ├── progress-185.png
│       │   │   │   │   ├── progress-186.png
│       │   │   │   │   ├── progress-187.png
│       │   │   │   │   ├── progress-188.png
│       │   │   │   │   ├── progress-189.png
│       │   │   │   │   ├── progress-19.png
│       │   │   │   │   ├── progress-190.png
│       │   │   │   │   ├── progress-191.png
│       │   │   │   │   ├── progress-192.png
│       │   │   │   │   ├── progress-193.png
│       │   │   │   │   ├── progress-194.png
│       │   │   │   │   ├── progress-195.png
│       │   │   │   │   ├── progress-196.png
│       │   │   │   │   ├── progress-197.png
│       │   │   │   │   ├── progress-198.png
│       │   │   │   │   ├── progress-199.png
│       │   │   │   │   ├── progress-2.png
│       │   │   │   │   ├── progress-20.png
│       │   │   │   │   ├── progress-200.png
│       │   │   │   │   ├── progress-201.png
│       │   │   │   │   ├── progress-202.png
│       │   │   │   │   ├── progress-203.png
│       │   │   │   │   ├── progress-204.png
│       │   │   │   │   ├── progress-205.png
│       │   │   │   │   ├── progress-206.png
│       │   │   │   │   ├── progress-207.png
│       │   │   │   │   ├── progress-208.png
│       │   │   │   │   ├── progress-209.png
│       │   │   │   │   ├── progress-21.png
│       │   │   │   │   ├── progress-210.png
│       │   │   │   │   ├── progress-211.png
│       │   │   │   │   ├── progress-212.png
│       │   │   │   │   ├── progress-213.png
│       │   │   │   │   ├── progress-214.png
│       │   │   │   │   ├── progress-215.png
│       │   │   │   │   ├── progress-216.png
│       │   │   │   │   ├── progress-217.png
│       │   │   │   │   ├── progress-218.png
│       │   │   │   │   ├── progress-219.png
│       │   │   │   │   ├── progress-22.png
│       │   │   │   │   ├── progress-220.png
│       │   │   │   │   ├── progress-221.png
│       │   │   │   │   ├── progress-222.png
│       │   │   │   │   ├── progress-223.png
│       │   │   │   │   ├── progress-224.png
│       │   │   │   │   ├── progress-225.png
│       │   │   │   │   ├── progress-226.png
│       │   │   │   │   ├── progress-227.png
│       │   │   │   │   ├── progress-228.png
│       │   │   │   │   ├── progress-229.png
│       │   │   │   │   ├── progress-23.png
│       │   │   │   │   ├── progress-230.png
│       │   │   │   │   ├── progress-231.png
│       │   │   │   │   ├── progress-232.png
│       │   │   │   │   ├── progress-233.png                           │       │   │   │   │   ├── progress-234.png
│       │   │   │   │   ├── progress-235.png                           │       │   │   │   │   ├── progress-236.png
│       │   │   │   │   ├── progress-237.png
│       │   │   │   │   ├── progress-238.png                           │       │   │   │   │   ├── progress-239.png
│       │   │   │   │   ├── progress-24.png                            │       │   │   │   │   ├── progress-240.png
│       │   │   │   │   ├── progress-241.png                           │       │   │   │   │   ├── progress-242.png
│       │   │   │   │   ├── progress-243.png                           │       │   │   │   │   ├── progress-244.png
│       │   │   │   │   ├── progress-245.png                           │       │   │   │   │   ├── progress-246.png
│       │   │   │   │   ├── progress-247.png
│       │   │   │   │   ├── progress-248.png
│       │   │   │   │   ├── progress-249.png
│       │   │   │   │   ├── progress-25.png
│       │   │   │   │   ├── progress-250.png
│       │   │   │   │   ├── progress-251.png
│       │   │   │   │   ├── progress-252.png
│       │   │   │   │   ├── progress-253.png
│       │   │   │   │   ├── progress-254.png
│       │   │   │   │   ├── progress-255.png
│       │   │   │   │   ├── progress-256.png
│       │   │   │   │   ├── progress-257.png
│       │   │   │   │   ├── progress-258.png
│       │   │   │   │   ├── progress-259.png
│       │   │   │   │   ├── progress-26.png
│       │   │   │   │   ├── progress-260.png
│       │   │   │   │   ├── progress-261.png
│       │   │   │   │   ├── progress-262.png
│       │   │   │   │   ├── progress-263.png
│       │   │   │   │   ├── progress-264.png
│       │   │   │   │   ├── progress-265.png                           │       │   │   │   │   ├── progress-266.png
│       │   │   │   │   ├── progress-267.png
│       │   │   │   │   ├── progress-268.png
│       │   │   │   │   ├── progress-269.png
│       │   │   │   │   ├── progress-27.png
│       │   │   │   │   ├── progress-270.png
│       │   │   │   │   ├── progress-271.png
│       │   │   │   │   ├── progress-272.png
│       │   │   │   │   ├── progress-273.png
│       │   │   │   │   ├── progress-274.png
│       │   │   │   │   ├── progress-275.png
│       │   │   │   │   ├── progress-276.png
│       │   │   │   │   ├── progress-277.png
│       │   │   │   │   ├── progress-278.png
│       │   │   │   │   ├── progress-279.png                           │       │   │   │   │   ├── progress-28.png
│       │   │   │   │   ├── progress-280.png
│       │   │   │   │   ├── progress-281.png
│       │   │   │   │   ├── progress-282.png
│       │   │   │   │   ├── progress-283.png
│       │   │   │   │   ├── progress-284.png
│       │   │   │   │   ├── progress-285.png
│       │   │   │   │   ├── progress-286.png
│       │   │   │   │   ├── progress-287.png
│       │   │   │   │   ├── progress-288.png
│       │   │   │   │   ├── progress-289.png
│       │   │   │   │   ├── progress-29.png
│       │   │   │   │   ├── progress-290.png
│       │   │   │   │   ├── progress-291.png
│       │   │   │   │   ├── progress-292.png
│       │   │   │   │   ├── progress-293.png
│       │   │   │   │   ├── progress-294.png
│       │   │   │   │   ├── progress-295.png
│       │   │   │   │   ├── progress-296.png
│       │   │   │   │   ├── progress-297.png
│       │   │   │   │   ├── progress-298.png
│       │   │   │   │   ├── progress-299.png
│       │   │   │   │   ├── progress-3.png
│       │   │   │   │   ├── progress-30.png
│       │   │   │   │   ├── progress-300.png                           │       │   │   │   │   ├── progress-301.png
│       │   │   │   │   ├── progress-302.png
│       │   │   │   │   ├── progress-303.png
│       │   │   │   │   ├── progress-304.png
│       │   │   │   │   ├── progress-305.png
│       │   │   │   │   ├── progress-306.png
│       │   │   │   │   ├── progress-307.png
│       │   │   │   │   ├── progress-308.png
│       │   │   │   │   ├── progress-309.png
│       │   │   │   │   ├── progress-31.png
│       │   │   │   │   ├── progress-310.png
│       │   │   │   │   ├── progress-311.png
│       │   │   │   │   ├── progress-312.png
│       │   │   │   │   ├── progress-313.png
│       │   │   │   │   ├── progress-314.png
│       │   │   │   │   ├── progress-315.png
│       │   │   │   │   ├── progress-316.png
│       │   │   │   │   ├── progress-317.png
│       │   │   │   │   ├── progress-318.png
│       │   │   │   │   ├── progress-319.png
│       │   │   │   │   ├── progress-32.png
│       │   │   │   │   ├── progress-320.png
│       │   │   │   │   ├── progress-321.png
│       │   │   │   │   ├── progress-322.png
│       │   │   │   │   ├── progress-323.png
│       │   │   │   │   ├── progress-324.png
│       │   │   │   │   ├── progress-325.png
│       │   │   │   │   ├── progress-326.png
│       │   │   │   │   ├── progress-327.png
│       │   │   │   │   ├── progress-328.png
│       │   │   │   │   ├── progress-329.png
│       │   │   │   │   ├── progress-33.png
│       │   │   │   │   ├── progress-330.png
│       │   │   │   │   ├── progress-331.png
│       │   │   │   │   ├── progress-332.png
│       │   │   │   │   ├── progress-333.png
│       │   │   │   │   ├── progress-334.png
│       │   │   │   │   ├── progress-335.png
│       │   │   │   │   ├── progress-336.png
│       │   │   │   │   ├── progress-337.png
│       │   │   │   │   ├── progress-338.png
│       │   │   │   │   ├── progress-339.png
│       │   │   │   │   ├── progress-34.png
│       │   │   │   │   ├── progress-340.png
│       │   │   │   │   ├── progress-341.png
│       │   │   │   │   ├── progress-342.png
│       │   │   │   │   ├── progress-343.png
│       │   │   │   │   ├── progress-344.png
│       │   │   │   │   ├── progress-345.png
│       │   │   │   │   ├── progress-346.png
│       │   │   │   │   ├── progress-347.png
│       │   │   │   │   ├── progress-348.png
│       │   │   │   │   ├── progress-349.png
│       │   │   │   │   ├── progress-35.png
│       │   │   │   │   ├── progress-350.png
│       │   │   │   │   ├── progress-351.png
│       │   │   │   │   ├── progress-352.png
│       │   │   │   │   ├── progress-353.png
│       │   │   │   │   ├── progress-354.png
│       │   │   │   │   ├── progress-355.png
│       │   │   │   │   ├── progress-356.png
│       │   │   │   │   ├── progress-357.png
│       │   │   │   │   ├── progress-358.png
│       │   │   │   │   ├── progress-359.png
│       │   │   │   │   ├── progress-36.png
│       │   │   │   │   ├── progress-360.png
│       │   │   │   │   ├── progress-361.png
│       │   │   │   │   ├── progress-362.png
│       │   │   │   │   ├── progress-363.png
│       │   │   │   │   ├── progress-364.png
│       │   │   │   │   ├── progress-365.png
│       │   │   │   │   ├── progress-366.png
│       │   │   │   │   ├── progress-367.png
│       │   │   │   │   ├── progress-368.png
│       │   │   │   │   ├── progress-369.png
│       │   │   │   │   ├── progress-37.png
│       │   │   │   │   ├── progress-370.png
│       │   │   │   │   ├── progress-371.png
│       │   │   │   │   ├── progress-372.png
│       │   │   │   │   ├── progress-373.png
│       │   │   │   │   ├── progress-374.png
│       │   │   │   │   ├── progress-38.png
│       │   │   │   │   ├── progress-39.png
│       │   │   │   │   ├── progress-4.png
│       │   │   │   │   ├── progress-40.png
│       │   │   │   │   ├── progress-41.png
│       │   │   │   │   ├── progress-42.png
│       │   │   │   │   ├── progress-43.png
│       │   │   │   │   ├── progress-44.png
│       │   │   │   │   ├── progress-45.png
│       │   │   │   │   ├── progress-46.png
│       │   │   │   │   ├── progress-47.png
│       │   │   │   │   ├── progress-48.png
│       │   │   │   │   ├── progress-49.png
│       │   │   │   │   ├── progress-5.png
│       │   │   │   │   ├── progress-50.png
│       │   │   │   │   ├── progress-51.png
│       │   │   │   │   ├── progress-52.png
│       │   │   │   │   ├── progress-53.png
│       │   │   │   │   ├── progress-54.png
│       │   │   │   │   ├── progress-55.png
│       │   │   │   │   ├── progress-56.png
│       │   │   │   │   ├── progress-57.png
│       │   │   │   │   ├── progress-58.png
│       │   │   │   │   ├── progress-59.png
│       │   │   │   │   ├── progress-6.png
│       │   │   │   │   ├── progress-60.png
│       │   │   │   │   ├── progress-61.png
│       │   │   │   │   ├── progress-62.png
│       │   │   │   │   ├── progress-63.png
│       │   │   │   │   ├── progress-64.png
│       │   │   │   │   ├── progress-65.png
│       │   │   │   │   ├── progress-66.png
│       │   │   │   │   ├── progress-67.png
│       │   │   │   │   ├── progress-68.png
│       │   │   │   │   ├── progress-69.png
│       │   │   │   │   ├── progress-7.png
│       │   │   │   │   ├── progress-70.png
│       │   │   │   │   ├── progress-71.png
│       │   │   │   │   ├── progress-72.png
│       │   │   │   │   ├── progress-73.png
│       │   │   │   │   ├── progress-74.png
│       │   │   │   │   ├── progress-75.png
│       │   │   │   │   ├── progress-76.png
│       │   │   │   │   ├── progress-77.png
│       │   │   │   │   ├── progress-78.png
│       │   │   │   │   ├── progress-79.png
│       │   │   │   │   ├── progress-8.png
│       │   │   │   │   ├── progress-80.png
│       │   │   │   │   ├── progress-81.png
│       │   │   │   │   ├── progress-82.png
│       │   │   │   │   ├── progress-83.png
│       │   │   │   │   ├── progress-84.png
│       │   │   │   │   ├── progress-85.png
│       │   │   │   │   ├── progress-86.png
│       │   │   │   │   ├── progress-87.png
│       │   │   │   │   ├── progress-88.png
│       │   │   │   │   ├── progress-89.png
│       │   │   │   │   ├── progress-9.png
│       │   │   │   │   ├── progress-90.png
│       │   │   │   │   ├── progress-91.png
│       │   │   │   │   ├── progress-92.png
│       │   │   │   │   ├── progress-93.png
│       │   │   │   │   ├── progress-94.png
│       │   │   │   │   ├── progress-95.png
│       │   │   │   │   ├── progress-96.png
│       │   │   │   │   ├── progress-97.png
│       │   │   │   │   ├── progress-98.png
│       │   │   │   │   └── progress-99.png
│       │   │   │   └── deus_ex_yellow
│       │   │   │       ├── progress-0.png
│       │   │   │       ├── progress-1.png
│       │   │   │       ├── progress-10.png
│       │   │   │       ├── progress-100.png
│       │   │   │       ├── progress-101.png
│       │   │   │       ├── progress-102.png
│       │   │   │       ├── progress-103.png
│       │   │   │       ├── progress-104.png
│       │   │   │       ├── progress-105.png
│       │   │   │       ├── progress-106.png
│       │   │   │       ├── progress-107.png
│       │   │   │       ├── progress-108.png
│       │   │   │       ├── progress-109.png
│       │   │   │       ├── progress-11.png
│       │   │   │       ├── progress-110.png
│       │   │   │       ├── progress-111.png
│       │   │   │       ├── progress-112.png
│       │   │   │       ├── progress-113.png
│       │   │   │       ├── progress-114.png
│       │   │   │       ├── progress-115.png
│       │   │   │       ├── progress-116.png
│       │   │   │       ├── progress-117.png
│       │   │   │       ├── progress-118.png
│       │   │   │       ├── progress-119.png
│       │   │   │       ├── progress-12.png
│       │   │   │       ├── progress-120.png
│       │   │   │       ├── progress-121.png
│       │   │   │       ├── progress-122.png
│       │   │   │       ├── progress-123.png
│       │   │   │       ├── progress-124.png
│       │   │   │       ├── progress-125.png
│       │   │   │       ├── progress-126.png
│       │   │   │       ├── progress-127.png
│       │   │   │       ├── progress-128.png
│       │   │   │       ├── progress-129.png
│       │   │   │       ├── progress-13.png
│       │   │   │       ├── progress-130.png
│       │   │   │       ├── progress-131.png
│       │   │   │       ├── progress-132.png
│       │   │   │       ├── progress-133.png
│       │   │   │       ├── progress-134.png
│       │   │   │       ├── progress-135.png
│       │   │   │       ├── progress-136.png
│       │   │   │       ├── progress-137.png
│       │   │   │       ├── progress-138.png
│       │   │   │       ├── progress-139.png
│       │   │   │       ├── progress-14.png
│       │   │   │       ├── progress-140.png
│       │   │   │       ├── progress-141.png
│       │   │   │       ├── progress-142.png
│       │   │   │       ├── progress-143.png
│       │   │   │       ├── progress-144.png
│       │   │   │       ├── progress-145.png
│       │   │   │       ├── progress-146.png
│       │   │   │       ├── progress-147.png
│       │   │   │       ├── progress-148.png
│       │   │   │       ├── progress-149.png
│       │   │   │       ├── progress-15.png
│       │   │   │       ├── progress-150.png
│       │   │   │       ├── progress-151.png
│       │   │   │       ├── progress-152.png
│       │   │   │       ├── progress-153.png
│       │   │   │       ├── progress-154.png
│       │   │   │       ├── progress-155.png
│       │   │   │       ├── progress-156.png
│       │   │   │       ├── progress-157.png
│       │   │   │       ├── progress-158.png
│       │   │   │       ├── progress-159.png
│       │   │   │       ├── progress-16.png
│       │   │   │       ├── progress-160.png
│       │   │   │       ├── progress-161.png
│       │   │   │       ├── progress-162.png
│       │   │   │       ├── progress-163.png
│       │   │   │       ├── progress-164.png
│       │   │   │       ├── progress-165.png
│       │   │   │       ├── progress-166.png
│       │   │   │       ├── progress-167.png
│       │   │   │       ├── progress-168.png
│       │   │   │       ├── progress-169.png
│       │   │   │       ├── progress-17.png
│       │   │   │       ├── progress-170.png
│       │   │   │       ├── progress-171.png
│       │   │   │       ├── progress-172.png
│       │   │   │       ├── progress-173.png
│       │   │   │       ├── progress-174.png
│       │   │   │       ├── progress-175.png
│       │   │   │       ├── progress-176.png
│       │   │   │       ├── progress-177.png
│       │   │   │       ├── progress-178.png
│       │   │   │       ├── progress-179.png
│       │   │   │       ├── progress-18.png
│       │   │   │       ├── progress-180.png
│       │   │   │       ├── progress-181.png
│       │   │   │       ├── progress-182.png
│       │   │   │       ├── progress-183.png
│       │   │   │       ├── progress-184.png
│       │   │   │       ├── progress-185.png
│       │   │   │       ├── progress-186.png
│       │   │   │       ├── progress-187.png
│       │   │   │       ├── progress-188.png
│       │   │   │       ├── progress-189.png
│       │   │   │       ├── progress-19.png
│       │   │   │       ├── progress-190.png
│       │   │   │       ├── progress-191.png
│       │   │   │       ├── progress-192.png
│       │   │   │       ├── progress-193.png
│       │   │   │       ├── progress-194.png
│       │   │   │       ├── progress-195.png
│       │   │   │       ├── progress-196.png
│       │   │   │       ├── progress-197.png
│       │   │   │       ├── progress-198.png
│       │   │   │       ├── progress-199.png
│       │   │   │       ├── progress-2.png
│       │   │   │       ├── progress-20.png
│       │   │   │       ├── progress-200.png
│       │   │   │       ├── progress-201.png
│       │   │   │       ├── progress-202.png
│       │   │   │       ├── progress-203.png
│       │   │   │       ├── progress-204.png
│       │   │   │       ├── progress-205.png
│       │   │   │       ├── progress-206.png
│       │   │   │       ├── progress-207.png
│       │   │   │       ├── progress-208.png
│       │   │   │       ├── progress-209.png
│       │   │   │       ├── progress-21.png
│       │   │   │       ├── progress-210.png
│       │   │   │       ├── progress-211.png
│       │   │   │       ├── progress-212.png
│       │   │   │       ├── progress-213.png
│       │   │   │       ├── progress-214.png
│       │   │   │       ├── progress-215.png
│       │   │   │       ├── progress-216.png
│       │   │   │       ├── progress-217.png
│       │   │   │       ├── progress-218.png
│       │   │   │       ├── progress-219.png
│       │   │   │       ├── progress-22.png
│       │   │   │       ├── progress-220.png
│       │   │   │       ├── progress-221.png
│       │   │   │       ├── progress-222.png
│       │   │   │       ├── progress-223.png
│       │   │   │       ├── progress-224.png
│       │   │   │       ├── progress-225.png
│       │   │   │       ├── progress-226.png
│       │   │   │       ├── progress-227.png
│       │   │   │       ├── progress-228.png
│       │   │   │       ├── progress-229.png
│       │   │   │       ├── progress-23.png
│       │   │   │       ├── progress-230.png
│       │   │   │       ├── progress-231.png
│       │   │   │       ├── progress-232.png
│       │   │   │       ├── progress-233.png
│       │   │   │       ├── progress-234.png
│       │   │   │       ├── progress-235.png
│       │   │   │       ├── progress-236.png
│       │   │   │       ├── progress-237.png
│       │   │   │       ├── progress-238.png
│       │   │   │       ├── progress-239.png
│       │   │   │       ├── progress-24.png
│       │   │   │       ├── progress-240.png
│       │   │   │       ├── progress-241.png
│       │   │   │       ├── progress-242.png
│       │   │   │       ├── progress-243.png
│       │   │   │       ├── progress-244.png
│       │   │   │       ├── progress-245.png
│       │   │   │       ├── progress-246.png
│       │   │   │       ├── progress-247.png
│       │   │   │       ├── progress-248.png
│       │   │   │       ├── progress-249.png
│       │   │   │       ├── progress-25.png
│       │   │   │       ├── progress-250.png
│       │   │   │       ├── progress-251.png
│       │   │   │       ├── progress-252.png
│       │   │   │       ├── progress-253.png
│       │   │   │       ├── progress-254.png
│       │   │   │       ├── progress-255.png
│       │   │   │       ├── progress-256.png
│       │   │   │       ├── progress-257.png
│       │   │   │       ├── progress-258.png
│       │   │   │       ├── progress-259.png
│       │   │   │       ├── progress-26.png
│       │   │   │       ├── progress-260.png
│       │   │   │       ├── progress-261.png
│       │   │   │       ├── progress-262.png
│       │   │   │       ├── progress-263.png
│       │   │   │       ├── progress-264.png
│       │   │   │       ├── progress-265.png
│       │   │   │       ├── progress-266.png
│       │   │   │       ├── progress-267.png
│       │   │   │       ├── progress-268.png
│       │   │   │       ├── progress-269.png
│       │   │   │       ├── progress-27.png
│       │   │   │       ├── progress-270.png
│       │   │   │       ├── progress-271.png
│       │   │   │       ├── progress-272.png
│       │   │   │       ├── progress-273.png
│       │   │   │       ├── progress-274.png
│       │   │   │       ├── progress-275.png
│       │   │   │       ├── progress-276.png
│       │   │   │       ├── progress-277.png
│       │   │   │       ├── progress-278.png
│       │   │   │       ├── progress-279.png
│       │   │   │       ├── progress-28.png
│       │   │   │       ├── progress-280.png
│       │   │   │       ├── progress-281.png
│       │   │   │       ├── progress-282.png
│       │   │   │       ├── progress-283.png
│       │   │   │       ├── progress-284.png
│       │   │   │       ├── progress-285.png
│       │   │   │       ├── progress-286.png
│       │   │   │       ├── progress-287.png
│       │   │   │       ├── progress-288.png
│       │   │   │       ├── progress-289.png
│       │   │   │       ├── progress-29.png
│       │   │   │       ├── progress-290.png
│       │   │   │       ├── progress-291.png
│       │   │   │       ├── progress-292.png
│       │   │   │       ├── progress-293.png
│       │   │   │       ├── progress-294.png
│       │   │   │       ├── progress-295.png
│       │   │   │       ├── progress-296.png
│       │   │   │       ├── progress-297.png
│       │   │   │       ├── progress-298.png
│       │   │   │       ├── progress-299.png
│       │   │   │       ├── progress-3.png
│       │   │   │       ├── progress-30.png
│       │   │   │       ├── progress-300.png
│       │   │   │       ├── progress-301.png
│       │   │   │       ├── progress-302.png
│       │   │   │       ├── progress-303.png
│       │   │   │       ├── progress-304.png
│       │   │   │       ├── progress-305.png
│       │   │   │       ├── progress-306.png
│       │   │   │       ├── progress-307.png
│       │   │   │       ├── progress-308.png
│       │   │   │       ├── progress-309.png
│       │   │   │       ├── progress-31.png
│       │   │   │       ├── progress-310.png
│       │   │   │       ├── progress-311.png
│       │   │   │       ├── progress-312.png
│       │   │   │       ├── progress-313.png
│       │   │   │       ├── progress-314.png
│       │   │   │       ├── progress-315.png
│       │   │   │       ├── progress-316.png
│       │   │   │       ├── progress-317.png
│       │   │   │       ├── progress-318.png
│       │   │   │       ├── progress-319.png
│       │   │   │       ├── progress-32.png
│       │   │   │       ├── progress-320.png
│       │   │   │       ├── progress-321.png
│       │   │   │       ├── progress-322.png
│       │   │   │       ├── progress-323.png
│       │   │   │       ├── progress-324.png
│       │   │   │       ├── progress-325.png
│       │   │   │       ├── progress-326.png
│       │   │   │       ├── progress-327.png
│       │   │   │       ├── progress-328.png
│       │   │   │       ├── progress-329.png
│       │   │   │       ├── progress-33.png
│       │   │   │       ├── progress-330.png
│       │   │   │       ├── progress-331.png
│       │   │   │       ├── progress-332.png
│       │   │   │       ├── progress-333.png
│       │   │   │       ├── progress-334.png
│       │   │   │       ├── progress-335.png
│       │   │   │       ├── progress-336.png
│       │   │   │       ├── progress-337.png
│       │   │   │       ├── progress-338.png
│       │   │   │       ├── progress-339.png
│       │   │   │       ├── progress-34.png
│       │   │   │       ├── progress-340.png
│       │   │   │       ├── progress-341.png
│       │   │   │       ├── progress-342.png
│       │   │   │       ├── progress-343.png
│       │   │   │       ├── progress-344.png
│       │   │   │       ├── progress-345.png
│       │   │   │       ├── progress-346.png
│       │   │   │       ├── progress-347.png
│       │   │   │       ├── progress-348.png
│       │   │   │       ├── progress-349.png
│       │   │   │       ├── progress-35.png
│       │   │   │       ├── progress-350.png
│       │   │   │       ├── progress-351.png
│       │   │   │       ├── progress-352.png
│       │   │   │       ├── progress-353.png
│       │   │   │       ├── progress-354.png
│       │   │   │       ├── progress-355.png
│       │   │   │       ├── progress-356.png
│       │   │   │       ├── progress-357.png
│       │   │   │       ├── progress-358.png
│       │   │   │       ├── progress-359.png
│       │   │   │       ├── progress-36.png
│       │   │   │       ├── progress-360.png
│       │   │   │       ├── progress-361.png
│       │   │   │       ├── progress-362.png
│       │   │   │       ├── progress-363.png
│       │   │   │       ├── progress-364.png
│       │   │   │       ├── progress-365.png
│       │   │   │       ├── progress-366.png
│       │   │   │       ├── progress-367.png
│       │   │   │       ├── progress-368.png
│       │   │   │       ├── progress-369.png
│       │   │   │       ├── progress-37.png
│       │   │   │       ├── progress-370.png
│       │   │   │       ├── progress-371.png
│       │   │   │       ├── progress-372.png
│       │   │   │       ├── progress-373.png
│       │   │   │       ├── progress-374.png
│       │   │   │       ├── progress-38.png
│       │   │   │       ├── progress-39.png
│       │   │   │       ├── progress-4.png
│       │   │   │       ├── progress-40.png
│       │   │   │       ├── progress-41.png
│       │   │   │       ├── progress-42.png
│       │   │   │       ├── progress-43.png
│       │   │   │       ├── progress-44.png
│       │   │   │       ├── progress-45.png
│       │   │   │       ├── progress-46.png
│       │   │   │       ├── progress-47.png
│       │   │   │       ├── progress-48.png
│       │   │   │       ├── progress-49.png
│       │   │   │       ├── progress-5.png
│       │   │   │       ├── progress-50.png
│       │   │   │       ├── progress-51.png
│       │   │   │       ├── progress-52.png
│       │   │   │       ├── progress-53.png
│       │   │   │       ├── progress-54.png
│       │   │   │       ├── progress-55.png
│       │   │   │       ├── progress-56.png
│       │   │   │       ├── progress-57.png
│       │   │   │       ├── progress-58.png
│       │   │   │       ├── progress-59.png
│       │   │   │       ├── progress-6.png
│       │   │   │       ├── progress-60.png
│       │   │   │       ├── progress-61.png
│       │   │   │       ├── progress-62.png
│       │   │   │       ├── progress-63.png
│       │   │   │       ├── progress-64.png
│       │   │   │       ├── progress-65.png
│       │   │   │       ├── progress-66.png
│       │   │   │       ├── progress-67.png
│       │   │   │       ├── progress-68.png
│       │   │   │       ├── progress-69.png
│       │   │   │       ├── progress-7.png
│       │   │   │       ├── progress-70.png
│       │   │   │       ├── progress-71.png
│       │   │   │       ├── progress-72.png
│       │   │   │       ├── progress-73.png
│       │   │   │       ├── progress-74.png
│       │   │   │       ├── progress-75.png
│       │   │   │       ├── progress-76.png
│       │   │   │       ├── progress-77.png
│       │   │   │       ├── progress-78.png
│       │   │   │       ├── progress-79.png
│       │   │   │       ├── progress-8.png
│       │   │   │       ├── progress-80.png
│       │   │   │       ├── progress-81.png
│       │   │   │       ├── progress-82.png
│       │   │   │       ├── progress-83.png
│       │   │   │       ├── progress-84.png
│       │   │   │       ├── progress-85.png
│       │   │   │       ├── progress-86.png
│       │   │   │       ├── progress-87.png
│       │   │   │       ├── progress-88.png
│       │   │   │       ├── progress-89.png
│       │   │   │       ├── progress-9.png
│       │   │   │       ├── progress-90.png
│       │   │   │       ├── progress-91.png
│       │   │   │       ├── progress-92.png
│       │   │   │       ├── progress-93.png
│       │   │   │       ├── progress-94.png
│       │   │   │       ├── progress-95.png
│       │   │   │       ├── progress-96.png
│       │   │   │       ├── progress-97.png
│       │   │   │       ├── progress-98.png
│       │   │   │       └── progress-99.png
│       │   │   └── unrap.gif
│       │   └── scripts
│       │       ├── ascii.py
│       │       ├── deusfetch.sh
│       │       └── utils.sh
│       ├── ghostty
│       │   ├── config
│       │   ├── config.bak
│       │   └── shaders
│       │       ├── dx1.glsl
│       │       ├── dx10.glsl
│       │       ├── dx11.glsl
│       │       ├── dx12.glsl
│       │       ├── dx2.glsl
│       │       ├── dx3.glsl
│       │       ├── dx4.glsl
│       │       ├── dx5.glsl
│       │       ├── dx6.glsl
│       │       ├── dx7.glsl
│       │       ├── dx8.glsl                                           │       │       ├── dx9.glsl
│       │       └── triangle_trouble.glsl                              │       ├── hypr
│       │   ├── hypridle.conf
│       │   ├── hyprland                                               │       │   │   ├── env.conf
│       │   │   ├── execs.conf                                         │       │   │   ├── general.conf
│       │   │   ├── keybinds.conf                                      │       │   │   └── rules.conf
│       │   ├── hyprland.conf                                          │       │   ├── hyprlock
│       │   │   └── status.sh                                          │       │   ├── hyprlock-scripts
│       │   │   ├── battery-status.sh
│       │   │   └── music-status.sh
│       │   ├── hyprlock.conf
│       │   └── shaders
│       │       ├── chromatic_abberation.frag
│       │       ├── crt.frag
│       │       ├── drugs.frag
│       │       ├── extradark.frag
│       │       ├── invert.frag
│       │       └── solarized.frag
│       ├── jamesdsp
│       │   ├── application.conf
│       │   ├── audio.conf
│       │   ├── graphiceq.conf
│       │   ├── irs
│       │   │   ├── Church.wav
│       │   │   ├── CorredHRTF_Crossfeed.wav
│       │   │   ├── CorredHRTF_Surround1.wav
│       │   │   ├── CorredHRTF_Surround2.wav
│       │   │   └── SwapChannels.wav
│       │   ├── liveprog                                               │       │   │   ├── 3bandSplitting.eel
│       │   │   ├── autopeakfilter.eel
│       │   │   ├── dc_remove.eel
│       │   │   ├── depthsurround.eel
│       │   │   ├── downmixer.eel
│       │   │   ├── downsampler.eel
│       │   │   ├── dynamicbass.eel
│       │   │   ├── fftConvolution2x4x2.eel
│       │   │   ├── fftConvolutionHRTF.eel
│       │   │   ├── firFilter.eel
│       │   │   ├── firlsProc.eel
│       │   │   ├── fractionalDelayline.eel
│       │   │   ├── gainControl.eel
│       │   │   ├── hadamVerb.eel
│       │   │   ├── lowpass.eel                                        │       │   │   ├── metallic-reverb.eel
│       │   │   ├── msCentreBoost.eel
│       │   │   ├── pfb.eel
│       │   │   ├── phaseshifter.eel
│       │   │   ├── polyphaseFilterbank.eel
│       │   │   ├── stereowide.eel
│       │   │   ├── stft-filter.eel
│       │   │   ├── stftCentreBoost.eel
│       │   │   ├── stftCentreCut.eel
│       │   │   ├── stftDenoise.eel
│       │   │   └── swapChannels.eel
│       │   └── vdc
│       │       ├── Butterworth.vdc
│       │       ├── FrontRearContrast.vdc
│       │       └── mh750.vdc
│       ├── kitty
│       │   ├── current-theme.conf
│       │   ├── kitty.conf
│       │   └── kitty.conf.bak
│       ├── kwinrc
│       ├── nvim
│       │   ├── .gitignore
│       │   ├── .neoconf.json
│       │   ├── LICENSE
│       │   ├── README.md                                              │       │   ├── init.lua
│       │   ├── lazy-lock.json
│       │   ├── lazyvim.json
│       │   ├── lua
│       │   │   ├── config
│       │   │   │   ├── autocmds.lua
│       │   │   │   ├── keymaps.lua
│       │   │   │   ├── lazy.lua
│       │   │   │   └── options.lua
│       │   │   └── plugins
│       │   │       ├── activate.lua
│       │   │       ├── autosave.lua
│       │   │       ├── cheatsheet.lua
│       │   │       ├── dashboard.lua
│       │   │       ├── disabled_plugins.lua
│       │   │       ├── dropbar.lua
│       │   │       ├── example.lua
│       │   │       ├── gesture_nvim.lua
│       │   │       ├── live-server.lua
│       │   │       ├── lualine.lua
│       │   │       ├── markview_nvim.lua
│       │   │       ├── mini-animate.lua
│       │   │       ├── neo-tree.lua
│       │   │       ├── neorg.lua
│       │   │       ├── neovim.lua
│       │   │       ├── noice.lua
│       │   │       ├── nvim-cmp.lua
│       │   │       ├── nvim-notify.lua
│       │   │       ├── nvim-scrollbar.lua
│       │   │       ├── presence.lua
│       │   │       ├── tabby.lua
│       │   │       ├── telescope-media-files.lua
│       │   │       ├── telescope-tabs.lua
│       │   │       ├── telescope.lua
│       │   │       ├── tips.lua
│       │   │       ├── toggleterm.lua
│       │   │       ├── tokyonight.lua
│       │   │       ├── undotree.lua
│       │   │       ├── wakatime.lua
│       │   │       ├── whereami_nvim.lua
│       │   │       ├── yazi.lua
│       │   │       └── zen-mode.lua
│       │   └── stylua.toml
│       ├── rmpc
│       │   ├── config.ron
│       │   ├── lyrics.sh
│       │   └── themes
│       │       └── theme.ron
│       ├── systemd
│       │   └── user
│       │       ├── default.target.wants
│       │       │   ├── pipewire-pulse.service
│       │       │   └── ydotool.service
│       │       ├── dynwalla.service
│       │       ├── dynwalla.timer
│       │       ├── dynwallb.service
│       │       ├── dynwallb.timer
│       │       ├── dynwallc.service
│       │       ├── dynwallc.timer
│       │       ├── dynwalld.service
│       │       ├── dynwalld.timer
│       │       ├── sockets.target.wants
│       │       │   └── pipewire-pulse.socket
│       │       └── timers.target.wants
│       │           ├── dynwalla.timer
│       │           ├── dynwallb.timer
│       │           ├── dynwallc.timer
│       │           └── dynwalld.timer
│       ├── tmux
│       │   ├── plugins
│       │   │   └── tpm_log.txt
│       │   ├── tmux.conf
│       │   └── tmux.conf.local
│       ├── yazi
│       │   ├── flavors
│       │   │   ├── kanagawa-dragon.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── LICENSE-tmtheme
│       │   │   │   ├── README.md
│       │   │   │   ├── flavor.toml
│       │   │   │   ├── preview.png
│       │   │   │   └── tmtheme.xml
│       │   │   └── tokyo-night.yazi
│       │   │       ├── LICENSE
│       │   │       ├── LICENSE-tmtheme
│       │   │       ├── README.md
│       │   │       ├── flavor.toml
│       │   │       ├── preview.png
│       │   │       └── tmtheme.xml
│       │   ├── init.lua
│       │   ├── keymap.toml
│       │   ├── package.toml
│       │   ├── plugins
│       │   │   ├── arrow.yazi
│       │   │   │   └── main.lua
│       │   │   ├── chmod.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── diff.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── duckdb.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── exifaudio.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── eza-preview.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── full-border.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── git.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── glow.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── hexyl.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── hide-preview.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── jump-to-char.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── lazygit.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── mediainfo.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   ├── assets
│       │   │   │   │   ├── 2025-02-15-09-14-23.png
│       │   │   │   │   ├── 2025-02-15-09-15-39.png
│       │   │   │   │   ├── 2025-02-15-16-51-11.png
│       │   │   │   │   └── 2025-02-15-16-52-39.png
│       │   │   │   └── main.lua
│       │   │   ├── miller.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── mount.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── nbpreview.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── omp.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── ouch.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── restore.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── rich-preview.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── smart-enter.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── smart-filter.yazi
│       │   │   │   ├── LICENSE
│       │   │   │   ├── README.md
│       │   │   │   └── main.lua
│       │   │   ├── smart-switch.yazi
│       │   │   │   └── main.lua
│       │   │   ├── smart-tab.yazi
│       │   │   │   └── main.lua
│       │   │   └── torrent-preview.yazi
│       │   │       ├── LICENSE
│       │   │       ├── README.md
│       │   │       └── main.lua
│       │   ├── theme.toml
│       │   └── yazi.toml
│       └── zsh
│           ├── .zlogin
│           ├── .zlogout
│           ├── .zprofile
│           ├── .zshenv
│           ├── .zshrc
│           ├── README.md
│           ├── aliases
│           │   ├── CLI
│           │   │   ├── Docker
│           │   │   │   ├── docker-compose.zsh
│           │   │   │   └── docker.zsh
│           │   │   ├── Git
│           │   │   │   ├── git-lfs.zsh
│           │   │   │   └── git.zsh
│           │   │   ├── Python
│           │   │   │   ├── pip.zsh
│           │   │   │   ├── pipenv.zsh
│           │   │   │   └── python.zsh
│           │   │   ├── conda.zsh
│           │   │   ├── eza.zsh
│           │   │   ├── github_cli.zsh
│           │   │   ├── gpg.zsh
│           │   │   ├── homebrew.zsh
│           │   │   ├── macports.zsh
│           │   │   ├── npm.zsh
│           │   │   ├── podman.zsh
│           │   │   ├── rsync.zsh
│           │   │   ├── ruby.zsh
│           │   │   ├── snap.zsh
│           │   │   ├── systemd.zsh
│           │   │   ├── tmuxinator.zsh
│           │   │   ├── vscodium.zsh
│           │   │   └── yt-dlp.zsh
│           │   ├── basics
│           │   │   ├── files_n_paths.zsh
│           │   │   ├── find_files.zsh
│           │   │   └── misc.zsh
│           │   └── os
│           │       ├── arch.zsh
│           │       ├── debian.zsh
│           │       ├── fedora.zsh
│           │       └── ubuntu.zsh
│           ├── completions
│           │   ├── auto
│           │   │   └── gen_completion.bundle.zsh
│           │   └── options.zsh
│           ├── functions
│           │   ├── CLI
│           │   │   ├── Python
│           │   │   │   ├── pip.bundle.zsh
│           │   │   │   ├── pyenv.bundle.zsh
│           │   │   │   └── python.zsh
│           │   │   ├── command-not-found.bundle.zsh
│           │   │   ├── doas.bundle.zsh
│           │   │   ├── dotnet.zsh
│           │   │   ├── yazi.zsh
│           │   │   ├── yt-dlp.bundle.zsh
│           │   │   └── zoxide-eza.bundle.zsh
│           │   ├── misc
│           │   │   ├── copyfile.zsh
│           │   │   ├── copypath.zsh
│           │   │   ├── mkdircd.zsh
│           │   │   ├── torrent.zsh
│           │   │   ├── ua.zsh
│           │   │   └── updir.bundle.zsh
│           │   └── os
│           │       ├── Arch
│           │       │   └── arch.bundle.zsh
│           │       ├── Debian
│           │       │   └── debian.bundle.zsh
│           │       └── Ubuntu
│           │           └── ubuntu.bundle.zsh
│           └── plugin-opts
│               ├── alias-tips.zsh
│               ├── fzf-tab.zsh
│               ├── zsh-auto-notify.zsh
│               ├── zsh-autosuggestions.zsh
│               └── zsh-history-substring-search.zsh
├── misc
│   ├── Deus_Ex_Mankind_Divided_Background_Titan_Wave.jpg
│   ├── HyprBibataModernClassicSVG.tar.gz
│   ├── Scripts
│   │   ├── DynWalls
│   │   │   ├── scripts
│   │   │   │   ├── switchwalla.sh
│   │   │   │   ├── switchwallb.sh
│   │   │   │   ├── switchwallc.sh
│   │   │   │   └── switchwalld.sh
│   │   │   └── walls
│   │   │       ├── Windows_11_Rise_&_Fall_a.jpg
│   │   │       ├── Windows_11_Rise_&_Fall_b.jpg
│   │   │       ├── Windows_11_Rise_&_Fall_c.jpg
│   │   │       └── Windows_11_Rise_&_Fall_d.jpg
│   │   └── Utils
│   │       └── archup.sh
│   ├── Windows_3D_Emoji_14+15.ttf
│   ├── ascii-neovim-logos.txt
│   ├── cava.sh
│   ├── sametaor.omp.json
│   ├── spicetify_lucid_theme_settings.json
│   ├── titan_aug.mp4
│   └── zen-themes-export.json
└── windows
    ├── HyperV_on_HomeEdition.bat
    ├── Microsoft.PowerShell_profile.ps1
    ├── Virt_machines
    │   └── VMWare
    │       └── Windows
    │           ├── MS Windows 1.04.7z
    │           ├── MS Windows 2.11.7z
    │           └── MS Windows 3.11.7z
    ├── Windhawk mod configs
    │   ├── Slick_Window_Arrangement.yaml
    │   ├── Taskbar_Button_Scroll.yaml
    │   ├── Taskbar_Clock_Customization.yaml
    │   ├── Taskbar_Volume_Control.yaml
    │   ├── Taskbar_Wheel_Cycle.yaml
    │   ├── Taskbar_tray_icon_spacing_and_grid.yaml
    │   ├── Translucent_Windows.yaml
    │   ├── Win11_File_Explorer_Styler.yaml
    │   ├── Windows_11_Notification_Center_Styler.yaml
    │   ├── Windows_11_Start_Menu_Styler.yaml
    │   └── Windows_11_Taskbar_Styler.yaml
    ├── Windows_7x11.png
    ├── Windows_7x11ALT.png
    ├── Windows_7x11ALT_lockscr.png
    ├── autounattend.xml
    ├── post_install_steps.ps1
    ├── regconfig.reg
    ├── startlayout.json
    ├── unattend.iso
    ├── wingetinstall.json
    └── winutilconfig.json
```
</details>

## General Concepts
- **Dotfiles**—Hidden configuration files (`.bashrc`, `.zshrc`, etc.) that control the behavior of your shell, editors, and CLI environments.
- **Portable scripts**—Reusable scripts for automating setup, installation, and environment bootstrapping.
- **Consistency and extensibility**—Create a base experience that you can further tweak per-device or future OS additions.

## Getting Started

## Prerequisites
Below is a categorized, collapsible "cheat sheet" of every essential tool, covering **all major Linux distros** and **Windows/Android** platforms. If a distro or platform doesn't offer the tool, it is marked "Manual" or "Not applicable". Every line includes a description for quick scanning.

<details>
<summary><strong>🔧 System Tools & Shells</strong></summary>

| Tool                                                  | Description                                           | Arch (Pacman/yay)                                                           | Ubuntu/Debian (apt)                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Fedora/RHEL (dnf5/dnf/yum)                                                                                                                                                                                                                                                                                      | openSUSE (zypper)                                                                                                                                                                                                         | Alpine (apk)                                                                                          | NixOS (nix-env)                                                                                                                        | Gentoo (emerge)                                                                                                                                                                               | Windows (winget/scoop/choco)                                                                                           | Android/Termux                                                                                                   | Flatpak                                      | Void Linux (Xbps)                                                                                                |
|-------------------------------------------------------|-------------------------------------------------------|-----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| Bash                                                  | Unix shell                                            | `sudo pacman -S bash`/`yay -S bash-git`                                     | `sudo apt install bash`                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `sudo dnf5 install bash`                                                                                                                                                                                                                                                                                        | `sudo zypper install bash`                                                                                                                                                                                                | `apk add bash`                                                                                        | `nix-env -iA nixpkgs.bash`                                                                                                             | `emerge -a app-shells/bash`                                                                                                                                                                   | Default/MSYS2/`winget install MSYS2.MSYS2; pacman -S bash`                                                             | `pkg install bash`                                                                                               | N/A                                          | `sudo xbps-install bash`                                                                                         |
</details>
