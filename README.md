# Scala Protobuf 3 Workbench

[![Docker Automated buil](https://img.shields.io/docker/automated/mobilityhouse/scala-protobuf3.svg)](https://hub.docker.com/r/mobilityhouse/scala-protobuf3/) 

This image provides all of the necessary tooling to compile Scala code from
proto schemas.

## Usage

Start an instance of the workbench container using the `docker-compose` in this
repository through `docker-compose` (when working from this repository's base
directory) which will spawn a container with this repository's work directory
(the `./bench` directory) set to the work directory of the container (see
container's `/workdir`).

`docker-compose run workbench`

> **NOTE**: The docker-compose setup actually spawns a container in which
the work directory is changed to `/workdir`. The `bench` directory of this
repository is mounted within this `/workdir`, after which `sbt compile` (the
default entry point) is fired up to produce the assets. In case one wants to
start the container directly, please note that the original work directory is
`/tmp/sbt-work-dir`, if the working directory is not explicitly set to another
locations (e.g.: `/workdir`) within the docker command :wink:.

For other projects, directly pull and run the image through
`docker run --rm -it $IMAGE -v /path/to/local/workdir:/workdir -w /workdir`
where the path of the directory mounted to the containers `/workdir` corresponds
to the directory in which you have the `src/main/protobuf` directory that
contains the proto files to be converted. The `$IMAGE` value should contain the
name of the image of the scala-protobuf3 compiler with the possible images on
[docker hub](https://hub.docker.com/r/mobilityhouse/scala-protobuf3/builds/)
being:

 - `mobilityhouse/scala-protobuf3:experimental` for the latest bleeding-edge image
 - `mobilityhouse/scala-protobuf3:latest` for the stable image (`master`).


The scala protobuf3 compiler will, by default, produce the assets inside the
`target` directory within the `workdir`.

Run `make clean` or `rm -rf /path/to/local/workdir/{target,project/project,project/target}`
to purge the work directory of any artifacts that are within paths where
ScalaPB delivers its assets.

Note that `/workdir` is the base directory on the container when using
`docker-compose`. On the host, the base directory is `bench` which is
mounted into the container's `/workdir`. Generated scala files will, by default
be delivered in `${BASE_DIR}/target/scala-2.10/src_managed/main` while the proto
files are sourced from `${BASE_DIR}/src/main/protobuf`.

The directory `/tmp/sbt-work-dir` is the working directory when using
the `docker` command without specifying a working directory through the
command line argument (e.g.: `-w /new/working/directory`).
