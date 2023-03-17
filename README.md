# connectal-docker

`connectal-docker` is a Docker image file that contains ubuntu 22.04, bsc, bsc-contrib, bsvbuild.sh, connectal and other components. It allows you to easily build connectal projects in Docker containers.

## Installation and running

To use connectal-docker image file, you need to install Docker and start Docker service first. Then execute the following commands in command line:

```bash
docker pull kazutoiris/connectal
```

This way you can use tools like bsc and connectal in the container.

## Docker Composer example

```yaml
version: "3.9"
services:
  connectal:
    image: kazutoiris/connectal:latest
    volumes:
      - .:/root
    network_mode: none
```

Create `docker-compose.yaml` under your project, and run `docker composer up`. Your project will sync to `~` in the Docker image.

## F.A.Q

1. Where’re the bsc/connectal?

   `bsc` is under `/opt/bsc/bin`, `connectal` is under `/opt/connectal`.

2. ./bsim: error while loading shared libraries: libconnectal-sim.so: cannot open shared object file: No such file or directory

   Execute `export LD_LIBRARY_PATH=.`

## License

Anti-996 License.
