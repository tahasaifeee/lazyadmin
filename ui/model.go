package ui

import (
	"fmt"
	"time"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/ui/panels"
)

type mainSection int
type systemSubPanel int
type userSubPanel int

const (
	sectionSystem mainSection = iota
	sectionUserManagement
)

const (
	subSystemInfo systemSubPanel = iota
	subSystemServices
	subSystemProcesses
	subSystemDisk
)

const (
	subUserList userSubPanel = iota
	subUserCreate
	subUserDelete
	subUserAddGroup
	subUserRemoveGroup
	subUserPassword
	subUserShell
	subUserLockUnlock
)

type Model struct {
	width  int
	height int

	// All panels
	systemSummaryPanel *panels.SystemSummaryPanel
	servicesPanel      *panels.ServicesPanel
	processesPanel     *panels.ProcessesPanel
	diskPanel          *panels.DiskPanel
	usersGroupsPanel   *panels.UsersGroupsPanel

	// Navigation
	activeSection   mainSection
	activeSystemSub systemSubPanel
	activeUserSub   userSubPanel
	inMainMenu      bool // true when selecting main sections
	inSubmenu       bool // true when navigating sub-items
	showHelp        bool

	// Update ticker
	lastUpdate time.Time
}

type tickMsg time.Time

func NewModel() Model {
	return Model{
		systemSummaryPanel: panels.NewSystemSummaryPanel(),
		servicesPanel:      panels.NewServicesPanel(),
		processesPanel:     panels.NewProcessesPanel(),
		diskPanel:          panels.NewDiskPanel(),
		usersGroupsPanel:   panels.NewUsersGroupsPanel(),

		activeSection:   sectionSystem,
		activeSystemSub: subSystemInfo,
		activeUserSub:   subUserList,
		inMainMenu:      true,
		inSubmenu:       true,
		showHelp:        false,
		lastUpdate:      time.Now(),
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
			// Go back through menu levels
			if !m.inSubmenu && !m.inMainMenu {
				// From content -> submenu
				m.inSubmenu = true
			} else if !m.inMainMenu {
				// From submenu -> main menu
				m.inMainMenu = true
				m.inSubmenu = false
			}
			return m, nil

		// Main section selection (1 or 2)
		case "1":
			if m.inMainMenu {
				m.activeSection = sectionSystem
				m.inMainMenu = false
				m.inSubmenu = true
				m.activeSystemSub = subSystemInfo
			} else if m.activeSection == sectionSystem && m.inSubmenu {
				// Quick jump to sub-option 1
				m.activeSystemSub = subSystemInfo
			}

		case "2":
			if m.inMainMenu {
				m.activeSection = sectionUserManagement
				m.inMainMenu = false
				m.inSubmenu = true
				m.activeUserSub = subUserList
			} else if m.activeSection == sectionSystem && m.inSubmenu {
				m.activeSystemSub = subSystemServices
			}

		// System Information sub-options (when in System section submenu)
		case "3":
			if m.activeSection == sectionSystem && m.inSubmenu {
				m.activeSystemSub = subSystemProcesses
			}
		case "4":
			if m.activeSection == sectionSystem && m.inSubmenu {
				m.activeSystemSub = subSystemDisk
			}

		// User Management sub-options (when in User Management section submenu)
		case "a":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserList
				m.inSubmenu = false
			}
		case "b":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserCreate
				m.inSubmenu = false
			}
		case "c":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserDelete
				m.inSubmenu = false
			}
		case "d":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserAddGroup
				m.inSubmenu = false
			}
		case "e":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserRemoveGroup
				m.inSubmenu = false
			}
		case "f":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserPassword
				m.inSubmenu = false
			}
		case "g":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserShell
				m.inSubmenu = false
			}
		case "h":
			if m.activeSection == sectionUserManagement && m.inSubmenu {
				m.activeUserSub = subUserLockUnlock
				m.inSubmenu = false
			}

		// Toggle users/groups view
		case "t":
			if m.activeSection == sectionUserManagement &&
			   m.activeUserSub == subUserList && !m.inSubmenu && !m.inMainMenu {
				m.usersGroupsPanel.ToggleView()
			}

		// Navigation within menus
		case "up", "k":
			if m.inMainMenu {
				// Navigate main sections
				if m.activeSection > 0 {
					m.activeSection--
				}
			} else if m.inSubmenu {
				// Navigate submenu items
				if m.activeSection == sectionSystem {
					if m.activeSystemSub > 0 {
						m.activeSystemSub--
					}
				} else {
					if m.activeUserSub > 0 {
						m.activeUserSub--
					}
				}
			} else {
				// Navigate content
				if m.activeSection == sectionSystem {
					switch m.activeSystemSub {
					case subSystemServices:
						m.servicesPanel.MoveUp()
					case subSystemProcesses:
						m.processesPanel.MoveUp()
					case subSystemDisk:
						m.diskPanel.MoveUp()
					}
				} else {
					if m.activeUserSub == subUserList {
						m.usersGroupsPanel.MoveUp()
					}
				}
			}

		case "down", "j":
			if m.inMainMenu {
				// Navigate main sections
				if m.activeSection < sectionUserManagement {
					m.activeSection++
				}
			} else if m.inSubmenu {
				// Navigate submenu items
				if m.activeSection == sectionSystem {
					if m.activeSystemSub < subSystemDisk {
						m.activeSystemSub++
					}
				} else {
					if m.activeUserSub < subUserLockUnlock {
						m.activeUserSub++
					}
				}
			} else {
				// Navigate content
				if m.activeSection == sectionSystem {
					switch m.activeSystemSub {
					case subSystemServices:
						m.servicesPanel.MoveDown()
					case subSystemProcesses:
						m.processesPanel.MoveDown()
					case subSystemDisk:
						m.diskPanel.MoveDown()
					}
				} else {
					if m.activeUserSub == subUserList {
						m.usersGroupsPanel.MoveDown()
					}
				}
			}

		case "enter":
			// Enter the selected item
			if m.inMainMenu {
				m.inMainMenu = false
				m.inSubmenu = true
			} else if m.inSubmenu {
				m.inSubmenu = false
			}

		// Service control actions
		case "s":
			if m.activeSection == sectionSystem &&
			   m.activeSystemSub == subSystemServices && !m.inSubmenu && !m.inMainMenu {
				m.servicesPanel.StartService()
			}
		case "x":
			if m.activeSection == sectionSystem &&
			   m.activeSystemSub == subSystemServices && !m.inSubmenu && !m.inMainMenu {
				m.servicesPanel.StopService()
			}
		case "r":
			if m.activeSection == sectionSystem &&
			   m.activeSystemSub == subSystemServices && !m.inSubmenu && !m.inMainMenu {
				m.servicesPanel.RestartService()
			}
		}

		// Handle e/d for services separately to avoid conflicts
		if msg.String() == "e" {
			if m.activeSection == sectionSystem &&
			   m.activeSystemSub == subSystemServices && !m.inSubmenu && !m.inMainMenu {
				m.servicesPanel.EnableService()
			}
		}
		if msg.String() == "d" {
			if m.activeSection == sectionSystem &&
			   m.activeSystemSub == subSystemServices && !m.inSubmenu && !m.inMainMenu {
				m.servicesPanel.DisableService()
			}
		}

	case tea.WindowSizeMsg:
		m.width = msg.Width
		m.height = msg.Height

	case tickMsg:
		// Update data every 2 seconds
		m.systemSummaryPanel.Update()
		m.servicesPanel.Update()
		m.processesPanel.Update()
		m.diskPanel.Update()
		m.usersGroupsPanel.Update()
		return m, tickCmd()
	}

	return m, nil
}

