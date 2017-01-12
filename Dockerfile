FROM openjdk:8u102-jdk
MAINTAINER David Asabina <vid@bina.me>
RUN wget -O /home/sbt-0.13.13.zip \
      https://dl.bintray.com/sbt/native-packages/sbt/0.13.13/sbt-0.13.13.zip \
      && unzip /home/sbt-0.13.13.zip -d /home/sbt
