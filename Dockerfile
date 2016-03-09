FROM meteogroup/centos:7

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 74
ENV JAVA_VERSION_BUILD 02
ENV JAVA_PACKAGE       jre
ENV JAVA_SHA256_SUM    9c8663a5a67429d423ed1da554a7f93d1c7e50f6bb4bc5e0bbde1f512cf36d95

RUN  mkdir -p /opt &&\
       curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o java.tar.gz\
       http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz &&\
       echo "$JAVA_SHA256_SUM  java.tar.gz" | sha256sum -c - &&\
       gunzip -c java.tar.gz | tar -xf - -C /opt && rm -f java.tar.gz &&\
       ln -s /opt/jre1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jre &&\
       yum -y install unzip && \
       curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o jce.zip http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip && \
       unzip -j -o jce.zip -d /opt/jre/lib/security/ && \
       rm -rf jce.zip \
       /opt/jre/lib/plugin.jar \
       /opt/jre/lib/ext/jfxrt.jar \
       /opt/jre/bin/javaws \
       /opt/jre/lib/javaws.jar \
       /opt/jre/lib/desktop \
       /opt/jre/plugin \
       /opt/jre/lib/deploy* \
       /opt/jre/lib/*javafx* \
       /opt/jre/lib/*jfx* \
       /opt/jre/lib/amd64/libdecora_sse.so \
       /opt/jre/lib/amd64/libprism_*.so \
       /opt/jre/lib/amd64/libfxplugins.so \
       /opt/jre/lib/amd64/libglass.so \
       /opt/jre/lib/amd64/libgstreamer-lite.so \
       /opt/jre/lib/amd64/libjavafx*.so \
       /opt/jre/lib/amd64/libjfx*.so

ENV JAVA_HOME /opt/jre
ENV PATH ${PATH}:${JAVA_HOME}/bin
