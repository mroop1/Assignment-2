#!/bin/bash

# This helps to inform the user how to use the script.
usage() {
  echo "Usage: $0 [ -u username ] [ -s shell ] [ -g 'group_name1,group_name2 ], etc...'"
  exit 1
}

# This helps to ensure that the user remembers to use sudo or running root account when accessing this script.
if [[ $EUID -ne 0 ]]
then
  echo "Please run with root privileges by using sudo."
  usage 
  exit 1
fi

# This sets up the command line arguments that can be used by the user. Using simple notations: "u" for username, "s" for shell, and "g" for groups. And "*", or blank will just call the usage function.
while getopts ":u:s:g:" OPTION
do
    case "${OPTION}" in
        u)
            username=${OPTARG}
            ;;
        s)
            shell=${OPTARG}
            ;;
        g)
            groups=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

# Checks to see if any of the arguments are blank (ensure string is not zero) and return usage function.
if [ -z "$username" ] || [ -z "$shell" ] || [ -z "$groups" ]
then
    usage
fi

# Checks to see if the user exists, otherwise create the user in the system. After creating the user, it will call the password function to create a new password for specified user.
if id "$username"
then
    echo "User $username already exists in the system."
    exit 1
else
    echo "Creating specified user $username."
    useradd -m -s "$shell" -G "$groups" "$username"
    echo "Please create a password for $username"
    passwd "$username"
    cp -r /etc/skel/. "home/$username/"
fi


