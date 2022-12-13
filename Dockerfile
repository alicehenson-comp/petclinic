###
# Base image specification build arguments
ARG BASE_REGISTRY="docker.io"
ARG BASE_IMAGE="ubuntu"
ARG BASE_TAG="18.04"

###
# Build image stage
FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

RUN apt-get update
ENV upload-token="45d62c50-1aze-4d3d-a8ea-380b06d8076c"

#Install java 11
RUN apt-get install openjdk-8-jdk -y
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV JRE_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install Tomcat
WORKDIR /petclinic
ARG TOMCAT_VERSION="9.0.56"
ADD https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz .
RUN tar -xvf apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN rm apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mv apache-tomcat-${TOMCAT_VERSION} tomcat
#COPY catalina.properties tomcat/conf

#prepare SSC
COPY target/petclinic.war /petclinic/tomcat/webapps

# Start tomcat at booting
WORKDIR /petclinic/tomcat/bin
RUN chmod +x catalina.sh
CMD ./catalina.sh run





