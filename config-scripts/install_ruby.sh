#!/bin/bash

echo "$DateStr Ruby installation:"
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
if [[ $? -eq 0 ]]; then echo "$DateStr Ruby installed successfully "
else echo "$DateStr Ruby installation failed."
fi
ruby -v
bundle -v
