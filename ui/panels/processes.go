package panels

import (
	"fmt"
	"sort"
	"strings"

	"github.com/charmbracelet/lipgloss"
	"github.com/tahasaifeee/lazyadmin/styles"
	"github.com/tahasaifeee/lazyadmin/utils"
)

type ProcessesPanel struct {
	processes     []utils.ProcessInfo
	selectedIndex int
	scrollOffset  int
}

func NewProcessesPanel() *ProcessesPanel {
	return &ProcessesPanel{
		selectedIndex: 0,
		scrollOffset:  0,
	}
}

func (p *ProcessesPanel) Update() {
	processes, err := utils.GetProcesses()
	if err == nil {
		// Sort by CPU usage (descending)
		sort.Slice(processes, func(i, j int) bool {
			return processes[i].CPUPerc > processes[j].CPUPerc
		})
		// Limit to top 100 processes
		if len(processes) > 100 {
			processes = processes[:100]
		}
		p.processes = processes
	}
}

func (p *ProcessesPanel) MoveUp() {
	if p.selectedIndex > 0 {
		p.selectedIndex--
		if p.selectedIndex < p.scrollOffset {
			p.scrollOffset = p.selectedIndex
		}
	}
}

func (p *ProcessesPanel) MoveDown() {
	if p.selectedIndex < len(p.processes)-1 {
		p.selectedIndex++
	}
}

func (p *ProcessesPanel) Render(width, height int, active bool) string {
	style := styles.PanelStyle
	titleStyle := styles.TitleStyle
	if active {
		style = styles.ActivePanelStyle
		titleStyle = styles.ActiveTitleStyle
	}

	if len(p.processes) == 0 {
		content := lipgloss.JoinVertical(
			lipgloss.Left,
			titleStyle.Render("⚡ Processes"),
			"",
			"Loading processes...",
		)
		return style.Width(width - 4).Height(height - 4).Render(content)
	}

	// Adjust scroll offset
	visibleLines := height - 10
	if p.selectedIndex >= p.scrollOffset+visibleLines {
		p.scrollOffset = p.selectedIndex - visibleLines + 1
	}

	// Render header
	header := titleStyle.Render("⚡ Processes") + "\n\n"
	header += styles.HelpStyle.Render(fmt.Sprintf("Top %d processes by CPU usage", len(p.processes)))

	// Column headers
	columnHeader := fmt.Sprintf("  %-8s %-25s %8s %8s %10s",
		"PID", "Name", "CPU%", "MEM%", "Status")
	header += "\n" + styles.KeyStyle.Render(columnHeader)

	// Render process list
	var items []string
	end := p.scrollOffset + visibleLines
	if end > len(p.processes) {
		end = len(p.processes)
	}

	for i := p.scrollOffset; i < end; i++ {
		proc := p.processes[i]
		itemStr := p.renderProcess(proc, i == p.selectedIndex)
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

func (p *ProcessesPanel) renderProcess(proc utils.ProcessInfo, selected bool) string {
	// Truncate name if too long
	name := proc.Name
	if len(name) > 25 {
		name = name[:22] + "..."
	}

	// Color CPU usage
	cpuStyle := styles.ValueStyle
	if proc.CPUPerc > 50 {
		cpuStyle = styles.StatusWarningStyle
	}
	if proc.CPUPerc > 80 {
		cpuStyle = styles.StatusStoppedStyle
	}

	itemText := fmt.Sprintf("%-8d %-25s %s %s %-10s",
		proc.PID,
		name,
		cpuStyle.Render(fmt.Sprintf("%7.1f%%", proc.CPUPerc)),
		styles.ValueStyle.Render(fmt.Sprintf("%7.1f%%", proc.MemPerc)),
		proc.Status,
	)

	if selected {
		return styles.SelectedItemStyle.Render("▶ " + itemText)
	}
	return styles.ItemStyle.Render("  " + itemText)
}
