# Launch DB server instances #
resource "aws_instance" "db" {
  count                       = var.db_instance_count
  ami                         = data.aws_ami.ubuntu-18.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = element(var.private_subnets,count.index)
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.db-instances-sg.id]
  
  tags = {
    Name = "Whiskey-DB${count.index + 1}"
  }
}

# Create a security group assigned to DB instances, to allow ingress
# ssh traffic from VPC, and egress all destinations #
resource "aws_security_group" "db-instances-sg" {
  name   = "db-instances-sg"
  vpc_id = var.vpc_id
  tags = {
    Name = "db-instances-sg"
  }
}
resource "aws_security_group_rule" "db-ssh-ing" {
  type              = "ingress"
  description       = "allow ssh access from vpc"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr}"]
  security_group_id = aws_security_group.db-instances-sg.id
}
resource "aws_security_group_rule" "db-egr-all" {
  type              = "egress"
  description       = "allow outbound traffic to anywhere"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db-instances-sg.id
}