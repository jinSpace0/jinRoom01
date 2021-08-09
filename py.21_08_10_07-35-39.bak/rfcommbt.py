import bluetooth
if __name__ == "__main__":
    print("looking for nearby devices...")
    nearby_devices=bluetooth.discover_devices(lookup_names=True)
    for addr,name in nearby_devices:
        print("%s %s" %(addr,name))
        server_sock=bluetooth.BluetoothSocket(bluetooth.RFCOMM)
        server_sock.bind((" ",bluetooth.PORT_ANY))
        server_sock.listen(1)
        port=server_sock.getsockname()[1]
        uuid="00001101-0000-1000-8000-00805F9B34FB"
        bluetooth.advertise_service(server_sock,"SampleServer",service_id=uuid)
        print("Waiting for connection on RFCOMM channel %d" %port)
        client_sock,client_info=server_sock.accept()
        print(client_info)
        try:
            while True:
                data=client_sock.recv(1024)
                if len(data)==0:
                    break
                print("received [%s]" %data)
        except IOError:
            pass
        client_sock.close()
        server_sock.close()
        print("this test is done!")

