# LazyAdmin

A fast and lightweight terminal UI (TUI) for Linux system administration, built with pure Bash. LazyAdmin provides an intuitive, menu-driven interface with single-keypress navigation for managing your Linux system without needing to remember complex commands.

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
  - Update package lists
  - Install and remove packages
  - Upgrade entire system
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
  - View firewall rules (nftables/iptables/firewalld/ufw)
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
- Five main sections:
  - **System Information**: System Info, Services, Processes, Disk Usage
  - **User & Group Management**: 8 different user/group operations
  - **Disk Management**: LVM, RAID, ZFS, Partitioning, Filesystems, Mount operations
  - **Package Management**: 7 package operations with auto-detection (apt/yum/dnf)
  - **Network Tools**: 9 networking utilities for diagnostics and configuration
- Real-time data display
- Interactive prompts for user actions
- No commands required - everything through menus

## Installation

### One-Line Install ⚡

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

After installation, run from anywhere:

```bash
lazyadmin
```

**Requirements:**
- Bash 4.0+
- systemd (for service management)
- No external dependencies - pure bash!

## Updating LazyAdmin

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/update.sh | sudo bash
```

## Uninstalling

```bash
sudo rm /usr/local/bin/lazyadmin
```

## Usage

```bash
lazyadmin
```

**Navigation:**
- **Just press the number key** (e.g., press `1`, `2`, `3`) - option executes instantly!
- **No Enter key needed** - single keypress navigation
- **Press `0`** to go back or exit current menu
- Simple, clean terminal menus with color coding

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
│   ├── [2] Install a Package        - Install new software
│   ├── [3] Remove a Package         - Uninstall software
│   ├── [4] Upgrade System           - Update all packages
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
│   └── [9] View Firewall Rules      - Display firewall configuration (nftables/iptables/firewalld/ufw)
│
└── [0] Exit
```

## Features in Detail

### System Information Panel

Displays comprehensive system information:
- Hostname, OS, Kernel version
- System uptime and load average
- CPU model, cores, architecture
- Memory usage (total, used, free)
- Network interfaces and IP addresses

### Service Management

Full systemd service control:
- View all services (running, stopped, enabled, disabled)
- Start/stop/restart services
- Enable/disable services for boot
- View detailed service status
- Real-time status updates

### Process Monitoring

View top 20 processes by memory usage:
- Process name and owner
- CPU and memory percentage
- Quick overview of system resource usage

### Disk Usage

Monitor all disk partitions:
- Filesystem and mount point
- Total, used, and available space
- Usage percentage
- Support for all filesystem types

### User & Group Management

Complete user administration:
- List all users (UID >= 1000) and groups
- Create new users with home directories
- Delete users (with option to remove home)
- Manage group memberships
- Set and reset passwords
- Change user shells (bash, zsh, sh, fish, custom)
- Lock/unlock user accounts

### Disk Management

Comprehensive disk and storage management:

**LVM (Logical Volume Management):**
- View Physical Volumes, Volume Groups, Logical Volumes
- Create PV, VG, LV with guided prompts
- Extend logical volumes and resize filesystems
- Remove LVs and VGs safely

**RAID Management (mdadm):**
- View RAID arrays and status
- Create RAID 0, 1, 5, 6, 10 arrays
- Add/remove disks from arrays
- Stop, assemble, and check RAID status

**ZFS Management:**
- Create and manage ZFS pools
- Create datasets and snapshots
- Rollback to snapshots
- View pool status

**Disk Partitioning:**
- Interactive fdisk and parted support
- List partitions and block devices
- Safe partition table editing

**Filesystem Operations:**
- Create filesystems (ext4, ext3, xfs, btrfs, vfat, ntfs)
- Check and repair filesystems (fsck)
- Resize filesystems (resize2fs, xfs_growfs)
- Tune filesystem parameters
- Set filesystem labels

**Mount/Unmount Operations:**
- View mounted filesystems
- Mount/unmount with guided prompts
- Auto-create mount points
- Edit and view /etc/fstab safely

### Network Tools

Complete networking diagnostic and configuration toolkit:

**Connectivity Testing:**
- Ping with customizable packet count for connectivity testing
- Traceroute for network path analysis and troubleshooting
- Test specific ports using nc/telnet/bash TCP features

**DNS Operations:**
- DNS lookup using dig, nslookup, or host commands
- Flush DNS cache (auto-detects systemd-resolved, dnsmasq, or nscd)
- DHCP renewal when applicable

**Port and Network Information:**
- View all open/listening ports using ss or netstat
- Display active connections and services
- Test specific port connectivity with timeout

**Network Services:**
- Restart NetworkManager, systemd-networkd, or legacy networking services
- Support for various network service implementations across distributions
- Service status checking before restart

**Firewall Management:**
- View firewall rules from nftables, iptables, firewalld, or ufw
- Display both filter and NAT tables for iptables
- Comprehensive ruleset display

**Performance Testing:**
- Network speed test using speedtest-cli
- Optional installation of speedtest-cli if not present
- Download and upload speed measurements

## Why LazyAdmin?

Managing Linux systems requires remembering numerous commands and their options. LazyAdmin provides:

1. **No Learning Curve**: Menu-driven interface, no need to remember commands
2. **Fast & Responsive**: Pure bash with instant startup
3. **Lightweight**: Zero dependencies, runs anywhere with Bash 4.0+
4. **Complete Control**: All essential system administration tasks in one place
5. **Safe Operations**: Interactive prompts before destructive actions
6. **Universal**: Works on any Linux distribution with Bash 4.0+

## Performance Benefits

**Compared to the previous Go version:**
- ✅ **Instant Startup**: No compilation or runtime overhead
- ✅ **Lower Memory Usage**: Pure bash uses minimal resources
- ✅ **Smaller Footprint**: Single bash script vs compiled binary
- ✅ **No Build Dependencies**: No need for Go toolchain
- ✅ **Zero External Dependencies**: No dialog, whiptail, or other tools required

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

## License

See the LICENSE file for details.

## Acknowledgments

- Inspired by [Lazygit](https://github.com/jesseduffield/lazygit)
- Built with pure Bash - no external dependencies
- Designed for system administrators who value simplicity and speed
