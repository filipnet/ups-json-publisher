#!/bin/bash

################################################################################
# This script retrieves UPS (Uninterruptible Power Supply) information using the
# upsc command, converts it to JSON format, and publishes it to an MQTT broker.
#
# Usage: ./mqtt_upsc_script.sh <device_name>
#
# The script requires the upsc command to be installed, and it uses mosquitto_pub
# to publish the JSON output to an MQTT broker. Configuration details are kept
# in the 'config.sh' file. Make sure to set the appropriate MQTT broker settings
# in the 'config.sh' file before running the script.
################################################################################

# Set environment variable for the directory
UPS_JSON_PUBLISHER_DIR="/root/ups-json-publisher"

# Check if the script was called with a device name as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <device_name>"
    exit 1
fi

# Extract device name from the argument
device_name=$1

# Execute the `upsc` command and store the output in a variable
upsc_output=$(upsc "$device_name" 2>/dev/null)

# Check if the device is reachable
if [ -z "$upsc_output" ]; then
    echo "The device '$device_name' could not be reached."
    exit 1
fi

# Convert output to JSON format
json_output="{"
while IFS=: read -r key value; do
    key=$(echo "$key" | sed 's/^[ \t]*//;s/[ \t]*$//')
    value=$(echo "$value" | sed 's/^[ \t]*//;s/[ \t]*$//')
    json_output+="\"$key\":\"$value\","
done <<< "$upsc_output"
json_output="${json_output%,}"  # Remove the trailing comma
json_output+="}"

# Display JSON output
echo "$json_output"

# Load configuration variables
source "$UPS_JSON_PUBLISHER_DIR/config.sh"

# Publish JSON output to MQTT broker
echo "$json_output" | mosquitto_pub -h "$mqtt_broker" -p "$mqtt_port" -u "$mqtt_username" -P "$mqtt_password" -i "$mqtt_client_id" -t "$mqtt_topic" -l
