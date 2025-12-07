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
        echo -e "  ${GREEN}[4]${NC} Package Management"
        echo -e "  ${GREEN}[5]${NC} Network Tools"
        echo -e "  ${RED}[0]${NC} Exit"
        echo ""
        echo -e "${YELLOW}Press a number key to select:${NC} "

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

# Package Management menu
package_management_menu() {
    while true; do
        show_header
        echo -e "${CYAN}${BOLD}PACKAGE MANAGEMENT${NC}"
        echo ""
        echo -e "  ${GREEN}[1]${NC} Update Package Lists (apt/yum/dnf update)"
        echo -e "  ${GREEN}[2]${NC} Install a Package"
        echo -e "  ${GREEN}[3]${NC} Remove a Package"
        echo -e "  ${GREEN}[4]${NC} Upgrade System"
        echo -e "  ${GREEN}[5]${NC} Search Package"
        echo -e "  ${GREEN}[6]${NC} List Installed Packages"
        echo -e "  ${GREEN}[7]${NC} Clean Package Cache"
        echo -e "  ${RED}[0]${NC} Back to Main Menu"
        echo ""
        echo -e "${YELLOW}Press a number key:${NC} "

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
        echo -e "${CYAN}${BOLD}NETWORK TOOLS${NC}"
        echo ""
        echo -e "  ${GREEN}[1]${NC} Ping Test"
        echo -e "  ${GREEN}[2]${NC} Traceroute"
        echo -e "  ${GREEN}[3]${NC} DNS Lookup (dig/nslookup)"
        echo -e "  ${GREEN}[4]${NC} Check Open Ports (netstat/ss)"
        echo -e "  ${GREEN}[5]${NC} Test Specific Port (nc)"
        echo -e "  ${GREEN}[6]${NC} Network Speed Test"
        echo -e "  ${GREEN}[7]${NC} Flush DNS Cache"
        echo -e "  ${GREEN}[8]${NC} Restart Network Service"
        echo -e "  ${GREEN}[9]${NC} View Firewall Rules"
        echo -e "  ${RED}[0]${NC} Back to Main Menu"
        echo ""
        echo -e "${YELLOW}Press a number key:${NC} "

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
