#!/bin/bash

# LazyAdmin - Simple Menu Version
# Single keypress navigation - no Enter needed

VERSION="2.0.0"

# Color codes - Enhanced with bright colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

# Bright/Bold colors
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_PURPLE='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'

# Background colors
BG_BLUE='\033[44m'
BG_GREEN='\033[42m'
BG_RED='\033[41m'

BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# Clear screen and show header
show_header() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║  ${BRIGHT_CYAN}█${BRIGHT_BLUE}█${BRIGHT_GREEN}█ ${WHITE}${BOLD}LazyAdmin${NC} ${BRIGHT_YELLOW}v$VERSION${NC}  ${BRIGHT_CYAN}Linux System Administration${BRIGHT_PURPLE}  ║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Main menu
main_menu() {
    while true; do
        show_header
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${WHITE}${BOLD}MAIN MENU${NC}                                                   ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}System Information${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${WHITE}User & Group Management${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}Disk Management${NC} ${DIM}(LVM, RAID, ZFS)${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${WHITE}Package Management${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${WHITE}Network Tools${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${WHITE}File Management${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Exit${NC}"
        echo ""
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC} Press a number key to select                            ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"

        read -n 1 -s choice
        echo ""

        case $choice in
            1) system_info_menu ;;
            2) user_management_menu ;;
            3) disk_management_menu ;;
            4) package_management_menu ;;
            5) network_tools_menu ;;
            6) file_management_menu ;;
            0) clear; exit 0 ;;
        esac
    done
}

# System Information menu
system_info_menu() {
    while true; do
        show_header
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${BRIGHT_BLUE}${WHITE}${BOLD}SYSTEM INFORMATION${NC}                                     ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}System Info${NC}         ${DIM}- View system metrics & hardware${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${WHITE}Services${NC}            ${DIM}- Manage systemd services${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}Processes${NC}           ${DIM}- View running processes${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${WHITE}Disk Usage${NC}          ${DIM}- Monitor disk space${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "Press a number key: "

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
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${BRIGHT_YELLOW}👥 ${WHITE}${BOLD}USER & GROUP MANAGEMENT${NC}                                ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}List Users & Groups${NC}      ${DIM}- View all users/groups${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${WHITE}Create User${NC}              ${DIM}- Add new user account${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}Delete User${NC}              ${DIM}- Remove user account${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${WHITE}Add User to Group${NC}        ${DIM}- Grant group membership${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${WHITE}Remove User from Group${NC}   ${DIM}- Revoke group membership${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${WHITE}Set/Reset Password${NC}       ${DIM}- Change user password${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${WHITE}Change User Shell${NC}        ${DIM}- Modify login shell${NC}"
        echo -e "  ${BRIGHT_GREEN}[8]${NC} ${WHITE}Lock/Unlock User${NC}         ${DIM}- Toggle account lock${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "Press a number key: "

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
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${BRIGHT_PURPLE}💾 ${WHITE}${BOLD}DISK MANAGEMENT${NC} ${DIM}(LVM, RAID, ZFS)${NC}                      ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}LVM Management${NC}           ${DIM}- Physical/Logical Volumes${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${WHITE}RAID Management${NC}          ${DIM}- mdadm RAID arrays${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}ZFS Management${NC}           ${DIM}- Pools, datasets, snapshots${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${WHITE}Disk Partitioning${NC}        ${DIM}- fdisk, parted${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${WHITE}Filesystem Operations${NC}    ${DIM}- Create, check, resize${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${WHITE}Mount/Unmount${NC}            ${DIM}- Mount operations${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${BRIGHT_CYAN}ℹ${NC}  ${WHITE}View Disk Information${NC}    ${DIM}- Comprehensive overview${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "Press a number key: "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) manage_lvm ;;
            2) manage_raid ;;
            3) manage_zfs ;;
            4) manage_partitioning ;;
            5) manage_filesystems ;;
            6) manage_mount_operations ;;
            7) view_disk_info ;;
            0) return ;;
        esac
    done
}

# Package Management menu
package_management_menu() {
    while true; do
        show_header
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${BRIGHT_CYAN}📦 ${WHITE}${BOLD}PACKAGE MANAGEMENT${NC}                                      ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}Update Package Lists${NC}     ${DIM}- apt/yum/dnf update${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_GREEN}⬇${NC}  ${WHITE}Install a Package${NC}        ${DIM}- Install new software${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}Remove a Package${NC}         ${DIM}- Uninstall software${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_YELLOW}⬆${NC}  ${WHITE}Upgrade System${NC}           ${DIM}- Update all packages${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${WHITE}Search Package${NC}           ${DIM}- Find packages${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${WHITE}List Installed Packages${NC}  ${DIM}- Show installed${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${WHITE}Clean Package Cache${NC}      ${DIM}- Free disk space${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "Press a number key: "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) update_package_lists ;;
            2) install_package ;;
            3) remove_package ;;
            4) upgrade_system ;;
            5) search_package ;;
            6) list_installed_packages ;;
            7) clean_package_cache ;;
            0) return ;;
        esac
    done
}

# Network Tools menu
network_tools_menu() {
    while true; do
        show_header
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${WHITE}${BOLD}NETWORK TOOLS${NC}                                           ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}Ping Test${NC}                ${DIM}- Test connectivity${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${WHITE}Traceroute${NC}               ${DIM}- Trace network path${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}DNS Lookup${NC}               ${DIM}- Resolve domains${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${WHITE}Check Open Ports${NC}         ${DIM}- View listening ports${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${WHITE}Test Specific Port${NC}       ${DIM}- Check port status${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${WHITE}Network Speed Test${NC}       ${DIM}- Measure bandwidth${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${WHITE}Flush DNS Cache${NC}          ${DIM}- Clear DNS cache${NC}"
        echo -e "  ${BRIGHT_GREEN}[8]${NC} ${WHITE}Restart Network Service${NC}  ${DIM}- Restart networking${NC}"
        echo -e "  ${BRIGHT_GREEN}[9]${NC} ${WHITE}Create Virtual Interface${NC} ${DIM}- Add virtual NIC${NC}"
        echo -e "  ${BRIGHT_GREEN}[10]${NC} ${WHITE}Create Network Bond${NC}     ${DIM}- Bond interfaces${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        read -p "Enter choice: " choice

        case $choice in
            1) ping_test ;;
            2) traceroute_test ;;
            3) dns_lookup ;;
            4) check_open_ports ;;
            5) test_specific_port ;;
            6) network_speed_test ;;
            7) flush_dns_cache ;;
            8) restart_network_service ;;
            9) create_virtual_interface ;;
            10) create_network_bond ;;
            0) return ;;
        esac
    done
}

#=============================================================================
# SYSTEM INFORMATION FUNCTIONS
#=============================================================================

show_system_info() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📊 ${WHITE}${BOLD}SYSTEM INFORMATION${NC}                                       ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ System Details ────────────────────────────────────────────┐${NC}"
    echo -e "  ${BRIGHT_GREEN}Hostname:${NC}     ${WHITE}$(hostname)${NC}"
    echo -e "  ${BRIGHT_GREEN}OS:${NC}           ${WHITE}$(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)${NC}"
    echo -e "  ${BRIGHT_GREEN}Kernel:${NC}       ${WHITE}$(uname -r)${NC}"
    echo -e "  ${BRIGHT_GREEN}Uptime:${NC}       ${BRIGHT_CYAN}$(uptime -p)${NC}"
    echo -e "  ${BRIGHT_GREEN}Load Average:${NC} ${BRIGHT_YELLOW}$(uptime | awk -F'load average:' '{print $2}')${NC}"
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_BLUE}┌─ CPU Information ────────────────────────────────────────────┐${NC}"
    echo -e "  ${BRIGHT_GREEN}CPU:${NC}          ${WHITE}$(lscpu | grep 'Model name' | cut -d: -f2 | xargs)${NC}"
    echo -e "  ${BRIGHT_GREEN}Cores:${NC}        ${BRIGHT_CYAN}$(nproc)${NC}"
    echo -e "  ${BRIGHT_GREEN}Architecture:${NC} ${BRIGHT_CYAN}$(uname -m)${NC}"
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_PURPLE}┌─ Memory Usage ───────────────────────────────────────────────┐${NC}"
    free -h | grep -E 'Mem|Swap' | awk -v green="'"${BRIGHT_GREEN}"'" -v white="'"${WHITE}"'" -v cyan="'"${BRIGHT_CYAN}"'" -v nc="'"${NC}"'" '{printf "  " green "%-6s" nc " Total: " cyan "%-8s" nc " Used: " white "%-8s" nc " Free: " cyan "%-8s" nc "\n", $1, $2, $3, $4}'
    echo -e "${BRIGHT_PURPLE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}┌─ Network Interfaces ─────────────────────────────────────────┐${NC}"
    ip -br addr | grep -v "lo" | awk -v green="'"${BRIGHT_GREEN}"'" -v white="'"${WHITE}"'" -v nc="'"${NC}"'" '{printf "  " green "%-10s" nc " " white "%s" nc "\n", $1, $3}'
    echo -e "${BRIGHT_CYAN}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    echo -e "${DIM}Press Enter to continue...${NC}"
    read
}

show_services() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_PURPLE}🔧 ${WHITE}${BOLD}RUNNING SERVICES${NC} ${DIM}(Top 20)${NC}                             ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    systemctl list-units --type=service --state=running --no-pager | head -n 20
    echo ""
    echo -e "${DIM}Press Enter to continue...${NC}"
    read
}

show_processes() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}⚡ ${WHITE}${BOLD}TOP PROCESSES${NC} ${DIM}(Sorted by Memory Usage)${NC}              ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    ps aux --sort=-%mem | head -n 21
    echo ""
    echo -e "${DIM}Press Enter to continue...${NC}"
    read
}

show_disk_usage() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}💿 ${WHITE}${BOLD}DISK USAGE${NC}                                                ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BRIGHT_CYAN}Filesystem${NC}      ${BRIGHT_GREEN}Size${NC}  ${BRIGHT_YELLOW}Used${NC}  ${BRIGHT_BLUE}Avail${NC} ${BRIGHT_PURPLE}Use%${NC} ${BRIGHT_CYAN}Mounted on${NC}"
    df -h | grep -E '^/dev/'
    echo ""
    echo -e "${DIM}Press Enter to continue...${NC}"
    read
}

#=============================================================================
# USER MANAGEMENT FUNCTIONS
#=============================================================================

list_users_groups() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📋 ${WHITE}${BOLD}USERS & GROUPS${NC}                                            ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ System Users (UID >= 1000) ────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-15s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%-6s'"${NC}"' Shell:'"${WHITE}"'%-20s'"${NC}"'\n", $1, $3, $7}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_BLUE}┌─ Available Groups ───────────────────────────────────────────┐${NC}"
    cut -d: -f1 /etc/group | column | sed "s/^/  ${WHITE}/" | sed "s/$/${NC}/"
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    echo -e "${DIM}Press Enter to continue...${NC}"
    read
}

create_user() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}➕ ${WHITE}${BOLD}CREATE USER${NC}                                               ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ Current Users ──────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-20s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%s'"${NC}"'\n", $1, $3}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter new username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' already exists${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    sudo useradd -m "$username"
    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ User '$username' created successfully!${NC}"
        echo ""
        echo -e "${BRIGHT_CYAN}Setting password for user '$username':${NC}"
        sudo passwd "$username"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create user${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

delete_user() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_RED}➖ ${WHITE}${BOLD}DELETE USER${NC}                                               ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Get users into array
    mapfile -t users < <(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "${YELLOW}No users found (UID >= 1000)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Select User to Delete ──────────────────────────────────────┐${NC}"
    local i=1
    for user in "${users[@]}"; do
        local uid=$(id -u "$user")
        local shell=$(getent passwd "$user" | cut -d: -f7)
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-15s ${DIM}UID:${NC}${BRIGHT_CYAN}%-6s${NC} ${DIM}Shell:${NC}${WHITE}%s${NC}\n" "$i" "$user" "$uid" "$shell"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter user number (or 0 to cancel): " user_num

    if [ -z "$user_num" ] || [ "$user_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$user_num" =~ ^[0-9]+$ ]] || [ "$user_num" -lt 1 ] || [ "$user_num" -gt ${#users[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local username="${users[$((user_num-1))]}"

    echo ""
    echo -e "${BRIGHT_YELLOW}⚠  Confirm deletion of user: ${BRIGHT_RED}$username${NC}"
    read -p "Are you sure? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    read -p "Delete home directory? (y/n): " -n 1 delhome
    echo ""
    echo ""

    if [[ $delhome =~ ^[Yy]$ ]]; then
        sudo userdel -r "$username"
    else
        sudo userdel "$username"
    fi

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ User '$username' deleted successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to delete user${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

add_user_to_group() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}👤 ${WHITE}${BOLD}ADD USER TO GROUP${NC}                                         ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Get users into array
    mapfile -t users < <(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "${YELLOW}No users found (UID >= 1000)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Select User ────────────────────────────────────────────────┐${NC}"
    local i=1
    for user in "${users[@]}"; do
        local uid=$(id -u "$user")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s ${DIM}UID:${NC}${BRIGHT_CYAN}%s${NC}\n" "$i" "$user" "$uid"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter user number (or 0 to cancel): " user_num

    if [ -z "$user_num" ] || [ "$user_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$user_num" =~ ^[0-9]+$ ]] || [ "$user_num" -lt 1 ] || [ "$user_num" -gt ${#users[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local username="${users[$((user_num-1))]}"

    echo ""
    # Get groups into array
    mapfile -t groups < <(cut -d: -f1 /etc/group | sort)

    echo -e "${BRIGHT_BLUE}┌─ Select Group ───────────────────────────────────────────────┐${NC}"
    i=1
    for group in "${groups[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s" "$i" "$group"
        ((i++))
        if [ $((i % 3)) -eq 1 ]; then
            echo ""
        fi
    done
    [ $((i % 3)) -ne 1 ] && echo ""
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo -e "${DIM}Total groups: ${#groups[@]}${NC}"
    echo ""

    read -p "Enter group number (or 0 to cancel): " group_num

    if [ -z "$group_num" ] || [ "$group_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$group_num" =~ ^[0-9]+$ ]] || [ "$group_num" -lt 1 ] || [ "$group_num" -gt ${#groups[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local groupname="${groups[$((group_num-1))]}"

    echo ""
    echo -e "${BRIGHT_YELLOW}Adding user ${BRIGHT_CYAN}$username${NC} to group ${BRIGHT_CYAN}$groupname${NC}"
    read -p "Confirm? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    sudo usermod -aG "$groupname" "$username"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ User '$username' added to group '$groupname'${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to add user to group${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

remove_user_from_group() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}👥 ${WHITE}${BOLD}REMOVE USER FROM GROUP${NC}                                    ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Get users into array
    mapfile -t users < <(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "${YELLOW}No users found (UID >= 1000)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Select User ────────────────────────────────────────────────┐${NC}"
    local i=1
    for user in "${users[@]}"; do
        local uid=$(id -u "$user")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s ${DIM}UID:${NC}${BRIGHT_CYAN}%s${NC}\n" "$i" "$user" "$uid"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter user number (or 0 to cancel): " user_num

    if [ -z "$user_num" ] || [ "$user_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$user_num" =~ ^[0-9]+$ ]] || [ "$user_num" -lt 1 ] || [ "$user_num" -gt ${#users[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local username="${users[$((user_num-1))]}"

    echo ""
    # Get groups into array
    mapfile -t groups < <(cut -d: -f1 /etc/group | sort)

    echo -e "${BRIGHT_BLUE}┌─ Select Group ───────────────────────────────────────────────┐${NC}"
    i=1
    for group in "${groups[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s" "$i" "$group"
        ((i++))
        if [ $((i % 3)) -eq 1 ]; then
            echo ""
        fi
    done
    [ $((i % 3)) -ne 1 ] && echo ""
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo -e "${DIM}Total groups: ${#groups[@]}${NC}"
    echo ""

    read -p "Enter group number (or 0 to cancel): " group_num

    if [ -z "$group_num" ] || [ "$group_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$group_num" =~ ^[0-9]+$ ]] || [ "$group_num" -lt 1 ] || [ "$group_num" -gt ${#groups[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local groupname="${groups[$((group_num-1))]}"

    echo ""
    echo -e "${BRIGHT_YELLOW}Removing user ${BRIGHT_CYAN}$username${NC} from group ${BRIGHT_CYAN}$groupname${NC}"
    read -p "Confirm? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    sudo gpasswd -d "$username" "$groupname"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ User '$username' removed from group '$groupname'${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to remove user from group${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

set_password() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_PURPLE}🔑 ${WHITE}${BOLD}SET/RESET PASSWORD${NC}                                        ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Get users into array
    mapfile -t users < <(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "${YELLOW}No users found (UID >= 1000)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Select User ────────────────────────────────────────────────┐${NC}"
    local i=1
    for user in "${users[@]}"; do
        local uid=$(id -u "$user")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s ${DIM}UID:${NC}${BRIGHT_CYAN}%s${NC}\n" "$i" "$user" "$uid"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter user number (or 0 to cancel): " user_num

    if [ -z "$user_num" ] || [ "$user_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$user_num" =~ ^[0-9]+$ ]] || [ "$user_num" -lt 1 ] || [ "$user_num" -gt ${#users[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local username="${users[$((user_num-1))]}"

    echo ""
    echo -e "${BRIGHT_CYAN}Setting password for user: ${BRIGHT_YELLOW}$username${NC}"
    echo ""
    sudo passwd "$username"

    echo ""
    read -p "Press Enter to continue..."
}

change_shell() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}🐚 ${WHITE}${BOLD}CHANGE USER SHELL${NC}                                         ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Get users into array
    mapfile -t users < <(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "${YELLOW}No users found (UID >= 1000)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Select User ────────────────────────────────────────────────┐${NC}"
    local i=1
    for user in "${users[@]}"; do
        local shell=$(getent passwd "$user" | cut -d: -f7)
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s ${DIM}Current Shell:${NC} ${WHITE}%s${NC}\n" "$i" "$user" "$shell"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter user number (or 0 to cancel): " user_num

    if [ -z "$user_num" ] || [ "$user_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$user_num" =~ ^[0-9]+$ ]] || [ "$user_num" -lt 1 ] || [ "$user_num" -gt ${#users[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local username="${users[$((user_num-1))]}"

    echo ""
    echo -e "${BRIGHT_BLUE}Select new shell for user ${BRIGHT_CYAN}$username${NC}:"
    echo -e "  ${BRIGHT_GREEN}1)${NC} ${WHITE}/bin/bash${NC}"
    echo -e "  ${BRIGHT_GREEN}2)${NC} ${WHITE}/bin/zsh${NC}"
    echo -e "  ${BRIGHT_GREEN}3)${NC} ${WHITE}/bin/sh${NC}"
    echo -e "  ${BRIGHT_GREEN}4)${NC} ${WHITE}/bin/fish${NC}"
    echo ""
    read -p "Choose shell (1-4): " -n 1 shell_choice
    echo ""
    echo ""

    case $shell_choice in
        1) newshell="/bin/bash" ;;
        2) newshell="/bin/zsh" ;;
        3) newshell="/bin/sh" ;;
        4) newshell="/bin/fish" ;;
        *) echo -e "${BRIGHT_RED}✗ Invalid choice${NC}"; read -p "Press Enter..."; return ;;
    esac

    sudo chsh -s "$newshell" "$username"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Shell changed to $newshell for user '$username'${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to change shell${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

lock_unlock_user() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_RED}🔒 ${WHITE}${BOLD}LOCK/UNLOCK USER${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Get users into array
    mapfile -t users < <(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)

    if [ ${#users[@]} -eq 0 ]; then
        echo -e "${YELLOW}No users found (UID >= 1000)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Select User ────────────────────────────────────────────────┐${NC}"
    local i=1
    for user in "${users[@]}"; do
        local uid=$(id -u "$user")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s ${DIM}UID:${NC}${BRIGHT_CYAN}%s${NC}\n" "$i" "$user" "$uid"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter user number (or 0 to cancel): " user_num

    if [ -z "$user_num" ] || [ "$user_num" -eq 0 ] 2>/dev/null; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! [[ "$user_num" =~ ^[0-9]+$ ]] || [ "$user_num" -lt 1 ] || [ "$user_num" -gt ${#users[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local username="${users[$((user_num-1))]}"

    echo ""
    echo -e "${BRIGHT_BLUE}Select action for user ${BRIGHT_CYAN}$username${NC}:${NC}"
    echo -e "  ${BRIGHT_RED}1)${NC} ${WHITE}Lock user account${NC}   ${DIM}(disable login)${NC}"
    echo -e "  ${BRIGHT_GREEN}2)${NC} ${WHITE}Unlock user account${NC} ${DIM}(enable login)${NC}"
    echo ""
    read -p "Choose action (1-2): " -n 1 action
    echo ""
    echo ""

    case $action in
        1)
            sudo usermod -L "$username"
            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ User '$username' locked successfully${NC}"
            else
                echo -e "${BRIGHT_RED}✗ Failed to lock user${NC}"
            fi
            ;;
        2)
            sudo usermod -U "$username"
            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ User '$username' unlocked successfully${NC}"
            else
                echo -e "${BRIGHT_RED}✗ Failed to unlock user${NC}"
            fi
            ;;
        *)
            echo -e "${BRIGHT_RED}✗ Invalid choice${NC}"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# DISK MANAGEMENT FUNCTIONS
#=============================================================================

view_disk_info() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}ℹ  ${WHITE}${BOLD}DISK INFORMATION${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ Disk Usage ─────────────────────────────────────────────────┐${NC}"
    df -h | grep -E '^Filesystem|^/dev/'
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}┌─ Block Devices ──────────────────────────────────────────────┐${NC}"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
    echo -e "${BRIGHT_CYAN}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    echo -e "${DIM}Press Enter to continue...${NC}"
    read
}

# RAID Management
manage_raid() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}⚡ ${WHITE}${BOLD}RAID MANAGEMENT (mdadm)${NC}                                   ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Check if mdadm is installed
    if ! command -v mdadm &> /dev/null; then
        echo -e "${YELLOW}mdadm is not installed.${NC}"
        echo ""
        read -p "Would you like to install it? (y/n): " -n 1 install_choice
        echo ""

        if [[ $install_choice =~ ^[Yy]$ ]]; then
            PKG_MGR=$(detect_package_manager)
            case $PKG_MGR in
                apt) sudo apt install -y mdadm ;;
                dnf) sudo dnf install -y mdadm ;;
                yum) sudo yum install -y mdadm ;;
                *) echo -e "${RED}Could not install mdadm${NC}"; read -p "Press Enter..."; return ;;
            esac
        else
            read -p "Press Enter to continue..."
            return
        fi
    fi

    echo -e "${BRIGHT_CYAN}RAID Operations:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} View RAID Arrays"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Create RAID Array ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Stop RAID Array"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} Remove RAID Array"
    echo -e "  ${BRIGHT_RED}[0]${NC} Back"
    echo ""
    read -p "Choose option: " -n 1 raid_choice
    echo ""
    echo ""

    case $raid_choice in
        1) view_raid_arrays ;;
        2) create_raid_wizard ;;
        3) stop_raid_array ;;
        4) remove_raid_array ;;
        0) return ;;
    esac
}