func (m Model) View() string {
	if m.width == 0 {
		return "Loading..."
	}

	header := m.renderHeader()

	var content string
	if m.showHelp {
		content = m.renderHelp()
	} else {
		content = m.renderPanels()
	}

	statusBar := m.renderStatusBar()

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
	contentHeight := m.height - 4

	menuWidth := 50
	menu := m.renderMenu(menuWidth, contentHeight)

	panelWidth := m.width - menuWidth - 2

	var activePanel string
	if m.activeSection == sectionSystem {
		switch m.activeSystemSub {
		case subSystemInfo:
			activePanel = m.systemSummaryPanel.Render(panelWidth, contentHeight, !m.inSubmenu && !m.inMainMenu)
		case subSystemServices:
			activePanel = m.servicesPanel.Render(panelWidth, contentHeight, !m.inSubmenu && !m.inMainMenu)
		case subSystemProcesses:
			activePanel = m.processesPanel.Render(panelWidth, contentHeight, !m.inSubmenu && !m.inMainMenu)
		case subSystemDisk:
			activePanel = m.diskPanel.Render(panelWidth, contentHeight, !m.inSubmenu && !m.inMainMenu)
		}
	} else {
		switch m.activeUserSub {
		case subUserList, subUserCreate, subUserDelete, subUserAddGroup,
		     subUserRemoveGroup, subUserPassword, subUserShell, subUserLockUnlock:
			activePanel = m.usersGroupsPanel.Render(panelWidth, contentHeight, !m.inSubmenu && !m.inMainMenu)
		}
	}

	return lipgloss.JoinHorizontal(
		lipgloss.Top,
		menu,
		activePanel,
	)
}

