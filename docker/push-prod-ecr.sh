#!/usr/bin/env bash

set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
ACCOUNT="$(aws sts get-caller-identity --query 'Account' --output text)"
REGION=$(aws configure get region)

response="$(aws ecr get-login-password --region "${REGION}" | docker login --username AWS --password-stdin "${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com" )"

TAG="medss-odata-jpa-service"
VERSION="1.4.0"
CLUSTER="medss-cluster"
ECS_SERVICE_ARN="arn:aws:ecs:${REGION}:${ACCOUNT}:service/${CLUSTER}/${TAG}"

mvn -f "${SCRIPT_DIR}/../pom.xml" clean package -DskipTests
cp ${SCRIPT_DIR}/../target/medss-odata-*.jar "${SCRIPT_DIR}/service.jar"

docker build --build-arg profile="prod" -t "${TAG}:${VERSION}" .
docker tag "${TAG}:${VERSION}" "${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/prod/${TAG}:${VERSION}"
docker push "${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com/prod/${TAG}:${VERSION}"

rm "${SCRIPT_DIR}/service.jar"

