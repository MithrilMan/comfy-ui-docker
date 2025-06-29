# Stage 1: Base image with common dependencies
#FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 AS base
#FROM nvidia/cuda:12.1.1-cudnn8-runtime-ubuntu22.04 AS base
FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

# Prevents prompts from packages asking for user input during installation
ENV DEBIAN_FRONTEND=noninteractive
# Prefer binary wheels over source distributions for faster pip installations
ENV PIP_PREFER_BINARY=1
# Ensures output from python is printed immediately to the terminal without buffering
ENV PYTHONUNBUFFERED=1

# Install Python, git and other necessary tools
RUN apt-get update && apt-get install -y \
#    python3.10 \
    python3-pip \
    git \
    git-lfs \
    unzip \
    ffmpeg \
    wget

# Clean up to reduce image size
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /comfyui

# Change working directory to ComfyUI
WORKDIR /comfyui

# RUN pip install -q opencv-python imageio imageio-ffmpeg ffmpeg-python av \
#     xformers==0.0.25 torchsde==0.2.6 einops==0.8.0 diffusers==0.28.0 transformers==4.41.2 accelerate==0.30.1

# Install ComfyUI dependencies
#RUN pip3 install --upgrade --no-cache-dir torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121 \
#    && pip3 install --upgrade -r requirements.txt
RUN pip3 install --upgrade -r /comfyui/requirements.txt

# Support for the network volume
#ADD src/extra_model_paths.yaml ./

# Go back to the root
WORKDIR /

#RUN cd /comfyui && \
#    git checkout d170292594770377d9e0442078ef43668e2331b6

# Add the start and the handler
ADD src/start.sh ./
RUN chmod +x /start.sh

# Start the container
CMD /start.sh