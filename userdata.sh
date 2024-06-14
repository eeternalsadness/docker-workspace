#!/bin/bash

# install docker
apt-get update && apt-get install -y docker.io
usermod -aG docker ubuntu && newgrp docker

# remove instance connect
apt-get remove ec2-instance-connect