caffe-ami
=========

create an ubuntu based AMI image with caffe + cuda + cudnn

## requirements

* ansible

## instructions
1. manually create instance (ubuntu)
2. edit inventory file with instance IP
```sh
echo > <instance ip> ansible_user=ubuntu > inventory
```
2. login to instance and install python
```sh
apt install python
```
3. run ansible
```sh
ansible-playbook -i inventory ansible/playbook.yml
```

## TODO
use packer to complete automation

