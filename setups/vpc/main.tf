# Calls the VPC module
module "webserver_vpc" {
	source 	= "app.terraform.io/Batel-OpsSchool1/webserver/aws//modules/vpc"
  	version = "1.0.0"
}