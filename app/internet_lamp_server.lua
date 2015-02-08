require "cord"
LED = require("led")
brd = LED:new("GP0")

print("internet lamp\n")
brd:flash(4)

ipaddr = storm.os.getipaddr()
ipaddrs = string.format("%02x%02x:%02x%02x:%02x%02x:%02x%02x::%02x%02x:%02x%02x:%02x%02x:%02x%02x",
			ipaddr[0],
			ipaddr[1],ipaddr[2],ipaddr[3],ipaddr[4],
			ipaddr[5],ipaddr[6],ipaddr[7],ipaddr[8],
			ipaddr[9],ipaddr[10],ipaddr[11],ipaddr[12],
			ipaddr[13],ipaddr[14],ipaddr[15])

print("ip addr", ipaddrs)
print("node id", storm.os.nodeid())
cport = 49160--49152

storm.io.set_mode(storm.io.OUTPUT, storm.io.D4, storm.io.D5)


-- create echo server as handler
server = function()
   ssock = storm.net.udpsocket(7,
			       function(payload, from, port)
				  brd:flash(1)
				  print (string.format("from %s port %d: %s",from,port,payload))
				  if payload == "1" then
				     print("'1'")
				     storm.io.set(storm.io.HIGH, storm.io.D4)
				  end
				  if payload == "0" then
				     print("'0'")
				     storm.io.set(storm.io.LOW, storm.io.D4)
				  end

				  -- print(storm.net.sendto(ssock, payload, from, cport))
				  brd:flash(1)
			       end)
end

server()			-- every node runs the echo server


-- enable a shell
sh = require "stormsh"
sh.start()
cord.enter_loop() -- start event/sleep loop
