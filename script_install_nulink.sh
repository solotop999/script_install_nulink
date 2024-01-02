#!/bin/bash

#document: https://docs.nulink.org/products/stakers

read -p 'Input your password (More than 8 digits): '  PASSWORD 
export NULINK_KEYSTORE_PASSWORD=$PASSWORD
export NULINK_OPERATOR_ETH_PASSWORD=$PASSWORD

# Check if the system is Ubuntu
if ! grep -q "Ubuntu" /etc/lsb-release; then
    echo "This script is for Ubuntu only. Exiting."
    exit 1
fi


# Check if the script is not running as root
if [ "$EUID" -ne 0 ]; then
    echo "Enter password to Switching to root"
    sudo su
fi


#install docker
# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "Docker is already installed. Skipping installation."
else
    sudo apt install curl build-essential git screen jq pkg-config libssl-dev libclang-dev ca-certificates gnupg lsb-release -y

    # Install Docker
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update -y
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin -y
    systemctl start docker
    systemctl enable docker
fi

# Check if Docker Compose is installed
if command -v docker-compose &> /dev/null; then
    echo "Docker Compose is already installed. Skipping installation."
else
    # Install Docker Compose
    sudo apt-get install docker-compose -y
fi

# Create Worker Account
cd /root
mkdir -p /root/nulink_bk
wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.10.23-d901d853.tar.gz
tar -xvzf geth-linux-amd64-1.10.23-d901d853.tar.gz
cd geth-linux-amd64-1.10.23-d901d853/
mv /root/geth-linux-amd64-1.10.23-d901d853/keystore/* /root/nulink_bk
./geth account new --keystore ./keystore

# NuLink Worker Installation
docker pull nulink/nulink:latest

cd /root
mkdir -p /root/nulink
mv /root/nulink/* /root/nulink_bk
cp /root/geth-linux-amd64-1.10.23-d901d853/keystore/* /root/nulink
chmod -R 777 /root/nulink


# Find the latest file matching the pattern
latest_file=$(ls -1t /root/nulink/UTC* | head -n 1)

# Check if a file was found
if [ -n "$latest_file" ]; then
    echo "Latest keystore file: $latest_file"
    filename=$(basename "$latest_file")
    operator_address=${filename##*--}
    operator_address="0x${operator_address%%.*}"
else
    echo "No keystore file found in /root/nulink/UTC*"
    exit 1  # Exit the script with an error code
fi


docker run -it --rm \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
nulink/nulink nulink ursula init \
--signer "keystore:///code/$filename" \
--eth-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--network horus \
--payment-provider https://data-seed-prebsc-2-s2.binance.org:8545 \
--payment-network bsc_testnet \
--operator-address "$operator_address" \
--max-gas-price 10000000000


docker run --restart on-failure -d \
--name ursula \
-p 9151:9151 \
-v /root/nulink:/code \
-v /root/nulink:/home/circleci/.local/share/nulink \
-e NULINK_KEYSTORE_PASSWORD \
-e NULINK_OPERATOR_ETH_PASSWORD \
nulink/nulink nulink ursula run --no-block-until-ready



docker logs -f ursula

#update: https://docs.nulink.org/products/stakers/nulink_worker/worker_update#update-in-docker-environment
