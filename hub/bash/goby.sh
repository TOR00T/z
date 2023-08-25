#!/bin/bash
echo "kali" | sudo -Sv
sudo setcap 'CAP_NET_RAW+eip CAP_NET_ADMIN+eip' ./golib/goby-cmd-linux
./goby