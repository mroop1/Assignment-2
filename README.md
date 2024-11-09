# System Setup and User Management Scripts

This project includes two main parts:
1. **Project 1**: Scripts for setting up a system by installing packages and creating symbolic links for configuration files.
2. **Project 2**: A script for automating user creation, including setting the user's shell, adding them to groups, and setting up a password.

---

## Project 1: System Setup Scripts

### Overview
Project 1 includes three scripts to simplify setting up a new system. These scripts install packages from a user defined list and creates symbolic links for configuration files. This saves time and ensures a consistent environment.

### Script Details

#### 1. install_packages.sh
**Purpose**: Installs packages from a file provided by the user.

**How It Works**:
- Reads package names from a file.
- Updates the package list with `pacman -Syu`.
- Checks if each package is already installed.
- Installs any missing packages.

**Usage**:
```bash
sudo ./install_packages.sh -f [ path_to_user_package_list ] 
```

**Options**:
- `-f <path_to_package_list>`: Path to the file that lists the packages to install.
***Example***
```bash
sudo ./install_packages.sh -f ~/user_package_list
```

#### 2. sym_link.sh
**Purpose**: Creates symbolic links for configuration files and directories from `~/config_dir` to the user's home directory.

**How It Works**:
- Checks if the source paths exist.
- Creates symbolic links for the `bin` directory, `config` directory, and `.bashrc` file.
- Prints messages indicating if the source paths exist or not.

**Usage**:
```bash
./sym_links.sh
```
***Example Output***:
```bash
Target path ~/config_dir/bin created
Target path ~/config_dir/config created
Target path ~/config_dir/home/bashrc created
```

#### 3. setup_system.sh
**Purpose**: Runs `install_packages.sh` and `sym_links.sh` to automate the full system setup.

**How It Works**:

- Takes the `-f` option for the package list and passes it to `install_packages.sh`.
- Runs `sym_links.sh` after installing packages.

**Usage**:
```bash
sudo ./setup_system.sh -f [ path_to_user_package_list ]
```

**Example**:
```bash
sudo ./setup_system.sh -f ~/user_package_list
```

### Running the Scripts

1. **Run the master script**:
```bash
sudo ./setup_system.sh -f ~/user_package_list
```

 2.**Run the scripts individually**:
 - ***install_packages.sh***:
```bash
sudo ./install_packages.sh -f ~/user_package_list
```
- ***sym_links.sh***:
```bash
./sym_links.sh

---

## Project 2: User Creation Script

### Overview

Project 2 includes a script called `create_user.sh` that automates user creation. It sets the user's shell, adds them to specified groups, and prompts for a password.

### Script Details

#### create_user.sh

**Purpose**: Automates the process of creating a user on the system.

**How It Works**:

- Takes command-line options for the username, shell, and groups.
- Checks if the user already exists.
- Creates the user and prompts for a password if they don't exist.

**Usage**:
```bash
sudo ./create_user.sh [ -u username ] [ -s shell ] [ -g group_name1, group_name2 ]
```

**Options**:

- `-u <username>`: The username to create (required).
- `-s <shell>`: The shell to use for the user (e.g., `/bin/bash`).
- `-g <group_name1,group_name2>`: Comma-separated list of groups to add the user to.

**Example**:
```bash
sudo ./create_user.sh -u test_user -s /bin/bash -g wheel, test_group
```



### Running the Script

1. Ensure the script has execute permissions:
```bash
chmod 755 create_user.sh
```
- `755`: 
	- `7`: Gives read write and execute privileges to the user
	- `5`: Gives read and execute privileges to the group
	- `5`: Gives read and execute privileges to others
2. Run the script with the appropriate options:
```bash
sudo ./create_user.sh -u arch -s /bin/bash -g arch
```

---

## Notes and Troubleshooting

### General Tips

- Always run the scripts with `sudo` to ensure they have the necessary permissions.
- Make sure the `~/config_dir` directory exists and contains the `bin`, `config`, and `home/bashrc` files.

### Potential Issues

- **User Already Exists**: If you see `User [username] already exists`, choose a different username or check the current users with:
```bash
cat /etc/passwd
```

- **Shell Path**: Make sure the specified shell (e.g., `/bin/bash`) exists on your system. Check with:
```bash
which bash
```

- **Group Names**: Verify that the groups you specify exist on your system; to create a group if needed. Use:
```bash
groupadd [ group_name ]
```

- **Permission**s: Ensure all scripts have execute permissions:
```bash
chmod 755 install_packages.sh sym_links.sh setup_system.sh create_user.sh
```
 - `755`: 
	- `7`: Gives read write and execute privileges to the user
	- `5`: Gives read and execute privileges to the group
	- `5`: Gives read and execute privileges to others

---

## Citations
Arch Linux. (n.d.). Pacman. Arch Linux Wiki. Retrieved November 7, 2024, from https://wiki.archlinux.org/title/Pacman

GNU Project. (n.d.). Bash conditional expressions. GNU Bash Reference Manual. Retrieved November 7, 2024, from https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html

Arch Linux Forums. (2022). Handling specific issues with pacman [Forum post]. Arch Linux BBS. Retrieved November 7, 2024, from https://bbs.archlinux.org/viewtopic.php?id=273025
