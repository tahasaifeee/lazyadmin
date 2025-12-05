package utils

import (
	"fmt"
	"os"
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

// GetHardwareInfo returns detailed hardware information
func GetHardwareInfo() (string, error) {
	var result strings.Builder

	// Try lshw first (more detailed, requires sudo)
	cmd := exec.Command("lshw", "-short")
	output, err := cmd.Output()
	if err == nil {
		return string(output), nil
	}

	// Try dmidecode (requires sudo)
	cmd = exec.Command("dmidecode", "-t", "system,baseboard,processor,memory")
	output, err = cmd.Output()
	if err == nil {
		return string(output), nil
	}

	// Fallback: Read hardware info from /proc (doesn't require sudo)
	result.WriteString("=== Hardware Information ===\n")
	result.WriteString("(For detailed info, run with sudo)\n\n")

	// CPU Information from /proc/cpuinfo
	cpuinfo, err := os.ReadFile("/proc/cpuinfo")
	if err == nil {
		result.WriteString("--- CPU Information ---\n")
		lines := strings.Split(string(cpuinfo), "\n")

		// Track CPU cores
		coreCount := 0
		seen := make(map[string]bool)

		for _, line := range lines {
			line = strings.TrimSpace(line)

			// Get model name
			if strings.HasPrefix(line, "model name") {
				if parts := strings.SplitN(line, ":", 2); len(parts) == 2 {
					model := strings.TrimSpace(parts[1])
					if !seen["model"] {
						result.WriteString(fmt.Sprintf("Model: %s\n", model))
						seen["model"] = true
					}
				}
			}

			// Count processors
			if strings.HasPrefix(line, "processor") {
				coreCount++
			}

			// Get CPU MHz
			if strings.HasPrefix(line, "cpu MHz") && !seen["mhz"] {
				if parts := strings.SplitN(line, ":", 2); len(parts) == 2 {
					result.WriteString(fmt.Sprintf("CPU MHz: %s\n", strings.TrimSpace(parts[1])))
					seen["mhz"] = true
				}
			}

			// Get cache size
			if strings.HasPrefix(line, "cache size") && !seen["cache"] {
				if parts := strings.SplitN(line, ":", 2); len(parts) == 2 {
					result.WriteString(fmt.Sprintf("Cache Size: %s\n", strings.TrimSpace(parts[1])))
					seen["cache"] = true
				}
			}
		}

		result.WriteString(fmt.Sprintf("CPU Cores: %d\n\n", coreCount))
	}

	// Memory Information from /proc/meminfo
	meminfo, err := os.ReadFile("/proc/meminfo")
	if err == nil {
		result.WriteString("--- Memory Information ---\n")
		lines := strings.Split(string(meminfo), "\n")

		for _, line := range lines {
			line = strings.TrimSpace(line)

			// Show key memory metrics
			if strings.HasPrefix(line, "MemTotal:") ||
			   strings.HasPrefix(line, "MemAvailable:") ||
			   strings.HasPrefix(line, "SwapTotal:") ||
			   strings.HasPrefix(line, "SwapFree:") {
				if parts := strings.SplitN(line, ":", 2); len(parts) == 2 {
					result.WriteString(fmt.Sprintf("%s: %s\n", parts[0], strings.TrimSpace(parts[1])))
				}
			}
		}
		result.WriteString("\n")
	}

	// PCI Devices (if lspci is available, doesn't require sudo)
	cmd = exec.Command("lspci")
	output, err = cmd.Output()
	if err == nil {
		result.WriteString("--- PCI Devices ---\n")
		result.WriteString(string(output))
		result.WriteString("\n")
	}

	// USB Devices (if lsusb is available, doesn't require sudo)
	cmd = exec.Command("lsusb")
	output, err = cmd.Output()
	if err == nil {
		result.WriteString("--- USB Devices ---\n")
		result.WriteString(string(output))
		result.WriteString("\n")
	}

	// Block Devices
	cmd = exec.Command("lsblk", "-o", "NAME,SIZE,TYPE,MOUNTPOINT,MODEL")
	output, err = cmd.Output()
	if err == nil {
		result.WriteString("--- Block Devices ---\n")
		result.WriteString(string(output))
		result.WriteString("\n")
	}

	resultStr := result.String()
	if len(resultStr) == 0 {
		return "Hardware information unavailable.", nil
	}

	return resultStr, nil
}

// NetworkInterface represents a network interface
type NetworkInterface struct {
	Name      string
	IPAddress string
	MAC       string
	Status    string
}

// GetNetworkInterfaces returns information about network interfaces
func GetNetworkInterfaces() ([]NetworkInterface, error) {
	var interfaces []NetworkInterface

	// Get interface list and IPs
	cmd := exec.Command("ip", "-brief", "addr", "show")
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
		if len(fields) < 3 {
			continue
		}

		iface := NetworkInterface{
			Name:   fields[0],
			Status: fields[1],
		}

		// Extract IP address (may be multiple)
		if len(fields) >= 3 {
			iface.IPAddress = strings.Join(fields[2:], ", ")
		}

		// Get MAC address
		macCmd := exec.Command("cat", fmt.Sprintf("/sys/class/net/%s/address", iface.Name))
		macOutput, err := macCmd.Output()
		if err == nil {
			iface.MAC = strings.TrimSpace(string(macOutput))
		}

		interfaces = append(interfaces, iface)
	}

	return interfaces, nil
}

