# Output the private ip of dbservers for further use on other modules
output "db_privateip" {
    value = "${aws_instance.db.*.private_ip}"
    description = "the private ip of db servers"
}