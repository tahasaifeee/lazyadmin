#!/bin/bash

# LazyAdmin - Simple Menu Version
# Single keypress navigation - no Enter needed

VERSION="2.0.0"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Clear screen and show header
show_header() {
    clear
    echo -e "${PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║               ${BOLD}LazyAdmin v$VERSION${NC}${PURPLE}                              ║${NC}"
    echo -e "${PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Main menu
main_menu() {
    while true; do
        show_header
        echo -e "${CYAN}${BOLD}MAIN MENU${NC}"
        echo ""
        echo -e "  ${GREEN}[1]${NC} System Information"
        echo -e "  ${GREEN}[2]${NC} User & Group Management"
        echo -e "  ${GREEN}[3]${NC} Disk Management (LVM, RAID, ZFS)"
        echo -e "  ${RED}[0]${NC} Exit"
        echo ""
        echo -e "${YELLOW}Press a number key to select:${NC} "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) system_info_menu ;;
            2) user_management_menu ;;
            3) disk_management_menu ;;
            0) clear; exit 0 ;;
        esac
    done
}

# System Information menu
system_info_menu() {
    while true; do
        show_header
        echo -e "${CYAN}${BOLD}SYSTEM INFORMATION${NC}"
        echo ""
        echo -e "  ${GREEN}[1]${NC} System Info"
        echo -e "  ${GREEN}[2]${NC} Services"
        echo -e "  ${GREEN}[3]${NC} Processes"
        echo -e "  ${GREEN}[4]${NC} Disk Usage"
        echo -e "  ${RED}[0]${NC} Back to Main Menu"
        echo ""
        echo -e "${YELLOW}Press a number key:${NC} "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) show_system_info ;;
            2) show_services ;;
            3) show_processes ;;
            4) show_disk_usage ;;
            0) return ;;
        esac
    done
}

# User Management menu
user_management_menu() {
    while true; do
        show_header
        echo -e "${CYAN}${BOLD}USER & GROUP MANAGEMENT${NC}"
        echo ""
        echo -e "  ${GREEN}[1]${NC} List Users & Groups"
        echo -e "  ${GREEN}[2]${NC} Create User"
        echo -e "  ${GREEN}[3]${NC} Delete User"
        echo -e "  ${GREEN}[4]${NC} Add User to Group"
        echo -e "  ${GREEN}[5]${NC} Remove User from Group"
        echo -e "  ${GREEN}[6]${NC} Set/Reset Password"
        echo -e "  ${GREEN}[7]${NC} Change User Shell"
        echo -e "  ${GREEN}[8]${NC} Lock/Unlock User"
        echo -e "  ${RED}[0]${NC} Back to Main Menu"
        echo ""
        echo -e "${YELLOW}Press a number key:${NC} "

        read -n 1 -s choice
        echo ""

        case $choice in
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

# Disk Management menu
disk_management_menu() {
    while true; do
        show_header
        echo -e "${CYAN}${BOLD}DISK MANAGEMENT (LVM, RAID, ZFS)${NC}"
        echo ""
        echo -e "  ${GREEN}[1]${NC} LVM Management"
        echo -e "  ${GREEN}[2]${NC} RAID Management (mdadm)"
        echo -e "  ${GREEN}[3]${NC} ZFS Management"
        echo -e "  ${GREEN}[4]${NC} Disk Partitioning"
        echo -e "  ${GREEN}[5]${NC} Filesystem Operations"
        echo -e "  ${GREEN}[6]${NC} Mount/Unmount Operations"
        echo -e "  ${GREEN}[7]${NC} View Disk Information"
        echo -e "  ${RED}[0]${NC} Back to Main Menu"
        echo ""
        echo -e "${YELLOW}Press a number key:${NC} "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) echo "LVM Management - Feature coming soon"; read -p "Press Enter to continue..." ;;
            2) echo "RAID Management - Feature coming soon"; read -p "Press Enter to continue..." ;;
            3) echo "ZFS Management - Feature coming soon"; read -p "Press Enter to continue..." ;;
            4) echo "Disk Partitioning - Feature coming soon"; read -p "Press Enter to continue..." ;;
            5) echo "Filesystem Operations - Feature coming soon"; read -p "Press Enter to continue..." ;;
            6) echo "Mount/Unmount - Feature coming soon"; read -p "Press Enter to continue..." ;;
            7) view_disk_info ;;
            0) return ;;
        esac
    done
}

#=============================================================================
# SYSTEM INFORMATION FUNCTIONS
#=============================================================================

show_system_info() {
    clear
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}${BOLD}                        SYSTEM INFORMATION                      ${NC}"
    echo -e "${CYAN}${BOLD}═══════════════════════════════════════════════════════════════${NC}"
    echo ""

    echo -e "${GREEN}Hostname:${NC}     $(hostname)"
    echo -e "${GREEN}OS:${NC}           $(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    echo -e "${GREEN}Kernel:${NC}       $(uname -r)"
    echo -e "${GREEN}Uptime:${NC}       $(uptime -p)"
    echo -e "${GREEN}Load Average:${NC} $(uptime | awk -F'load average:' '{print $2}')"
    echo ""
    echo -e "${GREEN}CPU:${NC}          $(lscpu | grep 'Model name' | cut -d: -f2 | xargs)"
    echo -e "${GREEN}Cores:${NC}        $(nproc)"
    echo -e "${GREEN}Architecture:${NC} $(uname -m)"
    echo ""
    echo -e "${GREEN}Memory:${NC}"
    free -h | grep -E 'Mem|Swap' | awk '{printf "  %-6s Total: %-8s Used: %-8s Free: %-8s\n", $1, $2, $3, $4}'
    echo ""
    echo -e "${GREEN}Network:${NC}"
    ip -br addr | grep -v "lo" | awk '{printf "  %-10s %s\n", $1, $3}'

    echo ""
    read -p "Press Enter to continue..."
}

