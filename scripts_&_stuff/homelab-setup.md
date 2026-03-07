go to "sudo vi /etc/ssh/ssh_config"
Uncomment "PasswordAuthentication" to **yes** if not already

sudo apt update && sudo apt-dist upgrade -y

# Install docker

# Add Docker's official GPG key:
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker

sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Gen ssh keys (optional but recommended)

ssh-keygen -t ed25519 -f .ssh/server_key
ssh-copy-id -i ~/.ssh/server_key.pub haxnethost@192.168.122.143

> [!IMPORTANT]
wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb
sudo dpkg -i fastfetch-linux-amd64.deb
sudo apt --fix-broken install
fastfetch
