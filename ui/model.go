package ui

import (
	"fmt"
	"time"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/ui/panels"
)

type panelType int

const (
	panelSystem panelType = iota
	panelServices
	panelProcesses
	panelDisk
)

type Model struct {
	width  int
	height int

	// Panels
	systemPanel    *panels.SystemPanel
	servicesPanel  *panels.ServicesPanel
	processesPanel *panels.ProcessesPanel
	diskPanel      *panels.DiskPanel

	// Navigation
	activePanel panelType
	showHelp    bool

	// Update ticker
	lastUpdate time.Time
}

type tickMsg time.Time

func NewModel() Model {
	return Model{
		systemPanel:    panels.NewSystemPanel(),
		servicesPanel:  panels.NewServicesPanel(),
		processesPanel: panels.NewProcessesPanel(),
		diskPanel:      panels.NewDiskPanel(),
		activePanel:    panelSystem,
		showHelp:       false,
		lastUpdate:     time.Now(),
	}
}

func (m Model) Init() tea.Cmd {
	return tea.Batch(
		tickCmd(),
		tea.EnterAltScreen,
	)
}

func tickCmd() tea.Cmd {
	return tea.Tick(time.Second*2, func(t time.Time) tea.Msg {
		return tickMsg(t)
	})
}

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c", "q":
			return m, tea.Quit

		case "?":
			m.showHelp = !m.showHelp
			return m, nil

		// Navigation between panels
		case "1":
			m.activePanel = panelSystem
		case "2":
			m.activePanel = panelServices
		case "3":
			m.activePanel = panelProcesses
		case "4":
			m.activePanel = panelDisk

		case "tab":
			m.activePanel = (m.activePanel + 1) % 4

		// Navigation within panels
		case "up", "k":
			switch m.activePanel {
			case panelServices:
				m.servicesPanel.MoveUp()
			case panelProcesses:
				m.processesPanel.MoveUp()
			case panelDisk:
				m.diskPanel.MoveUp()
			}

		case "down", "j":
			switch m.activePanel {
			case panelServices:
				m.servicesPanel.MoveDown()
			case panelProcesses:
				m.processesPanel.MoveDown()
			case panelDisk:
				m.diskPanel.MoveDown()
			}
		}

	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height

	case tickMsg:
		// Update data every 2 seconds
		m.systemPanel.Update()
		m.servicesPanel.Update()
		m.processesPanel.Update()
		m.diskPanel.Update()
		return m, tickCmd()
	}

	return m, nil
}

func (m Model) View() string {
	if m.width == 0 {
		return "Loading..."
	}

	// Header
	header := m.renderHeader()

	// Main content area
	var content string
	if m.showHelp {
		content = m.renderHelp()
	} else {
		content = m.renderPanels()
	}

	// Status bar
	statusBar := m.renderStatusBar()

	// Combine all sections
	return lipgloss.JoinVertical(
		lipgloss.Left,
		header,
		content,
		statusBar,
	)
}

func (m Model) renderHeader() string {
	title := " LazyAdmin - Linux System Administration TUI "
	return styles.HeaderStyle.
		Width(m.width).
		Render(title)
}

func (m Model) renderPanels() string {
	// Calculate dimensions
	contentHeight := m.height - 4 // subtract header and status bar

	// Left column (menu)
	menuWidth := 25
	menu := m.renderMenu(menuWidth, contentHeight)

	// Right column (panels)
	panelWidth := m.width - menuWidth - 2

	var activePanel string
	switch m.activePanel {
	case panelSystem:
		activePanel = m.systemPanel.Render(panelWidth, contentHeight, true)
	case panelServices:
		activePanel = m.servicesPanel.Render(panelWidth, contentHeight, true)
	case panelProcesses:
		activePanel = m.processesPanel.Render(panelWidth, contentHeight, true)
	case panelDisk:
		activePanel = m.diskPanel.Render(panelWidth, contentHeight, true)
	}

	// Join horizontally
	return lipgloss.JoinHorizontal(
		lipgloss.Top,
		menu,
		activePanel,
	)
}

func (m Model) renderMenu(width, height int) string {
	menuItems := []struct {
		key   string
		label string
		panel panelType
		icon  string
	}{
		{"1", "System Info", panelSystem, "⚙"},
		{"2", "Services", panelServices, "🔧"},
		{"3", "Processes", panelProcesses, "⚡"},
		{"4", "Disk Usage", panelDisk, "💾"},
	}

	var items []string
	items = append(items, styles.TitleStyle.Render("Panels"))
	items = append(items, "")

	for _, item := range menuItems {
		var itemStr string
		if item.panel == m.activePanel {
			itemStr = styles.ActiveMenuItemStyle.Render(fmt.Sprintf("%s [%s] %s",
				item.icon, item.key, item.label))
		} else {
			itemStr = styles.MenuItemStyle.Render(fmt.Sprintf("%s [%s] %s",
				item.icon, item.key, item.label))
		}
		items = append(items, itemStr)
	}

	content := lipgloss.JoinVertical(lipgloss.Left, items...)

	return styles.PanelStyle.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}

func (m Model) renderStatusBar() string {
	leftSection := fmt.Sprintf(" Tab: Switch | ↑↓/jk: Navigate | ?: Help | q: Quit ")
	rightSection := fmt.Sprintf(" Updated: %s ", m.lastUpdate.Format("15:04:05"))

	gap := m.width - lipgloss.Width(leftSection) - lipgloss.Width(rightSection)
	if gap < 0 {
		gap = 0
	}

	return styles.StatusBarStyle.
		Width(m.width).
		Render(leftSection + lipgloss.PlaceHorizontal(gap, lipgloss.Right, rightSection))
}

func (m Model) renderHelp() string {
	helpContent := lipgloss.JoinVertical(
		lipgloss.Left,
		styles.TitleStyle.Render("Keyboard Shortcuts"),
		"",
		m.renderHelpRow("q, Ctrl+C", "Quit application"),
		m.renderHelpRow("?", "Toggle this help menu"),
		"",
		styles.TitleStyle.Render("Navigation"),
		"",
		m.renderHelpRow("1, 2, 3, 4", "Switch to specific panel"),
		m.renderHelpRow("Tab", "Switch to next panel"),
		m.renderHelpRow("↑/k", "Move selection up"),
		m.renderHelpRow("↓/j", "Move selection down"),
		"",
		styles.TitleStyle.Render("Panels"),
		"",
		m.renderHelpRow("System Info", "View system information, CPU, memory"),
		m.renderHelpRow("Services", "View and manage systemd services"),
		m.renderHelpRow("Processes", "View running processes"),
		m.renderHelpRow("Disk Usage", "View disk usage and mount points"),
		"",
		styles.HelpStyle.Render("Press ? again to close this help menu"),
	)

	return styles.PanelStyle.
		Width(m.width - 10).
		Height(m.height - 6).
		Render(helpContent)
}

func (m Model) renderHelpRow(key, description string) string {
	return fmt.Sprintf("%s %s",
		styles.KeyStyle.Render(fmt.Sprintf("  %-20s", key)),
		styles.ValueStyle.Render(description),
	)
}
