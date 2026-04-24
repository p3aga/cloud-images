# default images variables
locals {
	disk_size   = "20G"
	memory_size = 2048
}

# vagrant images variables
locals {
	vagrant_ssh_username = "vagrant"
	vagrant_ssh_password = "vagrant"
}

# almalinux 10 variables
locals {
	almalinux_10_iso_url      = "https://raw.repo.almalinux.org/almalinux/10.1/isos/x86_64/AlmaLinux-10-latest-x86_64-minimal.iso"
	almalinux_10_iso_checksum = "sha256:049efd183a5a841dd432b3427eb6faa7deb3bf6c6bf2c63cbffa024b9c651725"
}