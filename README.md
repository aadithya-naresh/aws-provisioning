# aws-provisioning #

[![GitHub Build Status](https://github.com/cisagov/provision-aws-account/workflows/build/badge.svg)](https://github.com/cisagov/provision-aws-account/actions)

This repository contains Terraform code for provisioning AWS instances to deploy Real time data into RDS. Provisioning instances for [this](https://github.com/aadithya-naresh/Real-time-streaming-project) project.

## Pre-requisites ##

- An AWS account configured.
- [Terraform](https://www.terraform.io/) and [Ansible](https://www.ansible.com/) installed on your system.
- A Terraform **terraform/terraform.tfvars** file with the RDS password, for example:
  ```
  rds_password= "YOUR_PASSWORD"
  ```
  
## Usage ##

1. Run ```aws configure``` with these values.

   ```
   aws_access_key_id = <MY_ACCESS_KEY_ID>
   aws_secret_access_key = <MY_SECRET_ACCESS_KEY>
   aws_session_token = <MY_SESSION_TOKEN>
   ```

1. Create a `terraform.tfvars` file. (see Pre-requisites).
1. Run the command `terraform init`.
1. Plan the provisioning and check the changes:

   ```console
   terraform plan
   ```
1. Provision the instances if the changes are correct:

   ```console
   terraform apply
   ```

<!-- BEGIN_TF_DOCS -->
## Requirements ##

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |

## Modules ##

No modules.

## Inputs ##

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The AWS region to deploy into (e.g. us-east-1). | `string` | `"us-east-1"` | no |
| tags | Tags to apply to all AWS resources created. | `map(string)` | `{}` | no |

## Outputs ##

| Name | Description |
|------|-------------|
| instances_ip | The IP Address of the EC2 instance created. |
<!-- END_TF_DOCS -->
