#!/bin/bash

# This helps to inform the user how to use the script.
usage() {
  echo "Usage: $0 -u username -p password -i uid -g gid -s shell"
  exit 1
}

# This helps to ensure that the user remembers to use sudo or running root account when accessing this script.
if [[ $EUID -ne 0 ]]; then
  echo "Please run with root privileges by using sudo."
  exit 1
fi

# PLACEHOLDER
while getopts ":u:p:i:g:s:" OPT
do
    case "${OPT}" in
        u)
            username=${OPTARG}
            ;;
        p)
            password=${OPTARG}
            ;;
        i)
            uid=${OPTARG}
            ;;
        g)
            gid=${OPTARG}
            ;;
        s)
            shell=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

# Checks to see if any of the arguments are blank and return usage function.
if [ -z "$username" ] || [ -z "$password" ] || [ -z "$uid" ] || [ -z "$gid" ] || [ -z "$shell" ]
then
    usage
fi

home="/home/$username"

if grep -qe "^$username:" /etc/passwd
then
    echo "User $username already exists in the system."
    exit 1
fi
if awk -F: '$3 == $uid' /etc/passwd
then
    echo "UID $uid already exists in the system."
    exit 1
fi

if awk -F: '$4 == $gid' /etc/passwd
then
    echo "GID $gid already exists in the system."
    exit 1
fi


# Takes username, x(this is for formatting), uid, gid, home dir, and shell which appends that to the etc/passwd dir 
echo "$username:x:$uid:$gid::$home:$shell" >> /etc/passwd

# Take username, x, and gid which appends to etc/group dir
echo "$username:x:$gid:" >> /etc/group

# openssl takes the passwords and hashes it for encryption
password_hash=$(openssl passwd -5 "$password")
echo "$username:$password_hash:20000:0:99999:7:::" >> /etc/shadow

# Takes username and appends it to /etc/gshadow
echo "$username:!::" >> /etc/gshadow


mkdir -p "$home"

chown "$username:$username" "$home"

chmod 755 "$home"

echo "Completed user creation process for $username"
