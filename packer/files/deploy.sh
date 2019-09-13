#!/bin/bash

sudo mv /tmp/puma.service /lib/systemd/system/puma.service
git clone -b monolith https://github.com/express42/reddit.git
pwd
cd reddit && bundle install
puma -d
ps aux | grep puma
systemctl start puma.service
sudo systemctl enable puma.service
