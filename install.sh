#!/bin/bash
# LazyAdmin Installation Script
# This script installs lazyadmin to your system
# Can be run locally or piped from curl/wget

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
BINARY_NAME="lazyadmin"
INSTALL_PATH="/usr/local/bin"
REPO_URL="https://github.com/tahasaifeee/lazyadmin.git"
TEMP_DIR=""
IN_REPO=false

# Print colored message
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo ""
    print_message "$PURPLE" "╔═══════════════════════════════════════════╗"
    print_message "$PURPLE" "║        LazyAdmin Installation Script      ║"
    print_message "$PURPLE" "╚═══════════════════════════════════════════╝"
    echo ""
}

# Check if running as root
check_root() {
    if [ "$(id -u)" != "0" ]; then
        print_message "$RED" "❌ This script requires root privileges."
        print_message "$YELLOW" "Please run with sudo:"
        if [ "$IN_REPO" = true ]; then
            print_message "$YELLOW" "  sudo ./install.sh"
        else
            print_message "$YELLOW" "  curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash"
        fi
        exit 1
    fi
}

# Check dependencies
check_dependencies() {
    print_message "$BLUE" "→ Checking dependencies..."

    if ! command -v git &> /dev/null; then
        print_message "$RED" "❌ Git is not installed. Please install git."
        print_message "$YELLOW" "Install git:"
        print_message "$YELLOW" "  Ubuntu/Debian: sudo apt-get install git"
        print_message "$YELLOW" "  RHEL/CentOS:   sudo yum install git"
        print_message "$YELLOW" "  Fedora:        sudo dnf install git"
        print_message "$YELLOW" "  Arch:          sudo pacman -S git"
        exit 1
    fi

    print_message "$GREEN" "✓ All dependencies satisfied (pure Bash, no external tools needed)"
}

# Clone repository if needed
setup_repo() {
    # Check if we're already in the repo
    if [ -f "lazyadmin.sh" ]; then
        print_message "$BLUE" "→ Using existing repository"
        IN_REPO=true
        return
    fi

    # We need to clone the repo
    print_message "$BLUE" "→ Cloning LazyAdmin repository..."

    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit 1

    git clone "$REPO_URL" . || {
        print_message "$RED" "❌ Failed to clone repository"
        exit 1
    }

    print_message "$GREEN" "✓ Repository cloned successfully"
}

# Prepare the script
prepare_script() {
    print_message "$BLUE" "→ Preparing ${BINARY_NAME}..."

    if [ ! -f "lazyadmin.sh" ]; then
        print_message "$RED" "❌ lazyadmin.sh not found in current directory."
        exit 1
    fi

    # Make executable
    chmod +x lazyadmin.sh || {
        print_message "$RED" "❌ Failed to make script executable"
        exit 1
    }

    print_message "$GREEN" "✓ Script prepared"
}

# Install the script
install_binary() {
    print_message "$BLUE" "→ Installing ${BINARY_NAME} to ${INSTALL_PATH}..."

    install -m 755 lazyadmin.sh "${INSTALL_PATH}/${BINARY_NAME}" || {
        print_message "$RED" "❌ Installation failed"
        exit 1
    }

    print_message "$GREEN" "✓ ${BINARY_NAME} installed successfully!"
}

# Cleanup temporary directory
cleanup() {
    if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        print_message "$BLUE" "→ Cleaning up temporary files..."
        cd / # Leave the temp dir before removing it
        rm -rf "$TEMP_DIR"
    fi
}

# Main installation function
main() {
    print_header

    # Set trap to cleanup on exit
    trap cleanup EXIT

    check_root
    check_dependencies
    setup_repo
    prepare_script
    install_binary

    echo ""
    print_message "$GREEN" "═══════════════════════════════════════════"
    print_message "$GREEN" "  ✓ Installation Complete!"
    print_message "$GREEN" "═══════════════════════════════════════════"
    echo ""
    print_message "$BLUE" "You can now run lazyadmin from anywhere:"
    print_message "$YELLOW" "  $ lazyadmin"
    echo ""
    print_message "$BLUE" "To update in the future:"
    if [ "$IN_REPO" = true ]; then
        print_message "$YELLOW" "  $ cd $(pwd)"
        print_message "$YELLOW" "  $ sudo make update"
    else
        print_message "$YELLOW" "  1. Clone the repo: git clone ${REPO_URL}"
        print_message "$YELLOW" "  2. Run: cd lazyadmin && sudo make update"
        print_message "$YELLOW" "  Or re-run the install command"
    fi
    echo ""
    print_message "$BLUE" "To uninstall:"
    print_message "$YELLOW" "  $ sudo rm ${INSTALL_PATH}/${BINARY_NAME}"
    echo ""
}

# Run main function
main
