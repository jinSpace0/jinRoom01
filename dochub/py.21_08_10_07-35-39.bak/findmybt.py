import bluetooth
target_name="BT-04"
target_address=None	
#target_address=28C671009B1C	
nearby_devices=bluetooth.discover_devices()
for bdaddr in nearby_devices:
    if target_name==bluetooth.lookup_name(bdaddr):
        target_address=bdaddr
        break
    if target_address is not None:
        print("found target bluetooth device with address", target_address)
    else:
        print("could not find target blue tooth device nearby")

