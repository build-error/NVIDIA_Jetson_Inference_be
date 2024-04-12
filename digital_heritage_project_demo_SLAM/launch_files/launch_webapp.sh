#!/bin/bash

echo "dheritage" | figlet

# Check if the first argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <mode: {recorded, webcam2}>"
    exit 1
fi

# Perform actions based on the selected mode
if [ "$1" = "recorded" ]; then
    echo "MODE: recorded mode"
    settingsFileName='test_recorded.yaml'
elif [ "$1" = "webcam2" ]; then
    echo "MODE: webcam2 mode"
    settingsFileName='test_webcam_2.yaml'
else
    echo "Invalid mode: $1"
    exit 1
fi

# Use the ip command to get the IP address of the default gateway
gateway_ip=$(ip route | grep default | awk '{print $3}')

# Use the ip command again to get the IP address associated with the default gateway's interface
hostip=$(ip -4 addr show dev $(ip route | grep default | awk '{print $5}') | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Display the obtained IP address
echo "IP address of the network: $network_ip"

read_yaml() {
    local yaml_file="$1"
    local key="$2"
    grep "$key:" "$yaml_file" | awk -F ': ' '{print $2}'
}

cd ../

settingsDirectory="ORB_SLAM3/Examples/Monocular/Setup_Files/"$settingsFileName
hostip=$network_ip
portNum=$(read_yaml "$settingsDirectory" portNum)
# Remove quotes from hostip and portNum
hostip="${hostip//\"/}"  # Remove double quotes
portNum="${portNum//\"/}"  # Remove double quotes
echo "Value of hostip is: $hostip"
echo "Value of portNum is: $portNum"

hostAddr="$hostip:$portNum"

url="http://$hostAddr/"

echo "launch dheritage webapp"
cd Digital\ Heritage\ app/new_app/dheritage

python manage.py runserver $hostAddr
# xdg-open "$url"