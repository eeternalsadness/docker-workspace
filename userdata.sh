#!/bin/bash

# NOTE: User data to set up work env

apt update && apt install -y docker.io
usermod -aG docker ubuntu && newgrp docker