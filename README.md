# aws-provisioning #

This repository contains Terraform code for provisioning AWS instances to deploy Real time data into RDS. Provisioning instances for [this](https://github.com/aadithya-naresh/Real-time-streaming-project) project.

![Github](https://img.shields.io/badge/logo-javascript-blue?logo=javascript) <br>

[![GitHub issues](https://img.shields.io/github/issues/aadithya-naresh/aws-provisioning)](https://github.com/aadithya-naresh/aws-provisioning/issues)

<a href="https://github.com/aadithya-naresh/aws-provisioning/network"><img alt="GitHub forks" src="https://img.shields.io/github/forks/aadithya-naresh/aws-provisioning"></a>
<a href="https://github.com/aadithya-naresh/aws-provisioning/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/aadithya-naresh/aws-provisioning"></a>

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
