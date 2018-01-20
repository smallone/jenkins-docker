
# jenkins-docker
This is how you can set up a [Jenkins](https://jenkins.io/) CI server in a [Docker](https://www.docker.com/) container with the possibility to build Docker container in it using a pipeline. The repository is based on a great post from Viktor Farcic on https://technologyconversations.com/2017/06/16/automating-jenkins-docker-setup

The used Dockerfile refers to the alpine build of Jenkins to minimize space and security vulnerabilities. It is also enabled to build a container on a windows host (you may will see some issues when you try to install the Jenkins plugins using the plugins.txt on a windows host)

## preparation
- edit the **plugins.txt** to your plugins of choice
- add your user to the **jenkins.yml**

### crawling the plugins
The easiest way to get a list of the plugins you want add during the image build process is to crawl it from a running instance. So the only thing you need  to do is to start the image from this repository and configure the Jenkins plugins you want to use. After that you can query the plugins by using the PluginManager *(you need to be admin)*
```sh
http://localhost:8080/pluginManager/api/json?depth=1
```
The out can be parsed on https://jqplay.org/.
As filter set **.plugins[].shortName** and as result **Raw Output**. 

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
$ docker stack deploy -c jenkins.yml jenkins
$ docker stack ps jenkins
$ open "http://localhost:8080" and enter secrets
```
##  stop the service
```sh
$ docker stack rm jenkins
$ docker secret rm jenkins-user
$ docker secret rm jenkins-pass
```

