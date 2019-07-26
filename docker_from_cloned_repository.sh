#!/bin/bash

# quit on false user input.
early_quit() {
    exit 1
    echo "Closing with error. Nothing has been installed."
}

# Gathering installation information
# for the environment and graphics card.
env() {
    echo -e -n "Do you want to run on cuda, cpu or opencl [cuda, cpu, opencl]?:\n"
    read env
    if [[ "$env" != "cuda" ]] && [[ "$env" != "cpu" ]] && [[ "$env" != "opencl" ]]; then
        echo "$env is not a valid option. Choose from: 'cuda', 'cpu' or 'opencl'"
        early_quit
    elif [[ "$env" = "opencl" ]]; then
        echo -e -n "What's your graphics card [mesa, nvidia, nvidia-390xx, ivybridge, haswell]?:\n"
        read graphics
        if [[ "$graphics" != "mesa" ]] && [[ "$graphics" != "nvidia" ]] && [[ "$graphics" != "nvidia-390xx" ]] && [[ "$graphics" != "ivybridge" ]] && [[ "$graphics" != "haswell" ]]; then
            echo "$env is not a valid option. Choose from: 'mesa', 'nvidia' 'nvidia-390xx', 'ivybridge' or 'haswell'"
            early_quit
        fi
    fi
}
# for optional packages (ie. https://github.com/aspera-non-spernit/vid2img):
optional() {   
    echo -e -n "Do you want to install optional packages [y | n]?:\n"
    read optional
    if [[ "$optional" != "y" ]] && [[ "$optional" != "n" ]]; then
        echo "$env is not a valid option. Choose from: y, n"
        early_quit
    fi
}

# Installing docker
install() {
    echo -e -n "Installing for a $env environment. Optional drivers: $graphics\n"
    docker build --tag=aspera_non_spernit/deepfacelab -f docker/Dockerfile --build-arg env=$env --build-arg graphics=$graphics --build-arg=$optional .
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
env
optional
install
workspace
run