view_raid_arrays() {
    clear
    echo -e "${BRIGHT_CYAN}${BOLD}RAID ARRAYS STATUS${NC}"
    echo ""

    if [ ! -f /proc/mdstat ]; then
        echo -e "${YELLOW}No RAID support in kernel${NC}"
    else
        cat /proc/mdstat
    fi

    echo ""
    echo -e "${BRIGHT_GREEN}Detailed RAID Information:${NC}"
    echo ""
    sudo mdadm --detail --scan 2>/dev/null || echo -e "${DIM}No RAID arrays found${NC}"

    echo ""
    read -p "Press Enter to continue..."
}

create_raid_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}CREATE RAID ARRAY - Wizard${NC}                               ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Auto-detect available disks
    echo -e "${BRIGHT_CYAN}Auto-detecting available disks...${NC}"
    echo ""

    mapfile -t disks < <(lsblk -dpno NAME,SIZE,TYPE | grep disk | awk '{print $1 " (" $2 ")"}')

    if [ ${#disks[@]} -lt 2 ]; then
        echo -e "${RED}Need at least 2 disks for RAID. Found: ${#disks[@]}${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Disks ────────────────────────────────────────────┐${NC}"
    local i=1
    for disk in "${disks[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$disk"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    # Select RAID level
    echo -e "${BRIGHT_BLUE}Select RAID Level:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} RAID 0 ${DIM}(Striping - 2+ disks, no redundancy, max performance)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} RAID 1 ${DIM}(Mirroring - 2+ disks, full redundancy)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} RAID 5 ${DIM}(Striping + Parity - 3+ disks, 1 disk redundancy)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} RAID 6 ${DIM}(Double Parity - 4+ disks, 2 disk redundancy)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} RAID 10 ${DIM}(Mirrored Striping - 4+ disks, best of both)${NC}"
    echo ""
    read -p "Choose RAID level (1-5, 0 to cancel): " -n 1 raid_level
    echo ""
    echo ""

    local raid_type min_disks
    case $raid_level in
        1) raid_type="0"; min_disks=2 ;;
        2) raid_type="1"; min_disks=2 ;;
        3) raid_type="5"; min_disks=3 ;;
        4) raid_type="6"; min_disks=4 ;;
        5) raid_type="10"; min_disks=4 ;;
        0) return ;;
        *) echo -e "${RED}Invalid choice${NC}"; read -p "Press Enter..."; return ;;
    esac

    if [ ${#disks[@]} -lt $min_disks ]; then
        echo -e "${RED}RAID $raid_type requires at least $min_disks disks. Found: ${#disks[@]}${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Select disks
    echo -e "${BRIGHT_CYAN}Select disks for RAID $raid_type (minimum: $min_disks)${NC}"
    echo -e "${DIM}Enter disk numbers separated by spaces (e.g., 1 2 3):${NC}"
    read -p "> " disk_selection

    # Parse selection
    local selected_disks=()
    for num in $disk_selection; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#disks[@]} ]; then
            local disk_path=$(echo "${disks[$((num-1))]}" | awk '{print $1}')
            selected_disks+=("$disk_path")
        fi
    done

    if [ ${#selected_disks[@]} -lt $min_disks ]; then
        echo -e "${RED}Not enough valid disks selected${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # RAID device name
    echo ""
    read -p "Enter RAID device name (e.g., md0): " raid_name
    raid_name="/dev/${raid_name#/dev/}"

    # Confirmation
    echo ""
    echo -e "${BRIGHT_YELLOW}⚠  RAID Configuration Summary:${NC}"
    echo -e "  ${WHITE}RAID Level:${NC} ${BRIGHT_CYAN}$raid_type${NC}"
    echo -e "  ${WHITE}Device:${NC} ${BRIGHT_CYAN}$raid_name${NC}"
    echo -e "  ${WHITE}Disks:${NC} ${BRIGHT_CYAN}${selected_disks[*]}${NC}"
    echo -e "  ${WHITE}Count:${NC} ${BRIGHT_CYAN}${#selected_disks[@]} disks${NC}"
    echo ""
    echo -e "${BRIGHT_RED}WARNING: This will erase all data on selected disks!${NC}"
    read -p "Continue? (yes/no): " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create RAID
    echo ""
    echo -e "${BRIGHT_GREEN}Creating RAID array...${NC}"
    sudo mdadm --create "$raid_name" --level="$raid_type" --raid-devices="${#selected_disks[@]}" "${selected_disks[@]}"

    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${BRIGHT_GREEN}✓ RAID array created successfully!${NC}"
        echo ""
        echo -e "${BRIGHT_CYAN}Array details:${NC}"
        sudo mdadm --detail "$raid_name"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create RAID array${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

stop_raid_array() {
    clear
    echo -e "${BRIGHT_CYAN}${BOLD}STOP RAID ARRAY${NC}"
    echo ""

    # List active arrays
    mapfile -t arrays < <(cat /proc/mdstat | grep ^md | awk '{print $1}')

    if [ ${#arrays[@]} -eq 0 ]; then
        echo -e "${YELLOW}No active RAID arrays found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}Active RAID Arrays:${NC}"
    local i=1
    for array in "${arrays[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} /dev/%s\n" "$i" "$array"
        ((i++))
    done
    echo ""

    read -p "Enter array number to stop (0 to cancel): " array_num

    if [ -z "$array_num" ] || [ "$array_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$array_num" =~ ^[0-9]+$ ]] || [ "$array_num" -lt 1 ] || [ "$array_num" -gt ${#arrays[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local array_name="/dev/${arrays[$((array_num-1))]}"

    echo ""
    echo -e "${BRIGHT_YELLOW}⚠  Stopping RAID array: ${BRIGHT_RED}$array_name${NC}"
    read -p "Continue? (y/n): " -n 1 confirm
    echo ""

    if [[ $confirm =~ ^[Yy]$ ]]; then
        sudo mdadm --stop "$array_name"
        if [ $? -eq 0 ]; then
            echo -e "${BRIGHT_GREEN}✓ Array stopped${NC}"
        else
            echo -e "${BRIGHT_RED}✗ Failed to stop array${NC}"
        fi
    fi

    echo ""
    read -p "Press Enter to continue..."
}

remove_raid_array() {
    clear
    echo -e "${BRIGHT_CYAN}${BOLD}REMOVE RAID ARRAY${NC}"
    echo ""

    # List arrays
    mapfile -t arrays < <(cat /proc/mdstat 2>/dev/null | grep ^md | awk '{print $1}')

    if [ ${#arrays[@]} -eq 0 ]; then
        echo -e "${YELLOW}No RAID arrays found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}RAID Arrays:${NC}"
    local i=1
    for array in "${arrays[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} /dev/%s\n" "$i" "$array"
        ((i++))
    done
    echo ""

    read -p "Enter array number to remove (0 to cancel): " array_num

    if [ -z "$array_num" ] || [ "$array_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$array_num" =~ ^[0-9]+$ ]] || [ "$array_num" -lt 1 ] || [ "$array_num" -gt ${#arrays[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local array_name="/dev/${arrays[$((array_num-1))]}"

    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: This will permanently remove RAID array: $array_name${NC}"
    read -p "Type 'yes' to confirm: " confirm

    if [ "$confirm" = "yes" ]; then
        sudo mdadm --stop "$array_name" 2>/dev/null
        sudo mdadm --remove "$array_name" 2>/dev/null
        sudo mdadm --zero-superblock "$array_name" 2>/dev/null

        echo -e "${BRIGHT_GREEN}✓ Array removed${NC}"
    else
        echo -e "${YELLOW}Cancelled${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# LVM Management
manage_lvm() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}📊 ${WHITE}${BOLD}LVM MANAGEMENT${NC}                                            ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Check if LVM tools are installed
    if ! command -v lvm &> /dev/null; then
        echo -e "${YELLOW}LVM tools not installed.${NC}"
        echo ""
        read -p "Would you like to install lvm2? (y/n): " -n 1 install_choice
        echo ""

        if [[ $install_choice =~ ^[Yy]$ ]]; then
            PKG_MGR=$(detect_package_manager)
            case $PKG_MGR in
                apt) sudo apt install -y lvm2 ;;
                dnf) sudo dnf install -y lvm2 ;;
                yum) sudo yum install -y lvm2 ;;
                *) echo -e "${RED}Could not install lvm2${NC}"; read -p "Press Enter..."; return ;;
            esac
        else
            read -p "Press Enter to continue..."
            return
        fi
    fi

    echo -e "${BRIGHT_CYAN}LVM Operations:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} View LVM Information ${DIM}(PV/VG/LV)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Create Physical Volume ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Create Volume Group ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} Create Logical Volume ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} Extend Logical Volume"
    echo -e "  ${BRIGHT_GREEN}[6]${NC} Remove LVM Component"
    echo -e "  ${BRIGHT_RED}[0]${NC} Back"
    echo ""
    read -p "Choose option: " -n 1 lvm_choice
    echo ""
    echo ""

    case $lvm_choice in
        1) view_lvm_info ;;
        2) create_pv_wizard ;;
        3) create_vg_wizard ;;
        4) create_lv_wizard ;;
        5) extend_lv_wizard ;;
        6) remove_lvm_component ;;
        0) return ;;
    esac
}

view_lvm_info() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📊 ${WHITE}${BOLD}LVM INFORMATION${NC}                                           ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ Physical Volumes (PV) ──────────────────────────────────────┐${NC}"
    sudo pvs 2>/dev/null || echo -e "${DIM}  No physical volumes${NC}"
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_BLUE}┌─ Volume Groups (VG) ─────────────────────────────────────────┐${NC}"
    sudo vgs 2>/dev/null || echo -e "${DIM}  No volume groups${NC}"
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_GREEN}┌─ Logical Volumes (LV) ───────────────────────────────────────┐${NC}"
    sudo lvs 2>/dev/null || echo -e "${DIM}  No logical volumes${NC}"
    echo -e "${BRIGHT_GREEN}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    read -p "Press Enter to continue..."
}

