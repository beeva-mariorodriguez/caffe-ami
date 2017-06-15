caffe-ami
=========

create an ubuntu based AMI image with caffe + cuda + cudnn

## requirements

* ansible
* AWS CLI, with credentials configured

## create AMI automagically
```sh
doit.sh
```

## manual steps

### packer
1. export AWS variables
```bash
export AWS_ROLE_ARN="your role arn"
export AWS_MFA_ARN="your aws mfa arn"
export AWS_PROFILE="your aws profile"
```
2. generate AWS session token
```bash
aws sts assume-role \
        --role-arn ${AWS_ROLE_ARN} \
        --role-session-name "Packer"  \
        --profile ${AWS_PROFILE} --serial-number ${AWS_MFA_ARN} --token-code "MFA code"
export AWS_ACCESS_KEY_ID="AccessKeyId"
export AWS_SESSION_TOKEN="SessionToken"
export AWS_SECRET_ACCESS_KEY="SecretAccessKey"
```
3. run packer
```sh
packer build caffe+cuda+cudnn.json
```

### standalone ansible
1. manually create instance (ubuntu)
2. login to instance and install python
```sh
apt install python
```
3. run ansible
```sh
ansible-playbook ansible/playbook.yml
```