show_services() {
    clear
    echo -e "${CYAN}${BOLD}TOP 20 SERVICES${NC}"
    echo ""
    systemctl list-units --type=service --state=running --no-pager | head -n 20
    echo ""
    read -p "Press Enter to continue..."
}

show_processes() {
    clear
    echo -e "${CYAN}${BOLD}TOP 20 PROCESSES (BY MEMORY)${NC}"
    echo ""
    ps aux --sort=-%mem | head -n 21
    echo ""
    read -p "Press Enter to continue..."
}

show_disk_usage() {
    clear
    echo -e "${CYAN}${BOLD}DISK USAGE${NC}"
    echo ""
    df -h | grep -E '^Filesystem|^/dev/'
    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# USER MANAGEMENT FUNCTIONS
#=============================================================================

list_users_groups() {
    clear
    echo -e "${CYAN}${BOLD}USERS (UID >= 1000)${NC}"
    echo ""
    awk -F: '$3 >= 1000 {printf "%-15s UID:%-6s Shell:%-20s Home:%s\n", $1, $3, $7, $6}' /etc/passwd
    echo ""
    echo -e "${CYAN}${BOLD}GROUPS${NC}"
    echo ""
    cut -d: -f1 /etc/group | column
    echo ""
    read -p "Press Enter to continue..."
}

create_user() {
    clear
    echo -e "${CYAN}${BOLD}CREATE USER${NC}"
    echo ""
    read -p "Enter username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    sudo useradd -m "$username"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User '$username' created successfully!${NC}"
        sudo passwd "$username"
    else
        echo -e "${RED}Failed to create user${NC}"
    fi

    read -p "Press Enter to continue..."
}

delete_user() {
    clear
    echo -e "${CYAN}${BOLD}DELETE USER${NC}"
    echo ""
    read -p "Enter username to delete: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Delete home directory? (y/n): " -n 1 delhome
    echo ""

    if [[ $delhome =~ ^[Yy]$ ]]; then
        sudo userdel -r "$username"
    else
        sudo userdel "$username"
    fi

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User deleted successfully${NC}"
    else
        echo -e "${RED}Failed to delete user${NC}"
    fi

    read -p "Press Enter to continue..."
}

add_user_to_group() {
    clear
    echo -e "${CYAN}${BOLD}ADD USER TO GROUP${NC}"
    echo ""
    read -p "Enter username: " username
    read -p "Enter group name: " groupname

    sudo usermod -aG "$groupname" "$username"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User '$username' added to group '$groupname'${NC}"
    else
        echo -e "${RED}Failed to add user to group${NC}"
    fi

    read -p "Press Enter to continue..."
}

remove_user_from_group() {
    clear
    echo -e "${CYAN}${BOLD}REMOVE USER FROM GROUP${NC}"
    echo ""
    read -p "Enter username: " username
    read -p "Enter group name: " groupname

    sudo gpasswd -d "$username" "$groupname"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}User removed from group${NC}"
    else
        echo -e "${RED}Failed to remove user from group${NC}"
    fi

    read -p "Press Enter to continue..."
}

set_password() {
    clear
    echo -e "${CYAN}${BOLD}SET/RESET PASSWORD${NC}"
    echo ""
    read -p "Enter username: " username

    sudo passwd "$username"

    read -p "Press Enter to continue..."
}

change_shell() {
    clear
    echo -e "${CYAN}${BOLD}CHANGE USER SHELL${NC}"
    echo ""
    read -p "Enter username: " username
    echo ""
    echo "Available shells:"
    echo "  1) /bin/bash"
    echo "  2) /bin/zsh"
    echo "  3) /bin/sh"
    echo "  4) /bin/fish"
    echo ""
    read -p "Choose shell (1-4): " -n 1 shell_choice
    echo ""

    case $shell_choice in
        1) newshell="/bin/bash" ;;
        2) newshell="/bin/zsh" ;;
        3) newshell="/bin/sh" ;;
        4) newshell="/bin/fish" ;;
        *) echo -e "${RED}Invalid choice${NC}"; read -p "Press Enter..."; return ;;
    esac

    sudo chsh -s "$newshell" "$username"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Shell changed to $newshell${NC}"
    else
        echo -e "${RED}Failed to change shell${NC}"
    fi

    read -p "Press Enter to continue..."
}

lock_unlock_user() {
    clear
    echo -e "${CYAN}${BOLD}LOCK/UNLOCK USER${NC}"
    echo ""
    read -p "Enter username: " username
    echo ""
    echo "  1) Lock user account"
    echo "  2) Unlock user account"
    echo ""
    read -p "Choose action (1-2): " -n 1 action
    echo ""

    case $action in
        1)
            sudo usermod -L "$username"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}User locked${NC}"
            else
                echo -e "${RED}Failed to lock user${NC}"
            fi
            ;;
        2)
            sudo usermod -U "$username"
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}User unlocked${NC}"
            else
                echo -e "${RED}Failed to unlock user${NC}"
            fi
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac

    read -p "Press Enter to continue..."
}

#=============================================================================
# DISK MANAGEMENT FUNCTIONS
#=============================================================================

view_disk_info() {
    clear
    echo -e "${CYAN}${BOLD}DISK INFORMATION${NC}"
    echo ""
    echo -e "${GREEN}DISK USAGE:${NC}"
    df -h | grep -E '^Filesystem|^/dev/'
    echo ""
    echo -e "${GREEN}BLOCK DEVICES:${NC}"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# MAIN EXECUTION
#=============================================================================

main_menu
