package panels

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type ServicesPanel struct {
	services      []utils.ServiceInfo
	selectedIndex int
	scrollOffset  int
}

func NewServicesPanel() *ServicesPanel {
	return &ServicesPanel{
		selectedIndex: 0,
		scrollOffset:  0,
	}
}

func (p *ServicesPanel) Update() {
	services, err := utils.GetServices()
	if err == nil {
		p.services = services
	}
}

func (p *ServicesPanel) MoveUp() {
	if p.selectedIndex > 0 {
		p.selectedIndex--
		if p.selectedIndex < p.scrollOffset {
			p.scrollOffset = p.selectedIndex
		}
	}
}

func (p *ServicesPanel) MoveDown() {
	if p.selectedIndex < len(p.services)-1 {
		p.selectedIndex++
	}
}

func (p *ServicesPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.services) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("🔧 Services"),
			"",
			"Loading services...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Adjust scroll offset
	visibleLines := height - 8
	if p.selectedIndex >= p.scrollOffset+visibleLines {
		p.scrollOffset = p.selectedIndex - visibleLines + 1
	}

	// Render header
	header := titleStyle.Render("🔧 Services") + "\n\n"
	header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d services", len(p.services)))

	// Render service list
	var items []string
	end := p.scrollOffset + visibleLines
	if end > len(p.services) {
		end = len(p.services)
	}

	for i := p.scrollOffset; i < end; i++ {
		service := p.services[i]
		itemStr := p.renderService(service, i == p.selectedIndex)
		items = append(items, itemStr)
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

func (p *ServicesPanel) renderService(service utils.ServiceInfo, selected bool) string {
	// Status indicator
	var statusStyle lipgloss.Style
	var statusIcon string
	if service.Active {
		statusStyle = styles.StatusRunningStyle
		statusIcon = "●"
	} else {
		statusStyle = styles.StatusStoppedStyle
		statusIcon = "○"
	}

	// Service name (truncate if too long)
	name := service.Name
	if len(name) > 40 {
		name = name[:37] + "..."
	}

	itemText := fmt.Sprintf("%s %-40s %s",
		statusStyle.Render(statusIcon),
		name,
		statusStyle.Render(service.Status),
	)

	if selected {
		return styles.SelectedItemStyle.Render("▶ " + itemText)
	}
	return styles.ItemStyle.Render("  " + itemText)
}