create_pv_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}CREATE PHYSICAL VOLUME - Wizard${NC}                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Auto-detect available disks/partitions
    echo -e "${BRIGHT_CYAN}Auto-detecting available devices...${NC}"
    echo ""

    mapfile -t devices < <(lsblk -dpno NAME,SIZE,TYPE | grep -E 'disk|part' | awk '{print $1 " (" $2 " " $3 ")"}')

    if [ ${#devices[@]} -eq 0 ]; then
        echo -e "${RED}No available devices found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Devices ──────────────────────────────────────────┐${NC}"
    local i=1
    for device in "${devices[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$device"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter device number (0 to cancel): " dev_num

    if [ -z "$dev_num" ] || [ "$dev_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$dev_num" =~ ^[0-9]+$ ]] || [ "$dev_num" -lt 1 ] || [ "$dev_num" -gt ${#devices[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local device_path=$(echo "${devices[$((dev_num-1))]}" | awk '{print $1}')

    echo ""
    echo -e "${BRIGHT_YELLOW}⚠  Creating Physical Volume on: ${BRIGHT_CYAN}$device_path${NC}"
    echo -e "${BRIGHT_RED}WARNING: This will erase all data on the device!${NC}"
    read -p "Continue? (yes/no): " confirm

    if [ "$confirm" = "yes" ]; then
        echo ""
        sudo pvcreate "$device_path"
        if [ $? -eq 0 ]; then
            echo -e "${BRIGHT_GREEN}✓ Physical Volume created successfully${NC}"
        else
            echo -e "${BRIGHT_RED}✗ Failed to create Physical Volume${NC}"
        fi
    else
        echo -e "${YELLOW}Cancelled${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

create_vg_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}CREATE VOLUME GROUP - Wizard${NC}                             ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List available PVs
    mapfile -t pvs < <(sudo pvs --noheadings -o pv_name,pv_size,vg_name 2>/dev/null | awk '$3 == "" {print $1 " (" $2 ")"}')

    if [ ${#pvs[@]} -eq 0 ]; then
        echo -e "${YELLOW}No available Physical Volumes found${NC}"
        echo -e "${DIM}Create a Physical Volume first${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Physical Volumes ─────────────────────────────────┐${NC}"
    local i=1
    for pv in "${pvs[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$pv"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${DIM}Enter PV numbers separated by spaces (e.g., 1 2 3):${NC}"
    read -p "> " pv_selection

    # Parse selection
    local selected_pvs=()
    for num in $pv_selection; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#pvs[@]} ]; then
            local pv_path=$(echo "${pvs[$((num-1))]}" | awk '{print $1}')
            selected_pvs+=("$pv_path")
        fi
    done

    if [ ${#selected_pvs[@]} -eq 0 ]; then
        echo -e "${RED}No valid PVs selected${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    read -p "Enter Volume Group name: " vg_name

    if [ -z "$vg_name" ]; then
        echo -e "${RED}VG name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Creating Volume Group: ${BRIGHT_YELLOW}$vg_name${NC}"
    echo -e "${WHITE}Physical Volumes: ${BRIGHT_CYAN}${selected_pvs[*]}${NC}"
    echo ""
    read -p "Continue? (y/n): " -n 1 confirm
    echo ""

    if [[ $confirm =~ ^[Yy]$ ]]; then
        echo ""
        sudo vgcreate "$vg_name" "${selected_pvs[@]}"
        if [ $? -eq 0 ]; then
            echo -e "${BRIGHT_GREEN}✓ Volume Group created successfully${NC}"
        else
            echo -e "${BRIGHT_RED}✗ Failed to create Volume Group${NC}"
        fi
    else
        echo -e "${YELLOW}Cancelled${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

create_lv_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}CREATE LOGICAL VOLUME - Wizard${NC}                           ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List available VGs
    mapfile -t vgs < <(sudo vgs --noheadings -o vg_name,vg_size,vg_free 2>/dev/null | awk '{print $1 " (Size:" $2 " Free:" $3 ")"}')

    if [ ${#vgs[@]} -eq 0 ]; then
        echo -e "${YELLOW}No Volume Groups found${NC}"
        echo -e "${DIM}Create a Volume Group first${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Volume Groups ────────────────────────────────────┐${NC}"
    local i=1
    for vg in "${vgs[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$vg"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter VG number (0 to cancel): " vg_num

    if [ -z "$vg_num" ] || [ "$vg_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$vg_num" =~ ^[0-9]+$ ]] || [ "$vg_num" -lt 1 ] || [ "$vg_num" -gt ${#vgs[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local vg_name=$(echo "${vgs[$((vg_num-1))]}" | awk '{print $1}')

    echo ""
    read -p "Enter Logical Volume name: " lv_name

    if [ -z "$lv_name" ]; then
        echo -e "${RED}LV name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    read -p "Enter size (e.g., 10G, 500M, or 100%FREE): " lv_size

    if [ -z "$lv_size" ]; then
        echo -e "${RED}Size cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Creating Logical Volume:${NC}"
    echo -e "  ${WHITE}Name:${NC} ${BRIGHT_YELLOW}$lv_name${NC}"
    echo -e "  ${WHITE}Size:${NC} ${BRIGHT_CYAN}$lv_size${NC}"
    echo -e "  ${WHITE}Volume Group:${NC} ${BRIGHT_GREEN}$vg_name${NC}"
    echo ""
    read -p "Continue? (y/n): " -n 1 confirm
    echo ""

    if [[ $confirm =~ ^[Yy]$ ]]; then
        echo ""
        if [[ "$lv_size" =~ %FREE ]]; then
            sudo lvcreate -l "$lv_size" -n "$lv_name" "$vg_name"
        else
            sudo lvcreate -L "$lv_size" -n "$lv_name" "$vg_name"
        fi

        if [ $? -eq 0 ]; then
            echo -e "${BRIGHT_GREEN}✓ Logical Volume created: /dev/$vg_name/$lv_name${NC}"
        else
            echo -e "${BRIGHT_RED}✗ Failed to create Logical Volume${NC}"
        fi
    else
        echo -e "${YELLOW}Cancelled${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

extend_lv_wizard() {
    clear
    echo -e "${BRIGHT_CYAN}${BOLD}EXTEND LOGICAL VOLUME${NC}"
    echo ""

    # List LVs
    mapfile -t lvs < <(sudo lvs --noheadings -o lv_name,vg_name,lv_size 2>/dev/null | awk '{print $2 "/" $1 " (" $3 ")"}')

    if [ ${#lvs[@]} -eq 0 ]; then
        echo -e "${YELLOW}No Logical Volumes found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}Logical Volumes:${NC}"
    local i=1
    for lv in "${lvs[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$lv"
        ((i++))
    done
    echo ""

    read -p "Enter LV number (0 to cancel): " lv_num

    if [ -z "$lv_num" ] || [ "$lv_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$lv_num" =~ ^[0-9]+$ ]] || [ "$lv_num" -lt 1 ] || [ "$lv_num" -gt ${#lvs[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local lv_path="/dev/$(echo "${lvs[$((lv_num-1))]}" | awk '{print $1}')"

    echo ""
    read -p "Enter additional size (e.g., +5G, +500M): " extend_size

    echo ""
    sudo lvextend -L "$extend_size" "$lv_path"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Logical Volume extended${NC}"
        echo ""
        read -p "Resize filesystem? (y/n): " -n 1 resize_fs
        echo ""

        if [[ $resize_fs =~ ^[Yy]$ ]]; then
            sudo resize2fs "$lv_path" 2>/dev/null || sudo xfs_growfs "$lv_path" 2>/dev/null
            echo -e "${BRIGHT_GREEN}✓ Filesystem resized${NC}"
        fi
    else
        echo -e "${BRIGHT_RED}✗ Failed to extend LV${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

remove_lvm_component() {
    clear
    echo -e "${BRIGHT_CYAN}${BOLD}REMOVE LVM COMPONENT${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}What to remove?${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Logical Volume"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Volume Group"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Physical Volume"
    echo -e "  ${BRIGHT_RED}[0]${NC} Cancel"
    echo ""
    read -p "Choose: " -n 1 remove_type
    echo ""
    echo ""

    case $remove_type in
        1)
            mapfile -t lvs < <(sudo lvs --noheadings -o lv_path 2>/dev/null)
            if [ ${#lvs[@]} -eq 0 ]; then
                echo -e "${YELLOW}No LVs found${NC}"
            else
                local i=1
                for lv in "${lvs[@]}"; do
                    printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$lv"
                    ((i++))
                done
                echo ""
                read -p "Enter LV number: " lv_num
                if [[ "$lv_num" =~ ^[0-9]+$ ]] && [ "$lv_num" -ge 1 ] && [ "$lv_num" -le ${#lvs[@]} ]; then
                    local lv_path="${lvs[$((lv_num-1))]}"
                    echo ""
                    echo -e "${BRIGHT_RED}⚠  Removing: $lv_path${NC}"
                    read -p "Type 'yes' to confirm: " confirm
                    if [ "$confirm" = "yes" ]; then
                        sudo lvremove -f "$lv_path"
                        [ $? -eq 0 ] && echo -e "${BRIGHT_GREEN}✓ Removed${NC}" || echo -e "${BRIGHT_RED}✗ Failed${NC}"
                    fi
                fi
            fi
            ;;
        2)
            mapfile -t vgs < <(sudo vgs --noheadings -o vg_name 2>/dev/null)
            if [ ${#vgs[@]} -eq 0 ]; then
                echo -e "${YELLOW}No VGs found${NC}"
            else
                local i=1
                for vg in "${vgs[@]}"; do
                    printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$vg"
                    ((i++))
                done
                echo ""
                read -p "Enter VG number: " vg_num
                if [[ "$vg_num" =~ ^[0-9]+$ ]] && [ "$vg_num" -ge 1 ] && [ "$vg_num" -le ${#vgs[@]} ]; then
                    local vg_name="${vgs[$((vg_num-1))]}"
                    echo ""
                    echo -e "${BRIGHT_RED}⚠  Removing: $vg_name${NC}"
                    read -p "Type 'yes' to confirm: " confirm
                    if [ "$confirm" = "yes" ]; then
                        sudo vgremove -f "$vg_name"
                        [ $? -eq 0 ] && echo -e "${BRIGHT_GREEN}✓ Removed${NC}" || echo -e "${BRIGHT_RED}✗ Failed${NC}"
                    fi
                fi
            fi
            ;;
        3)
            mapfile -t pvs < <(sudo pvs --noheadings -o pv_name 2>/dev/null)
            if [ ${#pvs[@]} -eq 0 ]; then
                echo -e "${YELLOW}No PVs found${NC}"
            else
                local i=1
                for pv in "${pvs[@]}"; do
                    printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$pv"
                    ((i++))
                done
                echo ""
                read -p "Enter PV number: " pv_num
                if [[ "$pv_num" =~ ^[0-9]+$ ]] && [ "$pv_num" -ge 1 ] && [ "$pv_num" -le ${#pvs[@]} ]; then
                    local pv_path="${pvs[$((pv_num-1))]}"
                    echo ""
                    echo -e "${BRIGHT_RED}⚠  Removing: $pv_path${NC}"
                    read -p "Type 'yes' to confirm: " confirm
                    if [ "$confirm" = "yes" ]; then
                        sudo pvremove -f "$pv_path"
                        [ $? -eq 0 ] && echo -e "${BRIGHT_GREEN}✓ Removed${NC}" || echo -e "${BRIGHT_RED}✗ Failed${NC}"
                    fi
                fi
            fi
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

# ZFS Management
manage_zfs() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}💿 ${WHITE}${BOLD}ZFS MANAGEMENT${NC}                                            ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Check if ZFS is installed
    if ! command -v zfs &> /dev/null; then
        echo -e "${YELLOW}ZFS tools not installed.${NC}"
        echo ""
        read -p "Would you like to install ZFS? (y/n): " -n 1 install_choice
        echo ""

        if [[ $install_choice =~ ^[Yy]$ ]]; then
            PKG_MGR=$(detect_package_manager)
            case $PKG_MGR in
                apt)
                    sudo apt install -y zfsutils-linux
                    sudo modprobe zfs
                    ;;
                dnf|yum)
                    echo -e "${YELLOW}Please install ZFS from https://openzfs.github.io/openzfs-docs/Getting%20Started/RHEL-based%20distro/index.html${NC}"
                    read -p "Press Enter..."
                    return
                    ;;
                *) echo -e "${RED}Could not install ZFS${NC}"; read -p "Press Enter..."; return ;;
            esac
        else
            read -p "Press Enter to continue..."
            return
        fi
    fi

    echo -e "${BRIGHT_CYAN}ZFS Operations:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} View ZFS Pools ${DIM}(status and properties)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Create ZFS Pool ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Create Dataset ${DIM}(filesystem)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} Create Snapshot ${DIM}(point-in-time copy)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} List Snapshots"
    echo -e "  ${BRIGHT_GREEN}[6]${NC} Rollback to Snapshot"
    echo -e "  ${BRIGHT_GREEN}[7]${NC} Destroy Pool/Dataset/Snapshot"
    echo -e "  ${BRIGHT_GREEN}[8]${NC} Import/Export Pool"
    echo -e "  ${BRIGHT_RED}[0]${NC} Back"
    echo ""
    echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
    echo -e "Press a number key: "

    read -n 1 -s choice
    echo ""

    case $choice in
        1) view_zfs_pools ;;
        2) create_zpool_wizard ;;
        3) create_dataset_wizard ;;
        4) create_snapshot_wizard ;;
        5) list_snapshots ;;
        6) rollback_snapshot_wizard ;;
        7) destroy_zfs_wizard ;;
        8) import_export_pool ;;
        0) return ;;
    esac

    manage_zfs
}

# View ZFS Pools
view_zfs_pools() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📊 ${WHITE}${BOLD}ZFS POOL STATUS${NC}                                           ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    if ! sudo zpool list &>/dev/null; then
        echo -e "${YELLOW}No ZFS pools found${NC}"
    else
        echo -e "${BRIGHT_YELLOW}┌─ ZFS Pools ──────────────────────────────────────────────────┐${NC}"
        sudo zpool list
        echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
        echo ""

        echo -e "${BRIGHT_YELLOW}┌─ ZFS Datasets ───────────────────────────────────────────────┐${NC}"
        sudo zfs list
        echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Create ZFS Pool Wizard
create_zpool_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}CREATE ZFS POOL - Wizard${NC}                                 ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Auto-detect available disks
    echo -e "${BRIGHT_CYAN}Auto-detecting available disks...${NC}"
    echo ""

    mapfile -t disks < <(lsblk -dpno NAME,SIZE,TYPE | grep disk | awk '{print $1 " (" $2 ")"}')

    if [ ${#disks[@]} -eq 0 ]; then
        echo -e "${RED}No available disks found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Disks ────────────────────────────────────────────┐${NC}"
    local i=1
    for disk in "${disks[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$disk"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    # Select pool type
    echo -e "${BRIGHT_BLUE}Select ZFS Pool Type:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Single Disk ${DIM}(no redundancy)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Mirror ${DIM}(2+ disks, full redundancy)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} RAIDZ1 ${DIM}(3+ disks, 1 parity disk)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} RAIDZ2 ${DIM}(4+ disks, 2 parity disks)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} RAIDZ3 ${DIM}(5+ disks, 3 parity disks)${NC}"
    echo ""
    read -p "Enter pool type (0 to cancel): " pool_type

    local vdev_type=""
    local min_disks=1
    case $pool_type in
        1) vdev_type=""; min_disks=1 ;;
        2) vdev_type="mirror"; min_disks=2 ;;
        3) vdev_type="raidz"; min_disks=3 ;;
        4) vdev_type="raidz2"; min_disks=4 ;;
        5) vdev_type="raidz3"; min_disks=5 ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}"; read -p "Press Enter..."; return ;;
    esac

    # Select disks
    echo ""
    echo -e "${BRIGHT_CYAN}Select disks for the pool (minimum $min_disks)${NC}"
    echo -e "${DIM}Enter disk numbers separated by spaces (e.g., 1 2 3):${NC}"
    read -p "> " disk_nums

    local selected_disks=()
    for num in $disk_nums; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#disks[@]} ]; then
            local disk_path=$(echo "${disks[$((num-1))]}" | awk '{print $1}')
            selected_disks+=("$disk_path")
        fi
    done

    if [ ${#selected_disks[@]} -lt $min_disks ]; then
        echo -e "${RED}Need at least $min_disks disks for this pool type${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Pool name
    echo ""
    read -p "Enter pool name: " pool_name

    if [ -z "$pool_name" ]; then
        echo -e "${RED}Pool name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Confirm
    echo ""
    echo -e "${BRIGHT_YELLOW}┌─ Configuration ──────────────────────────────────────────────┐${NC}"
    echo -e "  Pool name: ${BRIGHT_CYAN}$pool_name${NC}"
    echo -e "  Type: ${BRIGHT_CYAN}${vdev_type:-single}${NC}"
    echo -e "  Disks: ${BRIGHT_CYAN}${selected_disks[*]}${NC}"
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: This will destroy all data on selected disks!${NC}"
    read -p "Type 'yes' to confirm: " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create pool
    echo ""
    echo -e "${BRIGHT_CYAN}Creating ZFS pool...${NC}"

    if [ -n "$vdev_type" ]; then
        sudo zpool create "$pool_name" $vdev_type "${selected_disks[@]}"
    else
        sudo zpool create "$pool_name" "${selected_disks[@]}"
    fi

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ ZFS pool '$pool_name' created successfully${NC}"
        sudo zpool status "$pool_name"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create pool${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Create Dataset Wizard
create_dataset_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}📁 ${WHITE}${BOLD}CREATE ZFS DATASET${NC}                                        ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List available pools
    mapfile -t pools < <(sudo zpool list -H -o name 2>/dev/null)

    if [ ${#pools[@]} -eq 0 ]; then
        echo -e "${YELLOW}No ZFS pools found. Create a pool first.${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Pools ────────────────────────────────────────────┐${NC}"
    local i=1
    for pool in "${pools[@]}"; do
        local size=$(sudo zpool list -H -o size "$pool")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-20s ${DIM}Size:${NC} ${BRIGHT_CYAN}%s${NC}\n" "$i" "$pool" "$size"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter pool number (0 to cancel): " pool_num

    if [ -z "$pool_num" ] || [ "$pool_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$pool_num" =~ ^[0-9]+$ ]] || [ "$pool_num" -lt 1 ] || [ "$pool_num" -gt ${#pools[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local pool_name="${pools[$((pool_num-1))]}"

    # Dataset name
    echo ""
    read -p "Enter dataset name (e.g., data): " dataset_name

    if [ -z "$dataset_name" ]; then
        echo -e "${RED}Dataset name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Optional: Set quota
    echo ""
    read -p "Set quota? (e.g., 100G, or press Enter to skip): " quota

    # Create dataset
    echo ""
    echo -e "${BRIGHT_CYAN}Creating dataset...${NC}"

    sudo zfs create "$pool_name/$dataset_name"

    if [ $? -eq 0 ]; then
        if [ -n "$quota" ]; then
            sudo zfs set quota="$quota" "$pool_name/$dataset_name"
        fi
        echo -e "${BRIGHT_GREEN}✓ Dataset '$pool_name/$dataset_name' created successfully${NC}"
        sudo zfs list "$pool_name/$dataset_name"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create dataset${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Create Snapshot Wizard
create_snapshot_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}📸 ${WHITE}${BOLD}CREATE ZFS SNAPSHOT${NC}                                       ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List datasets
    mapfile -t datasets < <(sudo zfs list -H -o name 2>/dev/null)

    if [ ${#datasets[@]} -eq 0 ]; then
        echo -e "${YELLOW}No ZFS datasets found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Datasets ─────────────────────────────────────────┐${NC}"
    local i=1
    for dataset in "${datasets[@]}"; do
        local used=$(sudo zfs list -H -o used "$dataset")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-30s ${DIM}Used:${NC} ${BRIGHT_CYAN}%s${NC}\n" "$i" "$dataset" "$used"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter dataset number (0 to cancel): " dataset_num

    if [ -z "$dataset_num" ] || [ "$dataset_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$dataset_num" =~ ^[0-9]+$ ]] || [ "$dataset_num" -lt 1 ] || [ "$dataset_num" -gt ${#datasets[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local dataset_name="${datasets[$((dataset_num-1))]}"

    # Snapshot name
    echo ""
    read -p "Enter snapshot name (e.g., backup-$(date +%Y%m%d)): " snap_name

    if [ -z "$snap_name" ]; then
        echo -e "${RED}Snapshot name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create snapshot
    echo ""
    echo -e "${BRIGHT_CYAN}Creating snapshot...${NC}"

    sudo zfs snapshot "$dataset_name@$snap_name"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Snapshot '$dataset_name@$snap_name' created successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create snapshot${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# List Snapshots
list_snapshots() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📸 ${WHITE}${BOLD}ZFS SNAPSHOTS${NC}                                             ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    if ! sudo zfs list -t snapshot &>/dev/null; then
        echo -e "${YELLOW}No snapshots found${NC}"
    else
        echo -e "${BRIGHT_YELLOW}┌─ Snapshots ──────────────────────────────────────────────────┐${NC}"
        sudo zfs list -t snapshot
        echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Rollback to Snapshot Wizard
rollback_snapshot_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}⏮ ${WHITE}${BOLD}ROLLBACK TO SNAPSHOT${NC}                                      ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List snapshots
    mapfile -t snapshots < <(sudo zfs list -H -t snapshot -o name 2>/dev/null)

    if [ ${#snapshots[@]} -eq 0 ]; then
        echo -e "${YELLOW}No snapshots found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Snapshots ────────────────────────────────────────┐${NC}"
    local i=1
    for snapshot in "${snapshots[@]}"; do
        local created=$(sudo zfs list -H -t snapshot -o creation "$snapshot")
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-40s ${DIM}%s${NC}\n" "$i" "$snapshot" "$created"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter snapshot number (0 to cancel): " snap_num

    if [ -z "$snap_num" ] || [ "$snap_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$snap_num" =~ ^[0-9]+$ ]] || [ "$snap_num" -lt 1 ] || [ "$snap_num" -gt ${#snapshots[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local snapshot_name="${snapshots[$((snap_num-1))]}"

    # Confirm
    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: This will discard all changes since this snapshot!${NC}"
    read -p "Type 'yes' to confirm rollback: " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Rollback
    echo ""
    echo -e "${BRIGHT_CYAN}Rolling back to snapshot...${NC}"

    sudo zfs rollback -r "$snapshot_name"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Rolled back to '$snapshot_name' successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to rollback${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Destroy ZFS Wizard
destroy_zfs_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_RED}🗑 ${WHITE}${BOLD}DESTROY ZFS COMPONENT${NC}                                      ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}What would you like to destroy?${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Snapshot"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Dataset"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Pool"
    echo -e "  ${BRIGHT_RED}[0]${NC} Cancel"
    echo ""
    read -p "Select type: " destroy_type

    case $destroy_type in
        1)
            # Destroy snapshot
            mapfile -t items < <(sudo zfs list -H -t snapshot -o name 2>/dev/null)
            local item_type="snapshot"
            ;;
        2)
            # Destroy dataset
            mapfile -t items < <(sudo zfs list -H -o name 2>/dev/null)
            local item_type="dataset"
            ;;
        3)
            # Destroy pool
            mapfile -t items < <(sudo zpool list -H -o name 2>/dev/null)
            local item_type="pool"
            ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}"; read -p "Press Enter..."; return ;;
    esac

    if [ ${#items[@]} -eq 0 ]; then
        echo -e "${YELLOW}No ${item_type}s found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_YELLOW}┌─ Available ${item_type^}s ─────────────────────────────────────────┐${NC}"
    local i=1
    for item in "${items[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$item"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter ${item_type} number (0 to cancel): " item_num

    if [ -z "$item_num" ] || [ "$item_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$item_num" =~ ^[0-9]+$ ]] || [ "$item_num" -lt 1 ] || [ "$item_num" -gt ${#items[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local item_name="${items[$((item_num-1))]}"

    # Confirm
    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: This action cannot be undone!${NC}"
    echo -e "Destroying: ${BRIGHT_CYAN}$item_name${NC}"
    read -p "Type 'yes' to confirm: " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Destroy
    echo ""
    echo -e "${BRIGHT_CYAN}Destroying ${item_type}...${NC}"

    case $destroy_type in
        3)
            sudo zpool destroy "$item_name"
            ;;
        *)
            sudo zfs destroy -r "$item_name"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Destroyed successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to destroy${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Import/Export Pool
import_export_pool() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}🔄 ${WHITE}${BOLD}IMPORT/EXPORT ZFS POOL${NC}                                    ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Select operation:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Import Pool"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Export Pool"
    echo -e "  ${BRIGHT_RED}[0]${NC} Cancel"
    echo ""
    read -p "Select: " operation

    case $operation in
        1)
            # Import pool
            echo ""
            echo -e "${BRIGHT_CYAN}Scanning for importable pools...${NC}"
            sudo zpool import
            echo ""
            read -p "Enter pool name to import (or 0 to cancel): " pool_name

            if [ "$pool_name" != "0" ] && [ -n "$pool_name" ]; then
                sudo zpool import "$pool_name"
                [ $? -eq 0 ] && echo -e "${BRIGHT_GREEN}✓ Pool imported${NC}" || echo -e "${BRIGHT_RED}✗ Failed${NC}"
            fi
            ;;
        2)
            # Export pool
            mapfile -t pools < <(sudo zpool list -H -o name 2>/dev/null)

            if [ ${#pools[@]} -eq 0 ]; then
                echo -e "${YELLOW}No pools to export${NC}"
                read -p "Press Enter..."; return
            fi

            echo ""
            echo -e "${BRIGHT_YELLOW}┌─ Active Pools ───────────────────────────────────────────────┐${NC}"
            local i=1
            for pool in "${pools[@]}"; do
                printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$pool"
                ((i++))
            done
            echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
            echo ""

            read -p "Enter pool number (0 to cancel): " pool_num

            if [ "$pool_num" -gt 0 ] 2>/dev/null && [ "$pool_num" -le ${#pools[@]} ]; then
                local pool_name="${pools[$((pool_num-1))]}"
                echo ""
                read -p "Export pool '$pool_name'? (y/n): " -n 1 confirm
                echo ""

                if [[ $confirm =~ ^[Yy]$ ]]; then
                    sudo zpool export "$pool_name"
                    [ $? -eq 0 ] && echo -e "${BRIGHT_GREEN}✓ Pool exported${NC}" || echo -e "${BRIGHT_RED}✗ Failed${NC}"
                fi
            fi
            ;;
        0) return ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

# Disk Partitioning
manage_partitioning() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}🔧 ${WHITE}${BOLD}DISK PARTITIONING${NC}                                         ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Partitioning Operations:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} List Disks & Partitions ${DIM}(lsblk)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Partition Disk ${DIM}(fdisk - wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Partition Disk ${DIM}(parted - wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} View Partition Details ${DIM}(detailed info)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} Delete Partition ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_RED}[0]${NC} Back"
    echo ""
    echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
    echo -e "Press a number key: "

    read -n 1 -s choice
    echo ""

    case $choice in
        1) list_disks_partitions ;;
        2) partition_fdisk_wizard ;;
        3) partition_parted_wizard ;;
        4) view_partition_details ;;
        5) delete_partition_wizard ;;
        0) return ;;
    esac

    manage_partitioning
}

# List Disks & Partitions
list_disks_partitions() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}💿 ${WHITE}${BOLD}DISKS & PARTITIONS${NC}                                        ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ Block Devices ──────────────────────────────────────────────┐${NC}"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,MODEL
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    read -p "Press Enter to continue..."
}

