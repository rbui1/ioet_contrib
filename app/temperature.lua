require "cord" -- scheduler / fiber library
LCD = require("lcd")
TEMP = require("temp")
require("storm") 

handle = nil; 
C_temp_value = 0;
function temp_setup()
	temp = TEMP:new()
	cord.new(function() temp:init() end)
end

temp_setup();



 --ord.new(function() temp_value = temp:getTemp() end) 
printTemp = function()
cord.new(function()	C_temp_value = temp:getTemp()  end) 
	print(C_temp_value, "degrees Celcius")
	F_temp_value =  (C_temp_value * 9 / 5 + 32) 
	print(F_temp_value, "degrees Fahrenheit")	 
end

if handle == nil then 
	handle = storm.os.invokePeriodically( 1 * storm.os.SECOND,  printTemp ) 
end 
-- enable a shell
sh = require "stormsh"
sh.start()
cord.enter_loop() -- start event/sleep loop
