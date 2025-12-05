package panels

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type DiskPanel struct {
	disks         []utils.DiskInfo
	selectedIndex int
}

func NewDiskPanel() *DiskPanel {
	return &DiskPanel{
		selectedIndex: 0,
	}
}

func (p *DiskPanel) Update() {
	disks, err := utils.GetDiskInfo()
	if err == nil {
		p.disks = disks
	}
}

func (p *DiskPanel) MoveUp() {
	if p.selectedIndex > 0 {
		p.selectedIndex--
	}
}

func (p *DiskPanel) MoveDown() {
	if p.selectedIndex < len(p.disks)-1 {
		p.selectedIndex++
	}
}

func (p *DiskPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.disks) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("💾 Disk Usage"),
			"",
			"Loading disk information...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Render header
	header := titleStyle.Render("💾 Disk Usage") + "\n\n"

	// Render disk list
	var items []string
	for i, disk := range p.disks {
		itemStr := p.renderDisk(disk, i == p.selectedIndex)
		items = append(items, itemStr)
		items = append(items, "") // Add spacing between disks
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

func (p *DiskPanel) renderDisk(disk utils.DiskInfo, selected bool) string {
	// Mount point with filesystem type
	mountInfo := fmt.Sprintf("%s (%s)", disk.MountPoint, disk.Filesystem)

	// Usage info
	usageInfo := fmt.Sprintf("%s / %s (%s free)",
		utils.FormatBytes(disk.Used),
		utils.FormatBytes(disk.Total),
		utils.FormatBytes(disk.Free),
	)

	// Progress bar
	bar := p.renderProgressBar(disk.Percent, 40)
	usageBar := fmt.Sprintf("%s %.1f%%", bar, disk.Percent)

	var lines []string
	if selected {
		lines = append(lines, styles.SelectedItemStyle.Render("▶ "+mountInfo))
		lines = append(lines, styles.ItemStyle.Render("  "+usageInfo))
		lines = append(lines, styles.ItemStyle.Render("  "+usageBar))
	} else {
		lines = append(lines, styles.ItemStyle.Render("  "+mountInfo))
		lines = append(lines, styles.ItemStyle.Render("  "+usageInfo))
		lines = append(lines, styles.ItemStyle.Render("  "+usageBar))
	}

	return strings.Join(lines, "\n")
}

func (p *DiskPanel) renderProgressBar(percent float64, width int) string {
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
