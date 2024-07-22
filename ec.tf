terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "environment" {
  description = "Environment type (dev or prod)"
  type        = string
  default     = "dev"
}

variable "ec2_instance_count_dev" {
  description = "Number of EC2 instances to create in dev environment"
  type        = number
  default     = 2
}

variable "ec2_instance_count_prod" {
  description = "Number of EC2 instances to create in prod environment"
  type        = number
  default     = 4
}

locals {
  instance_count = var.environment == "dev" ? var.ec2_instance_count_dev : var.ec2_instance_count_prod
  instance_names = [for idx in range(local.instance_count) : "${var.environment}-instance-${idx + 1}"]
}
resource "aws_instance" "Infrasity" {
  for_each = { for idx, name in local.instance_names : idx => name }

  ami           = "ami-0ec0e125bb6c6e8ec"  
  instance_type = "t2.micro"

  tags = {
    Name        = each.value
    Environment = var.environment
  }
}
