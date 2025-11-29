provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.19.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.common_tags
}

# Security Group for SSH access
resource "aws_security_group" "app_server_sg" {
  name_prefix = "${var.instance_name}-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from anywhere (restrict to your IP in production)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # TODO: Replace with your IP/32
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.instance_name}-sg"
  })
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)

  lifecycle {
    create_before_destroy = true # Ensures new key before old is removed
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name

  vpc_security_group_ids = [aws_security_group.app_server_sg.id]
  subnet_id              = module.vpc.public_subnets[0]

  # Enable public IP for initial access (remove for production private subnet)
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = merge(var.common_tags, {
    Name = var.instance_name
  })

  # Prevent accidental destruction
  lifecycle {
    prevent_destroy = true
  }
}
