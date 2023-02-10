echo "WIFI:$(ifconfig wlan0 | grep ssid | cut -d " " -f 2 ) | IP:$(ifconfig wlan0 | grep inet | cut -d " " -f 2)"
