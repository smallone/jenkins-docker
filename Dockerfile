FROM jenkins/jenkins:lts-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

USER root

COPY Jenkins/Setup/security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
COPY Jenkins/Setup/plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN	echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
	apk --no-cache update && apk --no-cache add openrc && \
	apk --no-cache add docker && rc-update add docker boot && \
	apk --no-cache add py-pip && pip install docker-compose && \
	apk --no-cache add dos2unix && \
	dos2unix /usr/share/jenkins/ref/plugins.txt && /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt && \
	rm /usr/share/jenkins/ref/plugins.txt && \
	apk del dos2unix

USER jenkins