#!/bin/bash


# audio duration info
sudo apt install mp3info

echo -ne "\033[35mУкажите директорию (абсолютный путь), информацию о файлах в которой вы хотели бы получить: \033[0m" && read hdir


home_dir=$hdir
this_dir=`pwd`
output=$this_dir/output.csv

touch $output
rm $output
echo -ne "\033[35mCheck output.csv in current dir \n \033[0m"
exec 1>$output
exec 2>errors.txt
IFS=$'\n'

# making a header of *.csv
echo "name,type,size,rights,date,duration,dir"

function myls()
{
	i=0 # counter to skip the first line (total:0) in ls -l

	# start collecting info about file
	for line in `ls -l $1`
	do
	i=$(( $i + 1 ))

	if [ $i -eq 1 ]
 		then
   		continue
	fi

	fil=`echo $line | awk '{print $9}'`

	# print name
	name=`echo "$fil" | awk -F '.' '{print $1}' `  # name is everything before dot
	echo -n "$2$name,"

	# say is it a directory or print type of file
	if [ -d "$1/$name" ]
	then
 		echo -n "directory,"
	else
		mtype=`echo "$fil" | awk -F '.' '{print $2}' `  # type is everything after do
		echo -n "$mtype,"  # print without new line
	fi

	# print size of item
	msize=`echo $line | awk '{print $5}'`
	echo -n "$msize,"

	# print rights
 	mrights=`echo $line | awk '{print $1}'`
	echo -n "$mrights, "

	# print date
	mdate=`echo $line | awk '{print $7 $6  $8}'`
	echo -n "$mdate,"

	# print info about audio
	if [ "$mtype" == "mp3" ]
  	then
  		echo -n "`mp3info -p "%m:%s" $1/$fil`,"
	else
  		echo -n ","
	fi

	# print current dirrectory to ensure we're still where we want to be
	echo -n "$1,"
	# start new line
	echo " "

	# go down if current folder have another folder
	if [ -d "$1/$name" ]
	then
		myls "$1/$fil" "$2-" =
	fi
	done
	return 0
}

myls $home_dir ""
exit 0

