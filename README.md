# LazyAdmin

A fast and lightweight terminal UI for Linux system administration built entirely in pure Bash. LazyAdmin simplifies complex system tasks through an intuitive, menu-driven interface with single-keypress navigation—no commands to memorize, no steep learning curve.

## Features

- **Pure Bash Implementation**: No external language dependencies, instant startup
- **System Information**: View real-time system metrics including CPU, memory, uptime, and hardware details
- **Service Management**: Complete control over systemd services
  - View all services with their current status
  - Start, stop, restart services
  - Enable/disable services for boot
  - View detailed service status
- **Process Monitoring**: View top processes sorted by memory usage
- **Disk Usage**: Monitor disk usage across all mount points
- **User & Group Management**: Comprehensive user and group administration
  - List all users and groups
  - Create and delete users
  - Add/remove users from groups
  - Set passwords
  - Change user shells
  - Lock/unlock user accounts
- **Package Management**: Universal package manager support (apt/yum/dnf)
  - Intelligent package search with numbered selection
  - Install and remove packages
  - Upgrade system (all or specific packages)
  - Search for packages
  - List installed packages
  - Clean package cache
- **Network Tools**: Comprehensive networking utilities
  - Ping test with customizable packet count
  - Traceroute for network path analysis
  - DNS lookup (dig/nslookup/host)
  - Check open ports (ss/netstat)
  - Test specific port connectivity
  - Network speed test (speedtest-cli)
  - Flush DNS cache (systemd-resolved/dnsmasq/nscd)
  - Restart network services
  - Create virtual interfaces (VLAN, Alias, Bridge, Dummy)
  - Create network bonds (all bonding modes)
- **File Management**: Easy directory and filesystem navigation
  - Interactive directory browser with numbered navigation
  - View directory sizes with detailed breakdown
  - Create directories with permission control
  - Delete directories with safety confirmations
  - Rename directories
- **Firewall & Security**: Comprehensive security management
  - Enable/disable firewall (ufw/firewalld)
  - Add and remove firewall rules
  - Fail2ban status and management
  - SSH hardening (port change, disable root login)
  - View authentication logs
  - Brute force detection and scanning
  - Active connections monitoring
  - Malware and rootkit scanning
- **Disk Management (LVM, RAID, ZFS)**: Complete storage administration
  - **LVM**: Create/manage Physical Volumes, Volume Groups, Logical Volumes
  - **RAID**: Configure and manage mdadm RAID arrays (0, 1, 5, 6, 10)
  - **ZFS**: Manage ZFS pools, datasets, and snapshots
  - **Partitioning**: Interactive fdisk/parted disk partitioning
  - **Filesystems**: Create, check, resize, and manage filesystems
  - **Mount Operations**: Mount/unmount with /etc/fstab management
- **Fast & Lightweight**: Instant startup, minimal resource usage
- **No Compilation Required**: Just bash scripts
- **Easy Navigation**: Single-keypress navigation - just press a number, no Enter needed!
- **No External Dependencies**: Pure bash with no dialog/whiptail required

## Screenshots

The interface features:
- Clean terminal-based menus with color coding
- Single-keypress navigation (no Enter needed!)
- Seven main sections:
  - **System Information**: System Info, Services, Processes, Disk Usage
  - **User & Group Management**: 8 different user/group operations
  - **Disk Management**: LVM, RAID, ZFS, Partitioning, Filesystems, Mount operations
  - **Package Management**: 7 package operations with intelligent search
  - **Network Tools**: 10 networking utilities including virtual interfaces and bonding
  - **File Management**: 5 directory operations for easy filesystem navigation
  - **Firewall & Security**: 9 security tools for system protection
- Real-time data display
- Interactive prompts for user actions
- No commands required - everything through menus

## Installation

### Requirements

- **Bash 4.0+** (standard on all modern Linux systems)
- **systemd** (for service management features)
- No other dependencies—everything is built-in!

### Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

Then run from anywhere:

```bash
lazyadmin
```

### Update & Uninstall

```bash
# Update to latest version
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/update.sh | sudo bash

# Uninstall
sudo rm /usr/local/bin/lazyadmin
```

## Usage

**Launch LazyAdmin:**
```bash
lazyadmin
```

**Navigation Rules:**
- **Press a number** (1, 2, 3, etc.) to select an option—it executes instantly
- **Press 0** to go back or exit the current menu
- **No Enter key needed**—everything responds to single keypresses
- Color-coded menus help guide your selection

### Main Menu Structure

