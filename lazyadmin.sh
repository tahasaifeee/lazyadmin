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
            --menu "Choose a section:\n\nNavigation: Use ↑↓ arrow keys to navigate, or type option number, then press Enter" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "System Information" \
            "2" "User & Group Management" \
            "3" "Disk Management (LVM, RAID, ZFS)" \
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
            3) disk_management_menu ;;
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
            --menu "Choose an option:\n\n(Use ↑↓ arrows or type number, then press Enter)" $HEIGHT $WIDTH $MENU_HEIGHT \
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
            --menu "Choose an option:\n\n(Use ↑↓ arrows or type number, then press Enter)" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "List Users & Groups" \
            "2" "Create User" \
            "3" "Delete User" \
            "4" "Add User to Group" \
            "5" "Remove User from Group" \
            "6" "Set/Reset Password" \
            "7" "Change User Shell" \
            "8" "Lock/Unlock User" \
            "0" "Back to Main Menu" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) list_users_groups ;;
            2) create_user ;;
            3) delete_user ;;
            4) add_user_to_group ;;
            5) remove_user_from_group ;;
            6) set_password ;;
            7) change_shell ;;
            8) lock_unlock_user ;;
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
# DISK MANAGEMENT MENU
#=============================================================================
disk_management_menu() {
    while true; do
        $DIALOG --clear --title "Disk Management" \
            --menu "Choose an option:\n\n(Use ↑↓ arrows or type number, then press Enter)" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "LVM Management" \
            "2" "RAID Management (mdadm)" \
            "3" "ZFS Management" \
            "4" "Disk Partitioning" \
            "5" "Filesystem Operations" \
            "6" "Mount/Unmount Operations" \
            "7" "View Disk Information" \
            "0" "Back to Main Menu" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $? -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) lvm_menu ;;
            2) raid_menu ;;
            3) zfs_menu ;;
            4) disk_partition_menu ;;
            5) filesystem_menu ;;
            6) mount_menu ;;
            7) view_disk_info ;;
            0) return ;;
        esac
    done
}

#=============================================================================
# LVM MANAGEMENT
#=============================================================================
lvm_menu() {
    while true; do
        $DIALOG --clear --title "LVM Management" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "View Physical Volumes (PV)" \
            "2" "View Volume Groups (VG)" \
            "3" "View Logical Volumes (LV)" \
            "4" "Create Physical Volume" \
            "5" "Create Volume Group" \
            "6" "Create Logical Volume" \
            "7" "Extend Logical Volume" \
            "8" "Remove Logical Volume" \
            "9" "Remove Volume Group" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) view_physical_volumes ;;
            2) view_volume_groups ;;
            3) view_logical_volumes ;;
            4) create_physical_volume ;;
            5) create_volume_group ;;
            6) create_logical_volume ;;
            7) extend_logical_volume ;;
            8) remove_logical_volume ;;
            9) remove_volume_group ;;
            0) return ;;
        esac
    done
}

view_physical_volumes() {
    pv_info=$(sudo pvdisplay 2>&1)
    $DIALOG --title "Physical Volumes" --msgbox "$pv_info" 30 100
}

view_volume_groups() {
    vg_info=$(sudo vgdisplay 2>&1)
    $DIALOG --title "Volume Groups" --msgbox "$vg_info" 30 100
}

view_logical_volumes() {
    lv_info=$(sudo lvdisplay 2>&1)
    $DIALOG --title "Logical Volumes" --msgbox "$lv_info" 30 100
}

create_physical_volume() {
    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    if [ -z "$device" ]; then
        $DIALOG --msgbox "Device path cannot be empty" 8 40
        return
    fi

    $DIALOG --yesno "Create physical volume on $device?\n\nWARNING: This will destroy all data on the device!" 10 60
    if [ $? -eq 0 ]; then
        if sudo pvcreate "$device" 2>&1 | tee /tmp/pv_output; then
            output=$(cat /tmp/pv_output)
            $DIALOG --msgbox "Physical volume created successfully!\n\n$output" 12 60
            rm -f /tmp/pv_output
        else
            output=$(cat /tmp/pv_output)
            $DIALOG --msgbox "Failed to create physical volume\n\n$output" 12 60
            rm -f /tmp/pv_output
        fi
    fi
}

