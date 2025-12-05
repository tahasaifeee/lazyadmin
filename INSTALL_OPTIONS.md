# LazyAdmin Installation Options

Multiple ways to install LazyAdmin on your Linux system. Choose the method that works best for you!

## 🚀 Method 1: One-Line Install (Fastest)

**Perfect for:** Quick testing, first-time installation

### Using curl:
```bash
curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

### Using wget:
```bash
wget -qO- https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash
```

**What it does:**
- Downloads the install script from GitHub
- Clones the repository to a temporary directory
- Builds the application
- Installs to `/usr/local/bin`
- Cleans up temporary files
- Ready to use with `lazyadmin` command

**Time:** ~30 seconds (depending on your internet speed)

---

## 📦 Method 2: Clone and Install Script

**Perfect for:** Users who want the repository for future updates

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
sudo ./install.sh
```

**What it does:**
- Clones repository to your local machine
- Builds from source
- Installs system-wide
- Keeps the repository for easy updates

**Time:** ~1 minute

**Update later with:**
```bash
cd lazyadmin
git pull
sudo ./install.sh
```

---

## 🔧 Method 3: Makefile Installation

**Perfect for:** Developers familiar with Makefiles

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
sudo make install
```

**Available make targets:**
- `make build` - Build the binary
- `make install` - Build and install system-wide
- `make update` - Pull latest changes and reinstall
- `make uninstall` - Remove from system
- `make clean` - Clean build artifacts
- `make run` - Build and run locally
- `make help` - Show all commands

**Time:** ~1 minute

**Update later with:**
```bash
cd lazyadmin
sudo make update
```

---

## 🛠️ Method 4: Manual Installation

**Perfect for:** Advanced users who want full control

```bash
git clone https://github.com/tahasaifeee/lazyadmin.git
cd lazyadmin
go build -o lazyadmin
sudo install -m 755 lazyadmin /usr/local/bin/lazyadmin
```

**What it does:**
- Manual control over each step
- Standard Go build process
- Uses system `install` command
- No extra scripts

**Time:** ~1 minute

**Update later with:**
```bash
cd lazyadmin
git pull
go build -o lazyadmin
sudo install -m 755 lazyadmin /usr/local/bin/lazyadmin
```

---

## 📊 Comparison Table

| Method | Speed | Repository Saved | Easy Updates | Best For |
|--------|-------|------------------|--------------|----------|
| One-Line (curl/wget) | ⚡ Fastest | ❌ No | Manual re-run | Quick testing |
| Install Script | 🚀 Fast | ✅ Yes | Very easy | Most users |
| Makefile | 🚀 Fast | ✅ Yes | One command | Developers |
| Manual | 🐢 Slowest | ✅ Yes | Manual steps | Advanced users |

---

## After Installation

Regardless of which method you choose, after installation you can:

**Run LazyAdmin:**
```bash
lazyadmin
```

**Check version:**
```bash
lazyadmin --version
```

**Get help:**
```bash
lazyadmin --help
```

**Run with full privileges:**
```bash
sudo lazyadmin
```

---

## Uninstallation

### If installed via Makefile:
```bash
sudo make uninstall
```

### For all other methods:
```bash
sudo rm /usr/local/bin/lazyadmin
```

---

## Requirements

All methods require:
- Go 1.16 or later
- Git
- Linux operating system
- Root/sudo privileges for installation

---

## Troubleshooting

### "go: command not found"
Install Go from: https://golang.org/doc/install

### "git: command not found"
Install git:
```bash
# Debian/Ubuntu
sudo apt install git

# RHEL/CentOS/Fedora
sudo dnf install git
```

### "Permission denied"
Make sure to use `sudo` for installation commands.

### One-line install failed
Try cloning the repository manually and using Method 2 or 3.

---

## Recommendations

- **First time users**: Use the one-line install (Method 1)
- **Regular users**: Use install script (Method 2) or Makefile (Method 3)
- **Developers**: Use Makefile (Method 3) for easy updates
- **Power users**: Use manual installation (Method 4) for full control

Choose the method that matches your comfort level and use case!
