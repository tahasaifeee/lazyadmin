#!/bin/bash

# LazyAdmin - Linux System Administration TUI
# Bash version using dialog/whiptail

VERSION="2.0.0"

# Color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if dialog is installed, fallback to whiptail
if command -v dialog &> /dev/null; then
    DIALOG="dialog"
elif command -v whiptail &> /dev/null; then
    DIALOG="whiptail"
else
    echo -e "${RED}Error: Neither 'dialog' nor 'whiptail' is installed.${NC}"
    echo "Please install one of them:"
    echo "  Ubuntu/Debian: sudo apt-get install dialog"
    echo "  RHEL/CentOS:   sudo yum install dialog"
    echo "  Arch:          sudo pacman -S dialog"
    exit 1
fi

# Temporary file for dialog output
TEMP_FILE=$(mktemp)
trap "rm -f $TEMP_FILE" EXIT

# Dialog dimensions
HEIGHT=25
WIDTH=80
MENU_HEIGHT=15

#=============================================================================
# MAIN MENU
#=============================================================================
main_menu() {
    while true; do
        $DIALOG --clear --title "LazyAdmin v$VERSION - Main Menu" \
            --menu "Choose a section:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "System Information" \
            "2" "User & Group Management" \
            "0" "Exit" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            exit 0
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) system_info_menu ;;
            2) user_management_menu ;;
            0) exit 0 ;;
        esac
    done
}

#=============================================================================
# SYSTEM INFORMATION MENU
#=============================================================================
system_info_menu() {
    while true; do
        $DIALOG --clear --title "System Information" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "System Info" \
            "2" "Services" \
            "3" "Processes" \
            "4" "Disk Usage" \
            "0" "Back to Main Menu" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) show_system_info ;;
            2) show_services ;;
            3) show_processes ;;
            4) show_disk_usage ;;
            0) return ;;
        esac
    done
}

#=============================================================================
# SYSTEM INFO
#=============================================================================
show_system_info() {
    info=$(cat <<EOF
SYSTEM SUMMARY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Hostname:     $(hostname)
OS:           $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2)
Kernel:       $(uname -r)
Uptime:       $(uptime -p)
Load Avg:     $(uptime | awk -F'load average:' '{print $2}')

CPU INFO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Model:        $(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
Cores:        $(nproc)
Architecture: $(uname -m)

MEMORY INFO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$(free -h | awk 'NR==1{print "         " $2 "      " $3 "      " $4} NR==2{print "Memory:  " $2 "    " $3 "    " $4} NR==3{print "Swap:    " $2 "    " $3 "    " $4}')

NETWORK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

$(ip -br addr | grep -v "^lo" | awk '{print $1 ": " $3}')
EOF
)

    $DIALOG --title "System Information" --msgbox "$info" 30 80
}

#=============================================================================
# SERVICES
#=============================================================================
show_services() {
    while true; do
        # Get list of services
        services=$(systemctl list-units --type=service --all --no-pager --no-legend | \
            awk '{status=""; if($4=="running") status="[ACTIVE]"; else if($4=="failed") status="[FAILED]"; else status="[INACTIVE]"; print $1, status}' | \
            head -n 20)

        $DIALOG --clear --title "Services (Top 20)" \
            --menu "Select a service to manage:\n\nNote: Service management requires sudo" 30 90 20 \
            $(echo "$services" | nl | awk '{print $1, $2 " " $3}') \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        line_num=$(cat "$TEMP_FILE")
        service_name=$(echo "$services" | sed -n "${line_num}p" | awk '{print $1}')

        manage_service "$service_name"
    done
}

manage_service() {
    local service="$1"
    local status=$(systemctl is-active "$service" 2>/dev/null)
    local enabled=$(systemctl is-enabled "$service" 2>/dev/null)

    while true; do
        $DIALOG --clear --title "Manage Service: $service" \
            --menu "Status: $status | Enabled: $enabled\n\nChoose an action:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "Start Service" \
            "2" "Stop Service" \
            "3" "Restart Service" \
            "4" "Enable Service (start on boot)" \
            "5" "Disable Service (don't start on boot)" \
            "6" "View Service Status" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        action=$(cat "$TEMP_FILE")

        case $action in
            1) sudo systemctl start "$service" && $DIALOG --msgbox "Service started successfully" 8 50 ;;
            2) sudo systemctl stop "$service" && $DIALOG --msgbox "Service stopped successfully" 8 50 ;;
            3) sudo systemctl restart "$service" && $DIALOG --msgbox "Service restarted successfully" 8 50 ;;
            4) sudo systemctl enable "$service" && $DIALOG --msgbox "Service enabled successfully" 8 50 ;;
            5) sudo systemctl disable "$service" && $DIALOG --msgbox "Service disabled successfully" 8 50 ;;
            6)
                status_info=$(systemctl status "$service" 2>&1)
                $DIALOG --title "Service Status: $service" --msgbox "$status_info" 30 100
                ;;
            0) return ;;
        esac

        # Update status
        status=$(systemctl is-active "$service" 2>/dev/null)
        enabled=$(systemctl is-enabled "$service" 2>/dev/null)
    done
}

