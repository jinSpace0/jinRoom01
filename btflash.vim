"=== python pybluez2 problem total 
  1.no advertisable device
    causeby:bluetooth invisiable
    dealwith:add code during error occur. turn on bluetooth visible.
    following:
      sudo bluetoothctl << EOF
      discoverable on
      pairable on
      exit
    ref:https://stackoverflow.com/questions/63788077/how-can-i-make-raspberry-pis-bluetooth-discoverable-to-iphone
  2.no such file or directory
    causeby:bug of bluez, need xxx mode bluetooth.  
    dealwith:add some code encount this problem, and modify relative files, and restart service.
    following:
      sudo vim /etc/systemd/system/dbus-org.bluez.service   "this nosuit me debian 10 buster
      or:sudo vim /lib/systemd/system/bluetooth.service    "this is ok to me
      "do change 'ExecStart=/usr/lib/bluetooth/bluetoothd' to
      "'ExecStart=/usr/lib/bluetooth/bluetoothd -C'
      sudo systemctl daemon-reload
      sudo systemctl restart bluetooth
      sudo sdptool add SP         "check '/var/run/sdp' should be generated
    ref:https://stackoverflow.com/questions/36675931/bluetooth-btcommon-bluetootherror-2-no-such-file-or-directory
  3.perminssion denied
    causeby:'sdp' has no root right.
    dealwith:just do by root.
    dealvith2:Running your script as root kinda works,but it's not a good practice.
    according to this thread, you just need to adjust permissions to the /var/run/sdp file (which is created when using\
    the --compat switch).
    so, to prevent link rot i'm reproducing dlech's post and adapting it to Raspberry Pi:
    step 1:make sure your pi user is in the bluetooth group:
      cat /etc/group|grep bluetooth
        bluetooth:x:113:pi
      1.1 if it's not ,add pi to bluetooth group:
        sudo usermod -G bluetooth -a pi
    step 2:change group of the '/var/run/sdp' file
        sudo chgrp bluetooth /var/run/sdp
    step 3:to make the change persistent after reboot:
      3.1. create file '/etc/systemd/system/var-run-sdp.path' with the following content:
        [Unit]
        Descrption=Monitor /var/run/sdp
        [Install]
        WantedBy=bluetooth.service
        [Path]
        PathExists=/var/run/sdp
        Unit=var-run-sdp.service
      3.2. and another file,'/etc/systemd/system/var-run-sdp.service':
        [Unit]
        Description=Set permission of /var/run/sdp
        [Install]
        RequiredBy=var-run-sdp.path
        [Service]
        Type=simple
        ExecStart=/bin/chgrp bluetooth /var/run/sdp
      3.3. finally,start it all up:
        sudo systemctl daemon-reload
        sudo systemctl enable var-run-sdp.path
        sudo systemctl enable var-run-sdp.service
        sudo systemctl start var-run-sdp.path     
    ref:https://stackoverflow.com/questions/34599703/rfcomm-bluetooth-permission-denied-error-raspberry-pi/42306883#42306883







master bt and slave bt
master bt host bus:usb, hci0
slave bt :rfcomm0
'sudo l2ping -c 3 18:dc:56:d2:1c:1a'

