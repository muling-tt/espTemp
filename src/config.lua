-- file: config.lua
local module = {}

module.SSID = {}
module.SSID["WiFI SSID"] = "WiFi Password"
module.MQTT_HOST = "mqtt"
module.MQTT_PORT = 1883
module.TOPIC = "/env/" .. "hackcenter" .. "/"
module.ID = "ESP-" .. node.chipid()
module.DHT_PIN = "4"
module.DEBUG = false

return module
