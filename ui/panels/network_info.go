package panels

import (
	"fmt"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type NetworkInfoPanel struct {
	interfaces []utils.NetworkInterface
}

func NewNetworkInfoPanel() *NetworkInfoPanel {
	return &NetworkInfoPanel{}
}

func (p *NetworkInfoPanel) Update() {
	interfaces, err := utils.GetNetworkInterfaces()
	if err == nil {
		p.interfaces = interfaces
	}
}

func (p *NetworkInfoPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.interfaces) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("🌐 Network Interfaces"),
			"",
			"Loading network information...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	var items []string
	items = append(items, titleStyle.Render("🌐 Network Interfaces"))
	items = append(items, "")

	for _, iface := range p.interfaces {
		statusStyle := styles.StatusInactiveStyle
		if iface.Status == "UP" {
			statusStyle = styles.StatusRunningStyle
		}

		items = append(items, styles.KeyStyle.Render(fmt.Sprintf("Interface:  "))+styles.ValueStyle.Render(iface.Name))
		items = append(items, styles.KeyStyle.Render(fmt.Sprintf("Status:     "))+statusStyle.Render(iface.Status))
		items = append(items, styles.KeyStyle.Render(fmt.Sprintf("IP Address: "))+styles.ValueStyle.Render(iface.IPAddress))
		items = append(items, styles.KeyStyle.Render(fmt.Sprintf("MAC:        "))+styles.ValueStyle.Render(iface.MAC))
		items = append(items, "")
	}

	content := lipgloss.JoinVertical(lipgloss.Left, items...)

	return style.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}
