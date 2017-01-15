# Scalapb Compiler

 - `docker-compose run workbench`
 - produce .proto files in `/src/main/protobuf`
 - compile provided .proto files with `sbt compile`
 - observe .scala output in `bench/target/scala-2.10/src_managed`
 - copy compiled Scala files to project (.e.g `cp bench/target/scala-2.10/src_managed/main/io/tmh/zeta/msg/DemoRequest/*.scala ../bachmann-smi/src/main/scala/io/tmh/zeta/msg/DemoRequest/.`)
