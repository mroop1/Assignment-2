#!/bin/bash

# Symbolic link for the bin directory
if [ -d ~/config_dir/bin ]
then 
    echo "Source path created"
    ln -sf ~/config_dir/bin ~/bin
else
    echo "Target path ~/config_dir/bin does not exist"
fi

# Symbolic link for the config directory
if [ -d ~/config_dir/config ]
then 
    echo "Source path created"
    ln -sf ~/config_dir/config ~/.config
else
   echo "Target path ~/config_dir/config does not exist"
fi

# Symbolic link for the bashrc directory
if [ -f ~/config_dir/home/bashrc ]
then 
    echo "Source path created"
    ln -sf ~/config_dir/home/bashrc ~/.bashrc
else
    echo "Target path ~/config_dir/home/bashrc does not exist"
fi


