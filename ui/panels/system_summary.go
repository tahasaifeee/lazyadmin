package panels

import (
	"fmt"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type SystemSummaryPanel struct {
	systemInfo *utils.SystemInfo
}

func NewSystemSummaryPanel() *SystemSummaryPanel {
	return &SystemSummaryPanel{}
}

func (p *SystemSummaryPanel) Update() {
	info, err := utils.GetSystemInfo()
	if err == nil {
		p.systemInfo = info
	}
}

func (p *SystemSummaryPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if p.systemInfo == nil {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("⚙ System Summary"),
			"",
			"Loading system information...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	info := p.systemInfo

	// Build content
	content := lipgloss.JoinVertical(
		lipgloss.Left,
		titleStyle.Render("⚙ System Summary"),
		"",
		styles.KeyStyle.Render("Hostname:     ")+styles.ValueStyle.Render(info.Hostname),
		styles.KeyStyle.Render("OS:           ")+styles.ValueStyle.Render(info.OS),
		styles.KeyStyle.Render("Platform:     ")+styles.ValueStyle.Render(info.Platform),
		styles.KeyStyle.Render("Kernel:       ")+styles.ValueStyle.Render(info.KernelVersion),
		styles.KeyStyle.Render("Uptime:       ")+styles.ValueStyle.Render(info.Uptime),
		"",
		styles.KeyStyle.Render("CPU Model:    ")+styles.ValueStyle.Render(info.CPUModel),
		styles.KeyStyle.Render("CPU Cores:    ")+styles.ValueStyle.Render(fmt.Sprintf("%d", info.CPUCores)),
		styles.KeyStyle.Render("CPU Usage:    ")+styles.ValueStyle.Render(fmt.Sprintf("%.1f%%", info.CPUUsage)),
		renderProgressBar(info.CPUUsage, width-20),
		"",
		styles.KeyStyle.Render("Memory Total: ")+styles.ValueStyle.Render(utils.FormatBytes(info.MemTotal)),
		styles.KeyStyle.Render("Memory Used:  ")+styles.ValueStyle.Render(utils.FormatBytes(info.MemUsed)),
		styles.KeyStyle.Render("Memory Usage: ")+styles.ValueStyle.Render(fmt.Sprintf("%.1f%%", info.MemPercent)),
		renderProgressBar(info.MemPercent, width-20),
	)

	return style.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}

func renderProgressBar(percent float64, width int) string {
	if width < 10 {
		width = 10
	}
	if width > 50 {
		width = 50
	}

	filled := int(percent / 100 * float64(width))
	if filled > width {
		filled = width
	}
	empty := width - filled

	var barStyle lipgloss.Style
	if percent >= 80 {
		barStyle = styles.StatusFailedStyle
	} else if percent >= 60 {
		barStyle = styles.StatusWarningStyle
	} else {
		barStyle = styles.StatusRunningStyle
	}

	bar := barStyle.Render(lipgloss.PlaceHorizontal(filled, lipgloss.Left, "█")) +
		styles.StatusInactiveStyle.Render(lipgloss.PlaceHorizontal(empty, lipgloss.Left, "░"))

	return "  " + bar
}