create_volume_group() {
    $DIALOG --inputbox "Enter volume group name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    vg_name=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter physical volume path (e.g., /dev/sdb1):" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    pv_path=$(cat "$TEMP_FILE")

    if [ -z "$vg_name" ] || [ -z "$pv_path" ]; then
        $DIALOG --msgbox "Volume group name and PV path cannot be empty" 8 50
        return
    fi

    if sudo vgcreate "$vg_name" "$pv_path" 2>&1 | tee /tmp/vg_output; then
        output=$(cat /tmp/vg_output)
        $DIALOG --msgbox "Volume group '$vg_name' created successfully!\n\n$output" 12 60
        rm -f /tmp/vg_output
    else
        output=$(cat /tmp/vg_output)
        $DIALOG --msgbox "Failed to create volume group\n\n$output" 12 60
        rm -f /tmp/vg_output
    fi
}

create_logical_volume() {
    $DIALOG --inputbox "Enter logical volume name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    lv_name=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter volume group name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    vg_name=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter size (e.g., 10G, 500M, 100%FREE):" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    size=$(cat "$TEMP_FILE")

    if [ -z "$lv_name" ] || [ -z "$vg_name" ] || [ -z "$size" ]; then
        $DIALOG --msgbox "All fields are required" 8 40
        return
    fi

    if sudo lvcreate -L "$size" -n "$lv_name" "$vg_name" 2>&1 | tee /tmp/lv_output; then
        output=$(cat /tmp/lv_output)
        $DIALOG --msgbox "Logical volume created!\n\n$output\n\nDevice: /dev/$vg_name/$lv_name" 14 70
        rm -f /tmp/lv_output
    else
        output=$(cat /tmp/lv_output)
        $DIALOG --msgbox "Failed to create logical volume\n\n$output" 12 60
        rm -f /tmp/lv_output
    fi
}

extend_logical_volume() {
    $DIALOG --inputbox "Enter LV path (e.g., /dev/vg_name/lv_name):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    lv_path=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter size to add (e.g., +5G, +100M):" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    size=$(cat "$TEMP_FILE")

    if [ -z "$lv_path" ] || [ -z "$size" ]; then
        $DIALOG --msgbox "LV path and size cannot be empty" 8 40
        return
    fi

    if sudo lvextend -L "$size" "$lv_path" 2>&1 | tee /tmp/lv_extend; then
        output=$(cat /tmp/lv_extend)
        $DIALOG --yesno "$output\n\nResize filesystem too?" 14 70
        if [ $? -eq 0 ]; then
            sudo resize2fs "$lv_path" 2>&1 | tee /tmp/resize_output
            resize_out=$(cat /tmp/resize_output)
            $DIALOG --msgbox "LV extended and filesystem resized!\n\n$resize_out" 14 70
            rm -f /tmp/resize_output
        else
            $DIALOG --msgbox "LV extended successfully (filesystem not resized)" 10 60
        fi
        rm -f /tmp/lv_extend
    else
        output=$(cat /tmp/lv_extend)
        $DIALOG --msgbox "Failed to extend LV\n\n$output" 12 60
        rm -f /tmp/lv_extend
    fi
}

remove_logical_volume() {
    $DIALOG --inputbox "Enter LV path (e.g., /dev/vg_name/lv_name):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    lv_path=$(cat "$TEMP_FILE")

    if [ -z "$lv_path" ]; then
        $DIALOG --msgbox "LV path cannot be empty" 8 40
        return
    fi

    $DIALOG --yesno "Remove logical volume $lv_path?\n\nWARNING: All data will be lost!" 10 60
    if [ $? -eq 0 ]; then
        if sudo lvremove -f "$lv_path"; then
            $DIALOG --msgbox "Logical volume removed successfully" 8 50
        else
            $DIALOG --msgbox "Failed to remove logical volume" 8 40
        fi
    fi
}

