#!/usr/bin/env bash

export WAYLAND_DISPLAY="wayland-1"
XDG_CONFIG_HOME="/home/sametaor/.config"
CONFIG_DIR="/home/sametaor/.config/ags"

switch() {
	imgpath=$1

	if [ "$imgpath" == '' ]; then
		echo 'Aborted'
		exit 0
	fi

	# ags run-js "wallpaper.set('')"
	# sleep 0.1 && ags run-js "wallpaper.set('${imgpath}')" &
	# swww img "/home/sametaor/Scripts/DynWalls/walls/Windows_11_Rise_&_Fall_c.jpg" --transition-step 100 --transition-fps 120 \
	#	--transition-type grow --transition-angle 30 --transition-duration 1 \
	#	--transition-pos "960, 540"
}

if [ "$1" == "--noswitch" ]; then
	imgpath=$(swww query | awk -F 'image: ' '{print $2}')
	# imgpath=$(ags run-js 'wallpaper.get(0)')
elif [[ "$1" ]]; then
	switch '/home/sametaor/Scripts/DynWalls/walls/Windows_11_Rise_&_Fall_c.jpg'
#else
	# Select and set image (hyprland)

#    cd "$(xdg-user-dir PICTURES)" || return 1
	 switch '/home/sametaor/Scripts/DynWalls/walls/Windows_11_Rise_&_Fall_c.jpg'
fi

# Generate colors for ags n stuff
"/home/sametaor/.config/ags/scripts/color_generation/colorgen.sh" "/home/sametaor/Scripts/DynWalls/walls/Windows_11_Rise_&_Fall_c.jpg" --apply --smart


sleep 3
swww img "/home/sametaor/Scripts/DynWalls/walls/Windows_11_Rise_&_Fall_c.jpg" --transition-step 100 --transition-fps 120 --transition-type grow --transition-angle 30 --transition-duration 1  --transition-pos "960, 540"