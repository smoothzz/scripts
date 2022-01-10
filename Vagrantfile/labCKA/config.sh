#!/bin/bash

sudo apt update -y

curl -fsSL https://get.docker.io | sh

swapoff -a; sed -i '/swap/d' /etc/fstab

sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

sudo echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/Z53U2LXPsDo0zJ1K1sTGtfrA0hiVtnSBdkCTLqBvbYdxooSHC4PulvyWaB+TQ3cfJt70Ugk3yQCH6gl09Qgb+2Q7sXNHEWiSu6mp59rCojxpVmOKclvKCXUYTJKWvQcvAPH7VYcwUy2M2qOUvQWjUUVw2iig2dxJwLCr60yiw4J4RuwQnajAaTxgD8MBgEs7KeaU1PqXOfkD9d4qkilz9eUpId5y7lsTjX0uQC+0rKwP/9kiLZi/omGFePi2+ejLcb2NmwkB11xyYzLS4s3RSuCISHdffHyekjZlaNKMAZ+9fjZuMGMuRsAeeuoK7RRd6eBjVJXHfa7/TmZEUsp7Mwro+Lzb6i2mehoOS6olrBhR30qqOczaizw5DxeboUzJmfol+2ZUYMV0Nzw+eRCo22csFlSRVmuPo59RTjMSJfZUjXA0sG7+fQMZhjo/GyZfwUxV/qtfg38BPCOkBS+syXnjRDQL3Cjd2FA4SIWn2Aj5o8RK3BPn0PTAYnzf6Xk= thiago@smoothz' >> ~/.ssh/authorized_keys