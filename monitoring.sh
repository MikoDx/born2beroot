mem=$(free -h | grep Mem | awk '{printf $3"/"$2}')
mem_p="$(free -m | grep Mem | awk '{printf "%.2f\n", ($3/$2)*100}')%" 
storage=$(df -h --total | grep total | awk '{printf "%s/%s (%s)\n",$3,$2,$5 }')
echo "#Architecture: " `uname -a`
echo "#CPU physical: " `grep 'physical id' /proc/cpuinfo | uniq | wc -l`
echo "#vCpu: " `grep 'physical id' /proc/cpuinfo | uniq | wc -l`
echo "#Memory Usage: " $mem "($mem_p)"
echo "#Disk Usage: " $storage
echo "#Cpu Usage: `mpstat 3 1 | grep Average | awk '{printf "%.1f%% \n", 100 - $12}'`"
echo "#Last Reboot: `uptime -s`"
echo "#Lvm Use: " ` if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi`
echo "#Tcp Connection: `netstat -at | grep ESTABLISHED | wc -l`"
echo "#Active Users : `users | wc -w`"
echo "#Ip and Mac :  `ip -4 addr show enp0s3 | grep inet | awk '{printf "%s\n",$2}'` `ip addr show enp0s3 | grep ether | awk '{printf "%s\n",$2}'`" 
echo "#Sudo: `grep  -a COMMAND /var/log/sudo.log | wc -l`"
