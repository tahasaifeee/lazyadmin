package panels

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type UsersGroupsPanel struct {
	users         []utils.UserInfo
	groups        []utils.GroupInfo
	scrollOffset  int
	selectedIndex int
	viewMode      string // "users" or "groups"
}

func NewUsersGroupsPanel() *UsersGroupsPanel {
	return &UsersGroupsPanel{
		viewMode: "users",
	}
}

func (p *UsersGroupsPanel) Update() {
	users, err := utils.GetUsers()
	if err == nil {
		p.users = users
	}

	groups, err := utils.GetGroups()
	if err == nil {
		p.groups = groups
	}
}

func (p *UsersGroupsPanel) MoveUp() {
	if p.selectedIndex > 0 {
		p.selectedIndex--
		if p.selectedIndex < p.scrollOffset {
			p.scrollOffset = p.selectedIndex
		}
	}
}

func (p *UsersGroupsPanel) MoveDown() {
	maxIndex := len(p.users) - 1
	if p.viewMode == "groups" {
		maxIndex = len(p.groups) - 1
	}

	if p.selectedIndex < maxIndex {
		p.selectedIndex++
	}
}

func (p *UsersGroupsPanel) ToggleView() {
	if p.viewMode == "users" {
		p.viewMode = "groups"
	} else {
		p.viewMode = "users"
	}
	p.selectedIndex = 0
	p.scrollOffset = 0
}

func (p *UsersGroupsPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.users) == 0 && len(p.groups) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("👥 Users & Groups"),
			"",
			"Loading user and group information...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	var header string
	var items []string

	if p.viewMode == "users" {
		header = titleStyle.Render("👥 Users") + "\n\n"
		header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d users | Press 't' to toggle to groups", len(p.users)))
		header += "\n\n"
		header += styles.KeyStyle.Render("User management requires sudo. Commands:")
		header += "\n" + styles.HelpStyle.Render("  Create:  sudo useradd -m <username>")
		header += "\n" + styles.HelpStyle.Render("  Delete:  sudo userdel -r <username>")
		header += "\n" + styles.HelpStyle.Render("  Password: sudo passwd <username>")
		header += "\n" + styles.HelpStyle.Render("  Lock:    sudo passwd -l <username>")
		header += "\n" + styles.HelpStyle.Render("  Unlock:  sudo passwd -u <username>")
		header += "\n"

		// Calculate visible lines
		visibleLines := height - 20
		if p.selectedIndex >= p.scrollOffset+visibleLines {
			p.scrollOffset = p.selectedIndex - visibleLines + 1
		}

		end := p.scrollOffset + visibleLines
		if end > len(p.users) {
			end = len(p.users)
		}

		for i := p.scrollOffset; i < end; i++ {
			user := p.users[i]

			statusStyle := styles.StatusRunningStyle
			statusIcon := "✓"
			if user.Status == "locked" {
				statusStyle = styles.StatusStoppedStyle
				statusIcon = "🔒"
			}

			itemText := fmt.Sprintf("%s %-15s UID:%-6s Shell:%-20s Home:%s",
				statusStyle.Render(statusIcon),
				user.Username,
				user.UID,
				user.Shell,
				user.Home,
			)

			if i == p.selectedIndex {
				items = append(items, styles.SelectedItemStyle.Render("▶ "+itemText))
			} else {
				items = append(items, styles.ItemStyle.Render("  "+itemText))
			}
		}
	} else {
		header = titleStyle.Render("👥 Groups") + "\n\n"
		header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d groups | Press 't' to toggle to users", len(p.groups)))
		header += "\n\n"
		header += styles.KeyStyle.Render("Group management requires sudo. Commands:")
		header += "\n" + styles.HelpStyle.Render("  Add user to group:    sudo usermod -aG <group> <user>")
		header += "\n" + styles.HelpStyle.Render("  Remove from group:    sudo gpasswd -d <user> <group>")
		header += "\n" + styles.HelpStyle.Render("  Create group:         sudo groupadd <groupname>")
		header += "\n" + styles.HelpStyle.Render("  Delete group:         sudo groupdel <groupname>")
		header += "\n"

		// Calculate visible lines
		visibleLines := height - 18
		if p.selectedIndex >= p.scrollOffset+visibleLines {
			p.scrollOffset = p.selectedIndex - visibleLines + 1
		}

		end := p.scrollOffset + visibleLines
		if end > len(p.groups) {
			end = len(p.groups)
		}

		for i := p.scrollOffset; i < end; i++ {
			group := p.groups[i]

			members := group.Members
			if members == "" {
				members = "(no members)"
			}
			if len(members) > 40 {
				members = members[:37] + "..."
			}

			itemText := fmt.Sprintf("%-20s GID:%-8s Members: %s",
				group.Name,
				group.GID,
				members,
			)

			if i == p.selectedIndex {
				items = append(items, styles.SelectedItemStyle.Render("▶ "+itemText))
			} else {
				items = append(items, styles.ItemStyle.Render("  "+itemText))
			}
		}
	}

	content := lipgloss.JoinVertical(
		lipgloss.Left,
		header,
		strings.Join(items, "\n"),
	)

	return style.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}
