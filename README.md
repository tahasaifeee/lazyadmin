# LazyAdmin

A beautiful terminal UI (TUI) for Linux system administration, built with Go, Bubble Tea, and Lip Gloss. Inspired by Lazygit, LazyAdmin provides an intuitive, keyboard-driven interface for managing your Linux system.

## Features

- **System Information Panel**: View real-time system metrics including CPU usage, memory usage, uptime, and OS details
- **Services Panel**: Browse and monitor systemd services with their current status
- **Processes Panel**: View running processes sorted by CPU usage with detailed statistics
- **Disk Usage Panel**: Monitor disk usage across all mount points with visual progress bars
- **Beautiful UI**: Styled with Lip Gloss for a modern, colorful terminal experience
- **Keyboard Navigation**: Vim-style keybindings (hjkl) and arrow keys
- **Real-time Updates**: Data refreshes automatically every 2 seconds

## Screenshots

The interface features:
- Split-panel layout with a sidebar menu and main content area
- Color-coded status indicators (green for running, red for stopped)
- Progress bars for CPU, memory, and disk usage
- Interactive help menu
- Status bar with keyboard shortcuts

## Installation

### One-Line Install (Fastest) ⚡

**If you already have Go installed:**

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

**If you DON'T have Go installed (installs Go automatically):**

```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install-with-go.sh | sudo bash
```

Or if you prefer `wget`:

```bash
# With Go already installed
wget -qO- https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash

# Without Go (auto-installs Go)
wget -qO- https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install-with-go.sh | sudo bash
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
go build -o lazyadmin
sudo install -m 755 lazyadmin /usr/local/bin/lazyadmin
```

### Requirements

- Go 1.16 or later
- Linux operating system
- systemd (for services panel)
- Root privileges recommended for full functionality

## Updating LazyAdmin

To update to the latest version:

```bash
cd lazyadmin
sudo make update
```

Or simply run the install script again:

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

Or run with sudo for full access to system information:

```bash
sudo lazyadmin
```

### Command Line Options

```bash
lazyadmin [options]

Options:
  -v, --version    Print version information
  -h, --help       Show help message
```

### Keyboard Shortcuts

#### General
- `q` or `Ctrl+C`: Quit application
- `?`: Toggle help menu

#### Navigation
- `1`, `2`, `3`, `4`: Jump to specific panel (System Info, Services, Processes, Disk Usage)
- `Tab`: Switch to next panel
- `↑`/`k`: Move selection up (in lists)
- `↓`/`j`: Move selection down (in lists)

### Panels

#### 1. System Information (⚙)
Displays:
- Hostname, OS, Platform, Kernel Version
- System Uptime
- CPU Model, Cores, and Usage (with progress bar)
- Memory Total, Used, and Usage percentage (with progress bar)

#### 2. Services (🔧)
Shows all systemd services with:
- Service name
- Current status (active/inactive)
- Visual status indicators (● for running, ○ for stopped)
- Scrollable list with selection

#### 3. Processes (⚡)
Displays top 100 processes by CPU usage:
- Process ID (PID)
- Process Name
- CPU Usage (%) - color-coded based on usage level
- Memory Usage (%)
- Process Status
- Sortable and scrollable list

#### 4. Disk Usage (💾)
Shows disk information for all mount points:
- Mount point and filesystem type
- Used/Total/Free space
- Usage percentage with visual progress bar
- Color-coded bars (green < 60%, orange < 80%, red >= 80%)

## Architecture

```
lazyadmin/
├── main.go              # Application entry point
├── ui/
│   ├── model.go        # Main Bubble Tea model & application logic
│   └── panels/         # Individual panel implementations
│       ├── system.go   # System information panel
│       ├── services.go # Services management panel
│       ├── processes.go# Process monitoring panel
│       └── disk.go     # Disk usage panel
├── styles/
│   └── styles.go       # Lip Gloss styling definitions
└── utils/
    └── system.go       # System information utilities
```

## Technologies Used

- **[Go](https://golang.org/)**: Programming language
- **[Bubble Tea](https://github.com/charmbracelet/bubbletea)**: TUI framework
- **[Lip Gloss](https://github.com/charmbracelet/lipgloss)**: Style definitions for terminal output
- **[gopsutil](https://github.com/shirou/gopsutil)**: Cross-platform library for system and process utilities

## Why LazyAdmin?

Managing Linux systems often requires remembering numerous commands and switching between multiple terminal windows. LazyAdmin provides:

1. **Visual Overview**: See all important system metrics at a glance
2. **Easy Navigation**: Switch between different system aspects with simple keystrokes
3. **Real-time Monitoring**: Automatic updates keep you informed
4. **Beautiful Interface**: Terminal UIs don't have to be ugly!
5. **Keyboard-Driven**: Fast navigation without touching the mouse

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests.

## License

See the LICENSE file for details.

## Acknowledgments

- Inspired by [Lazygit](https://github.com/jesseduffield/lazygit)
- Built with [Charm](https://charm.sh/) tools (Bubble Tea, Lip Gloss)
- System information powered by [gopsutil](https://github.com/shirou/gopsutil)
