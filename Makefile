# LazyAdmin Makefile
# Simple commands to build, install, and manage LazyAdmin

.PHONY: build install uninstall update clean help

# Variables
BINARY_NAME=lazyadmin
INSTALL_PATH=/usr/local/bin
VERSION=$(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
LDFLAGS=-ldflags "-X main.Version=${VERSION}"

# Default target
all: build

# Build the application
build:
	@echo "Building ${BINARY_NAME}..."
	@go build ${LDFLAGS} -o ${BINARY_NAME}
	@echo "✓ Build complete: ./${BINARY_NAME}"

# Install to system path
install: build
	@echo "Installing ${BINARY_NAME} to ${INSTALL_PATH}..."
	@if [ "$$(id -u)" != "0" ]; then \
		echo "❌ Installation requires root privileges. Please run: sudo make install"; \
		exit 1; \
	fi
	@install -m 755 ${BINARY_NAME} ${INSTALL_PATH}/${BINARY_NAME}
	@echo "✓ ${BINARY_NAME} installed successfully!"
	@echo "✓ You can now run 'lazyadmin' from anywhere"

# Uninstall from system
uninstall:
	@echo "Uninstalling ${BINARY_NAME}..."
	@if [ "$$(id -u)" != "0" ]; then \
		echo "❌ Uninstallation requires root privileges. Please run: sudo make uninstall"; \
		exit 1; \
	fi
	@rm -f ${INSTALL_PATH}/${BINARY_NAME}
	@echo "✓ ${BINARY_NAME} uninstalled successfully"

# Update: pull latest changes, rebuild, and reinstall
update:
	@echo "Updating ${BINARY_NAME}..."
	@if [ "$$(id -u)" != "0" ]; then \
		echo "❌ Update requires root privileges. Please run: sudo make update"; \
		exit 1; \
	fi
	@echo "→ Pulling latest changes from git..."
	@git pull origin $$(git branch --show-current)
	@echo "→ Building new version..."
	@go build ${LDFLAGS} -o ${BINARY_NAME}
	@echo "→ Installing updated binary..."
	@install -m 755 ${BINARY_NAME} ${INSTALL_PATH}/${BINARY_NAME}
	@echo "✓ ${BINARY_NAME} updated successfully!"
	@echo "✓ Version: ${VERSION}"

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -f ${BINARY_NAME}
	@echo "✓ Clean complete"

# Run the application locally
run: build
	@echo "Running ${BINARY_NAME}..."
	@./${BINARY_NAME}

# Show help
help:
	@echo "LazyAdmin - Makefile commands"
	@echo ""
	@echo "Usage:"
	@echo "  make build      - Build the application"
	@echo "  make install    - Install to ${INSTALL_PATH} (requires sudo)"
	@echo "  make uninstall  - Remove from ${INSTALL_PATH} (requires sudo)"
	@echo "  make update     - Update to latest version (requires sudo)"
	@echo "  make clean      - Remove build artifacts"
	@echo "  make run        - Build and run locally"
	@echo "  make help       - Show this help message"
	@echo ""
	@echo "Quick start:"
	@echo "  1. Clone the repository"
	@echo "  2. Run: sudo make install"
	@echo "  3. Run: lazyadmin"
	@echo ""
	@echo "To update later:"
	@echo "  sudo make update"
