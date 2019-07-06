# Use this file only if you have downloaded the entire github repository

FROM archlinux/base
MAINTAINER github.com/aspera-non-spernit
LABEL description="DeepFaceLab on archlinux/base"
ARG requirements
WORKDIR /DeepFaceLab

# INSTALLATION OF DRIVERS

# option: nVidia cuda cards
# RUN pacman -S cuda cudnn

# option: opencl for supported AMD/ATI 
# RUN pacman -S ocl-icd opencl-mesa

# option: opencl for nVidia cards
# RUN pacman -S ocl-icd opencl-nvidia

COPY docker/pacman.conf /etc/pacman.conf
RUN pacman -Sy --noconfirm

RUN pacman -S --noconfirm lib32-libxtst libsm libxrender python git nano youtube-dl ffmpeg wget &&\
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py &&\
    python get-pip.py &&\
    rm get-pip.py

WORKDIR /app/DeepFaceLab_Linux
# WIP If you run this comment the following COPY command.
# git clone https://www.github.com/aspera-non-spernit/DeepFaceLab_Linux.git

COPY . /app/DeepFaceLab_Linux
RUN python -m pip install -r requirements-$requirements.txt &&\
    rm docker_from_cloned_repository.sh

