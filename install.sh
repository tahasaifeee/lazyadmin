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

# Clone repository if needed
setup_repo() {
    # Check if we're already in the repo
    if [ -f "go.mod" ] && grep -q "github.com/tahasaifeee/lazyadmin" go.mod 2>/dev/null; then
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

# Build the application
build_app() {
    print_message "$BLUE" "→ Building ${BINARY_NAME}..."

    if [ ! -f "go.mod" ]; then
        print_message "$RED" "❌ Not in lazyadmin directory."
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
