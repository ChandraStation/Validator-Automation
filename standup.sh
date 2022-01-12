#!/bin/bash

#Archlinux Setup
while true; do
    read -p "Is this a new Archlinux server?" yn
    case $yn in
        [Yy]* ) pacman -Syyu aria2 atop autoconf automake base binutils bison bmon btrfs-progs btop clang cronie cryptsetup docker dstat fakeroot flex gcc git go gptfdisk groff grub haveged htop iftop iptraf-ng jq llvm lvm2 m4 make mdadm neovim net-tools nethogs openssh patch pkgconf python rsync rustup screen sudo texinfo unzip vi vim vnstat wget which xfsprogs hddtemp python-setuptools npm python-bottle python-docker python-matplotlib python-netifaces python-zeroconf python-pystache time nload nmon glances gtop bwm-ng bpytop duf go-ipfs fish pigz zerotier-one sysstat github-cli pm2; break;;
        [Nn]* ) break;;
	    [Ss]* ) exit;;
        * ) echo "Please answer yes no or stop.";;
    esac
done

#Ubuntu Setup
while true; do
    read -p "Is this a new Ubuntu server?" yn
    case $yn in
        [Yy]* ) apt-get update -y && apt install wget curl gcc make snap; break;;
        [Nn]* ) break;;
	    [Ss]* ) exit;;
        * ) echo "Please answer yes no or stop.";;
    esac
done

#Golang install for Ubuntu
while true; do
    read -p "Need golang on Ubuntu?" yn
    case $yn in
        [Yy]* ) snapd install go --classic; break;;
        [Nn]* ) break;;
	    [Ss]* ) exit;;
        * ) echo "Please answer yes no or stop.";;
    esac
done

PS3='Please enter your choice: '
options=("Akash" "Sentinel" "Chihuahua" "Comdex" "Dig" "e-Money" "G-Bridge" "Omniflix" "Osmosis" "Sentinel" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Akash")
                PS3='Would you like to run a Mainnet or Testnet Node?'
                options=("Mainnet" "Testnet" "Go Back")
                select opt in "${options[@]}"
                do
                        case $opt in
                                "Mainnet")
                                        wget https://github.com/ovrclk/akash/releases/download/v0.14.1/akash_0.14.1_linux_amd64.zip
                                        unzip akash_0.14.1_linux_amd64.zip
                                        sudo rm akash_0.14.1_linux_amd64.zip
                                        mv akash_0.14.1_linux_amd64/akash /usr/bin/
                                        sudo rm -i -rf akash_0.14.1_linux_amd64/
                                        akash init node --chain-id akashnet-2
                                        sed -i 's/seeds = ""/seeds ="27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656,8e2f56098f182ffe2f6fb09280ba" ~/.akash/config/config.toml
                                        sed -i 's/persistent_peers = ""/persistent_peers = "27eb432ccd5e895c5c659659120d68b393dd8c60@35.247.65.183:26656" ~/.akash/config/config.toml
                                        sed -i 's/minimum-gas-prices = ""/minimum-gas-prices = "0.01uakt"/g' ~/.akash/config/app.toml
                                        sudo rm -i ~/.akash/config/genesis.json
                                        wget https://github.com/ovrclk/net/raw/master/mainnet/genesis.json ~/.akash/config/
                                        akash start
                                        cat > /etc/systemd/system/akash.service
                                        echo "[Unit]
                                        Description=Akash Node
                                        After=network.target

                                        [Service]
                                        Type=simple
                                        User=root
                                        WorkingDirectory=/root/
                                        ExecStart=/usr/bin/akash start
                                        Restart=on-failure
                                        StartLimitInterval=0
                                        RestartSec=3
                                        LimitNOFILE=65535
                                        LimitMEMLOCK=209715200

                                        [Install]
                                        WantedBy=multi-user.target" > /etc/systemd/system/akash.service
                                        sudo systemctl enable akash
                                        sudo systemctl daemon-reload
                                        sudo systemctl start akash && journalctl -u akash -f; break;;

                                "Testnet")
                                        echo "Sorry this is still a work in progress"
                                        ;;

                                "Go Back")
                                        exit;;
                        esac
                done

            ;;
        "Chihuahua")
            echo "you chose choice 2"

            ;;
        "Comdex")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Dig")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "e-Money")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "G-Bridge")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Omniflix")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Osmosis")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Sentinel")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            exit
            ;;
    esac
done

#Akash Snapshot
#while true; do
#    read -p "Snapshot 4 Akash bb?" yn
#    case $yn in
#        [Yy]* ) rm ~/.akash/data/priv_validator_state.json
#                wget http://135.181.60.250/akash/akashnet-2_$(date +"%Y-%m-%d").tar -P ~/.akash/data
#                tar -xvf ~/.akash/data break;;
#        [Nn]* ) break;;
#        [Ss]* ) exit;;
#        * ) echo "Please answer yes no or stop.";;
#    esac
#done

#Chihuahua Node
#Comdex Node
#Dig Node
#E-Money Node
#G-Bridge Node
#Sentinel Node
#Osmosis Node
