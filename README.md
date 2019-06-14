This is a fork of [https://github.com/lbfs/DeepFaceLab_Linux](bfs/DeepFaceLab_Linux).

The changes made regard the installation process. This fork uses a docker container to install
DeeFaceLab_Linux.

# Installation

**Note**: Currently, there's only one option available to install DeepFaceLab Linux.
That is, you have cloned this repository before you start the installation. The provided ```Dockerfile``` does not download this repository at the moment.


1. Install and run Docker


```bash
// archlinux
# pacman -S docker 
# systemctl start docker
// ubuntu
...
```

1. Clone the repository

```bash
$ git clone https://github.com/lbfs/DeepFaceLab_Linux
```

2. Change directory and make the build script executable

```bash
$ cd DeepFaceLab
$ chmod 700 docker_from_cloned_repository.sh
```

**Note**: If you experience network issues during the installation do the following:
```bash
# cp docker/daemon.json /etc/docker
```

3. Run the build script

**Note**: The build script will ask you for the environment you are using.
Correct answers are: cuda, cpu or opencl

```bash
$ ./docker_from_cloned_repository.sh
```
-v myvol2:/app \
4. Run the docker container

**Note:** I recommend to 'mount' the workspace of DeepFaceLinux to a directory outside the docker container.
If you do not want that remove the -v option. If you choose to do so you can read and write media files to the directoy of the host system.

```bash
// create workspace
$ mkdir /home/{USER}/workspace
$ docker run -ti -v /home/{USER}/workspace:/app/DeepFaceLab_Linux/workspace aspera_non_spernit/deepfacelab
´´´

5. Execute Docker Container as executable comman

**Note:** The idea is that you execute the docker container with appropriate arguments to run a specific task of
DeepFaceLab_Linux without logging into the container.