FROM jenkins/jenkins:lts-alpine
ENV JENKINS_USER admin
ENV JENKINS_PASS billy
USER root
#INSTALL Docker engine, to build docker pipelines
RUN apk update
RUN apk add openrc
RUN apk add docker
RUN addgroup jenkins docker
RUN rc-update add docker boot

USER jenkins
# Skip initial setup
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# copy default-user.groovy under the init.groovy.d directory 
# where to setup the default admin user and password
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt