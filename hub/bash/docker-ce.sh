#!/bin/bash

echo "kali" | sudo -Sv

printf '%s\n' "deb https://mirrors.ustc.edu.cn/docker-ce/linux/debian bullseye stable" |
  sudo tee /etc/apt/sources.list.d/docker-ce.list

curl -fsSL https://mirrors.ustc.edu.cn/docker-ce/linux/debian/gpg |
  sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-ce-archive-keyring.gpg

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

echo '{
    "registry-mirrors":[
        "https://docker.m.daocloud.io",
        "https://dockerproxy.com",
        "https://hub-mirror.c.163.com",
        "https://docker.nju.edu.cn",
        "https://mirror.baidubce.com",
        "https://docker.mirrors.ustc.edu.cn"
    ],
    "dns": ["8.8.8.8","8.8.4.4"]
}' | sudo tee /etc/docker/daemon.json

sudo systemctl daemon-reload
sudo systemctl restart docker
sleep 3
sudo docker info

read -p "Restart the system? (y/N): " choice
if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
  sudo reboot
fi