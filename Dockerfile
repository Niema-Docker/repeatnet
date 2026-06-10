# Minimal Docker image for RepeatNet using PyTorch base
FROM pytorch/pytorch:2.9.1-cuda13.0-cudnn9-runtime
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# install RepeatNet
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y time unzip wget && \
    wget "https://github.com/niemasd/RepeatNet-pytorch/archive/refs/heads/master.zip" && \
    unzip master.zip && \
    mv RepeatNet-* /usr/local/bin/RepeatNet && \
    echo "alias RepeatNet='torchrun --nproc_per_node=1 /usr/local/bin/RepeatNet/RepeatNet/Run.py'" >> ~/.bashrc && \
    rm -rf master.zip && \
    rm -rf /root/.cache /tmp/*
ENV PYTHONPATH="${PYTHONPATH}:/usr/local/bin/RepeatNet"
