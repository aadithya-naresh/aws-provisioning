#!/bin/bash
cd terraform
sudo ntpdate time.windows.com
aws configure


if [ $? -ne 0 ]; then
  echo "AWS configuration failed. Exiting."
  exit 1
fi

if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform first."
    exit 1
fi

echo "Terraform init executing"
init_output=$(terraform init 2>&1)

if [ $? -ne 0 ]; then
    echo "Terraform init failed. Exiting."
    echo "$init_output"
    exit 1
fi
echo "Terraform init successful"

echo "Terraform plan executing"
plan_output=$(terraform plan 2>&1)

if [ $? -ne 0 ]; then
    echo "Terraform plan failed. Exiting."
    echo "$plan_output"
    exit 1
fi   
echo "Terraform plan successful"

echo "Terraform apply executing"
apply_output=$(echo "yes" | terraform apply 2>&1)

if [ $? -ne 0 ]; then
    echo "Terraform apply failed. Exiting."
    echo "$apply_output"
    exit 1
fi
echo "Terraform apply successful"

mv .ssh/ansible-ssh-key.pem ~
chmod 600 ~/ansible-ssh-key.pem

cd ../ansible
ansible-playbook -i inventory.ini playbook.yaml
#Checking if WSL
# if grep -q Microsoft /proc/version; then
#     mv ssh-key.pem ~/ssh-key.pem
#     chmod 600 "~/ssh-key.pem"
#     mv ~/ssh-key.pem ssh-key.pem
# else
#     chmod 600 "ssh-key.pem"
# fi



# for ip in $instances_ip; do
#     echo "SSHing into instance at IP: $ip"
#     ssh -i ssh_key.pem ec2-user@${ip}
# done

# echo "Terraform destroy executing"
# plan_output=$(terraform destroy 2>&1)

# if [ $? -ne 0 ]; then
#     echo "Terraform destroy failed. Exiting."
#     echo "$plan_output"
#     exit 1
# fi
# echo "Terraform destroy successful"

