This is a fork of [https://github.com/lbfs/DeepFaceLab_Linux](bfs/DeepFaceLab_Linux).

The changes made regard the installation process. This fork uses a docker container to install
DeeFaceLab_Linux.

# Installation

**Notes**: 

Currently, there's only one option available to install DeepFaceLab Linux.
That is, you have cloned this repository before you start the installation. The provided ```docker/Dockerfile``` does not download this repository at the moment.

The routine does not install cuda or opencl drivers at the moment. You can uncommebt the parts required in the
```docker/Dockerfile```


## 1) Install and start/enable Docker

**Note:** The user running the docker container must be member of the group "docker". This example is for
Archlinux. Docker is available in repositories of many other Linux distros.

```bash
# pacman -S docker
# usermod -a -G docker {USER}
# systemctl start docker
```

## 2) Clone the repository

```bash
$ git clone https://github.com/aspera-non-spernit/DeepFaceLab_Linux
```

## 3) Change directory and make the build script executable

```bash
$ cd DeepFaceLab
$ chmod 700 docker_from_cloned_repository.sh
```

**Note**: If you experience network issues during the installation often it's Docker having problems to use the
System DNS. You can manually edit the file and enter any DNS of your choice:

```bash
# cp docker/daemon.json /etc/docker
```

## 4) Run the build script

**Note**: The build script will ask you for the environment you are using.
Correct answers are: cuda, cpu or opencl

```bash
$ ./docker_from_cloned_repository.sh
```

## 5) Run the docker container

**Note:** I recommend to 'mount' the workspace of DeepFaceLinux to a directory outside the docker container.
If you do not want that remove the -v option. If you choose to do so you can read and write media files to the directoy of the host system.

```bash
// create workspace
$ mkdir /home/{USER}/workspace

// run the container
$ docker run -ti -v /home/{USER}/workspace:/app/DeepFaceLab_Linux/workspace aspera_non_spernit/deepfacelab
```

## 6) Execute Docker Container as executable command

**Note:** The idea is that you execute the docker container with appropriate arguments to run a specific task of
DeepFaceLab_Linux without logging into the container.

# Documentation

- English language (Google Translate)[PDF](https://github.com/lbfs/DeepFaceLab_Linux/blob/master/doc/manual_en_google_translated.pdf) | [doc](https://github.com/lbfs/DeepFaceLab_Linux/blob/master/doc/manual_en_google_translated.docx)
- Russian language [PDF](https://github.com/lbfs/DeepFaceLab_Linux/blob/master/doc/manual_ru.pdf) | [doc](https://github.com/lbfs/DeepFaceLab_Linux/blob/master/doc/manual_ru_source.docx)

# Changes made in this fork

- There have been no changes made to the code base. 
- The Russian and Chinese language documentation in docx and pdf format have been removed. Links to the orihinal
source are included in this README.md
- Several files in ```doc/*.md``` have been condensed into one file ```documentation.md```

# Examples

![Example DeepFace][example_1]
![Example DeepFace][example_1]

[example_1]: https://github.com/aspera-non-spernit/DeepFaceLab_Linux/doc/gallery/example_1.jpg "Example DeepFace"
[example_2]: https://github.com/aspera-non-spernit/DeepFaceLab_Linux/doc/gallery/example_2.jpg "Example DeepFace"



