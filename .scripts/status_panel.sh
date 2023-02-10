#!/usr/local/bin/bash

PANEL_FONT_0="-misc-tamsyn-medium-r-normal-*-15-108-100-100-c-80-iso8859-1"

#this second font is for icons. If they are not displayed, then you need to setup UTF8 locale
PANEL_FONT_1="-wuncon-siji-medium-r-normal-*-10-100-75-75-c-80-iso10646-1"

PANEL_FIFO=/tmp/panel-fifo
PANEL_HEIGHT=16

#everforest style
COLOR_DEFAULT_BG="#2f383e"
COLOR_DEFAULT_FG="#b9b9b9"
#COLOR_ICONS_FG="#a7c080"

#wombat style
#COLOR_DEFAULT_BG="#101010"
#COLOR_DEFAULT_FG="#b9b9b9"

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

info_battery(){
	STATE="$(sysctl hw.acpi.battery.state | awk '{ print $2 }')"
	CHARGE="$(sysctl hw.acpi.battery.life | awk '{ print $2 }')"

	case $STATE in
			1)
				#discharging
				OUTPUT="\ue1fe $CHARGE"
				;;
			2)
				#charging
				OUTPUT="\ue200 $CHARGE"
				;;
			7)
				#no battery attached, plugged.
				OUTPUT="\ue041 N/A"
				;;
			0)
				#fully charged, or at least we think so
				OUTPUT="\ue041 $CHARGE"
				;;
			*)
				OUTPUT="ERR"
				;;
	esac
	printf "$OUTPUT"
	printf "%s" "%"
}

info_network_status(){
	WIFI_INFO=$(ifconfig wlan0)
	WIFI_STATUS=$(printf "%s\\n" "$WIFI_INFO" | grep -w "status:" | awk '{ print $2 }')
	SSID=$(printf "%s\\n" "$WIFI_INFO" | grep -w "ssid" | awk '{ print $2 }')

	ETH_INFO=$(ifconfig em0)
	ETH_STATUS=$(printf "%s\\n" "$ETH_INFO" | grep -w "status:" | awk '{ print $2 }')

	if [ "$WIFI_STATUS" = "associated" ] && [ "$ETH_STATUS" = "no" ]
	then
		printf "\ue14b %s" "${SSID}"
	elif [ "$WIFI_STATUS" = "associated" ] && [ "$ETH_STATUS" = "active" ]
	then
		printf "\ue149 Wired"
	else
		printf "\ue0c6 Down"
	fi

	printf "%s\n" " |"
}

info_volume(){
	GETVOL="$(mixer | grep vol | awk '{ print $7 }' | grep -o '^[^:]*')"
	
	#this is for headphones icon: \ue04d
	printf "\ue05d "
	printf "%s\\n" "${GETVOL}% |"
}

info_time_date(){
	TTIME=$(date +"%H:%M")
	TDATE=$(date +"%m-%d-%Y")

	printf "\ue017 %s | %s \ue225" "$TTIME" "$TDATE"
}

info_cpu(){
	USEDCPU=$(top -n | grep -w "CPU" | awk '{ print $2+$4+$6+$8 }')
	
	printf "\ue021"
	printf "%s\\n" " ${USEDCPU}% |"
}

info_ram(){
	#check fix when some outputs are KB instead of MB
	RAM_TOP=$(top -n | grep -w "Mem" | grep -o '\b[0-9MK]*\b' | tr '\n' ' ')
	USEDRAM=0
	for value in $RAM_TOP; do
		temp=$( echo "${value}" | grep -o '[K]')
		if [ -z "${temp}" ]; then
				num=$( echo "${value}" | grep -o '[0-9]' | tr -d '\n' )
				USEDRAM=$(( $USEDRAM + $num ))
		fi
	done
	TOTALRAM=$(dmesg | grep -E '^avail memory' | cut -d'(' -f2 | cut -d')' -f1 | awk '{ print $1 }' | sed -n 1p)
	PRCNTUSED=$(awk -v u=$USEDRAM -v t="${TOTALRAM}" 'BEGIN{print 100 * u / t}' | awk -F. '{ print $1"."substr($2,1,2) }')

	printf "\ue224"
	printf "%s\\n" " ${PRCNTUSED}% |"
}


info_disk_space(){
	AVAIL=$(df -H / | grep -w "ROOT" | awk '{ print $4 }' | awk -F'[A-Z]' '{print $1}')
	#TOTAL=$(df -H / | grep -w "default" | awk '{ print $2 }' | awk -F'[A-Z]' '{print $1}')

	printf "\ue1e0 %sGB " "${AVAIL}"
}

#this requires coretemp or amdtemp loaded with kldload or in boot/loader.conf to work
info_cpu_temp(){
	CURRENT=$(sysctl dev.cpu.0.temperature | awk '{ print $2 }')

	#printf "%{F${COLOR_ICONS_FG}\ue01d}"
	printf "\ue01d"
	printf "%s" " ${CURRENT} |"
}

info_focused_monitor(){
	focused=$(bspc wm -g | grep -o ':[OF][A-Z0-9]*'| sed 's/:[OF]//')

	#case $focused in
	#1)
	#	icon="\ue187"
	#	;;
	#2)
	#	icon="\ue188"
	#	;;
	#3)
	#	icon="\ue189"
	#	;;
	#4)
	#	icon="\ue18a"
	#	;;
	#5)
	#	icon="\ue18b"
	#	;;
	#esac

	#printf "%s\n" "${icon} |" >> ./bar-log
	printf "\ue255"
	
	#this can print an icon number. too small for HD. looking for alternatives.
	#printf "$icon"
	#printf "%s\n" " |"
	
	printf "%s\n" " ${focused} |"
}

info_cpu > "$PANEL_FIFO" &
info_ram > "$PANEL_FIFO" &
info_cpu_temp > "$PANEL_FIFO" &
info_disk_space > "$PANEL_FIFO" &
info_time_date > "$PANEL_FIFO" &
info_focused_monitor > "$PANEL_FIFO" &
info_network_status > "$PANEL_FIFO" &
info_volume > "$PANEL_FIFO" &
info_battery > "$PANEL_FIFO" &


panel_bar()
{
	while true; do
			BAR_INPUT="%{l} CPU:$(info_cpu) Temp:$(info_cpu_temp) RAM:$(info_ram) Disk:$(info_disk_space) %{c}$(info_time_date) %{r} $(info_focused_monitor) Net:$(info_network_status) Vol:$(info_volume) Battery:$(info_battery)  "
		printf "%s\\n" "$BAR_INPUT"
	sleep 1
	done
}

panel_bar < "$PANEL_FIFO" | lemonbar -f "${PANEL_FONT_0}" -f "${PANEL_FONT_1}" -g x$PANEL_HEIGHT -F $COLOR_DEFAULT_FG -B $COLOR_DEFAULT_BG &

wait

