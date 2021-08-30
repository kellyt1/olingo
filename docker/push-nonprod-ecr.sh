$(aws ecr get-login --no-include-email --region us-east-2)

export TAG=medss-odata-jpa-service
export CLUSTER=medss-cluster
export ECS_SERVICE_ARN=arn:aws:ecs:us-east-2:938619397650:service/${CLUSTER}/${TAG}

mvn -f ../pom.xml clean package -DskipTests
cp ../target/medss-odata-*.jar service.jar

docker build --build-arg profile=nonprod -t ${TAG}:latest .
docker tag ${TAG}:latest 938619397650.dkr.ecr.us-east-2.amazonaws.com/nonprod/${TAG}
docker push 938619397650.dkr.ecr.us-east-2.amazonaws.com/nonprod/${TAG}

rm service.jar

aws ecs update-service --cluster ${CLUSTER} --service ${ECS_SERVICE_ARN}  --force-new-deployment

aws ecs update-service --cluster medss-cluster --service arn:aws:ecs:us-east-2:938619397650:service/medss-cluster/medss-odata-jpa-service  --force-new-deployment
