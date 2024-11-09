#!/bin/bash

# Simple funtion to inform user how to run the set_system.sh script
usage () {
    echo "Usage: sudo $0 [ -f file_path ]"
    exit 1
}

# Makes sure user remembers to run the script as root
if [[ $EUID -ne 0 ]]
then 
    echo "Please run as root using sudo"
    usage
    exit 1
fi

# Getopts function to ensure the install packages script works properly
# by using a (-f) argument to point to a file path

file=""

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

# Starts the install_packages.sh script that captures all arguments
./install_packages.sh -f "$file"

# Starts the sym_link.sh script
./sym_links.sh

