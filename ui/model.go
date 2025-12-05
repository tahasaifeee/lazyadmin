package ui

import (
	"fmt"
	"time"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/ui/panels"
)

type systemSubPanel int

const (
	subPanelSummary systemSubPanel = iota
	subPanelHardware
	subPanelFilesystems
	subPanelNetwork
	subPanelPorts
	subPanelLogs
	subPanelServices
	subPanelProcesses
	subPanelDisk
)

type Model struct {
	width  int
	height int

	// All panels
	systemSummaryPanel   *panels.SystemSummaryPanel
	hardwareInfoPanel    *panels.HardwareInfoPanel
	filesystemsInfoPanel *panels.FilesystemsInfoPanel
	networkInfoPanel     *panels.NetworkInfoPanel
	portsInfoPanel       *panels.PortsInfoPanel
	systemLogsPanel      *panels.SystemLogsPanel
	servicesPanel        *panels.ServicesPanel
	processesPanel       *panels.ProcessesPanel
	diskPanel            *panels.DiskPanel

	// Navigation
	activeSubPanel  systemSubPanel
	inSubmenu       bool
	showHelp        bool

	// Update ticker
	lastUpdate time.Time
}

type tickMsg time.Time

func NewModel() Model {
	return Model{
		systemSummaryPanel:   panels.NewSystemSummaryPanel(),
		hardwareInfoPanel:    panels.NewHardwareInfoPanel(),
		filesystemsInfoPanel: panels.NewFilesystemsInfoPanel(),
		networkInfoPanel:     panels.NewNetworkInfoPanel(),
		portsInfoPanel:       panels.NewPortsInfoPanel(),
		systemLogsPanel:      panels.NewSystemLogsPanel(),
		servicesPanel:        panels.NewServicesPanel(),
		processesPanel:       panels.NewProcessesPanel(),
		diskPanel:            panels.NewDiskPanel(),

		activeSubPanel: subPanelSummary,
		inSubmenu:      true,
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

		case "esc":
			// Go back to menu if in content view
			if !m.inSubmenu {
				m.inSubmenu = true
			}
			return m, nil

		// Direct navigation keys (numbers only to avoid conflicts)
		case "1":
			m.activeSubPanel = subPanelSummary
			m.inSubmenu = false
		case "2":
			m.activeSubPanel = subPanelHardware
			m.inSubmenu = false
		case "3":
			m.activeSubPanel = subPanelFilesystems
			m.inSubmenu = false
		case "4":
			m.activeSubPanel = subPanelNetwork
			m.inSubmenu = false
		case "5":
			m.activeSubPanel = subPanelPorts
			m.inSubmenu = false
		case "6":
			m.activeSubPanel = subPanelLogs
			m.inSubmenu = false
		case "7":
			m.activeSubPanel = subPanelServices
			m.inSubmenu = false
		case "8":
			m.activeSubPanel = subPanelProcesses
			m.inSubmenu = false
		case "9":
			m.activeSubPanel = subPanelDisk
			m.inSubmenu = false

		// Navigation within menu
		case "up", "k":
			if m.inSubmenu {
				// Navigate menu
				if m.activeSubPanel > 0 {
					m.activeSubPanel--
				}
			} else {
				// Navigate content
				switch m.activeSubPanel {
				case subPanelHardware:
					m.hardwareInfoPanel.MoveUp()
				case subPanelFilesystems:
					m.filesystemsInfoPanel.MoveUp()
				case subPanelPorts:
					m.portsInfoPanel.MoveUp()
				case subPanelLogs:
					m.systemLogsPanel.MoveUp()
				case subPanelServices:
					m.servicesPanel.MoveUp()
				case subPanelProcesses:
					m.processesPanel.MoveUp()
				case subPanelDisk:
					m.diskPanel.MoveUp()
				}
			}

		case "down", "j":
			if m.inSubmenu {
				// Navigate menu
				if m.activeSubPanel < subPanelDisk {
					m.activeSubPanel++
				}
			} else {
				// Navigate content
				switch m.activeSubPanel {
				case subPanelHardware:
					m.hardwareInfoPanel.MoveDown()
				case subPanelFilesystems:
					m.filesystemsInfoPanel.MoveDown()
				case subPanelPorts:
					m.portsInfoPanel.MoveDown()
				case subPanelLogs:
					m.systemLogsPanel.MoveDown()
				case subPanelServices:
					m.servicesPanel.MoveDown()
				case subPanelProcesses:
					m.processesPanel.MoveDown()
				case subPanelDisk:
					m.diskPanel.MoveDown()
				}
			}

		case "enter":
			// Enter the selected submenu item
			if m.inSubmenu {
				m.inSubmenu = false
			}

		// Service control actions (only for services panel)
		case "s":
			if m.activeSubPanel == subPanelServices && !m.inSubmenu {
				m.servicesPanel.StartService()
			}
		case "x":
			if m.activeSubPanel == subPanelServices && !m.inSubmenu {
				m.servicesPanel.StopService()
			}
		case "r":
			if m.activeSubPanel == subPanelServices && !m.inSubmenu {
				m.servicesPanel.RestartService()
			}
		case "e":
			if m.activeSubPanel == subPanelServices && !m.inSubmenu {
				m.servicesPanel.EnableService()
			}
		case "d":
			if m.activeSubPanel == subPanelServices && !m.inSubmenu {
				m.servicesPanel.DisableService()
			}
		}

	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height

	case tickMsg:
		// Update data every 2 seconds
		m.systemSummaryPanel.Update()
		m.hardwareInfoPanel.Update()
		m.filesystemsInfoPanel.Update()
		m.networkInfoPanel.Update()
		m.portsInfoPanel.Update()
		m.systemLogsPanel.Update()
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

	// Left column (menu) - wider to fit all options
	menuWidth := 45
	menu := m.renderMenu(menuWidth, contentHeight)

	// Right column (panels)
	panelWidth := m.width - menuWidth - 2

	var activePanel string
	switch m.activeSubPanel {
	case subPanelSummary:
		activePanel = m.systemSummaryPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelHardware:
		activePanel = m.hardwareInfoPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelFilesystems:
		activePanel = m.filesystemsInfoPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelNetwork:
		activePanel = m.networkInfoPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelPorts:
		activePanel = m.portsInfoPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelLogs:
		activePanel = m.systemLogsPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelServices:
		activePanel = m.servicesPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelProcesses:
		activePanel = m.processesPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
	case subPanelDisk:
		activePanel = m.diskPanel.Render(panelWidth, contentHeight, !m.inSubmenu)
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
		key      string
		label    string
		subPanel systemSubPanel
		style    lipgloss.Style
	}{
		{"1", "System Summary", subPanelSummary, styles.SubMenuStyle1},
		{"2", "Hardware Info", subPanelHardware, styles.SubMenuStyle2},
		{"3", "Filesystems", subPanelFilesystems, styles.SubMenuStyle3},
		{"4", "Network Interfaces", subPanelNetwork, styles.SubMenuStyle4},
		{"5", "Listening Ports", subPanelPorts, styles.SubMenuStyle5},
		{"6", "System Logs", subPanelLogs, styles.SubMenuStyle6},
		{"7", "Services", subPanelServices, styles.SubMenuStyle7},
		{"8", "Processes", subPanelProcesses, styles.SubMenuStyle8},
		{"9", "Disk Usage", subPanelDisk, styles.SubMenuStyle9},
	}

	var items []string
	items = append(items, styles.TitleStyle.Render("System Information"))
	items = append(items, "")

	// Render menu items with colors
	for _, item := range menuItems {
		var itemStr string
		prefix := "  "

		if m.activeSubPanel == item.subPanel {
			if m.inSubmenu {
				// Highlight with selection indicator in menu mode
				itemStr = styles.SelectedItemStyle.Render(fmt.Sprintf("▶ [%s] %s",
					item.key, item.label))
			} else {
				// Active but in content mode - show with bold style
				boldStyle := item.style.Copy().Bold(true)
				itemStr = boldStyle.Render(fmt.Sprintf("%s[%s] %s",
					prefix, item.key, item.label))
			}
		} else {
			// Inactive - show with colored style
			itemStr = item.style.Render(fmt.Sprintf("%s[%s] %s",
				prefix, item.key, item.label))
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
	leftSection := " 1-9: Quick Jump | ↑↓/jk: Navigate | Enter: Select | Esc: Back"
	if m.activeSubPanel == subPanelServices && !m.inSubmenu {
		leftSection = " s:Start | x:Stop | r:Restart | e:Enable | d:Disable | Esc: Back"
	}
	leftSection += " | ?: Help | q: Quit "

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
		m.renderHelpRow("1-9", "Quick jump to menu item"),
		m.renderHelpRow("↑/k", "Move selection up"),
		m.renderHelpRow("↓/j", "Move selection down"),
		m.renderHelpRow("Enter", "View selected menu item"),
		m.renderHelpRow("Esc", "Return to menu"),
		"",
		styles.TitleStyle.Render("Menu Options"),
		"",
		styles.SubMenuStyle1.Render(m.renderHelpRow("1", "System Summary (CPU, RAM, uptime)")),
		styles.SubMenuStyle2.Render(m.renderHelpRow("2", "Hardware Info (lshw/dmidecode)")),
		styles.SubMenuStyle3.Render(m.renderHelpRow("3", "Mounted Filesystems (df)")),
		styles.SubMenuStyle4.Render(m.renderHelpRow("4", "Network Interfaces & IPs")),
		styles.SubMenuStyle5.Render(m.renderHelpRow("5", "Listening Ports")),
		styles.SubMenuStyle6.Render(m.renderHelpRow("6", "System Logs (journalctl)")),
		styles.SubMenuStyle7.Render(m.renderHelpRow("7", "Services Management")),
		styles.SubMenuStyle8.Render(m.renderHelpRow("8", "Process Monitor")),
		styles.SubMenuStyle9.Render(m.renderHelpRow("9", "Disk Usage")),
		"",
		styles.TitleStyle.Render("Service Control (Services Panel - Press 7)"),
		"",
		m.renderHelpRow("s", "Start selected service"),
		m.renderHelpRow("x", "Stop selected service"),
		m.renderHelpRow("r", "Restart selected service"),
		m.renderHelpRow("e", "Enable service (start on boot)"),
		m.renderHelpRow("d", "Disable service (don't start on boot)"),
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
