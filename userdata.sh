#!/bin/bash

# NOTE: User data to install docker
apt update && apt install -y docker.io

usermod -aG docker ubuntu && newgrp docker