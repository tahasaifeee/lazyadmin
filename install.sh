#!/bin/bash
# LazyAdmin Installation Script
# This script installs lazyadmin to your system

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
        print_message "$YELLOW" "Please run with sudo: sudo ./install.sh"
        exit 1
    fi
}

# Check dependencies
check_dependencies() {
    print_message "$BLUE" "→ Checking dependencies..."

    if ! command -v go &> /dev/null; then
        print_message "$RED" "❌ Go is not installed. Please install Go 1.16 or later."
        print_message "$YELLOW" "Visit: https://golang.org/doc/install"
        exit 1
    fi

    if ! command -v git &> /dev/null; then
        print_message "$RED" "❌ Git is not installed. Please install git."
        exit 1
    fi

    print_message "$GREEN" "✓ All dependencies are installed"
}

# Build the application
build_app() {
    print_message "$BLUE" "→ Building ${BINARY_NAME}..."

    if [ ! -f "go.mod" ]; then
        print_message "$RED" "❌ Not in lazyadmin directory. Please cd to the repository first."
        exit 1
    fi

    go build -o "${BINARY_NAME}" || {
        print_message "$RED" "❌ Build failed"
        exit 1
    }

    print_message "$GREEN" "✓ Build complete"
}

# Install the binary
install_binary() {
    print_message "$BLUE" "→ Installing ${BINARY_NAME} to ${INSTALL_PATH}..."

    install -m 755 "${BINARY_NAME}" "${INSTALL_PATH}/${BINARY_NAME}" || {
        print_message "$RED" "❌ Installation failed"
        exit 1
    }

    print_message "$GREEN" "✓ ${BINARY_NAME} installed successfully!"
}

# Main installation function
main() {
    print_header

    check_root
    check_dependencies
    build_app
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
    print_message "$YELLOW" "  $ sudo make update"
    print_message "$YELLOW" "  or"
    print_message "$YELLOW" "  $ sudo ./install.sh"
    echo ""
    print_message "$BLUE" "To uninstall:"
    print_message "$YELLOW" "  $ sudo make uninstall"
    echo ""
}

# Run main function
main