remove_volume_group() {
    $DIALOG --inputbox "Enter volume group name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    vg_name=$(cat "$TEMP_FILE")

    if [ -z "$vg_name" ]; then
        $DIALOG --msgbox "VG name cannot be empty" 8 40
        return
    fi

    $DIALOG --yesno "Remove volume group $vg_name?\n\nWARNING: Remove all LVs first!" 10 60
    if [ $? -eq 0 ]; then
        if sudo vgremove -f "$vg_name"; then
            $DIALOG --msgbox "Volume group removed successfully" 8 50
        else
            $DIALOG --msgbox "Failed to remove volume group" 8 40
        fi
    fi
}

#=============================================================================
# RAID MANAGEMENT (mdadm)
#=============================================================================
raid_menu() {
    while true; do
        $DIALOG --clear --title "RAID Management (mdadm)" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "View RAID Arrays" \
            "2" "Create RAID Array" \
            "3" "Add Disk to RAID" \
            "4" "Remove Disk from RAID" \
            "5" "Stop RAID Array" \
            "6" "Assemble RAID Array" \
            "7" "Check RAID Status" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) view_raid_arrays ;;
            2) create_raid_array ;;
            3) add_raid_disk ;;
            4) remove_raid_disk ;;
            5) stop_raid_array ;;
            6) assemble_raid_array ;;
            7) check_raid_status ;;
            0) return ;;
        esac
    done
}

view_raid_arrays() {
    raid_info=$(cat /proc/mdstat 2>&1)
    $DIALOG --title "RAID Arrays (/proc/mdstat)" --msgbox "$raid_info" 30 100
}

create_raid_array() {
    $DIALOG --menu "Select RAID level:" 15 60 5 \
        "0" "RAID 0 (Striping)" \
        "1" "RAID 1 (Mirroring)" \
        "5" "RAID 5 (Parity)" \
        "6" "RAID 6 (Double Parity)" \
        "10" "RAID 10 (Mirrored Striping)" \
        2> "$TEMP_FILE"

    if [ $? -ne 0 ]; then return; fi
    raid_level=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter array device name (e.g., /dev/md0):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    md_device=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter number of devices:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    num_devices=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter device paths (space-separated, e.g., /dev/sdb1 /dev/sdc1):" 10 70 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    devices=$(cat "$TEMP_FILE")

    $DIALOG --yesno "Create RAID$raid_level array $md_device?\n\nDevices: $devices\n\nWARNING: All data will be destroyed!" 12 70
    if [ $? -eq 0 ]; then
        if sudo mdadm --create "$md_device" --level="$raid_level" --raid-devices="$num_devices" $devices 2>&1 | tee /tmp/raid_output; then
            output=$(cat /tmp/raid_output)
            $DIALOG --msgbox "RAID array created successfully!\n\n$output" 15 80
            rm -f /tmp/raid_output
        else
            output=$(cat /tmp/raid_output)
            $DIALOG --msgbox "Failed to create RAID array\n\n$output" 12 70
            rm -f /tmp/raid_output
        fi
    fi
}

add_raid_disk() {
    $DIALOG --inputbox "Enter RAID device (e.g., /dev/md0):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    md_device=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter disk to add (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    disk=$(cat "$TEMP_FILE")

    if sudo mdadm --add "$md_device" "$disk"; then
        $DIALOG --msgbox "Disk $disk added to $md_device successfully" 8 60
    else
        $DIALOG --msgbox "Failed to add disk to RAID" 8 40
    fi
}

remove_raid_disk() {
    $DIALOG --inputbox "Enter RAID device (e.g., /dev/md0):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    md_device=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter disk to remove (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    disk=$(cat "$TEMP_FILE")

    $DIALOG --yesno "First mark $disk as failed in $md_device?" 8 60
    if [ $? -eq 0 ]; then
        sudo mdadm --fail "$md_device" "$disk"
    fi

    if sudo mdadm --remove "$md_device" "$disk"; then
        $DIALOG --msgbox "Disk removed successfully" 8 50
    else
        $DIALOG --msgbox "Failed to remove disk" 8 40
    fi
}

