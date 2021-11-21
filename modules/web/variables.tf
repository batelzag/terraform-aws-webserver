# Ec2 Instance type
variable "instance_type" {
    description = "The type of EC2"
    default = "t2.micro"
    type = string
}
# The number of web instances to create
variable "web_instance_count" {
    description = "The number of web server instances to create"
    default = 2
}
# The key name for EC2 instance
variable "key_name" {
    description = "The key name of the Key Pair to use for the instance"
    default     = "OpsSchool"
    type        = string
}
# The volume type for disks in the project
variable "volumes_type" {
    description = "The type of all the disk instances in my project"
    default = "gp2"
}
# The size of root disk
variable "web_instance_root_disk_size" {
  description = "The size of the root disk"
  default = "10"
}
# The size of secondary encrypted disk
variable "web_instance_encrypted_disk_size" {
  description = "The size of the secondary encrypted disk"
  default = "10"
}
# The device name of secondary encrypted disk
variable "web_instance_encrypted_disk_device_name" {
  description = "The device name of secondary encrypted disk"
  default = "xvdh"
}
# The vpc id in which to deploy web instances
variable  "vpc_id" {
  type = string
}
# The public subnets for instances to be assigned
variable "public_subnets" {
  type    = list(string)
}
# The S3 bucket name for upload nginx access logs
variable "bucket_name" {
  type = string
  default = "whiskey-access-logs"
}