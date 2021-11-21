module "webserver_vpc" {
	source = "app.terraform.io/Batel-OpsSchool/webserver/aws//modules/vpc"
  	version = "1.0.0"
}
# module "test_WEB" {
#   	source  = "app.terraform.io/Batel-OpsSchool/webserver/aws//modules/web"
#   	version = "1.0.0"
#   	vpc_id = data.terraform_remote_state.webserver_vpc.vpc_id
# 	public_subnets = "${data.terraform_remote_state.webserver_vpc.public_subnets[*]}"
# }
# module "test_DB" {
#   	source  = "app.terraform.io/Batel-OpsSchool/webserver/aws//modules/db"
#   	version = "1.0.0"	
# 	vpc_id = data.terraform_remote_state.webserver_vpc.vpc_id
# 	vpc_cidr = data.terraform_remote_state.webserver_vpc.vpc_cidr
# 	private_subnets = "${data.terraform_remote_state.webserver_vpc.private_subnets[*]}"
# }