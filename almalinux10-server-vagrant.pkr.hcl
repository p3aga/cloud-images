source "qemu" "almalinux10-vagrant" {
	iso_url          = local.almalinux_10_iso_url
	iso_checksum     = local.almalinux_10_iso_checksum
	accelerator      = "kvm"
	disk_interface   = "virtio-scsi"
	disk_size        = local.disk_size
	disk_cache       = "unsafe"
	disk_compression = true
	headless         = false
	machine_type     = "q35"
	memory           = local.memory_size
	net_device       = "virtio-net"
	vm_name          = "AlmaLinux-10-vagrant-${formatdate("YYYYMMDD", timestamp())}.x86_64.qcow2"
	cpu_model        = "host"
	http_directory   = "http"
	shutdown_command = "echo vagrant | sudo -S /sbin/shutdown -hP now"
	ssh_username     = local.vagrant_ssh_username
	ssh_password     = local.vagrant_ssh_password
	ssh_timeout      = "10m"
	boot_wait        = "5s"
	boot_command     = [
		"e",
		"<down><down>",
		"<leftCtrlOn>e<leftCtrlOff>",
		"<spacebar>",
		"biosdevname=0",
		"<spacebar>",
		"net.ifnames=0",
		"<spacebar>",
		"inst.text",
		"<spacebar>",
		"inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux-10.vagrant-x86_64.ks",
		"<leftCtrlOn>x<leftCtrlOff>",
	]
}

build {
	sources = ["source.qemu.almalinux10-vagrant"]

	post-processors {
		post-processor "vagrant" {
			compression_level = 9
			output            = "almalinux10-server-vagrant-${formatdate("YYYYMMDD", timestamp())}.box"
		}
	}
}