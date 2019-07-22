# Use this file only if you have downloaded the entire github repository

FROM archlinux/base
MAINTAINER github.com/aspera-non-spernit
LABEL description="DeepFaceLab on archlinux/base"
ARG env
ARG graphics

# Updating ArchLinux
COPY docker/pacman.conf /etc/pacman.conf
RUN pacman -Sy --noconfirm
# Installing drivers

RUN if [ "$env" = "opencl" ]; then\
        # mesa = ATI / AMD Mesa 
        if [ "$graphics" = "mesa" ] || [ "$graphics" = "nvidia" ] || [ "$graphics" = "nvidia-390xx" ]; then\
            pacman -S --noconfirm libclc ocl-icd opencl-$graphics;\
        elif [ "$graphics" = "ivybridge" ] || [ "$graphics" = "haswell" ]; then\
            pacman -S --noconfirm libclc ocl-icd beignet;\
        else pacman -S --noconfirm libclc ocl-icd intel-compute-runtime;\
        fi\
    elif [ "$env" = "cuda" ]; then\
        pacman -S --noconfirm cuda cudann;\
    fi
# Copying DeepFaceLab_Linux
COPY . /app/DeepFaceLab_Linux
# Installing the work environment for DeepFaceLab_Linux
WORKDIR /app/DeepFaceLab_Linux
RUN pacman -S --noconfirm lib32-libxtst libsm libxrender clinfo python git nano youtube-dl ffmpeg wget &&\
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py &&\
    python get-pip.py &&\
    python -m pip install -r requirements-$env.txt &&\
# Removing installation files
    rm get-pip.py &&\
    rm docker_from_cloned_repository.sh&&\
    rm -rf docker&&\
    rm requirements*
