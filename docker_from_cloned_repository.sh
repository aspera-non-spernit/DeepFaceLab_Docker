#!/bin/bash
# Gathering installation information
echo -n "Do you want to run on cuda, cpu or opencl [cuda, cpu, opencl]?: "
read env
if [[ "$env" != "cuda" ]] && [[ "$env" != "cpu" ]] && [[ "$env" != "opencl" ]]; then
    echo "$env is not a valid option. Choose from 'cuda', 'cpu' or 'opencl'"
elif [[ "$env" = "opencl" ]]; then
    echo -n "What's your graphics card [mesa, nvidia, nvidia-390xx, ivybridge, haswell]?: "
    read graphics
fi
# Installing docker
docker build --tag=aspera_non_spernit/deepfacelab -f docker/Dockerfile --build-arg env=$env --build-arg graphics=$graphics .
echo -e -n "Docker container with DeepFaceLab successfully installed."
# Setting up workspace
echo -e -n "Where do you want to have the workspace directory [default: /home/${USER}/DeepFaceLab/workspace)]:"
read workspace
if [ "$workspace" = "" ]; then
    workspace=/home/${USER}/DeepFaceLab/workspace
fi
echo -n "Creating folder structure in workspace.."
rm -rf $workspace
mkdir -r $workspace
mkdir $workspace/data_src
mkdir $workspace/data_src/aligned
mkdir $workspace/data_src/aligned_debug
mkdir $workspace/data_dst
mkdir $workspace/data_dst/aligned
mkdir $workspace/data_dst/aligned_debug
mkdir $workspace/model
# Running or quitting installation
echo -n "You can run and enter your Container with the command:"
echo -n "docker run -ti -v /home/${USER}/workspace:/app/DeepFaceLab_Linux/workspace aspera_non_spernit/deepfacelab"
echo -n "You can copy your video material into the workspace folder on the host machine."
echo -n "DeepFaceLab_Docker will pick up changes."
echo -n "Run DeepFaceLab_Docker now? [y, n]?"
read execute
if [ "$execute" = "y"]; then
    docker run -ti -v /home/${USER}/workspace:/app/DeepFaceLab_Linux/workspace aspera_non_spernit/deepfacelab
fi
echo -n "Installation successful. Have fun. "