FROM mcr.microsoft.com/devcontainers/base:ubuntu-20.04

SHELL [ "bash", "-c" ]

# Install essential packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        build-essential \
        wget \
        curl \
        git \
        git-lfs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Initialize git-lfs
RUN git lfs install

USER vscode

# Setup conda for vscode user
RUN cd /tmp && \
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash ./Miniconda3-latest-Linux-x86_64.sh -b -p /home/vscode/miniconda3 && \
    rm ./Miniconda3-latest-Linux-x86_64.sh

# Add conda to PATH
ENV PATH="/home/vscode/miniconda3/bin:${PATH}"