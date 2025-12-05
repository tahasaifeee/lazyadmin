package main

import (
	"fmt"
	"os"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/tahasaifeee/lazyadmin/ui"
)

func main() {
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
