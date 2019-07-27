# Use this file only if you have downloaded the entire github repository
FROM nvidia/cuda
FROM archlinux/base
MAINTAINER github.com/aspera-non-spernit
LABEL description="DeepFaceLab on archlinux/base"
ARG env
ARG graphics

# Updating ArchLinux
COPY docker/pacman.conf /etc/pacman.conf
COPY docker/sshd_conf /etc/ssh/sshd_conf
RUN pacman -Sy --noconfirm

# Installing drivers
RUN pacman -S --noconfirm base-devel lib32-libxtst libsm libxrender clinfo python git nano youtube-dl ffmpeg wget xclock;\
    if [[ "$env" = "cuda" ]]; then\
        # for cuda capable graphics cards
        pacman -S --noconfirm cuda cudnn;\
        if [[ "$graphics" = "V100" ]]; then\
            wget "https://www.nvidia.com/content/DriverDownload-March2009/confirmation.php?url=/tesla/418.67/NVIDIA-Linux-x86_64-418.67.run&lang=us&type=Tesla";\
            chmod 700 ./NVIDIA-Linux-x86_64-418.67.run;\
            ./NVIDIA-Linux-x86_64-418.67.run;\
        elif [[ "$graphics" = "GTX1080" ]]; then\
            wget "https://www.nvidia.com/content/DriverDownload-March2009/confirmation.php?url=/XFree86/Linux-x86_64/430.34/NVIDIA-Linux-x86_64-430.34.run&lang=us&type=TITAN";\
            chmod 700 ./NVIDIA-Linux-x86_64-430.34.run;\
            ./NVIDIA-Linux-x86_64-430.34.run;\
        fi/
    elif [[ "$env" = "opencl" ]]; then\
        pacman -S --noconfirm libclc ocl-icd\
        # for non-cuda nvidia, mesa compatible (ATI/AMD), or other
        if [[ "$graphics" = "mesa" ]] || [[ "$graphics" = "nvidia" ]] || [[ "$graphics" = "nvidia-390xx" ]]; then\
            pacman -S --noconfirm opencl-$graphics;\
        elif [[ "$graphics" = "ivybridge" ]] || [[ "$graphics" = "haswell" ]]; then\
            pacman -S --noconfirm  beignet;\
        else\
            pacman -S --noconfirm intel-compute-runtime;\
        fi\
    fi

# CMD export PATH=/opt/cuda/bin:$PATH

# Copying DeepFaceLab_Linux
COPY . /app/DeepFaceLab_Linux

# Installing DeepFaceLab_Linux
WORKDIR /app/DeepFaceLab_Linux
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py &&\
    python get-pip.py &&\
    python -m pip install -r requirements-$env.txt &&\
# Removing installation files
    rm get-pip.py &&\
    rm docker_from_cloned_repository.sh&&\
    rm -rf docker&&\
    rm requirements*

