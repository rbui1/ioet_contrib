require "cord" 
sh = require "stormsh"   
LCD = require "lcd"


function lcd_setup()
	lcd = LCD:new(storm.i2c.EXT, 0x7c, storm.i2c.EXT, 0xc4)
	cord.new(function() lcd:init(2,1) lcd:setBackColor(0,0,255) lcd:writeString("hello how are you doing today, I'm doing great thanks") end)
end


lcd_setup() 
--cord.new( function () lcd:writeString("Hello") end)  
--cord.new( function() lcd:writeString("Hello") end) 


sh.start()


cord.enter_loop()
