# jenkins_docker
Jenkins Docker image with plugins preinstalled, built from Linux Alpine

To build the image:
`sudo docker build -t my/jenkins <dockerfile-path>`  (change my/jenkins with your preferred image name)

Note that Docker daemon always runs as root, if you don't want to prefix docker with "sudo" you need to add group and user as explained [here](https://docs.docker.com/engine/install/linux-postinstall/).

To run a container: 
`docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home <image name>`

- Dockerfile: docker image build file
- jenkins.yaml: jenkins configuration-as-code
- plugins.txt: list of plugins to be installed
- default-user.groovy: script to preconfigure default admin user, as defined in Dockerfile