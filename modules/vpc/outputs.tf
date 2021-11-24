# Output the vpc id for further use on other modules
output "vpc_id" {
    value       = aws_vpc.whiskey-vpc.id
    description = "the id of the vpc"
}

# Output the vpc cidr for further use on other modules
output "vpc_cidr" {
    value       = aws_vpc.whiskey-vpc.cidr_block
    description = "the cidr block of the VPC"
}

# Output the public subnets ids for further use on other modules
output "public_subnets" {
    value       = "${aws_subnet.public.*.id}"
    description = "the ids of the public subnets"
}

# Output the private subnets ids for further use on other modules
output "private_subnets" {
    value       = "${aws_subnet.private.*.id}"
    description = "the ids of the privete subnets"
}