// PortInfo represents a listening port
type PortInfo struct {
	Protocol string
	Port     string
	Process  string
	State    string
}

// GetListeningPorts returns information about listening ports
func GetListeningPorts() ([]PortInfo, error) {
	var ports []PortInfo

	// Use ss command (modern alternative to netstat)
	cmd := exec.Command("ss", "-tulpn")
	output, err := cmd.Output()
	if err != nil {
		// Fallback to netstat
		cmd = exec.Command("netstat", "-tulpn")
		output, err = cmd.Output()
		if err != nil {
			return nil, err
		}
	}

	lines := strings.Split(string(output), "\n")
	for i, line := range lines {
		if i == 0 || line == "" {
			continue // Skip header
		}

		fields := strings.Fields(line)
		if len(fields) < 5 {
			continue
		}

		port := PortInfo{
			Protocol: fields[0],
			State:    fields[1],
		}

		// Extract port from local address (format: 0.0.0.0:80 or *:80)
		localAddr := fields[4]
		if idx := strings.LastIndex(localAddr, ":"); idx != -1 {
			port.Port = localAddr[idx+1:]
		}

		// Extract process info if available
		if len(fields) >= 7 {
			port.Process = fields[6]
		}

		ports = append(ports, port)
	}

	return ports, nil
}

// GetSystemLogs returns recent system logs from journalctl
func GetSystemLogs(lines int) (string, error) {
	cmd := exec.Command("journalctl", "-n", fmt.Sprintf("%d", lines), "--no-pager")
	output, err := cmd.Output()
	if err != nil {
		return "System logs unavailable. Please run with sudo.", nil
	}
	return string(output), nil
}

// FilesystemInfo represents mounted filesystem information
type FilesystemInfo struct {
	Device     string
	MountPoint string
	FSType     string
	Size       string
	Used       string
	Available  string
	UsePercent string
}

// GetFilesystems returns information about mounted filesystems
func GetFilesystems() ([]FilesystemInfo, error) {
	var filesystems []FilesystemInfo

	cmd := exec.Command("df", "-h", "-T")
	output, err := cmd.Output()
	if err != nil {
		return nil, err
	}

	lines := strings.Split(string(output), "\n")
	for i, line := range lines {
		if i == 0 || line == "" {
			continue // Skip header
		}

		fields := strings.Fields(line)
		if len(fields) < 7 {
			continue
		}

		fs := FilesystemInfo{
			Device:     fields[0],
			FSType:     fields[1],
			Size:       fields[2],
			Used:       fields[3],
			Available:  fields[4],
			UsePercent: fields[5],
			MountPoint: fields[6],
		}

		filesystems = append(filesystems, fs)
	}

	return filesystems, nil
}

