# Scala Protobuf 3 Workbench

This image provides all of the necessary tooling to compile Scala code from
proto schemas.

## Usage

Start an instance of the workbench container using the `docker-compose` in this
repository through `docker-compose` (when working from this repository's base
directory)

`docker-compose run workbench`

which will spawn a container with this repository's work directory (the
`./bench` directory) set to the work directory of the container (see container's
`/workdir`).

For other projects, directly pull and run the image through
`docker run --rm -it $IMAGE -v /path/to/local/workdir:/workdir`
where the path of the directory mounted to the containers `/workdir` corresponds
to the directory in which you have the `src` directory that contains the proto
files to be converted. The `$IMAGE` value should contain the name of the
image of the scala-protobuf3 compiler with the possible images on
[docker hub](https://hub.docker.com/r/mobilityhouse/scala-protobuf3/builds/)
being

 - `mobilityhouse/scala-protobuf3:experimental` for the latest bleeding-edge image
 - `mobilityhouse/scala-protobuf3:latest` for the stable image (`master`).


The scala protobuf3 compiler will, by default, produce the assets inside the
`target` directory within the `workdir`.

Run `make clean` or `rm -rf /path/to/local/workdir/{target,project/project,project/target}`
to purge the work directory of any artifacts that are within paths where
ScalaPB delivers its assets.

Considering `/workdir` is the base directory on the container and `bench` the
base directory on the host, the generated scala files will, by default be
delivered in `${BASE_DIR}/target/scala-2.10/src_managed/main` while the proto
files are sourced from `${BASE_DIR}/src/main/protobuf`.
