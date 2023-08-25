#!/usr/bin/env bash

ini() {
  if [[ $(hostname) != "kali" || $UID -ne 0 ]]; then
    echo "Please run as root user in KALI!"
    exit 1
  else
    ping -c 1 223.5.5.5 > /dev/null 2>&1
    if [ $? -ne 0 ]; then
      echo "No internet connection!"
      exit 1
    fi
  fi
}

run() {
  menu='> 01. Default Kali Linux /etc/apt/sources.list
> 02. Update Kali Linux /etc/apt/sources.list
> 03. Install kali-wallpapers-all
> 04. Install dirsearch
> 05. Install feroxbuster
> 06. Install sublist3r
> 07. Install gobuster
> 08. Install finalrecon
> 09. Install kazam
> 10. Install flameshot
> 11. Install ibus'

  echo "$menu"
  echo "Please enter a number [1-11] to select the operation:"

  while true; do
    read choice
    if [[ ! $choice =~ ^[1-9]$|^1[0-1]$ ]]; then
      echo "Invalid option! Please choose again:"
    else
      break
    fi
  done

  if [[ $choice == 1 ]]; then
    sudo rm -rf /etc/apt/sources.list
    contents="deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware"
    echo "$contents" | sudo tee /etc/apt/sources.list > /dev/null &&
    sudo chmod 644 /etc/apt/sources.list && cat /etc/apt/sources.list &&
    while true; do
      read -p "Do you want to update? (y/N): " yn
      case $yn in
        [Yy]* ) 
            sudo apt update 
            sudo du -sh /var/cache/apt/archives 
            sudo apt-get clean 
            break;;
        [Nn]* ) 
            break;;
        * ) echo "Please answer y or N.";;
      esac
    done

  elif [[ $choice == 2 ]]; then
    sudo mv /etc/apt/sources.list /etc/apt/sources.list_bak
    contents="deb https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
deb-src https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib"
    echo "$contents" | sudo tee /etc/apt/sources.list > /dev/null &&
    sudo chmod 644 /etc/apt/sources.list && cat /etc/apt/sources.list &&
    while true; do
      read -p "Do you want to update? (y/N): " yn
      case $yn in
        [Yy]* ) 
            sudo apt update 
            sudo du -sh /var/cache/apt/archives 
            sudo apt-get clean 
            break;;
        [Nn]* ) 
            break;;
        * ) echo "Please answer y or N.";;
      esac
    done

  elif [[ $choice == 3 ]]; then
    sudo apt install kali-wallpapers-all -y

  elif [[ $choice == 4 ]]; then
    sudo apt install dirsearch -y 
    echo ""
    echo "/usr/lib/python3/dist-packages/dirsearch/db/dicc.txt"

  elif [[ $choice == 5 ]]; then
    sudo apt install feroxbuster -y

  elif [[ $choice == 6 ]]; then
    sudo apt install sublist3r -y

  elif [[ $choice == 7 ]]; then
    sudo apt install gobuster -y

  elif [[ $choice == 8 ]]; then
    sudo apt install finalrecon -y

  elif [[ $choice == 9 ]]; then
    sudo apt install kazam -y

  elif [[ $choice == 10 ]]; then
    sudo apt install flameshot -y

  elif [[ $choice == 11 ]]; then
    sudo apt install ibus ibus-pinyin -y
  fi
}

main() {
  ini || exit 1
  run
}

main