source "proxmox-iso" "almalinux10-proxmox" {
	proxmox_url              = var.proxmox_api_url
	username                 = var.proxmox_api_token_id
	token                    = var.proxmox_api_token_secret
	insecure_skip_tls_verify = true

	node                     = var.proxmox_node
	vm_name                  = "almalinux-server-10"
	vm_id                    = "9100"
	tags                     = "almalinux"

	boot                     = "order=scsi0;ide0"
	memory                   = 2048
	cores                    = 2
	cpu_type                 = "x86-64-v3"
	sockets                  = 2
	os                       = "l26"

	qemu_agent               = true
	scsi_controller          = "virtio-scsi-pci"
	onboot                   = false
	cloud_init               = true
	cloud_init_storage_pool  = "local-lvm"

	ssh_username             = "root"
	ssh_password             = "almalinux"
	ssh_timeout              = "10m"

	http_directory           = "http"

	boot_wait                = "10s"
	boot_command             = [
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
		"inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/almalinux-10.proxmox-x86_64.ks",
		"<leftCtrlOn>x<leftCtrlOff>",
	]

	vga {
		type = "serial0"
	}

	boot_iso {
		type             = "ide"
		iso_url          = "https://raw.repo.almalinux.org/almalinux/10.1/isos/x86_64/AlmaLinux-10-latest-x86_64-minimal.iso"
		unmount          = true
		iso_checksum     = "sha256:049efd183a5a841dd432b3427eb6faa7deb3bf6c6bf2c63cbffa024b9c651725"
		iso_storage_pool = "local"
	}

	network_adapters {
		model    = "virtio"
		bridge   = "vmbr0"
		firewall = true
	}

	disks {
		type         = "scsi"
		storage_pool = "local-lvm"
		disk_size    = "10G"
	}
}

build {
  sources = ["source.proxmox-iso.almalinux10-proxmox"]
}