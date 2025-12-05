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
		header = titleStyle.Render("👥 System Users") + "\n\n"
		header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d users | Press 't' to toggle to groups view", len(p.users)))
		header += "\n\n"
		header += styles.KeyStyle.Render("═══ User Management Commands (requires sudo) ═══")
		header += "\n\n" + styles.SubMenuStyle2.Render("● Create User:")
		header += "\n" + styles.HelpStyle.Render("    sudo useradd -m <username>              # Create with home dir")
		header += "\n" + styles.HelpStyle.Render("    sudo passwd <username>                  # Set password")
		header += "\n\n" + styles.SubMenuStyle5.Render("● Delete User:")
		header += "\n" + styles.HelpStyle.Render("    sudo userdel -r <username>              # Delete with home dir")
		header += "\n\n" + styles.SubMenuStyle4.Render("● Add User to Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo usermod -aG <group> <user>        # Add to group")
		header += "\n\n" + styles.SubMenuStyle3.Render("● Remove User from Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo gpasswd -d <user> <group>         # Remove from group")
		header += "\n\n" + styles.SubMenuStyle6.Render("● Set/Reset Password:")
		header += "\n" + styles.HelpStyle.Render("    sudo passwd <username>                  # Interactive password")
		header += "\n\n" + styles.SubMenuStyle7.Render("● Change User Shell:")
		header += "\n" + styles.HelpStyle.Render("    sudo chsh -s /bin/bash <user>           # Set bash shell")
		header += "\n" + styles.HelpStyle.Render("    sudo chsh -s /bin/zsh <user>            # Set zsh shell")
		header += "\n\n" + styles.SubMenuStyle5.Render("● Lock/Unlock User:")
		header += "\n" + styles.HelpStyle.Render("    sudo passwd -l <username>               # Lock account")
		header += "\n" + styles.HelpStyle.Render("    sudo passwd -u <username>               # Unlock account")
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
		header = titleStyle.Render("👥 System Groups") + "\n\n"
		header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d groups | Press 't' to toggle to users view", len(p.groups)))
		header += "\n\n"
		header += styles.KeyStyle.Render("═══ Group Management Commands (requires sudo) ═══")
		header += "\n\n" + styles.SubMenuStyle2.Render("● Create Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo groupadd <groupname>               # Create new group")
		header += "\n" + styles.HelpStyle.Render("    sudo groupadd -g <GID> <groupname>     # With specific GID")
		header += "\n\n" + styles.SubMenuStyle5.Render("● Delete Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo groupdel <groupname>               # Delete group")
		header += "\n\n" + styles.SubMenuStyle4.Render("● Add User to Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo usermod -aG <group> <user>        # Add user (append)")
		header += "\n" + styles.HelpStyle.Render("    sudo gpasswd -a <user> <group>         # Alternative method")
		header += "\n\n" + styles.SubMenuStyle3.Render("● Remove User from Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo gpasswd -d <user> <group>         # Remove user")
		header += "\n\n" + styles.SubMenuStyle7.Render("● Modify Group:")
		header += "\n" + styles.HelpStyle.Render("    sudo groupmod -n <new> <old>            # Rename group")
		header += "\n" + styles.HelpStyle.Render("    sudo groupmod -g <GID> <group>          # Change GID")
		header += "\n\n" + styles.SubMenuStyle6.Render("● View Group Members:")
		header += "\n" + styles.HelpStyle.Render("    getent group <groupname>                # Show group info")
		header += "\n" + styles.HelpStyle.Render("    groups <username>                       # Show user's groups")
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
