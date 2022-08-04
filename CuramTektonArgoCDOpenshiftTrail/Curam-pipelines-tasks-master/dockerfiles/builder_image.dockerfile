FROM registry.access.redhat.com/ubi8/ubi:8.4

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN dnf install -y tzdata openssl curl ca-certificates fontconfig glibc-langpack-en gzip tar java-1.8.0-openjdk-devel unzip \
    && dnf update -y; dnf clean all

LABEL name="Curas SPM Build Environment" \
      vendor="IBM" \
      version="8" \
      release="1" \
      run="docker run --rm -ti <image_name:tag> /bin/bash" \
      summary="Customized UBI image to build Curam SPM V8" \
      description="For more information on this image please see..."

COPY apache-ant-1.10.6-bin.zip openliberty-javaee8-21.0.0.9.zip /tmp/

COPY h2-1.3.176.jar /opt/h2/

RUN set -ex; \
    mkdir /opt/ibm; \
    cd /opt/ibm; \
    unzip /tmp/openliberty-javaee8-21.0.0.9.zip; \
    cd /opt; \
    unzip /tmp/apache-ant-1.10.6-bin.zip; \
    /opt/ibm/wlp/bin/featureUtility installFeature javaee-7.0

ENV JAVA_HOME="/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.312.b07-2.el8_5.x86_64" \
    WLP_HOME="/opt/ibm/wlp" \
    ANT_HOME="/opt/apache-ant-1.10.6" \
    PATH="/opt/apache-ant-1.10.6/bin:/opt/ibm/wlp/bin:/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.312.b07-2.el8_5.x86_64/bin:${PATH}"

COPY 9.2.3.0-IBM-MQ-Java-InstallRA.jar activation.jar apache-ant-1.10.6-bin.zip javax.mail.jar  /curam/content/

COPY Bootstrap.properties curam-config.xml deployment_packaging.xml /curam/properties/

COPY curam-spm-v8-binaries.tar.gz /curam