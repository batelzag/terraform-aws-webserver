# Outputs for use in other modules
output "vpc_id" {
    value = module.webserver_VPC.vpc_id
}
output "vpc_cidr" {
    value = module.webserver_VPC.vpc_cidr
}
output "public_subnets" {
    value = "${module.webserver_VPC.public_subnets}"
}
output "private_subnets" {
    value = "${module.webserver_VPC.private_subnets}"
}