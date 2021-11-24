# EC2 Instance type
variable "instance_type" {
    description = "The type of EC2"
    type        = string
    default     = "t2.micro"
}

# The number of DB instances to create
variable "db_instance_count" {
    default = 2
}

# The key name for EC2 instance
variable "key_name" {
    default     = "OpsSchool"
    description = "The key name of the Key Pair to use for the instance"
    type        = string
}

# The volume type of disks in the project
variable "volumes_type" {
    description = "The type of all the disk instances in my project"
    default     = "gp2"
}

# The vpc id in which to deploy DB instances
variable  "vpc_id" {
  type = string
}

# The vpc cidr
variable "vpc_cidr" {
    type = string
}

# The private subnets for instances to be assigned
variable "private_subnets" {
    type = list
}