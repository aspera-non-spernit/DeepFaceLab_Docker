#!/bin/bash
echo -n "Do you want to run on cuda, cpu or opencl [cuda, cpu, opencl]?: "
read env
if [[ "$env" != "cuda" ]] && [[ "$env" != "cpu" ]] && [[ "$env" != "opencl" ]]; then
    echo "$env is not a valid option. Choose from 'cuda', 'cpu' or 'opencl'"
else
    docker build --tag=aspera_non_spernit/deepfacelab -f docker/Dockerfile --build-arg requirements=$env .
fi
