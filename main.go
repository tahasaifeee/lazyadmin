package main

import (
	"flag"
	"fmt"
	"os"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/tahasaifeee/lazyadmin/ui"
)

// Version information (set via ldflags during build)
var (
	Version   = "dev"
	BuildDate = "unknown"
	GitCommit = "unknown"
)

func main() {
	// Command line flags
	versionFlag := flag.Bool("version", false, "Print version information")
	vFlag := flag.Bool("v", false, "Print version information (short)")
	helpFlag := flag.Bool("help", false, "Show help message")
	hFlag := flag.Bool("h", false, "Show help message (short)")

	flag.Parse()

	// Handle version flag
	if *versionFlag || *vFlag {
		printVersion()
		return
	}

	// Handle help flag
	if *helpFlag || *hFlag {
		printHelp()
		return
	}

	// Check if running as root (needed for some system information)
	if os.Geteuid() != 0 {
		fmt.Println("⚠️  Warning: Running without root privileges. Some features may be limited.")
		fmt.Println("   Consider running with sudo for full functionality.\n")
	}

	// Create the Bubble Tea program
	p := tea.NewProgram(
		ui.NewModel(),
		tea.WithAltScreen(),
		tea.WithMouseCellMotion(),
	)

	// Run the program
	if _, err := p.Run(); err != nil {
		fmt.Printf("Error running program: %v\n", err)
		os.Exit(1)
	}
}

func printVersion() {
	fmt.Printf("LazyAdmin %s\n", Version)
	if GitCommit != "unknown" {
		fmt.Printf("Commit: %s\n", GitCommit)
	}
	if BuildDate != "unknown" {
		fmt.Printf("Built: %s\n", BuildDate)
	}
}

func printHelp() {
	fmt.Println("LazyAdmin - A beautiful TUI for Linux system administration")
	fmt.Println()
	fmt.Println("Usage:")
	fmt.Println("  lazyadmin [options]")
	fmt.Println()
	fmt.Println("Options:")
	fmt.Println("  -v, --version    Print version information")
	fmt.Println("  -h, --help       Show this help message")
	fmt.Println()
	fmt.Println("Keyboard Shortcuts (once running):")
	fmt.Println("  q, Ctrl+C        Quit application")
	fmt.Println("  ?                Toggle help menu")
	fmt.Println("  1, 2, 3, 4       Switch to specific panel")
	fmt.Println("  Tab              Switch to next panel")
	fmt.Println("  ↑/k              Move selection up")
	fmt.Println("  ↓/j              Move selection down")
	fmt.Println()
	fmt.Println("For more information, visit: https://github.com/tahasaifeee/lazyadmin")
}
