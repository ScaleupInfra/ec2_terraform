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

resource "aws_instance" "example" {
  ami           = "ami-0ec0e125bb6c6e8ec" 
  instance_type = "t2.micro"
  

  tags = {
    Name = "MySimpleEC2Instance"
  }
}

variable "region" {}
variable "access_key" {}
variable "secret_key" {}
