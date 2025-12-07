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

    echo -e "${BRIGHT_YELLOW}┌─ Existing Users ─────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-15s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%-6s'"${NC}"' Shell:'"${WHITE}"'%s'"${NC}"'\n", $1, $3, $7}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter username to delete: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    # Check if user exists
    if ! id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' does not exist${NC}"
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

    echo -e "${BRIGHT_YELLOW}┌─ Existing Users ─────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-20s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%s'"${NC}"'\n", $1, $3}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_BLUE}┌─ Available Groups ───────────────────────────────────────────┐${NC}"
    echo -n "  ${WHITE}"
    cut -d: -f1 /etc/group | head -n 20 | column
    echo -e "${NC}  ${DIM}(showing first 20 groups)${NC}"
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter group name: " groupname

    if [ -z "$groupname" ]; then
        echo -e "${RED}Group name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! getent group "$groupname" &>/dev/null; then
        echo -e "${RED}Group '$groupname' does not exist${NC}"
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

    echo -e "${BRIGHT_YELLOW}┌─ Existing Users ─────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-20s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%s'"${NC}"'\n", $1, $3}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    echo -e "${BRIGHT_BLUE}┌─ Available Groups ───────────────────────────────────────────┐${NC}"
    echo -n "  ${WHITE}"
    cut -d: -f1 /etc/group | head -n 20 | column
    echo -e "${NC}  ${DIM}(showing first 20 groups)${NC}"
    echo -e "${BRIGHT_BLUE}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    read -p "Enter group name: " groupname

    if [ -z "$groupname" ]; then
        echo -e "${RED}Group name cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! getent group "$groupname" &>/dev/null; then
        echo -e "${RED}Group '$groupname' does not exist${NC}"
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

    echo -e "${BRIGHT_YELLOW}┌─ Existing Users ─────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-20s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%s'"${NC}"'\n", $1, $3}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

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

    echo -e "${BRIGHT_YELLOW}┌─ Existing Users ─────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-20s'"${NC}"' Current Shell:'"${WHITE}"'%s'"${NC}"'\n", $1, $7}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_BLUE}Available shells:${NC}"
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

    echo -e "${BRIGHT_YELLOW}┌─ Existing Users ─────────────────────────────────────────────┐${NC}"
    awk -F: '$3 >= 1000 {printf "  '"${BRIGHT_GREEN}"'%-20s'"${NC}"' UID:'"${BRIGHT_CYAN}"'%s'"${NC}"'\n", $1, $3}' /etc/passwd
    echo -e "${BRIGHT_YELLOW}└──────────────────────────────────────────────────────────────┘${NC}"
    echo ""

    read -p "Enter username: " username

    if [ -z "$username" ]; then
        echo -e "${RED}Username cannot be empty${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    if ! id "$username" &>/dev/null; then
        echo -e "${RED}User '$username' does not exist${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo ""
    echo -e "${BRIGHT_BLUE}Choose action:${NC}"
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
