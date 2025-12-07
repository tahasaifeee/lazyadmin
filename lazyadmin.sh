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
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${BRIGHT_BLUE}⚙${NC}  ${WHITE}System Information${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_YELLOW}👥${NC}  ${WHITE}User & Group Management${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${BRIGHT_PURPLE}💾${NC}  ${WHITE}Disk Management${NC} ${DIM}(LVM, RAID, ZFS)${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_CYAN}📦${NC}  ${WHITE}Package Management${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${BRIGHT_GREEN}🌐${NC}  ${WHITE}Network Tools${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${RED}✖${NC}  ${WHITE}Exit${NC}"
        echo ""
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC} ${BRIGHT_YELLOW}❯${NC} Press a number key to select                            ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"

        read -n 1 -s choice
        echo ""

        case $choice in
            1) system_info_menu ;;
            2) user_management_menu ;;
            3) disk_management_menu ;;
            4) package_management_menu ;;
            5) network_tools_menu ;;
            0) clear; exit 0 ;;
        esac
    done
}

# System Information menu
system_info_menu() {
    while true; do
        show_header
        echo -e "${BRIGHT_CYAN}╭─────────────────────────────────────────────────────────────╮${NC}"
        echo -e "${BRIGHT_CYAN}│${NC}  ${BRIGHT_BLUE}⚙  ${WHITE}${BOLD}SYSTEM INFORMATION${NC}                                     ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${BRIGHT_CYAN}📊${NC}  ${WHITE}System Info${NC}         ${DIM}- View system metrics & hardware${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_PURPLE}🔧${NC}  ${WHITE}Services${NC}            ${DIM}- Manage systemd services${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${BRIGHT_YELLOW}⚡${NC}  ${WHITE}Processes${NC}           ${DIM}- View running processes${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_BLUE}💿${NC}  ${WHITE}Disk Usage${NC}          ${DIM}- Monitor disk space${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${RED}←${NC}  ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "${BRIGHT_YELLOW}❯${NC} Press a number key: "

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
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${BRIGHT_CYAN}📋${NC}  ${WHITE}List Users & Groups${NC}      ${DIM}- View all users/groups${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_GREEN}➕${NC}  ${WHITE}Create User${NC}              ${DIM}- Add new user account${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${BRIGHT_RED}➖${NC}  ${WHITE}Delete User${NC}              ${DIM}- Remove user account${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_BLUE}👤${NC}  ${WHITE}Add User to Group${NC}        ${DIM}- Grant group membership${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${BRIGHT_YELLOW}👥${NC}  ${WHITE}Remove User from Group${NC}   ${DIM}- Revoke group membership${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${BRIGHT_PURPLE}🔑${NC}  ${WHITE}Set/Reset Password${NC}       ${DIM}- Change user password${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${BRIGHT_CYAN}🐚${NC}  ${WHITE}Change User Shell${NC}        ${DIM}- Modify login shell${NC}"
        echo -e "  ${BRIGHT_GREEN}[8]${NC} ${BRIGHT_RED}🔒${NC}  ${WHITE}Lock/Unlock User${NC}         ${DIM}- Toggle account lock${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${RED}←${NC}  ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "${BRIGHT_YELLOW}❯${NC} Press a number key: "

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
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${BRIGHT_BLUE}📊${NC}  ${WHITE}LVM Management${NC}           ${DIM}- Physical/Logical Volumes${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_YELLOW}⚡${NC}  ${WHITE}RAID Management${NC}          ${DIM}- mdadm RAID arrays${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${BRIGHT_CYAN}🗄${NC}  ${WHITE}ZFS Management${NC}           ${DIM}- Pools, datasets, snapshots${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_PURPLE}🔧${NC}  ${WHITE}Disk Partitioning${NC}        ${DIM}- fdisk, parted${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${BRIGHT_GREEN}💿${NC}  ${WHITE}Filesystem Operations${NC}    ${DIM}- Create, check, resize${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${BRIGHT_YELLOW}📌${NC}  ${WHITE}Mount/Unmount${NC}            ${DIM}- Mount operations${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${BRIGHT_CYAN}ℹ${NC}  ${WHITE}View Disk Information${NC}    ${DIM}- Comprehensive overview${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${RED}←${NC}  ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "${BRIGHT_YELLOW}❯${NC} Press a number key: "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) manage_lvm ;;
            2) manage_raid ;;
            3) echo "ZFS Management - Feature coming soon"; read -p "Press Enter to continue..." ;;
            4) echo "Disk Partitioning - Feature coming soon"; read -p "Press Enter to continue..." ;;
            5) echo "Filesystem Operations - Feature coming soon"; read -p "Press Enter to continue..." ;;
            6) echo "Mount/Unmount - Feature coming soon"; read -p "Press Enter to continue..." ;;
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
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${BRIGHT_BLUE}🔄${NC}  ${WHITE}Update Package Lists${NC}     ${DIM}- apt/yum/dnf update${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_GREEN}⬇${NC}  ${WHITE}Install a Package${NC}        ${DIM}- Install new software${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${BRIGHT_RED}🗑${NC}  ${WHITE}Remove a Package${NC}         ${DIM}- Uninstall software${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_YELLOW}⬆${NC}  ${WHITE}Upgrade System${NC}           ${DIM}- Update all packages${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${BRIGHT_PURPLE}🔍${NC}  ${WHITE}Search Package${NC}           ${DIM}- Find packages${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${BRIGHT_CYAN}📋${NC}  ${WHITE}List Installed Packages${NC}  ${DIM}- Show installed${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${BRIGHT_BLUE}🧹${NC}  ${WHITE}Clean Package Cache${NC}      ${DIM}- Free disk space${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${RED}←${NC}  ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "${BRIGHT_YELLOW}❯${NC} Press a number key: "

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
        echo -e "${BRIGHT_CYAN}│${NC}  ${BRIGHT_GREEN}🌐 ${WHITE}${BOLD}NETWORK TOOLS${NC}                                           ${BRIGHT_CYAN}│${NC}"
        echo -e "${BRIGHT_CYAN}╰─────────────────────────────────────────────────────────────╯${NC}"
        echo ""
        echo -e "  ${BRIGHT_GREEN}[1]${NC} ${BRIGHT_YELLOW}📡${NC}  ${WHITE}Ping Test${NC}                ${DIM}- Test connectivity${NC}"
        echo -e "  ${BRIGHT_GREEN}[2]${NC} ${BRIGHT_PURPLE}🗺${NC}  ${WHITE}Traceroute${NC}               ${DIM}- Trace network path${NC}"
        echo -e "  ${BRIGHT_GREEN}[3]${NC} ${BRIGHT_BLUE}🔍${NC}  ${WHITE}DNS Lookup${NC}               ${DIM}- Resolve domains${NC}"
        echo -e "  ${BRIGHT_GREEN}[4]${NC} ${BRIGHT_CYAN}🔌${NC}  ${WHITE}Check Open Ports${NC}         ${DIM}- View listening ports${NC}"
        echo -e "  ${BRIGHT_GREEN}[5]${NC} ${BRIGHT_GREEN}🎯${NC}  ${WHITE}Test Specific Port${NC}       ${DIM}- Check port status${NC}"
        echo -e "  ${BRIGHT_GREEN}[6]${NC} ${BRIGHT_YELLOW}⚡${NC}  ${WHITE}Network Speed Test${NC}       ${DIM}- Measure bandwidth${NC}"
        echo -e "  ${BRIGHT_GREEN}[7]${NC} ${BRIGHT_PURPLE}💧${NC}  ${WHITE}Flush DNS Cache${NC}          ${DIM}- Clear DNS cache${NC}"
        echo -e "  ${BRIGHT_GREEN}[8]${NC} ${BRIGHT_RED}🔄${NC}  ${WHITE}Restart Network Service${NC}  ${DIM}- Restart networking${NC}"
        echo -e "  ${BRIGHT_GREEN}[9]${NC} ${BRIGHT_BLUE}🛡${NC}  ${WHITE}View Firewall Rules${NC}      ${DIM}- Display firewall${NC}"
        echo ""
        echo -e "  ${BRIGHT_RED}[0]${NC} ${RED}←${NC}  ${WHITE}Back to Main Menu${NC}"
        echo ""
        echo -e "${DIM}${BRIGHT_CYAN}───────────────────────────────────────────────────────────────${NC}"
        echo -e "${BRIGHT_YELLOW}❯${NC} Press a number key: "

        read -n 1 -s choice
        echo ""

        case $choice in
            1) ping_test ;;
            2) traceroute_test ;;
            3) dns_lookup ;;
            4) check_open_ports ;;
            5) test_specific_port ;;
            6) network_speed_test ;;
            7) flush_dns_cache ;;
            8) restart_network_service ;;
            9) view_firewall_rules ;;
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
    echo -e "${CYAN}${BOLD}INSTALL PACKAGE${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    if [ "$PKG_MGR" == "none" ]; then
        echo -e "${RED}No supported package manager found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter package name to install: " package_name

    if [ -z "$package_name" ]; then
        echo -e "${RED}Package name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Running: sudo apt install $package_name${NC}"
            echo ""
            sudo apt install "$package_name"
            ;;
        dnf)
            echo -e "${GREEN}Running: sudo dnf install $package_name${NC}"
            echo ""
            sudo dnf install "$package_name"
            ;;
        yum)
            echo -e "${GREEN}Running: sudo yum install $package_name${NC}"
            echo ""
            sudo yum install "$package_name"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