# Partition Disk with fdisk Wizard
partition_fdisk_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}PARTITION DISK (fdisk)${NC}                                    ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List available disks
    mapfile -t disks < <(lsblk -dpno NAME,SIZE,TYPE | grep disk | awk '{print $1 " (" $2 ")"}')

    if [ ${#disks[@]} -eq 0 ]; then
        echo -e "${RED}No disks found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Disks ────────────────────────────────────────────┐${NC}"
    local i=1
    for disk in "${disks[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$disk"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter disk number (0 to cancel): " disk_num

    if [ -z "$disk_num" ] || [ "$disk_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$disk_num" =~ ^[0-9]+$ ]] || [ "$disk_num" -lt 1 ] || [ "$disk_num" -gt ${#disks[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local disk_path=$(echo "${disks[$((disk_num-1))]}" | awk '{print $1}')

    # Show current partition table
    echo ""
    echo -e "${BRIGHT_CYAN}Current partition table for $disk_path:${NC}"
    sudo fdisk -l "$disk_path"

    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: Incorrect partitioning can result in data loss!${NC}"
    read -p "Continue with fdisk on $disk_path? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Launch fdisk interactively
    echo ""
    echo -e "${BRIGHT_CYAN}Launching fdisk...${NC}"
    echo -e "${DIM}Common commands: p(print), n(new), d(delete), t(type), w(write), q(quit)${NC}"
    echo ""
    sleep 2

    sudo fdisk "$disk_path"

    echo ""
    echo -e "${BRIGHT_GREEN}✓ fdisk session completed${NC}"
    read -p "Press Enter to continue..."
}

# Partition Disk with parted Wizard
partition_parted_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}PARTITION DISK (parted)${NC}                                   ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Check if parted is installed
    if ! command -v parted &> /dev/null; then
        echo -e "${YELLOW}parted not installed.${NC}"
        echo ""
        read -p "Would you like to install parted? (y/n): " -n 1 install_choice
        echo ""

        if [[ $install_choice =~ ^[Yy]$ ]]; then
            PKG_MGR=$(detect_package_manager)
            case $PKG_MGR in
                apt) sudo apt install -y parted ;;
                dnf) sudo dnf install -y parted ;;
                yum) sudo yum install -y parted ;;
                *) echo -e "${RED}Could not install parted${NC}"; read -p "Press Enter..."; return ;;
            esac
        else
            read -p "Press Enter to continue..."
            return
        fi
    fi

    # List available disks
    mapfile -t disks < <(lsblk -dpno NAME,SIZE,TYPE | grep disk | awk '{print $1 " (" $2 ")"}')

    if [ ${#disks[@]} -eq 0 ]; then
        echo -e "${RED}No disks found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Disks ────────────────────────────────────────────┐${NC}"
    local i=1
    for disk in "${disks[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$disk"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter disk number (0 to cancel): " disk_num

    if [ -z "$disk_num" ] || [ "$disk_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$disk_num" =~ ^[0-9]+$ ]] || [ "$disk_num" -lt 1 ] || [ "$disk_num" -gt ${#disks[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local disk_path=$(echo "${disks[$((disk_num-1))]}" | awk '{print $1}')

    # Show current partition table
    echo ""
    echo -e "${BRIGHT_CYAN}Current partition table for $disk_path:${NC}"
    sudo parted "$disk_path" print

    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: Incorrect partitioning can result in data loss!${NC}"
    read -p "Continue with parted on $disk_path? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Launch parted interactively
    echo ""
    echo -e "${BRIGHT_CYAN}Launching parted...${NC}"
    echo -e "${DIM}Common commands: print, mklabel, mkpart, rm, quit${NC}"
    echo ""
    sleep 2

    sudo parted "$disk_path"

    echo ""
    echo -e "${BRIGHT_GREEN}✓ parted session completed${NC}"
    read -p "Press Enter to continue..."
}

# View Partition Details
view_partition_details() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📊 ${WHITE}${BOLD}PARTITION DETAILS${NC}                                         ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List all partitions
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,TYPE | grep part | awk '{print $1 " (" $2 ")"}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${YELLOW}No partitions found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number to view details (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_path=$(echo "${partitions[$((part_num-1))]}" | awk '{print $1}')

    echo ""
    echo -e "${BRIGHT_CYAN}Detailed information for $partition_path:${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}Block device info:${NC}"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,UUID,LABEL "$partition_path"

    echo ""
    echo -e "${BRIGHT_YELLOW}Filesystem info:${NC}"
    sudo blkid "$partition_path"

    if command -v parted &> /dev/null; then
        echo ""
        echo -e "${BRIGHT_YELLOW}Partition table info:${NC}"
        local disk_path=$(echo "$partition_path" | sed 's/[0-9]*$//')
        sudo parted "$disk_path" print | grep -A 1 "Number"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Delete Partition Wizard
delete_partition_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_RED}🗑 ${WHITE}${BOLD}DELETE PARTITION${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List all partitions
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT | grep part)

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${YELLOW}No partitions found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        local part_name=$(echo "$partition" | awk '{print $1}')
        local part_size=$(echo "$partition" | awk '{print $2}')
        local part_fs=$(echo "$partition" | awk '{print $4}')
        local part_mount=$(echo "$partition" | awk '{print $5}')
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-15s ${DIM}Size:${NC}%-8s ${DIM}FS:${NC}%-8s ${DIM}Mount:${NC}%s\n" "$i" "$part_name" "$part_size" "${part_fs:--}" "${part_mount:--}"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_info="${partitions[$((part_num-1))]}"
    local partition_path=$(echo "$partition_info" | awk '{print $1}')
    local partition_mount=$(echo "$partition_info" | awk '{print $5}')

    # Check if mounted
    if [ -n "$partition_mount" ] && [ "$partition_mount" != "-" ]; then
        echo ""
        echo -e "${BRIGHT_RED}⚠  Partition is currently mounted at: $partition_mount${NC}"
        read -p "Unmount first? (y/n): " -n 1 unmount_choice
        echo ""

        if [[ $unmount_choice =~ ^[Yy]$ ]]; then
            sudo umount "$partition_path"
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to unmount partition${NC}"
                read -p "Press Enter to continue..."
                return
            fi
            echo -e "${BRIGHT_GREEN}✓ Unmounted${NC}"
        else
            echo -e "${YELLOW}Cancelled - partition is still mounted${NC}"
            read -p "Press Enter to continue..."
            return
        fi
    fi

    # Confirm deletion
    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: This will permanently delete the partition and all data on it!${NC}"
    echo -e "Partition: ${BRIGHT_CYAN}$partition_path${NC}"
    read -p "Type 'yes' to confirm deletion: " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Get partition number and disk
    local part_number=$(echo "$partition_path" | grep -o '[0-9]*$')
    local disk_path=$(echo "$partition_path" | sed 's/[0-9]*$//')

    # Delete using parted
    echo ""
    echo -e "${BRIGHT_CYAN}Deleting partition...${NC}"

    if command -v parted &> /dev/null; then
        sudo parted "$disk_path" rm "$part_number"
        if [ $? -eq 0 ]; then
            echo -e "${BRIGHT_GREEN}✓ Partition deleted successfully${NC}"
            sudo partprobe "$disk_path" 2>/dev/null
        else
            echo -e "${BRIGHT_RED}✗ Failed to delete partition${NC}"
        fi
    else
        echo -e "${YELLOW}parted not found. Use fdisk manually to delete partition.${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Filesystem Operations
manage_filesystems() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}📁 ${WHITE}${BOLD}FILESYSTEM OPERATIONS${NC}                                     ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Filesystem Operations:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Create Filesystem ${DIM}(mkfs - wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Check/Repair Filesystem ${DIM}(fsck)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Resize Filesystem ${DIM}(resize2fs/xfs_growfs)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} View Filesystem Info ${DIM}(detailed)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} Set Filesystem Label"
    echo -e "  ${BRIGHT_GREEN}[6]${NC} Tune Filesystem ${DIM}(tune2fs)${NC}"
    echo -e "  ${BRIGHT_RED}[0]${NC} Back"
    echo ""
    echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
    echo -e "Press a number key: "

    read -n 1 -s choice
    echo ""

    case $choice in
        1) create_filesystem_wizard ;;
        2) check_repair_filesystem ;;
        3) resize_filesystem_wizard ;;
        4) view_filesystem_info ;;
        5) set_filesystem_label ;;
        6) tune_filesystem ;;
        0) return ;;
    esac

    manage_filesystems
}

