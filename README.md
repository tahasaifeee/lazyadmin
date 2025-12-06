# LazyAdmin

A fast and lightweight terminal UI (TUI) for Linux system administration, built with Bash and Dialog/Whiptail. LazyAdmin provides an intuitive, menu-driven interface for managing your Linux system without needing to remember complex commands.

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
- **Fast & Lightweight**: Instant startup, minimal resource usage
- **No Compilation Required**: Just bash scripts
- **Easy Navigation**: Menu-driven interface using arrow keys

## Screenshots

The interface features:
- Clean dialog-based menus
- Hierarchical navigation (Main Menu → Submenus → Actions)
- Two main sections:
  - **System Information**: System Info, Services, Processes, Disk Usage
  - **User & Group Management**: 8 different user/group operations
- Real-time data display
- Interactive prompts for user actions

## Installation

### One-Line Install (Fastest) ⚡

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

Or if you prefer `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

After installation, you can run `lazyadmin` from anywhere:

```bash
lazyadmin
```

### Quick Install (Alternative)

Clone the repository and run the installation script:

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
sudo ./install.sh
```

### Using Makefile

Alternatively, you can use the Makefile:

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
sudo make install
```

### Manual Installation

If you prefer to install manually:

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
chmod +x lazyadmin.sh
sudo install -m 755 lazyadmin.sh /usr/local/bin/lazyadmin
```

### Requirements

- Bash 4.0 or later
- `dialog` or `whiptail` (auto-installed if missing)
- Linux operating system
- systemd (for service management)
- Root/sudo privileges for system modifications

## Updating LazyAdmin

### One-Line Update (Fastest) ⚡

Update to the latest version with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/update.sh | sudo bash
```

Or with `wget`:

```bash
wget -qO- https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/update.sh | sudo bash
```

### Alternative Update Methods

**If you cloned the repository:**

```bash
cd lazyadmin
sudo make update
```

Or manually:

```bash
cd lazyadmin
git pull
sudo ./install.sh
```

## Uninstalling

To remove LazyAdmin from your system:

```bash
sudo make uninstall
```

Or manually:

```bash
sudo rm /usr/local/bin/lazyadmin
```

## Usage

Once installed, simply run:

```bash
lazyadmin
```

Run with sudo for full access to all features:

```bash
sudo lazyadmin
```

### Navigation

- Use **arrow keys** (↑ ↓) to navigate menus
- Press **Enter** to select an option
- Press **Esc** or select "Back" to return to previous menu
- Select **"Exit"** or **"0"** to quit the application

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
│   ├── [a] List Users & Groups      - View all users/groups
│   ├── [b] Create User              - Add new user
│   ├── [c] Delete User              - Remove user
│   ├── [d] Add User to Group        - Add user to group
│   ├── [e] Remove User from Group   - Remove user from group
│   ├── [f] Set/Reset Password       - Change user password
│   ├── [g] Change User Shell        - Modify user's shell
│   └── [h] Lock/Unlock User         - Lock/unlock account
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

## Why LazyAdmin?

Managing Linux systems requires remembering numerous commands and their options. LazyAdmin provides:

1. **No Learning Curve**: Menu-driven interface, no need to remember commands
2. **Fast & Responsive**: Pure bash with instant startup
3. **Lightweight**: Minimal dependencies, runs anywhere
4. **Complete Control**: All essential system administration tasks in one place
5. **Safe Operations**: Interactive prompts before destructive actions
6. **Universal**: Works on any Linux distribution with bash and dialog/whiptail

## Performance Benefits

**Compared to the previous Go version:**
- ✅ **Instant Startup**: No compilation or runtime overhead
- ✅ **Lower Memory Usage**: Pure bash uses minimal resources
- ✅ **Smaller Footprint**: Single bash script vs compiled binary
- ✅ **No Build Dependencies**: No need for Go toolchain
- ✅ **Faster Menu Navigation**: Direct dialog/whiptail rendering

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

## License

See the LICENSE file for details.

## Acknowledgments

- Inspired by [Lazygit](https://github.com/jesseduffield/lazygit)
- Built with standard Linux tools: bash, dialog/whiptail
- Designed for system administrators who value simplicity and speed
