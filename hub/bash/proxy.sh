#!/bin/bash
# proxy.sh

proxy_arg="$1"

PROXY_TYPE=""
PROXY_URL=""
PROXY_IP=""
PROXY_PORT=""
PROXY_USER=""
PROXY_PASSWORD=""

if [[ "${proxy_arg}" == "http://"*":"[1-9][0-9]* ]] || \
   [[ "${proxy_arg}" == "https://"*":"[1-9][0-9]* ]] || \
   [[ "${proxy_arg}" == "socks://"*":"[1-9][0-9]* ]] || \
   [[ "${proxy_arg}" == "http://"*":"[1-9][0-9]*"@"* ]] || \
   [[ "${proxy_arg}" == "https://"*":"[1-9][0-9]*"@"* ]] || \
   [[ "${proxy_arg}" == "socks://"*":"[1-9][0-9]*"@"* ]]; then
   :
else
    echo "Usage: bash proxy.sh {protocol}://{IP}:{Port}
       bash proxy.sh {protocol}://{username}:{password}@{IP}:{Port}"
    echo ""
    echo "Example: bash proxy.sh http://127.0.0.1:8080
         bash proxy.sh http://user:pass@127.0.0.1:8080"
   exit 1
fi

if [[ "${proxy_arg}" == "http://"* ]]; then
  PROXY_TYPE="http"
  PROXY_URL="${proxy_arg#http://}"
elif [[ "${proxy_arg}" == "https://"* ]]; then
  PROXY_TYPE="https"
  PROXY_URL="${proxy_arg#https://}"
elif [[ "${proxy_arg}" == "socks://"* ]]; then
  PROXY_TYPE="socks"
  PROXY_URL="${proxy_arg#socks://}"
fi

if [[ "${PROXY_URL}" == *"@"* ]]; then
  PROXY_USER="${PROXY_URL%%:*}"
  PROXY_PASSWORD="${PROXY_URL#*:}"
  PROXY_PASSWORD="${PROXY_PASSWORD%@*}"
  PROXY_URL="${PROXY_URL##*@}"
fi

PROXY_IP=$(echo ${PROXY_URL} | cut -d':' -f1)

if ! [[ "${PROXY_IP}" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
   echo "Error: Invalid IP address."
   exit 1
fi

PROXY_PORT=$(echo ${PROXY_URL#*:})

if ! [[ "${PROXY_PORT}" =~ ^([1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$ ]]; then
   echo "Error: Invalid Port."
   exit 1
fi

echo "PROXY_TYPE: ${PROXY_TYPE}"
echo "PROXY_URL: ${PROXY_URL}"
echo "PROXY_IP: ${PROXY_IP}"
echo "PROXY_PORT: ${PROXY_PORT}"
echo "PROXY_USER: ${PROXY_USER}"
echo "PROXY_PASSWORD: ${PROXY_PASSWORD}"

if grep -q "setproxy()" ~/.bashrc; then
    sed -i "s|export {http,https,ftp,all}_proxy=.*|export {http,https,ftp,all}_proxy=\"$proxy_arg\"|" ~/.bashrc
else
    echo -e "\n# Set Proxy\nfunction setproxy() {\n    export {http,https,ftp,all}_proxy=\"$proxy_arg\"\n}\n\n# Unset Proxy\nfunction unsetproxy() {\n    unset {http,https,ftp,all}_proxy\n}" >> ~/.bashrc
fi

echo "======================"
echo "write ~/.bashrc OK"

if grep -q "setproxy()" ~/.zshrc; then
    sed -i "s|export {http,https,ftp,all}_proxy=.*|export {http,https,ftp,all}_proxy=\"$proxy_arg\"|" ~/.zshrc
else
    echo -e "\n# Set Proxy\nfunction setproxy() {\n    export {http,https,ftp,all}_proxy=\"$proxy_arg\"\n}\n\n# Unset Proxy\nfunction unsetproxy() {\n    unset {http,https,ftp,all}_proxy\n}" >> ~/.zshrc
fi

echo "======================"
echo "write ~/.zshrc OK"

echo "======================"
echo "source ~/.bashrc"
echo "source ~/.zshrc"

echo "======================"
echo "setproxy"
echo "unsetproxy"