#=============================================================================
# PROCESSES
#=============================================================================
show_processes() {
    processes=$(ps aux --sort=-%mem | head -n 21 | tail -n 20 | \
        awk '{printf "%-10s %5s%% %5s%% %s\n", $1, $3, $4, $11}')

    $DIALOG --title "Top 20 Processes by Memory Usage" \
        --msgbox "USER       CPU%  MEM%  COMMAND\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$processes" 30 100
}

#=============================================================================
# DISK USAGE
#=============================================================================
show_disk_usage() {
    disk_info=$(df -h | grep -E '^/dev/' | awk '{printf "%-20s %8s %8s %8s %5s %s\n", $1, $2, $3, $4, $5, $6}')

    $DIALOG --title "Disk Usage" \
        --msgbox "FILESYSTEM           SIZE     USED     AVAIL  USE%  MOUNTED\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$disk_info" 20 90
}

#=============================================================================
# USER MANAGEMENT MENU
#=============================================================================
user_management_menu() {
    while true; do
        $DIALOG --clear --title "User & Group Management" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "a" "List Users & Groups" \
            "b" "Create User" \
            "c" "Delete User" \
            "d" "Add User to Group" \
            "e" "Remove User from Group" \
            "f" "Set/Reset Password" \
            "g" "Change User Shell" \
            "h" "Lock/Unlock User" \
            "0" "Back to Main Menu" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            a) list_users_groups ;;
            b) create_user ;;
            c) delete_user ;;
            d) add_user_to_group ;;
            e) remove_user_from_group ;;
            f) set_password ;;
            g) change_shell ;;
            h) lock_unlock_user ;;
            0) return ;;
        esac
    done
}

#=============================================================================
# LIST USERS & GROUPS
#=============================================================================
list_users_groups() {
    while true; do
        $DIALOG --clear --title "List Users & Groups" \
            --menu "Choose what to display:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "List Users" \
            "2" "List Groups" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1)
                users=$(getent passwd | awk -F: '$3 >= 1000 {printf "%-15s UID:%-6s Shell:%-20s Home:%s\n", $1, $3, $7, $6}' | head -n 30)
                $DIALOG --title "System Users (UID >= 1000)" \
                    --msgbox "USERNAME        UID    SHELL               HOME\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$users" 30 100
                ;;
            2)
                groups=$(getent group | awk -F: '$3 >= 1000 {printf "%-20s GID:%-8s Members: %s\n", $1, $3, $4}' | head -n 30)
                $DIALOG --title "System Groups (GID >= 1000)" \
                    --msgbox "GROUP               GID      MEMBERS\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n$groups" 30 100
                ;;
            0) return ;;
        esac
    done
}

#=============================================================================
# CREATE USER
#=============================================================================
create_user() {
    $DIALOG --inputbox "Enter username:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    if [ -z "$username" ]; then
        $DIALOG --msgbox "Username cannot be empty" 8 40
        return
    fi

    if sudo useradd -m "$username"; then
        $DIALOG --msgbox "User '$username' created successfully.\n\nSet password with: sudo passwd $username" 10 60
    else
        $DIALOG --msgbox "Failed to create user '$username'" 8 40
    fi
}

#=============================================================================
# DELETE USER
#=============================================================================
delete_user() {
    $DIALOG --inputbox "Enter username to delete:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    if [ -z "$username" ]; then
        $DIALOG --msgbox "Username cannot be empty" 8 40
        return
    fi

    $DIALOG --yesno "Delete user '$username' and home directory?" 8 50
    if [ $? -eq 0 ]; then
        if sudo userdel -r "$username" 2>/dev/null; then
            $DIALOG --msgbox "User '$username' deleted successfully" 8 50
        else
            $DIALOG --msgbox "Failed to delete user '$username'" 8 40
        fi
    fi
}

