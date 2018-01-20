# create the image
docker image build -t smallone/jenkins .

# create the secrets
echo admin | docker secret create jenkins-user -
echo admin | docker secret create jenkins-pass -

# launch the service
docker stack ps jenkins
open "http://localhost:8080" and enter secrets

# stop the service
docker stack rm jenkins
docker secret rm jenkins-user
docker secret rm jenkins-pass
