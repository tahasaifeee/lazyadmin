# LazyAdmin

A fast and lightweight terminal UI for Linux system administration built entirely in pure Bash. LazyAdmin simplifies complex system tasks through an intuitive, menu-driven interface with single-keypress navigation—no commands to memorize, no steep learning curve.

## Features

- **Zero Dependencies**: Pure Bash with instant startup and minimal resource usage—no compiling, no installing extra tools
- **Single-Keypress Navigation**: Just press a number, no Enter needed—everything is intuitive and responsive
- **System Information**: Real-time system metrics (CPU, memory, uptime, hardware details, network interfaces)
- **Service Management**: Full systemd control—view, start, stop, restart, enable/disable services with status tracking
- **Process & Disk Monitoring**: View top memory-consuming processes and monitor disk usage across all mount points
- **User & Group Management**: Create, delete, and manage users; add/remove group memberships; set passwords; lock/unlock accounts
- **Package Management**: Universal support for apt, yum, and dnf—install, remove, search, upgrade, and manage packages with auto-detection
- **Network Tools**: Ping, traceroute, DNS lookup, port scanning, speed testing, DNS cache flushing, firewall rule viewing
- **Disk Management (LVM, RAID, ZFS)**: Create and manage advanced storage—physical volumes, volume groups, logical volumes, RAID arrays, ZFS pools, and filesystem operations
- **Mount Operations**: Mount/unmount with intelligent /etc/fstab management

## User Interface

The interface is organized into five main sections accessible from the menu:

1. **System Information** - System details, service management, process monitoring, disk usage
2. **User & Group Management** - User creation, deletion, group membership, password and shell management
3. **Disk Management** - LVM, RAID, ZFS, partitioning, filesystem operations, mount management
4. **Package Management** - Install, remove, search, and upgrade packages with auto-detection
5. **Network Tools** - Connectivity testing, DNS operations, port scanning, firewall management

Clean terminal-based menus with color coding, real-time data display, and interactive prompts guide you through every task—all without requiring a single command.

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

**Ports** - View listening ports with ss or netstat; test specific port connectivity with timeouts.

**Services** - Restart NetworkManager, systemd-networkd, or legacy networking services with status checking.

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