# Create Filesystem Wizard
create_filesystem_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔧 ${WHITE}${BOLD}CREATE FILESYSTEM${NC}                                         ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List partitions without filesystems or all partitions
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,TYPE,FSTYPE | grep -E 'part|lvm' | awk '{print $1 " (" $2 ") [" ($4 ? $4 : "none") "]"}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No partitions found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_path=$(echo "${partitions[$((part_num-1))]}" | awk '{print $1}')

    # Select filesystem type
    echo ""
    echo -e "${BRIGHT_BLUE}Select Filesystem Type:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} ext4 ${DIM}(default Linux filesystem)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} ext3 ${DIM}(legacy Linux)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} xfs ${DIM}(high performance)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} btrfs ${DIM}(advanced features)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} vfat/FAT32 ${DIM}(USB/compatibility)${NC}"
    echo -e "  ${BRIGHT_GREEN}[6]${NC} ntfs ${DIM}(Windows compatibility)${NC}"
    echo ""
    read -p "Enter filesystem type (0 to cancel): " fs_type

    local mkfs_cmd=""
    case $fs_type in
        1) mkfs_cmd="mkfs.ext4" ;;
        2) mkfs_cmd="mkfs.ext3" ;;
        3) mkfs_cmd="mkfs.xfs" ;;
        4) mkfs_cmd="mkfs.btrfs" ;;
        5) mkfs_cmd="mkfs.vfat" ;;
        6) mkfs_cmd="mkfs.ntfs" ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}"; read -p "Press Enter..."; return ;;
    esac

    # Check if tool is available
    if ! command -v "$mkfs_cmd" &> /dev/null; then
        echo -e "${YELLOW}$mkfs_cmd not installed.${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Optional label
    echo ""
    read -p "Enter filesystem label (or press Enter to skip): " fs_label

    # Confirm
    echo ""
    echo -e "${BRIGHT_RED}⚠  WARNING: This will destroy all data on $partition_path!${NC}"
    echo -e "Filesystem: ${BRIGHT_CYAN}$mkfs_cmd${NC}"
    if [ -n "$fs_label" ]; then
        echo -e "Label: ${BRIGHT_CYAN}$fs_label${NC}"
    fi
    read -p "Type 'yes' to confirm: " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create filesystem
    echo ""
    echo -e "${BRIGHT_CYAN}Creating filesystem...${NC}"

    if [ -n "$fs_label" ]; then
        sudo "$mkfs_cmd" -L "$fs_label" "$partition_path"
    else
        sudo "$mkfs_cmd" "$partition_path"
    fi

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Filesystem created successfully${NC}"
        sudo blkid "$partition_path"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create filesystem${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Check/Repair Filesystem
check_repair_filesystem() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}🔍 ${WHITE}${BOLD}CHECK/REPAIR FILESYSTEM${NC}                                   ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List partitions with filesystems
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT | grep -E 'part|lvm' | grep -v 'swap')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No partitions found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        local part_name=$(echo "$partition" | awk '{print $1}')
        local part_size=$(echo "$partition" | awk '{print $2}')
        local part_fs=$(echo "$partition" | awk '{print $4}')
        local part_mount=$(echo "$partition" | awk '{print $5}')
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-15s ${DIM}Size:${NC}%-8s ${DIM}FS:${NC}%-8s ${DIM}Mount:${NC}%s\n" "$i" "$part_name" "$part_size" "${part_fs:--}" "${part_mount:--}"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_info="${partitions[$((part_num-1))]}"
    local partition_path=$(echo "$partition_info" | awk '{print $1}')
    local partition_mount=$(echo "$partition_info" | awk '{print $5}')

    # Check if mounted
    if [ -n "$partition_mount" ] && [ "$partition_mount" != "-" ]; then
        echo ""
        echo -e "${BRIGHT_RED}⚠  Partition must be unmounted for fsck${NC}"
        echo -e "Currently mounted at: $partition_mount"
        read -p "Unmount now? (y/n): " -n 1 unmount_choice
        echo ""

        if [[ $unmount_choice =~ ^[Yy]$ ]]; then
            sudo umount "$partition_path"
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to unmount partition${NC}"
                read -p "Press Enter to continue..."
                return
            fi
            echo -e "${BRIGHT_GREEN}✓ Unmounted${NC}"
        else
            echo -e "${YELLOW}Cancelled${NC}"
            read -p "Press Enter to continue..."
            return
        fi
    fi

    # Run fsck
    echo ""
    echo -e "${BRIGHT_CYAN}Running filesystem check...${NC}"
    echo -e "${DIM}(This may take a while depending on filesystem size)${NC}"
    echo ""

    sudo fsck -f "$partition_path"

    echo ""
    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Filesystem check completed${NC}"
    else
        echo -e "${BRIGHT_YELLOW}⚠  Filesystem check completed with warnings/repairs${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Resize Filesystem Wizard
resize_filesystem_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}📏 ${WHITE}${BOLD}RESIZE FILESYSTEM${NC}                                         ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List partitions with filesystems
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,TYPE,FSTYPE | grep -E 'part|lvm' | awk '{if ($4 != "" && $4 != "swap") print $1 " (" $2 ") [" $4 "]"}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No partitions with filesystems found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_info="${partitions[$((part_num-1))]}"
    local partition_path=$(echo "$partition_info" | awk '{print $1}')
    local fs_type=$(lsblk -no FSTYPE "$partition_path")

    echo ""
    echo -e "${BRIGHT_CYAN}Partition: ${WHITE}$partition_path${NC}"
    echo -e "${BRIGHT_CYAN}Filesystem: ${WHITE}$fs_type${NC}"
    echo ""

    case $fs_type in
        ext[234])
            echo -e "${BRIGHT_YELLOW}Note: For ext filesystems, resize to match partition size automatically${NC}"
            read -p "Continue? (y/n): " -n 1 confirm
            echo ""

            if ! [[ $confirm =~ ^[Yy]$ ]]; then
                return
            fi

            echo ""
            echo -e "${BRIGHT_CYAN}Resizing filesystem...${NC}"
            sudo resize2fs "$partition_path"
            ;;
        xfs)
            local mount_point=$(lsblk -no MOUNTPOINT "$partition_path")
            if [ -z "$mount_point" ]; then
                echo -e "${YELLOW}XFS filesystems must be mounted to resize${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            read -p "Resize XFS filesystem? (y/n): " -n 1 confirm
            echo ""

            if ! [[ $confirm =~ ^[Yy]$ ]]; then
                return
            fi

            echo ""
            echo -e "${BRIGHT_CYAN}Resizing filesystem...${NC}"
            sudo xfs_growfs "$mount_point"
            ;;
        btrfs)
            local mount_point=$(lsblk -no MOUNTPOINT "$partition_path")
            if [ -z "$mount_point" ]; then
                echo -e "${YELLOW}Btrfs filesystems must be mounted to resize${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            read -p "Resize to max? (y/n): " -n 1 confirm
            echo ""

            if ! [[ $confirm =~ ^[Yy]$ ]]; then
                return
            fi

            echo ""
            echo -e "${BRIGHT_CYAN}Resizing filesystem...${NC}"
            sudo btrfs filesystem resize max "$mount_point"
            ;;
        *)
            echo -e "${YELLOW}Resize not supported for $fs_type${NC}"
            read -p "Press Enter to continue..."
            return
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Filesystem resized successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to resize filesystem${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# View Filesystem Info
view_filesystem_info() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📊 ${WHITE}${BOLD}FILESYSTEM INFORMATION${NC}                                    ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List partitions with filesystems
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,FSTYPE | grep -E 'part|lvm' | awk '{if ($3 != "" && $3 != "swap") print $1 " (" $2 ") [" $3 "]"}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No partitions with filesystems found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_path=$(echo "${partitions[$((part_num-1))]}" | awk '{print $1}')
    local fs_type=$(lsblk -no FSTYPE "$partition_path")

    echo ""
    echo -e "${BRIGHT_CYAN}Filesystem Information for $partition_path:${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}Basic Info:${NC}"
    sudo blkid "$partition_path"
    echo ""

    echo -e "${BRIGHT_YELLOW}Block Device Info:${NC}"
    lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,UUID,LABEL "$partition_path"
    echo ""

    case $fs_type in
        ext[234])
            echo -e "${BRIGHT_YELLOW}Ext Filesystem Details:${NC}"
            sudo tune2fs -l "$partition_path" | grep -E "Filesystem|Block|Inode|Created|Last"
            ;;
        xfs)
            echo -e "${BRIGHT_YELLOW}XFS Filesystem Details:${NC}"
            sudo xfs_info "$partition_path" 2>/dev/null || echo "Mount to view detailed info"
            ;;
        btrfs)
            echo -e "${BRIGHT_YELLOW}Btrfs Filesystem Details:${NC}"
            sudo btrfs filesystem show "$partition_path" 2>/dev/null || echo "Btrfs info unavailable"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

# Set Filesystem Label
set_filesystem_label() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🏷 ${WHITE}${BOLD}SET FILESYSTEM LABEL${NC}                                      ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List partitions with filesystems
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,FSTYPE,LABEL | grep -E 'part|lvm' | awk '{if ($3 != "" && $3 != "swap") print $1 " (" $2 ") [" $3 "] - Current: " ($4 ? $4 : "none")}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No partitions with filesystems found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_path=$(lsblk -pno NAME,SIZE,FSTYPE,LABEL | grep -E 'part|lvm' | sed -n "${part_num}p" | awk '{print $1}')
    local fs_type=$(lsblk -no FSTYPE "$partition_path")

    echo ""
    read -p "Enter new label: " new_label

    if [ -z "$new_label" ]; then
        echo -e "${RED}Label cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Setting label...${NC}"

    case $fs_type in
        ext[234])
            sudo e2label "$partition_path" "$new_label"
            ;;
        xfs)
            sudo xfs_admin -L "$new_label" "$partition_path"
            ;;
        vfat|fat)
            sudo fatlabel "$partition_path" "$new_label"
            ;;
        ntfs)
            sudo ntfslabel "$partition_path" "$new_label"
            ;;
        *)
            echo -e "${YELLOW}Label setting not supported for $fs_type${NC}"
            read -p "Press Enter to continue..."
            return
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Label set successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to set label${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Tune Filesystem
tune_filesystem() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}⚙ ${WHITE}${BOLD}TUNE FILESYSTEM${NC}                                           ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List ext filesystems only
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,FSTYPE | grep -E 'ext[234]' | awk '{print $1 " (" $2 ") [" $3 "]"}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No ext2/3/4 filesystems found${NC}"
        echo -e "${YELLOW}(tune2fs only works with ext filesystems)${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Ext Filesystems ──────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_path=$(echo "${partitions[$((part_num-1))]}" | awk '{print $1}')

    echo ""
    echo -e "${BRIGHT_CYAN}Tuning Options:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Set reserved blocks percentage"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Set max mount count"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Set check interval (days)"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} Disable fsck on boot"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} Enable fsck on boot"
    echo ""
    read -p "Select option (0 to cancel): " tune_option

    case $tune_option in
        1)
            read -p "Enter reserved blocks percentage (default 5): " reserved
            if [ -n "$reserved" ]; then
                sudo tune2fs -m "$reserved" "$partition_path"
            fi
            ;;
        2)
            read -p "Enter max mount count before fsck (-1 to disable): " max_count
            if [ -n "$max_count" ]; then
                sudo tune2fs -c "$max_count" "$partition_path"
            fi
            ;;
        3)
            read -p "Enter check interval in days (0 to disable): " interval
            if [ -n "$interval" ]; then
                sudo tune2fs -i "${interval}d" "$partition_path"
            fi
            ;;
        4)
            sudo tune2fs -i 0 -c 0 "$partition_path"
            echo -e "${BRIGHT_GREEN}✓ Disabled fsck on boot${NC}"
            ;;
        5)
            sudo tune2fs -i 180d -c 30 "$partition_path"
            echo -e "${BRIGHT_GREEN}✓ Enabled fsck on boot (180 days or 30 mounts)${NC}"
            ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}"; read -p "Press Enter..."; return ;;
    esac

    if [ $? -eq 0 ] && [ "$tune_option" != "4" ] && [ "$tune_option" != "5" ]; then
        echo -e "${BRIGHT_GREEN}✓ Filesystem tuned successfully${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Mount/Unmount Operations
manage_mount_operations() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_BLUE}🔌 ${WHITE}${BOLD}MOUNT/UNMOUNT OPERATIONS${NC}                                  ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Mount Operations:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} View Mounted Filesystems ${DIM}(df/mount)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Mount Filesystem ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Unmount Filesystem ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} View /etc/fstab ${DIM}(boot mounts)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} Add Entry to /etc/fstab ${DIM}(wizard)${NC}"
    echo -e "  ${BRIGHT_GREEN}[6]${NC} Remove Entry from /etc/fstab"
    echo -e "  ${BRIGHT_GREEN}[7]${NC} Edit /etc/fstab ${DIM}(manual)${NC}"
    echo -e "  ${BRIGHT_RED}[0]${NC} Back"
    echo ""
    echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
    echo -e "Press a number key: "

    read -n 1 -s choice
    echo ""

    case $choice in
        1) view_mounted_filesystems ;;
        2) mount_filesystem_wizard ;;
        3) unmount_filesystem_wizard ;;
        4) view_fstab ;;
        5) add_fstab_entry_wizard ;;
        6) remove_fstab_entry ;;
        7) edit_fstab_manual ;;
        0) return ;;
    esac

    manage_mount_operations
}

# View Mounted Filesystems
view_mounted_filesystems() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📊 ${WHITE}${BOLD}MOUNTED FILESYSTEMS${NC}                                       ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ Disk Usage ─────────────────────────────────────────────────┐${NC}"
    df -h | grep -v "tmpfs\|devtmpfs\|loop"
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    echo -e "${BRIGHT_YELLOW}┌─ Mount Details ──────────────────────────────────────────────┐${NC}"
    mount | grep -v "tmpfs\|devtmpfs\|loop" | column -t
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    read -p "Press Enter to continue..."
}

# Mount Filesystem Wizard
mount_filesystem_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}🔌 ${WHITE}${BOLD}MOUNT FILESYSTEM${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List unmounted partitions with filesystems
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,FSTYPE,MOUNTPOINT | grep -E 'part|lvm' | awk '$3 != "" && $3 != "swap" && $4 == "" {print $1 " (" $2 ") [" $3 "]"}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${YELLOW}No unmounted filesystems found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Unmounted Filesystems ──────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_path=$(echo "${partitions[$((part_num-1))]}" | awk '{print $1}')
    local fs_type=$(lsblk -no FSTYPE "$partition_path")

    # Get mount point
    echo ""
    read -p "Enter mount point (e.g., /mnt/data): " mount_point

    if [ -z "$mount_point" ]; then
        echo -e "${RED}Mount point cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create mount point if it doesn't exist
    if [ ! -d "$mount_point" ]; then
        echo ""
        read -p "Mount point doesn't exist. Create it? (y/n): " -n 1 create_mp
        echo ""

        if [[ $create_mp =~ ^[Yy]$ ]]; then
            sudo mkdir -p "$mount_point"
            if [ $? -ne 0 ]; then
                echo -e "${RED}Failed to create mount point${NC}"
                read -p "Press Enter to continue..."
                return
            fi
            echo -e "${BRIGHT_GREEN}✓ Created mount point${NC}"
        else
            echo -e "${YELLOW}Cancelled${NC}"
            read -p "Press Enter to continue..."
            return
        fi
    fi

    # Mount filesystem
    echo ""
    echo -e "${BRIGHT_CYAN}Mounting $partition_path to $mount_point...${NC}"

    sudo mount "$partition_path" "$mount_point"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Filesystem mounted successfully${NC}"
        df -h "$mount_point"
    else
        echo -e "${BRIGHT_RED}✗ Failed to mount filesystem${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Unmount Filesystem Wizard
unmount_filesystem_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_RED}🔌 ${WHITE}${BOLD}UNMOUNT FILESYSTEM${NC}                                        ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List mounted partitions (excluding system mounts)
    mapfile -t mounts < <(mount | grep -E '/dev/(sd|hd|nvme|vd|mapper)' | awk '{print $1 " on " $3 " type " $5}')

    if [ ${#mounts[@]} -eq 0 ]; then
        echo -e "${YELLOW}No user-mounted filesystems found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Mounted Filesystems ────────────────────────────────────────┐${NC}"
    local i=1
    for mount_entry in "${mounts[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$mount_entry"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter mount number (0 to cancel): " mount_num

    if [ -z "$mount_num" ] || [ "$mount_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$mount_num" =~ ^[0-9]+$ ]] || [ "$mount_num" -lt 1 ] || [ "$mount_num" -gt ${#mounts[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local mount_info="${mounts[$((mount_num-1))]}"
    local mount_point=$(echo "$mount_info" | awk '{print $3}')

    # Confirm
    echo ""
    echo -e "${BRIGHT_YELLOW}Unmount: ${BRIGHT_CYAN}$mount_point${NC}"
    read -p "Continue? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Unmount
    echo ""
    echo -e "${BRIGHT_CYAN}Unmounting...${NC}"

    sudo umount "$mount_point"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Filesystem unmounted successfully${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to unmount${NC}"
        echo -e "${YELLOW}Tip: Check if files are in use (lsof $mount_point)${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# View /etc/fstab
view_fstab() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_CYAN}📄 ${WHITE}${BOLD}/etc/fstab${NC}                                                ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_YELLOW}┌─ /etc/fstab Contents ────────────────────────────────────────┐${NC}"
    cat -n /etc/fstab
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"

    echo ""
    read -p "Press Enter to continue..."
}

# Add Entry to /etc/fstab Wizard
add_fstab_entry_wizard() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_GREEN}➕ ${WHITE}${BOLD}ADD /etc/fstab ENTRY${NC}                                      ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List all partitions with filesystems
    mapfile -t partitions < <(lsblk -pno NAME,SIZE,FSTYPE,UUID | grep -E 'part|lvm' | awk '$3 != "" && $3 != "swap" {print $1 " (" $2 ") [" $3 "] UUID=" $4}')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo -e "${RED}No partitions with filesystems found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Available Partitions ───────────────────────────────────────┐${NC}"
    local i=1
    for partition in "${partitions[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$partition"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter partition number (0 to cancel): " part_num

    if [ -z "$part_num" ] || [ "$part_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$part_num" =~ ^[0-9]+$ ]] || [ "$part_num" -lt 1 ] || [ "$part_num" -gt ${#partitions[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local partition_info="${partitions[$((part_num-1))]}"
    local partition_path=$(echo "$partition_info" | awk '{print $1}')
    local uuid=$(lsblk -no UUID "$partition_path")
    local fs_type=$(lsblk -no FSTYPE "$partition_path")

    echo ""
    echo -e "${BRIGHT_CYAN}Device: ${WHITE}$partition_path${NC}"
    echo -e "${BRIGHT_CYAN}UUID: ${WHITE}$uuid${NC}"
    echo -e "${BRIGHT_CYAN}Filesystem: ${WHITE}$fs_type${NC}"
    echo ""

    # Get mount point
    read -p "Enter mount point (e.g., /mnt/data): " mount_point

    if [ -z "$mount_point" ]; then
        echo -e "${RED}Mount point cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create mount point if needed
    if [ ! -d "$mount_point" ]; then
        sudo mkdir -p "$mount_point"
    fi

    # Get mount options
    echo ""
    echo -e "${BRIGHT_CYAN}Common mount options:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} defaults ${DIM}(rw,suid,dev,exec,auto,nouser,async)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} defaults,noatime ${DIM}(performance optimization)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} defaults,nofail ${DIM}(boot even if device missing)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} Custom"
    echo ""
    read -p "Select mount options (1-4): " opt_choice

    local mount_opts="defaults"
    case $opt_choice in
        1) mount_opts="defaults" ;;
        2) mount_opts="defaults,noatime" ;;
        3) mount_opts="defaults,nofail" ;;
        4) read -p "Enter custom options: " mount_opts ;;
        *) mount_opts="defaults" ;;
    esac

    # Get dump and pass values
    local dump=0
    local pass=2

    # Create fstab entry
    local fstab_entry="UUID=$uuid  $mount_point  $fs_type  $mount_opts  $dump  $pass"

    echo ""
    echo -e "${BRIGHT_YELLOW}┌─ fstab Entry ────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}$fstab_entry${NC}"
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_RED}⚠  WARNING: Incorrect fstab entries can prevent system boot!${NC}"
    read -p "Add this entry to /etc/fstab? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Backup fstab
    sudo cp /etc/fstab /etc/fstab.backup.$(date +%Y%m%d%H%M%S)

    # Add entry
    echo "$fstab_entry" | sudo tee -a /etc/fstab > /dev/null

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Entry added to /etc/fstab${NC}"
        echo -e "${BRIGHT_CYAN}Backup created: /etc/fstab.backup.*${NC}"

        echo ""
        read -p "Test mount now? (y/n): " -n 1 test_mount
        echo ""

        if [[ $test_mount =~ ^[Yy]$ ]]; then
            sudo mount -a
            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ All filesystems mounted successfully${NC}"
            else
                echo -e "${BRIGHT_RED}✗ Mount failed - check /etc/fstab${NC}"
            fi
        fi
    else
        echo -e "${BRIGHT_RED}✗ Failed to add entry${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Remove Entry from /etc/fstab
