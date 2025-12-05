package panels

import (
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type SystemLogsPanel struct {
	logs         string
	scrollOffset int
}

func NewSystemLogsPanel() *SystemLogsPanel {
	return &SystemLogsPanel{}
}

func (p *SystemLogsPanel) Update() {
	logs, err := utils.GetSystemLogs(100)
	if err == nil {
		p.logs = logs
	}
}

func (p *SystemLogsPanel) MoveUp() {
	if p.scrollOffset > 0 {
		p.scrollOffset--
	}
}

func (p *SystemLogsPanel) MoveDown() {
	p.scrollOffset++
}

func (p *SystemLogsPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if p.logs == "" {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("📋 System Logs"),
			"",
			"Loading system logs...",
			"",
			styles.HelpStyle.Render("(Please run with sudo to view system logs)"),
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Split into lines
	lines := strings.Split(p.logs, "\n")

	// Calculate visible lines
	visibleLines := height - 8
	if p.scrollOffset >= len(lines)-visibleLines && len(lines) > visibleLines {
		p.scrollOffset = len(lines) - visibleLines
	}
	if p.scrollOffset < 0 {
		p.scrollOffset = 0
	}

	// Get visible portion
	end := p.scrollOffset + visibleLines
	if end > len(lines) {
		end = len(lines)
	}

	visibleContent := strings.Join(lines[p.scrollOffset:end], "\n")

	content := lipgloss.JoinVertical(
		lipgloss.Left,
		titleStyle.Render("📋 System Logs (Last 100)"),
		"",
		styles.HelpStyle.Render("Use ↑↓/jk to scroll"),
		"",
		visibleContent,
	)

	return style.
		Width(width - 4).
		Height(height - 4).
		Render(content)
}
