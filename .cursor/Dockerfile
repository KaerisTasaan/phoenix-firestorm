FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    git \
    ninja-build \
    pkg-config \
    python3 \
    python3-pip \
    python3-venv \
    time \
    gcc-11 \
    g++-11 \
    libfontconfig-dev \
    libfreetype6-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpulse-dev \
    libssl-dev \
    libxinerama-dev \
    libxrandr-dev \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace/phoenix-firestorm
