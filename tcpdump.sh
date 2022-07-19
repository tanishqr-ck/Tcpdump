#!/bin/bash

echo "Enter interface name"
read interface
ifconfig "$interface" promisc
echo "Enter time duration"
read t_ime

sudo tcpdump -i "$interface" -vvvv -e -G "$time" -W 1 -w main.pcap &
sleep $t_ime

zenity --info --title="TCPDUMP" --text="All packets in $t_ime span have been captured" --width=300 --height=200
killall -u tcpdump
zenity --width=300 --height=200 --question --title="TCPDUMP" --text="Do you want to analyze the traffic now?"
if [[ $? = 1 ]] 
then

zenity --info --title="TCPDUMP" --text="No worries you can examine data packets using 'wireshark main.pcap' comamnd later!!!" --width=300 --height=200
else
cntrl=0
while [ $cntrl == 0 ]
do
ch=`zenity --width=400 --height=300 --list \
  --title="Select Protocols" \
  --column="Protocols" \
    ip  \
    tcp \
    ip6 \
    arp \
    rarp \
    ether \
    udp \
    fddi \
    close \
    decnet;`

protocol=$ch
echo $protocol
case $protocol in
tcp)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'tcp'`" --width=1500 --height=600
;;
ip)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'ip'`" --width=1500 --height=600
;;
udp)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'udp'`" --width=1500 --height=600
;;
arp)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'arp'`" --width=1500 --height=600
;;
ip6)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'ip6'`" --width=1500 --height=600
;;
rarp)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'rarp'`" --width=1500 --height=600
;;
decnet)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'decnet'`" --width=1500 --height=600
;;
ether)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'ether'`" --width=1500 --height=800
;;
tr)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'tr'`" --width=1500 --height=600
;;
fddi)
zenity --info --title="TCPDUMP" --text="`tcpdump -r main.pcap 'fddi'`" --width=1500 --height=600
;;
close)
cntrl=1
;;
*)
zenity --info --title="UNKNOWN" --text="The entered protocol is unidentified."
;;
esac
done

fi