// UserInfo represents user account information
type UserInfo struct {
	Username string
	UID      string
	GID      string
	Home     string
	Shell    string
	Status   string // locked/unlocked
}

// GroupInfo represents group information
type GroupInfo struct {
	Name    string
	GID     string
	Members string
}

// GetUsers returns list of all users from /etc/passwd
func GetUsers() ([]UserInfo, error) {
	var users []UserInfo

	data, err := os.ReadFile("/etc/passwd")
	if err != nil {
		return nil, err
	}

	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		if line == "" {
			continue
		}

		fields := strings.Split(line, ":")
		if len(fields) < 7 {
			continue
		}

		// Check if user is locked (from /etc/shadow if readable)
		status := "unlocked"
		shadowCmd := exec.Command("passwd", "-S", fields[0])
		shadowOutput, err := shadowCmd.Output()
		if err == nil {
			if strings.Contains(string(shadowOutput), "L ") {
				status = "locked"
			}
		}

		users = append(users, UserInfo{
			Username: fields[0],
			UID:      fields[2],
			GID:      fields[3],
			Home:     fields[5],
			Shell:    fields[6],
			Status:   status,
		})
	}

	return users, nil
}

// GetGroups returns list of all groups from /etc/group
func GetGroups() ([]GroupInfo, error) {
	var groups []GroupInfo

	data, err := os.ReadFile("/etc/group")
	if err != nil {
		return nil, err
	}

	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		if line == "" {
			continue
		}

		fields := strings.Split(line, ":")
		if len(fields) < 4 {
			continue
		}

		groups = append(groups, GroupInfo{
			Name:    fields[0],
			GID:     fields[2],
			Members: fields[3],
		})
	}

	return groups, nil
}

// CreateUser creates a new user account
func CreateUser(username, password string) error {
	// Create user
	cmd := exec.Command("useradd", "-m", username)
	if err := cmd.Run(); err != nil {
		return fmt.Errorf("failed to create user: %w", err)
	}

	// Set password if provided
	if password != "" {
		cmd = exec.Command("chpasswd")
		cmd.Stdin = strings.NewReader(fmt.Sprintf("%s:%s", username, password))
		if err := cmd.Run(); err != nil {
			return fmt.Errorf("failed to set password: %w", err)
		}
	}

	return nil
}

// DeleteUser deletes a user account
func DeleteUser(username string, removeHome bool) error {
	args := []string{username}
	if removeHome {
		args = append([]string{"-r"}, args...)
	}

	cmd := exec.Command("userdel", args...)
	return cmd.Run()
}

// AddUserToGroup adds a user to a group
func AddUserToGroup(username, groupname string) error {
	cmd := exec.Command("usermod", "-aG", groupname, username)
	return cmd.Run()
}

// RemoveUserFromGroup removes a user from a group
func RemoveUserFromGroup(username, groupname string) error {
	cmd := exec.Command("gpasswd", "-d", username, groupname)
	return cmd.Run()
}

// SetUserPassword sets or resets a user's password
func SetUserPassword(username, password string) error {
	cmd := exec.Command("chpasswd")
	cmd.Stdin = strings.NewReader(fmt.Sprintf("%s:%s", username, password))
	return cmd.Run()
}

// ChangeUserShell changes a user's login shell
func ChangeUserShell(username, shell string) error {
	cmd := exec.Command("chsh", "-s", shell, username)
	return cmd.Run()
}

// LockUserAccount locks a user account
func LockUserAccount(username string) error {
	cmd := exec.Command("passwd", "-l", username)
	return cmd.Run()
}

// UnlockUserAccount unlocks a user account
func UnlockUserAccount(username string) error {
	cmd := exec.Command("passwd", "-u", username)
	return cmd.Run()
}
