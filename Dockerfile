FROM centos:centos7

MAINTAINER Warren Roque <wroquem@gmail.com>

#install required packages
RUN yum -y update && \
 yum -y install wget && \
 yum -y install tar && \
 yum -y install zip && \
 yum -y install unzip
 
RUN yum -y install java-11-openjdk-devel

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk
ENV JRE_HOME /usr/lib/jvm/java-11-openjdk/jre
ENV PATH $PATH:${JAVA_HOME}:${JRE_HOME}/bin

ENV CATALINA_HOME /opt/tomcat

RUN echo "Installing Tomcat ${TOMCAT_VERSION}..." && \
wget -nv https://downloads.apache.org/tomcat/tomcat-9/v9.0.45/bin/apache-tomcat-9.0.45.tar.gz -O /tmp/tomcat.tgz && \
tar xzf /tmp/tomcat.tgz -C /opt && \
mv /opt/apache-tomcat-9.0.45 ${CATALINA_HOME} && \
rm /tmp/tomcat.tgz


ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080

# Launch Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
