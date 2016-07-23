--file: application.lua
local module = {}
m = nil

-- Get temperature and humidity from DHT-22
local function read_dht()
  status, temp, hum, temp_dec, humi_dec = dht.read(config.DHT_PIN)
  if status == dht.OK then
  print("DHT temp: ".. temp .. ";" .. "hum: " .. hum)
  elseif status == dht.ERROR_CHECKSUM then
    print("ERROR: DHT checksum")
  elseif status == dht.ERROR_TIMEOUT then
    print("ERROR: DHT Timeout. Sensor connected to pin " .. config.DHT_PIN .. "?")
    hum = "err, DHT"
    temp = "err, DHT"
  end
end


-- Publish to MQTT broker
local function publish()
  read_dht()
  m:publish(config.TOPIC .. "hum",hum,0,0)
  m:publish(config.TOPIC .. "temp",temp,0,0)
end


-- Register with MQTT broker, subscribe to ID topic
local function mqtt_register()
  m:subscribe(config.ID,0, function(con)
    print("MQTT Subscribed to: " .. config.ID)
  end)
end


-- Run MQTT connect & publish loop
local function mqtt_run()
  m = mqtt.Client(config.ID, 60)
  m:connect(config.MQTT_HOST, config.MQTT_PORT, 0, 1, function(conn)
  mqtt_register()
  publish()
  tmr.stop(2)
  tmr.alarm(2, 60000, 1, publish)  
  end)
end


function module.run()
  mqtt_run()
end

return module