stop_raid_array() {
    $DIALOG --inputbox "Enter RAID device to stop (e.g., /dev/md0):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    md_device=$(cat "$TEMP_FILE")

    $DIALOG --yesno "Stop RAID array $md_device?" 8 50
    if [ $? -eq 0 ]; then
        if sudo mdadm --stop "$md_device"; then
            $DIALOG --msgbox "RAID array stopped successfully" 8 50
        else
            $DIALOG --msgbox "Failed to stop RAID array" 8 40
        fi
    fi
}

assemble_raid_array() {
    $DIALOG --inputbox "Enter RAID device (e.g., /dev/md0):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    md_device=$(cat "$TEMP_FILE")

    if sudo mdadm --assemble "$md_device"; then
        $DIALOG --msgbox "RAID array assembled successfully" 8 50
    else
        $DIALOG --msgbox "Failed to assemble RAID array" 8 40
    fi
}

check_raid_status() {
    $DIALOG --inputbox "Enter RAID device (e.g., /dev/md0):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    md_device=$(cat "$TEMP_FILE")

    status=$(sudo mdadm --detail "$md_device" 2>&1)
    $DIALOG --title "RAID Status: $md_device" --msgbox "$status" 30 100
}

#=============================================================================
# ZFS MANAGEMENT
#=============================================================================
zfs_menu() {
    # Check if ZFS is available
    if ! command -v zfs &> /dev/null; then
        $DIALOG --msgbox "ZFS is not installed on this system.\n\nInstall with:\n  Ubuntu: sudo apt install zfsutils-linux\n  RHEL: sudo yum install zfs" 12 60
        return
    fi

    while true; do
        $DIALOG --clear --title "ZFS Management" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "List ZFS Pools" \
            "2" "List ZFS Datasets" \
            "3" "Create ZFS Pool" \
            "4" "Create ZFS Dataset" \
            "5" "Destroy ZFS Dataset" \
            "6" "ZFS Pool Status" \
            "7" "Create ZFS Snapshot" \
            "8" "List ZFS Snapshots" \
            "9" "Rollback Snapshot" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) list_zfs_pools ;;
            2) list_zfs_datasets ;;
            3) create_zfs_pool ;;
            4) create_zfs_dataset ;;
            5) destroy_zfs_dataset ;;
            6) zfs_pool_status ;;
            7) create_zfs_snapshot ;;
            8) list_zfs_snapshots ;;
            9) rollback_zfs_snapshot ;;
            0) return ;;
        esac
    done
}

list_zfs_pools() {
    pools=$(sudo zpool list 2>&1)
    $DIALOG --title "ZFS Pools" --msgbox "$pools" 20 100
}

list_zfs_datasets() {
    datasets=$(sudo zfs list 2>&1)
    $DIALOG --title "ZFS Datasets" --msgbox "$datasets" 30 100
}

create_zfs_pool() {
    $DIALOG --inputbox "Enter pool name:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    pool_name=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --yesno "Create ZFS pool '$pool_name' on $device?\n\nWARNING: All data will be destroyed!" 10 60
    if [ $? -eq 0 ]; then
        if sudo zpool create "$pool_name" "$device" 2>&1 | tee /tmp/zpool_output; then
            output=$(cat /tmp/zpool_output)
            $DIALOG --msgbox "ZFS pool created successfully!\n\n$output" 12 60
            rm -f /tmp/zpool_output
        else
            output=$(cat /tmp/zpool_output)
            $DIALOG --msgbox "Failed to create ZFS pool\n\n$output" 12 60
            rm -f /tmp/zpool_output
        fi
    fi
}

create_zfs_dataset() {
    $DIALOG --inputbox "Enter dataset name (e.g., poolname/dataset):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    dataset=$(cat "$TEMP_FILE")

    if sudo zfs create "$dataset"; then
        $DIALOG --msgbox "ZFS dataset '$dataset' created successfully" 10 60
    else
        $DIALOG --msgbox "Failed to create ZFS dataset" 8 40
    fi
}

