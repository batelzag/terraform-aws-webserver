# Launch WEB instances
resource "aws_instance" "web" {
  count                       = var.web_instance_count
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(var.public_subnets,count.index)
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.web-instances-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2-s3-write-profile.name
  user_data                   = local.web-instance-userdata
  
  root_block_device {
    encrypted   = false
    volume_type = var.volumes_type
    volume_size = var.web_instance_root_disk_size
  }

  ebs_block_device {
    encrypted   = true
    device_name = var.web_instance_encrypted_disk_device_name
    volume_type = var.volumes_type
    volume_size = var.web_instance_encrypted_disk_size
  }

  tags = {
    Name = "Whiskey-WS${count.index + 1}"
  }
}

# Create a security group assigned to ELB and WEB instances
resource "aws_security_group" "web-instances-sg" {
  name    = "web-instances-sg"
  vpc_id  = var.vpc_id
  tags = {
    Name = "web-instances-sg"
  }
}

# Create secrutiy groups rules to allow ingress traffic with ssh and http, and egress from all destinations
resource "aws_security_group_rule" "web-ssh-ing" {
  type              = "ingress"
  description       = "allow ssh access from anywhere"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-instances-sg.id
}

resource "aws_security_group_rule" "web-http-ing" {
  type              = "ingress"
  description       = "allow http access from anywhere"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-instances-sg.id
}

resource "aws_security_group_rule" "web-egr-all" {
  type              = "egress"
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-instances-sg.id
}