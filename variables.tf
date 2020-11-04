variable "readme" {
  type        = "string"
  default     = "terraform-docs"
  description = "**NOT PART OF CODE** Readme information. This readme was generated with terraform-docs. terraform-docs --with-aggregate-type-defaults --no-required --no-sort markdown ."
}

variable "key_name" {
  type        = "string"
  default     = "csgo"
  description = "**PRE-REQUIRED!** SSH key name, used for linux instances. Must to be exist on AWS account before apply terraform code."
}

variable "shared_credentials_file" {
  type        = "string"
  default     = "./secrets/credentials"
  description = "**PRE-REQUIRED!** Path of your AWS credentials file. Do NOT store it under version control system!"
}

variable "private_key" {
  type        = "string"
  default     = "./secrets/csgo.key"
  description = "**PRE-REQUIRED!** Path of your private SSH key. Required to connect target instance via SSH."
}

data "aws_ami" "Amazon_Linux" {
  #Get the latest amazon-linux2 official image as AMI.
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

variable "region" {
  type        = "string"
  default     = "us-east-1"
  description = "AWS region. Where to deploy with this Infrastructure-As-A-Code - terraform."
}

variable "profile" {
  type        = "string"
  default     = "default"
  description = "AWS Credential(s) profile. Define the name of the profile as defined in your aws credentials file."
}

variable "instance_type" {
  type        = "string"
  default     = "t2.micro"
  description = "AWS instance type. Define size of machine. https://aws.amazon.com/ec2/instance-types/"
}

variable "ami_user" {
  type        = "string"
  default     = "ec2-user"
  description = "SSH user, used for login to linux instance. Depends on used AMI."
}