#!bin/bash
#author: Nguyen Tuan Dat
#script bai tap 1

arrayLenh=(
"Ten may: `cat /etc/os-release | grep -w "NAME"|cut -d '=' -f2`"
"Ban phan phoi: `cat /etc/os-release | grep -w "VERSION"|cut -d '=' -f2`"
"He dieu hanh: `cat /proc/version |cut -d '=' -f2`"
"Ten CPU: `cat /proc/cpuinfo | grep -w "model name" |cut -d ':' -f2`"
"Bit CPU: `lscpu | grep -w "CPU op-mode(s)" | cut -d ':' -f2`"
"Toc do CPU `lscpu | grep -w "CPU MHz"|cut -d ':' -f2` Mhz"
"Dung luong o cung: `df -h /dev/sda1 --output=size|grep "G"`" 
"Dung luong con lai: `df -h /dev/sda1 --output=avail|grep "G"`"
"Dia chi ip: `ip addr |grep -w "inet"|cut -d '/' -f2 | tr -s ' '|cut -d ' ' -f3`"
)


for ((i=0;i<${#arrayLenh[@]};i++))
do
		echo -e ${arrayLenh[i]} 
done

users="Danh sach user:\n `cut -d : -f 1 /etc/passwd|sort`"
echo -e $users | sed 's/ /\n/4g'

echo -e "\n\n Danh sach tien trinh dang chay duoi quyen root: \n"
ps -fU root |sort

echo -e "\n\n danh sach cach port dang mo: \n"
netstat | sort -n

echo -e "\n\n Danh sach file ma other co quyen ghi: \n"
find -perm -o=r

ehco -e "\n\n Danh sach cac phan mem duoc cai dat tren he thong:\n"
apt list --installed