```
LazyAdmin Main Menu
├── [1] System Information
│   ├── [1] System Info      - View system summary and hardware
│   ├── [2] Services         - Manage systemd services
│   ├── [3] Processes        - View running processes
│   └── [4] Disk Usage       - Monitor disk space
│
├── [2] User & Group Management
│   ├── [1] List Users & Groups      - View all users/groups
│   ├── [2] Create User              - Add new user
│   ├── [3] Delete User              - Remove user
│   ├── [4] Add User to Group        - Add user to group
│   ├── [5] Remove User from Group   - Remove user from group
│   ├── [6] Set/Reset Password       - Change user password
│   ├── [7] Change User Shell        - Modify user's shell
│   └── [8] Lock/Unlock User         - Lock/unlock account
│
├── [3] Disk Management (LVM, RAID, ZFS)
│   ├── [1] LVM Management           - Physical Volumes, Volume Groups, Logical Volumes
│   ├── [2] RAID Management          - Create/manage mdadm RAID arrays
│   ├── [3] ZFS Management           - Pools, datasets, snapshots
│   ├── [4] Disk Partitioning        - fdisk, parted, lsblk
│   ├── [5] Filesystem Operations    - Create, check, resize filesystems
│   ├── [6] Mount/Unmount            - Mount operations, /etc/fstab
│   └── [7] View Disk Information    - Comprehensive disk overview
│
├── [4] Package Management (apt/yum/dnf)
│   ├── [1] Update Package Lists     - Refresh available packages
│   ├── [2] Install a Package        - Search and install with numbered selection
│   ├── [3] Remove a Package         - Search and remove with numbered selection
│   ├── [4] Upgrade System           - Upgrade all or specific packages
│   ├── [5] Search Package           - Find packages by name
│   ├── [6] List Installed Packages  - Show installed software
│   └── [7] Clean Package Cache      - Free up disk space
│
├── [5] Network Tools
│   ├── [1] Ping Test                - Test connectivity with customizable packet count
│   ├── [2] Traceroute               - Trace network path to destination
│   ├── [3] DNS Lookup               - Resolve domain names (dig/nslookup/host)
│   ├── [4] Check Open Ports         - View listening ports (ss/netstat)
│   ├── [5] Test Specific Port       - Check if a port is open (nc/telnet/bash)
│   ├── [6] Network Speed Test       - Test download/upload speeds (speedtest-cli)
│   ├── [7] Flush DNS Cache          - Clear DNS cache (systemd-resolved/dnsmasq/nscd)
│   ├── [8] Restart Network Service  - Restart NetworkManager/systemd-networkd/networking
│   ├── [9] Create Virtual Interface - Create VLAN, Alias, Bridge, or Dummy interfaces
│   └── [10] Create Network Bond     - Bond interfaces with all bonding modes
│
├── [6] File Management
│   ├── [1] Navigate Directories     - Browse filesystem with numbered selection
│   ├── [2] Show Directory Sizes     - View disk usage with sort options
│   ├── [3] Create Directory         - Create directories with permission control
│   ├── [4] Delete Directory         - Remove directories with safety checks
│   └── [5] Rename Directory         - Rename existing directories
│
├── [7] Firewall & Security
│   ├── [1] Enable/Disable Firewall  - Toggle firewall status
│   ├── [2] Add Firewall Rule        - Create new firewall rule
│   ├── [3] Remove Firewall Rule     - Delete existing rule
│   ├── [4] Fail2ban Status          - View and manage fail2ban
│   ├── [5] SSH Hardening            - Quick security configurations
│   ├── [6] View Auth Logs           - Check authentication logs
│   ├── [7] Brute Force Scan         - Detect attack attempts
│   ├── [8] Active Connections       - Monitor network connections
│   └── [9] Malware Scan             - Rootkit and malware detection
│
└── [0] Exit
```

## Features in Detail

### System Information & Monitoring

**System Info** displays hostname, OS, kernel version, uptime, load average, CPU model, cores, architecture, memory usage, and network interfaces with IP addresses.

**Service Management** gives you full systemd control—view services by status (running/stopped, enabled/disabled), start/stop/restart services, enable/disable boot startup, and check detailed service status in real-time.

**Process Monitoring** shows the top 20 memory-consuming processes with their owner, CPU, and memory usage percentages for quick resource assessment.

**Disk Usage** monitors all partitions with filesystem info, mount points, total/used/available space, and usage percentages across all filesystem types.

### User & Group Management

Create and delete users with home directories, manage group memberships, set/reset passwords, change shells (bash, zsh, sh, fish, or custom), and lock/unlock accounts. View all users and groups with UID filtering for easy identification.

### Disk Management

**LVM** - Create and manage Physical Volumes, Volume Groups, and Logical Volumes; extend volumes and resize filesystems safely.

**RAID** - Create RAID 0/1/5/6/10 arrays with mdadm; add/remove disks, assemble, stop, and check array status.

**ZFS** - Create and manage pools, datasets, and snapshots; rollback to previous states and view pool status.

**Partitioning** - Interactive fdisk and parted support with partition and block device listing.

**Filesystems** - Create ext4/ext3/xfs/btrfs/vfat/ntfs filesystems; check/repair with fsck; resize with resize2fs/xfs_growfs; tune parameters and set labels.

**Mount/Unmount** - View mounted filesystems, mount/unmount with guided prompts, auto-create mount points, and safely edit /etc/fstab.

