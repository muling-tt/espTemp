--file: init.lua

-- Set UART to 9600 baud.
-- Higher results in frequent corruption for me, may work for you tho
uart.setup(0, 9600, 8, 0, 1, 1 )

print("Init")
setup = require("setup")
config = require("config")
app = require("application")

setup.init()

