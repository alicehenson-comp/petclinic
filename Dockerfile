###
# Base image specification build arguments
ARG BASE_REGISTRY="docker.io"
ARG BASE_IMAGE="ubuntu"
ARG BASE_TAG="18.04"

###
# Build image stage
FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

RUN apt-get update

#Install java 11
RUN apt-get install openjdk-11-jdk -y
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64
ENV JRE_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Install git
RUN apt-get install git -y

WORKDIR /petclinic

ADD target .

RUN ls -al

ENTRYPOINT java -jar *.jar



