#!/bin/bash
# LazyAdmin Update Script
# Updates LazyAdmin to the latest version from GitHub

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
GO_VERSION="1.21.6"
GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/${GO_TARBALL}"

print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

print_header() {
    echo ""
    print_message "$PURPLE" "╔═══════════════════════════════════════════╗"
    print_message "$PURPLE" "║        LazyAdmin Update Script            ║"
    print_message "$PURPLE" "╚═══════════════════════════════════════════╝"
    echo ""
}

check_root() {
    if [ "$(id -u)" != "0" ]; then
        print_message "$RED" "❌ This script requires root privileges."
        print_message "$YELLOW" "Please run with sudo:"
        print_message "$YELLOW" "  curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/update.sh | sudo bash"
        exit 1
    fi
}

check_installed() {
    if ! command -v lazyadmin &> /dev/null; then
        print_message "$RED" "❌ LazyAdmin is not installed."
        print_message "$YELLOW" "Please install it first:"
        print_message "$YELLOW" "  curl -sSL https://raw.githubusercontent.com/tahasaifeee/lazyadmin/main/install.sh | sudo bash"
        exit 1
    fi

    print_message "$GREEN" "✓ LazyAdmin is currently installed"
    lazyadmin --version 2>/dev/null || echo "  Version: unknown"
}

install_go() {
    print_message "$BLUE" "→ Installing Go ${GO_VERSION}..."

    # Create temp directory for Go install
    GO_TEMP_DIR=$(mktemp -d)
    cd "$GO_TEMP_DIR"

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
    rm -rf "$GO_TEMP_DIR"

    print_message "$GREEN" "✓ Go ${GO_VERSION} installed successfully!"
    go version
}

check_dependencies() {
    print_message "$BLUE" "→ Checking dependencies..."

    # Check for wget (needed for Go install if Go is missing)
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

    # Check for Go and install if missing
    if ! command -v go &> /dev/null; then
        print_message "$YELLOW" "⚠️  Go is not installed"
        print_message "$BLUE" "→ Installing Go automatically..."
        install_go
    else
        GO_VER=$(go version | awk '{print $3}' | sed 's/go//')
        print_message "$GREEN" "✓ Go $GO_VER is already installed"
    fi

    print_message "$GREEN" "✓ All dependencies are installed"
}

update_lazyadmin() {
    print_message "$BLUE" "→ Downloading latest version..."

    TEMP_DIR=$(mktemp -d)
    cd "$TEMP_DIR" || exit 1

    git clone --depth 1 "$REPO_URL" . || {
        print_message "$RED" "❌ Failed to download latest version"
        exit 1
    }

    print_message "$GREEN" "✓ Latest version downloaded"
    print_message "$BLUE" "→ Building LazyAdmin..."

    go build -o "${BINARY_NAME}" || {
        print_message "$RED" "❌ Build failed"
        exit 1
    }

    print_message "$GREEN" "✓ Build complete"
    print_message "$BLUE" "→ Installing updated binary..."

    install -m 755 "${BINARY_NAME}" "${INSTALL_PATH}/${BINARY_NAME}" || {
        print_message "$RED" "❌ Installation failed"
        exit 1
    }

    print_message "$GREEN" "✓ LazyAdmin updated successfully!"
}

cleanup() {
    if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
        print_message "$BLUE" "→ Cleaning up temporary files..."
        cd /
        rm -rf "$TEMP_DIR"
    fi
}

main() {
    print_header

    # Set trap to cleanup on exit
    trap cleanup EXIT

    check_root
    check_installed
    check_dependencies
    update_lazyadmin

    echo ""
    print_message "$GREEN" "═══════════════════════════════════════════"
    print_message "$GREEN" "  ✓ Update Complete!"
    print_message "$GREEN" "═══════════════════════════════════════════"
    echo ""
    print_message "$BLUE" "New version installed:"
    lazyadmin --version 2>/dev/null || echo "  LazyAdmin (updated)"
    echo ""
    print_message "$BLUE" "You can now run:"
    print_message "$YELLOW" "  $ lazyadmin"
    echo ""
}

# Run main function
main
