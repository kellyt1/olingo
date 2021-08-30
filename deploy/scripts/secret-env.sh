#! /bin/bash

# set application specific items
export APPNAME=salesforce-api-secret
export STACKNAME=${APPNAME}-secrets-stack

# set template specific items
export TEMPLATEFILE=../cloudformation/create-client-secret.yml
export PACKAGETEMPLATEFILE=../cloudformation/package.yml

# get account id and region
export ACCOUNT=$(aws sts get-caller-identity --output text --query 'Account')
export ROLE=$(aws sts get-caller-identity --output text --query 'Arn' | sed -e 's/^.*[/]\(.*\)[/].*$/\1/g')
export REGION=$(aws configure get region)

# set environmented based on account id
if [ "$ACCOUNT" = "938619397650" ]; then
	echo "Setting Non-Production Environment Variables"
	export ENVIRONMENT=nonprod
  export KMS_KEY_ID=d0e0dd76-2cb6-4f3f-8786-c02dc30391cd
elif [ "$ACCOUNT" = "100582527228" ]; then
	echo "Setting Production Environment Variables"
	export ENVIRONMENT=prod
	export KMS_KEY_ID=d5363244-de58-4496-985d-32c6cb2139ba
else
	export ENVIRONMENT=unknown
	echo "The environment is not known."
	echo "Do you need to login? (awsauth.py)"
	exit 1;
fi

# set environment specific items
export S3DEPLOYMENTBUCKET=mdh-deploy-serverless-${ENVIRONMENT}

# check role
if [ "$ROLE" != "ADFS-AgencyRoleAdministratorsRole" ]; then
	echo "Please authenticate with role ADFS-AgencyRoleAdministratorsRole (current role ${ROLE})."
	exit 3;
fi

echo "Environment                 " ${ENVIRONMENT}
echo "Account                     " ${ACCOUNT}
echo "Region                      " ${REGION}
echo "App Name                    " ${APPNAME}
echo "Stack Name                  " ${STACKNAME}
echo "Original Template File      " ${TEMPLATEFILE}
echo "Generated Template File     " ${PACKAGETEMPLATEFILE}
echo "KMS Key Id                  " ${KMS_KEY_ID}