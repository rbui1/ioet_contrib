require "cord"


function scan_i2c()
    for i=0x00,0xFE,2 do
        local arr = storm.array.create(1, storm.array.UINT8)
        local rv = cord.await(storm.i2c.read,  storm.i2c.INT + i,  
                        storm.i2c.START + storm.i2c.STOP, arr)
        if (rv == storm.i2c.OK) then
            print (string.format("Device found at 0x%02x",i ));
        end
    end
end

cord.new(function() scan_i2c() end)



cord.enter_loop()
