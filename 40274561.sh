#!/bin/sh
#source set to first arguement
source=$1
#dest set to second arguement
dest=$2

#Check if the user had entered more than two arguements
if [ $# -gt 2 ] ; then 
	echo "Error: You had entered more than two arguements"
	#terminate
	exit
#closes if statement
fi

#Check that the user had not entered two arguments 
if [ $# -ne 2 ]; then
     #check that the user had entered the first arguement
    if [ $# -eq 1 ]; then 
		echo "You had only entered the source directory"
		#terminate
		exit
	else
		echo "Error: You had not entered the source directory and destination directory"
		#terminate 
		exit
	#closes if statement
	fi
else
	echo "You had entered the source directory and destination directory"
#closes if statement
fi

#check whether the source directory exist or not 
if [ ! -d $source ]; then 
	echo "$source do not exist"
	#terminate
	exit 
else
	echo "$source do exist"
#closes if statement
fi

#Check whether the destination directory exist or not 
if [ ! -d $dest ] ; then 
	#Make the destination directory
	mkdir $dest
else 
	echo "$dest do exist"
#closes if statement
fi
 
 #Check that the user has read permissions for the source directory or not 
if [ ! -r $source ]; then 
	echo "You do not have the read permissions for $source"
	#terminate
	exit
else
	echo "You do have the read permissions for $source"
#closes if statement
fi

#Check that the user has read permissions for the destination directory or not
if [ ! -r $dest ]; then 
	echo "You do not have the read permissions for $dest"
	#terminate
	exit
else
	echo "You do have the read permissions for $dest"
#closes if statement
fi

#Check that the user has write permissions for the source directory or not
if [ ! -w $source ]; then
	echo "You do not have the write permissions for $source"
	#terminate
	exit
else
	echo "You do have write permissions for $source"
#closes if statement
fi

#Check that the user has write permissions for the destination directory or not 
if [ ! -w $dest ] ; then 
	echo "You do not have write permissions for $dest"
	exit
else
	echo "You do have write permissions for $dest"
#closes if statement
fi

#loop all of the files of source directory that has a IMG_dddd format where d is between 0 and 9
for photos in $(find $source -name IMG_[0-9][0-9][0-9][0-9].JPG)
do
    #Set name to images names of the base
	name=$(basename $photos)
	#Check if a image in the source directory has same name of a image in the destination directory
	if [ -e $dest/$name ]; then 
	    #Check if the contents of a image of the source directory is same as the contents of a image in the destination directory. 
		if cmp  -s $photos $dest/$name ; then 
		     #Write the absolute path of the photo in the destination directory to the duplicates.txt
			readlink -f  $photos >> $dest/duplicates.txt
		else
		    #copy the photo of the source directory into the destination directory and append the filename with .JPG
			cp $photos "$dest/$name.JPG"
		#closes if statement
		fi
	else
	#copy the photo from source directory to destination directory
	cp $photos $dest/$name
	#closesif statement
	fi
 #End of loop
done