#! /bin/bash

source secret-env.sh

aws cloudformation deploy --template-file ${TEMPLATEFILE} \
    --stack-name ${STACKNAME} \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        KmsKeyId=${KMS_KEY_ID}
