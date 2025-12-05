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
type systemSubPanel int

const (
	panelSystem panelType = iota
	panelServices
	panelProcesses
	panelDisk
)

const (
	subPanelSummary systemSubPanel = iota
	subPanelHardware
	subPanelFilesystems
	subPanelNetwork
	subPanelPorts
	subPanelLogs
)

type Model struct {
	width  int
	height int

	// Original panels
	servicesPanel  *panels.ServicesPanel
	processesPanel *panels.ProcessesPanel
	diskPanel      *panels.DiskPanel

	// New System Information sub-panels
	systemSummaryPanel    *panels.SystemSummaryPanel
	hardwareInfoPanel     *panels.HardwareInfoPanel
	filesystemsInfoPanel  *panels.FilesystemsInfoPanel
	networkInfoPanel      *panels.NetworkInfoPanel
	portsInfoPanel        *panels.PortsInfoPanel
	systemLogsPanel       *panels.SystemLogsPanel

	// Navigation
	activePanel      panelType
	activeSubPanel   systemSubPanel
	inSystemSubmenu  bool
	showHelp         bool

	// Update ticker
	lastUpdate time.Time
}

type tickMsg time.Time

func NewModel() Model {
	return Model{
		// Original panels
		servicesPanel:  panels.NewServicesPanel(),
		processesPanel: panels.NewProcessesPanel(),
		diskPanel:      panels.NewDiskPanel(),

		// New sub-panels
		systemSummaryPanel:   panels.NewSystemSummaryPanel(),
		hardwareInfoPanel:    panels.NewHardwareInfoPanel(),
		filesystemsInfoPanel: panels.NewFilesystemsInfoPanel(),
		networkInfoPanel:     panels.NewNetworkInfoPanel(),
		portsInfoPanel:       panels.NewPortsInfoPanel(),
		systemLogsPanel:      panels.NewSystemLogsPanel(),

		activePanel:      panelSystem,
		activeSubPanel:   subPanelSummary,
		inSystemSubmenu:  true,
		showHelp:         false,
		lastUpdate:       time.Now(),
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
			// Go back to main menu if in submenu
			if m.inSystemSubmenu {
				m.inSystemSubmenu = false
			}
			return m, nil

		// Navigation between main panels
		case "1":
			m.activePanel = panelSystem
			m.inSystemSubmenu = true
			m.activeSubPanel = subPanelSummary
		case "2":
			m.activePanel = panelServices
			m.inSystemSubmenu = false
		case "3":
			m.activePanel = panelProcesses
			m.inSystemSubmenu = false
		case "4":
			m.activePanel = panelDisk
			m.inSystemSubmenu = false

		case "tab":
			m.inSystemSubmenu = false
			m.activePanel = (m.activePanel + 1) % 4
			if m.activePanel == panelSystem {
				m.inSystemSubmenu = true
			}

		// Navigation within System Information sub-menu
		case "a":
			if m.activePanel == panelSystem {
				m.activeSubPanel = subPanelSummary
				m.inSystemSubmenu = true
			}
		case "b":
			if m.activePanel == panelSystem {
				m.activeSubPanel = subPanelHardware
				m.inSystemSubmenu = true
			}
		case "c":
			if m.activePanel == panelSystem {
				m.activeSubPanel = subPanelFilesystems
				m.inSystemSubmenu = true
			}
		case "n":
			if m.activePanel == panelSystem {
				m.activeSubPanel = subPanelNetwork
				m.inSystemSubmenu = true
			}
		case "p":
			if m.activePanel == panelSystem {
				m.activeSubPanel = subPanelPorts
				m.inSystemSubmenu = true
			}
		case "l":
			if m.activePanel == panelSystem {
				m.activeSubPanel = subPanelLogs
				m.inSystemSubmenu = true
			}

		// Navigation within panels
		case "up", "k":
			if m.activePanel == panelSystem && m.inSystemSubmenu {
				// Navigate sub-menu
				if m.activeSubPanel > 0 {
					m.activeSubPanel--
				}
			} else {
				switch m.activePanel {
				case panelServices:
					m.servicesPanel.MoveUp()
				case panelProcesses:
					m.processesPanel.MoveUp()
				case panelDisk:
					m.diskPanel.MoveUp()
				case panelSystem:
					switch m.activeSubPanel {
					case subPanelHardware:
						m.hardwareInfoPanel.MoveUp()
					case subPanelFilesystems:
						m.filesystemsInfoPanel.MoveUp()
					case subPanelPorts:
						m.portsInfoPanel.MoveUp()
					case subPanelLogs:
						m.systemLogsPanel.MoveUp()
					}
				}
			}

		case "down", "j":
			if m.activePanel == panelSystem && m.inSystemSubmenu {
				// Navigate sub-menu
				if m.activeSubPanel < subPanelLogs {
					m.activeSubPanel++
				}
			} else {
				switch m.activePanel {
				case panelServices:
					m.servicesPanel.MoveDown()
				case panelProcesses:
					m.processesPanel.MoveDown()
				case panelDisk:
					m.diskPanel.MoveDown()
				case panelSystem:
					switch m.activeSubPanel {
					case subPanelHardware:
						m.hardwareInfoPanel.MoveDown()
					case subPanelFilesystems:
						m.filesystemsInfoPanel.MoveDown()
					case subPanelPorts:
						m.portsInfoPanel.MoveDown()
					case subPanelLogs:
						m.systemLogsPanel.MoveDown()
					}
				}
			}

		case "enter":
			// Enter the selected submenu item
			if m.activePanel == panelSystem && m.inSystemSubmenu {
				m.inSystemSubmenu = false
			}

		// Service control actions (only for services panel)
		case "s":
			if m.activePanel == panelServices {
				m.servicesPanel.StartService()
			}
		case "x":
			if m.activePanel == panelServices {
				m.servicesPanel.StopService()
			}
		case "r":
			if m.activePanel == panelServices {
				m.servicesPanel.RestartService()
			}
		case "e":
			if m.activePanel == panelServices {
				m.servicesPanel.EnableService()
			}
		case "d":
			if m.activePanel == panelServices {
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

	// Left column (menu)
	menuWidth := 35
	menu := m.renderMenu(menuWidth, contentHeight)

	// Right column (panels)
	panelWidth := m.width - menuWidth - 2

	var activePanel string
	switch m.activePanel {
	case panelSystem:
		switch m.activeSubPanel {
		case subPanelSummary:
			activePanel = m.systemSummaryPanel.Render(panelWidth, contentHeight, !m.inSystemSubmenu)
		case subPanelHardware:
			activePanel = m.hardwareInfoPanel.Render(panelWidth, contentHeight, !m.inSystemSubmenu)
		case subPanelFilesystems:
			activePanel = m.filesystemsInfoPanel.Render(panelWidth, contentHeight, !m.inSystemSubmenu)
		case subPanelNetwork:
			activePanel = m.networkInfoPanel.Render(panelWidth, contentHeight, !m.inSystemSubmenu)
		case subPanelPorts:
			activePanel = m.portsInfoPanel.Render(panelWidth, contentHeight, !m.inSystemSubmenu)
		case subPanelLogs:
			activePanel = m.systemLogsPanel.Render(panelWidth, contentHeight, !m.inSystemSubmenu)
		}
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
	mainMenuItems := []struct {
		key   string
		label string
		panel panelType
		icon  string
	}{
		{"1", "System Information", panelSystem, "⚙"},
		{"2", "Services", panelServices, "🔧"},
		{"3", "Processes", panelProcesses, "⚡"},
		{"4", "Disk Usage", panelDisk, "💾"},
	}

	subMenuItems := []struct {
		key      string
		label    string
		subPanel systemSubPanel
		icon     string
	}{
		{"a", "System Summary", subPanelSummary, "📊"},
		{"b", "Hardware Info", subPanelHardware, "🖥"},
		{"c", "Filesystems", subPanelFilesystems, "💿"},
		{"n", "Network Interfaces", subPanelNetwork, "🌐"},
		{"p", "Listening Ports", subPanelPorts, "🔌"},
		{"l", "System Logs", subPanelLogs, "📋"},
	}

	var items []string
	items = append(items, styles.TitleStyle.Render("Panels"))
	items = append(items, "")

	// Render main menu items
	for _, item := range mainMenuItems {
		var itemStr string
		if item.panel == m.activePanel {
			itemStr = styles.ActiveMenuItemStyle.Render(fmt.Sprintf("%s [%s] %s",
				item.icon, item.key, item.label))
		} else {
			itemStr = styles.MenuItemStyle.Render(fmt.Sprintf("%s [%s] %s",
				item.icon, item.key, item.label))
		}
		items = append(items, itemStr)

		// Show sub-menu if System Information is selected
		if item.panel == panelSystem && m.activePanel == panelSystem {
			items = append(items, "")
			items = append(items, styles.HelpStyle.Render("  Sub-Menu:"))
			for _, subItem := range subMenuItems {
				var subItemStr string
				prefix := "    "
				if m.activeSubPanel == subItem.subPanel {
					if m.inSystemSubmenu {
						// Highlight in menu navigation mode
						subItemStr = styles.SelectedItemStyle.Render(fmt.Sprintf("%s▶ %s [%s] %s",
							prefix, subItem.icon, subItem.key, subItem.label))
					} else {
						// Active but in content mode
						subItemStr = styles.ActiveMenuItemStyle.Render(fmt.Sprintf("%s  %s [%s] %s",
							prefix, subItem.icon, subItem.key, subItem.label))
					}
				} else {
					subItemStr = styles.MenuItemStyle.Render(fmt.Sprintf("%s  %s [%s] %s",
						prefix, subItem.icon, subItem.key, subItem.label))
				}
				items = append(items, subItemStr)
			}
		}
	}

	content := lipgloss.JoinVertical(lipgloss.Left, items...)

	return styles.PanelStyle.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}

func (m Model) renderStatusBar() string {
	leftSection := " Tab: Switch | ↑↓/jk: Navigate"
	if m.activePanel == panelSystem {
		leftSection += " | Enter: Select | Esc: Back"
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
		m.renderHelpRow("1, 2, 3, 4", "Switch to main panel"),
		m.renderHelpRow("Tab", "Switch to next panel"),
		m.renderHelpRow("↑/k", "Move selection up"),
		m.renderHelpRow("↓/j", "Move selection down"),
		m.renderHelpRow("Enter", "Select submenu item (System Info)"),
		m.renderHelpRow("Esc", "Go back to submenu"),
		"",
		styles.TitleStyle.Render("System Information Submenu"),
		"",
		m.renderHelpRow("a", "System Summary (CPU, RAM, uptime)"),
		m.renderHelpRow("b", "Hardware Info (lshw/dmidecode)"),
		m.renderHelpRow("c", "Mounted Filesystems (df)"),
		m.renderHelpRow("n", "Network Interfaces & IPs"),
		m.renderHelpRow("p", "Listening Ports"),
		m.renderHelpRow("l", "System Logs (journalctl)"),
		"",
		styles.TitleStyle.Render("Service Control (Services Panel)"),
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
