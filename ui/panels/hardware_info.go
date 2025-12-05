package panels

import (
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type HardwareInfoPanel struct {
	hardwareInfo string
	scrollOffset int
}

func NewHardwareInfoPanel() *HardwareInfoPanel {
	return &HardwareInfoPanel{}
}

func (p *HardwareInfoPanel) Update() {
	info, err := utils.GetHardwareInfo()
	if err == nil {
		p.hardwareInfo = info
	}
}

func (p *HardwareInfoPanel) MoveUp() {
	if p.scrollOffset > 0 {
		p.scrollOffset--
	}
}

func (p *HardwareInfoPanel) MoveDown() {
	p.scrollOffset++
}

func (p *HardwareInfoPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if p.hardwareInfo == "" {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("🖥 Hardware Information"),
			"",
			"Loading hardware information...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Split into lines
	lines := strings.Split(p.hardwareInfo, "\n")

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
		titleStyle.Render("🖥 Hardware Information"),
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
