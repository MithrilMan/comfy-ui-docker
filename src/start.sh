#!/usr/bin/env bash

# Use libtcmalloc for better memory management
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"

cd comfyui/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ComfyUI-Manager
git fetch
git pull

cd /comfyui
git checkout master
git fetch
git pull

echo "Installing requirements.txt"
pip3 install --upgrade -r requirements.txt

cd /

echo "Starting ComfyUI"
python3 /comfyui/main.py --disable-auto-launch --disable-metadata --highvram --listen