#!/usr/bin/env bash

source ./functions/colors.sh

requirements(){
    if ! [ -x "$(command -v autorandr)" ]; then
        echo "${BYELLOW}Autorandr${NC} is required to properly save & re-apply profiles, both manually & automatically."
        echo ""
        echo "Attempting to install now..."
        sudo apt install autorandr
        echo ""
        read -p "${YELLOW}Press Enter to resume ...${NC}"
    fi
}

save(){
    echo "${YELLOW}Will now save your current scaled resolution ${NC}${GREEN}$1${NC}${YELLOW}."
    echo ""
    echo -n "Set profile name [${GREEN}default${NC}${YELLOW}]:${NC} "
    read profile
    # echo "$profile"
    if [[ $profile = "" ]]; then
        profile="default"
    fi
    autorandr --save "$profile" --force
    grep -q "/usr/bin/sleep 5 && autorandr -c&" ~/.xsessionrc
    if [ $? -eq 1 ]; then
        echo "/usr/bin/sleep 5 && autorandr -c&" > ~/.xsessionrc
    fi
    read -p "${YELLOW}Press Enter to finish ...${NC}"
}

fallback(){
    autorandr | grep -q fallback
    if [ $? -eq 1 ]; then
        echo "Fallback profile not found. Will create one."
        autorandr --save fallback
        cp ./functions/block ~/.config/autorandr/fallback/block
        read -p "${YELLOW}Press Enter to resume ...${NC}"
    fi
}

