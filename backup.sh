#!/bin/sh

today=`date +"%m-%d-%y"`
zipcount=`ls -l *.zip | wc -l`
archiveLimit=5
filedirectory=$1
zipfolder=$2

if [ "$zipcount" -eq "$archiveLimit" ]; then 
  echo "Removing old files..."
  oldestFile=`ls -gt|tail -1`
  rm -R $oldestFile 
fi 

echo "Copying new files..."
cp -R $filedirectory $zipfolder

zip -r $today.zip $zipfolder
rm -R $zipfolder
echo "Done!"
