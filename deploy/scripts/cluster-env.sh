#! /bin/bash

# cluster-env.sh

# set cluster specific items
export CLUSTERNAME=medss-cluster
export STACKNAME=$CLUSTERNAME-ecs-ec2-stack
export INSTANCE_TYPE=t2.medium
export INSTANCE_COUNT=1
export AC2_CODE=3GASG
CERT_ARN_NONPROD=arn:aws:acm:us-east-2:938619397650:certificate/3dacddd1-a0b0-40c7-81f9-a491b397e94c
CERT_ARN_PROD=arn:aws:acm:us-east-2:100582527228:certificate/5f08f0e9-c8e9-431b-afe4-00a2527829a5

# set template specific items
export TEMPLATEFILE=../cloudformation/create-ecs-ec2-cluster.yml

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
	export PROXY=http://outboundproxy.nonprod.health.state.mn.us:3128/
elif [ "$ACCOUNT" = "100582527228" ]; then
	echo "Setting Production Environment Variables"
	export ENVIRONMENT=prod
	export HOSTED_ZONE=web.health.state.mn.us
	export VPC_ID=vpc-0f12eb66
	export PRIVATE_SUBNETS=subnet-96c50dff,subnet-e8475d90
	export PUBLIC_SUBNETS=subnet-68c60e01,subnet-e9475d91
	export CERT_ARN=$CERT_ARN_PROD
	export PROXY=http://outboundproxy.web.health.state.mn.us:3128/
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
echo "S3 Bucket                   " ${S3DEPLOYMENTBUCKET}
echo "Cluster Name                " ${CLUSTERNAME}
echo "Stack Name                  " ${STACKNAME}
echo "API Subdomain               " ${API_SUBDOMIAN}
echo "Hosted Zone                 " ${HOSTED_ZONE}
echo "Cert ARN                    " ${CERT_ARN}
echo "Original Template File      " ${TEMPLATEFILE}
echo "AC2 CODE                    " ${AC2_CODE}

