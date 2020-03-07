#!bin/bash
#author: Nguyen Tuan Dat
#script bai tap 2
createFile(){
	if [ ! -e $1 ]
	then
		touch $1
	fi
}

checkTextFile(){
	check=$(file -i $1|grep -w "text/plain")
	if [ $check ]
	then
		head -n 10 "$1" > /var/log/checketc.log
	else
		echo $s1 > /var/log/checketc.log
	fi
}

checkNewFile(){
	old=$1
	current=$2
	while read -r line
	do
		check=$(grep -w $line -m 1 $old)
		if [ ! $check ]
		then
			checkTextFile $line > /var/log/checketc.log
		fi
	done < $current
}

checkDeleteFile(){
	old=$1
	current=$2
	while read -r line
	do
		check=$(grep -w $line -m 1 $current)
		if [ !$check ]
		then 
			echo $line > /var/log/checketc.log
		fi
	done < $old
}


echo "[Log checketc - `date +%T` `date +%D`]"

#dir file
dir='/etc'
listOldFiles='/home/tuandat/old_files'
listCurrentFiles='/home/tuandat/current_files'
listCheckFiles='/home/tuandat/check_files'

#Create file check
createFile $listCheckFiles
createFile $listOldFiles
createFile $listCurrentFiles

#write list file
find $dir -type f > $listCurrentFiles
find $dir -type f -cmin -30 > $listCheckFiles

#list new file
echo "=====Danh Sach file moi tao============" > /var/log/checketc.log
checkNewFile $listOldFiles $listCheckFiles

echo "=== Danh sach file moi chinh sua ===" > /var/log/checketc.log
filesEdit=`sudo find /etc -mmin -30`
echo $filesEdit |sed 's/ /\n/g' > /var/log/checketc.log

echo "==========Danh sach file bi xoa========" > /var/log/checketc.log
checkDeleteFile $listOldFiles $listCurrentFiles
cat $listCurrentFiles > $listOldFiles
sendmail root@localhost /var/log/checketc.log