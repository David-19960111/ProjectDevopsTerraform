terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.10.0"
            }
    }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_eip" "windowsserver-eip" {
    tags = {
        Name="windowsserver"
        OWNER="david11011996@gmail.com"
    }
}
resource "aws_eip_association" "serverwindows-eip" {
    instance_id = aws_instance.serverwindows.id
    allocation_id = aws_eip.windowsserver-eip.id
}
resource "aws_security_group" "serverwindows-sg" {
    name = "serverwindows-rdp-sg"
    description = "Acceso remoto"
    vpc_id = "vpc-085cbbd5a65dbe4d2"
    ingress {
        from_port = 3389
        to_port = 3389
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    }
}
resource "aws_instance" "serverwindows" {
    ami = "ami-0fc682b2a42e57ca2"
    instance_type = var.windows_instance_type
    key_name = "windowsserver1"
    associate_public_ip_address = false
    vpc_security_group_ids = [aws_security_group.serverwindows-sg.id]
    subnet_id = "subnet-091d67d3f758993fe"

    root_block_device {
		volume_size           = var.windows_root_volume_size
		volume_type           = var.windows_root_volume_type
		delete_on_termination = true
		encrypted             = true
	}

    tags = {
        Name="serverwindows"
        OWNER="david11011996@gmail.com"
    }
}

