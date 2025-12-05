package panels

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type FilesystemsInfoPanel struct {
	filesystems []utils.FilesystemInfo
	selectedIndex int
	scrollOffset int
}

func NewFilesystemsInfoPanel() *FilesystemsInfoPanel {
	return &FilesystemsInfoPanel{}
}

func (p *FilesystemsInfoPanel) Update() {
	filesystems, err := utils.GetFilesystems()
	if err == nil {
		p.filesystems = filesystems
	}
}

func (p *FilesystemsInfoPanel) MoveUp() {
	if p.selectedIndex > 0 {
		p.selectedIndex--
		if p.selectedIndex < p.scrollOffset {
			p.scrollOffset = p.selectedIndex
		}
	}
}

func (p *FilesystemsInfoPanel) MoveDown() {
	if p.selectedIndex < len(p.filesystems)-1 {
		p.selectedIndex++
	}
}

func (p *FilesystemsInfoPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.filesystems) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("💿 Mounted Filesystems"),
			"",
			"Loading filesystem information...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Header
	header := titleStyle.Render("💿 Mounted Filesystems") + "\n\n"
	header += styles.HelpStyle.Render(fmt.Sprintf("Total: %d mounted filesystems", len(p.filesystems)))

	// Calculate visible lines
	visibleLines := height - 10
	if p.selectedIndex >= p.scrollOffset+visibleLines {
		p.scrollOffset = p.selectedIndex - visibleLines + 1
	}

	var items []string
	end := p.scrollOffset + visibleLines
	if end > len(p.filesystems) {
		end = len(p.filesystems)
	}

	for i := p.scrollOffset; i < end; i++ {
		fs := p.filesystems[i]
		itemText := fmt.Sprintf("%-25s %-10s %-8s / %-8s (%s)",
			fs.MountPoint,
			fs.FSType,
			fs.Used,
			fs.Size,
			fs.UsePercent,
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