main() {
    echo "${BBLUE}betterScale v0.1${NC}"
    echo "----------------"
    echo "The missing resolution and proper scaling utility."
    echo "Designed for Gnome and Budgie running on x11."
    echo ""
    echo "Uses a similar concept as scaling on macs."
    echo "Enables experimental scaling support & increases the framebuffer."
    echo "Then betterScale will scale the framebuffer back down."
    echo ""
    read -p "${YELLOW}Press Enter to resume ...${NC}"
    clear
    requirements
    fallback
    clear
    echo ""
    echo "${BRED}Warning:${NC} There is a small chance that your session could freeze when changing scale."
    echo ""
    echo "If this happens press ${BGREEN}Ctrl+Alt+F2${NC} & run ${YELLOW}'kill -9 -1'${NC} to logout & back in."
    echo "Then presss ${BGREEN}Ctrl+Alt+F7${NC} to go back to your GUI session."
    echo ""
    echo "Lastly apply a different scaling & then apply the one you originally wanted."
    echo "That will most likely avoid the glitch & you needing to reboot your system."
    echo ""
    read -p "${YELLOW}Press Enter to resume ...${NC}"
    echo ""
    clear

    FILE=/usr/share/X11/xorg.conf.d/20-intel.conf
    if ! test -f "$FILE"; then
        echo "${BWHITE}Tearing & mouse flicker fix for intel GPUs is not found. Would you like to apply it?${NC}"
        question="This will copy 20-intel.conf to /usr/share/X11/xorg.conf.d/"
        choices=(*yes no)
        response=$(prompt "$question" $choices)
        if [ "$response" == "y" ];then
            echo "Copying..."
            sudo cp ./20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf
            echo "Please logoff and back on & maybe reboot to see changes."
            exit 0
        fi
    else
        echo "Checking if 20-intel.conf is the same."
        DIFF=$(diff -w ./20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf) 
        if [ "$DIFF" != "" ]; then
            echo "${BWHITE}An 20-intel.conf file is found but differs, would you like to overwrite it?${NC}"
            question="This will copy 20-intel.conf to /usr/share/X11/xorg.conf.d/"
            choices=(*yes no)
            response=$(prompt "$question" $choices)
            if [ "$response" == "y" ];then
                echo "Copying..."
                sudo cp /usr/share/X11/xorg.conf.d/20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf.bak
                sudo cp ./20-intel.conf /usr/share/X11/xorg.conf.d/20-intel.conf
                echo "Please logoff and back on & maybe reboot to see changes."
                exit 0
            fi
        else
            echo "File matches, tearing & mouse flicker fix already applied."
        fi
    fi


    # Find if file exist
    # copy if doesn't
    # /usr/share/X11/xorg.conf.d/20-intel.conf
    # if it does see if it matches existing file

    # Grab all relevant information
    # xrandr | grep -w connected  | awk -F'[ \+]' '{print $1","$3","$4","$5","$6}'
    IFS=',' read -r -a monitor_settings <<< `xrandr | grep -w connected  | awk -F'[ \+]' '{print $1","$3","$4","$5","$6}'`
    # echo "${monitor_settings[@]}"
    # Grab native screen resolution
    # xrandr --current | grep '*' | uniq | awk '{print $1}'

    IFS='x' read -r -a native <<< `xrandr --current | grep '*' | uniq | awk '{print $1}'`

    res0_width=$(echo "${native[0]}")
    res0_height=$(echo "${native[1]}")
    res1_width=$(echo "${native[0]}*1.1" | bc)
    res1_height=$(echo "${native[1]}*1.1" | bc)
    res2_width=$(echo "${native[0]}*1.2" | bc)
    res2_height=$(echo "${native[1]}*1.2" | bc)
    res3_width=$(echo "${native[0]}*1.3" | bc)
    res3_height=$(echo "${native[1]}*1.3" | bc)
    res4_width=$(echo "${native[0]}*1.4" | bc)
    res4_height=$(echo "${native[1]}*1.4" | bc)
    res5_width=$(echo "${native[0]}*1.5" | bc)
    res5_height=$(echo "${native[1]}*1.5" | bc)
    res6_width=$(echo "${native[0]}*1.6" | bc)
    res6_height=$(echo "${native[1]}*1.6" | bc)
    res7_width=$(echo "${native[0]}*1.7" | bc)
    res7_height=$(echo "${native[1]}*1.7" | bc)
    res8_width=$(echo "${native[0]}*1.8" | bc)
    res8_height=$(echo "${native[1]}*1.8" | bc)
    res9_width=$(echo "${native[0]}*1.9" | bc)
    res9_height=$(echo "${native[1]}*1.9" | bc)
    res10_width=$(echo "${native[0]}*2" | bc)
    res10_height=$(echo "${native[1]}*2" | bc)


    res11_width=$(echo "${native[0]}*1.25" | bc)
    res11_height=$(echo "${native[1]}*1.25" | bc)
    res12_width=$(echo "${native[0]}*1.75" | bc)
    res12_height=$(echo "${native[1]}*1.75" | bc)

    echo ""
    echo "% scale based on perception"
    echo "-----------------"
    echo "${YELLOW} 0:${NC} 200%: ${GREEN}"$((${res0_width%.*}/2))"x"$((${res0_height%.*}/2))"${NC}"
    echo "${YELLOW} 1:${NC} 190%: ${GREEN}"$((${res1_width%.*}/2))"x"$((${res1_height%.*}/2))"${NC}"
    echo "${YELLOW} 2:${NC} 180%: ${GREEN}"$((${res2_width%.*}/2))"x"$((${res2_height%.*}/2))"${NC}"
    echo "${YELLOW} 3:${NC} 170%: ${GREEN}"$((${res3_width%.*}/2))"x"$((${res3_height%.*}/2))"${NC}"
    echo "${YELLOW} 4:${NC} 160%: ${GREEN}"$((${res4_width%.*}/2))"x"$((${res4_height%.*}/2))"${NC}"
    echo "${YELLOW} 5:${NC} 150%: ${GREEN}"$((${res5_width%.*}/2))"x"$((${res5_height%.*}/2))"${NC}"
    echo "${YELLOW} 6:${NC} 140%: ${GREEN}"$((${res6_width%.*}/2))"x"$((${res6_height%.*}/2))"${NC}"
    echo "${YELLOW} 7:${NC} 130%: ${GREEN}"$((${res7_width%.*}/2))"x"$((${res7_height%.*}/2))"${NC}"
    echo "${YELLOW} 8:${NC} 120%: ${GREEN}"$((${res8_width%.*}/2))"x"$((${res8_height%.*}/2))"${NC}"
    echo "${YELLOW} 9:${NC} 110%: ${GREEN}"$((${res9_width%.*}/2))"x"$((${res9_height%.*}/2))"${NC}"
    echo "${YELLOW}10:${NC} 100%: ${GREEN}"$((${res10_width%.*}/2))"x"$((${res10_height%.*}/2))"${NC}"

    echo ""
    echo "In between quarter scales"
    echo "-----------------"
    echo "${YELLOW}11:${NC} Scale 175%: ${GREEN}"$((${res11_width%.*}/2))"x"$((${res11_height%.*}/2))"${NC}"
    echo "${YELLOW}12:${NC} Scale 125%: ${GREEN}"$((${res12_width%.*}/2))"x"$((${res12_height%.*}/2))"${NC}"
    echo ""
    echo "Exit"
    echo "-----"
    echo "13 or Q"
    # echo "Scale 10%: "${res1_width}"x"${res1_height}
    # echo "Scale 120%: "${res2_width}"x"${res2_height}

    echo -n "${YELLOW}Please select an option [0-13]:${NC} "
    read resolution

    # Check these and apply if needed
    # gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
    # gsettings set org.gnome.desktop.interface scaling-factor 2

    if [[ $resolution -lt 10 ]] || [[ $resolution -gt 10 ]]; then
        gsettings get org.gnome.settings-daemon.plugins.xsettings overrides | grep -q "'Gdk/WindowScalingFactor': <2>"
        if [ $? -eq 1 ]; then
            question="To continue you will need to apply experimental GDK WindowScalingFactor of 2. Apply now?"
            choices=(*yes no)
            response=$(prompt "$question" $choices)
            if [ "$response" == "y" ];then
                echo "Applying experimental GDK WindowScalingFactor 2..."
                gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]"
                gsettings set org.gnome.desktop.interface scaling-factor 2
                echo "Please logoff and back on."
            else
                echo "Cancelling. Will not continue."
            fi
            exit 0
        fi
    else
        gsettings get org.gnome.settings-daemon.plugins.xsettings overrides | grep -q "'Gdk/WindowScalingFactor': <2>"
        if [ $? -eq 0 ]; then
            echo "Removing experimental GDK WindowScalingFactor 2..."
            gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "@a{sv} {}"
            gsettings set org.gnome.desktop.interface scaling-factor 0
            echo "Applying 100%: "$((${res10_width%.*}/2))"x"$((${res10_height%.*}/2))
            echo "Removed experimental GDK scaling, no xrandr scaling needed."
            echo "Please logoff and back on."
        fi
    fi

    case $resolution in

    0)
        newRes=$((${res0_width%.*}/2))"x"$((${res0_height%.*}/2))
        echo "Applying 200%: $newRes"
        echo "xrandr --fb "$((${res0_width%.*}))"x"$((${res0_height%.*}))" --output ${monitor_settings[0]} --scale 1x1 --pos 0x0"
        xrandr --fb "$((${res0_width%.*}))"x"$((${res0_height%.*}))" --output "${monitor_settings[0]}" --scale 1x1 --pos 0x0
        ;;
    1)
        newRes=$((${res1_width%.*}/2))"x"$((${res1_height%.*}/2))
        echo "Applying 190%: $newRes"
        echo "xrandr --fb "$((${res1_width%.*}))"x"$((${res1_height%.*}))" --output ${monitor_settings[0]} --scale 1.1x1.1 --pos 0x0"
        xrandr --fb "$((${res1_width%.*}))"x"$((${res1_height%.*}))" --output "${monitor_settings[0]}" --scale 1.1x1.1 --pos 0x0
        ;;
    2)
        newRes=$((${res2_width%.*}/2))"x"$((${res2_height%.*}/2))
        echo "Applying 180%: $newRes"
        echo "xrandr --fb "$((${res2_width%.*}))"x"$((${res2_height%.*}))" --output ${monitor_settings[0]} --scale 1.2x1.2 --pos 0x0"
        xrandr --fb "$((${res2_width%.*}))"x"$((${res2_height%.*}))" --output "${monitor_settings[0]}" --scale 1.2x1.2 --pos 0x0
        ;;
    3)
        newRes=$((${res3_width%.*}/2))"x"$((${res3_height%.*}/2))
        echo "Applying 170%: $newRes"
        echo "xrandr --fb "$((${res3_width%.*}))"x"$((${res3_height%.*}))" --output ${monitor_settings[0]} --scale 1.3x1.3 --pos 0x0"
        xrandr --fb "$((${res3_width%.*}))"x"$((${res3_height%.*}))" --output "${monitor_settings[0]}" --scale 1.3x1.3 --pos 0x0
        ;;
    4)
        newRes=$((${res4_width%.*}/2))"x"$((${res4_height%.*}/2))
        echo "Applying 160%: $newRes"
        echo "xrandr --fb "$((${res4_width%.*}))"x"$((${res4_height%.*}))" --output ${monitor_settings[0]} --scale 1.4x1.4 --pos 0x0"
        xrandr --fb "$((${res4_width%.*}))"x"$((${res4_height%.*}))" --output "${monitor_settings[0]}" --scale 1.4x1.4 --pos 0x0
        ;;
    5)
        newRes=$((${res5_width%.*}/2))"x"$((${res5_height%.*}/2))
        echo "Applying 150%: $newRes"
        echo "xrandr --fb "$((${res5_width%.*}))"x"$((${res5_height%.*}))" --output ${monitor_settings[0]} --scale 1.5x1.5 --pos 0x0"
        xrandr --fb "$((${res5_width%.*}))"x"$((${res5_height%.*}))" --output "${monitor_settings[0]}" --scale 1.5x1.5 --pos 0x0
        ;;
    6)
        newRes=$((${res6_width%.*}/2))"x"$((${res6_height%.*}/2))
        echo "Applying 140%: $newRes"
        echo "xrandr --fb "$((${res6_width%.*}))"x"$((${res6_height%.*}))" --output ${monitor_settings[0]} --scale 1.6x1.6 --pos 0x0"
        xrandr --fb "$((${res6_width%.*}))"x"$((${res6_height%.*}))" --output "${monitor_settings[0]}" --scale 1.6x1.6 --pos 0x0
        ;;
    7)
        newRes=$((${res7_width%.*}/2))"x"$((${res7_height%.*}/2))
        echo "Applying 130%: $newRes"
        echo "xrandr --fb "$((${res7_width%.*}))"x"$((${res7_height%.*}))" --output ${monitor_settings[0]} --scale 1.7x1.7 --pos 0x0"
        xrandr --fb "$((${res7_width%.*}))"x"$((${res7_height%.*}))" --output "${monitor_settings[0]}" --scale 1.7x1.7 --pos 0x0
        ;;
    8)
        newRes=$((${res8_width%.*}/2))"x"$((${res8_height%.*}/2))
        echo "Applying 120%: $newRes"
        echo "xrandr --fb "$((${res8_width%.*}))"x"$((${res8_height%.*}))" --output ${monitor_settings[0]} --scale 1.8x1.8 --pos 0x0"
        xrandr --fb "$((${res8_width%.*}))"x"$((${res8_height%.*}))" --output "${monitor_settings[0]}" --scale 1.8x1.8 --pos 0x0
        ;;
    9)
        newRes=$((${res9_width%.*}/2))"x"$((${res9_height%.*}/2))
        echo "Applying 110%: $newRes"
        echo "xrandr --fb "$((${res9_width%.*}))"x"$((${res9_height%.*}))" --output ${monitor_settings[0]} --scale 1.9x1.9 --pos 0x0"
        xrandr --fb "$((${res9_width%.*}))"x"$((${res9_height%.*}))" --output "${monitor_settings[0]}" --scale 1.9x1.9 --pos 0x0
        ;;
    11)
        newRes=$((${res11_width%.*}/2))"x"$((${res11_height%.*}/2))
        echo "Applying 175%: $newRes"
        echo "xrandr --fb "$((${res11_width%.*}))"x"$((${res11_height%.*}))" --output ${monitor_settings[0]} --scale 1.25x1.25 --pos 0x0"
        xrandr --fb "$((${res11_width%.*}))"x"$((${res11_height%.*}))" --output "${monitor_settings[0]}" --scale 1.25x1.25 --pos 0x0
        ;;
    12)
        newRes=$((${res12_width%.*}/2))"x"$((${res12_height%.*}/2))
        echo "Applying 125%: $newRes"
        echo "xrandr --fb "$((${res12_width%.*}))"x"$((${res12_height%.*}))" --output ${monitor_settings[0]} --scale 1.75x1.75 --pos 0x0"
        xrandr --fb "$((${res12_width%.*}))"x"$((${res12_height%.*}))" --output "${monitor_settings[0]}" --scale 1.75x1.75 --pos 0x0
        ;;
    13)
        exit 0
        ;;
    q)
        exit 0
        ;;
    Q)
        exit 0
        ;;
    *)
        echo "unknown"
        ;;
    esac

    # Add in confirmation that user screen resolution has been changed
    # If no confirmation and recieved back to a gxmessage prompt then revert user back to original sreen resolution.
    # The assumption will be that it failed to work.
    save
}

source ./functions/prompt.sh

main "$@"; exit