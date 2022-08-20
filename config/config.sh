### Helper functions
uncomment() {
	local file=$1
	shift 1
	local patterns=$@
	for pattern in $patterns; do
		sed -i "/$pattern/s/^#//g" $file
	done
}

comment() {
	local file=$1
	shift 1
	local patterns=$@
	for pattern in $patterns; do
		sed -i "s/^[^#]*$pattern/#&/" $file
	done
}

### Get mirrors
curl -o /etc/pacman.d/mirrorlist "https://archlinux.org/mirrorlist/?country=HU&protocol=http&protocol=https&ip_version=4"
uncomment "/etc/pacman.d/mirrorlist" "Server"

### Pacman config
uncomment "/etc/pacman.conf" "Color" "VerbosePkgLists" "ParallelDownloads"
comment "/etc/pacman.conf" "NoProgressBar"