### Network Tools

**Connectivity** - Ping (customizable packet count), traceroute for path analysis, and port testing via nc/telnet/bash.

**DNS** - Lookup via dig/nslookup/host; flush cache (auto-detects systemd-resolved, dnsmasq, or nscd).

**Virtual Networking:**
- Create virtual interfaces: VLAN (802.1Q), Alias, Bridge, Dummy
- Network bonding with all 7 bonding modes (balance-rr, active-backup, balance-xor, broadcast, 802.3ad/LACP, balance-tlb, balance-alb)
- Multi-interface selection for bonding
- Automatic IP configuration and interface management

### File Management

Easy and intuitive directory navigation and management:

**Interactive Directory Browser:**
- Navigate filesystem with numbered selection
- Browse directories and view files
- Quick navigation options: parent directory, manual path entry, home directory
- Display file sizes and types
- Support for both directories and files

**Directory Size Analysis:**
- View sizes of all subdirectories
- Sort by size or name
- Detailed breakdown of large directories
- Recursive size calculation with du
- Human-readable size display

**Directory Operations:**
- Create directories with optional parent directory creation (mkdir -p)
- Set custom permissions during creation
- Delete directories with safety confirmations
- Empty directory detection with simple confirmation
- Non-empty directories require typing 'DELETE' to confirm
- Rename directories with path validation
- Real-time feedback and error handling

### Firewall & Security

Comprehensive security management and system hardening:

**Firewall Management:**
- Enable/disable firewall with support for ufw, firewalld, and iptables
- Add firewall rules with port, protocol (TCP/UDP), and action (allow/deny) configuration
- Remove firewall rules with numbered selection (ufw) or port specification (firewalld)
- View current firewall status and rules
- Reload firewall configurations

**Fail2ban Integration:**
- Check fail2ban service status and jail configurations
- View currently banned IPs and total ban counts per jail
- Unban specific IP addresses from jails
- Install and configure fail2ban if not present
- Monitor SSH, Apache, and other service protections

**SSH Hardening:**
- Change SSH port from default 22 to custom port (1024-65535)
- Disable root login for enhanced security
- Disable password authentication (enforce key-only access)
- Add idle timeout to disconnect inactive sessions
- Apply all hardening measures at once
- Automatic configuration backup before changes
- Configuration validation before service restart

**Authentication Monitoring:**
- View recent failed login attempts
- Monitor successful SSH logins (password and key-based)
- Track all SSH connection attempts
- Review sudo command history
- Display last 50 authentication events
- Support for both /var/log/auth.log and /var/log/secure

**Brute Force Detection:**
- Analyze failed SSH login attempts by IP address
- Identify high-risk IPs with multiple failed attempts
- Detect distributed brute force attacks
- Display statistics (total attempts, unique IPs)
- Show top failed usernames targeted
- Provide security recommendations

**Connection Monitoring:**
- View all active network connections
- Filter established connections only
- Display listening ports and services
- Monitor SSH connections specifically
- Show connections grouped by IP address
- Support for both ss and netstat commands

**Malware & Rootkit Scanning:**
- Quick rootkit scan with chkrootkit
- Comprehensive scan with rkhunter (with automatic updates)
- Check for suspicious files modified in last 24 hours
- Detect SUID/SGID files that could be exploited
- List running processes and check for hidden processes
- Auto-install scanning tools if not present
- Display scan results with warnings and recommendations

### Package Management

**Intelligent Search and Selection:**
- Search for packages by keyword (e.g., "apache", "python")
- Display up to 20 matching packages with numbered selection
- Install packages by selecting from search results
- Remove packages with search and numbered selection
- Upgrade all packages or search for specific package to upgrade
- Support for apt, dnf, and yum package managers
- Non-interactive mode with automatic yes (-y flag)

## Why LazyAdmin?

**Firewall** - View rules from nftables, iptables (filter/NAT), firewalld, or ufw.

**Speed Test** - Network speed testing with speedtest-cli (optional installation if not present).

## Why LazyAdmin?

Managing Linux systems typically requires memorizing dozens of commands and their options. LazyAdmin eliminates that friction:

- **No Learning Curve** - Menu-driven interface with no commands to memorize
- **Fast & Responsive** - Pure Bash with instant startup and no runtime overhead
- **Lightweight & Portable** - Single script with zero dependencies; works anywhere Bash 4.0+ runs
- **Complete Control** - All essential system admin tasks accessible from one interface
- **Safe by Default** - Interactive prompts protect against accidental destructive actions
- **Universal** - Works across all Linux distributions without additional setup

## Contributing

Found a bug or have a feature request? Contributions are welcome! Submit issues or pull requests on GitHub.

## License

See the LICENSE file for details.

## Acknowledgments

- Inspired by [Lazygit](https://github.com/jesseduffield/lazygit) for its elegant, keyboard-driven interface
- Built entirely in pure Bash with zero external dependencies
- Designed for system administrators who prioritize simplicity, speed, and productivity
