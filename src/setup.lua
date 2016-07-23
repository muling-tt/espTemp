--file: setup.lua
local module = {}

local function wifi_lease_wait()
  if wifi.sta.getip() == nil then
    print("Waiting for DHCP")
  else
    tmr.stop(1)
    print("IP: " .. wifi.sta.getip())
    print("MAC: " .. wifi.ap.getmac())
    print("MODE: " .. wifi.getmode())
    print("ID: "..config.ID)
    print("TOPIC: "..config.TOPIC)
    app.run()
  end
end


local function wifi_connect(list_aps)
  print("WiFi Connecting...")
  if list_aps then
    for key,value in pairs(list_aps) do  
      if config.SSID and config.SSID[key] then
        print("AP found, Associating...")
        wifi.setmode(wifi.STATION);
        wifi.sta.config(key,config.SSID[key])
        wifi.sta.connect()
        tmr.alarm(1, 5000, 1, wifi_lease_wait)
      end
    end
  else
    print("AP association error")
  end
end

function module.run()
  wifi.setmode(wifi.STATION);
  wifi.sta.getap(wifi_connect)
end

return module
  
  
  
    
      
      



    

    
    