destroy_zfs_dataset() {
    $DIALOG --inputbox "Enter dataset name to destroy:" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    dataset=$(cat "$TEMP_FILE")

    $DIALOG --yesno "Destroy ZFS dataset '$dataset'?\n\nWARNING: All data will be lost!" 10 60
    if [ $? -eq 0 ]; then
        if sudo zfs destroy "$dataset"; then
            $DIALOG --msgbox "ZFS dataset destroyed successfully" 8 50
        else
            $DIALOG --msgbox "Failed to destroy ZFS dataset" 8 40
        fi
    fi
}

zfs_pool_status() {
    $DIALOG --inputbox "Enter pool name (or leave empty for all):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    pool_name=$(cat "$TEMP_FILE")

    if [ -z "$pool_name" ]; then
        status=$(sudo zpool status 2>&1)
    else
        status=$(sudo zpool status "$pool_name" 2>&1)
    fi

    $DIALOG --title "ZFS Pool Status" --msgbox "$status" 30 100
}

create_zfs_snapshot() {
    $DIALOG --inputbox "Enter dataset name:" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    dataset=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter snapshot name:" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    snapshot_name=$(cat "$TEMP_FILE")

    if sudo zfs snapshot "${dataset}@${snapshot_name}"; then
        $DIALOG --msgbox "Snapshot created: ${dataset}@${snapshot_name}" 10 70
    else
        $DIALOG --msgbox "Failed to create snapshot" 8 40
    fi
}

list_zfs_snapshots() {
    snapshots=$(sudo zfs list -t snapshot 2>&1)
    $DIALOG --title "ZFS Snapshots" --msgbox "$snapshots" 30 100
}

rollback_zfs_snapshot() {
    $DIALOG --inputbox "Enter snapshot name (e.g., pool/dataset@snapshot):" 10 70 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    snapshot=$(cat "$TEMP_FILE")

    $DIALOG --yesno "Rollback to snapshot '$snapshot'?\n\nWARNING: This will revert all changes!" 10 70
    if [ $? -eq 0 ]; then
        if sudo zfs rollback "$snapshot"; then
            $DIALOG --msgbox "Rolled back to snapshot successfully" 8 50
        else
            $DIALOG --msgbox "Failed to rollback snapshot" 8 40
        fi
    fi
}

#=============================================================================
# DISK PARTITIONING
#=============================================================================
disk_partition_menu() {
    while true; do
        $DIALOG --clear --title "Disk Partitioning" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "List Partitions (fdisk -l)" \
            "2" "Partition Disk (fdisk)" \
            "3" "Partition Disk (parted)" \
            "4" "List Block Devices (lsblk)" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) list_partitions ;;
            2) partition_fdisk ;;
            3) partition_parted ;;
            4) list_block_devices ;;
            0) return ;;
        esac
    done
}

list_partitions() {
    partitions=$(sudo fdisk -l 2>&1)
    $DIALOG --title "Disk Partitions" --msgbox "$partitions" 30 100
}

partition_fdisk() {
    $DIALOG --inputbox "Enter device to partition (e.g., /dev/sdb):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --msgbox "You will now enter fdisk interactive mode for $device\n\nCommon commands:\n  n - new partition\n  d - delete partition\n  p - print partition table\n  w - write changes\n  q - quit without saving\n\nPress OK to continue..." 16 70

    sudo fdisk "$device"
    $DIALOG --msgbox "Exited fdisk. Check partition table with 'fdisk -l'" 10 60
}

partition_parted() {
    $DIALOG --msgbox "Opening parted (graphical partitioning tool).\n\nNote: This requires a terminal multiplexer or separate terminal.\n\nPress OK to continue..." 12 60

    $DIALOG --inputbox "Enter device to partition (e.g., /dev/sdb):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    sudo parted "$device"
    $DIALOG --msgbox "Exited parted" 8 40
}

