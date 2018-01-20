# jenkins-docker
This is how you can set up a [Jenkins](https://jenkins.io/) CI server in a [Docker](https://www.docker.com/) container with the possibility to build Docker container in it using a pipeline. The repository is based on a great post from Viktor Farcic on https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup

The used Dockerfile refers to the alpine build of Jenkins to minimize space and security vulnerabilities. It is also designed to build the container on a windows host (you may will see some issues when you try to install the Jenkins plugins using the plugins.txt)

## preparation
- edit the **plugins.txt** to your plugins of choice
- add your user to the **jenkins.yml**

## create the image
```sh
$ docker image build -t <your_user>/jenkins .
```
## create the secrets
```sh 
$ echo <user> | docker secret create jenkins-user -
$ echo <password> | docker secret create jenkins-pass -
```

##  launch the service
```sh 
$ docker stack ps jenkins
$ open "http://localhost:8080" and enter secrets
```
##  stop the service
```sh
$ docker stack rm jenkins
$ docker secret rm jenkins-user
$ docker secret rm jenkins-pass
```

