package panels

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type PortsInfoPanel struct {
	ports        []utils.PortInfo
	scrollOffset int
	selectedIndex int
}

func NewPortsInfoPanel() *PortsInfoPanel {
	return &PortsInfoPanel{}
}

func (p *PortsInfoPanel) Update() {
	ports, err := utils.GetListeningPorts()
	if err == nil {
		p.ports = ports
	}
}

func (p *PortsInfoPanel) MoveUp() {
	if p.selectedIndex > 0 {
		p.selectedIndex--
		if p.selectedIndex < p.scrollOffset {
			p.scrollOffset = p.selectedIndex
		}
	}
}

func (p *PortsInfoPanel) MoveDown() {
	if p.selectedIndex < len(p.ports)-1 {
		p.selectedIndex++
	}
}

func (p *PortsInfoPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.ports) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("🔌 Listening Ports"),
			"",
			"Loading port information...",
			"",
			styles.HelpStyle.Render("(Please run with sudo for full port details)"),
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Header
	header := titleStyle.Render("🔌 Listening Ports") + "\n\n"
	header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d open ports", len(p.ports)))

	// Calculate visible lines
	visibleLines := height - 8
	if p.selectedIndex >= p.scrollOffset+visibleLines {
		p.scrollOffset = p.selectedIndex - visibleLines + 1
	}

	var items []string
	end := p.scrollOffset + visibleLines
	if end > len(p.ports) {
		end = len(p.ports)
	}

	for i := p.scrollOffset; i < end; i++ {
		port := p.ports[i]
		itemText := fmt.Sprintf("%-10s %-8s %-30s",
			port.Protocol,
			port.Port,
			strings.TrimSpace(port.Process),
		)

		if i == p.selectedIndex {
			items = append(items, styles.SelectedItemStyle.Render("▶ "+itemText))
		} else {
			items = append(items, styles.ItemStyle.Render("  "+itemText))
		}
	}

	content := lipgloss.JoinVertical(
		lipgloss.Left,
		header,
		"",
		strings.Join(items, "\n"),
	)

	return style.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}
