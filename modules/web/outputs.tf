# Output the private ip of WEB instances for further use on other modules
output "web_privateip" {
    value       = "${aws_instance.web.*.private_ip}"
    description = "the private ip of web servers"
}