list_block_devices() {
    devices=$(lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT 2>&1)
    $DIALOG --title "Block Devices (lsblk)" --msgbox "$devices" 30 100
}

#=============================================================================
# FILESYSTEM OPERATIONS
#=============================================================================
filesystem_menu() {
    while true; do
        $DIALOG --clear --title "Filesystem Operations" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "Create Filesystem (mkfs)" \
            "2" "Check Filesystem (fsck)" \
            "3" "Resize Filesystem" \
            "4" "Tune Filesystem (tune2fs)" \
            "5" "Label Filesystem" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) create_filesystem ;;
            2) check_filesystem ;;
            3) resize_filesystem ;;
            4) tune_filesystem ;;
            5) label_filesystem ;;
            0) return ;;
        esac
    done
}

create_filesystem() {
    $DIALOG --menu "Select filesystem type:" 15 60 6 \
        "ext4" "EXT4 (recommended)" \
        "ext3" "EXT3" \
        "xfs" "XFS" \
        "btrfs" "BTRFS" \
        "vfat" "FAT32/VFAT" \
        "ntfs" "NTFS" \
        2> "$TEMP_FILE"

    if [ $? -ne 0 ]; then return; fi
    fs_type=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --yesno "Create $fs_type filesystem on $device?\n\nWARNING: All data will be destroyed!" 10 60
    if [ $? -eq 0 ]; then
        if sudo mkfs."$fs_type" "$device" 2>&1 | tee /tmp/mkfs_output; then
            output=$(cat /tmp/mkfs_output)
            $DIALOG --msgbox "Filesystem created successfully!\n\n$output" 15 80
            rm -f /tmp/mkfs_output
        else
            output=$(cat /tmp/mkfs_output)
            $DIALOG --msgbox "Failed to create filesystem\n\n$output" 12 70
            rm -f /tmp/mkfs_output
        fi
    fi
}

check_filesystem() {
    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --msgbox "Running filesystem check on $device...\n\nThis may take a while." 10 60

    if sudo fsck -y "$device" 2>&1 | tee /tmp/fsck_output; then
        output=$(cat /tmp/fsck_output)
        $DIALOG --msgbox "Filesystem check completed!\n\n$output" 20 80
        rm -f /tmp/fsck_output
    else
        output=$(cat /tmp/fsck_output)
        $DIALOG --msgbox "Filesystem check found errors\n\n$output" 20 80
        rm -f /tmp/fsck_output
    fi
}

resize_filesystem() {
    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --menu "Select resize operation:" 12 60 2 \
        "1" "Resize to maximum (resize2fs)" \
        "2" "Resize XFS (xfs_growfs)" \
        2> "$TEMP_FILE"

    if [ $? -ne 0 ]; then return; fi
    resize_type=$(cat "$TEMP_FILE")

    case $resize_type in
        1)
            if sudo resize2fs "$device" 2>&1 | tee /tmp/resize_output; then
                output=$(cat /tmp/resize_output)
                $DIALOG --msgbox "Filesystem resized!\n\n$output" 12 70
                rm -f /tmp/resize_output
            else
                output=$(cat /tmp/resize_output)
                $DIALOG --msgbox "Resize failed\n\n$output" 12 70
                rm -f /tmp/resize_output
            fi
            ;;
        2)
            $DIALOG --inputbox "Enter mount point:" 8 60 2> "$TEMP_FILE"
            if [ $? -ne 0 ]; then return; fi
            mountpoint=$(cat "$TEMP_FILE")

            if sudo xfs_growfs "$mountpoint" 2>&1 | tee /tmp/xfs_output; then
                output=$(cat /tmp/xfs_output)
                $DIALOG --msgbox "XFS filesystem grown!\n\n$output" 12 70
                rm -f /tmp/xfs_output
            else
                output=$(cat /tmp/xfs_output)
                $DIALOG --msgbox "XFS grow failed\n\n$output" 12 70
                rm -f /tmp/xfs_output
            fi
            ;;
    esac
}

