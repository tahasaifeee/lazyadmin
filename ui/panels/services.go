package panels

import (
	"fmt"
	"strings"
	"time"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type ServicesPanel struct {
	services       []utils.ServiceInfo
	selectedIndex  int
	scrollOffset   int
	statusMessage  string
	statusTime     time.Time
	statusIsError  bool
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

func (p *ServicesPanel) GetSelectedService() *utils.ServiceInfo {
	if len(p.services) == 0 || p.selectedIndex >= len(p.services) {
		return nil
	}
	return &p.services[p.selectedIndex]
}

func (p *ServicesPanel) StartService() {
	service := p.GetSelectedService()
	if service == nil {
		return
	}

	err := utils.StartService(service.Name)
	if err != nil {
		p.setStatus("Failed to start service: "+err.Error(), true)
	} else {
		p.setStatus("✓ Service started: "+service.Name, false)
		// Wait a moment for systemd to update before refreshing
		time.Sleep(300 * time.Millisecond)
		p.Update() // Refresh service list
	}
}

func (p *ServicesPanel) StopService() {
	service := p.GetSelectedService()
	if service == nil {
		return
	}

	err := utils.StopService(service.Name)
	if err != nil {
		p.setStatus("Failed to stop service: "+err.Error(), true)
	} else {
		p.setStatus("✓ Service stopped: "+service.Name, false)
		// Wait a moment for systemd to update before refreshing
		time.Sleep(300 * time.Millisecond)
		p.Update() // Refresh service list
	}
}

func (p *ServicesPanel) RestartService() {
	service := p.GetSelectedService()
	if service == nil {
		return
	}

	err := utils.RestartService(service.Name)
	if err != nil {
		p.setStatus("Failed to restart service: "+err.Error(), true)
	} else {
		p.setStatus("✓ Service restarted: "+service.Name, false)
		// Wait a moment for systemd to update before refreshing
		time.Sleep(300 * time.Millisecond)
		p.Update() // Refresh service list
	}
}

func (p *ServicesPanel) EnableService() {
	service := p.GetSelectedService()
	if service == nil {
		return
	}

	err := utils.EnableService(service.Name)
	if err != nil {
		p.setStatus("Failed to enable service: "+err.Error(), true)
	} else {
		p.setStatus("✓ Service enabled: "+service.Name, false)
		// Wait a moment for systemd to update before refreshing
		time.Sleep(300 * time.Millisecond)
		p.Update() // Refresh service list
	}
}

func (p *ServicesPanel) DisableService() {
	service := p.GetSelectedService()
	if service == nil {
		return
	}

	err := utils.DisableService(service.Name)
	if err != nil {
		p.setStatus("Failed to disable service: "+err.Error(), true)
	} else {
		p.setStatus("✓ Service disabled: "+service.Name, false)
		// Wait a moment for systemd to update before refreshing
		time.Sleep(300 * time.Millisecond)
		p.Update() // Refresh service list
	}
}

func (p *ServicesPanel) setStatus(message string, isError bool) {
	p.statusMessage = message
	p.statusTime = time.Now()
	p.statusIsError = isError
}

func (p *ServicesPanel) ClearOldStatus() {
	// Clear status message after 5 seconds
	if p.statusMessage != "" && time.Since(p.statusTime) > 5*time.Second {
		p.statusMessage = ""
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

	// Clear old status messages
	p.ClearOldStatus()

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

	// Render keyboard shortcuts
	shortcuts := "\n" + styles.HelpStyle.Render("s:Start | x:Stop | r:Restart | e:Enable | d:Disable")

	// Render status message if present
	statusLine := ""
	if p.statusMessage != "" {
		statusStyle := styles.StatusRunningStyle
		if p.statusIsError {
			statusStyle = styles.StatusStoppedStyle
		}
		statusLine = "\n" + statusStyle.Render(p.statusMessage)
	}

	content := lipgloss.JoinVertical(
		lipgloss.Left,
		header,
		"",
		strings.Join(items, "\n"),
		shortcuts,
		statusLine,
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
