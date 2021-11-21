# Defines the vpc cidr
variable "vpc_cidr" {
    default = "10.0.0.0/16"
}
# Defines the private subnets cidrs
variable "private_cidr" {
    type    = list(string)
    default = ["10.0.10.0/24", "10.0.11.0/24"] 
}
# Defines the public subnets cidrs
variable "public_cidr" {
    type    = list(string)
    default = ["10.0.100.0/24", "10.0.101.0/24"]
}