tune_filesystem() {
    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    tune_info=$(sudo tune2fs -l "$device" 2>&1)
    $DIALOG --title "Filesystem Info: $device" --msgbox "$tune_info" 30 100
}

label_filesystem() {
    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter new label:" 8 50 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    label=$(cat "$TEMP_FILE")

    if sudo e2label "$device" "$label"; then
        $DIALOG --msgbox "Label set to '$label' successfully" 10 50
    else
        $DIALOG --msgbox "Failed to set label" 8 40
    fi
}

#=============================================================================
# MOUNT/UNMOUNT OPERATIONS
#=============================================================================
mount_menu() {
    while true; do
        $DIALOG --clear --title "Mount/Unmount Operations" \
            --menu "Choose an option:" $HEIGHT $WIDTH $MENU_HEIGHT \
            "1" "View Mounted Filesystems" \
            "2" "Mount Filesystem" \
            "3" "Unmount Filesystem" \
            "4" "Edit /etc/fstab" \
            "5" "View /etc/fstab" \
            "0" "Back" \
            2> "$TEMP_FILE"

        choice=$?
        if [ $choice -ne 0 ]; then
            return
        fi

        selection=$(cat "$TEMP_FILE")

        case $selection in
            1) view_mounts ;;
            2) mount_filesystem ;;
            3) unmount_filesystem ;;
            4) edit_fstab ;;
            5) view_fstab ;;
            0) return ;;
        esac
    done
}

view_mounts() {
    mounts=$(mount | column -t 2>&1)
    $DIALOG --title "Mounted Filesystems" --msgbox "$mounts" 30 120
}

mount_filesystem() {
    $DIALOG --inputbox "Enter device path (e.g., /dev/sdb1):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    device=$(cat "$TEMP_FILE")

    $DIALOG --inputbox "Enter mount point (e.g., /mnt/mydisk):" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    mountpoint=$(cat "$TEMP_FILE")

    # Create mount point if it doesn't exist
    if [ ! -d "$mountpoint" ]; then
        $DIALOG --yesno "Mount point $mountpoint doesn't exist. Create it?" 8 60
        if [ $? -eq 0 ]; then
            sudo mkdir -p "$mountpoint"
        else
            return
        fi
    fi

    if sudo mount "$device" "$mountpoint"; then
        $DIALOG --msgbox "Mounted $device to $mountpoint successfully" 10 60
    else
        $DIALOG --msgbox "Failed to mount filesystem" 8 40
    fi
}

unmount_filesystem() {
    $DIALOG --inputbox "Enter mount point or device to unmount:" 8 60 2> "$TEMP_FILE"
    if [ $? -ne 0 ]; then return; fi
    target=$(cat "$TEMP_FILE")

    if sudo umount "$target"; then
        $DIALOG --msgbox "Unmounted $target successfully" 8 50
    else
        $DIALOG --msgbox "Failed to unmount (may be in use)" 8 50
    fi
}

edit_fstab() {
    $DIALOG --msgbox "Opening /etc/fstab for editing...\n\nBe careful! Errors can prevent system boot." 10 60

    # Use default editor or nano
    EDITOR=${EDITOR:-nano}
    sudo $EDITOR /etc/fstab

    $DIALOG --msgbox "/etc/fstab editing complete" 8 40
}

view_fstab() {
    fstab_content=$(cat /etc/fstab 2>&1)
    $DIALOG --title "/etc/fstab" --msgbox "$fstab_content" 30 100
}

#=============================================================================
# VIEW DISK INFORMATION
#=============================================================================
view_disk_info() {
    info=$(cat <<EOF
DISK USAGE (df -h)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$(df -h | grep -E '^/dev/')

BLOCK DEVICES (lsblk)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$(lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT)

DISK PARTITIONS (fdisk -l summary)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$(sudo fdisk -l 2>&1 | grep -E '^Disk /dev/')
EOF
)

    $DIALOG --title "Disk Information Overview" --msgbox "$info" 30 100
}

#=============================================================================
# MAIN EXECUTION
#=============================================================================
main_menu
