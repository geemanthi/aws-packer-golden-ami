packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "base-ami" {
  region = var.aws_region
  source_ami_filter {
    filters = {
      name                = "al2023-ami-2023.*-x86_64"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  instance_type = "t3.micro"

  subnet_id                                 = var.build_subnet_id
  temporary_security_group_source_public_ip = true
  associate_public_ip_address               = true

  ssh_username  = "ec2-user"
  ssh_interface = "public_ip"
  ssh_timeout   = "5m"

  ami_name        = "base-aml3-x64-{{timestamp}}"
  ami_description = "Amazon Linux 2023 x86_64 base image with standard utilities"

  imds_support = "v2.0"

  run_tags = {
    Name    = "base-aml3-x64"
    Project = "golden-ami"
    BuiltBy = "packer"
  }
}