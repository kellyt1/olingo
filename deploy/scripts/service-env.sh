#! /bin/bash

# service-env.sh

# set application specific items
export CLUSTERNAME=medss-cluster
export CONTAINERNAME=medss-odata-jpa-service
export CONTAINERPORT=8080
export SUBDOMAIN=medss-crm-api
export AC2_CODE=3GASG
export INSTANCE_COUNT=1
export MIN_HEALTHY_PERCENT=0
export ECR_IMAGE=938619397650.dkr.ecr.us-east-2.amazonaws.com/nonprod/$CONTAINERNAME:latest
export STACKNAME=$CONTAINERNAME-ecs-service-stack
CERT_ARN_NONPROD=arn:aws:acm:us-east-1:938619397650:certificate/4fe467c4-09e0-4115-b91c-819505c63b26
CERT_ARN_PROD=arn:aws:acm:us-east-2:100582527228:certificate/5f08f0e9-c8e9-431b-afe4-00a2527829a5

export LISTENER=$(aws cloudformation describe-stack-resources --stack-name $CLUSTERNAME-ecs-ec2-stack  --logical-resource-id LoadBalancerListener --output text --query "StackResources[0].PhysicalResourceId")
export HOST_SG=$(aws cloudformation describe-stack-resources --stack-name $CLUSTERNAME-ecs-ec2-stack  --logical-resource-id ECSHostSecurityGroup --output text --query "StackResources[0].PhysicalResourceId")
export CLUSTER_LB=$(aws cloudformation describe-stack-resources --stack-name $CLUSTERNAME-ecs-ec2-stack  --logical-resource-id LoadBalancer --output text --query "StackResources[0].PhysicalResourceId")
export LB_DNS=$(aws elbv2 describe-load-balancers --load-balancer-arns $CLUSTER_LB --output text --query "LoadBalancers[0].DNSName")
export LB_ZONEID=$(aws elbv2 describe-load-balancers --load-balancer-arns $CLUSTER_LB --output text --query "LoadBalancers[0].CanonicalHostedZoneId")

# set template specific items
export TEMPLATEFILE=../cloudformation/deploy-service.yml

# get account id and region
export ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account')
export ROLE=$(aws sts get-caller-identity --output text --query 'Arn' | sed -e 's/^.*[/]\(.*\)[/].*$/\1/g')
export REGION=$(aws configure get region)

# set environmented based on account id
if [ "$ACCOUNT" = "938619397650" ]; then
	echo "Setting Non-Production Environment Variables"
	export ENVIRONMENT=nonprod
	export HOSTED_ZONE=nonprod.health.state.mn.us
	export VPC_ID=vpc-13a55d7a
	export PRIVATE_SUBNETS=subnet-ef864d86,subnet-c9ffe5b1
	export PUBLIC_SUBNETS=subnet-ee864d87,subnet-d7ffe5af
	export CERT_ARN=$CERT_ARN_NONPROD
	export DB_SG=sg-071af82ef23cd6481
elif [ "$ACCOUNT" = "100582527228" ]; then
	echo "Setting Production Environment Variables"
	export ENVIRONMENT=prod
	export HOSTED_ZONE=web.health.state.mn.us
	export VPC_ID=vpc-0f12eb66
	export PRIVATE_SUBNETS=subnet-96c50dff,subnet-e8475d90
	export PUBLIC_SUBNETS=subnet-68c60e01,subnet-e9475d91
	export CERT_ARN=$CERT_ARN_PROD
	export DB_SG=sg-0ff62b9d164923fd9
else
	export ENVIRONMENT=unknown
	echo "The environment is not known."
	echo "Do you need to login? (awsauth.py)"
	exit 1;
fi

# set environment specific items
export S3DEPLOYMENTBUCKET=mdh-deploy-serverless-${ENVIRONMENT}

# check for cert settings
if [ "$CERT_ARN" = "unknown" ]; then
	echo "Please set the certificate ARN for this environment (${ENVIRONMENT})."
	exit 2;
fi
# check role
if [ "$ROLE" != "ADFS-AgencyRoleAdministratorsRole" ]; then
	echo "Please authenticate with role ADFS-AgencyRoleAdministratorsRole (current role ${ROLE})."
	exit 3;
fi

echo "Environment                 " ${ENVIRONMENT}
echo "Account                     " ${ACCOUNT}
echo "Region                      " ${REGION}
echo "VPC ID                      " ${VPC_ID}
echo "Public Subnet(s)            " ${PUBLIC_SUBNETS}
echo "Private Subnet(s)           " ${PRIVATE_SUBNETS}
echo "Instance Type               " ${INSTANCE_TYPE}
echo "Instance Count              " ${INSTANCE_COUNT}
echo "Min Healthly %              " ${MIN_HEALTHY_PERCENT}
echo "S3 Bucket                   " ${S3DEPLOYMENTBUCKET}
echo "Cluster Name                " ${CLUSTERNAME}
echo "ECR Image                   " ${ECR_IMAGE}
echo "Container Name              " ${CONTAINERNAME}
echo "Container Port              " ${CONTAINERPORT}
echo "Stack Name                  " ${STACKNAME}
echo "Subdomain                   " ${SUBDOMIAN}
echo "Hosted Zone                 " ${HOSTED_ZONE}
echo "Cert ARN                    " ${CERT_ARN}
echo "Original Template File      " ${TEMPLATEFILE}
echo "Listener                    " ${LISTENER}
echo "AC2 CODE                    " ${AC2_CODE}
echo "ECS HOST SG                 " ${HOST_SG}
echo "DB Security Group           " ${DB_SG}
echo "LoadBalancer DNS            " ${LB_DNS}
echo "LoadBalancer Hosted Zone    " ${LB_ZONEID}