package panels

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type SystemPanel struct {
	info *utils.SystemInfo
}

func NewSystemPanel() *SystemPanel {
	return &SystemPanel{}
}

func (p *SystemPanel) Update() {
	info, err := utils.GetSystemInfo()
	if err == nil {
		p.info = info
	}
}

func (p *SystemPanel) Render(width, height int, active bool) string {
	if p.info == nil {
		return "Loading system information..."
	}

	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	content := lipgloss.JoinVertical(
		lipgloss.Left,
		titleStyle.Render("⚙ System Information"),
		"",
		p.renderRow("Hostname", p.info.Hostname),
		p.renderRow("OS", fmt.Sprintf("%s (%s)", p.info.OS, p.info.Platform)),
		p.renderRow("Kernel", p.info.KernelVersion),
		p.renderRow("Uptime", p.info.Uptime),
		"",
		p.renderRow("CPU Model", p.info.CPUModel),
		p.renderRow("CPU Cores", fmt.Sprintf("%d", p.info.CPUCores)),
		p.renderCPUUsage(),
		"",
		p.renderRow("Memory Total", utils.FormatBytes(p.info.MemTotal)),
		p.renderRow("Memory Used", utils.FormatBytes(p.info.MemUsed)),
		p.renderMemoryUsage(),
	)

	return style.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}

func (p *SystemPanel) renderRow(key, value string) string {
	return fmt.Sprintf("%s %s",
		styles.KeyStyle.Render(fmt.Sprintf("%-15s:", key)),
		styles.ValueStyle.Render(value),
	)
}

func (p *SystemPanel) renderCPUUsage() string {
	bar := p.renderProgressBar(p.info.CPUUsage, 30)
	return fmt.Sprintf("%s %s %s",
		styles.KeyStyle.Render(fmt.Sprintf("%-15s:", "CPU Usage")),
		bar,
		styles.ValueStyle.Render(fmt.Sprintf("%.1f%%", p.info.CPUUsage)),
	)
}

func (p *SystemPanel) renderMemoryUsage() string {
	bar := p.renderProgressBar(p.info.MemPercent, 30)
	return fmt.Sprintf("%s %s %s",
		styles.KeyStyle.Render(fmt.Sprintf("%-15s:", "Memory Usage")),
		bar,
		styles.ValueStyle.Render(fmt.Sprintf("%.1f%%", p.info.MemPercent)),
	)
}

func (p *SystemPanel) renderProgressBar(percent float64, width int) string {
	filled := int(percent / 100 * float64(width))
	if filled > width {
		filled = width
	}

	var color lipgloss.Color
	if percent < 60 {
		color = lipgloss.Color("#10B981") // Green
	} else if percent < 80 {
		color = lipgloss.Color("#F59E0B") // Orange
	} else {
		color = lipgloss.Color("#EF4444") // Red
	}

	filledBar := lipgloss.NewStyle().
		Foreground(color).
		Render(string([]rune(strings.Repeat("█", filled))))

	emptyBar := lipgloss.NewStyle().
		Foreground(lipgloss.Color("#374151")).
		Render(string([]rune(strings.Repeat("░", width-filled))))

	return filledBar + emptyBar
}
