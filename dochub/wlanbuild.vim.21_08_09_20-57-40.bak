"=== #ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: enp2s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 00:16:d3:26:a7:88 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.3/24 brd 192.168.1.255 scope global dynamic noprefixroute enp2s0
       valid_lft 84676sec preferred_lft 84676sec
    inet6 fe80::216:d3ff:fe26:a788/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: wlp4s2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 6e:b8:a1:49:f7:63 brd ff:ff:ff:ff:ff:ff
    "'lo' mean local cycle address.
    "'enp2s0' 'en' mean local ethernet address
    "'wlp4s2' 'wl' mean local wirelesslan address
    'p2s0''p4s2' means 'p' pci.'bus 2 slot 0' 'bus 4 slot 2'
enp2s0    no wireless extensions.

lo        no wireless extensions.

wlp4s2    IEEE 802.11  ESSID:"TP-LINK_9FFB"  
          Mode:Managed  Frequency:2.437 GHz  Access Point: 48:7D:2E:C8:9F:FB   
          Bit Rate:54 Mb/s   Tx-Power=20 dBm   Sensitivity=8/0  
          Retry limit:7   RTS thr:off   Fragment thr:off
          Encryption key:F7A0-6F53-1A4B-70F9-0FD9-F263-7BE2-3F25   Security mode:open
          Power Management:off
          Link Quality=84/100  Signal level=-46 dBm  Noise level=-84 dBm
          Rx invalid nwid:0  Rx invalid crypt:126  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:5

    
memo:
ap:essid'TP-LINK_9FFB', mac'48:7d:2e:c8:9f:fb'
tips:
point to debian series of linuxsys. all network configure just modify one file'/etc/network/interfaces'


    
      
2021年 08月 08日 星期日 11:34:39 CST
now wlan is ok.i feel good and little pullze. so do memo to find clue late. beneth word is not confirm, just revivification in fact as possible as i can.
step 1: '#sudo apt-get upgrade' ensure debian is newest.
step 2: '#dpkg -i firmware-ipw2x00_20210315-2_bpo10+1_all.deb (or:firmware-ipw2x00_20190114-2_all.deb)' . because newest debian do not find my wlan and bluetooth. so reinstall all these firmware driver.
setp 3: purge all old configure. such as '/etc/network/interfaces': like these:
      # This file describes the network interfaces available on your system
      # and how to activate them. For more information, see interfaces(5).
      
      source /etc/network/interfaces.d/*
      
      # The loopback network interface
      auto lo
      iface lo inet loopback
      
      #allow-hotplug wlp4s2
      #auto wlp4s2
      #	iface wlp4s2 inet dhcp
      #	wpa-conf /etc/wpa.conf


below is some useful tool instruction:
(1)#ip a
    echo 'lo''enp2s0''wlp4s2' etc some detail info.
(2)#sudo ifconfig 
    sudo ifconfig wlp4s2 up 
(3)#sudo iwconfig
(4)#lsusb [|grep xxx...]
(5)#sudo lspci [|grep -i ethernet]
(6)#sudo lsmod [|grep ipw2200]
      feedback>>>...
      ipw2200               139264  0
      libipw                 32768  1 ipw2200
      cfg80211              503808  2 ipw2200,libipw
(7)#sudo modprobe ipw2200
(8)#sudo modinfo ipw2200 [|grep lib...]
      filename:       /lib/modules/4.19.0-17-686-pae/kernel/drivers/net/wireless/intel/ipw2x00/ipw2200.ko
      depends:        cfg80211,libipw
(9)#sudo iwlist scan |less
(10)#sudo 

How to share directory to win7(easy)
step 1:#ifconfig    "to the debian, look for local addr.'192.168.0.111)
        ...
        inet 127.0.0.1  netmask 255.0.0.0
        ...
        inet 192.168.0.111  netmask 255.255.255.0  broadcast 192.168.0.255
        ...  

step 2:to the debian.do:
      install 'samba' and 'sambaclient'
      'vim /etc/samba/smb.conf'
        [debian]
          comment=share
          available=yes
          path=/home/liujinjing/download
          valid users=win
          public=yes
          browseable=yes
          writeable=yes
          create mask=0700
          directory mask=0700

step 3:'to the win7,mycomputer-->map netdriver-->imput'\\192.168.0.111\debian'and next window imput user:win password:1234.
done.
      
