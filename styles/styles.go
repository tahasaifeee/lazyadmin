package styles

import (
	"github.com/charmbracelet/lipgloss"
)

var (
	// Color palette
	primaryColor   = lipgloss.Color("#7C3AED") // Purple
	secondaryColor = lipgloss.Color("#3B82F6") // Blue
	accentColor    = lipgloss.Color("#10B981") // Green
	warningColor   = lipgloss.Color("#F59E0B") // Orange
	dangerColor    = lipgloss.Color("#EF4444") // Red
	mutedColor     = lipgloss.Color("#6B7280") // Gray
	textColor      = lipgloss.Color("#F3F4F6") // Light gray
	borderColor    = lipgloss.Color("#4B5563") // Border gray

	// Base styles
	BaseStyle = lipgloss.NewStyle().
			Foreground(textColor)

	// Panel styles
	PanelStyle = lipgloss.NewStyle().
			Border(lipgloss.RoundedBorder()).
			BorderForeground(borderColor).
			Padding(1, 2)

	ActivePanelStyle = lipgloss.NewStyle().
				Border(lipgloss.RoundedBorder()).
				BorderForeground(primaryColor).
				Padding(1, 2)

	// Title styles
	TitleStyle = lipgloss.NewStyle().
			Foreground(primaryColor).
			Bold(true).
			Padding(0, 1)

	ActiveTitleStyle = lipgloss.NewStyle().
				Foreground(lipgloss.Color("#FFFFFF")).
				Background(primaryColor).
				Bold(true).
				Padding(0, 1)

	// List item styles
	ItemStyle = lipgloss.NewStyle().
			Foreground(textColor).
			Padding(0, 2)

	SelectedItemStyle = lipgloss.NewStyle().
				Foreground(lipgloss.Color("#FFFFFF")).
				Background(primaryColor).
				Bold(true).
				Padding(0, 2)

	// Status styles
	StatusRunningStyle = lipgloss.NewStyle().
				Foreground(accentColor).
				Bold(true)

	StatusStoppedStyle = lipgloss.NewStyle().
				Foreground(dangerColor).
				Bold(true)

	StatusWarningStyle = lipgloss.NewStyle().
				Foreground(warningColor).
				Bold(true)

	StatusDisabledStyle = lipgloss.NewStyle().
				Foreground(warningColor).
				Bold(true)

	StatusEnabledStyle = lipgloss.NewStyle().
				Foreground(secondaryColor).
				Bold(true)

	StatusFailedStyle = lipgloss.NewStyle().
				Foreground(lipgloss.Color("#DC2626")).
				Bold(true)

	StatusInactiveStyle = lipgloss.NewStyle().
				Foreground(mutedColor).
				Bold(true)

	StatusMaskedStyle = lipgloss.NewStyle().
				Foreground(lipgloss.Color("#6366F1")).
				Bold(true)

	// Status bar style
	StatusBarStyle = lipgloss.NewStyle().
			Foreground(textColor).
			Background(lipgloss.Color("#1F2937")).
			Padding(0, 1)

	// Help style
	HelpStyle = lipgloss.NewStyle().
			Foreground(mutedColor)

	// Header style
	HeaderStyle = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#FFFFFF")).
			Background(primaryColor).
			Bold(true).
			Padding(0, 1).
			Width(100)

	// Key binding style
	KeyStyle = lipgloss.NewStyle().
			Foreground(primaryColor).
			Bold(true)

	ValueStyle = lipgloss.NewStyle().
			Foreground(textColor)

	// Menu item styles
	MenuItemStyle = lipgloss.NewStyle().
			Foreground(mutedColor).
			Padding(0, 2)

	ActiveMenuItemStyle = lipgloss.NewStyle().
				Foreground(primaryColor).
				Bold(true).
				Padding(0, 2)

	// Colorful submenu item styles
	SubMenuStyle1 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#10B981")). // Green
			Padding(0, 2)

	SubMenuStyle2 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#3B82F6")). // Blue
			Padding(0, 2)

	SubMenuStyle3 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#8B5CF6")). // Purple
			Padding(0, 2)

	SubMenuStyle4 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#F59E0B")). // Orange
			Padding(0, 2)

	SubMenuStyle5 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#EF4444")). // Red
			Padding(0, 2)

	SubMenuStyle6 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#06B6D4")). // Cyan
			Padding(0, 2)

	SubMenuStyle7 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#EC4899")). // Pink
			Padding(0, 2)

	SubMenuStyle8 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#14B8A6")). // Teal
			Padding(0, 2)

	SubMenuStyle9 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#F97316")). // Deep Orange
			Padding(0, 2)

	SubMenuStyle10 = lipgloss.NewStyle().
			Foreground(lipgloss.Color("#A855F7")). // Vivid Purple
			Padding(0, 2)
)
