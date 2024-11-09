#!/bin/bash

# This is the conventional funciton used to print usage instructions if the input is incorrect.
usage() {
    echo "Usage: sudo $0 [ -f file path ]"
    exit 1
}

# This helps to ensure that the user remembers to use sudo or running root account when accessing this script.
if [[ $EUID -ne 0 ]] 
then
    echo "Please run as root by using sudo."
    usage
    exit 1
fi

# This helps to ensure that packages are provided as arguments, otherwise run usage function.
if [[ $# -lt 1 ]]
then
    usage
fi

# Default values
file=""

# getopts function that takes in a command line argument (-f) is for a user-defined file path 
# and (*) is for all other characters that are not specfied
while getopts ":f:" opt
do
    case "${opt}" in
      f)
	file=${OPTARG}
	;;
      *)
	usage
	;;
    esac
done

# This declears the user list file as the first argurment, checks if the file is valid or exists, 
# and then concatenates the package names
if [[ ! -f $file ]]
then
    echo "File $file not found or invalid"
    exit 1
elif [[ -z $file ]]
then
    echo "File path is required"
    usage
else
    echo "File $file found and ready to install"
fi

packages=`cat $file`

# Check for updates and update package list before further installation.
pacman -Syu --noconfirm

# Install user defined packages after doing initial checks.
for package in ${packages[@]}
do
  if pacman -Q "$package" 
  then
   echo "Package $package is already installed."
  elif pacman -Ss "$package" 
  then
    echo "Installing the package: $package, please wait..."
    pacman -S --noconfirm "$package"  
  else
    echo "Package $package was not found. Please check the package and input command again."
  fi
done

