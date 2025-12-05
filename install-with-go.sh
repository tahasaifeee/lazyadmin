#!/bin/bash
# LazyAdmin Installation Script with Auto Go Installation
# This script will install Go if needed, then install LazyAdmin

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
GO_VERSION="1.21.6"
GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"
INSTALL_SCRIPT_URL="https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh"

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo ""
    print_message "$PURPLE" "╔════════════════════════════════════════════════╗"
    print_message "$PURPLE" "║   LazyAdmin Installation (with Go installer)   ║"
    print_message "$PURPLE" "╚════════════════════════════════════════════════╝"
    echo ""
}

check_root() {
    if [ "$(id -u)" != "0" ]; then
        print_message "$RED" "❌ This script requires root privileges."
        print_message "$YELLOW" "Please run with sudo:"
        print_message "$YELLOW" "  curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install-with-go.sh | sudo bash"
        exit 1
    fi
}

install_go() {
    print_message "$BLUE" "→ Installing Go ${GO_VERSION}..."

    # Create temp directory
    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR"

    # Download Go
    print_message "$BLUE" "  Downloading Go..."
    wget -q --show-progress "$GO_URL" || {
        print_message "$RED" "❌ Failed to download Go"
        exit 1
    }

    # Remove old Go installation
    if [ -d "/usr/local/go" ]; then
        print_message "$BLUE" "  Removing old Go installation..."
        rm -rf /usr/local/go
    fi

    # Extract Go
    print_message "$BLUE" "  Installing Go to /usr/local/go..."
    tar -C /usr/local -xzf "$GO_TARBALL" || {
        print_message "$RED" "❌ Failed to extract Go"
        exit 1
    }

    # Add to PATH for current session
    export PATH=$PATH:/usr/local/go/bin

    # Add to system-wide profile
    if ! grep -q "/usr/local/go/bin" /etc/profile 2>/dev/null; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> /etc/profile
    fi

    # Add to root's bashrc
    if ! grep -q "/usr/local/go/bin" ~/.bashrc 2>/dev/null; then
        echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
    fi

    # Cleanup
    cd /
    rm -rf "$TEMP_DIR"

    print_message "$GREEN" "✓ Go ${GO_VERSION} installed successfully!"

    # Verify installation
    go version
}

check_and_install_go() {
    print_message "$BLUE" "→ Checking for Go installation..."

    if command -v go &> /dev/null; then
        GO_VER=$(go version | awk '{print $3}' | sed 's/go//')
        print_message "$GREEN" "✓ Go $GO_VER is already installed"
        return 0
    fi

    print_message "$YELLOW" "⚠️  Go is not installed"
    print_message "$BLUE" "→ Installing Go automatically..."

    install_go
}

check_dependencies() {
    print_message "$BLUE" "→ Checking other dependencies..."

    # Check for wget
    if ! command -v wget &> /dev/null; then
        print_message "$YELLOW" "→ Installing wget..."
        apt-get update -qq
        apt-get install -y wget || {
            print_message "$RED" "❌ Failed to install wget"
            exit 1
        }
    fi

    # Check for git
    if ! command -v git &> /dev/null; then
        print_message "$YELLOW" "→ Installing git..."
        apt-get update -qq
        apt-get install -y git || {
            print_message "$RED" "❌ Failed to install git"
            exit 1
        }
    fi

    print_message "$GREEN" "✓ All dependencies are installed"
}

install_lazyadmin() {
    print_message "$BLUE" "→ Installing LazyAdmin..."
    echo ""

    # Download and run the LazyAdmin install script
    wget -qO- "$INSTALL_SCRIPT_URL" | bash
}

main() {
    print_header

    check_root
    check_and_install_go
    check_dependencies

    echo ""
    print_message "$BLUE" "═════════════════════════════════════════════"
    print_message "$BLUE" "  Ready to install LazyAdmin!"
    print_message "$BLUE" "═════════════════════════════════════════════"
    echo ""

    install_lazyadmin
}

# Run main function
main
