# Docker ComfyUI installation with NVidia support

The following repository contains a `Dockerfile` and a `docker-compose.yml` with a couple of scripts that help to setup a ComfyUI deployment on docker.

## (optional) Install NVIDIA container libraries for docker

In case the docker host doesn't have nvidia library installed yet, a reminder:

Official instructions:
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

Apt example:

```shell
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```

## Prepare volume folders

- see `src/extra_models_paths.yaml` and prepare a folder structure like that somewhere on your local docker host
- edit `docker-compose.yml` to map the folders as wanted.

## Run

run `docker compose up` in the root project folder.

## `start.sh` info

The `start.sh` can be heavily customized.
In the sample we install ComfyUI-Manager and start ComfyUI in highvram, listening for having API access