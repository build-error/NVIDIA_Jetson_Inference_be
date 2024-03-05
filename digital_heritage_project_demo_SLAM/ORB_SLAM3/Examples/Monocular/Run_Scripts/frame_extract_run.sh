#!/bin/bash

# change these variable(s) accordingly
videoFileName='WIN_20240305_13_06_20_Pro.mp4'
timeStampFileName='timestamps.txt'
DatasetFolderName='lab_data'
#------------------------------------
# Monocular Examples
echo "frame_extract" | figlet
echo "Launching frame_extract.cc"
../frame_extract ../../Datasets/"$videoFileName" ../../Datasets/"$DatasetFolderName"/ ../Datasets_TimeStamps/Lab_TimeStamps/"$timeStampFileName"