package utils

import (
	"fmt"
	"os/exec"
	"runtime"
	"strings"
	"time"

	"github.com/shirou/gopsutil/v3/cpu"
	"github.com/shirou/gopsutil/v3/disk"
	"github.com/shirou/gopsutil/v3/host"
	"github.com/shirou/gopsutil/v3/mem"
	"github.com/shirou/gopsutil/v3/process"
)

type SystemInfo struct {
	Hostname        string
	OS              string
	Platform        string
	KernelVersion   string
	Uptime          string
	CPUModel        string
	CPUCores        int
	CPUUsage        float64
	MemTotal        uint64
	MemUsed         uint64
	MemPercent      float64
}

type DiskInfo struct {
	MountPoint string
	Total      uint64
	Used       uint64
	Free       uint64
	Percent    float64
	Filesystem string
}

type ProcessInfo struct {
	PID     int32
	Name    string
	CPUPerc float64
	MemPerc float32
	Status  string
}

type ServiceInfo struct {
	Name         string
	Status       string
	Active       bool
	Enabled      string
	LoadState    string
	SubState     string
}

func GetSystemInfo() (*SystemInfo, error) {
	info := &SystemInfo{}

	// Host info
	hostInfo, err := host.Info()
	if err == nil {
		info.Hostname = hostInfo.Hostname
		info.OS = hostInfo.OS
		info.Platform = hostInfo.Platform
		info.KernelVersion = hostInfo.KernelVersion

		uptime := time.Duration(hostInfo.Uptime) * time.Second
		days := uptime / (24 * time.Hour)
		hours := (uptime % (24 * time.Hour)) / time.Hour
		minutes := (uptime % time.Hour) / time.Minute
		info.Uptime = fmt.Sprintf("%dd %dh %dm", days, hours, minutes)
	}

	// CPU info
	cpuInfo, err := cpu.Info()
	if err == nil && len(cpuInfo) > 0 {
		info.CPUModel = cpuInfo[0].ModelName
	}
	info.CPUCores = runtime.NumCPU()

	// CPU usage
	cpuPercent, err := cpu.Percent(time.Second, false)
	if err == nil && len(cpuPercent) > 0 {
		info.CPUUsage = cpuPercent[0]
	}

	// Memory info
	memInfo, err := mem.VirtualMemory()
	if err == nil {
		info.MemTotal = memInfo.Total
		info.MemUsed = memInfo.Used
		info.MemPercent = memInfo.UsedPercent
	}

	return info, nil
}

func GetDiskInfo() ([]DiskInfo, error) {
	var disks []DiskInfo

	partitions, err := disk.Partitions(false)
	if err != nil {
		return nil, err
	}

	for _, partition := range partitions {
		usage, err := disk.Usage(partition.Mountpoint)
		if err != nil {
			continue
		}

		disks = append(disks, DiskInfo{
			MountPoint: partition.Mountpoint,
			Total:      usage.Total,
			Used:       usage.Used,
			Free:       usage.Free,
			Percent:    usage.UsedPercent,
			Filesystem: partition.Fstype,
		})
	}

	return disks, nil
}

func GetProcesses() ([]ProcessInfo, error) {
	var processes []ProcessInfo

	procs, err := process.Processes()
	if err != nil {
		return nil, err
	}

	for _, p := range procs {
		name, err := p.Name()
		if err != nil {
			continue
		}

		cpuPerc, _ := p.CPUPercent()
		memPerc, _ := p.MemoryPercent()
		status, _ := p.Status()

		processes = append(processes, ProcessInfo{
			PID:     p.Pid,
			Name:    name,
			CPUPerc: cpuPerc,
			MemPerc: memPerc,
			Status:  strings.Join(status, ","),
		})
	}

	return processes, nil
}

func GetServices() ([]ServiceInfo, error) {
	serviceMap := make(map[string]*ServiceInfo)

	// First, get all unit files (this includes disabled services)
	cmd := exec.Command("systemctl", "list-unit-files", "--type=service", "--no-pager", "--no-legend")
	output, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	lines := strings.Split(string(output), "\n")
	for _, line := range lines {
		if line == "" {
			continue
		}

		fields := strings.Fields(line)
		if len(fields) < 2 {
			continue
		}

		name := fields[0]
		enabledState := fields[1]

		// Filter out services with "not-found" or similar issues
		if strings.Contains(enabledState, "not-found") || strings.Contains(name, "not-found") {
			continue
		}

		serviceMap[name] = &ServiceInfo{
			Name:    name,
			Enabled: enabledState,
			Status:  "inactive",
			Active:  false,
		}
	}

	// Now get the runtime state of all services
	cmd = exec.Command("systemctl", "list-units", "--type=service", "--all", "--no-pager", "--no-legend")
	output, err = cmd.Output()
	if err != nil {
		// Continue with what we have
		goto returnServices
	}

	lines = strings.Split(string(output), "\n")
	for _, line := range lines {
		if line == "" {
			continue
		}

		fields := strings.Fields(line)
		if len(fields) < 4 {
			continue
		}

		name := fields[0]
		loadState := fields[1]
		activeState := fields[2]
		subState := fields[3]

		// Filter out not-found services
		if strings.Contains(loadState, "not-found") || strings.Contains(activeState, "not-found") {
			delete(serviceMap, name)
			continue
		}

		// Update or create service info
		if svc, exists := serviceMap[name]; exists {
			svc.LoadState = loadState
			svc.Status = activeState
			svc.SubState = subState
			svc.Active = activeState == "active"
		} else {
			// Service is loaded but not in unit-files list (rare case)
			serviceMap[name] = &ServiceInfo{
				Name:      name,
				LoadState: loadState,
				Status:    activeState,
				SubState:  subState,
				Active:    activeState == "active",
				Enabled:   "unknown",
			}
		}
	}

returnServices:
	// Convert map to slice
	var services []ServiceInfo
	for _, svc := range serviceMap {
		// Final filter for not-found
		if strings.Contains(svc.Name, "not-found") ||
		   strings.Contains(svc.Status, "not-found") ||
		   strings.Contains(svc.LoadState, "not-found") {
			continue
		}
		services = append(services, *svc)
	}

	return services, nil
}

// StartService starts a systemd service
func StartService(serviceName string) error {
	cmd := exec.Command("systemctl", "start", serviceName)
	return cmd.Run()
}

// StopService stops a systemd service
func StopService(serviceName string) error {
	cmd := exec.Command("systemctl", "stop", serviceName)
	return cmd.Run()
}

// RestartService restarts a systemd service
func RestartService(serviceName string) error {
	cmd := exec.Command("systemctl", "restart", serviceName)
	return cmd.Run()
}

// EnableService enables a systemd service to start on boot
func EnableService(serviceName string) error {
	cmd := exec.Command("systemctl", "enable", serviceName)
	return cmd.Run()
}

// DisableService disables a systemd service from starting on boot
func DisableService(serviceName string) error {
	cmd := exec.Command("systemctl", "disable", serviceName)
	return cmd.Run()
}

func FormatBytes(bytes uint64) string {
	const unit = 1024
	if bytes < unit {
		return fmt.Sprintf("%d B", bytes)
	}
	div, exp := uint64(unit), 0
	for n := bytes / unit; n >= unit; n /= unit {
		div *= unit
		exp++
	}
	return fmt.Sprintf("%.1f %ciB", float64(bytes)/float64(div), "KMGTPE"[exp])
}
