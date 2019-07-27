#!/bin/bash
ENV="cuda"
OPTIONAL="n"
GRAPHICS="GTX1080"

# If you run into trouble with CUDA not being available,
# run nvidia-modprobe first.
# You need to relogin in order for the cuda binaries to appear in your PATH
# https://github.com/NVIDIA/nvidia-docker
# quit on false user input.
early_quit() {
    echo "Closing with error. Nothing has been installed."
    exit 1
}

# Gathering installation information
# for the environment and graphics card.
environment() {
    echo -e -n "Do you want to run on cuda, cpu or opencl [cuda, cpu, opencl]?:\n"
    read env
    ENV=$env
    if [[ "$env" != "cuda" ]] && [[ "$env" != "cpu" ]] && [[ "$env" != "opencl" ]]; then
        echo "$env is not a valid option. Choose from: 'cuda', 'cpu' or 'opencl'"
        early_quit
    # opencl ennvironment
    elif [[ "$env" = "opencl" ]]; then
        echo -e -n "What's your graphics card [mesa, nvidia, nvidia-390xx, ivybridge, haswell]?:\n"
        read graphics
        GRAPHICS=$grapics
        if [[ "$graphics" != "mesa" ]] && [[ "$graphics" != "nvidia" ]] && [[ "$graphics" != "nvidia-390xx" ]] && [[ "$graphics" != "ivybridge" ]] && [[ "$graphics" != "haswell" ]]; then
            echo "$graphics is not a valid option. Choose from: 'mesa', 'nvidia' 'nvidia-390xx', 'ivybridge' or 'haswell'"
            early_quit
        fi
	# cuda environment
    elif [[ "$env" = "cuda" ]]; then
        echo -e -n "What's your nvidia graphics card [GTX1080, V100]?:\n";
        read graphics
        if [[ "$graphics" != "GTX1080" ]] && [[ "$graphics" != "V100" ]]; then
   			echo "$graphics is not a valid option. Choose from: 'GTX1080' or 'V100'"
        	early_quit
		fi
		GRAPHICS=$graphics
        if [[ "$graphics" = "V100" ]]; then
            wget "http://us.download.nvidia.com/tesla/418.67/NVIDIA-Linux-x86_64-418.67.run";
            chmod 700 ./NVIDIA-Linux-x86_64-418.67.run;
            sudo ./NVIDIA-Linux-x86_64-418.67.run;
            rm ./NVIDIA-Linux-x86_64-418.67.run;
        elif [[ "$graphics" = "GTX1080" ]]; then
            wget "http://us.download.nvidia.com/XFree86/Linux-x86_64/430.34/NVIDIA-Linux-x86_64-430.34.run";
            chmod 700 ./NVIDIA-Linux-x86_64-430.34.run;
            sudo ./NVIDIA-Linux-x86_64-430.34.run;
            rm ./NVIDIA-Linux-x86_64-430.34.run;
        fi
    fi
}
# for optional packages (ie. https://github.com/aspera-non-spernit/vid2img):
optional() {   
    echo -e -n "Do you want to install optional packages [y | n]?:\n"
    read optional
    OPTIONAL=$optional
    if [[ "$optional" != "y" ]] && [[ "$optional" != "n" ]]; then
        echo "$env is not a valid option. Choose from: y, n"
        early_quit
    fi
}

# Installing docker
install() {    
    echo -e -n "Installing for a $env environment. "
    if [[ "$env" != "cpu" ]]; then
		echo -e -n "Optional drivers: $graphics\n"
    else 
        echo -e -n "\n"
    fi
    docker build --tag=aspera_non_spernit/deepfacelab -f docker/Dockerfile --build-arg env=$ENV --build-arg graphics=$GRAPHICS --build-arg=$OPTIONAL .
    echo -e -n "Docker container with DeepFaceLab successfully installed.\n"
}

# Setting up workspace on the host
workspace() {
    echo -e -n "Where do you want to have the workspace directory [default: /home/${USER}/DeepFaceLab/workspace)]:\n"
    read workspace
    if [ "$workspace" = "" ]; then
        workspace=/home/${USER}/DeepFaceLab/workspace
    fi
    echo -e -n "Creating folder structure: $workspace\n"
    rm -rf $workspace
    mkdir -p $workspace
    mkdir $workspace/data_src
    mkdir $workspace/data_src/aligned
    mkdir $workspace/data_src/aligned_debug
    mkdir $workspace/data_src/aligned_notrain
    mkdir $workspace/data_src/seq
    mkdir $workspace/data_src/vid
    mkdir $workspace/data_dst
    mkdir $workspace/data_dst/aligned
    mkdir $workspace/data_dst/aligned_debug
    mkdir $workspace/data_dst/aligned_notrain
    mkdir $workspace/data_dst/seq
    mkdir $workspace/data_dst/vid
    mkdir $workspace/model
    cp ./scripts/host/clear_workspace.sh $workspace/..
    cp ./scripts/host/run.sh $workspace/..
}

finish_installation() {
    exec bash
}

# Running or quitting installation
run() {
    echo -e -n "\nYou can run and enter your Container with the command:\n"
    echo -e -n "docker run -ti -v /home/${USER}/DeepFaceLab/workspace:/app/DeepFaceLab_Linux/workspace:rw aspera_non_spernit/deepfacelab\n"
    echo -e -n "\nYou can copy your video material into the workspace folder on the host machine.\n"
    echo -e -n "DeepFaceLab_Docker will pick up changes.\n"
    echo -e -n "\nRun DeepFaceLab_Docker now? [y, n]?"
    read execute
    if [ "$execute" = "y" ]; then
        docker run -ti -v /home/${USER}/DeepFaceLab/workspace:/app/DeepFaceLab_Linux/workspace:rw aspera_non_spernit/deepfacelab
    fi
    echo -e -n "Installation successful. Have fun.\n"
}
environment
#optional
install
finish_installation
workspace
run