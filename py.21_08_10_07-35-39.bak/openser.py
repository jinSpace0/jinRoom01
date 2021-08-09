ser=serial.Serial("/dev/rfcomm0",9600,timeout=0.5)
ser.open()
print ser.name
print ser.port
print ser.baudrate
print ser.bytesize
print ser.parity
print ser.stopbits
print ser.timeout
print ser.writeTimeout
print ser.xonxoff
print ser.rtscts
print ser.dstrtr
print ser.interCharTimeout
ser.close()