#=============================================================================
# ADD USER TO GROUP
#=============================================================================
add_user_to_group() {
    $DIALOG --inputbox "Enter username:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter group name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    groupname=$(cat "$TEMP_FILE")

    if [ -z "$username" ] || [ -z "$groupname" ]; then
        $DIALOG --msgbox "Username and group cannot be empty" 8 40
        return
    fi

    if sudo usermod -aG "$groupname" "$username"; then
        $DIALOG --msgbox "User '$username' added to group '$groupname'" 10 50
    else
        $DIALOG --msgbox "Failed to add user to group" 8 40
    fi
}

#=============================================================================
# REMOVE USER FROM GROUP
#=============================================================================
remove_user_from_group() {
    $DIALOG --inputbox "Enter username:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter group name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    groupname=$(cat "$TEMP_FILE")

    if [ -z "$username" ] || [ -z "$groupname" ]; then
        $DIALOG --msgbox "Username and group cannot be empty" 8 40
        return
    fi

    if sudo gpasswd -d "$username" "$groupname"; then
        $DIALOG --msgbox "User '$username' removed from group '$groupname'" 10 50
    else
        $DIALOG --msgbox "Failed to remove user from group" 8 40
    fi
}

#=============================================================================
# SET PASSWORD
#=============================================================================
set_password() {
    $DIALOG --inputbox "Enter username:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    if [ -z "$username" ]; then
        $DIALOG --msgbox "Username cannot be empty" 8 40
        return
    fi

    $DIALOG --msgbox "You will now set the password for user '$username'\n\nPress OK to continue..." 10 50

    if sudo passwd "$username"; then
        $DIALOG --msgbox "Password set successfully for '$username'" 8 50
    else
        $DIALOG --msgbox "Failed to set password" 8 40
    fi
}

#=============================================================================
# CHANGE SHELL
#=============================================================================
change_shell() {
    $DIALOG --inputbox "Enter username:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    $DIALOG --menu "Select shell for user '$username':" 15 60 5 \
        "1" "/bin/bash" \
        "2" "/bin/zsh" \
        "3" "/bin/sh" \
        "4" "/usr/bin/fish" \
        "5" "Custom path" \
        2> "$TEMP_FILE"

    if [ $? -ne 0 ]; then return; fi
    shell_choice=$(cat "$TEMP_FILE")

    case $shell_choice in
        1) shell="/bin/bash" ;;
        2) shell="/bin/zsh" ;;
        3) shell="/bin/sh" ;;
        4) shell="/usr/bin/fish" ;;
        5)
            $DIALOG --inputbox "Enter shell path:" 8 50 2> "$TEMP_FILE"
            if [ $? -ne 0 ]; then return; fi
            shell=$(cat "$TEMP_FILE")
            ;;
    esac

    if sudo chsh -s "$shell" "$username"; then
        $DIALOG --msgbox "Shell changed to '$shell' for user '$username'" 10 50
    else
        $DIALOG --msgbox "Failed to change shell" 8 40
    fi
}

#=============================================================================
# LOCK/UNLOCK USER
#=============================================================================
lock_unlock_user() {
    $DIALOG --inputbox "Enter username:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    username=$(cat "$TEMP_FILE")

    if [ -z "$username" ]; then
        $DIALOG --msgbox "Username cannot be empty" 8 40
        return
    fi

    $DIALOG --menu "Choose action for user '$username':" 12 50 2 \
        "1" "Lock Account" \
        "2" "Unlock Account" \
        2> "$TEMP_FILE"

    if [ $? -ne 0 ]; then return; fi
    action=$(cat "$TEMP_FILE")

    case $action in
        1)
            if sudo passwd -l "$username"; then
                $DIALOG --msgbox "User '$username' locked successfully" 8 50
            else
                $DIALOG --msgbox "Failed to lock user" 8 40
            fi
            ;;
        2)
            if sudo passwd -u "$username"; then
                $DIALOG --msgbox "User '$username' unlocked successfully" 8 50
            else
                $DIALOG --msgbox "Failed to unlock user" 8 40
            fi
            ;;
    esac
}

#=============================================================================
# MAIN EXECUTION
#=============================================================================
main_menu
