# ups-json-publisher
UPS Data Publisher for MQTT: Capture UPS details using upsc, format as JSON, and send to MQTT broker.

## Usage
1. **Clone the Repository:**
```
git clone https://github.com/filipnet/ups-json-publisher.git
cd ups-json-publisher
```

2. **Configure MQTT Broker Settings:**
Copy the example configuration file:
```
cp config.sh.example config.sh
```
Open config.sh in a text editor (e.g., nano, vim) and replace placeholders with your actual MQTT broker information.

3. **Run the Script:**
Make sure the required dependencies are installed: upsc (part of Network UPS Tools) and mosquitto_pub (part of Mosquitto MQTT client).

Run the script with the device name as an argument:
```
./mqtt_upsc_script.sh <device_name>
```
Important: Protect Your Configuration:

The config.sh file contains sensitive information. Make sure not to expose your credentials by adding config.sh to the .gitignore file. Never commit the actual config.sh to the repository.

## Dependencies
- Network UPS Tools
- Mosquitto MQTT Client

## License
This project is licensed under the BSD 3-Clause License.