#!/bin/bash

# aws credentials
if [ -z ${AWS_ROLE_ARN} ]
then
    echo "Role ARN:"
    read
    AWS_ROLE_ARN=$REPLY
fi

if [ -z ${AWS_PROFILE} ]
then
    echo "profile name:"
    read
    AWS_PROFILE=$REPLY
fi

if [ -z ${AWS_MFA_ARN} ]
then
    echo "MFA ARN:"
    read
    AWS_MFA_ARN=$REPLY
fi

echo "MFA code:"
read
code=$REPLY

tmpdir=$(mktemp -d)

aws sts assume-role \
        --role-arn ${AWS_ROLE_ARN} \
        --role-session-name "Packer" \
        --profile ${AWS_PROFILE} --serial-number ${AWS_MFA_ARN} --token-code ${code} > ${tmpdir}/out.json

if [ $? != 0 ]
then
    echo "errrorrrr"
    exit 1
fi

export AWS_ACCESS_KEY_ID=$(jq -r .Credentials.AccessKeyId < ${tmpdir}/out.json)
export AWS_SESSION_TOKEN=$(jq -r .Credentials.SessionToken < ${tmpdir}/out.json)
export AWS_SECRET_ACCESS_KEY=$(jq -r .Credentials.SecretAccessKey < ${tmpdir}/out.json)

# run packer!
packer build caffe+cuda+cudnn.json

