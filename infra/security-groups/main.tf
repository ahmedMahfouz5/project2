variable "ec2_sg_name_ssh" {}
variable "vpc_id" {}
variable "ec2_sg_name_http" {}
variable "public_subnet_cidr_block" {}


output "sg_ec2_sg_ssh_http_id" {
  value = aws_security_group.ec2_sg_ssh_http.id
}

output "sg_ec2_port_8080_id" {
  value = aws_security_group.ec2_port_8080.id
}

output "rds_mysql_sg_id" {
  value = aws_security_group.rds_mysql_sg.id
}

resource "aws_security_group" "ec2_sg_ssh_http" {
  name        = var.ec2_sg_name_ssh
  description = "Enable the Port 22(SSH) & Port 80(http)"
  vpc_id      = var.vpc_id

  # ssh for terraform remote exec
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
  }

  #Outgoing request
  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}

resource "aws_security_group" "ec2_port_8080" {
  name        = var.ec2_sg_name_http
  description = "Enable the Port 8080 for jenkins"
  vpc_id      = var.vpc_id

  # ssh for terraform remote exec
  ingress {
    description = "Allow 8080 port to access jenkins"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}

resource "aws_security_group" "lb_allow_port_80" {
  name        = var.ec2_sg_name_http
  description = "Enable the Port 8080 for jenkins"
  vpc_id      = var.vpc_id

  # ssh for terraform remote exec
  ingress {
    description = "Allow 8080 port to access jenkins"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  tags = {
    Name = "Security Groups to allow SSH(22) and HTTP(80)"
  }
}

# Security Group for RDS
resource "aws_security_group" "rds_mysql_sg" {
  name        = "rds-sg"
  description = "Allow access to RDS from EC2 present in public subnet"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = tolist(var.public_subnet_cidr_block) # replace with your EC2 instance security group CIDR block
  }
}