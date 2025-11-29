variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "test-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "Private subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "Public subnets CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.nano"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "ubuntu-nano-server"
}

variable "key_pair_name" {
  description = "Name of EC2 Key Pair"
  type        = string
  default     = "ubuntu-nano-key"
}

variable "public_key_path" {
  description = "Path to public key file (.pub)"
  type        = string
  default     = "" # RECOMMENDED YOU USE A DIFFERENT KEY THAN YOUR DEFAULT, ~/.ssh/id_ed25519.pub
  # define this in terraform.tfvars
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "development"
    ManagedBy   = "Terraform"
    Project     = "Ubuntu-Nano-EC2"
  }
}