remove_package() {
    clear
    echo -e "${CYAN}${BOLD}REMOVE PACKAGE${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    if [ "$PKG_MGR" == "none" ]; then
        echo -e "${RED}No supported package manager found${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter package name to remove: " package_name

    if [ -z "$package_name" ]; then
        echo -e "${RED}Package name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    read -p "Are you sure you want to remove $package_name? (y/n): " -n 1 confirm
    echo ""

    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Running: sudo apt remove $package_name${NC}"
            echo ""
            sudo apt remove "$package_name"
            ;;
        dnf)
            echo -e "${GREEN}Running: sudo dnf remove $package_name${NC}"
            echo ""
            sudo dnf remove "$package_name"
            ;;
        yum)
            echo -e "${GREEN}Running: sudo yum remove $package_name${NC}"
            echo ""
            sudo yum remove "$package_name"
            ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
}

upgrade_system() {
    clear
    echo -e "${CYAN}${BOLD}UPGRADE SYSTEM${NC}"
    echo ""

    PKG_MGR=$(detect_package_manager)

    case $PKG_MGR in
        apt)
            echo -e "${GREEN}Running: sudo apt update && sudo apt upgrade${NC}"
            echo ""
            sudo apt update && sudo apt upgrade
            ;;
        dnf)
            echo -e "${GREEN}Running: sudo dnf upgrade${NC}"
            echo ""
            sudo dnf upgrade
            ;;
        yum)
            echo -e "${GREEN}Running: sudo yum update${NC}"
            echo ""
            sudo yum update
            ;;
        *)
            echo -e "${RED}No supported package manager found${NC}"
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

#=============================================================================
# MAIN EXECUTION
#=============================================================================

main_menu