func (m Model) renderMenu(width, height int) string {
	var items []string

	if m.inMainMenu {
		// Show main sections
		items = append(items, styles.TitleStyle.Render("═══ Main Menu ═══"))
		items = append(items, "")

		// System Information
		sysStyle := styles.MenuItemStyle
		if m.activeSection == sectionSystem {
			sysStyle = styles.ActiveMenuItemStyle
			items = append(items, sysStyle.Render("▶ [1] System Information"))
		} else {
			items = append(items, sysStyle.Render("  [1] System Information"))
		}

		// User & Group Management
		userStyle := styles.MenuItemStyle
		if m.activeSection == sectionUserManagement {
			userStyle = styles.ActiveMenuItemStyle
			items = append(items, userStyle.Render("▶ [2] User & Group Management"))
		} else {
			items = append(items, userStyle.Render("  [2] User & Group Management"))
		}

		items = append(items, "")
		items = append(items, styles.HelpStyle.Render("Press Enter to expand →"))

	} else {
		// Show submenu based on active section
		if m.activeSection == sectionSystem {
			items = append(items, styles.TitleStyle.Render("1. System Information"))
			items = append(items, "")

			systemItems := []struct {
				key   string
				label string
				sub   systemSubPanel
				style lipgloss.Style
			}{
				{"1", "System Info", subSystemInfo, styles.SubMenuStyle1},
				{"2", "Services", subSystemServices, styles.SubMenuStyle2},
				{"3", "Processes", subSystemProcesses, styles.SubMenuStyle3},
				{"4", "Disk Usage", subSystemDisk, styles.SubMenuStyle4},
			}

			for _, item := range systemItems {
				var itemStr string
				prefix := "  "

				if m.activeSystemSub == item.sub {
					if m.inSubmenu {
						itemStr = styles.SelectedItemStyle.Render(fmt.Sprintf("▶ [%s] %s", item.key, item.label))
					} else {
						boldStyle := item.style.Copy().Bold(true)
						itemStr = boldStyle.Render(fmt.Sprintf("%s[%s] %s", prefix, item.key, item.label))
					}
				} else {
					itemStr = item.style.Render(fmt.Sprintf("%s[%s] %s", prefix, item.key, item.label))
				}
				items = append(items, itemStr)
			}

		} else {
			items = append(items, styles.TitleStyle.Render("2. User & Group Management"))
			items = append(items, "")

			userItems := []struct {
				key   string
				label string
				sub   userSubPanel
				style lipgloss.Style
			}{
				{"a", "List Users & Groups", subUserList, styles.SubMenuStyle1},
				{"b", "Create User", subUserCreate, styles.SubMenuStyle2},
				{"c", "Delete User", subUserDelete, styles.SubMenuStyle5},
				{"d", "Add User to Group", subUserAddGroup, styles.SubMenuStyle4},
				{"e", "Remove User from Group", subUserRemoveGroup, styles.SubMenuStyle3},
				{"f", "Set/Reset Password", subUserPassword, styles.SubMenuStyle6},
				{"g", "Change User Shell", subUserShell, styles.SubMenuStyle7},
				{"h", "Lock/Unlock User", subUserLockUnlock, styles.SubMenuStyle8},
			}

			for _, item := range userItems {
				var itemStr string
				prefix := "  "

				if m.activeUserSub == item.sub {
					if m.inSubmenu {
						itemStr = styles.SelectedItemStyle.Render(fmt.Sprintf("▶ [%s] %s", item.key, item.label))
					} else {
						boldStyle := item.style.Copy().Bold(true)
						itemStr = boldStyle.Render(fmt.Sprintf("%s[%s] %s", prefix, item.key, item.label))
					}
				} else {
					itemStr = item.style.Render(fmt.Sprintf("%s[%s] %s", prefix, item.key, item.label))
				}
				items = append(items, itemStr)
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
	var leftSection string

	if m.inMainMenu {
		leftSection = " 1-2: Select Section | ↑↓/jk: Navigate | Enter: Expand"
	} else if m.inSubmenu {
		if m.activeSection == sectionSystem {
			leftSection = " 1-4: Quick Jump | ↑↓/jk: Navigate | Enter: View | Esc: Back"
		} else {
			leftSection = " a-h: Quick Jump | ↑↓/jk: Navigate | Enter: View | Esc: Back"
		}
	} else {
		if m.activeSection == sectionSystem && m.activeSystemSub == subSystemServices {
			leftSection = " s:Start | x:Stop | r:Restart | e:Enable | d:Disable | Esc: Back"
		} else if m.activeSection == sectionUserManagement && m.activeUserSub == subUserList {
			leftSection = " t:Toggle Users/Groups | ↑↓/jk: Navigate | Esc: Back"
		} else {
			leftSection = " ↑↓/jk: Navigate | Esc: Back to Menu"
		}
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
		m.renderHelpRow("1-2", "Select main section"),
		m.renderHelpRow("1-4/a-h", "Quick jump to sub-item"),
		m.renderHelpRow("↑/k", "Move selection up"),
		m.renderHelpRow("↓/j", "Move selection down"),
		m.renderHelpRow("Enter", "Expand/View selected item"),
		m.renderHelpRow("Esc", "Go back to previous menu"),
		"",
		styles.TitleStyle.Render("Main Sections"),
		"",
		m.renderHelpRow("1", "System Information"),
		m.renderHelpRow("2", "User & Group Management"),
		"",
		styles.TitleStyle.Render("Service Control (System → Services)"),
		"",
		m.renderHelpRow("s", "Start selected service"),
		m.renderHelpRow("x", "Stop selected service"),
		m.renderHelpRow("r", "Restart selected service"),
		m.renderHelpRow("e", "Enable service (start on boot)"),
		m.renderHelpRow("d", "Disable service (don't start on boot)"),
		"",
		m.renderHelpRow("t", "Toggle users/groups (User Mgmt → List)"),
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