remove_fstab_entry() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_RED}➖ ${WHITE}${BOLD}REMOVE /etc/fstab ENTRY${NC}                                   ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Show fstab with line numbers (excluding comments and empty lines)
    mapfile -t entries < <(grep -v '^#' /etc/fstab | grep -v '^$' | nl)

    if [ ${#entries[@]} -eq 0 ]; then
        echo -e "${YELLOW}No entries in /etc/fstab${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ /etc/fstab Entries ─────────────────────────────────────────┐${NC}"
    for entry in "${entries[@]}"; do
        echo -e "  ${BRIGHT_GREEN}$entry${NC}"
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter line number to remove (0 to cancel): " line_num

    if [ -z "$line_num" ] || [ "$line_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$line_num" =~ ^[0-9]+$ ]] || [ "$line_num" -lt 1 ] || [ "$line_num" -gt ${#entries[@]} ]; then
        echo -e "${RED}Invalid line number${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local entry_to_remove=$(grep -v '^#' /etc/fstab | grep -v '^$' | sed -n "${line_num}p")

    echo ""
    echo -e "${BRIGHT_YELLOW}Entry to remove:${NC}"
    echo -e "${BRIGHT_RED}$entry_to_remove${NC}"
    echo ""

    echo -e "${BRIGHT_RED}⚠  WARNING: Removing entries can affect system boot!${NC}"
    read -p "Type 'yes' to confirm removal: " confirm

    if [ "$confirm" != "yes" ]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Backup fstab
    sudo cp /etc/fstab /etc/fstab.backup.$(date +%Y%m%d%H%M%S)

    # Remove entry
    sudo sed -i "/^$(echo "$entry_to_remove" | sed 's/[\/&]/\\&/g')/d" /etc/fstab

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Entry removed from /etc/fstab${NC}"
        echo -e "${BRIGHT_CYAN}Backup created: /etc/fstab.backup.*${NC}"
    else
        echo -e "${BRIGHT_RED}✗ Failed to remove entry${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Edit /etc/fstab Manually
edit_fstab_manual() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${BRIGHT_YELLOW}✏ ${WHITE}${BOLD}EDIT /etc/fstab${NC}                                           ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_RED}⚠  WARNING: Incorrect fstab entries can prevent system boot!${NC}"
    echo ""
    read -p "Continue with editing /etc/fstab? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Backup fstab
    sudo cp /etc/fstab /etc/fstab.backup.$(date +%Y%m%d%H%M%S)
    echo -e "${BRIGHT_CYAN}Backup created: /etc/fstab.backup.*${NC}"

    # Edit with default editor
    echo ""
    echo -e "${BRIGHT_CYAN}Opening /etc/fstab in editor...${NC}"
    sleep 1

    sudo ${EDITOR:-nano} /etc/fstab

    echo ""
    echo -e "${BRIGHT_GREEN}✓ Edit session completed${NC}"

    read -p "Test mount all filesystems? (y/n): " -n 1 test_mount
    echo ""

    if [[ $test_mount =~ ^[Yy]$ ]]; then
        sudo mount -a
        if [ $? -eq 0 ]; then
            echo -e "${BRIGHT_GREEN}✓ All filesystems mounted successfully${NC}"
        else
            echo -e "${BRIGHT_RED}✗ Mount failed - check /etc/fstab for errors${NC}"
            echo -e "${BRIGHT_CYAN}Restore backup if needed: sudo cp /etc/fstab.backup.* /etc/fstab${NC}"
        fi
    fi

    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# PACKAGE MANAGEMENT FUNCTIONS
#=============================================================================

# Detect package manager
detect_package_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v yum &> /dev/null; then
        echo "yum"
    else
        echo "none"
    fi
}

update_package_lists() {
    clear
    echo -e "${CYAN}${BOLD}UPDATE PACKAGE LISTS${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Running: sudo apt update${NC}"
            echo ""
            sudo apt update
            ;;
        dnf)
            echo -e "${GREEN}Running: sudo dnf check-update${NC}"
            echo ""
            sudo dnf check-update
            ;;
        yum)
            echo -e "${GREEN}Running: sudo yum check-update${NC}"
            echo ""
            sudo yum check-update
            ;;
        *)
            echo -e "${RED}No supported package manager found${NC}"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

install_package() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}INSTALL PACKAGE${NC}                                              ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    if [ "$PKG_MGR" == "none" ]; then
        echo -e "${RED}No supported package manager found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter search term (e.g., apache, nginx, python): " search_term

    if [ -z "$search_term" ]; then
        echo -e "${RED}Search term cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Searching for packages matching '$search_term'...${NC}"
    echo ""

    # Search and display packages
    case $PKG_MGR in
        apt)
            mapfile -t packages < <(apt-cache search "$search_term" 2>/dev/null | head -20 | awk '{print $1}')
            ;;
        dnf)
            mapfile -t packages < <(dnf search "$search_term" 2>/dev/null | grep -v "^=" | grep -v "^Last" | grep ":" | head -20 | awk -F: '{print $1}' | xargs)
            ;;
        yum)
            mapfile -t packages < <(yum search "$search_term" 2>/dev/null | grep -v "^=" | grep -v "^Loaded" | grep ":" | head -20 | awk -F: '{print $1}' | sed 's/\..*//g' | xargs)
            ;;
    esac

    if [ ${#packages[@]} -eq 0 ]; then
        echo -e "${YELLOW}No packages found matching '$search_term'${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Found Packages ─────────────────────────────────────────────┐${NC}"
    local i=1
    for pkg in "${packages[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$pkg"
        ((i++))
        if [ $i -gt 20 ]; then
            break
        fi
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter package number to install (0 to cancel): " pkg_num

    if [ -z "$pkg_num" ] || [ "$pkg_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$pkg_num" =~ ^[0-9]+$ ]] || [ "$pkg_num" -lt 1 ] || [ "$pkg_num" -gt ${#packages[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local package_name="${packages[$((pkg_num-1))]}"

    echo ""
    echo -e "${BRIGHT_CYAN}Installing: ${WHITE}$package_name${NC}"
    echo ""

    case $PKG_MGR in
        apt)
            sudo apt install -y "$package_name"
            ;;
        dnf)
            sudo dnf install -y "$package_name"
            ;;
        yum)
            sudo yum install -y "$package_name"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${BRIGHT_GREEN}✓ Package installed successfully${NC}"
    else
        echo ""
        echo -e "${BRIGHT_RED}✗ Installation failed${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

remove_package() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}REMOVE PACKAGE${NC}                                               ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    if [ "$PKG_MGR" == "none" ]; then
        echo -e "${RED}No supported package manager found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter search term for installed packages: " search_term

    if [ -z "$search_term" ]; then
        echo -e "${RED}Search term cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Searching installed packages matching '$search_term'...${NC}"
    echo ""

    # Search installed packages
    case $PKG_MGR in
        apt)
            mapfile -t packages < <(dpkg -l | grep "$search_term" | awk '{print $2}' | head -20)
            ;;
        dnf)
            mapfile -t packages < <(dnf list installed | grep "$search_term" | awk '{print $1}' | sed 's/\..*//g' | head -20)
            ;;
        yum)
            mapfile -t packages < <(yum list installed | grep "$search_term" | awk '{print $1}' | sed 's/\..*//g' | head -20)
            ;;
    esac

    if [ ${#packages[@]} -eq 0 ]; then
        echo -e "${YELLOW}No installed packages found matching '$search_term'${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_YELLOW}┌─ Installed Packages ─────────────────────────────────────────┐${NC}"
    local i=1
    for pkg in "${packages[@]}"; do
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$pkg"
        ((i++))
        if [ $i -gt 20 ]; then
            break
        fi
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter package number to remove (0 to cancel): " pkg_num

    if [ -z "$pkg_num" ] || [ "$pkg_num" -eq 0 ] 2>/dev/null; then
        return
    fi

    if ! [[ "$pkg_num" =~ ^[0-9]+$ ]] || [ "$pkg_num" -lt 1 ] || [ "$pkg_num" -gt ${#packages[@]} ]; then
        echo -e "${RED}Invalid selection${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local package_name="${packages[$((pkg_num-1))]}"

    echo ""
    echo -e "${BRIGHT_RED}⚠  Remove: ${WHITE}$package_name${NC}"
    read -p "Are you sure? (y/n): " -n 1 confirm
    echo ""

    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Removing: ${WHITE}$package_name${NC}"
    echo ""

    case $PKG_MGR in
        apt)
            sudo apt remove -y "$package_name"
            ;;
        dnf)
            sudo dnf remove -y "$package_name"
            ;;
        yum)
            sudo yum remove -y "$package_name"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${BRIGHT_GREEN}✓ Package removed successfully${NC}"
    else
        echo ""
        echo -e "${BRIGHT_RED}✗ Removal failed${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

upgrade_system() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}UPGRADE SYSTEM${NC}                                                ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    if [ "$PKG_MGR" == "none" ]; then
        echo -e "${RED}No supported package manager found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${BRIGHT_CYAN}Upgrade options:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Upgrade all packages ${DIM}(full system upgrade)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Upgrade specific package ${DIM}(search and select)${NC}"
    echo ""
    read -p "Enter choice (1-2): " upgrade_choice

    case $upgrade_choice in
        1)
            # Full system upgrade
            echo ""
            echo -e "${BRIGHT_YELLOW}⚠  This will upgrade all packages on your system${NC}"
            read -p "Continue? (y/n): " -n 1 confirm
            echo ""

            if [[ ! $confirm =~ ^[Yy]$ ]]; then
                echo -e "${YELLOW}Cancelled${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            echo ""
            case $PKG_MGR in
                apt)
                    echo -e "${BRIGHT_CYAN}Running: sudo apt update && sudo apt upgrade${NC}"
                    echo ""
                    sudo apt update && sudo apt upgrade -y
                    ;;
                dnf)
                    echo -e "${BRIGHT_CYAN}Running: sudo dnf upgrade${NC}"
                    echo ""
                    sudo dnf upgrade -y
                    ;;
                yum)
                    echo -e "${BRIGHT_CYAN}Running: sudo yum update${NC}"
                    echo ""
                    sudo yum update -y
                    ;;
            esac

            if [ $? -eq 0 ]; then
                echo ""
                echo -e "${BRIGHT_GREEN}✓ System upgraded successfully${NC}"
            else
                echo ""
                echo -e "${BRIGHT_RED}✗ Upgrade failed${NC}"
            fi
            ;;
        2)
            # Specific package upgrade
            echo ""
            read -p "Enter package name to search: " search_term

            if [ -z "$search_term" ]; then
                echo -e "${RED}Search term cannot be empty${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            echo ""
            echo -e "${BRIGHT_CYAN}Searching for upgradable packages matching '$search_term'...${NC}"
            echo ""

            # List upgradable packages
            case $PKG_MGR in
                apt)
                    mapfile -t packages < <(apt list --upgradable 2>/dev/null | grep "$search_term" | awk -F'/' '{print $1}' | head -20)
                    ;;
                dnf)
                    mapfile -t packages < <(dnf list updates 2>/dev/null | grep "$search_term" | awk '{print $1}' | sed 's/\..*//g' | head -20)
                    ;;
                yum)
                    mapfile -t packages < <(yum list updates 2>/dev/null | grep "$search_term" | awk '{print $1}' | sed 's/\..*//g' | head -20)
                    ;;
            esac

            if [ ${#packages[@]} -eq 0 ]; then
                echo -e "${YELLOW}No upgradable packages found matching '$search_term'${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            echo -e "${BRIGHT_YELLOW}┌─ Upgradable Packages ────────────────────────────────────────┐${NC}"
            local i=1
            for pkg in "${packages[@]}"; do
                printf "  ${BRIGHT_GREEN}[%2d]${NC} %s\n" "$i" "$pkg"
                ((i++))
                if [ $i -gt 20 ]; then
                    break
                fi
            done
            echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
            echo ""

            read -p "Enter package number to upgrade (0 to cancel): " pkg_num

            if [ -z "$pkg_num" ] || [ "$pkg_num" -eq 0 ] 2>/dev/null; then
                return
            fi

            if ! [[ "$pkg_num" =~ ^[0-9]+$ ]] || [ "$pkg_num" -lt 1 ] || [ "$pkg_num" -gt ${#packages[@]} ]; then
                echo -e "${RED}Invalid selection${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            local package_name="${packages[$((pkg_num-1))]}"

            echo ""
            echo -e "${BRIGHT_CYAN}Upgrading: ${WHITE}$package_name${NC}"
            echo ""

            case $PKG_MGR in
                apt)
                    sudo apt install --only-upgrade -y "$package_name"
                    ;;
                dnf)
                    sudo dnf upgrade -y "$package_name"
                    ;;
                yum)
                    sudo yum update -y "$package_name"
                    ;;
            esac

            if [ $? -eq 0 ]; then
                echo ""
                echo -e "${BRIGHT_GREEN}✓ Package upgraded successfully${NC}"
            else
                echo ""
                echo -e "${BRIGHT_RED}✗ Upgrade failed${NC}"
            fi
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

search_package() {
    clear
    echo -e "${CYAN}${BOLD}SEARCH PACKAGE${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    if [ "$PKG_MGR" == "none" ]; then
        echo -e "${RED}No supported package manager found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter search term: " search_term

    if [ -z "$search_term" ]; then
        echo -e "${RED}Search term cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Running: apt search $search_term${NC}"
            echo ""
            apt search "$search_term" 2>/dev/null | head -n 50
            ;;
        dnf)
            echo -e "${GREEN}Running: dnf search $search_term${NC}"
            echo ""
            dnf search "$search_term" 2>/dev/null | head -n 50
            ;;
        yum)
            echo -e "${GREEN}Running: yum search $search_term${NC}"
            echo ""
            yum search "$search_term" 2>/dev/null | head -n 50
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

list_installed_packages() {
    clear
    echo -e "${CYAN}${BOLD}INSTALLED PACKAGES (First 50)${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Installed packages (dpkg -l):${NC}"
            echo ""
            dpkg -l | grep '^ii' | head -n 50
            ;;
        dnf)
            echo -e "${GREEN}Installed packages (dnf list installed):${NC}"
            echo ""
            dnf list installed 2>/dev/null | head -n 50
            ;;
        yum)
            echo -e "${GREEN}Installed packages (yum list installed):${NC}"
            echo ""
            yum list installed 2>/dev/null | head -n 50
            ;;
        *)
            echo -e "${RED}No supported package manager found${NC}"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

clean_package_cache() {
    clear
    echo -e "${CYAN}${BOLD}CLEAN PACKAGE CACHE${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Running: sudo apt clean && sudo apt autoclean${NC}"
            echo ""
            sudo apt clean && sudo apt autoclean
            echo -e "${GREEN}Cache cleaned successfully${NC}"
            ;;
        dnf)
            echo -e "${GREEN}Running: sudo dnf clean all${NC}"
            echo ""
            sudo dnf clean all
            echo -e "${GREEN}Cache cleaned successfully${NC}"
            ;;
        yum)
            echo -e "${GREEN}Running: sudo yum clean all${NC}"
            echo ""
            sudo yum clean all
            echo -e "${GREEN}Cache cleaned successfully${NC}"
            ;;
        *)
            echo -e "${RED}No supported package manager found${NC}"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# NETWORK TOOLS FUNCTIONS
#=============================================================================

ping_test() {
    clear
    echo -e "${CYAN}${BOLD}PING TEST${NC}"
    echo ""

    read -p "Enter hostname or IP address to ping: " target

    if [ -z "$target" ]; then
        echo -e "${RED}Target cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Number of packets (default: 4): " count
    count=${count:-4}

    echo ""
    echo -e "${GREEN}Running: ping -c $count $target${NC}"
    echo ""
    ping -c "$count" "$target"

    echo ""
    read -p "Press Enter to continue..."
}

traceroute_test() {
    clear
    echo -e "${CYAN}${BOLD}TRACEROUTE${NC}"
    echo ""

    # Check if traceroute is installed
    if ! command -v traceroute &> /dev/null; then
        echo -e "${YELLOW}traceroute is not installed.${NC}"
        echo ""
        read -p "Would you like to install it? (y/n): " -n 1 install_choice
        echo ""

        if [[ $install_choice =~ ^[Yy]$ ]]; then
            PKG_MGR=$(detect_package_manager)
            case $PKG_MGR in
                apt) sudo apt install -y traceroute ;;
                dnf) sudo dnf install -y traceroute ;;
                yum) sudo yum install -y traceroute ;;
                *) echo -e "${RED}Could not install traceroute${NC}"; read -p "Press Enter..."; return ;;
            esac
        else
            read -p "Press Enter to continue..."
            return
        fi
    fi

    read -p "Enter hostname or IP address: " target

    if [ -z "$target" ]; then
        echo -e "${RED}Target cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${GREEN}Running: traceroute $target${NC}"
    echo ""
    traceroute "$target"

    echo ""
    read -p "Press Enter to continue..."
}

dns_lookup() {
    clear
    echo -e "${CYAN}${BOLD}DNS LOOKUP${NC}"
    echo ""

    read -p "Enter domain name to lookup: " domain

    if [ -z "$domain" ]; then
        echo -e "${RED}Domain cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""

    # Try dig first, fallback to nslookup
    if command -v dig &> /dev/null; then
        echo -e "${GREEN}Running: dig $domain${NC}"
        echo ""
        dig "$domain"
    elif command -v nslookup &> /dev/null; then
        echo -e "${GREEN}Running: nslookup $domain${NC}"
        echo ""
        nslookup "$domain"
    else
        echo -e "${YELLOW}Neither dig nor nslookup is available${NC}"
        echo ""
        echo -e "${GREEN}Using host command:${NC}"
        echo ""
        host "$domain"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

check_open_ports() {
    clear
    echo -e "${CYAN}${BOLD}CHECK OPEN PORTS${NC}"
    echo ""

    # Try ss first (modern), fallback to netstat
    if command -v ss &> /dev/null; then
        echo -e "${GREEN}Listening ports (using ss):${NC}"
        echo ""
        sudo ss -tulpn | head -n 30
    elif command -v netstat &> /dev/null; then
        echo -e "${GREEN}Listening ports (using netstat):${NC}"
        echo ""
        sudo netstat -tulpn | head -n 30
    else
        echo -e "${RED}Neither ss nor netstat is available${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

test_specific_port() {
    clear
    echo -e "${CYAN}${BOLD}TEST SPECIFIC PORT${NC}"
    echo ""

    read -p "Enter hostname or IP address: " target
    read -p "Enter port number: " port

    if [ -z "$target" ] || [ -z "$port" ]; then
        echo -e "${RED}Target and port cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${GREEN}Testing connection to $target:$port${NC}"
    echo ""

    # Try nc (netcat) first
    if command -v nc &> /dev/null; then
        timeout 5 nc -zv "$target" "$port" 2>&1
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Port $port is open${NC}"
        else
            echo -e "${RED}✗ Port $port is closed or filtered${NC}"
        fi
    else
        # Fallback to telnet or bash
        if command -v telnet &> /dev/null; then
            timeout 5 telnet "$target" "$port" 2>&1 | head -n 5
        else
            # Use bash TCP feature
            timeout 5 bash -c "echo > /dev/tcp/$target/$port" 2>&1
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}✓ Port $port is open${NC}"
            else
                echo -e "${RED}✗ Port $port is closed or not reachable${NC}"
            fi
        fi
    fi

    echo ""
    read -p "Press Enter to continue..."
}

network_speed_test() {
    clear
    echo -e "${CYAN}${BOLD}NETWORK SPEED TEST${NC}"
    echo ""

    if ! command -v speedtest-cli &> /dev/null; then
        echo -e "${YELLOW}speedtest-cli is not installed.${NC}"
        echo ""
        read -p "Would you like to install it? (y/n): " -n 1 install_choice
        echo ""

        if [[ $install_choice =~ ^[Yy]$ ]]; then
            PKG_MGR=$(detect_package_manager)
            case $PKG_MGR in
                apt) sudo apt install -y speedtest-cli ;;
                dnf) sudo dnf install -y speedtest-cli ;;
                yum) sudo yum install -y speedtest-cli ;;
                *) echo -e "${RED}Could not install speedtest-cli${NC}"; read -p "Press Enter..."; return ;;
            esac
        else
            read -p "Press Enter to continue..."
            return
        fi
    fi

    echo -e "${GREEN}Running speed test...${NC}"
    echo -e "${YELLOW}This may take a minute...${NC}"
    echo ""
    speedtest-cli

    echo ""
    read -p "Press Enter to continue..."
}

flush_dns_cache() {
    clear
    echo -e "${CYAN}${BOLD}FLUSH DNS CACHE${NC}"
    echo ""

    # Detect which DNS caching service is running
    if systemctl is-active --quiet systemd-resolved; then
        echo -e "${GREEN}Flushing systemd-resolved DNS cache...${NC}"
        sudo systemd-resolve --flush-caches 2>/dev/null || sudo resolvectl flush-caches
        echo -e "${GREEN}✓ DNS cache flushed (systemd-resolved)${NC}"
    elif systemctl is-active --quiet dnsmasq; then
        echo -e "${GREEN}Restarting dnsmasq...${NC}"
        sudo systemctl restart dnsmasq
        echo -e "${GREEN}✓ DNS cache flushed (dnsmasq)${NC}"
    elif systemctl is-active --quiet nscd; then
        echo -e "${GREEN}Restarting nscd...${NC}"
        sudo systemctl restart nscd
        echo -e "${GREEN}✓ DNS cache flushed (nscd)${NC}"
    else
        echo -e "${YELLOW}No DNS caching service detected.${NC}"
        echo ""
        echo -e "${GREEN}Clearing /etc/resolv.conf if using DHCP:${NC}"
        if command -v dhclient &> /dev/null; then
            sudo dhclient -r && sudo dhclient
            echo -e "${GREEN}✓ DHCP renewed${NC}"
        else
            echo -e "${YELLOW}No action needed - no DNS cache found${NC}"
        fi
    fi

    echo ""
    read -p "Press Enter to continue..."
}

restart_network_service() {
    clear
    echo -e "${CYAN}${BOLD}RESTART NETWORK SERVICE${NC}"
    echo ""

    echo -e "${YELLOW}Available network services:${NC}"
    echo ""
    echo "  1) NetworkManager"
    echo "  2) systemd-networkd"
    echo "  3) networking (Debian/Ubuntu)"
    echo "  4) network (RHEL/CentOS)"
    echo ""
    read -p "Choose service to restart (1-4): " -n 1 service_choice
    echo ""
    echo ""

    case $service_choice in
        1)
            if systemctl is-active --quiet NetworkManager; then
                echo -e "${GREEN}Restarting NetworkManager...${NC}"
                sudo systemctl restart NetworkManager
                echo -e "${GREEN}✓ NetworkManager restarted${NC}"
            else
                echo -e "${RED}NetworkManager is not running${NC}"
            fi
            ;;
        2)
            if systemctl is-active --quiet systemd-networkd; then
                echo -e "${GREEN}Restarting systemd-networkd...${NC}"
                sudo systemctl restart systemd-networkd
                echo -e "${GREEN}✓ systemd-networkd restarted${NC}"
            else
                echo -e "${RED}systemd-networkd is not running${NC}"
            fi
            ;;
        3)
            echo -e "${GREEN}Restarting networking service...${NC}"
            sudo systemctl restart networking 2>/dev/null || sudo service networking restart
            echo -e "${GREEN}✓ Networking service restarted${NC}"
            ;;
        4)
            echo -e "${GREEN}Restarting network service...${NC}"
            sudo systemctl restart network 2>/dev/null || sudo service network restart
            echo -e "${GREEN}✓ Network service restarted${NC}"
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

view_firewall_rules() {
    clear
    echo -e "${CYAN}${BOLD}VIEW FIREWALL RULES${NC}"
    echo ""

    # Check which firewall system is in use
    if command -v nft &> /dev/null && [ -n "$(sudo nft list ruleset 2>/dev/null)" ]; then
        echo -e "${GREEN}Firewall: nftables${NC}"
        echo ""
        sudo nft list ruleset | head -n 50
    elif command -v iptables &> /dev/null; then
        echo -e "${GREEN}Firewall: iptables${NC}"
        echo ""
        echo -e "${CYAN}Filter table (INPUT/OUTPUT/FORWARD):${NC}"
        sudo iptables -L -n -v | head -n 30
        echo ""
        echo -e "${CYAN}NAT table:${NC}"
        sudo iptables -t nat -L -n -v | head -n 20
    elif command -v firewall-cmd &> /dev/null; then
        echo -e "${GREEN}Firewall: firewalld${NC}"
        echo ""
        sudo firewall-cmd --list-all
    elif command -v ufw &> /dev/null; then
        echo -e "${GREEN}Firewall: ufw${NC}"
        echo ""
        sudo ufw status verbose
    else
        echo -e "${YELLOW}No supported firewall tool found${NC}"
        echo -e "${YELLOW}(Checked: nftables, iptables, firewalld, ufw)${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Create Virtual Interface
create_virtual_interface() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}CREATE VIRTUAL INTERFACE${NC}                                   ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # List existing interfaces
    echo -e "${BRIGHT_YELLOW}┌─ Existing Interfaces ────────────────────────────────────────┐${NC}"
    ip -br addr | awk -v green="${BRIGHT_GREEN}" -v white="${WHITE}" -v nc="${NC}" '{printf "  " green "%-15s" nc " " white "%s" nc "\n", $1, $3}'
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Select virtual interface type:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} VLAN ${DIM}(802.1Q tagged)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Alias ${DIM}(eth0:0, eth0:1, etc.)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} Bridge ${DIM}(virtual switch)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} Dummy ${DIM}(virtual loopback)${NC}"
    echo ""
    read -p "Enter type (0 to cancel): " vif_type

    case $vif_type in
        1)
            # VLAN
            read -p "Enter parent interface (e.g., eth0): " parent_iface
            if ! ip link show "$parent_iface" &>/dev/null; then
                echo -e "${RED}Interface $parent_iface not found${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            read -p "Enter VLAN ID (1-4094): " vlan_id
            if ! [[ "$vlan_id" =~ ^[0-9]+$ ]] || [ "$vlan_id" -lt 1 ] || [ "$vlan_id" -gt 4094 ]; then
                echo -e "${RED}Invalid VLAN ID${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            local vlan_iface="${parent_iface}.${vlan_id}"

            echo ""
            echo -e "${BRIGHT_CYAN}Creating VLAN interface: $vlan_iface${NC}"

            sudo ip link add link "$parent_iface" name "$vlan_iface" type vlan id "$vlan_id"

            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ VLAN interface created${NC}"

                read -p "Configure IP address? (y/n): " -n 1 config_ip
                echo ""

                if [[ $config_ip =~ ^[Yy]$ ]]; then
                    read -p "Enter IP address (e.g., 192.168.1.10/24): " ip_addr
                    sudo ip addr add "$ip_addr" dev "$vlan_iface"
                    sudo ip link set "$vlan_iface" up
                    echo -e "${BRIGHT_GREEN}✓ IP configured and interface brought up${NC}"
                fi
            else
                echo -e "${BRIGHT_RED}✗ Failed to create VLAN interface${NC}"
            fi
            ;;
        2)
            # Alias
            read -p "Enter base interface (e.g., eth0): " base_iface
            if ! ip link show "$base_iface" &>/dev/null; then
                echo -e "${RED}Interface $base_iface not found${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            read -p "Enter alias number (e.g., 0 for eth0:0): " alias_num
            local alias_iface="${base_iface}:${alias_num}"

            read -p "Enter IP address (e.g., 192.168.1.20/24): " ip_addr

            echo ""
            echo -e "${BRIGHT_CYAN}Creating alias interface: $alias_iface${NC}"

            sudo ifconfig "$alias_iface" "$ip_addr" up 2>/dev/null || sudo ip addr add "$ip_addr" dev "$base_iface" label "$alias_iface"

            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ Alias interface created${NC}"
            else
                echo -e "${BRIGHT_RED}✗ Failed to create alias interface${NC}"
            fi
            ;;
        3)
            # Bridge
            if ! command -v brctl &>/dev/null && ! command -v ip &>/dev/null; then
                echo -e "${YELLOW}Bridge utilities not available${NC}"
                read -p "Press Enter to continue..."
                return
            fi

            read -p "Enter bridge name (e.g., br0): " bridge_name

            echo ""
            echo -e "${BRIGHT_CYAN}Creating bridge: $bridge_name${NC}"

            sudo ip link add "$bridge_name" type bridge
            sudo ip link set "$bridge_name" up

            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ Bridge created${NC}"

                read -p "Add interface to bridge? (y/n): " -n 1 add_iface
                echo ""

                if [[ $add_iface =~ ^[Yy]$ ]]; then
                    read -p "Enter interface to add: " iface_to_add
                    if ip link show "$iface_to_add" &>/dev/null; then
                        sudo ip link set "$iface_to_add" master "$bridge_name"
                        echo -e "${BRIGHT_GREEN}✓ Interface added to bridge${NC}"
                    fi
                fi
            else
                echo -e "${BRIGHT_RED}✗ Failed to create bridge${NC}"
            fi
            ;;
        4)
            # Dummy
            read -p "Enter dummy interface name (e.g., dummy0): " dummy_name

            echo ""
            echo -e "${BRIGHT_CYAN}Creating dummy interface: $dummy_name${NC}"

            sudo ip link add "$dummy_name" type dummy

            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ Dummy interface created${NC}"

                read -p "Configure IP address? (y/n): " -n 1 config_ip
                echo ""

                if [[ $config_ip =~ ^[Yy]$ ]]; then
                    read -p "Enter IP address (e.g., 10.0.0.1/32): " ip_addr
                    sudo ip addr add "$ip_addr" dev "$dummy_name"
                    sudo ip link set "$dummy_name" up
                    echo -e "${BRIGHT_GREEN}✓ IP configured and interface brought up${NC}"
                fi
            else
                echo -e "${BRIGHT_RED}✗ Failed to create dummy interface${NC}"
            fi
            ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}" ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

