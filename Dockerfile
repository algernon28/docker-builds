FROM jenkins/jenkins:lts-alpine
ENV JENKINS_USER admin
ENV JENKINS_PASS billy
USER root
#INSTALL Docker engine, to build docker pipelines
RUN apk update && apk add openrc && apk add docker && addgroup jenkins docker && rc-update add docker boot
USER jenkins
# Skip initial setup
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

#Copy the configuration
COPY jenkins.yaml /home/jenkins.yaml
#The configuration-as-code plugin will look for this variable in order to load the configuration
ENV CASC_JENKINS_CONFIG="/home/jenkins.yaml"

# copy default-user.groovy under the init.groovy.d directory 
# where to setup the default admin user and password
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

#Preinstall the plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
