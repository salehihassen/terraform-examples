output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.app_server.private_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnet_id" {
  description = "ID of the private subnet where instance is launched"
  value       = module.vpc.private_subnets[0]
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.app_server_sg.id
}

output "key_pair_name" {
  description = "Name of the EC2 key pair"
  value       = aws_key_pair.deployer.key_name
}

output "ami_id" {
  description = "ID of the Ubuntu AMI used"
  value       = data.aws_ami.ubuntu.id
}

output "ami_name" {
  description = "Name of the Ubuntu AMI used"
  value       = data.aws_ami.ubuntu.name
}
