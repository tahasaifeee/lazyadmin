# LazyAdmin Quick Start Guide

This guide will help you quickly install and start using LazyAdmin on your Linux system.

## Installation (3 Simple Steps)

### Step 1: Clone the Repository

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
```

### Step 2: Install LazyAdmin

**Option A: Using the installation script (Recommended)**
```bash
sudo ./install.sh
```

**Option B: Using Make**
```bash
sudo make install
```

### Step 3: Run LazyAdmin

```bash
lazyadmin
```

That's it! LazyAdmin is now installed and running on your system.

## First Time Usage

When you first run LazyAdmin, you'll see four main panels:

1. **System Info (Press 1)**: View CPU, memory, and system details
2. **Services (Press 2)**: Monitor systemd services
3. **Processes (Press 3)**: View running processes
4. **Disk Usage (Press 4)**: Check disk usage across mount points

### Essential Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `1-4` | Jump to specific panel |
| `Tab` | Switch to next panel |
| `↑/k` | Move selection up |
| `↓/j` | Move selection down |
| `?` | Show/hide help menu |
| `q` or `Ctrl+C` | Quit |

## Updating LazyAdmin

When you want to update to the latest version:

```bash
cd lazyadmin
sudo make update
```

Or:

```bash
cd lazyadmin
git pull
sudo ./install.sh
```

## Troubleshooting

### "Permission denied" errors
Make sure to run with sudo for full functionality:
```bash
sudo lazyadmin
```

### "command not found: lazyadmin"
The installation might have failed. Try:
```bash
cd lazyadmin
sudo make install
```

### Services panel is empty
Make sure systemd is running on your system:
```bash
systemctl status
```

## Uninstalling

If you need to remove LazyAdmin:

```bash
sudo make uninstall
```

Or manually:
```bash
sudo rm /usr/local/bin/lazyadmin
```

## Getting Help

- Press `?` inside the application for keyboard shortcuts
- Run `lazyadmin --help` for command-line options
- Visit: https://github.com/tahasaifeee/lazyadmin

## What's Next?

Now that LazyAdmin is installed:

1. Explore all four panels to see what information is available
2. Try the keyboard shortcuts to navigate quickly
3. Run with `sudo` if you need full system access
4. Check back for updates with `sudo make update`

Enjoy managing your Linux system with LazyAdmin! 🚀