# Create Network Bond
create_network_bond() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}CREATE NETWORK BOND${NC}                                       ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    # Check if bonding module is available
    if ! lsmod | grep -q bonding; then
        echo -e "${YELLOW}Loading bonding kernel module...${NC}"
        sudo modprobe bonding
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to load bonding module${NC}"
            read -p "Press Enter to continue..."
            return
        fi
        echo -e "${BRIGHT_GREEN}✓ Bonding module loaded${NC}"
        echo ""
    fi

    # List available interfaces
    echo -e "${BRIGHT_YELLOW}┌─ Available Interfaces ───────────────────────────────────────┐${NC}"
    mapfile -t interfaces < <(ip -br link | awk '$2!="lo" && $1!~/bond/ {print $1}')

    local i=1
    for iface in "${interfaces[@]}"; do
        local status=$(ip -br link show "$iface" | awk '{print $2}')
        printf "  ${BRIGHT_GREEN}[%2d]${NC} %-15s ${DIM}Status:${NC} %s\n" "$i" "$iface" "$status"
        ((i++))
    done
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    # Bond configuration
    read -p "Enter bond name (e.g., bond0): " bond_name

    echo ""
    echo -e "${BRIGHT_CYAN}Select bonding mode:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} balance-rr ${DIM}(Mode 0: Round-robin)${NC}"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} active-backup ${DIM}(Mode 1: Active-backup)${NC}"
    echo -e "  ${BRIGHT_GREEN}[3]${NC} balance-xor ${DIM}(Mode 2: XOR)${NC}"
    echo -e "  ${BRIGHT_GREEN}[4]${NC} broadcast ${DIM}(Mode 3: Broadcast)${NC}"
    echo -e "  ${BRIGHT_GREEN}[5]${NC} 802.3ad ${DIM}(Mode 4: LACP)${NC}"
    echo -e "  ${BRIGHT_GREEN}[6]${NC} balance-tlb ${DIM}(Mode 5: Adaptive transmit load balancing)${NC}"
    echo -e "  ${BRIGHT_GREEN}[7]${NC} balance-alb ${DIM}(Mode 6: Adaptive load balancing - active-active)${NC}"
    echo ""
    read -p "Enter mode (1-7): " mode_choice

    local bond_mode=""
    local mode_num=""
    case $mode_choice in
        1) bond_mode="balance-rr"; mode_num="0" ;;
        2) bond_mode="active-backup"; mode_num="1" ;;
        3) bond_mode="balance-xor"; mode_num="2" ;;
        4) bond_mode="broadcast"; mode_num="3" ;;
        5) bond_mode="802.3ad"; mode_num="4" ;;
        6) bond_mode="balance-tlb"; mode_num="5" ;;
        7) bond_mode="balance-alb"; mode_num="6" ;;
        *) echo -e "${RED}Invalid mode${NC}"; read -p "Press Enter..."; return ;;
    esac

    # Select interfaces to bond
    echo ""
    echo -e "${BRIGHT_CYAN}Select interfaces to add to bond (space-separated numbers):${NC}"
    read -p "Enter interface numbers: " iface_nums

    local selected_ifaces=()
    for num in $iface_nums; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le ${#interfaces[@]} ]; then
            selected_ifaces+=("${interfaces[$((num-1))]}")
        fi
    done

    if [ ${#selected_ifaces[@]} -lt 2 ]; then
        echo -e "${RED}Need at least 2 interfaces for bonding${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Confirm
    echo ""
    echo -e "${BRIGHT_YELLOW}┌─ Bond Configuration ─────────────────────────────────────────┐${NC}"
    echo -e "  Bond name: ${BRIGHT_CYAN}$bond_name${NC}"
    echo -e "  Mode: ${BRIGHT_CYAN}$bond_mode (mode $mode_num)${NC}"
    echo -e "  Interfaces: ${BRIGHT_CYAN}${selected_ifaces[*]}${NC}"
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""
    read -p "Create this bond? (y/n): " -n 1 confirm
    echo ""

    if ! [[ $confirm =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Cancelled${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create bond
    echo ""
    echo -e "${BRIGHT_CYAN}Creating bond interface...${NC}"

    sudo ip link add "$bond_name" type bond mode "$mode_num"

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Bond interface created${NC}"

        # Add interfaces to bond
        for iface in "${selected_ifaces[@]}"; do
            echo -e "${BRIGHT_CYAN}Adding $iface to bond...${NC}"
            sudo ip link set "$iface" down
            sudo ip link set "$iface" master "$bond_name"
            echo -e "${BRIGHT_GREEN}✓ $iface added${NC}"
        done

        # Bring up bond
        sudo ip link set "$bond_name" up

        echo ""
        echo -e "${BRIGHT_GREEN}✓ Bond $bond_name is now active!${NC}"

        # Configure IP
        read -p "Configure IP address for bond? (y/n): " -n 1 config_ip
        echo ""

        if [[ $config_ip =~ ^[Yy]$ ]]; then
            read -p "Enter IP address (e.g., 192.168.1.10/24): " ip_addr
            sudo ip addr add "$ip_addr" dev "$bond_name"
            echo -e "${BRIGHT_GREEN}✓ IP configured${NC}"
        fi

        # Show bond status
        echo ""
        echo -e "${BRIGHT_YELLOW}Bond status:${NC}"
        cat "/proc/net/bonding/$bond_name" 2>/dev/null || echo "Status info not available"
    else
        echo -e "${BRIGHT_RED}✗ Failed to create bond${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# FILE MANAGEMENT MENU
#=============================================================================

# File Management menu
file_management_menu() {
    while true; do
        show_header
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${WHITE}${BOLD}FILE MANAGEMENT${NC}                                         ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${WHITE}Navigate Directories${NC}     ${DIM}- Browse filesystem${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${WHITE}Show Directory Sizes${NC}     ${DIM}- View disk usage${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${WHITE}Create Directory${NC}         ${DIM}- Make new directory${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${WHITE}Delete Directory${NC}         ${DIM}- Remove directory${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${WHITE}Rename Directory${NC}         ${DIM}- Rename directory${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "Press a number key: "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) navigate_directories ;;
            2) show_directory_sizes ;;
            3) create_directory ;;
            4) delete_directory ;;
            5) rename_directory ;;
            0) return ;;
        esac
    done
}

# Navigate directories
navigate_directories() {
    local current_dir="${1:-$PWD}"

    while true; do
        clear
        echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}NAVIGATE DIRECTORIES${NC}                                      ${BRIGHT_PURPLE}║${NC}"
        echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -e "${BRIGHT_CYAN}Current directory:${NC} ${WHITE}$current_dir${NC}"
        echo ""

        # Check if directory exists and is accessible
        if [ ! -d "$current_dir" ]; then
            echo -e "${RED}Directory does not exist or is not accessible${NC}"
            read -p "Press Enter to go back..."
            return
        fi

        # List contents with numbering
        echo -e "${BRIGHT_YELLOW}┌─ Contents ───────────────────────────────────────────────────┐${NC}"

        # Show parent directory option
        echo -e "  ${BRIGHT_GREEN}[0]${NC} ${DIM}..${NC} ${DIM}(Parent directory)${NC}"

        # Get directories and files
        local i=1
        local -a items
        items[0]=".."

        # List directories first
        while IFS= read -r dir; do
            if [ -n "$dir" ]; then
                items[$i]="$dir"
                printf "  ${BRIGHT_GREEN}[%2d]${NC} ${BRIGHT_BLUE}%s${NC} ${DIM}(directory)${NC}\n" "$i" "$(basename "$dir")"
                ((i++))
            fi
        done < <(find "$current_dir" -maxdepth 1 -type d ! -path "$current_dir" 2>/dev/null | sort)

        # Then list files
        while IFS= read -r file; do
            if [ -n "$file" ]; then
                items[$i]="$file"
                local size=$(du -h "$file" 2>/dev/null | awk '{print $1}')
                printf "  ${BRIGHT_GREEN}[%2d]${NC} %s ${DIM}(%s)${NC}\n" "$i" "$(basename "$file")" "$size"
                ((i++))
            fi
        done < <(find "$current_dir" -maxdepth 1 -type f 2>/dev/null | sort)

        echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
        echo ""
        echo -e "${DIM}Total items: $((i-1))${NC}"
        echo ""
        echo -e "Enter number to navigate, or type:"
        echo -e "  ${BRIGHT_CYAN}p${NC} - Enter path manually"
        echo -e "  ${BRIGHT_CYAN}h${NC} - Go to home directory"
        echo -e "  ${BRIGHT_CYAN}q${NC} - Quit navigation"
        echo ""
        read -p "Choice: " nav_choice

        case "$nav_choice" in
            q|Q)
                return
                ;;
            p|P)
                read -p "Enter path: " new_path
                if [ -d "$new_path" ]; then
                    current_dir="$(cd "$new_path" && pwd)"
                else
                    echo -e "${RED}Invalid path${NC}"
                    read -p "Press Enter to continue..."
                fi
                ;;
            h|H)
                current_dir="$HOME"
                ;;
            *)
                if [[ "$nav_choice" =~ ^[0-9]+$ ]] && [ "$nav_choice" -ge 0 ] && [ "$nav_choice" -lt "$i" ]; then
                    local selected="${items[$nav_choice]}"
                    if [ "$selected" = ".." ]; then
                        current_dir="$(dirname "$current_dir")"
                    elif [ -d "$selected" ]; then
                        current_dir="$selected"
                    else
                        echo ""
                        echo -e "${BRIGHT_CYAN}File:${NC} $(basename "$selected")"
                        echo -e "${BRIGHT_CYAN}Size:${NC} $(du -h "$selected" 2>/dev/null | awk '{print $1}')"
                        echo -e "${BRIGHT_CYAN}Type:${NC} $(file -b "$selected" 2>/dev/null)"
                        echo ""
                        read -p "Press Enter to continue..."
                    fi
                else
                    echo -e "${RED}Invalid selection${NC}"
                    read -p "Press Enter to continue..."
                fi
                ;;
        esac
    done
}

# Show directory sizes
show_directory_sizes() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}DIRECTORY SIZES${NC}                                           ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    read -p "Enter directory path (or press Enter for current directory): " dir_path

    if [ -z "$dir_path" ]; then
        dir_path="$PWD"
    fi

    if [ ! -d "$dir_path" ]; then
        echo -e "${RED}Directory does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_CYAN}Analyzing directory:${NC} ${WHITE}$dir_path${NC}"
    echo ""
    echo -e "${BRIGHT_YELLOW}┌─ Directory Sizes ────────────────────────────────────────────┐${NC}"
    echo ""

    # Show total size first
    local total_size=$(du -sh "$dir_path" 2>/dev/null | awk '{print $1}')
    echo -e "${BRIGHT_CYAN}Total size:${NC} ${WHITE}$total_size${NC}"
    echo ""

    # Sort options
    echo -e "${BRIGHT_CYAN}Sort by:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Size (largest first)"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Name (alphabetical)"
    echo ""
    read -p "Choice (default: 1): " sort_choice

    echo ""
    echo -e "${DIM}Calculating sizes...${NC}"
    echo ""

    case "$sort_choice" in
        2)
            du -h --max-depth=1 "$dir_path" 2>/dev/null | sort -k2
            ;;
        *)
            du -h --max-depth=1 "$dir_path" 2>/dev/null | sort -hr
            ;;
    esac

    echo ""
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    # Offer detailed breakdown
    read -p "Show detailed breakdown of a subdirectory? (y/n): " -n 1 show_detail
    echo ""

    if [[ $show_detail =~ ^[Yy]$ ]]; then
        read -p "Enter subdirectory name: " subdir
        local full_path="$dir_path/$subdir"

        if [ -d "$full_path" ]; then
            echo ""
            echo -e "${BRIGHT_CYAN}Detailed view of:${NC} ${WHITE}$full_path${NC}"
            echo ""
            du -h --max-depth=1 "$full_path" 2>/dev/null | sort -hr | head -20
        else
            echo -e "${RED}Subdirectory not found${NC}"
        fi
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Create directory
create_directory() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}CREATE DIRECTORY${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Current directory:${NC} ${WHITE}$PWD${NC}"
    echo ""

    read -p "Enter directory name or full path: " dir_name

    if [ -z "$dir_name" ]; then
        echo -e "${RED}Directory name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Create parent directories option
    echo ""
    echo -e "${BRIGHT_CYAN}Options:${NC}"
    echo -e "  ${BRIGHT_GREEN}[1]${NC} Create only this directory"
    echo -e "  ${BRIGHT_GREEN}[2]${NC} Create parent directories if needed (mkdir -p)"
    echo ""
    read -p "Choice (default: 1): " create_choice

    echo ""

    case "$create_choice" in
        2)
            mkdir -p "$dir_name"
            ;;
        *)
            mkdir "$dir_name"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "${BRIGHT_GREEN}✓ Directory created successfully${NC}"
        echo -e "${BRIGHT_CYAN}Location:${NC} $(realpath "$dir_name" 2>/dev/null || echo "$dir_name")"

        # Set permissions option
        echo ""
        read -p "Set custom permissions? (y/n): " -n 1 set_perms
        echo ""

        if [[ $set_perms =~ ^[Yy]$ ]]; then
            read -p "Enter permissions (e.g., 755, 700): " perms
            chmod "$perms" "$dir_name" 2>/dev/null
            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ Permissions set to $perms${NC}"
            else
                echo -e "${YELLOW}Could not set permissions${NC}"
            fi
        fi
    else
        echo -e "${BRIGHT_RED}✗ Failed to create directory${NC}"
        echo -e "${YELLOW}Common reasons:${NC}"
        echo -e "  - Directory already exists"
        echo -e "  - Insufficient permissions"
        echo -e "  - Parent directory does not exist (use option 2)"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Delete directory
delete_directory() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}DELETE DIRECTORY${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_RED}⚠  Warning: This will permanently delete the directory${NC}"
    echo ""
    echo -e "${BRIGHT_CYAN}Current directory:${NC} ${WHITE}$PWD${NC}"
    echo ""

    read -p "Enter directory name or full path to delete: " dir_name

    if [ -z "$dir_name" ]; then
        echo -e "${RED}Directory name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if [ ! -e "$dir_name" ]; then
        echo -e "${RED}Directory does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if [ ! -d "$dir_name" ]; then
        echo -e "${RED}Path is not a directory${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Get directory info
    local full_path="$(realpath "$dir_name" 2>/dev/null || echo "$dir_name")"
    local dir_size=$(du -sh "$dir_name" 2>/dev/null | awk '{print $1}')
    local item_count=$(find "$dir_name" -type f 2>/dev/null | wc -l)

    echo ""
    echo -e "${BRIGHT_YELLOW}Directory information:${NC}"
    echo -e "  Path: ${WHITE}$full_path${NC}"
    echo -e "  Size: ${WHITE}$dir_size${NC}"
    echo -e "  Files: ${WHITE}$item_count${NC}"
    echo ""

    # Check if directory is empty
    if [ -z "$(ls -A "$dir_name" 2>/dev/null)" ]; then
        echo -e "${BRIGHT_CYAN}Directory is empty${NC}"
        echo ""
        read -p "Delete this directory? (y/n): " -n 1 confirm
        echo ""

        if [[ $confirm =~ ^[Yy]$ ]]; then
            rmdir "$dir_name"
            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ Directory deleted successfully${NC}"
            else
                echo -e "${BRIGHT_RED}✗ Failed to delete directory${NC}"
            fi
        else
            echo -e "${YELLOW}Cancelled${NC}"
        fi
    else
        echo -e "${BRIGHT_YELLOW}Directory is not empty${NC}"
        echo ""
        echo -e "${BRIGHT_RED}⚠  WARNING: This will delete all contents!${NC}"
        echo ""
        read -p "Type 'DELETE' to confirm deletion: " confirm

        if [ "$confirm" = "DELETE" ]; then
            rm -rf "$dir_name"
            if [ $? -eq 0 ]; then
                echo -e "${BRIGHT_GREEN}✓ Directory and all contents deleted${NC}"
            else
                echo -e "${BRIGHT_RED}✗ Failed to delete directory${NC}"
            fi
        else
            echo -e "${YELLOW}Cancelled - confirmation did not match${NC}"
        fi
    fi

    echo ""
    read -p "Press Enter to continue..."
}

# Rename directory
rename_directory() {
    clear
    echo -e "${BRIGHT_PURPLE}╔═══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BRIGHT_PURPLE}║${NC}  ${WHITE}${BOLD}RENAME DIRECTORY${NC}                                          ${BRIGHT_PURPLE}║${NC}"
    echo -e "${BRIGHT_PURPLE}╚═══════════════════════════════════════════════════════════════╝${NC}"
    echo ""

    echo -e "${BRIGHT_CYAN}Current directory:${NC} ${WHITE}$PWD${NC}"
    echo ""

    read -p "Enter current directory name or path: " old_name

    if [ -z "$old_name" ]; then
        echo -e "${RED}Directory name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if [ ! -e "$old_name" ]; then
        echo -e "${RED}Directory does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if [ ! -d "$old_name" ]; then
        echo -e "${RED}Path is not a directory${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    local old_path="$(realpath "$old_name" 2>/dev/null || echo "$old_name")"

    echo ""
    echo -e "${BRIGHT_CYAN}Current name:${NC} ${WHITE}$(basename "$old_path")${NC}"
    echo -e "${BRIGHT_CYAN}Full path:${NC} ${WHITE}$old_path${NC}"
    echo ""

    read -p "Enter new name: " new_name

    if [ -z "$new_name" ]; then
        echo -e "${RED}New name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Determine the new path
    local dir_parent="$(dirname "$old_path")"
    local new_path="$dir_parent/$new_name"

    if [ -e "$new_path" ]; then
        echo -e "${RED}A directory with that name already exists${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_YELLOW}Rename:${NC}"
    echo -e "  From: ${WHITE}$old_path${NC}"
    echo -e "  To:   ${WHITE}$new_path${NC}"
    echo ""
    read -p "Confirm rename? (y/n): " -n 1 confirm
    echo ""

    if [[ $confirm =~ ^[Yy]$ ]]; then
        mv "$old_path" "$new_path"
        if [ $? -eq 0 ]; then
            echo ""
            echo -e "${BRIGHT_GREEN}✓ Directory renamed successfully${NC}"
            echo -e "${BRIGHT_CYAN}New location:${NC} ${WHITE}$new_path${NC}"
        else
            echo ""
            echo -e "${BRIGHT_RED}✗ Failed to rename directory${NC}"
        fi
    else
        echo ""
        echo -e "${YELLOW}Cancelled${NC}"
    fi

    echo ""
    read -p "Press Enter to continue..."
}

#=============================================================================
# MAIN EXECUTION
#=============================================================================

main_menu
